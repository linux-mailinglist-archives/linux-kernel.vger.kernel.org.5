Return-Path: <linux-kernel+bounces-143540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36668A3AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67611F23F93
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8B18E25;
	Sat, 13 Apr 2024 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMUyOg2v"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E8182B9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978743; cv=none; b=TT8OlIeDrqmn344Mpi7mwtIyGUOHscapZtJ1U8yZRLT5qL6j88hv5PpzqksI1E77/w5Sy/3fsuIvOe56a6ch5jxNs8NRNJE9qNlAKvpuVAp+g6VmQkEls8TSvMNR2j4v2Jyrhi73JTQU3fczik1Q9JSVvnZjpmvFqTMCp9o0SUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978743; c=relaxed/simple;
	bh=00qTM4jLkIBYqi7XCk6NoWEfDdaanVXt5Sy6uLOAnns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KECSqEasL/4O9SbveRJgWuYWWFS7AKM0UCK2wXEzcd3q7dfJj2MqEhkes1Oiollvr3cmcPsMbaBd+8VbbANXzEOU7Tqp5ih1QnSIx9DKCTNkvOwEtxZIK1uDReFZOPD8IF0/kPxCCfh+geOZ5qtcjbPFNeOd3FJUIEbmcQKzmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMUyOg2v; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36aff988d73so46115ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712978738; x=1713583538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQln+CYzpq5reAgOac89bcnR5R424YInQTdlwzF4cHg=;
        b=lMUyOg2vYxcMPFY16ne/LHv3rX6jn6JpPRs6+B5ROK0kQpVNDVaDGvCBoPxYCplNsi
         ea/R1XedC69yOhmQRIswH9OxbrVOkQaxqbZ7u113LZsDebxTY0tpJKbgiUwbK+oh7KD/
         /Go1jQPpnOUdxcXvl7RAwDnxzHsqbu0TITOLvV3PK7aYAE5aTNgAN8Cj1+oFBX1FTfNr
         gLNk26HyaS/gviMa+9cXvnoATNq6YwX6yT67Zb6QKLypUHfN/omIt+55zeTxviVd21K+
         UcxJwAxJdXhQR6Gol1fvYrwOw4/jpZf40ywmi1ZX1jLmorpgLOue04M4TeTOtxGK4GqO
         DOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712978738; x=1713583538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQln+CYzpq5reAgOac89bcnR5R424YInQTdlwzF4cHg=;
        b=Yp6lQf5dzkUCtWfBEKkyaOW/F/3QDv/OrVisEUkG1sjEeoogpg/nGy9l7ZxD9RtqKm
         +vgFyCNk+siJkYGNeqAbYf4uBTqil33TGyzxypsuSfw/cXfdsDmTBEPkTWzjl1L0EQdl
         706CVhi3Yvmatsg0MdYq0mr0pr3ETqvbB01C3gRJLfcxQjRXqJ9BzrK8lEpXasWK0p8i
         WeUQMnpOn5jdz+xtWBxil3aD6gsynscYJNPKik2AD1WiUgkSQAlEJ3lKXDuxeheOH1Ed
         xS1yS0G+xo46hiJmE3+9okp2BEGsfDjitA0Mes3oHhROTzHhTmwADZEM/TZi5CL9dFGY
         yVdg==
X-Forwarded-Encrypted: i=1; AJvYcCVceVVyBqUQTSF/7co0iLUI7/2oaxZW4nNUaUkvIOh3qb/FhXoQyJqTCt9ZY6NKoJz/ftIdICefnNBZtmcOCWaaw8Ztc1zyMKaJEg1r
X-Gm-Message-State: AOJu0YxXgkIEI02F9u0W/ZMyW4yG3lMLdqQTPtX4Y2XU3bi7Ma6dNslo
	FyZ9UXf3y3Liqqi5FkrF+kluSWlT5c+aTkbE6C1vGbuM4IywRZfXEALZVque4TVnVmu8oK+XpAu
	VvOu5v1hbdJ9mnjlf3/W55ABblc7mDGcSln8S
X-Google-Smtp-Source: AGHT+IGsi+COYCF3CPNkCwwfpdQZaEfQvUfaAgLyrZ2AK4Fssc3aVMk0e5CvtH7M74CybiReqbhVecXnhuse1VEPsbc=
X-Received: by 2002:a05:6e02:591:b0:36a:fcc9:64ec with SMTP id
 c17-20020a056e02059100b0036afcc964ecmr67680ils.1.1712978732489; Fri, 12 Apr
 2024 20:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhWTIuyB9p1ORbQH@x1> <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>
 <Zhgly2eQ5vk4FdEE@x1> <CAP-5=fVOR+9tEjn84Og-ZHSsNsfQcd7boLPrPv9cqdqtp8us1g@mail.gmail.com>
 <ZhlLq2SBPzNWQvcI@x1>
In-Reply-To: <ZhlLq2SBPzNWQvcI@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Apr 2024 20:25:17 -0700
Message-ID: <CAP-5=fVLZM3iGv-erx00xwvjJyxcPR-y6KxQnWp6nkH8FfFn5g@mail.gmail.com>
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid systems
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 7:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Apr 11, 2024 at 11:26:21AM -0700, Ian Rogers wrote:
> > On Thu, Apr 11, 2024 at 11:02=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > On Tue, Apr 09, 2024 at 02:28:43PM -0700, Ian Rogers wrote:
> > > > On Tue, Apr 9, 2024 at 12:12=E2=80=AFPM Arnaldo Carvalho de Melo <a=
cme@kernel.org> wrote:
> > > > > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > > > > model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> > > > > root@x1:~# uname -a
> > > > > Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27=
 16:50:39 UTC 2024 x86_64 GNU/Linux
> > > > > root@x1:~#
>
> > > > > Bisected down to:
>
> > > > > commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> > > > > Author: Ravi Bangoria <ravi.bangoria@amd.com>
> > > > > Date:   Thu Jun 15 10:47:00 2023 +0530
> > > > >
> > > > >     perf mem: Scan all PMUs instead of just core ones
> > > > >
> > > > >     Scanning only core PMUs is not sufficient on platforms like A=
MD since
> > > > >     perf mem on AMD uses IBS OP PMU, which is independent of core=
 PMU.
> > > > >     Scan all PMUs instead of just core PMUs. There should be negl=
igible
> > > > >     performance overhead because of scanning all PMUs, so we shou=
ld be okay.
> > > > >
> > > > >     Reviewed-by: Ian Rogers <irogers@google.com>
>
> > > > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > > > perf version 6.4.rc3.g5752c20f3787
> > > > > 111: Test data symbol                                            =
    :
> > > > > --- start ---
> > > > > test child forked, pid 522202
> > > > > Recording workload...
> > > > > malloc_consolidate(): invalid chunk size
> > > > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: lin=
e 60: 522208 Aborted                 (core dumped) perf mem record --all-us=
er -o ${PERF_DATA} -- $TEST_PROGRAM
> > > > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: lin=
e 62: kill: (522208) - No such process
> > > > > Cleaning up files...
> > > > > test child finished with -1
> > > > > ---- end ----
> > > > > Test data symbol: FAILED!
> > > > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > > > perf version 6.8.g63c22868714b
> > > > > 116: Test data symbol:
> > > > > --- start ---
> > > > > test child forked, pid 526540
> > > > >  954300-954339 l buf1
> > > > > perf does have symbol 'buf1'
> > > > > Recording workload...
> > > > > Waiting for "perf record has started" message
> > > > > OK
> > > > > Cleaning up files...
> > > > > ---- end(-1) ----
> > > > > 116: Test data symbol                                            =
    : FAILED!
> > > > > root@x1:~#
> > > > >
> > > > > Further details:
> > > > >
> > > > > (gdb) run mem record --all-user sleep 1
> > > > > Starting program: /root/bin/perf mem record --all-user sleep 1
> > > > >
> > > > >
> > > > > This GDB supports auto-downloading debuginfo from the following U=
RLs:
> > > > >   <https://debuginfod.fedoraproject.org/>
> > > > > Enable debuginfod for this session? (y or [n]) y
> > > > > Debuginfod has been enabled.
> > > > > To make this setting permanent, add 'set debuginfod enabled on' t=
o .gdbinit.
> > > > > [Thread debugging using libthread_db enabled]
> > > > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > > >
> > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > 0x0000000000611860 in perf_mem_events__record_args (rec_argv=3D0x=
ea8280, argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7fffffffd6=
c0) at util/mem-events.c:213
> > > > > 213                                     s =3D perf_mem_events__na=
me(j, pmu->name);
> > > > > (gdb) bt
> > > > > #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=
=3D0xea8280, argv_nr=3D0x7fffffffd6bc, rec_tmp=3D0xebbda0, tmp_nr=3D0x7ffff=
fffd6c0) at util/mem-events.c:213
> > > > > #1  0x000000000045c47f in __cmd_record (argc=3D2, argv=3D0x7fffff=
ffe420, mem=3D0x7fffffffda20) at builtin-mem.c:152
> > > > > #2  0x000000000045d69b in cmd_mem (argc=3D4, argv=3D0x7fffffffe42=
0) at builtin-mem.c:514
> > > > > #3  0x00000000004ffe38 in run_builtin (p=3D0xe08aa0 <commands+672=
>, argc=3D5, argv=3D0x7fffffffe420) at perf.c:323
> > > > > #4  0x00000000005000ac in handle_internal_command (argc=3D5, argv=
=3D0x7fffffffe420) at perf.c:377
> > > > > #5  0x00000000005001fb in run_argv (argcp=3D0x7fffffffe23c, argv=
=3D0x7fffffffe230) at perf.c:421
> > > > > #6  0x00000000005004e8 in main (argc=3D5, argv=3D0x7fffffffe420) =
at perf.c:537
> > > > > (gdb) list -5
> > > > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "??=
?"
> > > > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 l=
ines.
> > > > > (gdb)
> > >
> > > > >
> > > > >
> > > > > (gdb) list -5
> > > > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "??=
?"
> > > > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 l=
ines.
> > > > > (gdb) p j
> > > > > $1 =3D 0
> > > > > (gdb) p pmu->name
> > > > > Cannot access memory at address 0x64ffffff9c
> > > > > (gdb)
> > > > >
> > > > > 183 int perf_mem_events__record_args(const char **rec_argv, int *=
argv_nr,
> > > > > 184                                  char **rec_tmp, int *tmp_nr)
> > > > > 185 {
> > > > > 186         int i =3D *argv_nr, k =3D 0;
> > > > > 187         struct perf_mem_event *e;
> > > > > 188         struct perf_pmu *pmu;
> > > > > 189         char *s;
> > > > > 190
> > > > > 191         for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > > > > 192                 e =3D perf_mem_events__ptr(j);
> > > > > 193                 if (!e->record)
> > > > > 194                         continue;
> > > > > 195
> > > > > 196                 if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> > > > > 197                         if (!e->supported) {
> > > > > 198                                 pr_err("failed: event '%s' no=
t supported\n",
> > > > > 199                                        perf_mem_events__name(=
j, NULL));
> > > > > 200                                 return -1;
> > > > > 201                         }
> > > > > 202
> > > > > 203                         rec_argv[i++] =3D "-e";
> > > > > 204                         rec_argv[i++] =3D perf_mem_events__na=
me(j, NULL);
> > > > > 205                 } else {
> > > > > 206                         if (!e->supported) {
> > > > > 207                                 perf_mem_events__print_unsupp=
ort_hybrid(e, j);
> > > > > 208                                 return -1;
> > > > > 209                         }
> > > > > 210
> > > > > 211                         while ((pmu =3D perf_pmus__scan(pmu))=
 !=3D NULL) {
> > > > > 212                                 rec_argv[i++] =3D "-e";
> > > > > 213                                 s =3D perf_mem_events__name(j=
, pmu->name);
> > > > > 214                                 if (s) {
> > > > > 215                                         s =3D strdup(s);
> > > >
> > > > This looks like something that address/memory sanitizers could help=
 with.
> > >
> > > I'm I forgetting something?
> >
> > I think it is just that the shell script pipes the output and so we
> > don't see it in verbose mode. I'd add a "set -x" to
> > tools/perf/tests/shell/test_data_symbol.sh so you can run the failing
> > command without the redirects/pipes/..
>
> With just -x its a lot of:
>
> root@x1:~# perf test -v "Test data symbol"
> 116: Test data symbol:
> --- start ---
> test child forked, pid 714006
> ++ dirname /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh
> + shelldir=3D/home/acme/libexec/perf-core/tests/shell
> + . /home/acme/libexec/perf-core/tests/shell/lib/waiting.sh
> ++ tenths=3D'date +%s%1N'
> + . /home/acme/libexec/perf-core/tests/shell/lib/perf_has_symbol.sh
> + skip_if_no_mem_event
> + perf mem record -e list
> + grep -E -q available
> + return 0
> + skip_test_missing_symbol buf1
> + perf_has_symbol buf1
> + perf test -vv -F Symbols
> + grep '[[:space:]]buf1$'
>  f87540-f87579 l buf1
> + echo 'perf does have symbol '\''buf1'\'''
> perf does have symbol 'buf1'
> + return 0
> + return 0
> + TEST_PROGRAM=3D'perf test -w datasym'
> ++ mktemp /tmp/__perf_test.perf.data.XXXXX
> + PERF_DATA=3D/tmp/__perf_test.perf.data.EXZvV
> ++ mktemp /tmp/__perf_test.stderr.XXXXX
> + ERR_FILE=3D/tmp/__perf_test.stderr.cZ5f6
> + trap cleanup_files exit term int
> + echo 'Recording workload...'
> Recording workload...
> ++ grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo
> + is_amd=3D0
> + (( 0 >=3D 1 ))
> + PERFPID=3D714019
> + wait_for_perf_to_start 714019 /tmp/__perf_test.stderr.cZ5f6
> + tm_out=3D
> + '[' -n '' ']'
> + tm_out=3D50
> + echo 'Waiting for "perf record has started" message'
> Waiting for "perf record has started" message
> + perf mem record -vvv --all-user -o /tmp/__perf_test.perf.data.EXZvV -- =
perf test -w datasym
> ++ date +%s%1N
> + start_time=3D17129328403
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
> ++ date +%s%1N
> + '[' 0 -ge 50 ']'
> + '[' -e /proc/714019 ']'
> + grep -q 'perf record has started' /
>
> Then trying manually the commands that have redirections in that script:
>
> root@x1:~# perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> root@x1:~#
>
> Collecting a perf data:
>
> root@x1:~# perf mem record -vvv --all-user perf test -w datasym
> calling: record -e cpu_atom/mem-loads,ldlat=3D30/P -e cpu_atom/mem-stores=
/P
> Attempt to add: cpu_atom/mem-loads,ldlat=3D0x1e/
> ..after resolving event: cpu_atom/event=3D0xd0,umask=3D0x5,ldlat=3D0x3,ld=
lat=3D0x1e/
> Attempt to add: cpu_atom/mem-stores/
> ..after resolving event: cpu_atom/event=3D0xd0,umask=3D0x6/
> DEBUGINFOD_URLS=3D
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> Opening: cpu/cycles/:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xa00000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 5
> Opening: cpu/cycles/:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0x400000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 6
> perf record opening and mmapping events
> Opening: cpu_atom/mem-loads,ldlat=3D30/P
> ------------------------------------------------------------
> perf_event_attr:
>   type                             10 (cpu_atom)
>   size                             136
>   config                           0x5d0 (mem-loads)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DAT=
A_SRC|WEIGHT_STRUCT
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   exclude_kernel                   1
>   freq                             1
>   enable_on_exec                   1
>   precise_ip                       3
>   sample_id_all                    1
>   { bp_addr, config1 }             0x1f
> ------------------------------------------------------------
> sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 =3D 7
> sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 =3D 9
> sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 =3D 10
> sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 =3D 11
> sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 =3D 12
> sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 =3D 13
> sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 =3D 14
> sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 =3D 15
> Opening: cpu_atom/mem-stores/P
> ------------------------------------------------------------
> perf_event_attr:
>   type                             10 (cpu_atom)
>   size                             136
>   config                           0x6d0 (mem-stores)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DAT=
A_SRC|WEIGHT_STRUCT
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   exclude_kernel                   1
>   freq                             1
>   enable_on_exec                   1
>   precise_ip                       3
>   sample_id_all                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 =3D 16
> sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 =3D 17
> sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 =3D 18
> sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 =3D 19
> sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 =3D 20
> sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 =3D 21
> sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 =3D 22
> sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 =3D 23
> Opening: dummy:u
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1 (software)
>   size                             136
>   config                           0x9 (PERF_COUNT_SW_DUMMY)
>   { sample_period, sample_freq }   1
>   sample_type                      IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|W=
EIGHT_STRUCT
>   read_format                      ID|LOST
>   inherit                          1
>   exclude_kernel                   1
>   exclude_hv                       1
>   mmap                             1
>   comm                             1
>   task                             1
>   mmap_data                        1
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid 715368  cpu 0  group_fd -1  flags 0x8 =3D 24
> sys_perf_event_open: pid 715368  cpu 1  group_fd -1  flags 0x8 =3D 25
> sys_perf_event_open: pid 715368  cpu 2  group_fd -1  flags 0x8 =3D 26
> sys_perf_event_open: pid 715368  cpu 3  group_fd -1  flags 0x8 =3D 27
> sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 =3D 28
> sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 =3D 29
> sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 =3D 30
> sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 =3D 31
> sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 =3D 32
> sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 =3D 33
> sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 =3D 34
> sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 =3D 35
> mmap size 528384B
> libperf: mmap_per_cpu: nr cpu values 12 nr threads 1
> libperf: idx 0: mmapping fd 24
> libperf: idx 1: mmapping fd 25
> libperf: idx 2: mmapping fd 26
> libperf: idx 3: mmapping fd 27
> libperf: idx 4: mmapping fd 7
> libperf: idx 4: set output fd 16 -> 7
> libperf: idx 4: set output fd 28 -> 7
> libperf: idx 5: mmapping fd 9
> libperf: idx 5: set output fd 17 -> 9
> libperf: idx 5: set output fd 29 -> 9
> libperf: idx 6: mmapping fd 10
> libperf: idx 6: set output fd 18 -> 10
> libperf: idx 6: set output fd 30 -> 10
> libperf: idx 7: mmapping fd 11
> libperf: idx 7: set output fd 19 -> 11
> libperf: idx 7: set output fd 31 -> 11
> libperf: idx 8: mmapping fd 12
> libperf: idx 8: set output fd 20 -> 12
> libperf: idx 8: set output fd 32 -> 12
> libperf: idx 9: mmapping fd 13
> libperf: idx 9: set output fd 21 -> 13
> libperf: idx 9: set output fd 33 -> 13
> libperf: idx 10: mmapping fd 14
> libperf: idx 10: set output fd 22 -> 14
> libperf: idx 10: set output fd 34 -> 14
> libperf: idx 11: mmapping fd 15
> libperf: idx 11: set output fd 23 -> 15
> libperf: idx 11: set output fd 35 -> 15
> Control descriptor is not initialized
> thread_data[0x60d000001700]: nr_mmaps=3D12, maps=3D0x608000004a20, ow_map=
s=3D(nil)
> thread_data[0x60d000001700]: cpu0: maps[0] -> mmap[0]
> thread_data[0x60d000001700]: cpu1: maps[1] -> mmap[1]
> thread_data[0x60d000001700]: cpu2: maps[2] -> mmap[2]
> thread_data[0x60d000001700]: cpu3: maps[3] -> mmap[3]
> thread_data[0x60d000001700]: cpu4: maps[4] -> mmap[4]
> thread_data[0x60d000001700]: cpu5: maps[5] -> mmap[5]
> thread_data[0x60d000001700]: cpu6: maps[6] -> mmap[6]
> thread_data[0x60d000001700]: cpu7: maps[7] -> mmap[7]
> thread_data[0x60d000001700]: cpu8: maps[8] -> mmap[8]
> thread_data[0x60d000001700]: cpu9: maps[9] -> mmap[9]
> thread_data[0x60d000001700]: cpu10: maps[10] -> mmap[10]
> thread_data[0x60d000001700]: cpu11: maps[11] -> mmap[11]
> thread_data[0x60d000001700]: pollfd[0] <- event_fd=3D24
> thread_data[0x60d000001700]: pollfd[1] <- event_fd=3D25
> thread_data[0x60d000001700]: pollfd[2] <- event_fd=3D26
> thread_data[0x60d000001700]: pollfd[3] <- event_fd=3D27
> thread_data[0x60d000001700]: pollfd[4] <- event_fd=3D7
> thread_data[0x60d000001700]: pollfd[5] <- event_fd=3D16
> thread_data[0x60d000001700]: pollfd[6] <- event_fd=3D28
> thread_data[0x60d000001700]: pollfd[7] <- event_fd=3D9
> thread_data[0x60d000001700]: pollfd[8] <- event_fd=3D17
> thread_data[0x60d000001700]: pollfd[9] <- event_fd=3D29
> thread_data[0x60d000001700]: pollfd[10] <- event_fd=3D10
> thread_data[0x60d000001700]: pollfd[11] <- event_fd=3D18
> thread_data[0x60d000001700]: pollfd[12] <- event_fd=3D30
> thread_data[0x60d000001700]: pollfd[13] <- event_fd=3D11
> thread_data[0x60d000001700]: pollfd[14] <- event_fd=3D19
> thread_data[0x60d000001700]: pollfd[15] <- event_fd=3D31
> thread_data[0x60d000001700]: pollfd[16] <- event_fd=3D12
> thread_data[0x60d000001700]: pollfd[17] <- event_fd=3D20
> thread_data[0x60d000001700]: pollfd[18] <- event_fd=3D32
> thread_data[0x60d000001700]: pollfd[19] <- event_fd=3D13
> thread_data[0x60d000001700]: pollfd[20] <- event_fd=3D21
> thread_data[0x60d000001700]: pollfd[21] <- event_fd=3D33
> thread_data[0x60d000001700]: pollfd[22] <- event_fd=3D14
> thread_data[0x60d000001700]: pollfd[23] <- event_fd=3D22
> thread_data[0x60d000001700]: pollfd[24] <- event_fd=3D34
> thread_data[0x60d000001700]: pollfd[25] <- event_fd=3D15
> thread_data[0x60d000001700]: pollfd[26] <- event_fd=3D23
> thread_data[0x60d000001700]: pollfd[27] <- event_fd=3D35
> thread_data[0x60d000001700]: pollfd[28] <- non_perf_event fd=3D4
> perf record done opening and mmapping events
> Opening: dummy:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1 (software)
>   size                             136
>   config                           0x9 (PERF_COUNT_SW_DUMMY)
>   watermark                        1
>   sample_id_all                    1
>   bpf_event                        1
>   { wakeup_events, wakeup_watermark } 1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 36
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 37
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 38
> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 =3D 39
> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 =3D 40
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 =3D 41
> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 =3D 42
> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 =3D 43
> sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 =3D 44
> sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 =3D 45
> sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 =3D 46
> sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 =3D 47
> mmap size 528384B
> libperf: mmap_per_cpu: nr cpu values 12 nr threads 1
> libperf: idx 0: mmapping fd 36
> libperf: idx 1: mmapping fd 37
> libperf: idx 2: mmapping fd 38
> libperf: idx 3: mmapping fd 39
> libperf: idx 4: mmapping fd 40
> libperf: idx 5: mmapping fd 41
> libperf: idx 6: mmapping fd 42
> libperf: idx 7: mmapping fd 43
> libperf: idx 8: mmapping fd 44
> libperf: idx 9: mmapping fd 45
> libperf: idx 10: mmapping fd 46
> libperf: idx 11: mmapping fd 47
> Synthesizing TSC conversion information
> Synthesizing id index
> perf record has started
>
>
> ^C[ perf record: Woken up 1 times to write data ]
> overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for=
 more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more i=
nfo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
> overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
> overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info=
)
> overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info=
)
> overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info=
)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for mo=
re info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
> overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
> overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
> overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more i=
nfo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more in=
fo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more in=
fo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more=
 info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more =
info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
> overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
> overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for=
 more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more in=
fo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for mo=
re info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for m=
ore info)
> overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for m=
ore info)
> overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for m=
ore info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for mor=
e info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more inf=
o)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
> overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
> overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more i=
nfo)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more =
info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
> overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
> overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info=
)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
> overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
> overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
> overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for mor=
e info)
> overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for m=
ore info)
> overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info=
)
> overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info=
)
> overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
> overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
> overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for=
 more info)
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more =
info)
> overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui fo=
r more info)
> overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more inf=
o)
> overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
> overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more=
 info)
> overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more in=
fo)
> overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for mo=
re info)
> overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more i=
nfo)
> overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for=
 more info)
> overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more inf=
o)
> overlapping maps in /home/acme/bin/perf (disable tui for more info)
> overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more=
 info)
> <SNIP lots of>
> overlapping maps in //anon (disable tui for more info)
> overlapping maps in //anon (disable tui for more info)
> Downloading debug info with build id 8957b3556da9752d88d5e97203ca82a6d7cd=
8440
> symbol:test_target file:(null) line:0 offset:0 return:0 lazy:(null)
> Downloading debug info with build id 72308a603a383d464946114b8a572b98b44e=
1b44
> symbol:unmap_start file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:unmap_complete file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:map_start file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:reloc_start file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:map_complete file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:reloc_complete file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:init_start file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:init_complete file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:lll_lock_wait_private file:(null) line:0 offset:0 return:0 lazy:(n=
ull)
> symbol:lll_lock_wait file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:setjmp file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:longjmp file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:longjmp_target file:(null) line:0 offset:0 return:0 lazy:(null)
> failed to write feature CPU_PMU_CAPS
> [ perf record: Captured and wrote 0.074 MB perf.data (163 samples) ]
>
> root@x1:~#
>
> root@x1:~# ls -la perf.data
> -rw-------. 1 root root 107670 Apr 12 11:45 perf.data
> root@x1:~# perf evlist
> cpu_atom/mem-loads,ldlat=3D30/P
> cpu_atom/mem-stores/P
> dummy:u
> root@x1:~# perf evlist -v
> cpu_atom/mem-loads,ldlat=3D30/P: type: 10 (cpu_atom), size: 136, config: =
0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TI=
D|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST,=
 disabled: 1, inherit: 1, exclude_kernel: 1, freq: 1, enable_on_exec: 1, pr=
ecise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
> cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem=
-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|AD=
DR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled=
: 1, inherit: 1, exclude_kernel: 1, freq: 1, enable_on_exec: 1, precise_ip:=
 3, sample_id_all: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY)=
, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFI=
ER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel=
: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all:=
 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> root@x1:~#
>
> Finally:
>
> root@x1:~# perf mem report -s symbol_daddr -q > /tmp/bla
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D715700=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 80 byte(s) in 10 object(s) allocated from:
>     #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x6f696f in sample__resolve_mem (/home/acme/bin/perf+0x6f696f) (Bu=
ildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x77e187 in iter_prepare_mem_entry (/home/acme/bin/perf+0x77e187) =
(BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x7894cc in hist_entry_iter__add (/home/acme/bin/perf+0x7894cc) (B=
uildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x45b32e in process_sample_event (/home/acme/bin/perf+0x45b32e) (B=
uildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e=
207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x71=
31ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: =
8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)

Memory is stashed into a priv field here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hist.c#n828
There is a comment saying that clean up isn't necessary:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hist.c#n884
but it seems something has broken that.

>
> Direct leak of 37 byte(s) in 1 object(s) allocated from:
>     #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x7feb378a0b77 in __vasprintf_internal (/lib64/libc.so.6+0x82b77) =
(BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #2 0x7feb38a9712f in __interceptor_vasprintf (/lib64/libasan.so.8+0x9=
712f) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #3 0x7feb38a9768e in __interceptor_asprintf (/lib64/libasan.so.8+0x97=
68e) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
>
> Indirect leak of 29612 byte(s) in 451 object(s) allocated from:
>     #0 0x7feb38ad8cc7 in calloc (/lib64/libasan.so.8+0xd8cc7) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)iter_prepare_mem_entry
>     #1 0x69e2cc in symbol__new (/home/acme/bin/perf+0x69e2cc) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x8bff08 in dso__load_sym_internal (/home/acme/bin/perf+0x8bff08) =
(BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x8c11d5 in dso__load_sym (/home/acme/bin/perf+0x8c11d5) (BuildId:=
 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x6a2798 in dso__load (/home/acme/bin/perf+0x6a2798) (BuildId: 895=
7b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x6fc19a in map__find_symbol (/home/acme/bin/perf+0x6fc19a) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x63936a in machine__resolve (/home/acme/bin/perf+0x63936a) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x45af8e in process_sample_event (/home/acme/bin/perf+0x45af8e) (B=
uildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e=
207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7=
131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957=
b3556da9752d88d5e97203ca82a6d7cd8440)
>     #13 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: =
8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #14 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #15 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #16 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #17 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #18 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> Indirect leak of 472 byte(s) in 1 object(s) allocated from:
>     #0 0x7feb38ad8cc7 in calloc (/lib64/libasan.so.8+0xd8cc7) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x6949ce in dso__new_id (/home/acme/bin/perf+0x6949ce) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x6989aa in dsos__findnew_id (/home/acme/bin/perf+0x6989aa) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x6b36af in __event_process_build_id.isra.0 (/home/acme/bin/perf+0=
x6b36af) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x6b3c26 in perf_header__read_build_ids (/home/acme/bin/perf+0x6b3=
c26) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x6b42e6 in process_build_id (/home/acme/bin/perf+0x6b42e6) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x6d1412 in perf_session__read_header (/home/acme/bin/perf+0x6d141=
2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x710442 in __perf_session__new (/home/acme/bin/perf+0x710442) (Bu=
ildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x46234d in cmd_report (/home/acme/bin/perf+0x46234d) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: =
8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> Indirect leak of 112 byte(s) in 2 object(s) allocated from:
>     #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x6fa213 in map__new (/home/acme/bin/perf+0x6fa213) (BuildId: 8957=
b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x6f4cf3 in machine__process_mmap2_event (/home/acme/bin/perf+0x6f=
4cf3) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e=
207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x71=
31ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #12 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #13 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> Indirect leak of 69 byte(s) in 1 object(s) allocated from:
>     #0 0x7feb38a814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x6a328f in dso__load (/home/acme/bin/perf+0x6a328f) (BuildId: 895=
7b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x6fc19a in map__find_symbol (/home/acme/bin/perf+0x6fc19a) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x63936a in machine__resolve (/home/acme/bin/perf+0x63936a) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x45af8e in process_sample_event (/home/acme/bin/perf+0x45af8e) (B=
uildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e=
207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x71=
31ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: =
8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> Indirect leak of 21 byte(s) in 1 object(s) allocated from:
>     #0 0x7feb38a814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x696d79 in dso__set_basename (/home/acme/bin/perf+0x696d79) (Buil=
dId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x698a44 in dsos__findnew_id (/home/acme/bin/perf+0x698a44) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x6b36af in __event_process_build_id.isra.0 (/home/acme/bin/perf+0=
x6b36af) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x6b3c26 in perf_header__read_build_ids (/home/acme/bin/perf+0x6b3=
c26) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x6b42e6 in process_build_id (/home/acme/bin/perf+0x6b42e6) (Build=
Id: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x6d1412 in perf_session__read_header (/home/acme/bin/perf+0x6d141=
2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x710442 in __perf_session__new (/home/acme/bin/perf+0x710442) (Bu=
ildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x46234d in cmd_report (/home/acme/bin/perf+0x46234d) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: =
8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> Indirect leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x71e0e6 in nsinfo__get (/home/acme/bin/perf+0x71e0e6) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x6fa3c5 in map__new (/home/acme/bin/perf+0x6fa3c5) (BuildId: 8957=
b3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x6f4cf3 in machine__process_mmap2_event (/home/acme/bin/perf+0x6f=
4cf3) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e=
207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x71=
31ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #7 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 89=
57b3556da9752d88d5e97203ca82a6d7cd8440)
>     #8 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #9 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #10 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291=
) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #11 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b35=
56da9752d88d5e97203ca82a6d7cd8440)
>     #12 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x2814=
9) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #13 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820=
a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #14 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>
> SUMMARY: AddressSanitizer: 30411 byte(s) leaked in 468 allocation(s).
> root@x1:~#
>
> But then, tring with what I have in tmp.perf-tools-next I get:
>
> root@x1:~# perf mem record --all-user sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.008 MB perf.data ]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D718348=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 52 byte(s) in 2 object(s) allocated from:
>     #0 0x7f5657c814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x87b46d in perf_mem_events__record_args (/home/acme/bin/perf+0x87=
b46d) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #2 0x4c3e04 in cmd_mem (/home/acme/bin/perf+0x4c3e04) (BuildId: 8957b=
3556da9752d88d5e97203ca82a6d7cd8440)
>     #3 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8=
957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #4 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291)=
 (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
>     #5 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b355=
6da9752d88d5e97203ca82a6d7cd8440)
>     #6 0x7f5656a46149 in __libc_start_call_main (/lib64/libc.so.6+0x28149=
) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #7 0x7f5656a4620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a=
) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #8 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3=
556da9752d88d5e97203ca82a6d7cd8440)

This is a real leak:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n261
the record args probably all need to be strdup-ed and then each array
entry freed when the array is freed.

Thanks,
Ian

> Direct leak of 37 byte(s) in 1 object(s) allocated from:
>     #0 0x7f5657cd92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2=
b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #1 0x7f5656aa0b77 in __vasprintf_internal (/lib64/libc.so.6+0x82b77) =
(BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
>     #2 0x7f5657c9712f in __interceptor_vasprintf (/lib64/libasan.so.8+0x9=
712f) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
>     #3 0x7f5657c9768e in __interceptor_asprintf (/lib64/libasan.so.8+0x97=
68e) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
>
> SUMMARY: AddressSanitizer: 89 byte(s) leaked in 3 allocation(s).
> root@x1:~#
>
> For the command that was segfaulting... /me scratches head...
>
> - Arnaldo

