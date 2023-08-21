Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD57878259A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjHUIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjHUIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:36:42 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA3B5;
        Mon, 21 Aug 2023 01:36:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VqEq8CV_1692606988;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqEq8CV_1692606988)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 16:36:29 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v7 3/8] perf vendor events: Supplement the omitted EventCode
Date:   Mon, 21 Aug 2023 16:36:12 +0800
Message-Id: <1692606977-92009-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an "event=0" in the event description, the EventCode can
be omitted in the JSON file, and jevent.py will automatically fill in
"event=0" during parsing.

However, for some events where EventCode and ConfigCode are missing,
it is not necessary to automatically fill in "event=0", such as the
CMN event description which is typically "type=xxx, eventid=xxx".

Therefore, before modifying jevent.py to prevent it from automatically
adding "event=0" by default, it is necessary to fill in all omitted
EventCodes first.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/pipeline.json     |  9 +++++++++
 tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json    |  3 +++
 tools/perf/pmu-events/arch/x86/broadwell/pipeline.json     |  4 ++++
 tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json   |  4 ++++
 .../perf/pmu-events/arch/x86/broadwellde/uncore-cache.json |  2 ++
 .../arch/x86/broadwellde/uncore-interconnect.json          |  1 +
 .../pmu-events/arch/x86/broadwellde/uncore-memory.json     |  1 +
 .../perf/pmu-events/arch/x86/broadwellde/uncore-power.json |  1 +
 tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json    |  4 ++++
 .../perf/pmu-events/arch/x86/broadwellx/uncore-cache.json  |  2 ++
 .../arch/x86/broadwellx/uncore-interconnect.json           | 13 +++++++++++++
 .../perf/pmu-events/arch/x86/broadwellx/uncore-memory.json |  2 ++
 .../perf/pmu-events/arch/x86/broadwellx/uncore-power.json  |  1 +
 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json  |  4 ++++
 .../pmu-events/arch/x86/cascadelakex/uncore-cache.json     |  2 ++
 .../arch/x86/cascadelakex/uncore-interconnect.json         |  1 +
 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json |  1 +
 .../pmu-events/arch/x86/cascadelakex/uncore-memory.json    |  1 +
 .../pmu-events/arch/x86/cascadelakex/uncore-power.json     |  1 +
 tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json   |  2 ++
 tools/perf/pmu-events/arch/x86/goldmont/pipeline.json      |  3 +++
 tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json  |  3 +++
 tools/perf/pmu-events/arch/x86/grandridge/pipeline.json    |  3 +++
 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json |  4 ++++
 tools/perf/pmu-events/arch/x86/haswell/pipeline.json       |  4 ++++
 tools/perf/pmu-events/arch/x86/haswellx/pipeline.json      |  4 ++++
 tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json  |  2 ++
 .../pmu-events/arch/x86/haswellx/uncore-interconnect.json  | 14 ++++++++++++++
 tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json |  2 ++
 tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json  |  1 +
 tools/perf/pmu-events/arch/x86/icelake/pipeline.json       |  4 ++++
 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json      |  4 ++++
 tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json  |  1 +
 .../pmu-events/arch/x86/icelakex/uncore-interconnect.json  |  1 +
 tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json |  1 +
 tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json  |  1 +
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json     |  3 +++
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json       |  4 ++++
 tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json   |  2 ++
 .../pmu-events/arch/x86/ivytown/uncore-interconnect.json   | 11 +++++++++++
 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json  |  1 +
 tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json   |  1 +
 tools/perf/pmu-events/arch/x86/jaketown/pipeline.json      |  4 ++++
 tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json  |  2 ++
 .../pmu-events/arch/x86/jaketown/uncore-interconnect.json  | 12 ++++++++++++
 tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json |  1 +
 tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json  |  2 ++
 .../perf/pmu-events/arch/x86/knightslanding/pipeline.json  |  3 +++
 .../pmu-events/arch/x86/knightslanding/uncore-cache.json   |  1 +
 .../pmu-events/arch/x86/knightslanding/uncore-memory.json  |  4 ++++
 tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json    |  8 ++++++++
 tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json   |  4 ++++
 .../perf/pmu-events/arch/x86/sapphirerapids/pipeline.json  |  5 +++++
 tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json  |  4 ++++
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json    |  3 +++
 tools/perf/pmu-events/arch/x86/skylake/pipeline.json       |  4 ++++
 tools/perf/pmu-events/arch/x86/skylakex/pipeline.json      |  4 ++++
 tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json  |  2 ++
 .../pmu-events/arch/x86/skylakex/uncore-interconnect.json  |  1 +
 tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json     |  1 +
 tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json |  1 +
 tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json  |  1 +
 tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json    |  2 ++
 .../perf/pmu-events/arch/x86/snowridgex/uncore-cache.json  |  1 +
 .../arch/x86/snowridgex/uncore-interconnect.json           |  1 +
 .../perf/pmu-events/arch/x86/snowridgex/uncore-memory.json |  1 +
 .../perf/pmu-events/arch/x86/snowridgex/uncore-power.json  |  1 +
 tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json     |  5 +++++
 68 files changed, 211 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index cb5b861..7054426 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -489,6 +489,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
@@ -550,6 +551,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -558,6 +560,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately 
 so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -584,6 +587,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
@@ -592,6 +596,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -743,6 +748,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0.",
@@ -752,6 +758,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -796,6 +803,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise-distribution",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a precise distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR++) feature to fix bias in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -1160,6 +1168,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index fa53ff1..345d1c8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -211,6 +211,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
@@ -225,6 +226,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -240,6 +242,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 9a902d2..b114d0d 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -336,6 +336,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. \nNote: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  This event is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appea
 r 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -359,6 +360,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -366,6 +368,7 @@
     },
     {
         "AnyThread": "1",
+        "EventCode": "0x0",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
@@ -514,6 +517,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. \nCounting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 9a902d2..ce90d058 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -336,6 +336,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. \nNote: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  This event is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appea
 r 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -359,6 +360,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -367,6 +369,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -514,6 +517,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. \nCounting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index 56bba6d..117be19 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -8,6 +8,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBOX"
@@ -1501,6 +1502,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This will be slightly different than the count in the Ubox because of enable/freeze delays.  The HA is on the other side of the die from the fixed Ubox uclk counter, so the drift could be somewhat larger than in units that are closer like the QPI Agent.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
index 8a327e0..ce54bd3 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
@@ -19,6 +19,7 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
+        "EventCode": "0x0",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
index a764234..32c46bd 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
@@ -131,6 +131,7 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index 83d2013..f57eb8e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 9a902d2..ce90d058 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -336,6 +336,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. \nNote: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  This event is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appea
 r 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -359,6 +360,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -367,6 +369,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -514,6 +517,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. \nCounting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 400d784..346f5cf 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -183,6 +183,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBOX"
@@ -1689,6 +1690,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This will be slightly different than the count in the Ubox because of enable/freeze delays.  The HA is on the other side of the die from the fixed Ubox uclk counter, so the drift could be somewhat larger than in units that are closer like the QPI Agent.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index e61a23f..df96e41 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of non data (control) flits transmitted . Derived from unc_q_txl_flits_g0.non_data",
+        "EventCode": "0x0",
         "EventName": "QPI_CTL_BANDWIDTH_TX",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-data flits transmitted across QPI.  This basically tracks the protocol overhead on the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This includes the header flits for data packets.",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Number of data flits transmitted . Derived from unc_q_txl_flits_g0.data",
+        "EventCode": "0x0",
         "EventName": "QPI_DATA_BANDWIDTH_TX",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits transmitted over QPI.  Each flit contains 64b of data.  This includes both DRS and NCB data flits (coherent and non-coherent).  This can be used to calculate the data bandwidth of the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This does not include the header flits that go in data packets.",
@@ -37,6 +39,7 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
+        "EventCode": "0x0",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
@@ -1400,6 +1403,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits transmitted over QPI.  Each flit contains 64b of data.  This includes both DRS and NCB data flits (coherent and non-coherent).  This can be used to calculate the data bandwidth of the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This does not include the header flits that go in data packets.",
@@ -1408,6 +1412,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protocol Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-data flits transmitted across QPI.  This basically tracks the protocol overhead on the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This includes the header flits for data packets.",
@@ -1416,6 +1421,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both Header and Data)",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.",
@@ -1424,6 +1430,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+		"EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of data flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the data flits (not the header).",
@@ -1432,6 +1439,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of protocol flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the header flits (not the data).  This includes extended headers.",
@@ -1440,6 +1448,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of flits transmitted over QPI on the home channel.",
@@ -1448,6 +1457,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of non-request flits transmitted over QPI on the home channel.  These are most commonly snoop responses, and this event can be used as a proxy for that.",
@@ -1456,6 +1466,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of data request transmitted over QPI on the home channel.  This basically counts the number of remote memory requests transmitted over QPI.  In conjunction with the local read count in the Home Agent, one can calculate the number of LLC Misses.",
@@ -1464,6 +1475,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of snoop request flits transmitted over QPI.  These requests are contained in the snoop channel.  This does not include snoop responses, which are transmitted on the home channel.",
@@ -3162,6 +3174,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_S_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "SBOX"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
index b5a33e7a..0c5888d 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
@@ -158,12 +158,14 @@
     },
     {
         "BriefDescription": "Clockticks in the Memory Controller using one of the programmable counters",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS_P",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event UNC_M_CLOCKTICKS_P",
+        "EventCode": "0x0",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index 83d2013..f57eb8e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 0f06e31..99346e1 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -191,6 +191,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overfl
 ow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -222,6 +223,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -230,6 +232,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -369,6 +372,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, Counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. Counting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
index 2c88053..ba7a6f6 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
@@ -512,6 +512,7 @@
     },
     {
         "BriefDescription": "Uncore cache clock ticks",
+        "EventCode": "0x0",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts clockticks of the clock controlling the uncore caching and home agent (CHA).",
@@ -5792,6 +5793,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event UNC_CHA_CLOCKTICKS",
+        "EventCode": "0x0",
         "Deprecated": "1",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
index 725780f..43d7b24 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
@@ -1090,6 +1090,7 @@
     },
     {
         "BriefDescription": "Cycles - at UCLK",
+        "EventCode": "0x0",
         "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "M2M"
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
index 743c91f..377d54f 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
@@ -1271,6 +1271,7 @@
     },
     {
         "BriefDescription": "Counting disabled",
+        "EventCode": "0x0",
         "EventName": "UNC_IIO_NOTHING",
         "PerPkg": "1",
         "Unit": "IIO"
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index f761856..77bb0ea 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -167,6 +167,7 @@
     },
     {
         "BriefDescription": "Memory controller clock ticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts clockticks of the fixed frequency clock of the memory controller using one of the programmable counters.",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
index c6254af..a01b279 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index 9dd8c90..3388cd5 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -150,6 +150,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -179,6 +180,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0.",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
index acb8974..79806e7 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
@@ -143,6 +143,7 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted  (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. In mobile systems the core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.  You cannot collect a PEBs record for this event.",
         "SampleAfterValue": "2000003",
@@ -165,6 +166,7 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted  (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction.  In mobile systems the core frequency may change from time.  This event is not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  This event uses fixed counter 2.  You cannot collect a PEBs record for this event.",
         "SampleAfterValue": "2000003",
@@ -187,6 +189,7 @@
     },
     {
         "BriefDescription": "Instructions retired (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions that retire execution. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. The counter continues counting during hardware interrupts, traps, and inside interrupt handlers.  This event uses fixed counter 0.  You cannot collect a PEBs record for this event.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index 33ef331..1be1b50 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -143,6 +143,7 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted  (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. In mobile systems the core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.  You cannot collect a PEBs record for this event.",
         "SampleAfterValue": "2000003",
@@ -165,6 +166,7 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted  (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction.  In mobile systems the core frequency may change from time.  This event is not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  This event uses fixed counter 2.  You cannot collect a PEBs record for this event.",
         "SampleAfterValue": "2000003",
@@ -187,6 +189,7 @@
     },
     {
         "BriefDescription": "Instructions retired (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "2",
         "PublicDescription": "Counts the number of instructions that retire execution. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. The counter continues counting during hardware interrupts, traps, and inside interrupt handlers.  This event uses fixed counter 0.  You cannot collect a PEBs record for this event.",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 4121295..5335a7b 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -29,6 +29,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
@@ -43,6 +44,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -55,6 +57,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 764c043..6ca34b9 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -17,6 +17,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately 
 so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -32,6 +33,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -46,6 +48,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -78,6 +81,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
index 540f437..0d5eafd 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -303,6 +303,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state.",
         "SampleAfterValue": "2000003",
@@ -327,6 +328,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of thread cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. The core frequency may change from time to time due to power or thermal throttling.",
         "SampleAfterValue": "2000003",
@@ -335,6 +337,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -436,6 +439,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "Errata": "HSD140, HSD143",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. INST_RETIRED.ANY is counted by a designated fixed counter, leaving the programmable counters available for other events. Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
index 540f437..0d5eafd 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -303,6 +303,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state.",
         "SampleAfterValue": "2000003",
@@ -327,6 +328,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of thread cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. The core frequency may change from time to time due to power or thermal throttling.",
         "SampleAfterValue": "2000003",
@@ -335,6 +337,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -436,6 +439,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "Errata": "HSD140, HSD143",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. INST_RETIRED.ANY is counted by a designated fixed counter, leaving the programmable counters available for other events. Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 9227cc2..64e2fb4 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -183,6 +183,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBOX"
@@ -1698,6 +1699,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This will be slightly different than the count in the Ubox because of enable/freeze delays.  The HA is on the other side of the die from the fixed Ubox uclk counter, so the drift could be somewhat larger than in units that are closer like the QPI Agent.",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 954e8198..7c4fc13 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of non data (control) flits transmitted . Derived from unc_q_txl_flits_g0.non_data",
+        "EventCode": "0x0",
         "EventName": "QPI_CTL_BANDWIDTH_TX",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-data flits transmitted across QPI.  This basically tracks the protocol overhead on the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This includes the header flits for data packets.",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Number of data flits transmitted . Derived from unc_q_txl_flits_g0.data",
+        "EventCode": "0x0",
         "EventName": "QPI_DATA_BANDWIDTH_TX",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits transmitted over QPI.  Each flit contains 64b of data.  This includes both DRS and NCB data flits (coherent and non-coherent).  This can be used to calculate the data bandwidth of the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This does not include the header flits that go in data packets.",
@@ -37,6 +39,7 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
+        "EventCode": "0x0",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
@@ -1401,6 +1404,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits transmitted over QPI.  Each flit contains 64b of data.  This includes both DRS and NCB data flits (coherent and non-coherent).  This can be used to calculate the data bandwidth of the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This does not include the header flits that go in data packets.",
@@ -1409,6 +1413,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protocol Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-data flits transmitted across QPI.  This basically tracks the protocol overhead on the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This includes the header flits for data packets.",
@@ -1417,6 +1422,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both Header and Data)",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.",
@@ -1425,6 +1431,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of data flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the data flits (not the header).",
@@ -1433,6 +1440,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of protocol flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the header flits (not the data).  This includes extended headers.",
@@ -1441,6 +1449,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of flits transmitted over QPI on the home channel.",
@@ -1449,6 +1458,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of non-request flits transmitted over QPI on the home channel.  These are most commonly snoop responses, and this event can be used as a proxy for that.",
@@ -1457,6 +1467,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of data request transmitted over QPI on the home channel.  This basically counts the number of remote memory requests transmitted over QPI.  In conjunction with the local read count in the Home Agent, one can calculate the number of LLC Misses.",
@@ -1465,6 +1476,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of snoop request flits transmitted over QPI.  These requests are contained in the snoop channel.  This does not include snoop responses, which are transmitted on the home channel.",
@@ -3136,6 +3148,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_S_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "SBOX"
@@ -3823,6 +3836,7 @@
     },
     {
         "BriefDescription": "UNC_U_CLOCKTICKS",
+        "EventCode": "0x0",
         "EventName": "UNC_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "UBOX"
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
index c005f51..124c3ae 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
@@ -151,12 +151,14 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM Clockticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
index daebf10..9276058 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
index 154fee4..0789412 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -193,6 +193,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to
  less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -208,6 +209,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -359,6 +361,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with a reduced effect of PEBS shadow in IP distribution",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a more unbiased distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR) feature to mitigate some bias in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -562,6 +565,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
index 442a4c7..9cfb341 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -193,6 +193,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to
  less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -208,6 +209,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -359,6 +361,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with a reduced effect of PEBS shadow in IP distribution",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a more unbiased distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR) feature to mitigate some bias in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -544,6 +547,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
index b6ce14e..ae57663 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
@@ -892,6 +892,7 @@
     },
     {
         "BriefDescription": "Clockticks of the uncore caching and home agent (CHA)",
+        "EventCode": "0x0",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
index 8ac5907..1b821b6 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
@@ -1419,6 +1419,7 @@
     },
     {
         "BriefDescription": "Clockticks of the mesh to memory (M2M)",
+        "EventCode": "0x0",
         "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "M2M"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
index 814d959..b0b2f27 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
@@ -100,6 +100,7 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
index ee4dac6..9c4cd59 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Clockticks of the power control unit (PCU)",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Clockticks of the power control unit (PCU) : The PCU runs off a fixed 1 GHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index 30a3da9..2df2d21 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -326,6 +326,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
@@ -348,6 +349,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -355,6 +357,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index 30a3da9..6f6f281 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -326,6 +326,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
@@ -348,6 +349,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -355,6 +357,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "SampleAfterValue": "2000003",
@@ -510,6 +513,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 8bf2706..31e58fb 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBOX"
@@ -1533,6 +1534,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This will be slightly different than the count in the Ubox because of enable/freeze delays.  The HA is on the other side of the die from the fixed Ubox uclk counter, so the drift could be somewhat larger than in units that are closer like the QPI Agent.",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index ccf45153..f2492ec7 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -109,6 +109,7 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
+        "EventCode": "0x0",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
@@ -1522,6 +1523,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits transmitted over QPI.  Each flit contains 64b of data.  This includes both DRS and NCB data flits (coherent and non-coherent).  This can be used to calculate the data bandwidth of the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This does not include the header flits that go in data packets.",
@@ -1530,6 +1532,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protocol Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual data and an additional 16 bits of other information.  To calc
 ulate data bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-data flits transmitted across QPI.  This basically tracks the protocol overhead on the QPI link.  One can get a good picture of the QPI-link characteristics by evaluating the protocol flits, data flits, and idle/null flits.  This includes the header flits for data packets.",
@@ -1538,6 +1541,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both Header and Data)",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.",
@@ -1546,6 +1550,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of data flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the data flits (not the header).",
@@ -1554,6 +1559,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the total number of protocol flits transmitted over QPI on the DRS (Data Response) channel.  DRS flits are used to transmit data with coherency.  This does not count data flits transmitted over the NCB channel which transmits non-coherent data.  This includes only the header flits (not the data).  This includes extended headers.",
@@ -1562,6 +1568,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of flits transmitted over QPI on the home channel.",
@@ -1570,6 +1577,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of non-request flits transmitted over QPI on the home channel.  These are most commonly snoop responses, and this event can be used as a proxy for that.",
@@ -1578,6 +1586,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of data request transmitted over QPI on the home channel.  This basically counts the number of remote memory requests transmitted over QPI.  In conjunction with the local read count in the Home Agent, one can calculate the number of LLC Misses.",
@@ -1586,6 +1595,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three groups that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four fits, each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the system will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as data bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual
  data and an additional 16 bits of other information.  To calculate data bandwidth, one should therefore do: data flits * 8B / time.; Counts the number of snoop request flits transmitted over QPI.  These requests are contained in the snoop channel.  This does not include snoop responses, which are transmitted on the home channel.",
@@ -3104,6 +3114,7 @@
     },
     {
         "EventName": "UNC_U_CLOCKTICKS",
+        "EventCode": "0x0",
         "PerPkg": "1",
         "Unit": "UBOX"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index 6550934..869a320 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -131,6 +131,7 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 5df1ebf..0a5d0c3 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index d0edfde..76b515d 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -329,6 +329,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -351,6 +352,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -359,6 +361,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -432,6 +435,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index 63395e7e..160f1c4 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBOX"
@@ -863,6 +864,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This will be slightly different than the count in the Ubox because of enable/freeze delays.  The HA is on the other side of the die from the fixed Ubox uclk counter, so the drift could be somewhat larger than in units that are closer like the QPI Agent.",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 874f15e..45f2966 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -109,6 +109,7 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
+        "EventCode": "0x0",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
@@ -847,6 +848,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual 'data' and an additional 16 bits of other infor
 mation.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -855,6 +857,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Idle and Null Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual 'data' and an additional 16 bits of other infor
 mation.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -863,6 +866,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protocol Tx Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 64 bits of actual 'data' and an additional 16 bits of other infor
 mation.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -871,6 +875,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both Header and Data)",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -879,6 +884,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -887,6 +893,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -895,6 +902,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -903,6 +911,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -911,6 +920,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -919,6 +929,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "EventCode": "0x0",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted across the QPI Link.  This is one of three 'groups' that allow us to track flits.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is made up of 80 bits of information (in addition to some ECC data).  In full-width (L0) mode, flits are made up of four 'fits', each of which contains 20 bits of data (along with some additional ECC data).   In half-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice as many fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate the bandwidth of the link by taking: flits*80b/time.  Note that this is not the same as 'data' bandwidth.  For example, when we are transferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header information and 8 with 6
 4 bits of actual 'data' and an additional 16 bits of other information.  To calculate 'data' bandwidth, one should therefore do: data flits * 8B / time.",
@@ -1576,6 +1587,7 @@
     },
     {
         "EventName": "UNC_U_CLOCKTICKS",
+        "EventCode": "0x0",
         "PerPkg": "1",
         "Unit": "UBOX"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
index 6dcc9415..2385b0a 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
@@ -65,6 +65,7 @@
     },
     {
         "BriefDescription": "uclks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Uncore Fixed Counter - uclks",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index b3ee5d7..f453afd 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
@@ -216,6 +217,7 @@
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
+        "EventCode": "0x0",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when the system is changing frequency.  This can not be filtered by thread ID.  One can also use it with the occupancy counter that monitors number of threads in C0 to estimate the performance impact that frequency transitions had on the system.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 3dc5321..a74d45a 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -150,12 +150,14 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter",
         "SampleAfterValue": "2000003",
@@ -177,6 +179,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions that retire.  For instructions that consist of multiple micro-ops, this event counts exactly once, as the last micro-op of the instruction retires.  The event continues counting while instructions retire, including during interrupt service routines caused by hardware interrupts, faults or traps.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
index 1b8dcfa..c062253 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
@@ -3246,6 +3246,7 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
+        "EventCode": "0x0",
         "EventName": "UNC_H_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
index fb75297..3575baa 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
@@ -41,6 +41,7 @@
     },
     {
         "BriefDescription": "ECLK count",
+        "EventCode": "0x0",
         "EventName": "UNC_E_E_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_ECLK"
@@ -55,6 +56,7 @@
     },
     {
         "BriefDescription": "UCLK count",
+        "EventCode": "0x0",
         "EventName": "UNC_E_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_UCLK"
@@ -93,12 +95,14 @@
     },
     {
         "BriefDescription": "DCLK count",
+        "EventCode": "0x0",
         "EventName": "UNC_M_D_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "UCLK count",
+        "EventCode": "0x0",
         "EventName": "UNC_M_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_UCLK"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 6397894..0de3572 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -37,6 +37,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -51,6 +52,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
@@ -58,6 +60,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately 
 so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -75,6 +78,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -82,6 +86,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -105,6 +110,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "SampleAfterValue": "2000003",
@@ -113,6 +119,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -157,6 +164,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index ecaf94c..973a5f4 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -337,6 +337,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -359,6 +360,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -367,6 +369,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -440,6 +443,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 72e9bdfa..ada2c34 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -284,6 +284,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately 
 so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -299,6 +300,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -426,6 +428,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -457,6 +460,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise-distribution",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a precise distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR++) feature to fix bias in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -719,6 +723,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index 4121295..67be689 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -17,6 +17,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -29,6 +30,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
@@ -43,6 +45,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -55,6 +58,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 2d4214b..6423c01 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -143,6 +143,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios.  The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. In systems with a constant core frequency, this event can give you a measurement of the elapsed time while the core was not in halt state by dividing the event count by the core frequency. This event is architecturally defined and is a designated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the core frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the programmable events are C
 PU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
         "SampleAfterValue": "2000003",
@@ -165,6 +166,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios.  The core frequency may change from time. This event is not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  Divide this event count by core frequency to determine the elapsed time while the core was not in halt state.  Divide this event count by core frequency to determine the elapsed time while the core was not in halt state.  This event is architecturally defined and is a designated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the core frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  The fixed events are
  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
         "SampleAfterValue": "2000003",
@@ -180,6 +182,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions that retire.  For instructions that consist of multiple micro-ops, this event counts exactly once, as the last micro-op of the instruction retires.  The event continues counting while instructions retire, including during interrupt service routines caused by hardware interrupts, faults or traps.  Background: Modern microprocessors employ extensive pipelining and speculative techniques.  Since sometimes an instruction is started but never completed, the notion of \"retirement\" is introduced.  A retired instruction is one that commits its states. Or stated differently, an instruction might be abandoned at some point. No instruction is truly finished until it retires.  This counter measures the number of completed instructions.  The fixed event is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
index 2dfc3af..53f1381 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -182,6 +182,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overfl
 ow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -213,6 +214,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -221,6 +223,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -360,6 +363,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, Counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. Counting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
index 0f06e31..99346e1 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
@@ -191,6 +191,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overfl
 ow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -222,6 +223,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -230,6 +232,7 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -369,6 +372,7 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, Counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. INST_RETIRED.ANY_P is counted by a programmable counter and it is an architectural performance event. Counting: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
index 543dfc1..4df1294 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
@@ -460,6 +460,7 @@
     },
     {
         "BriefDescription": "Clockticks of the uncore caching & home agent (CHA)",
+        "EventCode": "0x0",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts clockticks of the clock controlling the uncore caching and home agent (CHA).",
@@ -5678,6 +5679,7 @@
     {
         "BriefDescription": "This event is deprecated. Refer to new event UNC_CHA_CLOCKTICKS",
         "Deprecated": "1",
+        "EventCode": "0x0",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
index 26a5a20..40f609c 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
@@ -1090,6 +1090,7 @@
     },
     {
         "BriefDescription": "Cycles - at UCLK",
+        "EventCode": "0x0",
         "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "M2M"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
index 2a3a709..21a6a0f 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
@@ -1271,6 +1271,7 @@
     },
     {
         "BriefDescription": "Counting disabled",
+        "EventCode": "0x0",
         "EventName": "UNC_IIO_NOTHING",
         "PerPkg": "1",
         "Unit": "IIO"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
index 6f8ff22..a7ce916 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
@@ -167,6 +167,7 @@
     },
     {
         "BriefDescription": "Memory controller clock ticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts clockticks of the fixed frequency clock of the memory controller using one of the programmable counters.",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
index c6254af..a01b279 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "pclk Cycles",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This event counts the number of pclk cycles measured while the counter was enabled.  The pclk, like the Memory Controller's dclk, counts at a constant rate making it a good measure of actual wall time.",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
index 9dd8c90..3388cd5 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
@@ -150,6 +150,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -179,6 +180,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0.",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
index a68a5bb..279381b 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
@@ -872,6 +872,7 @@
     },
     {
         "BriefDescription": "Uncore cache clock ticks",
+        "EventCode": "0x0",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
index de38400..399536f 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
@@ -1419,6 +1419,7 @@
     },
     {
         "BriefDescription": "Clockticks of the mesh to memory (M2M)",
+        "EventCode": "0x0",
         "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "M2M"
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
index 530e9b71..b24ba35 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
@@ -120,6 +120,7 @@
     },
     {
         "BriefDescription": "Memory controller clock ticks",
+        "EventCode": "0x0",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Clockticks of the integrated memory controller (IMC)",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
index 27fc155..5c04d6e 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Clockticks of the power control unit (PCU)",
+        "EventCode": "0x0",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "PCU"
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index a0aeeb8..54a81f9 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -193,6 +193,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears the overflow status bit and resets the counter to
  less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -208,6 +209,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -352,6 +354,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -377,6 +380,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with a reduced effect of PEBS shadow in IP distribution",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a more unbiased distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR) feature to mitigate some bias in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -569,6 +573,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "EventCode": "0x0",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
-- 
1.8.3.1

