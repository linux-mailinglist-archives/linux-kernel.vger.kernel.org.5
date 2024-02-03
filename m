Return-Path: <linux-kernel+bounces-50819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C5847E4B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE761C22105
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363163CB;
	Sat,  3 Feb 2024 02:01:30 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D65C9A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925689; cv=none; b=KJnOkK64UHzeU+CoTiKKpCPtvsVDvGH6X9ctJPX3tFsWFN5wd1JBsbI0EnmAIoblDYEb4GheYvpJqWvqtof/hN4MlTkbZWhb461iBQDoiPGrKNQqL/r4KZaVh2+e7AdxH41o9kvN4ZOxRpUX54h9L5inaKtrC7M70mCh54koMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925689; c=relaxed/simple;
	bh=rR+aOdV8FrjGQd+efGHmEoMJokPCMsVnH++GyxBwJ4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtTfYt+mUnlaU9yjpWkxaLSe1env/lTuScf/Lpg83vqpYvzwIslMHHMV2r1r9rzUiEUrzFXGXSjbOgQgUuuiy+3GT3pzAH8FHWRhxMjWFB4h8FZLRZ0ETUshB4W4EqhNxF4K2q0H3AMfqtS6b8Y4LdhhrDm8hwwdcCmFwUPQ+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2605935a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 18:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706925687; x=1707530487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HICfnzr/wPW8INQZ2/4xRGq8z+Fhi65qpmr5eWtufHo=;
        b=EG+sqPfJntIcfesM47pxcBNHVaYqe+U+Frli1yrEl9c7Od+aRmOVBTdRZdf8UWwwcy
         1XB1MrFcXhohTuHxwIHS2QQO/6mwcCS2W9lRdmLgR3cBVtRALB9uM/vu8rvKPWGv437r
         FmXGMKQehYNoqOXWUWSRpFPfjMbCwhSsQcFLEFKu+tApGtIH5W/qKlK6Zu6Dm84PBKl7
         7AzXQyINvw9Rb7tEx2o4bK1tYmub9VIexcY94PEEN1Wj4Lie1PKzyuUKJMXAWpkUzBeM
         USc+HCUy0XSULGEamFJjf/T+/aKuDJob9eR7M6VAJvFRbXfkrt+B6AHn/XkHPM2NSi9B
         C4tQ==
X-Gm-Message-State: AOJu0YzYS5maDx7XJMxJottHpOQl8tj/iN2GJk+QnQiDg5PyT2crrLmS
	wB9FiRFzynLpgGOBlGUZ/6WpzMKtV/BdDZRl8urUI+o9IlNDyMUDFSDN7aS2S4MMydTlQj179jL
	a+4jcM7jCf+EaICM6C4g3eNInZtG2zpmTVqY=
X-Google-Smtp-Source: AGHT+IH3jDAzzKGh8bKDqZV0KpYzXFce6AwQ26CpPBLEu+vYGiO9AvIBAwaI+Q5bx5+wutSffwmcS59aGu8b/MHrntE=
X-Received: by 2002:a05:6a20:2e8f:b0:199:7d51:a942 with SMTP id
 bj15-20020a056a202e8f00b001997d51a942mr8605597pzb.50.1706925687261; Fri, 02
 Feb 2024 18:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zb1EBzpBn4s-mIa8@x1>
In-Reply-To: <Zb1EBzpBn4s-mIa8@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Feb 2024 18:01:16 -0800
Message-ID: <CAM9d7ch6tvwMgdOg=1hZqE23bQUKDtYOdyJ16kkyt+6uY4q7pw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf augmented_raw_syscalls.bpf: Move 'struct
 timespec64' to vmlinux.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:35=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> If we instead decide to generate vmlinux.h from BTF info, it will be
> there:
>
>   $ pahole timespec64
>   struct timespec64 {
>         time64_t                   tv_sec;               /*     0     8 *=
/
>         long int                   tv_nsec;              /*     8     8 *=
/
>
>         /* size: 16, cachelines: 1, members: 2 */
>         /* last cacheline: 16 bytes */
>   };
>
>   $
>
> pahole manages to find it from /sys/kernel/btf/vmlinux, that is
> generated from the kernel types.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../util/bpf_skel/augmented_raw_syscalls.bpf.c     | 14 +-------------
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |  7 +++++++
>  2 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index baecffbece14fb68..d3b672593c540259 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -6,6 +6,7 @@
>   * payload expected by the 'perf trace' beautifiers.
>   */
>
> +#include "vmlinux.h"
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
> @@ -22,19 +23,6 @@
>
>  #define MAX_CPUS  4096
>
> -// FIXME: These should come from system headers
> -#ifndef bool
> -typedef char bool;
> -#endif
> -typedef int pid_t;
> -typedef long long int __s64;
> -typedef __s64 time64_t;
> -
> -struct timespec64 {
> -       time64_t        tv_sec;
> -       long int        tv_nsec;
> -};
> -
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util=
/bpf_skel/vmlinux/vmlinux.h
> index ab84a6e1da5eedb3..e9028235d7717b59 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -20,6 +20,13 @@ typedef __s64 s64;
>
>  typedef int pid_t;
>
> +typedef __s64 time64_t;
> +
> +struct timespec64 {
> +        time64_t        tv_sec;
> +        long int        tv_nsec;
> +};
> +
>  enum cgroup_subsys_id {
>         perf_event_cgrp_id  =3D 8,
>  };
> --
> 2.43.0
>

