Return-Path: <linux-kernel+bounces-141474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA08A1EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68A81F27BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721156B73;
	Thu, 11 Apr 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9tKPazp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB1205E35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859996; cv=none; b=EMg6tdgyvqfo3K3Nj+OLiEPMXwri/aTb6hlK3kkC+KU19AuUP8mq9q7vRz0/aLv+Zh0vYeGFW2n4pF/LWPU8pKJpjRHMLzEjFb1iE/Chwjhec9ayQKlfyawh3czbq4+YMDqTQcfaoIIxcRZLO7JIY68MXKxcPCWwY3gbwonbUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859996; c=relaxed/simple;
	bh=cUoKJPO1frb65Eu9had+XQKYxvcWcC7R+sgZ987tX6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdAK4cjGbABPZzGJT8wduPWG33gpoonk6Z7v+4HojebjxiWqgwvC9pl3kL5m/TBmUbZj2QxmvBRYcXiOFzAQRwyJxxk+nxJnmjjZ1v9LEBLR5IQLI+y6NuveO/EPsFvBy1IJkz20hVWVPgVnBnDBfsHXpSH1sANkOzFBtm/GrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9tKPazp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c89f3d32so23535ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859994; x=1713464794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC41917dgny/jVUVx3QVCZJWuG+qzx5F6Qv3bCsIzVE=;
        b=v9tKPazpTawHSe+rK7xqVCwbr+FkPHQsSK04WoQYHKIdON9RBl2LAC3dEg1EjIW8RS
         9k1tglQbiFYIb5siVateaXj5fwpjL5qYwGCWfkDjSI0iLwUxh+hURzqzDL/iqAkIzOP7
         DQZsyzqtLeRVbnuYxrCw8RDMJ/uA4RaBJPTxtf12BErU7bBLBIiFttITNx3LPMqsgOHJ
         tSQdsZEX+TvdJG4GnDZPosfPImTI0ny7A2UtbxE2608KpRLkfvinYPUlgPZeCFeqd76B
         P6zcVgTssCILt0h+VbPaYC/4DY6n4c8RsBFke67rtrIlICQu0n68/FEBpdW/8EdsMW06
         55nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859994; x=1713464794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC41917dgny/jVUVx3QVCZJWuG+qzx5F6Qv3bCsIzVE=;
        b=SA3c003/D1zf21/nAINVW1AKaGPtWWlHb1oRuvG735oZT/+7dabInTq10VyEaxLFSZ
         9hOQmLPZ6qlqwz9SZYc9wpAyXpu31bxvqSk2duO1Q0n3jBumOv4JpkT8znGlv1GJC49+
         Jz/mN3hji323meQ7KBWIn4fWNuLlPVOVNpFN8KuQzoTAap19a7YMXTOqY4LQ6TzyPprs
         82OPzC6R9U/+0cd4WxUFlMm4brZ6EpnToVRT9HzburrvKfrn926Dkh0XavEM5+coTUcn
         34i1y+ka+fIFtiSWhjNlfNFZz8IwQFEvKsPIJotgOhWoyr40sgzbTWo50q1XgdMk4Asm
         AwNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZi0vUaUYfkQgWVIBXQemYrlQU/5qNPTCGr249ruJVNpBozZZWhz94BucqHGmgsJzfjygOJN+rkKW0YH3Df6QUpEXobHDk0cWtPO9D
X-Gm-Message-State: AOJu0Yx6+L+yNMZcs1LiFU7MlFcBC8yx2ekHUvl77r8U13IuHVCoQUk7
	LYyv3U/iFuwlACGuL1E6lwGGD8qyk50zxmmMqBCBvcADYEKM9PkiMG0RCcsKVcRhm9wB0wwAspw
	pwYfXEpTZA2/an3Rac+e2f0YDgjxeG9uy60Il
X-Google-Smtp-Source: AGHT+IFAAV0KSnFsBZIG+Z9mxEFfB3YxRLmfRM8eML++JJOVy0kWDixF2H0Be9NL8D4o/ShBYoKWX03L19DmBH3RBQo=
X-Received: by 2002:a17:902:ce87:b0:1e5:5c7a:6a4e with SMTP id
 f7-20020a170902ce8700b001e55c7a6a4emr15863plg.2.1712859993699; Thu, 11 Apr
 2024 11:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhWTIuyB9p1ORbQH@x1> <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>
 <Zhgly2eQ5vk4FdEE@x1>
In-Reply-To: <Zhgly2eQ5vk4FdEE@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Apr 2024 11:26:21 -0700
Message-ID: <CAP-5=fVOR+9tEjn84Og-ZHSsNsfQcd7boLPrPv9cqdqtp8us1g@mail.gmail.com>
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid systems
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Apr 09, 2024 at 02:28:43PM -0700, Ian Rogers wrote:
> > On Tue, Apr 9, 2024 at 12:12=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > > model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> > > root@x1:~# uname -a
> > > Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:=
50:39 UTC 2024 x86_64 GNU/Linux
> > > root@x1:~#
> > >
> > > Bisected down to:
> > >
> > > commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> > > Author: Ravi Bangoria <ravi.bangoria@amd.com>
> > > Date:   Thu Jun 15 10:47:00 2023 +0530
> > >
> > >     perf mem: Scan all PMUs instead of just core ones
> > >
> > >     Scanning only core PMUs is not sufficient on platforms like AMD s=
ince
> > >     perf mem on AMD uses IBS OP PMU, which is independent of core PMU=
.
> > >     Scan all PMUs instead of just core PMUs. There should be negligib=
le
> > >     performance overhead because of scanning all PMUs, so we should b=
e okay.
> > >
> > >     Reviewed-by: Ian Rogers <irogers@google.com>
> > >     Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > >
> > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > perf version 6.4.rc3.g5752c20f3787
> > > 111: Test data symbol                                                =
:
> > > --- start ---
> > > test child forked, pid 522202
> > > Recording workload...
> > > malloc_consolidate(): invalid chunk size
> > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60=
: 522208 Aborted                 (core dumped) perf mem record --all-user -=
o ${PERF_DATA} -- $TEST_PROGRAM
> > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62=
: kill: (522208) - No such process
> > > Cleaning up files...
> > > test child finished with -1
> > > ---- end ----
> > > Test data symbol: FAILED!
> > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > perf version 6.8.g63c22868714b
> > > 116: Test data symbol:
> > > --- start ---
> > > test child forked, pid 526540
> > >  954300-954339 l buf1
> > > perf does have symbol 'buf1'
> > > Recording workload...
> > > Waiting for "perf record has started" message
> > > OK
> > > Cleaning up files...
> > > ---- end(-1) ----
> > > 116: Test data symbol                                                =
: FAILED!
> > > root@x1:~#
> > >
> > > Further details:
> > >
> > > (gdb) run mem record --all-user sleep 1
> > > Starting program: /root/bin/perf mem record --all-user sleep 1
> > >
> > >
> > > This GDB supports auto-downloading debuginfo from the following URLs:
> > >   <https://debuginfod.fedoraproject.org/>
> > > Enable debuginfod for this session? (y or [n]) y
> > > Debuginfod has been enabled.
> > > To make this setting permanent, add 'set debuginfod enabled on' to .g=
dbinit.
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x0000000000611860 in perf_mem_events__record_args (rec_argv=3D0xea82=
80, argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7fffffffd6c0) =
at util/mem-events.c:213
> > > 213                                     s =3D perf_mem_events__name(j=
, pmu->name);
> > > (gdb) bt
> > > #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=3D0x=
ea8280, argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7fffffffd6=
c0) at util/mem-events.c:213
> > > #1  0x000000000045c47f in __cmd_record (argc=3D2, argv=3D0x7fffffffe4=
20, mem=3D0x7fffffffda20) at builtin-mem.c:152
> > > #2  0x000000000045d69b in cmd_mem (argc=3D4, argv=3D0x7fffffffe420) a=
t builtin-mem.c:514
> > > #3  0x00000000004ffe38 in run_builtin (p=3D0xe08aa0 <commands+672>, a=
rgc=3D5, argv=3D0x7fffffffe420) at perf.c:323
> > > #4  0x00000000005000ac in handle_internal_command (argc=3D5, argv=3D0=
x7fffffffe420) at perf.c:377
> > > #5  0x00000000005001fb in run_argv (argcp=3D0x7fffffffe23c, argv=3D0x=
7fffffffe230) at perf.c:421
> > > #6  0x00000000005004e8 in main (argc=3D5, argv=3D0x7fffffffe420) at p=
erf.c:537
> > > (gdb) list -5
> > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines=
.
> > > (gdb)
>
> > >
> > >
> > > (gdb) list -5
> > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines=
.
> > > (gdb) p j
> > > $1 =3D 0
> > > (gdb) p pmu->name
> > > Cannot access memory at address 0x64ffffff9c
> > > (gdb)
> > >
> > > 183 int perf_mem_events__record_args(const char **rec_argv, int *argv=
_nr,
> > > 184                                  char **rec_tmp, int *tmp_nr)
> > > 185 {
> > > 186         int i =3D *argv_nr, k =3D 0;
> > > 187         struct perf_mem_event *e;
> > > 188         struct perf_pmu *pmu;
> > > 189         char *s;
> > > 190
> > > 191         for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > > 192                 e =3D perf_mem_events__ptr(j);
> > > 193                 if (!e->record)
> > > 194                         continue;
> > > 195
> > > 196                 if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> > > 197                         if (!e->supported) {
> > > 198                                 pr_err("failed: event '%s' not su=
pported\n",
> > > 199                                        perf_mem_events__name(j, N=
ULL));
> > > 200                                 return -1;
> > > 201                         }
> > > 202
> > > 203                         rec_argv[i++] =3D "-e";
> > > 204                         rec_argv[i++] =3D perf_mem_events__name(j=
, NULL);
> > > 205                 } else {
> > > 206                         if (!e->supported) {
> > > 207                                 perf_mem_events__print_unsupport_=
hybrid(e, j);
> > > 208                                 return -1;
> > > 209                         }
> > > 210
> > > 211                         while ((pmu =3D perf_pmus__scan(pmu)) !=
=3D NULL) {
> > > 212                                 rec_argv[i++] =3D "-e";
> > > 213                                 s =3D perf_mem_events__name(j, pm=
u->name);
> > > 214                                 if (s) {
> > > 215                                         s =3D strdup(s);
> >
> > This looks like something that address/memory sanitizers could help wit=
h.
>
> I'm I forgetting something?

I think it is just that the shell script pipes the output and so we
don't see it in verbose mode. I'd add a "set -x" to
tools/perf/tests/shell/test_data_symbol.sh so you can run the failing
command without the redirects/pipes/..

Thanks,
Ian

> =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf ~/libexec/perf-core/ ; ma=
ke -k CORESIGHT=3D1 EXTRA_CFLAGS=3D"-fsanitize=3Daddress" O=3D/tmp/build/$(=
basename $PWD)/ -C tools/perf install-bin
>
> root@x1:~# perf test -v 116
> 116: Test data symbol:
> --- start ---
> test child forked, pid 614595
>  f87540-f87579 l buf1
> perf does have symbol 'buf1'
> Recording workload...
> Waiting for "perf record has started" message
> OK
> Cleaning up files...
> ---- end(-1) ----
> 116: Test data symbol                                                : FA=
ILED!
> root@x1:~# ldd ~/bin/perf | grep asan
>         libasan.so.8 =3D> /lib64/libasan.so.8 (0x00007f8eb7a00000)
> root@x1:~#

