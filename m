Return-Path: <linux-kernel+bounces-137644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37589E4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6040282AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE1158867;
	Tue,  9 Apr 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5jzyBH5"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E19158851
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698142; cv=none; b=Uf++wUF05onhS4bR1cf0d4nyOTR0923lsCrKsZIKe1kd1z5mjL1pw+H8nrwFoOWZHIp5JjFoE1wiT1loRxyEAdHsWajxm2dWFbEqxEceRnNCnCtl2RlPwNrlDlyBPGYJXICKIcVyvS/YyS+7a/XIskluCuvIQHmSmopM7DRU3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698142; c=relaxed/simple;
	bh=8hahaSlpUCuWs5ErEu7Vn6rWT9MWMKsz31mT4yVZ8DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5DqHgF3iWBWSYP7fpMzTdphxwJxDxQs406iXLOVCTtCvX+tgkmqLPGywOIW2ltEWQv7oGwoU65nlT++3UDmD+WtkWYekMRp1oOz43zDRqGhq8EPVRm4pxu8hXklxwmbruqQrU8+qDdpGWkYiQRkpx/Yd0b5BI8EtwgfPbQLTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5jzyBH5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so14045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712698139; x=1713302939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlpIKC9YdW3AY0kdbg2B0nJR6pLjcYcStssU1/0Zjls=;
        b=P5jzyBH5+nCOxSWDphqokJ3FYil/RinNmtIhBDV7XEV2iXnhR/ygjYgXf7L5wKoZa7
         H585douqHIB3rRkmSuneNjIuC9LS/gClMD3janzqHBiBsLxqmRy1Ad/QtbwuEJR7PERg
         qLNI8iL8LOduNI1RET2Rit00+cXMK0kKNI8eC+gPikFDPDyKQkFbkNX87At8QJ7jFeLl
         iq7Qu4yWDomlVdtiUvcRfgmh65hvIOmhwtBPrMLYXQF9JOzLtndjdBHNClaLV53vIQaG
         kzxFAyD5PHSEaXWRGM8XazsLT0h93Z4bBwYJ7X3ziuuQkB2RQAc9ewuO2BULQuVc+UMG
         Us1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698139; x=1713302939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlpIKC9YdW3AY0kdbg2B0nJR6pLjcYcStssU1/0Zjls=;
        b=Ym4xkgDPlhrYd5HfCvN2SUkyINLyW5mroEfu5+DX/bS8wb+GWR0LyhDvaNXnSP9t86
         /EFlsi6sZpyBHjXe7XEz2XMOu17kWU+yNJ1xBOP49wrv+aosipeXS0ex5p55c1TF3GnC
         bR7Ff+IuZZ9ALQB5Hii/1Q953heqeMwtxwCKwoZMAYxtnMMKYzcfaVBd2vNFiJUoflvq
         lGPeo89vNgl1irTT8Mc3Mam/lIWmfLYRKh6o9IDmVakrmmFmq+cJP4sXjk7K826TbYzf
         lbcLKiY4lCCwhiXEhKvkzFOnEcYq9+6s6iS4CQy6zwZz9B2m0R89ia6t1gT2f9YhfPgp
         fS9A==
X-Forwarded-Encrypted: i=1; AJvYcCWA8ZxPVn9WEDoyLsI23uUYZvK333f7YS0hTaaGGiqdpxbc/Om5z2i8/xtscXITMm03yjXTKa3sHCsVmiPy8DLWwq4+Patj2VyXDJFI
X-Gm-Message-State: AOJu0YxtTW4QZaIFhZ/3CXy7mc65zFjsV89RgZwjyVGuLtkRkeYX3ubA
	hWgOVSXy3UF/ZBAoGbX94b3xwt1+xfnpACKgDtU17lIElItvLNccDSpnWdB9T7sHnzrOWLgU5Hm
	UsRMR/mlX62wlKZYdDFkuXT9y6fa5ReW0dX6g
X-Google-Smtp-Source: AGHT+IE1zKKybQi1Lfs3RAG8qynsc0HXtJ1BtoUXE6F+s0GlQP9B2DXUSp/JCFIP41AdV1QhhpyXAR/usmUi3Lk2bF8=
X-Received: by 2002:a05:6e02:1d1a:b0:36a:2a78:1c38 with SMTP id
 i26-20020a056e021d1a00b0036a2a781c38mr19233ila.13.1712698139335; Tue, 09 Apr
 2024 14:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhWTIuyB9p1ORbQH@x1>
In-Reply-To: <ZhWTIuyB9p1ORbQH@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 14:28:43 -0700
Message-ID: <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid systems
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 12:12=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> root@x1:~# grep -m1 "model name" /proc/cpuinfo
> model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> root@x1:~# uname -a
> Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:3=
9 UTC 2024 x86_64 GNU/Linux
> root@x1:~#
>
> Bisected down to:
>
> commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> Author: Ravi Bangoria <ravi.bangoria@amd.com>
> Date:   Thu Jun 15 10:47:00 2023 +0530
>
>     perf mem: Scan all PMUs instead of just core ones
>
>     Scanning only core PMUs is not sufficient on platforms like AMD since
>     perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
>     Scan all PMUs instead of just core PMUs. There should be negligible
>     performance overhead because of scanning all PMUs, so we should be ok=
ay.
>
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>
> root@x1:~# perf -v ; perf test -v "Test data symbol"
> perf version 6.4.rc3.g5752c20f3787
> 111: Test data symbol                                                :
> --- start ---
> test child forked, pid 522202
> Recording workload...
> malloc_consolidate(): invalid chunk size
> /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60: 52=
2208 Aborted                 (core dumped) perf mem record --all-user -o ${=
PERF_DATA} -- $TEST_PROGRAM
> /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62: ki=
ll: (522208) - No such process
> Cleaning up files...
> test child finished with -1
> ---- end ----
> Test data symbol: FAILED!
> root@x1:~# perf -v ; perf test -v "Test data symbol"
> perf version 6.8.g63c22868714b
> 116: Test data symbol:
> --- start ---
> test child forked, pid 526540
>  954300-954339 l buf1
> perf does have symbol 'buf1'
> Recording workload...
> Waiting for "perf record has started" message
> OK
> Cleaning up files...
> ---- end(-1) ----
> 116: Test data symbol                                                : FA=
ILED!
> root@x1:~#
>
> Further details:
>
> (gdb) run mem record --all-user sleep 1
> Starting program: /root/bin/perf mem record --all-user sleep 1
>
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbin=
it.
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000611860 in perf_mem_events__record_args (rec_argv=3D0xea8280, =
argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7fffffffd6c0) at u=
til/mem-events.c:213
> 213                                     s =3D perf_mem_events__name(j, pm=
u->name);
> (gdb) bt
> #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=3D0xea82=
80, argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7fffffffd6c0) =
at util/mem-events.c:213
> #1  0x000000000045c47f in __cmd_record (argc=3D2, argv=3D0x7fffffffe420, =
mem=3D0x7fffffffda20) at builtin-mem.c:152
> #2  0x000000000045d69b in cmd_mem (argc=3D4, argv=3D0x7fffffffe420) at bu=
iltin-mem.c:514
> #3  0x00000000004ffe38 in run_builtin (p=3D0xe08aa0 <commands+672>, argc=
=3D5, argv=3D0x7fffffffe420) at perf.c:323
> #4  0x00000000005000ac in handle_internal_command (argc=3D5, argv=3D0x7ff=
fffffe420) at perf.c:377
> #5  0x00000000005001fb in run_argv (argcp=3D0x7fffffffe23c, argv=3D0x7fff=
ffffe230) at perf.c:421
> #6  0x00000000005004e8 in main (argc=3D5, argv=3D0x7fffffffe420) at perf.=
c:537
> (gdb) list -5
> file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> (gdb)
>
>
>
> (gdb) list -5
> file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> (gdb) p j
> $1 =3D 0
> (gdb) p pmu->name
> Cannot access memory at address 0x64ffffff9c
> (gdb)
>
> 183 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> 184                                  char **rec_tmp, int *tmp_nr)
> 185 {
> 186         int i =3D *argv_nr, k =3D 0;
> 187         struct perf_mem_event *e;
> 188         struct perf_pmu *pmu;
> 189         char *s;
> 190
> 191         for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> 192                 e =3D perf_mem_events__ptr(j);
> 193                 if (!e->record)
> 194                         continue;
> 195
> 196                 if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> 197                         if (!e->supported) {
> 198                                 pr_err("failed: event '%s' not suppor=
ted\n",
> 199                                        perf_mem_events__name(j, NULL)=
);
> 200                                 return -1;
> 201                         }
> 202
> 203                         rec_argv[i++] =3D "-e";
> 204                         rec_argv[i++] =3D perf_mem_events__name(j, NU=
LL);
> 205                 } else {
> 206                         if (!e->supported) {
> 207                                 perf_mem_events__print_unsupport_hybr=
id(e, j);
> 208                                 return -1;
> 209                         }
> 210
> 211                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NU=
LL) {
> 212                                 rec_argv[i++] =3D "-e";
> 213                                 s =3D perf_mem_events__name(j, pmu->n=
ame);
> 214                                 if (s) {
> 215                                         s =3D strdup(s);

This looks like something that address/memory sanitizers could help with.

Thanks,
Ian

