Return-Path: <linux-kernel+bounces-47182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E59844A36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0C01F271AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C139FF1;
	Wed, 31 Jan 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxcRhK6c"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31539AC8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737205; cv=none; b=AoigaSxmnooJPe/DpDiX5wCTK3/fw5Eq7g0gHQDyTwS4xGZ5zGoh7Ew1/RHs7ZmhwPySu94zg9yAl+y2u3fLMhJSVkgc9lAMnSfaTgCWMZb0iEh3CF534NszKpc0oc4FubLUJoDhFr8n8hSuqMHg7tRNIN77RB1LiSu61ccOr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737205; c=relaxed/simple;
	bh=985KcQ3UVIDR1csYLNaIAW5hTokn3RhXK7uIuRctAa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDTpp2m0MwDLJEDfJhNyGwLI7OjQywZDcha0FB+H12zVwIlDiYRAeAxZqmmMvruUXcmL8AYT0Om26Yhl5lp5gyn+tKvYhNi7pyv61mzCsYV2CNfCYXRLcXxvUfM7R7MZELbxMpfkU/JWexXv9a+uIBYT4QJA4VesMEy5byVsyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxcRhK6c; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363961cfbe2so19865ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706737203; x=1707342003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFjObDdGQLE9bY7yI89gY+pg7QylMew1kpmpiCAjiMM=;
        b=hxcRhK6cZzvpfkKe16CpQPJz7r4mkr4Qdhp+cTcsLuas+P16smNhbIeg4LT6+vC8WI
         3KrJTQKnNbLqRZ7rqOS66BaH22dThvxorOyU4ZXzq2rvUuDGF61+6Tq8/vXgvboftPqx
         g0xSdSSt0lSWtnn2W466Z6KO63RxgMPcvp+8jfZQeYfWp2Y1MzPFByOhJ0goCDiv5bXi
         oeSOuoyGMxbSYOkuFyDkM830OVnOi0/zuTqUD+aah52PIj1n533ciXH6MSYo0A6724A1
         ogIL2/gy3vkxDIlqo9O46AIgRfEF14jhg2KEDrZmAlRAOZHWzfp7hh/M80ogQlLjP+nR
         0nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737203; x=1707342003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFjObDdGQLE9bY7yI89gY+pg7QylMew1kpmpiCAjiMM=;
        b=SJ7OngYxZlBRdv7r9CJOHWv/wjF40VFSPcnpO/dsKxXLB8Oshy9ly+AECkud2FtPVm
         vih5FcvyxPxk0kGcgX3gAm+WkPjbKA9pICJJUA2S7BxN8G4QqcA/BX5I455aQXPC335G
         BesOeHRUF/kb2TWjHR+drxFpoP0Bq5dI463XL2wEnNMn8vWnMaGnod0kigdrxMVOY/Xr
         ZbdWa06keN7hDPNbEZx1RlzeNHUzgqOFBU8MHy0AKPsK6ebgIOlwv8cRNtsNwNyXZLME
         UkqkAlZxLt12Ih+4+KBzB20aWwrLVOiW8eMsiONgqsT/12u4IrkkHYHzI/iR0ctz0nL4
         Ileg==
X-Gm-Message-State: AOJu0YxyqRixxER3jfmx4l2ZN/G8Szm6iHCIcDK2uslVhLresOgITLci
	zwRCjVbHTj3p81qEA1/6L3HZ47yJMSR8HCoYIT0clsnwj24QxsBGpag95G9FBPm0ZCVmJqtCP7K
	Un9TOs5CXTTux5truCzVHxEvk2YyddqdJKfTxXoaY2P/ctjtZBLoI
X-Google-Smtp-Source: AGHT+IGejzTIlC7NrVAXQ5FDPjCop3CAqTjxm44U93l+LbKW3cvzVlR4bCrOu9FG3KQbybT5RJdD9hvTEVu6S7GDhOc=
X-Received: by 2002:a05:6e02:747:b0:363:9d1d:1c0d with SMTP id
 x7-20020a056e02074700b003639d1d1c0dmr24676ils.13.1706737203050; Wed, 31 Jan
 2024 13:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbq72dJRpOlfRWnf@kernel.org>
In-Reply-To: <Zbq72dJRpOlfRWnf@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 13:39:51 -0800
Message-ID: <CAP-5=fW7zk2A1OqCAA1ngVydzzNmSbhhLC0D9OR7jzU_rg=1WA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf trace: Collect sys_nanosleep first argument
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> That is a 'struct timespec' passed from userspace to the kernel as we
> can see with a system wide syscall tracing:
>
>   root@number:~# perf trace -e nanosleep
>        0.000 (10.102 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>       38.924 (10.077 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      100.177 (10.107 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      139.171 (10.063 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      200.603 (10.105 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      239.399 (10.064 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      300.994 (10.096 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      339.584 (10.067 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      401.335 (10.057 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      439.758 (10.166 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      501.814 (10.110 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      539.983 (10.227 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      602.284 (10.199 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      640.208 (10.105 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      702.662 (10.163 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      740.440 (10.107 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      802.993 (10.159 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>   ^Croot@number:~# strace -p 9150 -e nanosleep
>
> If we then use the ptrace method to look at that podman process:
>
>   root@number:~# strace -p 9150 -e nanosleep
>   strace: Process 9150 attached
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   ^Cstrace: Process 9150 detached
>   root@number:~#
>
> With some changes we can get something closer to the strace output,
> still in system wide mode:
>
>   root@number:~# perf config trace.show_arg_names=3Dfalse
>   root@number:~# perf config trace.show_duration=3Dfalse
>   root@number:~# perf config trace.show_timestamp=3Dfalse
>   root@number:~# perf config trace.show_zeros=3Dtrue
>   root@number:~# perf config trace.args_alignment=3D0
>   root@number:~# perf trace -e nanosleep --max-events=3D10
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   root@number:~#
>   root@number:~# perf config
>   trace.show_arg_names=3Dfalse
>   trace.show_duration=3Dfalse
>   trace.show_timestamp=3Dfalse
>   trace.show_zeros=3Dtrue
>   trace.args_alignment=3D0
>   root@number:~# cat ~/.perfconfig
>   # this file is auto-generated.
>   [trace]
>         show_arg_names =3D false
>         show_duration =3D false
>         show_timestamp =3D false
>         show_zeros =3D true
>         args_alignment =3D 0
>   root@number:~#
>
> This will not get reused by any other syscall as nanosleep is the only
> one to have as its first argument a 'struct timespec" pointer argument
> passed from userspace to the kernel:
>
>   root@number:~# grep timespec /sys/kernel/tracing/events/syscalls/sys_en=
ter_*/format | grep offset:16
>   /sys/kernel/tracing/events/syscalls/sys_enter_nanosleep/format:       f=
ield:struct __kernel_timespec * rqtp;  offset:16;      size:8; signed:0;
>   root@number:~#
>
> BTF based pretty printing will simplify all this, but then lets just get
> the low hanging fruits first.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c                    |  2 ++
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 21 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 109b8e64fe69ae32..6abe280dc38f1921 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1048,6 +1048,8 @@ static const struct syscall_fmt syscall_fmts[] =3D =
{
>           .arg =3D { [3] =3D { .scnprintf =3D SCA_MREMAP_FLAGS, /* flags =
*/ }, }, },
>         { .name     =3D "name_to_handle_at",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
> +       { .name     =3D "nanosleep",
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_TIMESPEC,  /* req */ },=
 }, },
>         { .name     =3D "newfstatat",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
>         { .name     =3D "open",
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 52c270330ae0d2f3..baecffbece14fb68 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -354,6 +354,27 @@ int sys_enter_clock_nanosleep(struct syscall_enter_a=
rgs *args)
>         return 1; /* Failure: don't filter */
>  }
>
> +SEC("tp/syscalls/sys_enter_nanosleep")
> +int sys_enter_nanosleep(struct syscall_enter_args *args)
> +{
> +       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> +       const void *req_arg =3D (const void *)args->args[0];
> +       unsigned int len =3D sizeof(augmented_args->args);
> +       __u32 size =3D sizeof(struct timespec64);
> +
> +        if (augmented_args =3D=3D NULL)
> +               goto failure;
> +
> +       if (size > sizeof(augmented_args->__data))
> +                goto failure;
> +
> +       bpf_probe_read_user(&augmented_args->__data, size, req_arg);
> +
> +       return augmented__output(args, augmented_args, len + size);
> +failure:
> +       return 1; /* Failure: don't filter */
> +}
> +
>  static pid_t getpid(void)
>  {
>         return bpf_get_current_pid_tgid();
> --
> 2.43.0
>

