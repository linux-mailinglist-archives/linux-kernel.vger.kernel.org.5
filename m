Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB780AC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjLHS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8DE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:57:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A91DC433C7;
        Fri,  8 Dec 2023 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702061842;
        bh=PyoZd6DEYlQ02STMB/e7rU1xXjX8HG0h4Pgh4yANRaE=;
        h=Date:From:To:Cc:Subject:From;
        b=AqHnuTgRAoDHVogR70A/K/mm1Tloo/hzLn4gNuXPZsnvJ7junMjY7hfhBaHU+sLJ/
         t0ihra9DqQhJNg0Jz0Al2F4X+ACFzwTk+2dSBpS7GLhr6Yal1sdjR8T96ntLXET+8c
         lH7L7OCUkDhfqOq8B5BqXou/39muDiPWXFffw4nBsqUCSP9JNQvufwX1XxAPptRJLY
         ebqSd7QNJd+WZzSJrw/oVOJzGTLqZ5ylE9A8uWCb1JnEHiL3HmUcKGnJ8s+rr7J6vK
         Tr7nEJetD2p6+63hWYr8eimnVgWPoZ8Ho8Nt4xu+ZDoFgussAXoUKNuBP0eDGAVRe1
         ItjvIVUzCMxdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0014B403EF; Fri,  8 Dec 2023 15:57:18 -0300 (-03)
Date:   Fri, 8 Dec 2023 15:57:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: 'perf top' broken on intel hybrid systems
Message-ID: <ZXNnDrGKXbEELMXV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	So I finally got a recent Intel hybrid system:

root@fedora:~# grep -m1 "model name" /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-14700K
root@fedora:~#

	Most things work, but:

root@fedora:~# perf top

Error:
The cycles:P event is not supported.
root@fedora:~#

root@fedora:~# perf top -e cycles:p
Error:
The cycles:p event is not supported.
root@fedora:~# perf top -e cycles:pp
Error:
The cycles:pp event is not supported.
^[[Aroot@fedora:~# perf top -e cycles:ppp
Error:
The cycles:ppp event is not supported.
root@fedora:~#
root@fedora:~# perf top -e cycles
Error:
The cycles event is not supported.
root@fedora:~#

root@fedora:~# perf top -e instructions
Error:
The instructions event is not supported.
root@fedora:~#root@fedora:~# perf top -e cache-misses
Error:
The cache-misses event is not supported.
root@fedora:~#

------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0xa00000000
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|CPU|PERIOD
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Error:
The cycles event is not supported.
root@fedora:~#

But...

root@fedora:~# perf record
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.631 MB perf.data (24079 samples) ]

root@fedora:~# perf evlist -v
cpu_atom/cycles:P/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
cpu_core/cycles:P/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@fedora:~#


root@fedora:~# perf top -e cpu_core/cpu-cycles:P/
event syntax error: 'cpu_core/cpu-cycles:P/'
                              \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu_core'

Initial error:
event syntax error: 'cpu_core/cpu-cycles:P/'
                              \___ unknown term 'cpu-cycles:P' for pmu 'cpu_core'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
Run 'perf list' for a list of valid events

 Usage: perf top [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events
root@fedora:~#

So it seems its just 'perf top' breakage:

root@fedora:~# perf top -e cpu_core/cpu-cycles/
Error:
The cpu_core/cpu-cycles/ event is not supported.
root@fedora:~# perf top -e cpu_atom/cpu-cycles/
Error:
The cpu_atom/cpu-cycles/ event is not supported.
root@fedora:~#

I bisected this to:

⬢[acme@toolbox perf-tools-next]$ git bisect good
251aa040244a3b17068e4e6ec61f138d7e50681a is the first bad commit
commit 251aa040244a3b17068e4e6ec61f138d7e50681a
Author: Ian Rogers <irogers@google.com>
Date:   Thu Jun 1 01:29:53 2023 -0700

    perf parse-events: Wildcard most "numeric" events

    Numeric events are either raw events or those with ABI defined numbers
    matched by the lexer. PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events
    should wildcard match on hybrid systems. So "cycles" should match each
    PMU type with an extended type, not just PERF_TYPE_HARDWARE.

    Change wildcard matching to add the event even if wildcard PMU
    scanning fails, there will be no extended type but this best matches
    previous behavior.

    Only set the extended type when the event type supports it and when
    perf_pmus__supports_extended_type is true. This new function returns
    true if >1 core PMU and avoids potential errors on older kernels.

    Modify evsel__compute_group_pmu_name using a helper
    perf_pmu__is_software to determine when grouping should occur. Try to
    use PMUs, and evsel__find_pmu, as being more dependable than
    evsel->pmu_name.

    Set a parse events error if a hardware term's PMU lookup fails, to
    provide extra diagnostics.

    Fixes: 8bc75f699c141420 ("perf parse-events: Support wildcards on raw events")
    Reported-by: Kan Liang <kan.liang@linux.intel.com>
    Signed-off-by: Ian Rogers <irogers@google.com>
    Tested-by: Kan Liang <kan.liang@linux.intel.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ravi Bangoria <ravi.bangoria@amd.com>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Thomas Richter <tmricht@linux.ibm.com>
    Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
    Link: https://lore.kernel.org/r/20230601082954.754318-4-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/util/parse-events.c | 104 +++++++++++++++++++++++++++++------------
 tools/perf/util/parse-events.y |  10 ++--
 tools/perf/util/pmu.c          |  16 +++++++
 tools/perf/util/pmu.h          |   5 ++
 tools/perf/util/pmus.c         |   5 ++
 tools/perf/util/pmus.h         |   1 +
 6 files changed, 106 insertions(+), 35 deletions(-)
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
