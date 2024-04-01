Return-Path: <linux-kernel+bounces-127136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61866894758
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE143B215E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8D51C2B;
	Mon,  1 Apr 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTvyErDl"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489A748E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010910; cv=none; b=sL9hUaxA8rYR9BryR/4lUf4GkXvlZgzjVsiGKJj7Pn6ILpsfJTiSw9G1JjFW4U0V7woycTkx66qQCNY9CWx6SIYJ34n9YDMq3nGOrRPxiwtObU7jHr7oMvkkw4LM0NWpYCrR9JsWGs2nA17PMsh9sezcTnTqmtxLH98JtZxsPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010910; c=relaxed/simple;
	bh=4gGLUWXWduE/ykETTpwAZnD+sBIEodQCXwALfVpTG28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D34zIn0b9Oy6DQMj5kfb0yjbG5bp7CS2DjqsQJiOGA7RmgWr1u9Una5z9+ctIaC+VUpDy5b0g0POzHgC6T8jhkjBFiXdTHcAiqNNgNb3UrkvlfxveOOjvoy6gdCrgVOQoi5oNv6sWUIUfjudV5LQODdCMD2y6FqhmauQ9cBBkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTvyErDl; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4659571276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712010908; x=1712615708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gGLUWXWduE/ykETTpwAZnD+sBIEodQCXwALfVpTG28=;
        b=KTvyErDlTldSZcsZ1JPziBQgGwM4F8k30Esufvjkwykftzyo7lxm5fLxWz//xjCE07
         4IlOR45R89m7C/E8o/Pak01Re004/AmXK6M1hQjb6iL6Tjiu96Yw+QnaeEjsTxMDYJcp
         OqnfwanJLdH1oK2x+gVTgnpEazxMz9nezlyWrVD5jh3saX1SknHTKqcTnRqNd8A/JAVJ
         vho69FPtGDxwdIUqMtQQ7FR7F1CJRptY+f0ZmqMNst4nurY8vTrIdaqqOSvUcPp3FbIm
         0nEDwHAoelssHPnqIdZCCsLQysI6e0svbbrT7WqU1f4it+ALbApAYe1hkY7OSzaWFChc
         +ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010908; x=1712615708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gGLUWXWduE/ykETTpwAZnD+sBIEodQCXwALfVpTG28=;
        b=I+eSxtSCN7EuLvDPzDMq1LgFtSXYJBo9fRX0/pZ8FTPQvS/N4HhB1zNXPeospeHmSQ
         mvXTPxVDFpFUDm+6J+6pB/2X4Sa5yS9HJN0rpILIGv2FtQJZgo4YAwbpJEJogyRnWJuc
         XdeAnIPGmI+zCfw64MLSmkVbHjYHYA7OD62D8oZ98SVcbA5yfT1U/M83SZLHf8Kdh+uF
         2c2LMxW65VxpfQCPRWf/kvxlivbinw6ik3neUJLOCLsfMeA7mQ8hU77xmNXnbFl1jP+O
         gpcrb3mttTD2f9WNzM9oV7vMmWGVdHTCDavhHJrMbQLPkN5CAwOjWywGPl3p5I/wFquk
         cpsA==
X-Forwarded-Encrypted: i=1; AJvYcCVfY7oy5pt3Um/CucD7fzLymmrK7LHHd0qBnOSf6/oKmecksocfOqGoN1pCP1fDpPNc+ft4FN+IH6dHM0feqJrl2hCk68eY25Ar6MsJ
X-Gm-Message-State: AOJu0Yxf6sm4BeyY9fyO0502nJz9QcPyc0/UqLilsZEG9KwkcW1H/l2H
	2EYmEI6YZByP6v8A/+Kbw4Vi9G7tP8xnVoaRQQku5K3GznuFlstKwa3ThypuzdXP5EaZjavD4I5
	nJVilCAGShLuf2trsmVJNpQy7idKk5pU1uGRYi5hq/KCOh2u32Wmj
X-Google-Smtp-Source: AGHT+IFUi3JTrTCZUB+peXS1I527UV2fsiOM3nDtPNSwVGvli46LhPqpAWJRr+80WKkjqURXZY2ftlDqSn9SU2BsjD4=
X-Received: by 2002:a25:bdc1:0:b0:dcb:abbc:f597 with SMTP id
 g1-20020a25bdc1000000b00dcbabbcf597mr8641545ybk.54.1712010907554; Mon, 01 Apr
 2024 15:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329145605.149917-1-yjnworkstation@gmail.com>
In-Reply-To: <20240329145605.149917-1-yjnworkstation@gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Mon, 1 Apr 2024 15:34:56 -0700
Message-ID: <CAJj2-QEzUjUP4kp9A-XGyjWzd9ZPmchRqYNZaw5AeYEoB7Z-Og@mail.gmail.com>
Subject: Re: [PATCH] mm: init_mlocked_on_free_v3
To: York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 7:56=E2=80=AFAM York Jasper Niebuhr
<yjnworkstation@gmail.com> wrote:
>
> Implements the "init_mlocked_on_free" boot option. When this boot option
> is enabled, any mlock'ed pages are zeroed on free. If
> the pages are munlock'ed beforehand, no initialization takes place.
> This boot option is meant to combat the performance hit of
> "init_on_free" as reported in commit 6471384af2a6 ("mm: security:
> introduce init_on_alloc=3D1 and init_on_free=3D1 boot options"). With
I understand the intent of the init_on_alloc and init_on_free options,
but what's the idea behind special-casing on mlock?
Is the idea that mlocking implies something other than "preventing
memory from being swapped out"?

> "init_mlocked_on_free=3D1" only relevant data is freed while everything
> else is left untouched by the kernel. Correspondingly, this patch
> introduces no performance hit for unmapping non-mlock'ed memory. The
> unmapping overhead for purely mlocked memory was measured to be
> approximately 13%. Realistically, most systems mlock only a fraction of
> the total memory so the real-world system overhead should be close to
> zero.
>
> Optimally, userspace programs clear any key material or other
> confidential memory before exit and munlock the according memory
> regions. If a program crashes, userspace key managers fail to do this
> job. Accordingly, no munlock operations are performed so the data is
> caught and zeroed by the kernel. Should the program not crash, all
> memory will ideally be munlocked so no overhead is caused.
>
> CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON can be set to enable
> "init_mlocked_on_free" by default.
>
> Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>
FYI, git format-patch takes a -v parameter to specify the version of
the patch series. and scripts/checkpatch.pl should catch some of the
formatting and style issues.

I also accidentally forgot to reply all, sorry about the noise York.

Thanks,
Yuanchu Xie

