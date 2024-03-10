Return-Path: <linux-kernel+bounces-98240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8950887773A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9712EB20EAB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29A2D607;
	Sun, 10 Mar 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrXAmr/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17372C85A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710079428; cv=none; b=hQcHh5zQUBaVzW1mytLOEEhdfywKLl0BYk0u+tfokBgR44Iw87eLWZvlgGpg5ijIeLtCNNa6STdnzTN+e9tC40A1TwJNuoLL3MvnKQbUz/AotAw24S0lP0Xq6lxN9cNo8NXlYHserhd2KL5ikXFwp9jchyblAgJgdizUhcs1BO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710079428; c=relaxed/simple;
	bh=bwiNExhP3G8/4ZF9l7HFtlTqhac5Y1om1nv7SCEhE0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL51xYnC6m/ZdvSuhDqDRZrK44kAA3ffQDDETVFzK1MjRLdWBTOtVWlIUrEK2gwH+/z8QrjhIVULQ/L9Jykrj+AJyKwBNz3q2Nsw3Ho2Rg5mvqF/zW7Jmt5j+euGBmP95devI+y2tKTd/XgafVADfPGzE0WUdu4V5yCfq4tgGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrXAmr/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BDCC433C7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710079427;
	bh=bwiNExhP3G8/4ZF9l7HFtlTqhac5Y1om1nv7SCEhE0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MrXAmr/FhTA07M0n01frmkIyWEcGbzUxsBZ3MglRzMA1sj5v/+EIToP3BDzY2tTGt
	 /cbyFRCTRKFSDyl7w0JWvI1Juc+PLpLIKiJv1Mu0vKZDGecbTd2pof3aaa/kBwWm+u
	 e+KDYV/yCabWPpPlLag8CjPNMtJN7ak518OyBg1fOs5g1EjioPACaO7pK3Gj4VV/2U
	 R7Wakre3MZB2i3QFN2E25FIXzcDY/14MuiyG9/KPly3Wo6SPR+eJZHBNItj1Rd+Og0
	 v7LZxSD+pHZIQEeeRJtiQ6LnMDL19Dw57/vSawx6RbtQdyEnoqCZQGH66iif1jH07D
	 yAYIjfPlaNVNA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44665605f3so541488666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 07:03:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHidxlczPfq60sO8IOOKYk5/3aBy8aeGHl+vGWCRKYc/5ZfjMYHg2OB1hRDlhTew+TZB8dPqVANmcrFkiBiOri3X9D8vGMyBf6MnAC
X-Gm-Message-State: AOJu0YxDJLoddndzeXrJjlwQWqyxPRm0kOO9C4K35hUO9ubABPvipU+L
	0Rs2EWJq3c84DmNJxsvpRBuVli0bBlkeRR5e+FZ7TsFKWz0yf3GYjYKtqmWUvRszvE24EPl8zed
	qkmiuoweXgLsqYWz9+69q5wa45fI=
X-Google-Smtp-Source: AGHT+IG4VFqfXMFmT5TrkFhnEebpwiC0lNv40gCZNo4v3r44FIWbSv/ZoWFpbWWWwdjnrXq3t8+SWp8OpqBOZQQYuos=
X-Received: by 2002:a17:906:564b:b0:a46:2e:ffdb with SMTP id
 v11-20020a170906564b00b00a46002effdbmr2316785ejr.49.1710079426029; Sun, 10
 Mar 2024 07:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308074600.3294338-1-max.kellermann@ionos.com>
 <CAAhV-H6O02es7ZsDRjWfO=9hz8owa1SWZXkyZ=p3BO28D+ix6A@mail.gmail.com> <CAKPOu+_j3FTcjpOfS6O+Pr5sFGEC63ofgU8qjHUFbSPRWtS6_Q@mail.gmail.com>
In-Reply-To: <CAKPOu+_j3FTcjpOfS6O+Pr5sFGEC63ofgU8qjHUFbSPRWtS6_Q@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 10 Mar 2024 22:03:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7X2ViBwz7wz3SPmwaxn__9Mo-5pEL9SGe0xON7exj+wA@mail.gmail.com>
Message-ID: <CAAhV-H7X2ViBwz7wz3SPmwaxn__9Mo-5pEL9SGe0xON7exj+wA@mail.gmail.com>
Subject: Re: [PATCH] loongarch/pgtable.h: move {dmw,tlb}_virt_to_page() to page.h
To: Max Kellermann <max.kellermann@ionos.com>
Cc: kernel@xen0n.name, lienze@kylinos.cn, yangtiezhu@loongson.cn, 
	tglx@linutronix.de, arnd@arndb.de, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Max,

On Sun, Mar 10, 2024 at 6:22=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Sun, Mar 10, 2024 at 2:14=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> > Could you please share what kind of configuration will cause a build er=
ror?
>
> With the current kernel, I found none; the problem is masked currently
> due to the current order of include directives, but it caused problems
> during my attempts to clean up linux/mm.h - see
> https://lore.kernel.org/lkml/20240305085919.1601395-1-max.kellermann@iono=
s.com/
> for the most recent submission; a later (not-yet-submitted) version of
> the series which reproduces the problem can be found here:
> https://github.com/MaxKellermann/linux/commits/mm.h/
OK, I will apply this patch if no one has objections.

Huacai

>
> I saw this problem with "randconfig KCONFIG_SEED=3D0x5D8A9172" - config a=
ttached.
>
> Max

