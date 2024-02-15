Return-Path: <linux-kernel+bounces-67419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B3856B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896801F23619
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C71369AB;
	Thu, 15 Feb 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uxjhqqcs"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B06341F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018749; cv=none; b=o4eI2ALiBVBg5hOW201iCY/yRKlZWMRg1JBIEaTX7pFPgoIAmHIUXwlVppKe8gQ/TyicWKlxveaqAfh3A4Fa0/OfJBXCxAbaPq4Cc9zzsphl4zMByDyQo/3dq9xfoyVet9PcSpdSt5V2zylom64X8ooUppieALKsFA2Xrol5ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018749; c=relaxed/simple;
	bh=IROb4bmJO8p3E3s41Wtdbj9pfrA0+CGUhgFRE4henRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+ZiwSuWtqBp2RaB74Zr3FZL5jkwveAQ//LGjtIheoOrtYNhhu3ocMHJkl8p76TF8pO9o1i3qs7u/tkx5wXan90zwnL+g6dmzBCo2kCWNhxsWYVUaBLKCjZxU08rcC70R6pvFjohv5I90wx7Ij8+/ZJe9SmaetHSRheXr2XZbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uxjhqqcs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso289206a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708018745; x=1708623545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWq3wEzxgQXqqnJ519gqKV1BvSlnBbIhZvrxCM/92is=;
        b=UxjhqqcsMljCZ9cd2vBtFeF8ynqTmX34Ublweq4I7hZfpAztAetNQsoJV+hpm2E9Mm
         rzRihuAMOsSHrGKNbwHkk6gK3k9Q1AwCNovYtZrxPnZ0CD72IFTKA7eyDQSP8MZDEk73
         vWGoCp1V5OW9NqwvYnT3qzVaUMVswCe4628ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018745; x=1708623545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWq3wEzxgQXqqnJ519gqKV1BvSlnBbIhZvrxCM/92is=;
        b=O1sldgQwbICa97d3TkXoiXZ1Ermli3kZdL1Kmgn7I0i2/GhwBHo9rP3AC0hX8XfUc6
         DQQyNnwY2akxUAQJCklsrZVdXjB1VuAaPhiH8Ena882Ma8Sz25RxbH9NoyL/BQSU2rXE
         sftBZIvLycni9BmFZygVSPw0j99HT4gLv4vqXek51jyr1OveGBC1PrkKJB5MwXbUXRzU
         rER74k2O35XVeF9GhWZ7714qusjjACCKOWEL8ueWGuF4FtFGUcbmuB90eP6kQ3eXlPSD
         B2U1er97QT76hWhFoy/iBHQqY0RblmpPvcB96Dkar/XyCWHwZCAGSfupHWEkAroyGFME
         ZpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXphBzuWA0Zo+lBTr4HI1lzaHr1oqAyDzaj38CAnarZdGeSKIs2oj82kpaCCohE9Kxa3lXSyciJDLcEghFRegLF8SSlFzeb9wFY3uMP
X-Gm-Message-State: AOJu0Yz20zq9Qk6lVVE9nawUBm1l63LSRL0E/7RsSxjqMXaIpjVw7hX4
	AG2NcTbLiMAOVaOgB4MhqGXRR7g1ur9qiE1lWTLTGtQAG/Y3XqAZqEAYzLvwggawwv4yAvz7JIQ
	RWybg
X-Google-Smtp-Source: AGHT+IGjT4Ij9Qc4F+GF6EdXsYj/Ve1DpIlAeVn4ltt10j8B34twgq1Yifrbr0sNc5dGjYlpRBURxw==
X-Received: by 2002:a17:906:4115:b0:a3d:4984:8d73 with SMTP id j21-20020a170906411500b00a3d49848d73mr1858353ejk.18.1708018744668;
        Thu, 15 Feb 2024 09:39:04 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906079600b00a3d4b488970sm770487ejc.45.2024.02.15.09.39.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:39:04 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4120933b710so265e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU0UZ8ywedI044jNiSZgGBWqS2rYU4gRyeeLDe/bVnVwpsUyy1QZbInbqKQWWZSFDL38B8IUluDURwCW/uThYZk0xX4Ubcrk3J48nj
X-Received: by 2002:a05:600c:c17:b0:410:d18a:290b with SMTP id
 fm23-20020a05600c0c1700b00410d18a290bmr3550wmb.7.1708018743887; Thu, 15 Feb
 2024 09:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org>
 <170799768132.3746307.14703611184129999692.b4-ty@kernel.org>
In-Reply-To: <170799768132.3746307.14703611184129999692.b4-ty@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Feb 2024 09:38:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WSi=9V-Oe5eq0J-Uew45cX9JfgB8me-Nw-iFRfXm59Xg@mail.gmail.com>
Message-ID: <CAD=FV=WSi=9V-Oe5eq0J-Uew45cX9JfgB8me-Nw-iFRfXm59Xg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
To: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	Dave Martin <Dave.Martin@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 4:44=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, 13 Feb 2024 18:24:38 +0000, Mark Brown wrote:
> > Doug Anderson observed that ChromeOS crashes are being reported which
> > include failing allocations of order 7 during core dumps due to ptrace
> > allocating storage for regsets:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
> >    ...
> >   regset_get_alloc+0x1c/0x28
> >   elf_core_dump+0x3d8/0xd8c
> >   do_coredump+0xeb8/0x1378
> >
> > [...]
>
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] arm64/sve: Lower the maximum allocation for the SVE ptrace regset
>       https://git.kernel.org/arm64/c/2813926261e4

Thanks!

A side note to anyone trying to backport this is that there's a hidden
dependency of commit f171f9e4097d ("arm64/fp: Make SVE and SME length
register definition match architecture"). Without that dependency then
backporting ${SUBJECT} patch is just a no-op. ...backporting the
hidden dependency ends up giving merge conflicts, so for the purposes
of picking this to our 5.15 or earlier branches I went back to just
making the #define be 16 again like it was in v1.

-Doug

