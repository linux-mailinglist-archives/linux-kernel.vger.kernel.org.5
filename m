Return-Path: <linux-kernel+bounces-48292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046108459A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E12FB252A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDA5D47D;
	Thu,  1 Feb 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9uSLSPI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B25D46C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796530; cv=none; b=O1ogUH49mQhyctZjBoFDvZxrkBJ0VRjMQe7x7ILVpe+vJ/1VTUeJ3oN8WG8DkCE0YXjJOTvJXX7tRTkn8uGUyI8GVm9FxX/CIKapr665OWMbdl6n+Y4c+jfXgLKOCbLdf8HNbEYtXnXcO9XztpwQz4W6HwUxO1I52wEbR7AFgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796530; c=relaxed/simple;
	bh=S/kT237ryNm3PnPnPKNnfVvpg+yzXlMfAL2xvda/AUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntda04RA10UxiJos0QAkiMGREwlkmwlHTVA5AsSTlJRFwTMVrRKdJzvgoqZq+zoaugpi/i6MBIL57yfOo/jrLbfpeQKHP6jSu9F2syBMhS2d208kt341CjptCEuipHO6wCA10khg8nWtMTkh3wqjFD0Gt6KWtS+Xl3MTm91h8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9uSLSPI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb804e4deso8633285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796526; x=1707401326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXTNG0NGaTKBhOKJjgCQmT3vvlhWCnQV7wCDhgjDYvY=;
        b=H9uSLSPIb36xXGqJMtatGZTm62wRRQANP+utYPUE5YS1M4Vl24JAtTxgaAi+b2gS2L
         9prFvSpQN0y+UW7UM+rvBGvp/m82UonIrwHOk2pv8GxFFt+U+QKty3FMYERrESr3zOaC
         F2KF594CFGvu6pEJ7Qp3v3HKbOipfim5lor8Y0+mVDf1cuvJ+AnN6wrulhGUfNgQvB6H
         6Vyp35ER7wv6mCrhoABYhvoQtfi8yVFl6AQCAmDiwhptzik2r4Uu/6CQUQlzeH+h327e
         BxXLMlsF36bmBV8iIcbA5BjH+JaO7tkBLp1T8iBB8PCt25YQ7jl7jPC8/uqjeTQ40gZB
         ssug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796526; x=1707401326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXTNG0NGaTKBhOKJjgCQmT3vvlhWCnQV7wCDhgjDYvY=;
        b=Xe42mg5Qc1iOzN+mIJupvoNr3MvqYNKsvDBf/cbLIQ4oQUcGE2ddrKFSPwTY0v47UK
         hd9a0i/C0s2ge8bDs7yQelGO7dUvI3pHYB/Mtn32YtXCEETXNvr5Rhp75koHAhz8yPPL
         oDO2lFEWXvqawH7xknu41rRAfTuBXeAPCAJtzLCR1H85ltBu/TECSrfp/O97lyMAkXs6
         TvorFm+Uc27KKJn37m6s+5ZXVHcEq2lKIoSzUTrZfEBW1UE+UgJpslJdUvNzl/nAdQqH
         0miPJPjlaF0UNH5c/GixaukVOfUB5dkOpDx6Gl+zroCOQB/oJLYhL5NuK/vk+SWFmm9u
         HT5Q==
X-Gm-Message-State: AOJu0YwMRxMLF7hEdsG6WcqOxRJiRgYCJrPK+gFPLTNSAOM5NTRn77ZQ
	OaDl8zsh+RwBOpzxxJD6jX6cbG9TqWa/9V4RDJgcgThcfh48PGWN1oGv/sTG9VJ/mKpiW3JW+YP
	9/+FNSyDhZIyG543FrELjhHDPwUW4fdE2
X-Google-Smtp-Source: AGHT+IHUl5nsQEgb/tuY4bb5N8uvwcpyJ1bcH5pP+Y6up1rSp3IrGvYyFCDrC5oLqOGDKnqyb0GMksvu1T36/vTFpSE=
X-Received: by 2002:adf:fe48:0:b0:33a:f321:5ae6 with SMTP id
 m8-20020adffe48000000b0033af3215ae6mr3848112wrs.35.1706796526366; Thu, 01 Feb
 2024 06:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201090434.1762340-1-elver@google.com>
In-Reply-To: <20240201090434.1762340-1-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 1 Feb 2024 15:08:35 +0100
Message-ID: <CA+fCnZchOw9Eg3uBPF6Xej+vXnxKD8Jzp2V_o5qZGFM5MDo_AQ@mail.gmail.com>
Subject: Re: [PATCH -mm v2] stackdepot: fix -Wstringop-overflow warning
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:04=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> Since 113a61863ecb ("Makefile: Enable -Wstringop-overflow globally")
> string overflow checking is enabled by default. Within stackdepot, the
> compiler (GCC 13.2.0) assumes that a multiplication overflow may be
> possible and flex_array_size() can return SIZE_MAX (4294967295 on
> 32-bit), resulting in this warning:
>
>  In function 'depot_alloc_stack',
>      inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
>  arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' speci=
fied bound 4294967295 exceeds maximum object size 2147483647 [-Werror=3Dstr=
ingop-overflow=3D]
>    150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>  lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
>    459 |         memcpy(stack->entries, entries, flex_array_size(stack, e=
ntries, nr_entries));
>        |         ^~~~~~
>  cc1: all warnings being treated as errors
>
> This is due to depot_alloc_stack() accepting an 'int nr_entries' which
> could be negative without deeper analysis of callers.
>
> The call to depot_alloc_stack() from stack_depot_save_flags(), however,
> only passes in its nr_entries which is unsigned int. Fix the warning by
> switching depot_alloc_stack()'s nr_entries to also be unsigned.
>
> Link: https://lore.kernel.org/all/20240201135747.18eca98e@canb.auug.org.a=
u/
> Fixes: d869d3fb362c ("stackdepot: use variable size records for non-evict=
able entries")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Just switch 'nr_entries' to unsigned int which is already the case
>   elsewhere.
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 8f3b2c84ec2d..4a7055a63d9f 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -420,7 +420,7 @@ static inline size_t depot_stack_record_size(struct s=
tack_record *s, unsigned in
>
>  /* Allocates a new stack in a stack depot pool. */
>  static struct stack_record *
> -depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depo=
t_flags_t flags, void **prealloc)
> +depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 h=
ash, depot_flags_t flags, void **prealloc)
>  {
>         struct stack_record *stack =3D NULL;
>         size_t record_size;
> --
> 2.43.0.429.g432eaa2c6b-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

