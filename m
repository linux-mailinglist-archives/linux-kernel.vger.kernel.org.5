Return-Path: <linux-kernel+bounces-132194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B389912E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1861F24B26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09C13C815;
	Thu,  4 Apr 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5XVqqrB"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2B13C3EB;
	Thu,  4 Apr 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269151; cv=none; b=A7MiFRGpaljlR3/FlZHu78jsiui901bBnsuuBDhdhJmp+OhI2wWyT/9awaAUjWFY1TsgmYuI6mkOJdiprcljzrgNYrPCoVVrLULFt0i0jiNVfuxkNIuXRhBW+rx/W4QTgxj4FaPURnd6sSl5b3novSk2HMytxhLjD9IaAZdDNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269151; c=relaxed/simple;
	bh=OBHcickDyG4iGacLH5Fn47xNvsmIx4Xp0B2DdAN7B1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx/wR5Li3sPm4hYJZAd3vhQ8KntYRuwk2j6lSyFB+Y9+yjWOCS+fbJ/UsrGKVU0i6/eYGa0VvsZ88FPv9+08jgk9Rt4Y8LIZbhSDzAvIKc/MK2iVpZ8D+aFM36WL/De7gJvYB8eivwFyCkl3/vBp6QColSyw2drCLxLfxb0vHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5XVqqrB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1149872a12.1;
        Thu, 04 Apr 2024 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712269149; x=1712873949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFi95zOVQYA4xEHKHqIiFXKZ5uGVSt/aCQ/r+P7rpsY=;
        b=I5XVqqrBw/EcINfCazvCNosZZYgzyYBcfi3zJ1Z37Oy8gKO+SNpmS5Y7edzwnrrvZm
         hbPs7cly5N+Ogfh/I3wwJS1qY0haDxLJKbzwFxHE0GQl9v71rVqO5XWg15lMWJFVEzzU
         uWNFh3b2IHQqeQ/xkE35NZVgc9QucJ8Hk76tOcsXRd30WTirJ6JZqQVTajGLDmbKp9OB
         W0c2z767pJN/0er0NGDDNF/R37We3jpYh5mAedeoiFehlzI/9/WQYOZE0/Xjwm80M4rs
         l3iJNqc6kJoEZCbwn0kxogDc2A92gdIx1pIJW5Z2xJhNDVME3INrUQonFlilHkXMofZl
         IoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269149; x=1712873949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFi95zOVQYA4xEHKHqIiFXKZ5uGVSt/aCQ/r+P7rpsY=;
        b=M2kq+SUg/gpkRJiKnPHTasCQX2p7C4I6PKMFcdhpAJ7BqAB19OpjP4e/2MHowjIJwy
         2gJ+npt2QeKUtkNO5Nalcl/zsdXA60MifIAnMxdRmNzxkBl3CgYzyjdn75uzOpIpEp5k
         F5Ep0T27yejMZ2N/ZQGUdVdzm1wR8+hQQtPvYnjJX/f2G7MjewR3KZccqtv/TR4bbXfH
         eSV9DQSGsn5b52q3Rqwfsh1sW1o0RKbuYD7jWMoUJwjY0HLz/V3vDA3HdsHtS5vRRS+l
         VTw+bArC+EDiFKYZcExTINH/PRwjPJjGfYgsm769auZPX5GuG+bjvFRjxlXhQXJ4Qvsm
         O1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVCVPISI7b0u/vdf/HHWGNlk6mEVhbt/0i9tS3P3fWnXSg4MVa2r98VJHlYZLIOmguWG+tBYkC4m/9QpV6r5CLQH8Y/trhZNt92VqB3
X-Gm-Message-State: AOJu0YwIHeHP0uWlNsfKWkGLA/6TuE1mQE3Co3WOg0Hlf3aOQq9UWEew
	9mtET53AQ9vExpXP3612gwRMAkDo6yuflXkLcTcZ376VM5UEJjq+NlMN6d0Nk/1L59pmBGs11sr
	Rwik9sT0FZdz9Gp0PWjaR0XQSMUg=
X-Google-Smtp-Source: AGHT+IH6G5tOrI2ksQ9kGiIvzM22pWSwDHtXY27hq7L0Etr+ekfWcBU+YiIxZ61QO9rb8eSAR3mcKNUBvEuACLWnaRc=
X-Received: by 2002:a05:6a20:d494:b0:1a7:3e78:cc7e with SMTP id
 im20-20020a056a20d49400b001a73e78cc7emr863190pzb.14.1712269149243; Thu, 04
 Apr 2024 15:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404010308.334604-1-void@manifault.com>
In-Reply-To: <20240404010308.334604-1-void@manifault.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 15:18:57 -0700
Message-ID: <CAEf4BzaXDQVCYD3YrzLJTKu7idHZ0KGzSedWPwEX3v44Fq1vQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow invoking kfuncs from
 BPF_PROG_TYPE_SYSCALL progs
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:03=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
> bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
> programs. The whitelist approach taken for enabling kfuncs makes sense:
> it not safe to call these kfuncs from every program type. For example,
> it may not be safe to call bpf_task_acquire() in an fentry to
> free_task().
>
> BPF_PROG_TYPE_SYSCALL, on the other hand, is a perfectly safe program
> type from which to invoke these kfuncs, as it's a very controlled
> environment, and we should never be able to run into any of the typical
> problems such as recursive invoations, acquiring references on freeing
> kptrs, etc. Being able to invoke these kfuncs would be useful, as
> BPF_PROG_TYPE_SYSCALL can be invoked with BPF_PROG_RUN, and would
> therefore enable user space programs to synchronously call into BPF to
> manipulate these kptrs.
>
> This patch therefore enables invoking the aforementioned core kfuncs
> from BPF_PROG_TYPE_SYSCALL progs.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  kernel/bpf/cpumask.c | 1 +
>  kernel/bpf/helpers.c | 1 +
>  2 files changed, 2 insertions(+)
>

Makes sense, but see my comments on patch #2.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index dad0fb1c8e87..33c473d676a5 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -474,6 +474,7 @@ static int __init cpumask_kfunc_init(void)
>         ret =3D bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpu=
mask), false);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &=
cpumask_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &cpumask_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
cpumask_kfunc_set);
>         return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
>                                                    ARRAY_SIZE(cpumask_dto=
rs),
>                                                    THIS_MODULE);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d9e7aca8ae9e..8cde717137bd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2653,6 +2653,7 @@ static int __init kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,=
 &generic_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &gene=
ric_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
generic_kfunc_set);
>         ret =3D ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
>                                                   ARRAY_SIZE(generic_dtor=
s),
>                                                   THIS_MODULE);
> --
> 2.44.0
>

