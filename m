Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FA80AD37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjLHTjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:39:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62771720;
        Fri,  8 Dec 2023 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702064380; x=1733600380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3dcKMv7qHN9pJqYwuNr48c5QTjgeOC67R6iDpbG6a1k=;
  b=JcGCqcLNTQN9H8nHAH8pYlGJE0t9PEpm+GfcLpSx6EtNKurXI13TxXXu
   ezTTtc/kD/Ctq30tnx8g15kRVbRhgJMc7BO/Snm+BeAHz47fQsLnTueHF
   aiq2isnwuSNi9zKO4tGv6MBVwUaUUT2WkNP2iEH0V90hY8yTDI22sNIzl
   uAOHN3N/O9lOTlRF547oUHJdH7LN5bO0nogGd47W/4XxQjat0B28y3nHf
   4SwbEKusMbsdv0LdWiyzPvDcdyoc+L16cIdeNofuek0ySkFDtiKqeT/eA
   WhkyO6EtSxbLnWKSeUPZr6XqppOaq3iOeZyz+u77FrrpStrc4VnCBkJQU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="391623035"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="391623035"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="862979298"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="862979298"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:39:40 -0800
Received: from [10.212.91.62] (unknown [10.212.91.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 99176580DA9;
        Fri,  8 Dec 2023 11:39:38 -0800 (PST)
Message-ID: <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
Date:   Fri, 8 Dec 2023 14:39:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'perf top' broken on intel hybrid systems
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <ZXNnDrGKXbEELMXV@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZXNnDrGKXbEELMXV@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-08 1:57 p.m., Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	So I finally got a recent Intel hybrid system:
> 
> root@fedora:~# grep -m1 "model name" /proc/cpuinfo
> model name	: Intel(R) Core(TM) i7-14700K
> root@fedora:~#
> 
> 	Most things work, but:
> 
> root@fedora:~# perf top
> 
> Error:
> The cycles:P event is not supported.
> root@fedora:~#
> 
> root@fedora:~# perf top -e cycles:p
> Error:
> The cycles:p event is not supported.
> root@fedora:~# perf top -e cycles:pp
> Error:
> The cycles:pp event is not supported.
> ^[[Aroot@fedora:~# perf top -e cycles:ppp
> Error:
> The cycles:ppp event is not supported.
> root@fedora:~#
> root@fedora:~# perf top -e cycles
> Error:
> The cycles event is not supported.
> root@fedora:~#
> 
> root@fedora:~# perf top -e instructions
> Error:
> The instructions event is not supported.
> root@fedora:~#root@fedora:~# perf top -e cache-misses
> Error:
> The cache-misses event is not supported.
> root@fedora:~#
> 
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0xa00000000
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2


The error is because the perf top always tries to open an event on the
user_requested_cpus, which are all CPUs by default.

Something as below should fix it. For hybrid, open a PMU event on an
unsupported CPU should be error out.

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1e42bd1c7d5a..7aa29e6264e4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct
perf_top *top)

        evlist__for_each_entry(evlist, counter) {
 try_again:
-               if (evsel__open(counter,
top->evlist->core.user_requested_cpus,
-                                    top->evlist->core.threads) < 0) {
+               if (evsel__open(counter, counter->core.cpus,
+                               counter->core.threads) < 0) {

                        /*
                         * Specially handle overwrite fall back.


> Error:
> The cycles event is not supported.
> root@fedora:~#
> 
> But...
> 
> root@fedora:~# perf record
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.631 MB perf.data (24079 samples) ]
> 
> root@fedora:~# perf evlist -v
> cpu_atom/cycles:P/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> cpu_core/cycles:P/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> root@fedora:~#
> 
> 
> root@fedora:~# perf top -e cpu_core/cpu-cycles:P/
> event syntax error: 'cpu_core/cpu-cycles:P/'
>                               \___ Bad event or PMU
> 
> Unable to find PMU or event on a PMU of 'cpu_core'
> 
> Initial error:
> event syntax error: 'cpu_core/cpu-cycles:P/'
>                               \___ unknown term 'cpu-cycles:P' for pmu 'cpu_core'

The P or other event modifier should be after the last '/'.
Something as below:
perf top -e cpu_core/cpu-cycles/P

Even for the non-hybrid or perf record, the /cpu-cycles:P/ format is
incorrect.

It looks like by design, not a bug.

$ perf record -e cpu/cycles:P/
event syntax error: 'cpu/cycles:P/'
                         \___ unknown term 'cycles:P' for pmu 'cpu'

valid terms:
event,pc,edge,any,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware

Initial error:
event syntax error: 'cpu/cycles:P/'
                         \___ unknown term 'cycles:P' for pmu 'cpu'

$ perf record -e cpu/cycles/P
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.695 MB perf.data (254 samples) ]


Thanks,
Kan
> 
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
> Run 'perf list' for a list of valid events
> 
>  Usage: perf top [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> root@fedora:~#
> 
> So it seems its just 'perf top' breakage:
> 
> root@fedora:~# perf top -e cpu_core/cpu-cycles/
> Error:
> The cpu_core/cpu-cycles/ event is not supported.
> root@fedora:~# perf top -e cpu_atom/cpu-cycles/
> Error:
> The cpu_atom/cpu-cycles/ event is not supported.
> root@fedora:~#
> 
> I bisected this to:
> 
> ⬢[acme@toolbox perf-tools-next]$ git bisect good
> 251aa040244a3b17068e4e6ec61f138d7e50681a is the first bad commit
> commit 251aa040244a3b17068e4e6ec61f138d7e50681a
> Author: Ian Rogers <irogers@google.com>
> Date:   Thu Jun 1 01:29:53 2023 -0700
> 
>     perf parse-events: Wildcard most "numeric" events
> 
>     Numeric events are either raw events or those with ABI defined numbers
>     matched by the lexer. PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events
>     should wildcard match on hybrid systems. So "cycles" should match each
>     PMU type with an extended type, not just PERF_TYPE_HARDWARE.
> 
>     Change wildcard matching to add the event even if wildcard PMU
>     scanning fails, there will be no extended type but this best matches
>     previous behavior.
> 
>     Only set the extended type when the event type supports it and when
>     perf_pmus__supports_extended_type is true. This new function returns
>     true if >1 core PMU and avoids potential errors on older kernels.
> 
>     Modify evsel__compute_group_pmu_name using a helper
>     perf_pmu__is_software to determine when grouping should occur. Try to
>     use PMUs, and evsel__find_pmu, as being more dependable than
>     evsel->pmu_name.
> 
>     Set a parse events error if a hardware term's PMU lookup fails, to
>     provide extra diagnostics.
> 
>     Fixes: 8bc75f699c141420 ("perf parse-events: Support wildcards on raw events")
>     Reported-by: Kan Liang <kan.liang@linux.intel.com>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Tested-by: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>     Cc: Rob Herring <robh@kernel.org>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
>     Link: https://lore.kernel.org/r/20230601082954.754318-4-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>  tools/perf/util/parse-events.c | 104 +++++++++++++++++++++++++++++------------
>  tools/perf/util/parse-events.y |  10 ++--
>  tools/perf/util/pmu.c          |  16 +++++++
>  tools/perf/util/pmu.h          |   5 ++
>  tools/perf/util/pmus.c         |   5 ++
>  tools/perf/util/pmus.h         |   1 +
>  6 files changed, 106 insertions(+), 35 deletions(-)
> ⬢[acme@toolbox perf-tools-next]$
> 
> - Arnaldo
