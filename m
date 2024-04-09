Return-Path: <linux-kernel+bounces-137512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019F89E321
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BF028886D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA98157A40;
	Tue,  9 Apr 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5vtu7Tk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC681156F5D;
	Tue,  9 Apr 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689957; cv=none; b=AqK+fYCDcQc6FeCzQpXERwbGexl+XaQdb0Quwld1ffliMQIviv0oIdIapqLvK1h+W1RtSO6Doz6E9gjVvQss46agbVeaif6wxFrDjL1Alx+bIhP/3rgPfzsZ3WvU4RrbpUAyKpnO4UBbWR21BP/7dbtU/GIKJI903NUHu9JH25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689957; c=relaxed/simple;
	bh=DfuXTGkraLWHkNJuO+9SBnAAUaw6k8nUYkhO8ZyCDKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ckmDcL87brtxbnPGOwQUBM2/qSPMdJY+gKNyebvYFOVilfduc5c/loYldwU554cBj+hz0mUxPQSpjbZfyx4zW3FA1JF5i2QuTcCdlJr31mGQOu0ZYaTFBxkmlBUHomK9wW+qAZjVAB5Q9oUt2/4pWNA3w677LMDmDOCfyk3dppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5vtu7Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69D7C433F1;
	Tue,  9 Apr 2024 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689957;
	bh=DfuXTGkraLWHkNJuO+9SBnAAUaw6k8nUYkhO8ZyCDKM=;
	h=Date:From:To:Cc:Subject:From;
	b=u5vtu7TkhAT4Whr3XXyEt7LbQMEwCqFiFl3pUziIPU1kp8AGW7WDFIof0cHHjpHcL
	 X0BlnbIX68Z6vz3irSxDq0XI7SP9nkanqb0Efexz1n64JWM4XWeW9FItbBdMyYQUB7
	 OHOofB+P5raIG8wSWpNGyHecFaOtCz9eNaZqKeSjq7M8ZljQOi+fOhtR8Rb9Fmc6dN
	 i9pjJxtEq9+bY7HpQbFVKAXnfw0w8LAB2IQlL0gpIo76MN1duPZDhOAuoTCyCRX6aR
	 0+WPQsylN8Zm6grDseHtdReZmCAFN9X7ypdq22Om0vrlvNEdzHDT0GaS3/u1jYfkPF
	 QnbS/56STmeDA==
Date: Tue, 9 Apr 2024 16:12:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid
 systems
Message-ID: <ZhWTIuyB9p1ORbQH@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

root@x1:~# grep -m1 "model name" /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~# uname -a
Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
root@x1:~#

Bisected down to:

commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
Author: Ravi Bangoria <ravi.bangoria@amd.com>
Date:   Thu Jun 15 10:47:00 2023 +0530

    perf mem: Scan all PMUs instead of just core ones
    
    Scanning only core PMUs is not sufficient on platforms like AMD since
    perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
    Scan all PMUs instead of just core PMUs. There should be negligible
    performance overhead because of scanning all PMUs, so we should be okay.
    
    Reviewed-by: Ian Rogers <irogers@google.com>
    Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

root@x1:~# perf -v ; perf test -v "Test data symbol"
perf version 6.4.rc3.g5752c20f3787
111: Test data symbol                                                :
--- start ---
test child forked, pid 522202
Recording workload...
malloc_consolidate(): invalid chunk size
/home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60: 522208 Aborted                 (core dumped) perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM
/home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62: kill: (522208) - No such process
Cleaning up files...
test child finished with -1
---- end ----
Test data symbol: FAILED!
root@x1:~# perf -v ; perf test -v "Test data symbol"
perf version 6.8.g63c22868714b
116: Test data symbol:
--- start ---
test child forked, pid 526540
 954300-954339 l buf1
perf does have symbol 'buf1'
Recording workload...
Waiting for "perf record has started" message
OK
Cleaning up files...
---- end(-1) ----
116: Test data symbol                                                : FAILED!
root@x1:~#

Further details:

(gdb) run mem record --all-user sleep 1
Starting program: /root/bin/perf mem record --all-user sleep 1


This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
[Thread debugging using libthread_db enabled]                                                                                                                                                  
Using host libthread_db library "/lib64/libthread_db.so.1".
                                                                                                                                                                                               
Program received signal SIGSEGV, Segmentation fault.
0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
213					s = perf_mem_events__name(j, pmu->name);
(gdb) bt
#0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
#1  0x000000000045c47f in __cmd_record (argc=2, argv=0x7fffffffe420, mem=0x7fffffffda20) at builtin-mem.c:152
#2  0x000000000045d69b in cmd_mem (argc=4, argv=0x7fffffffe420) at builtin-mem.c:514
#3  0x00000000004ffe38 in run_builtin (p=0xe08aa0 <commands+672>, argc=5, argv=0x7fffffffe420) at perf.c:323
#4  0x00000000005000ac in handle_internal_command (argc=5, argv=0x7fffffffe420) at perf.c:377
#5  0x00000000005001fb in run_argv (argcp=0x7fffffffe23c, argv=0x7fffffffe230) at perf.c:421
#6  0x00000000005004e8 in main (argc=5, argv=0x7fffffffe420) at perf.c:537
(gdb) list -5
file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
(gdb) 



(gdb) list -5
file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
(gdb) p j
$1 = 0
(gdb) p pmu->name
Cannot access memory at address 0x64ffffff9c
(gdb) 

183 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
184                                  char **rec_tmp, int *tmp_nr)
185 {
186         int i = *argv_nr, k = 0;
187         struct perf_mem_event *e;
188         struct perf_pmu *pmu;
189         char *s;
190 
191         for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
192                 e = perf_mem_events__ptr(j);
193                 if (!e->record)
194                         continue;
195 
196                 if (perf_pmus__num_mem_pmus() == 1) {
197                         if (!e->supported) {
198                                 pr_err("failed: event '%s' not supported\n",
199                                        perf_mem_events__name(j, NULL));
200                                 return -1;
201                         }
202 
203                         rec_argv[i++] = "-e";
204                         rec_argv[i++] = perf_mem_events__name(j, NULL);
205                 } else {
206                         if (!e->supported) {
207                                 perf_mem_events__print_unsupport_hybrid(e, j);
208                                 return -1;
209                         }
210 
211                         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
212                                 rec_argv[i++] = "-e";
213                                 s = perf_mem_events__name(j, pmu->name);
214                                 if (s) {
215                                         s = strdup(s);

