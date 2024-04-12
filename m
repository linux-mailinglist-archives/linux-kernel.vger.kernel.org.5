Return-Path: <linux-kernel+bounces-142885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5E8A31A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E72D1C22FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7C1474AD;
	Fri, 12 Apr 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTzUuYI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE213DDAC;
	Fri, 12 Apr 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933808; cv=none; b=Q9+gKWCNfhDIPEximU/8EdqrGsJF7T1bKI48k2Zfn0cuv1yeBqE2yz7rGCHFSh2uKK9dw2At3dQGy2CpJKkLe0yeTiLQaEDt/+9Lo8jxrb8M7Q0NS4vovDlzjZ8I5/zuMQVsB1lLhQhzXoPgO4TrwL6vrZNdqXSFlPkId66cq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933808; c=relaxed/simple;
	bh=SkyeDstIUvOfUScH7iRUlVv823YXfAATfSnKmo++N5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxi4mHQSg/Jme6A/CadtaeUFopnvsYKC2DFLb0xkPo3VS8Vgw2uq9SxK8vIHNE/gYTXsND2w81Z9Oox5NQJFrmWsaYUrnsBj7+anqdZxO2tU7+HOo2ipj1XEo22n7Mhn10cBeOwhcHdTzXIOgl6vcgUKFvSYR6frBj0WhcOjNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTzUuYI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9EDC113CC;
	Fri, 12 Apr 2024 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933807;
	bh=SkyeDstIUvOfUScH7iRUlVv823YXfAATfSnKmo++N5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTzUuYI3ArGRlrTvV+JpJVL4HwfXPyDFFBWse1Fq3Q3M498HtUFmbChjbiMIwQdNl
	 UbFwW5otRUJr9XRX6jTSudD3rxViJVGId+wOI16nKyRzYBTVL26yfEJdTpme/3uPGc
	 bqKxKTc4SZQHXh6aWB+Oi5X6fp/fHhLLCd2n8HEITdgTpGE3+Jg/d35jqumG0aj57o
	 vfjrD/UBkF6fD8cZ6sFz4Z1KgytUg3WmcTngTamIpwoIzfiH7lCTdmrnpcpE9tFgVu
	 +mTGiwZHXBpNess5KZOWTye25wgsm9Mvd4SjGrndW6wR0xre0+Cx4/JM6hFV9TNNXV
	 70jVDvvD1n8qw==
Date: Fri, 12 Apr 2024 11:56:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linux.dev>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel
 Hybrid systems
Message-ID: <ZhlLq2SBPzNWQvcI@x1>
References: <ZhWTIuyB9p1ORbQH@x1>
 <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>
 <Zhgly2eQ5vk4FdEE@x1>
 <CAP-5=fVOR+9tEjn84Og-ZHSsNsfQcd7boLPrPv9cqdqtp8us1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVOR+9tEjn84Og-ZHSsNsfQcd7boLPrPv9cqdqtp8us1g@mail.gmail.com>

On Thu, Apr 11, 2024 at 11:26:21AM -0700, Ian Rogers wrote:
> On Thu, Apr 11, 2024 at 11:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Tue, Apr 09, 2024 at 02:28:43PM -0700, Ian Rogers wrote:
> > > On Tue, Apr 9, 2024 at 12:12 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > > > model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> > > > root@x1:~# uname -a
> > > > Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
> > > > root@x1:~#

> > > > Bisected down to:

> > > > commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> > > > Author: Ravi Bangoria <ravi.bangoria@amd.com>
> > > > Date:   Thu Jun 15 10:47:00 2023 +0530
> > > >
> > > >     perf mem: Scan all PMUs instead of just core ones
> > > >
> > > >     Scanning only core PMUs is not sufficient on platforms like AMD since
> > > >     perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
> > > >     Scan all PMUs instead of just core PMUs. There should be negligible
> > > >     performance overhead because of scanning all PMUs, so we should be okay.
> > > >
> > > >     Reviewed-by: Ian Rogers <irogers@google.com>

> > > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > > perf version 6.4.rc3.g5752c20f3787
> > > > 111: Test data symbol                                                :
> > > > --- start ---
> > > > test child forked, pid 522202
> > > > Recording workload...
> > > > malloc_consolidate(): invalid chunk size
> > > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60: 522208 Aborted                 (core dumped) perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM
> > > > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62: kill: (522208) - No such process
> > > > Cleaning up files...
> > > > test child finished with -1
> > > > ---- end ----
> > > > Test data symbol: FAILED!
> > > > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > > > perf version 6.8.g63c22868714b
> > > > 116: Test data symbol:
> > > > --- start ---
> > > > test child forked, pid 526540
> > > >  954300-954339 l buf1
> > > > perf does have symbol 'buf1'
> > > > Recording workload...
> > > > Waiting for "perf record has started" message
> > > > OK
> > > > Cleaning up files...
> > > > ---- end(-1) ----
> > > > 116: Test data symbol                                                : FAILED!
> > > > root@x1:~#
> > > >
> > > > Further details:
> > > >
> > > > (gdb) run mem record --all-user sleep 1
> > > > Starting program: /root/bin/perf mem record --all-user sleep 1
> > > >
> > > >
> > > > This GDB supports auto-downloading debuginfo from the following URLs:
> > > >   <https://debuginfod.fedoraproject.org/>
> > > > Enable debuginfod for this session? (y or [n]) y
> > > > Debuginfod has been enabled.
> > > > To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > >
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > 0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> > > > 213                                     s = perf_mem_events__name(j, pmu->name);
> > > > (gdb) bt
> > > > #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> > > > #1  0x000000000045c47f in __cmd_record (argc=2, argv=0x7fffffffe420, mem=0x7fffffffda20) at builtin-mem.c:152
> > > > #2  0x000000000045d69b in cmd_mem (argc=4, argv=0x7fffffffe420) at builtin-mem.c:514
> > > > #3  0x00000000004ffe38 in run_builtin (p=0xe08aa0 <commands+672>, argc=5, argv=0x7fffffffe420) at perf.c:323
> > > > #4  0x00000000005000ac in handle_internal_command (argc=5, argv=0x7fffffffe420) at perf.c:377
> > > > #5  0x00000000005001fb in run_argv (argcp=0x7fffffffe23c, argv=0x7fffffffe230) at perf.c:421
> > > > #6  0x00000000005004e8 in main (argc=5, argv=0x7fffffffe420) at perf.c:537
> > > > (gdb) list -5
> > > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> > > > (gdb)
> >
> > > >
> > > >
> > > > (gdb) list -5
> > > > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > > > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> > > > (gdb) p j
> > > > $1 = 0
> > > > (gdb) p pmu->name
> > > > Cannot access memory at address 0x64ffffff9c
> > > > (gdb)
> > > >
> > > > 183 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> > > > 184                                  char **rec_tmp, int *tmp_nr)
> > > > 185 {
> > > > 186         int i = *argv_nr, k = 0;
> > > > 187         struct perf_mem_event *e;
> > > > 188         struct perf_pmu *pmu;
> > > > 189         char *s;
> > > > 190
> > > > 191         for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > > > 192                 e = perf_mem_events__ptr(j);
> > > > 193                 if (!e->record)
> > > > 194                         continue;
> > > > 195
> > > > 196                 if (perf_pmus__num_mem_pmus() == 1) {
> > > > 197                         if (!e->supported) {
> > > > 198                                 pr_err("failed: event '%s' not supported\n",
> > > > 199                                        perf_mem_events__name(j, NULL));
> > > > 200                                 return -1;
> > > > 201                         }
> > > > 202
> > > > 203                         rec_argv[i++] = "-e";
> > > > 204                         rec_argv[i++] = perf_mem_events__name(j, NULL);
> > > > 205                 } else {
> > > > 206                         if (!e->supported) {
> > > > 207                                 perf_mem_events__print_unsupport_hybrid(e, j);
> > > > 208                                 return -1;
> > > > 209                         }
> > > > 210
> > > > 211                         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> > > > 212                                 rec_argv[i++] = "-e";
> > > > 213                                 s = perf_mem_events__name(j, pmu->name);
> > > > 214                                 if (s) {
> > > > 215                                         s = strdup(s);
> > >
> > > This looks like something that address/memory sanitizers could help with.
> >
> > I'm I forgetting something?
> 
> I think it is just that the shell script pipes the output and so we
> don't see it in verbose mode. I'd add a "set -x" to
> tools/perf/tests/shell/test_data_symbol.sh so you can run the failing
> command without the redirects/pipes/..

With just -x its a lot of:

root@x1:~# perf test -v "Test data symbol"
116: Test data symbol:
--- start ---
test child forked, pid 714006
++ dirname /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh
+ shelldir=/home/acme/libexec/perf-core/tests/shell
+ . /home/acme/libexec/perf-core/tests/shell/lib/waiting.sh
++ tenths='date +%s%1N'
+ . /home/acme/libexec/perf-core/tests/shell/lib/perf_has_symbol.sh
+ skip_if_no_mem_event
+ perf mem record -e list
+ grep -E -q available
+ return 0
+ skip_test_missing_symbol buf1
+ perf_has_symbol buf1
+ perf test -vv -F Symbols
+ grep '[[:space:]]buf1$'
 f87540-f87579 l buf1
+ echo 'perf does have symbol '\''buf1'\'''
perf does have symbol 'buf1'
+ return 0
+ return 0
+ TEST_PROGRAM='perf test -w datasym'
++ mktemp /tmp/__perf_test.perf.data.XXXXX
+ PERF_DATA=/tmp/__perf_test.perf.data.EXZvV
++ mktemp /tmp/__perf_test.stderr.XXXXX
+ ERR_FILE=/tmp/__perf_test.stderr.cZ5f6
+ trap cleanup_files exit term int
+ echo 'Recording workload...'
Recording workload...
++ grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo
+ is_amd=0
+ (( 0 >= 1 ))
+ PERFPID=714019
+ wait_for_perf_to_start 714019 /tmp/__perf_test.stderr.cZ5f6
+ tm_out=
+ '[' -n '' ']'
+ tm_out=50
+ echo 'Waiting for "perf record has started" message'
Waiting for "perf record has started" message
+ perf mem record -vvv --all-user -o /tmp/__perf_test.perf.data.EXZvV -- perf test -w datasym
++ date +%s%1N
+ start_time=17129328403
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /tmp/__perf_test.stderr.cZ5f6
++ date +%s%1N
+ '[' 0 -ge 50 ']'
+ '[' -e /proc/714019 ']'
+ grep -q 'perf record has started' /

Then trying manually the commands that have redirections in that script:

root@x1:~# perf mem record -e list
ldlat-loads  : available
ldlat-stores : available
root@x1:~#

Collecting a perf data:

root@x1:~# perf mem record -vvv --all-user perf test -w datasym
calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P 
Attempt to add: cpu_atom/mem-loads,ldlat=0x1e/
.after resolving event: cpu_atom/event=0xd0,umask=0x5,ldlat=0x3,ldlat=0x1e/
Attempt to add: cpu_atom/mem-stores/
.after resolving event: cpu_atom/event=0xd0,umask=0x6/
DEBUGINFOD_URLS=
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
Opening: cpu/cycles/:HG
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
Opening: cpu/cycles/:HG
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x400000000
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 6
perf record opening and mmapping events
Opening: cpu_atom/mem-loads,ldlat=30/P
------------------------------------------------------------
perf_event_attr:
  type                             10 (cpu_atom)
  size                             136
  config                           0x5d0 (mem-loads)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  freq                             1
  enable_on_exec                   1
  precise_ip                       3
  sample_id_all                    1
  { bp_addr, config1 }             0x1f
------------------------------------------------------------
sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 = 15
Opening: cpu_atom/mem-stores/P
------------------------------------------------------------
perf_event_attr:
  type                             10 (cpu_atom)
  size                             136
  config                           0x6d0 (mem-stores)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  freq                             1
  enable_on_exec                   1
  precise_ip                       3
  sample_id_all                    1
------------------------------------------------------------
sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 = 23
Opening: dummy:u
------------------------------------------------------------
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0x9 (PERF_COUNT_SW_DUMMY)
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
  read_format                      ID|LOST
  inherit                          1
  exclude_kernel                   1
  exclude_hv                       1
  mmap                             1
  comm                             1
  task                             1
  mmap_data                        1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 715368  cpu 0  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid 715368  cpu 1  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid 715368  cpu 2  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid 715368  cpu 3  group_fd -1  flags 0x8 = 27
sys_perf_event_open: pid 715368  cpu 4  group_fd -1  flags 0x8 = 28
sys_perf_event_open: pid 715368  cpu 5  group_fd -1  flags 0x8 = 29
sys_perf_event_open: pid 715368  cpu 6  group_fd -1  flags 0x8 = 30
sys_perf_event_open: pid 715368  cpu 7  group_fd -1  flags 0x8 = 31
sys_perf_event_open: pid 715368  cpu 8  group_fd -1  flags 0x8 = 32
sys_perf_event_open: pid 715368  cpu 9  group_fd -1  flags 0x8 = 33
sys_perf_event_open: pid 715368  cpu 10  group_fd -1  flags 0x8 = 34
sys_perf_event_open: pid 715368  cpu 11  group_fd -1  flags 0x8 = 35
mmap size 528384B
libperf: mmap_per_cpu: nr cpu values 12 nr threads 1
libperf: idx 0: mmapping fd 24
libperf: idx 1: mmapping fd 25
libperf: idx 2: mmapping fd 26
libperf: idx 3: mmapping fd 27
libperf: idx 4: mmapping fd 7
libperf: idx 4: set output fd 16 -> 7
libperf: idx 4: set output fd 28 -> 7
libperf: idx 5: mmapping fd 9
libperf: idx 5: set output fd 17 -> 9
libperf: idx 5: set output fd 29 -> 9
libperf: idx 6: mmapping fd 10
libperf: idx 6: set output fd 18 -> 10
libperf: idx 6: set output fd 30 -> 10
libperf: idx 7: mmapping fd 11
libperf: idx 7: set output fd 19 -> 11
libperf: idx 7: set output fd 31 -> 11
libperf: idx 8: mmapping fd 12
libperf: idx 8: set output fd 20 -> 12
libperf: idx 8: set output fd 32 -> 12
libperf: idx 9: mmapping fd 13
libperf: idx 9: set output fd 21 -> 13
libperf: idx 9: set output fd 33 -> 13
libperf: idx 10: mmapping fd 14
libperf: idx 10: set output fd 22 -> 14
libperf: idx 10: set output fd 34 -> 14
libperf: idx 11: mmapping fd 15
libperf: idx 11: set output fd 23 -> 15
libperf: idx 11: set output fd 35 -> 15
Control descriptor is not initialized
thread_data[0x60d000001700]: nr_mmaps=12, maps=0x608000004a20, ow_maps=(nil)
thread_data[0x60d000001700]: cpu0: maps[0] -> mmap[0]
thread_data[0x60d000001700]: cpu1: maps[1] -> mmap[1]
thread_data[0x60d000001700]: cpu2: maps[2] -> mmap[2]
thread_data[0x60d000001700]: cpu3: maps[3] -> mmap[3]
thread_data[0x60d000001700]: cpu4: maps[4] -> mmap[4]
thread_data[0x60d000001700]: cpu5: maps[5] -> mmap[5]
thread_data[0x60d000001700]: cpu6: maps[6] -> mmap[6]
thread_data[0x60d000001700]: cpu7: maps[7] -> mmap[7]
thread_data[0x60d000001700]: cpu8: maps[8] -> mmap[8]
thread_data[0x60d000001700]: cpu9: maps[9] -> mmap[9]
thread_data[0x60d000001700]: cpu10: maps[10] -> mmap[10]
thread_data[0x60d000001700]: cpu11: maps[11] -> mmap[11]
thread_data[0x60d000001700]: pollfd[0] <- event_fd=24
thread_data[0x60d000001700]: pollfd[1] <- event_fd=25
thread_data[0x60d000001700]: pollfd[2] <- event_fd=26
thread_data[0x60d000001700]: pollfd[3] <- event_fd=27
thread_data[0x60d000001700]: pollfd[4] <- event_fd=7
thread_data[0x60d000001700]: pollfd[5] <- event_fd=16
thread_data[0x60d000001700]: pollfd[6] <- event_fd=28
thread_data[0x60d000001700]: pollfd[7] <- event_fd=9
thread_data[0x60d000001700]: pollfd[8] <- event_fd=17
thread_data[0x60d000001700]: pollfd[9] <- event_fd=29
thread_data[0x60d000001700]: pollfd[10] <- event_fd=10
thread_data[0x60d000001700]: pollfd[11] <- event_fd=18
thread_data[0x60d000001700]: pollfd[12] <- event_fd=30
thread_data[0x60d000001700]: pollfd[13] <- event_fd=11
thread_data[0x60d000001700]: pollfd[14] <- event_fd=19
thread_data[0x60d000001700]: pollfd[15] <- event_fd=31
thread_data[0x60d000001700]: pollfd[16] <- event_fd=12
thread_data[0x60d000001700]: pollfd[17] <- event_fd=20
thread_data[0x60d000001700]: pollfd[18] <- event_fd=32
thread_data[0x60d000001700]: pollfd[19] <- event_fd=13
thread_data[0x60d000001700]: pollfd[20] <- event_fd=21
thread_data[0x60d000001700]: pollfd[21] <- event_fd=33
thread_data[0x60d000001700]: pollfd[22] <- event_fd=14
thread_data[0x60d000001700]: pollfd[23] <- event_fd=22
thread_data[0x60d000001700]: pollfd[24] <- event_fd=34
thread_data[0x60d000001700]: pollfd[25] <- event_fd=15
thread_data[0x60d000001700]: pollfd[26] <- event_fd=23
thread_data[0x60d000001700]: pollfd[27] <- event_fd=35
thread_data[0x60d000001700]: pollfd[28] <- non_perf_event fd=4
perf record done opening and mmapping events
Opening: dummy:HG
------------------------------------------------------------
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0x9 (PERF_COUNT_SW_DUMMY)
  watermark                        1
  sample_id_all                    1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 36
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 37
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 38
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 39
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 40
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 41
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 42
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 43
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 44
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 45
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 46
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 47
mmap size 528384B
libperf: mmap_per_cpu: nr cpu values 12 nr threads 1
libperf: idx 0: mmapping fd 36
libperf: idx 1: mmapping fd 37
libperf: idx 2: mmapping fd 38
libperf: idx 3: mmapping fd 39
libperf: idx 4: mmapping fd 40
libperf: idx 5: mmapping fd 41
libperf: idx 6: mmapping fd 42
libperf: idx 7: mmapping fd 43
libperf: idx 8: mmapping fd 44
libperf: idx 9: mmapping fd 45
libperf: idx 10: mmapping fd 46
libperf: idx 11: mmapping fd 47
Synthesizing TSC conversion information
Synthesizing id index
perf record has started


^C[ perf record: Woken up 1 times to write data ]
overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more info)
overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more info)
overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more info)
overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more info)
overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more info)
overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more info)
overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more info)
overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more info)
overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more info)
overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more info)
overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more info)
overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more info)
overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more info)
overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more info)
overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more info)
overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for more info)
overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for more info)
overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for more info)
overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for more info)
overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for more info)
overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info)
overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info)
overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more info)
overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more info)
overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more info)
overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for more info)
overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for more info)
overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for more info)
overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for more info)
overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more info)
overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more info)
overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more info)
overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more info)
overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more info)
overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more info)
overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more info)
overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info)
overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info)
overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libc.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libpcre2-8.so.0.11.2 (disable tui for more info)
overlapping maps in /usr/lib64/libselinux.so.1 (disable tui for more info)
overlapping maps in /usr/lib64/libresolv.so.2 (disable tui for more info)
overlapping maps in /usr/lib64/libkeyutils.so.1.10 (disable tui for more info)
overlapping maps in /usr/lib64/libz.so.1.2.13 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypto.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5support.so.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libcom_err.so.2.1 (disable tui for more info)
overlapping maps in /usr/lib64/libk5crypto.so.3.1 (disable tui for more info)
overlapping maps in /usr/lib64/libkrb5.so.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libunistring.so.5.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libgssapi_krb5.so.2.2 (disable tui for more info)
overlapping maps in /usr/lib64/libssl.so.3.1.1 (disable tui for more info)
overlapping maps in /usr/lib64/libidn2.so.0.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libnghttp2.so.14.24.3 (disable tui for more info)
overlapping maps in /usr/lib64/libglib-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libgmodule-2.0.so.0.7800.3 (disable tui for more info)
overlapping maps in /usr/lib64/libuuid.so.1.3.0 (disable tui for more info)
overlapping maps in /usr/lib64/libpopt.so.0.0.2 (disable tui for more info)
overlapping maps in /usr/lib64/libzstd.so.1.5.6 (disable tui for more info)
overlapping maps in /usr/lib64/libelf-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/liblzma.so.5.4.4 (disable tui for more info)
overlapping maps in /usr/lib64/libbz2.so.1.0.8 (disable tui for more info)
overlapping maps in /usr/lib64/libdw-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcrypt.so.2.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcurl.so.4.8.0 (disable tui for more info)
overlapping maps in /usr/lib64/libm.so.6 (disable tui for more info)
overlapping maps in /usr/lib64/libgcc_s-13-20240316.so.1 (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
overlapping maps in /usr/lib64/libstdc++.so.6.0.32 (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libtraceevent.so.1.7.2 (disable tui for more info)
overlapping maps in /usr/lib64/libpfm.so.4.13.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcapstone.so.4 (disable tui for more info)
overlapping maps in /usr/lib64/libbabeltrace-ctf.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libnuma.so.1.0.0 (disable tui for more info)
overlapping maps in /usr/lib64/libcap.so.2.48 (disable tui for more info)
overlapping maps in /usr/lib64/libpython3.12.so.1.0 (disable tui for more info)
overlapping maps in /usr/lib64/libperl.so.5.38.2 (disable tui for more info)
overlapping maps in /usr/lib64/libslang.so.2.3.3 (disable tui for more info)
overlapping maps in /usr/lib64/libdebuginfod-0.191.so (disable tui for more info)
overlapping maps in /usr/lib64/libopencsd_c_api.so.1.4.0 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libunwind-x86_64.so.8.0.1 (disable tui for more info)
overlapping maps in /usr/lib64/libasan.so.8.0.0 (disable tui for more info)
overlapping maps in /home/acme/bin/perf (disable tui for more info)
overlapping maps in /usr/lib64/ld-linux-x86-64.so.2 (disable tui for more info)
<SNIP lots of>
overlapping maps in //anon (disable tui for more info)
overlapping maps in //anon (disable tui for more info)
Downloading debug info with build id 8957b3556da9752d88d5e97203ca82a6d7cd8440
symbol:test_target file:(null) line:0 offset:0 return:0 lazy:(null)
Downloading debug info with build id 72308a603a383d464946114b8a572b98b44e1b44
symbol:unmap_start file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:unmap_complete file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:map_start file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:reloc_start file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:map_complete file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:reloc_complete file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:init_start file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:init_complete file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:lll_lock_wait_private file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:lll_lock_wait file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:setjmp file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:longjmp file:(null) line:0 offset:0 return:0 lazy:(null)
symbol:longjmp_target file:(null) line:0 offset:0 return:0 lazy:(null)
failed to write feature CPU_PMU_CAPS
[ perf record: Captured and wrote 0.074 MB perf.data (163 samples) ]

root@x1:~#

root@x1:~# ls -la perf.data
-rw-------. 1 root root 107670 Apr 12 11:45 perf.data
root@x1:~# perf evlist
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
dummy:u
root@x1:~# perf evlist -v
cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@x1:~#

Finally:

root@x1:~# perf mem report -s symbol_daddr -q > /tmp/bla

=================================================================
==715700==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 80 byte(s) in 10 object(s) allocated from:
    #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x6f696f in sample__resolve_mem (/home/acme/bin/perf+0x6f696f) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x77e187 in iter_prepare_mem_entry (/home/acme/bin/perf+0x77e187) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x7894cc in hist_entry_iter__add (/home/acme/bin/perf+0x7894cc) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x45b32e in process_sample_event (/home/acme/bin/perf+0x45b32e) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Direct leak of 37 byte(s) in 1 object(s) allocated from:
    #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x7feb378a0b77 in __vasprintf_internal (/lib64/libc.so.6+0x82b77) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #2 0x7feb38a9712f in __interceptor_vasprintf (/lib64/libasan.so.8+0x9712f) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #3 0x7feb38a9768e in __interceptor_asprintf (/lib64/libasan.so.8+0x9768e) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)

Indirect leak of 29612 byte(s) in 451 object(s) allocated from:
    #0 0x7feb38ad8cc7 in calloc (/lib64/libasan.so.8+0xd8cc7) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x69e2cc in symbol__new (/home/acme/bin/perf+0x69e2cc) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x8bff08 in dso__load_sym_internal (/home/acme/bin/perf+0x8bff08) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x8c11d5 in dso__load_sym (/home/acme/bin/perf+0x8c11d5) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x6a2798 in dso__load (/home/acme/bin/perf+0x6a2798) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x6fc19a in map__find_symbol (/home/acme/bin/perf+0x6fc19a) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x63936a in machine__resolve (/home/acme/bin/perf+0x63936a) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x45af8e in process_sample_event (/home/acme/bin/perf+0x45af8e) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #13 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #14 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #15 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #16 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #17 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #18 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Indirect leak of 472 byte(s) in 1 object(s) allocated from:
    #0 0x7feb38ad8cc7 in calloc (/lib64/libasan.so.8+0xd8cc7) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x6949ce in dso__new_id (/home/acme/bin/perf+0x6949ce) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x6989aa in dsos__findnew_id (/home/acme/bin/perf+0x6989aa) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x6b36af in __event_process_build_id.isra.0 (/home/acme/bin/perf+0x6b36af) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x6b3c26 in perf_header__read_build_ids (/home/acme/bin/perf+0x6b3c26) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x6b42e6 in process_build_id (/home/acme/bin/perf+0x6b42e6) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x6d1412 in perf_session__read_header (/home/acme/bin/perf+0x6d1412) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x710442 in __perf_session__new (/home/acme/bin/perf+0x710442) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x46234d in cmd_report (/home/acme/bin/perf+0x46234d) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Indirect leak of 112 byte(s) in 2 object(s) allocated from:
    #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x6fa213 in map__new (/home/acme/bin/perf+0x6fa213) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x6f4cf3 in machine__process_mmap2_event (/home/acme/bin/perf+0x6f4cf3) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #12 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #13 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Indirect leak of 69 byte(s) in 1 object(s) allocated from:
    #0 0x7feb38a814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x6a328f in dso__load (/home/acme/bin/perf+0x6a328f) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x6fc19a in map__find_symbol (/home/acme/bin/perf+0x6fc19a) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x63936a in machine__resolve (/home/acme/bin/perf+0x63936a) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x45af8e in process_sample_event (/home/acme/bin/perf+0x45af8e) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Indirect leak of 21 byte(s) in 1 object(s) allocated from:
    #0 0x7feb38a814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x696d79 in dso__set_basename (/home/acme/bin/perf+0x696d79) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x698a44 in dsos__findnew_id (/home/acme/bin/perf+0x698a44) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x6b36af in __event_process_build_id.isra.0 (/home/acme/bin/perf+0x6b36af) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x6b3c26 in perf_header__read_build_ids (/home/acme/bin/perf+0x6b3c26) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x6b42e6 in process_build_id (/home/acme/bin/perf+0x6b42e6) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x6d1412 in perf_session__read_header (/home/acme/bin/perf+0x6d1412) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x710442 in __perf_session__new (/home/acme/bin/perf+0x710442) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x46234d in cmd_report (/home/acme/bin/perf+0x46234d) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #13 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #14 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #15 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7feb38ad92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x71e0e6 in nsinfo__get (/home/acme/bin/perf+0x71e0e6) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x6fa3c5 in map__new (/home/acme/bin/perf+0x6fa3c5) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x6f4cf3 in machine__process_mmap2_event (/home/acme/bin/perf+0x6f4cf3) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x70e207 in perf_session__deliver_event (/home/acme/bin/perf+0x70e207) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x71ac28 in __ordered_events__flush (/home/acme/bin/perf+0x71ac28) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x7131ed in perf_session__process_events (/home/acme/bin/perf+0x7131ed) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #7 0x463450 in cmd_report (/home/acme/bin/perf+0x463450) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #8 0x4c2fef in cmd_mem (/home/acme/bin/perf+0x4c2fef) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #9 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #10 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #11 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #12 0x7feb37846149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #13 0x7feb3784620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #14 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

SUMMARY: AddressSanitizer: 30411 byte(s) leaked in 468 allocation(s).
root@x1:~#

But then, tring with what I have in tmp.perf-tools-next I get:

root@x1:~# perf mem record --all-user sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.008 MB perf.data ]

=================================================================
==718348==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 52 byte(s) in 2 object(s) allocated from:
    #0 0x7f5657c814a8 in strdup (/lib64/libasan.so.8+0x814a8) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x87b46d in perf_mem_events__record_args (/home/acme/bin/perf+0x87b46d) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #2 0x4c3e04 in cmd_mem (/home/acme/bin/perf+0x4c3e04) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #3 0x5feaa2 in run_builtin (/home/acme/bin/perf+0x5feaa2) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #4 0x5ff291 in handle_internal_command (/home/acme/bin/perf+0x5ff291) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #5 0x41a69b in main (/home/acme/bin/perf+0x41a69b) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)
    #6 0x7f5656a46149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #7 0x7f5656a4620a in __libc_start_main_impl (/lib64/libc.so.6+0x2820a) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #8 0x41fe74 in _start (/home/acme/bin/perf+0x41fe74) (BuildId: 8957b3556da9752d88d5e97203ca82a6d7cd8440)

Direct leak of 37 byte(s) in 1 object(s) allocated from:
    #0 0x7f5657cd92ef in malloc (/lib64/libasan.so.8+0xd92ef) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #1 0x7f5656aa0b77 in __vasprintf_internal (/lib64/libc.so.6+0x82b77) (BuildId: e0b579ca7024cf12a2686b60cf49d1d9e3ff6273)
    #2 0x7f5657c9712f in __interceptor_vasprintf (/lib64/libasan.so.8+0x9712f) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)
    #3 0x7f5657c9768e in __interceptor_asprintf (/lib64/libasan.so.8+0x9768e) (BuildId: 2b657470ea196ba4342e3bd8a3cc138b1e200599)

SUMMARY: AddressSanitizer: 89 byte(s) leaked in 3 allocation(s).
root@x1:~# 

For the command that was segfaulting... /me scratches head...

- Arnaldo

