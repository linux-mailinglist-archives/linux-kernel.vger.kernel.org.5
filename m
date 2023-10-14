Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88717C922C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJNBwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJNBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:52:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B144ECC;
        Fri, 13 Oct 2023 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248342; x=1728784342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDh4cqlDk/RietFOmwFIrRy16QcsyoJ9oC6fXSot960=;
  b=cKv6UYyVOyvP/aWBM2R5eCrtajGqadx5CdIHFjU6vuYf/U2ZLCc9K1Fw
   YkgnhV4+NBeEMuJqzcEV57xLfh13kJz/N7nCcVhSl7563NtJ0QrbL+TLT
   miLZOFXHruNywZj0L2drcU8jUS8X6gJJcbck9H68eoVWfFjxd6EKZsBiZ
   oMadTfHokOI9Zaz/T1sm5za84GlBDBlGTArhdft8VYdWpSZekLC4Yotf2
   LyMBdxOYf/YlLrKC8nJ2ZqQsxwsQ606s/Q18/tfcwOLTO1OOawBCJwdF6
   CkHJY67aLfo7HK6gdYbPF/Ejg22hDhb5qUTGCATrYVP+/lfrytFcaLF/a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154687"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154687"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565665"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565665"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:15 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v2 04/17] perf pmu-events: Add counter info into JSON files for SapphireRapids
Date:   Fri, 13 Oct 2023 18:51:49 -0700
Message-Id: <20231014015202.1175377-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

The added new fields are required in the hardware aware grouping method.
Currently, the format of added fields are temporary for experiments.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../arch/x86/sapphirerapids/cache.json        | 104 ++++
 .../arch/x86/sapphirerapids/counter.json      |  17 +
 .../x86/sapphirerapids/floating-point.json    |  25 +
 .../arch/x86/sapphirerapids/frontend.json     |  98 +++-
 .../arch/x86/sapphirerapids/memory.json       |  44 ++
 .../arch/x86/sapphirerapids/other.json        |  40 ++
 .../arch/x86/sapphirerapids/pipeline.json     | 118 ++++
 .../arch/x86/sapphirerapids/uncore-cache.json | 534 +++++++++++++++++-
 .../arch/x86/sapphirerapids/uncore-cxl.json   |  56 ++
 .../sapphirerapids/uncore-interconnect.json   | 476 ++++++++++++++++
 .../arch/x86/sapphirerapids/uncore-io.json    | 373 ++++++++++++
 .../x86/sapphirerapids/uncore-memory.json     | 391 +++++++++++++
 .../arch/x86/sapphirerapids/uncore-power.json |  24 +
 .../x86/sapphirerapids/virtual-memory.json    |  20 +
 14 files changed, 2304 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.j=
son

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 9606e76b9..67d5150f5 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L1D.HWPF_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
         "SampleAfterValue": "1000003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x48",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
+        "Counter": "0,1,2,3",
         "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Number of L1D misses that are outstanding",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
@@ -75,6 +84,7 @@
     },
     {
         "BriefDescription": "L2_LINES_OUT.NON_SILENT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
         "SampleAfterValue": "200003",
@@ -82,6 +92,7 @@
     },
     {
         "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
         "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
@@ -90,6 +101,7 @@
     },
     {
         "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
         "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
@@ -98,6 +110,7 @@
     },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
@@ -106,6 +119,7 @@
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_RQSTS.MISS]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
@@ -114,6 +128,7 @@
     },
     {
         "BriefDescription": "L2 code requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
@@ -122,6 +137,7 @@
     },
     {
         "BriefDescription": "Demand Data Read access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
@@ -130,6 +146,7 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "PublicDescription": "Counts demand requests that miss L2 cache.",
@@ -138,6 +155,7 @@
     },
     {
         "BriefDescription": "Demand requests to L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
         "PublicDescription": "Counts demand requests to L2 cache.",
@@ -146,6 +164,7 @@
     },
     {
         "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
         "SampleAfterValue": "200003",
@@ -153,6 +172,7 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
@@ -169,6 +190,7 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
@@ -177,6 +199,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
@@ -185,6 +208,7 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
@@ -193,6 +217,7 @@
     },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
         "SampleAfterValue": "200003",
@@ -200,6 +225,7 @@
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_REQUEST.MISS]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
@@ -208,6 +234,7 @@
     },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
@@ -216,6 +243,7 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
@@ -224,6 +252,7 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
@@ -232,6 +261,7 @@
     },
     {
         "BriefDescription": "SW prefetch requests that hit L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
         "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
@@ -240,6 +270,7 @@
     },
     {
         "BriefDescription": "SW prefetch requests that miss L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
         "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
@@ -248,6 +279,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
@@ -256,6 +288,7 @@
     },
     {
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
@@ -264,6 +297,7 @@
     },
     {
         "BriefDescription": "Retired load instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
@@ -274,6 +308,7 @@
     },
     {
         "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
@@ -284,6 +319,7 @@
     },
     {
         "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
@@ -294,6 +330,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
@@ -304,6 +341,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
@@ -314,6 +352,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
@@ -324,6 +363,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
@@ -334,6 +374,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
@@ -344,6 +385,7 @@
     },
     {
         "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
         "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
@@ -352,6 +394,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
@@ -362,6 +405,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
@@ -372,6 +416,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
@@ -382,6 +427,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
@@ -392,6 +438,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
@@ -402,6 +449,7 @@
     },
     {
         "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
@@ -411,6 +459,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
was forwarded from a remote cache",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
@@ -421,6 +470,7 @@
     },
     {
         "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
@@ -430,6 +480,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with remote Intel(R=
) Optane(TM) DC persistent memory as the data source where the data request=
 missed all caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
         "PublicDescription": "Counts retired load instructions with remote=
 Intel(R) Optane(TM) DC persistent memory as the data source and the data r=
equest missed L3.",
@@ -438,6 +489,7 @@
     },
     {
         "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
@@ -448,6 +500,7 @@
     },
     {
         "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
@@ -458,6 +511,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
@@ -468,6 +522,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
@@ -478,6 +533,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
@@ -488,6 +544,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
@@ -498,6 +555,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
@@ -508,6 +566,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
@@ -518,6 +577,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with local Intel(R)=
 Optane(TM) DC persistent memory as the data source where the data request =
missed all caches.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
@@ -528,6 +588,7 @@
     },
     {
         "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
         "SampleAfterValue": "200003",
@@ -535,6 +596,7 @@
     },
     {
         "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
         "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
@@ -543,6 +605,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -552,6 +615,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -561,6 +625,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a modified line in a distant L3 Cache or =
were snooped from a distant core's L1/L2 caches on this socket when the sys=
tem is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -570,6 +635,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that either hit a non-modified line in a distant L=
3 Cache or were snooped from a distant core's L1/L2 caches on this socket w=
hen the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -579,6 +645,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -588,6 +655,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -597,6 +665,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -606,6 +675,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -615,6 +685,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit a modified line in another c=
ore's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -624,6 +695,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit in another core's caches whi=
ch forwarded the unmodified data to the requesting core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -633,6 +705,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that hit a modified =
line in a distant L3 Cache or were snooped from a distant core's L1/L2 cach=
es on this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -642,6 +715,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that either hit a no=
n-modified line in a distant L3 Cache or were snooped from a distant core's=
 L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) m=
ode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -651,6 +725,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -660,6 +735,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -669,6 +745,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
modified line in a distant L3 Cache or were snooped from a distant core's L=
1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mod=
e.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -678,6 +755,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that either=
 hit a non-modified line in a distant L3 Cache or were snooped from a dista=
nt core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA c=
luster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -687,6 +765,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit in the L3 or were snooped from another core's caches on the same sock=
et.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -696,6 +775,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit in the L3 or were snooped from another core's caches on the sa=
me socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -705,6 +785,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit a modified line in another core's caches w=
hich forwarded the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -714,6 +795,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop that hit in another core, which did not forwar=
d the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -723,6 +805,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit in another core's caches which forwarded t=
he unmodified data to the requesting core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -732,6 +815,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop was sent=
 and data was returned (Modified or Not Modified).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -741,6 +825,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit a mo=
dified line in another core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -750,6 +835,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit in a=
nother core's caches which forwarded the unmodified data to the requesting =
core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -759,6 +845,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit a modified line in a distant L3 Cache or were snooped from a d=
istant core's L1/L2 caches on this socket when the system is in SNC (sub-NU=
MA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -768,6 +855,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that either hit a non-modified line in a distant L3 Cache or were snoop=
ed from a distant core's L1/L2 caches on this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -777,6 +865,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO), hard=
ware prefetch RFOs (which bring data to L2), and software prefetches for ex=
clusive ownership (PREFETCHW) that hit to a (M)odified cacheline in the L3 =
or snoop filter.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.RFO_TO_CORE.L3_HIT_M",
         "MSRIndex": "0x1a6,0x1a7",
@@ -786,6 +875,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -795,6 +885,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "SampleAfterValue": "100003",
@@ -802,6 +893,7 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
@@ -810,6 +902,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
@@ -818,6 +911,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "Counter": "0,1,2,3",
         "Deprecated": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -826,6 +920,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA=
_RD",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
@@ -834,6 +929,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
@@ -842,6 +938,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMA=
ND_RFO",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
@@ -850,6 +947,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "SampleAfterValue": "1000003",
@@ -857,6 +955,7 @@
     },
     {
         "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
         "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
@@ -865,6 +964,7 @@
     },
     {
         "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
@@ -873,6 +973,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
         "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
@@ -881,6 +982,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
         "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
@@ -889,6 +991,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
         "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
@@ -897,6 +1000,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json b/t=
ools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
new file mode 100644
index 000000000..300d9046c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
@@ -0,0 +1,17 @@
+[
+  {
+      "Unit": "Core",
+      "Size": "8",
+      "FixedSize": "4"
+  },
+  {
+      "Unit": "UBOX",
+      "Size": "2",
+      "FixedSize": "0"
+  },
+  {
+      "Unit": "IRP",
+      "Size": "2",
+      "FixedSize": "0"
+  }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 4a9d211e9..5b144ac50 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "ARITH.FPDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts all microcode FP assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
         "PublicDescription": "Counts all microcode Floating Point assists.=
",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "ASSISTS.SSE_AVX_MIX",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
         "SampleAfterValue": "1000003",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "SampleAfterValue": "2000003",
@@ -31,6 +35,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "SampleAfterValue": "2000003",
@@ -38,6 +43,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "SampleAfterValue": "2000003",
@@ -45,6 +51,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
@@ -53,6 +60,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
@@ -61,6 +69,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
@@ -69,6 +78,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
@@ -77,6 +87,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events.",
@@ -85,6 +96,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
@@ -93,6 +105,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
@@ -101,6 +114,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision and 512-bit packed double precision  FP instructions ret=
ired; some instructions will count twice as noted below.  Each count repres=
ents 8 computation operations, 1 for each element.  Applies to SSE* and AVX=
* packed single precision and double precision FP instructions: ADD SUB HAD=
D HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB count twice as they perform 2 calculations per elem=
ent.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
@@ -109,6 +123,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
@@ -117,6 +132,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
@@ -125,6 +141,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
@@ -133,6 +150,7 @@
     },
     {
         "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
         "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
@@ -141,6 +159,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
         "SampleAfterValue": "100003",
@@ -148,6 +167,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
         "SampleAfterValue": "100003",
@@ -155,6 +175,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
         "SampleAfterValue": "100003",
@@ -162,6 +183,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
         "SampleAfterValue": "100003",
@@ -169,6 +191,7 @@
     },
     {
         "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
         "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
@@ -177,6 +200,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
         "SampleAfterValue": "100003",
@@ -184,6 +208,7 @@
     },
     {
         "BriefDescription": "Number of all Vector (also called packed) Hal=
f-Precision FP arithmetic instructions(1) retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
         "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 860a415e5..b89f07e7c 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Clears due to Unknown Branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
         "SampleAfterValue": "500009",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -39,10 +44,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -50,10 +57,12 @@
         "PEBS": "1",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
@@ -61,10 +70,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
@@ -72,10 +83,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
@@ -83,10 +96,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
@@ -94,10 +109,12 @@
         "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
@@ -105,10 +122,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
@@ -116,10 +135,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
@@ -127,10 +148,12 @@
         "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
@@ -138,10 +161,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
@@ -149,10 +174,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
@@ -160,10 +187,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
@@ -171,10 +200,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
@@ -182,10 +213,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
@@ -193,10 +226,12 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
@@ -204,20 +239,24 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
         "PEBS": "1",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
@@ -225,20 +264,24 @@
         "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
         "PEBS": "1",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
@@ -247,6 +290,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
         "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
@@ -255,6 +299,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
@@ -264,6 +309,7 @@
     },
     {
         "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
@@ -273,6 +319,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
@@ -281,6 +328,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
@@ -290,6 +338,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
@@ -299,6 +348,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
@@ -307,6 +357,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
@@ -316,6 +367,7 @@
     },
     {
         "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -326,6 +378,7 @@
     },
     {
         "BriefDescription": "Uops delivered to IDQ while MS is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
@@ -333,29 +386,62 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE=
]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CORE",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_BUBBLES.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index e8bf7c9c4..4c1f257bf 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -59,10 +66,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -71,10 +80,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -83,10 +94,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -95,10 +108,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -107,10 +122,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -119,10 +136,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -131,10 +150,12 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -143,6 +164,7 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
+        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
@@ -157,6 +179,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -166,6 +189,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -175,6 +199,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -184,6 +209,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t missed the local socket's L1, L2, and L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -193,6 +219,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline is homed locally.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -202,6 +229,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -211,6 +239,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and t=
he cacheline is homed locally.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -220,6 +249,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that missed the L3 Cache and were supplied by the local socket (DRAM or=
 PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PM=
M or DRAM accesses that are controlled by the close or distant SNC Cluster.=
  It does not count misses to the L3 which go to Local CXL Type 2 Memory or=
 Local Non DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
         "MSRIndex": "0x1a6,0x1a7",
@@ -229,6 +259,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that missed the local=
 socket's L1, L2, and L3 caches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -238,6 +269,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that were not supplie=
d by the local socket's L1, L2, or L3 caches and the cacheline is homed loc=
ally.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -247,6 +279,7 @@
     },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "SampleAfterValue": "100003",
@@ -254,6 +287,7 @@
     },
     {
         "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD",
         "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
@@ -262,6 +296,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
@@ -270,6 +305,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 4 categories (e.g. interrupt).",
@@ -278,6 +314,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEM",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
@@ -286,6 +323,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
@@ -294,6 +332,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
@@ -302,6 +341,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
         "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
@@ -310,6 +350,7 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution started.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
         "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
@@ -318,6 +359,7 @@
     },
     {
         "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_READ",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
@@ -326,6 +368,7 @@
     },
     {
         "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
@@ -334,6 +377,7 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
         "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 442ef3807..5a5ead85b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
         "SampleAfterValue": "1000003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb7",
         "EventName": "EXE.AMX_BUSY",
         "SampleAfterValue": "2000003",
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM on a distant memory con=
troller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -60,6 +67,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -69,6 +77,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -78,6 +87,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode=
.  In SNC Mode counts PMM accesses that are controlled by the close or dist=
ant SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_SOCKET_PMM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -87,6 +97,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y PMM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.PMM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -96,6 +107,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -105,6 +117,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to another socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_PMM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -114,6 +127,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM on a distant memory controller of this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -123,6 +137,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -132,6 +147,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -141,6 +157,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -150,6 +167,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM on a distant memory controller of this socket when the syst=
em is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -159,6 +177,7 @@
     },
     {
         "BriefDescription": "Counts data load hardware prefetch requests t=
o the L1 data cache that have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L1D.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -168,6 +187,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -177,6 +197,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -186,6 +207,7 @@
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.REMOTE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -195,6 +217,7 @@
     },
     {
         "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -204,6 +227,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -213,6 +237,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -222,6 +247,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -231,6 +257,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -240,6 +267,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to this socket, whether or not in Su=
b NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are control=
led by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -249,6 +277,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -258,6 +287,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -267,6 +297,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -276,6 +307,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to another socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_PMM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -285,6 +317,7 @@
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -294,6 +327,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -303,6 +337,7 @@
     },
     {
         "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
         "MSRIndex": "0x1a6,0x1a7",
@@ -312,6 +347,7 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
@@ -320,6 +356,7 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
@@ -331,6 +368,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EdgeDetect": "1",
@@ -342,6 +380,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
@@ -350,6 +389,7 @@
     },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 6dcf3b763..d52c264fa 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "AMX retired arithmetic BF16 operations.",
+        "Counter": "0",
         "EventCode": "0xce",
         "EventName": "AMX_OPS_RETIRED.BF16",
         "PublicDescription": "Number of AMX-based retired arithmetic bfloa=
t16 (BF16) floating-point operations. Counts TDPBF16PS FP instructions. SW =
to use operation multiplier of 4",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "AMX retired arithmetic integer 8-bit operatio=
ns.",
+        "Counter": "0",
         "EventCode": "0xce",
         "EventName": "AMX_OPS_RETIRED.INT8",
         "PublicDescription": "Number of AMX-based retired arithmetic integ=
er operations of 8-bit width source operands. Counts TDPB[SS,UU,US,SU]D ins=
tructions. SW should use operation multiplier of 8.",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -44,6 +49,7 @@
     },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
@@ -52,6 +58,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -61,6 +68,7 @@
     },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
         "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
@@ -69,6 +77,7 @@
     },
     {
         "BriefDescription": "All branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -77,6 +86,7 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
@@ -86,6 +96,7 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
         "PEBS": "1",
@@ -95,6 +106,7 @@
     },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -104,6 +116,7 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -113,6 +126,7 @@
     },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -122,6 +136,7 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -131,6 +146,7 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -140,6 +156,7 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -149,6 +166,7 @@
     },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -157,6 +175,7 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
@@ -166,6 +185,7 @@
     },
     {
         "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
         "PEBS": "1",
@@ -175,6 +195,7 @@
     },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -184,6 +205,7 @@
     },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -193,6 +215,7 @@
     },
     {
         "BriefDescription": "Mispredicted indirect CALL retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -202,6 +225,7 @@
     },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -211,6 +235,7 @@
     },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
@@ -220,6 +245,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
@@ -228,6 +254,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
@@ -236,6 +263,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
@@ -244,6 +272,7 @@
     },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
@@ -252,6 +281,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
@@ -260,6 +290,7 @@
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
         "SampleAfterValue": "2000003",
@@ -267,6 +298,7 @@
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xec",
@@ -276,6 +308,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
         "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
@@ -284,6 +317,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -291,6 +325,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
@@ -299,6 +334,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -306,6 +342,7 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
@@ -313,6 +350,7 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
@@ -321,6 +359,7 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
@@ -329,6 +368,7 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
@@ -337,6 +377,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
@@ -345,6 +386,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
@@ -353,6 +395,7 @@
     },
     {
         "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
@@ -361,6 +404,7 @@
     },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
@@ -369,6 +413,7 @@
     },
     {
         "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
@@ -377,6 +422,7 @@
     },
     {
         "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -385,6 +431,7 @@
     },
     {
         "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -393,6 +440,7 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
@@ -401,6 +449,7 @@
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
@@ -410,6 +459,7 @@
     },
     {
         "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
         "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
@@ -418,6 +468,7 @@
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
@@ -426,6 +477,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -434,6 +486,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -442,6 +495,7 @@
     },
     {
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
         "SampleAfterValue": "2000003",
@@ -449,6 +503,7 @@
     },
     {
         "BriefDescription": "Retired NOP instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
@@ -457,6 +512,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -465,6 +521,7 @@
     },
     {
         "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
@@ -473,6 +530,7 @@
     },
     {
         "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xad",
@@ -483,6 +541,7 @@
     },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
         "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
@@ -491,6 +550,7 @@
     },
     {
         "BriefDescription": "INT_MISC.MBA_STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.MBA_STALLS",
         "SampleAfterValue": "1000003",
@@ -498,6 +558,7 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
         "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
@@ -506,15 +567,18 @@
     },
     {
         "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
         "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "TMA slots where uops got dropped",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
@@ -523,6 +587,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.128BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
         "SampleAfterValue": "1000003",
@@ -530,6 +595,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.256BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
         "SampleAfterValue": "1000003",
@@ -537,6 +603,7 @@
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
@@ -545,6 +612,7 @@
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
@@ -553,6 +621,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
         "SampleAfterValue": "1000003",
@@ -560,6 +629,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
         "SampleAfterValue": "1000003",
@@ -567,6 +637,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
         "SampleAfterValue": "1000003",
@@ -574,6 +645,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
         "SampleAfterValue": "1000003",
@@ -581,6 +653,7 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
@@ -589,6 +662,7 @@
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
@@ -597,6 +671,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
@@ -605,6 +680,7 @@
     },
     {
         "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
@@ -613,6 +689,7 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -622,6 +699,7 @@
     },
     {
         "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
@@ -631,6 +709,7 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
         "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
@@ -639,6 +718,7 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xc3",
@@ -649,6 +729,7 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
@@ -657,6 +738,7 @@
     },
     {
         "BriefDescription": "LFENCE instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
         "PublicDescription": "number of LFENCE retired instructions",
@@ -665,6 +747,7 @@
     },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
@@ -673,6 +756,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
@@ -681,6 +765,7 @@
     },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
         "SampleAfterValue": "100003",
@@ -688,6 +773,7 @@
     },
     {
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
         "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
@@ -712,6 +798,7 @@
     },
     {
         "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "SampleAfterValue": "10000003",
@@ -719,6 +806,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
@@ -726,6 +814,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
@@ -734,6 +823,7 @@
     },
     {
         "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
         "SampleAfterValue": "1000003",
@@ -741,6 +831,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 0",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
         "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
@@ -749,6 +840,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
         "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
@@ -757,6 +849,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 2, 3 and 10",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
         "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
@@ -765,6 +858,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 4 and 9",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
         "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
@@ -773,6 +867,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 5 and 11",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
         "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
@@ -781,6 +876,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 6",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
         "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
@@ -789,6 +885,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 7 and 8",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
         "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
@@ -797,6 +894,7 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE",
         "PublicDescription": "Counts the number of uops executed from any =
thread.",
@@ -805,6 +903,7 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -814,6 +913,7 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -823,6 +923,7 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -832,6 +933,7 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -841,6 +943,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
@@ -850,6 +953,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
@@ -859,6 +963,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
@@ -868,6 +973,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
@@ -877,6 +983,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
@@ -887,6 +994,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_EXECUTED.STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb1",
@@ -897,6 +1005,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -904,6 +1013,7 @@
     },
     {
         "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
         "PublicDescription": "Counts the number of x87 uops executed.",
@@ -912,6 +1022,7 @@
     },
     {
         "BriefDescription": "Uops that RAT issues to RS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
@@ -920,6 +1031,7 @@
     },
     {
         "BriefDescription": "Cycles with retired uop(s).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
@@ -929,6 +1041,7 @@
     },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
         "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
@@ -937,15 +1050,18 @@
     },
     {
         "BriefDescription": "UOPS_RETIRED.MS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
         "SampleAfterValue": "2000003",
+        "TakenAlone": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Retirement slots used.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
         "PublicDescription": "Counts the retirement slots used each cycle.=
",
@@ -954,6 +1070,7 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
@@ -964,6 +1081,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_RETIRED.STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xc2",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index 3fa660694..fc3ecfc0e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "CHA to iMC Bypass : Intermediate bypass Taken=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_CHA_BYPASS_CHA_IMC.INTERMEDIATE",
         "PerPkg": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Bypass : Not Taken",
+        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_CHA_BYPASS_CHA_IMC.NOT_TAKEN",
         "PerPkg": "1",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Bypass : Taken",
+        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_CHA_BYPASS_CHA_IMC.TAKEN",
         "PerPkg": "1",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "CHA Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
@@ -36,6 +40,7 @@
     },
     {
         "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_CHA_CMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Any Cycle with Mul=
tiple Snoops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.ANY_GTONE",
         "PerPkg": "1",
@@ -52,6 +58,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Any Single Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.ANY_ONE",
         "PerPkg": "1",
@@ -61,6 +68,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Multiple Core Requ=
ests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
         "PerPkg": "1",
@@ -70,6 +78,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Single Core Reques=
ts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.CORE_ONE",
         "PerPkg": "1",
@@ -79,6 +88,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Multiple Eviction",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
         "PerPkg": "1",
@@ -88,6 +98,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Single Eviction",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EVICT_ONE",
         "PerPkg": "1",
@@ -97,6 +108,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Multiple External =
Snoops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EXT_GTONE",
         "PerPkg": "1",
@@ -106,6 +118,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Single External Sn=
oops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EXT_ONE",
         "PerPkg": "1",
@@ -115,6 +128,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Multiple Snoop Tar=
gets from Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.REMOTE_GTONE",
         "PerPkg": "1",
@@ -124,6 +138,7 @@
     },
     {
         "BriefDescription": "Core Cross Snoops Issued : Single Snoop Targe=
t from Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.REMOTE_ONE",
         "PerPkg": "1",
@@ -133,6 +148,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6e",
         "EventName": "UNC_CHA_DIRECT_GO.HA_SUPPRESS_DRD",
         "PerPkg": "1",
@@ -141,6 +157,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6e",
         "EventName": "UNC_CHA_DIRECT_GO.HA_SUPPRESS_NO_D2C",
         "PerPkg": "1",
@@ -149,6 +166,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6e",
         "EventName": "UNC_CHA_DIRECT_GO.HA_TOR_DEALLOC",
         "PerPkg": "1",
@@ -157,6 +175,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.EXTCMP",
         "PerPkg": "1",
@@ -165,6 +184,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.FAST_GO",
         "PerPkg": "1",
@@ -173,6 +193,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.FAST_GO_PULL",
         "PerPkg": "1",
@@ -181,6 +202,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.GO",
         "PerPkg": "1",
@@ -189,6 +211,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.GO_PULL",
         "PerPkg": "1",
@@ -197,6 +220,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.IDLE_DUE_SUPPRESS",
         "PerPkg": "1",
@@ -205,6 +229,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.NOP",
         "PerPkg": "1",
@@ -213,6 +238,7 @@
     },
     {
         "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6d",
         "EventName": "UNC_CHA_DIRECT_GO_OPC.PULL",
         "PerPkg": "1",
@@ -221,6 +247,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Not Needed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
         "PerPkg": "1",
@@ -230,6 +257,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Needed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
         "PerPkg": "1",
@@ -239,6 +267,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from the HA pipe",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.HA",
         "PerPkg": "1",
@@ -248,6 +277,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from TOR pipe",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.TOR",
         "PerPkg": "1",
@@ -257,6 +287,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_DN",
         "PerPkg": "1",
@@ -266,6 +297,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_UP",
         "PerPkg": "1",
@@ -275,6 +307,7 @@
     },
     {
         "BriefDescription": "Read request from a remote socket which hit i=
n the HitMe Cache to a line In the E state",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
         "PerPkg": "1",
@@ -284,6 +317,7 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache : Shared=
 hit and op is RdInvOwn, RdInv, Inv*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_CHA_HITME_HIT.SHARED_OWNREQ",
         "PerPkg": "1",
@@ -292,6 +326,7 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache : op is =
WbMtoE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_CHA_HITME_HIT.WBMTOE",
         "PerPkg": "1",
@@ -300,6 +335,7 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache : op is =
WbMtoI, WbPushMtoI, WbFlush, or WbMtoS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_CHA_HITME_HIT.WBMTOI_OR_S",
         "PerPkg": "1",
@@ -308,6 +344,7 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d : op is RdCode, RdData, RdDataMigratory, RdCur, RdInvOwn, RdInv, Inv*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5e",
         "EventName": "UNC_CHA_HITME_LOOKUP.READ",
         "PerPkg": "1",
@@ -316,6 +353,7 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d : op is WbMtoE, WbMtoI, WbPushMtoI, WbFlush, or WbMtoS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5e",
         "EventName": "UNC_CHA_HITME_LOOKUP.WRITE",
         "PerPkg": "1",
@@ -324,6 +362,7 @@
     },
     {
         "BriefDescription": "Counts Number of Misses in HitMe Cache : No S=
F/LLC HitS/F and op is RdInvOwn",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_CHA_HITME_MISS.NOTSHARED_RDINVOWN",
         "PerPkg": "1",
@@ -332,6 +371,7 @@
     },
     {
         "BriefDescription": "Counts Number of Misses in HitMe Cache : op i=
s RdCode, RdData, RdDataMigratory, RdCur, RdInv, Inv*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_CHA_HITME_MISS.READ_OR_INV",
         "PerPkg": "1",
@@ -340,6 +380,7 @@
     },
     {
         "BriefDescription": "Counts Number of Misses in HitMe Cache : SF/L=
LC HitS/F and op is RdInvOwn",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_CHA_HITME_MISS.SHARED_RDINVOWN",
         "PerPkg": "1",
@@ -348,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache : Deallocate HitME$ on Reads without RspFwdI*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_CHA_HITME_UPDATE.DEALLOCATE",
         "PerPkg": "1",
@@ -356,6 +398,7 @@
     },
     {
         "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache : op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_CHA_HITME_UPDATE.DEALLOCATE_RSPFWDI_LOC",
         "PerPkg": "1",
@@ -365,6 +408,7 @@
     },
     {
         "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache : Update HitMe Cache on RdInvOwn even if not RspFwdI*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_CHA_HITME_UPDATE.RDINVOWN",
         "PerPkg": "1",
@@ -373,6 +417,7 @@
     },
     {
         "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache : op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_CHA_HITME_UPDATE.RSPFWDI_REM",
         "PerPkg": "1",
@@ -382,6 +427,7 @@
     },
     {
         "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache : Update HitMe Cache to SHARed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_CHA_HITME_UPDATE.SHARED",
         "PerPkg": "1",
@@ -390,6 +436,7 @@
     },
     {
         "BriefDescription": "Normal priority reads issued to the memory co=
ntroller from the CHA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
         "PerPkg": "1",
@@ -399,6 +446,7 @@
     },
     {
         "BriefDescription": "HA to iMC Reads Issued : ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_IMC_READS_COUNT.PRIORITY",
         "PerPkg": "1",
@@ -408,6 +456,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued; Full Line=
 Non-ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
         "PerPkg": "1",
@@ -417,6 +466,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
         "PerPkg": "1",
@@ -426,6 +476,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
         "PerPkg": "1",
@@ -435,6 +486,7 @@
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
         "PerPkg": "1",
@@ -444,6 +496,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Any Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.ALL",
         "PerPkg": "1",
@@ -453,6 +506,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : All transactions from Remote =
Agents",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.ALL_REMOTE",
         "PerPkg": "1",
@@ -462,6 +516,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : All Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.ANY_F",
         "PerPkg": "1",
@@ -470,6 +525,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : CRd Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
         "PerPkg": "1",
@@ -479,6 +535,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : CRd Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.CODE_READ_F",
         "PerPkg": "1",
@@ -487,6 +544,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Local non-prefetch requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.COREPREF_OR_DMND_LOCAL_F",
         "PerPkg": "1",
@@ -495,6 +553,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
         "PerPkg": "1",
@@ -504,6 +563,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Data Reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
         "PerPkg": "1",
@@ -513,6 +573,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Data Read Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_F",
         "PerPkg": "1",
@@ -521,6 +582,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Demand Data Reads, Core and L=
LC prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
         "PerPkg": "1",
@@ -530,6 +592,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Data Read Misses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
         "PerPkg": "1",
@@ -539,6 +602,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : E State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.E",
         "PerPkg": "1",
@@ -548,6 +612,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : F State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.F",
         "PerPkg": "1",
@@ -557,6 +622,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Flush or Invalidate Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.FLUSH_INV",
         "PerPkg": "1",
@@ -566,6 +632,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Flush",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.FLUSH_OR_INV_F",
         "PerPkg": "1",
@@ -574,6 +641,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.I",
         "PerPkg": "1",
@@ -583,6 +651,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Local LLC prefetch requests (=
from LLC)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LLCPREF_LOCAL_F",
         "PerPkg": "1",
@@ -591,6 +660,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Transactions homed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCALLY_HOMED_ADDRESS",
         "PerPkg": "1",
@@ -600,6 +670,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : CRd Requests that come from t=
he local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_CODE",
         "PerPkg": "1",
@@ -609,6 +680,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DATA_RD",
         "PerPkg": "1",
@@ -618,6 +690,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Demand CRd Requests that come=
 from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_CODE",
         "PerPkg": "1",
@@ -627,6 +700,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Demand Data R=
eads that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_DATA_RD",
         "PerPkg": "1",
@@ -636,6 +710,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Demand RFO Requests that come=
 from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_RFO",
         "PerPkg": "1",
@@ -645,6 +720,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Transactions homed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_F",
         "PerPkg": "1",
@@ -653,6 +729,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Flush or Invalidate Requests =
that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_FLUSH_INV",
         "PerPkg": "1",
@@ -662,6 +739,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Prefetch requ=
ests to the LLC that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_LLC_PF",
         "PerPkg": "1",
@@ -671,6 +749,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Pre=
fetches that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF",
         "PerPkg": "1",
@@ -680,6 +759,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : CRd Prefetches that come from=
 the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_CODE",
         "PerPkg": "1",
@@ -689,6 +769,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Pre=
fetches that come from the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_DATA_RD",
         "PerPkg": "1",
@@ -698,6 +779,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : RFO Prefetches that come from=
 the local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_RFO",
         "PerPkg": "1",
@@ -707,6 +789,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : RFO Requests that come from t=
he local socket (usually the core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_RFO",
         "PerPkg": "1",
@@ -716,6 +799,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : M State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.M",
         "PerPkg": "1",
@@ -725,6 +809,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : All Misses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.MISS_ALL",
         "PerPkg": "1",
@@ -734,6 +819,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Write Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.OTHER_REQ_F",
         "PerPkg": "1",
@@ -742,6 +828,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Remote non-snoop requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.PREF_OR_DMND_REMOTE_F",
         "PerPkg": "1",
@@ -750,6 +837,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Transactions homed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTELY_HOMED_ADDRESS",
         "PerPkg": "1",
@@ -759,6 +847,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : CRd Requests that come from a=
 Remote socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_CODE",
         "PerPkg": "1",
@@ -768,6 +857,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uests that come from a Remote socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_DATA_RD",
         "PerPkg": "1",
@@ -777,6 +867,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Transactions homed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_F",
         "PerPkg": "1",
@@ -785,6 +876,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Flush or Invalidate requests =
that come from a Remote socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_FLUSH_INV",
         "PerPkg": "1",
@@ -794,6 +886,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Filters Requests for those th=
at write info into the cache that come from a remote socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_OTHER",
         "PerPkg": "1",
@@ -803,6 +896,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : RFO Requests that come from a=
 Remote socket.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_RFO",
         "PerPkg": "1",
@@ -812,6 +906,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Remote snoop requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNOOP_F",
         "PerPkg": "1",
@@ -820,6 +915,7 @@
     },
     {
         "BriefDescription": "Cache and Snoop Filter Lookups; Snoop Request=
s from a Remote Socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
         "PerPkg": "1",
@@ -829,6 +925,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : RFO Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
         "PerPkg": "1",
@@ -838,6 +935,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : RFO Request Filter",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO_F",
         "PerPkg": "1",
@@ -846,6 +944,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Locally HOMed RFOs - Demand a=
nd Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
         "PerPkg": "1",
@@ -855,6 +954,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.S",
         "PerPkg": "1",
@@ -864,6 +964,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : SnoopFilter - E State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.SF_E",
         "PerPkg": "1",
@@ -873,6 +974,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : SnoopFilter - H State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.SF_H",
         "PerPkg": "1",
@@ -882,6 +984,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : SnoopFilter - S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.SF_S",
         "PerPkg": "1",
@@ -891,6 +994,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
         "PerPkg": "1",
@@ -900,6 +1004,7 @@
     },
     {
         "BriefDescription": "Cache Lookups : Remote Writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_REMOTE",
         "PerPkg": "1",
@@ -909,6 +1014,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : Lines in E state",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
@@ -918,6 +1024,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : IA traffic",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IA",
         "PerPkg": "1",
@@ -927,6 +1034,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : IO traffic",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO",
         "PerPkg": "1",
@@ -936,6 +1044,7 @@
     },
     {
         "BriefDescription": "All LLC lines in E state that are victimized =
on a fill from an IO device",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO_E",
         "PerPkg": "1",
@@ -945,6 +1054,7 @@
     },
     {
         "BriefDescription": "All LLC lines in F or S state that are victim=
ized on a fill from an IO device",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO_FS",
         "PerPkg": "1",
@@ -954,6 +1064,7 @@
     },
     {
         "BriefDescription": "All LLC lines in M state that are victimized =
on a fill from an IO device",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO_M",
         "PerPkg": "1",
@@ -963,6 +1074,7 @@
     },
     {
         "BriefDescription": "All LLC lines in any state that are victimize=
d on a fill from an IO device",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO_MESF",
         "PerPkg": "1",
@@ -972,6 +1084,7 @@
     },
     {
         "BriefDescription": "Lines Victimized; Local - All Lines",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
         "PerPkg": "1",
@@ -981,6 +1094,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
         "PerPkg": "1",
@@ -990,6 +1104,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
         "PerPkg": "1",
@@ -999,6 +1114,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : Local Only",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ONLY",
         "PerPkg": "1",
@@ -1007,6 +1123,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
         "PerPkg": "1",
@@ -1016,6 +1133,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : Lines in M state",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
@@ -1025,6 +1143,7 @@
     },
     {
         "BriefDescription": "Lines Victimized; Remote - All Lines",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
         "PerPkg": "1",
@@ -1034,6 +1153,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_E",
         "PerPkg": "1",
@@ -1043,6 +1163,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_M",
         "PerPkg": "1",
@@ -1052,6 +1173,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : Remote Only",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ONLY",
         "PerPkg": "1",
@@ -1060,6 +1182,7 @@
     },
     {
         "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_S",
         "PerPkg": "1",
@@ -1069,6 +1192,7 @@
     },
     {
         "BriefDescription": "Lines Victimized : Lines in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
@@ -1078,6 +1202,7 @@
     },
     {
         "BriefDescription": "All LLC lines in E state that are victimized =
on a fill",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
         "PerPkg": "1",
@@ -1087,6 +1212,7 @@
     },
     {
         "BriefDescription": "All LLC lines in M state that are victimized =
on a fill",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
         "PerPkg": "1",
@@ -1096,6 +1222,7 @@
     },
     {
         "BriefDescription": "All LLC lines in S state that are victimized =
on a fill",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
         "PerPkg": "1",
@@ -1105,6 +1232,7 @@
     },
     {
         "BriefDescription": "Cbo Misc : CV0 Prefetch Miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.CV0_PREF_MISS",
         "PerPkg": "1",
@@ -1114,6 +1242,7 @@
     },
     {
         "BriefDescription": "Cbo Misc : CV0 Prefetch Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.CV0_PREF_VIC",
         "PerPkg": "1",
@@ -1123,6 +1252,7 @@
     },
     {
         "BriefDescription": "Number of times that an RFO hit in S state.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -1132,6 +1262,7 @@
     },
     {
         "BriefDescription": "Cbo Misc : Silent Snoop Eviction",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
@@ -1141,6 +1272,7 @@
     },
     {
         "BriefDescription": "Cbo Misc : Write Combining Aliasing",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.WC_ALIASING",
         "PerPkg": "1",
@@ -1150,6 +1282,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Local InvItoE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
         "PerPkg": "1",
@@ -1159,6 +1292,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Local Rd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.LOCAL_READ",
         "PerPkg": "1",
@@ -1168,6 +1302,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Off",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.OFF_PWRHEURISTIC",
         "PerPkg": "1",
@@ -1177,6 +1312,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Remote Rd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.REMOTE_READ",
         "PerPkg": "1",
@@ -1186,6 +1322,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Remote Rd InvItoE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.REMOTE_READINVITOE",
         "PerPkg": "1",
@@ -1195,6 +1332,7 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : RFO HitS Snoop Broadcas=
t",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.RFO_HITS_SNP_BCAST",
         "PerPkg": "1",
@@ -1204,6 +1342,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x65",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.LOCAL",
         "PerPkg": "1",
@@ -1212,6 +1351,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.REMOTE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x65",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.REMOTE",
         "PerPkg": "1",
@@ -1220,6 +1360,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.SETCONFLICT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x65",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_INVITOX.SETCONFLICT",
         "PerPkg": "1",
@@ -1228,6 +1369,7 @@
     },
     {
         "BriefDescription": "Memory Mode related events; Counts the number=
 of times CHA saw a Near Memory set conflict in SF/LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x64",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS.LLC",
         "PerPkg": "1",
@@ -1237,6 +1379,7 @@
     },
     {
         "BriefDescription": "Memory Mode related events; Counts the number=
 of times CHA saw a Near memory set conflict in SF/LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x64",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS.SF",
         "PerPkg": "1",
@@ -1246,6 +1389,7 @@
     },
     {
         "BriefDescription": "Memory Mode related events; Counts the number=
 of times CHA saw a Near Memory set conflict in TOR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x64",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS.TOR",
         "PerPkg": "1",
@@ -1255,6 +1399,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.IODC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.IODC",
         "PerPkg": "1",
@@ -1263,6 +1408,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.MEMWR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.MEMWR",
         "PerPkg": "1",
@@ -1271,6 +1417,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.MEMWRNI",
+        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_CHA_PMM_MEMMODE_NM_SETCONFLICTS2.MEMWRNI",
         "PerPkg": "1",
@@ -1279,6 +1426,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.DDR4_FAST_INSERT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.DDR4_FAST_INSERT",
         "PerPkg": "1",
@@ -1287,6 +1435,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.REJ_IRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.REJ_IRQ",
         "PerPkg": "1",
@@ -1295,6 +1444,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.SLOWTORQ_SKIP",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.SLOWTORQ_SKIP",
         "PerPkg": "1",
@@ -1303,6 +1453,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.SLOW_INSERT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.SLOW_INSERT",
         "PerPkg": "1",
@@ -1311,6 +1462,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.THROTTLE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.THROTTLE",
         "PerPkg": "1",
@@ -1319,6 +1471,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.THROTTLE_IRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.THROTTLE_IRQ",
         "PerPkg": "1",
@@ -1327,6 +1480,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS.THROTTLE_PRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_CHA_PMM_QOS.THROTTLE_PRQ",
         "PerPkg": "1",
@@ -1335,6 +1489,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_PMM_QOS_OCCUPANCY.DDR_FAST_FIFO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_CHA_PMM_QOS_OCCUPANCY.DDR_FAST_FIFO",
         "PerPkg": "1",
@@ -1344,6 +1499,7 @@
     },
     {
         "BriefDescription": "Number of SLOW TOR Request inserted to ha_pmm=
_tor_req_fifo",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_CHA_PMM_QOS_OCCUPANCY.DDR_SLOW_FIFO",
         "PerPkg": "1",
@@ -1352,6 +1508,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC0",
         "PerPkg": "1",
@@ -1361,6 +1518,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC1",
         "PerPkg": "1",
@@ -1370,6 +1528,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC2",
         "PerPkg": "1",
@@ -1379,6 +1538,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC3",
         "PerPkg": "1",
@@ -1388,6 +1548,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC4",
         "PerPkg": "1",
@@ -1397,6 +1558,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_CHA_READ_NO_CREDITS.MC5",
         "PerPkg": "1",
@@ -1406,6 +1568,7 @@
     },
     {
         "BriefDescription": "Requests for exclusive ownership of a cache l=
ine without receiving data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE",
         "PerPkg": "1",
@@ -1415,6 +1578,7 @@
     },
     {
         "BriefDescription": "Local requests for exclusive ownership of a c=
ache line  without receiving data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -1424,6 +1588,7 @@
     },
     {
         "BriefDescription": "Remote requests for exclusive ownership of a =
cache line  without receiving data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -1433,6 +1598,7 @@
     },
     {
         "BriefDescription": "Read requests made into the CHA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS",
         "PerPkg": "1",
@@ -1442,6 +1608,7 @@
     },
     {
         "BriefDescription": "Read requests from a unit on this socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
@@ -1451,6 +1618,7 @@
     },
     {
         "BriefDescription": "Read requests from a remote socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
         "PerPkg": "1",
@@ -1460,6 +1628,7 @@
     },
     {
         "BriefDescription": "Write requests made into the CHA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES",
         "PerPkg": "1",
@@ -1469,6 +1638,7 @@
     },
     {
         "BriefDescription": "Write Requests from a unit on this socket",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
@@ -1478,6 +1648,7 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Writes Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
         "PerPkg": "1",
@@ -1487,6 +1658,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : IPQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.IPQ",
         "PerPkg": "1",
@@ -1496,6 +1668,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : IRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
         "PerPkg": "1",
@@ -1505,6 +1678,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : IRQ Rejected=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.IRQ_REJ",
         "PerPkg": "1",
@@ -1514,6 +1688,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : PRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.PRQ",
         "PerPkg": "1",
@@ -1523,6 +1698,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : PRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.PRQ_REJ",
         "PerPkg": "1",
@@ -1532,6 +1708,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : RRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.RRQ",
         "PerPkg": "1",
@@ -1541,6 +1718,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Allocations : WBQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.WBQ",
         "PerPkg": "1",
@@ -1550,6 +1728,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : AD=
 REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -1559,6 +1738,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : AD=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -1568,6 +1748,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : No=
n UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -1577,6 +1758,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : BL=
 NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -1586,6 +1768,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : BL=
 NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -1595,6 +1778,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : BL=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -1604,6 +1788,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : BL=
 WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -1613,6 +1798,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 0 : No=
n UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_CHA_RxC_IPQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -1622,6 +1808,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : Al=
low Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -1630,6 +1817,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : AN=
Y0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -1639,6 +1827,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : HA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.HA",
         "PerPkg": "1",
@@ -1647,6 +1836,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : LL=
C OR SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -1656,6 +1846,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : LL=
C Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.LLC_VICTIM",
         "PerPkg": "1",
@@ -1664,6 +1855,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : Ph=
yAddr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -1673,6 +1865,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : SF=
 Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -1682,6 +1875,7 @@
     },
     {
         "BriefDescription": "IPQ Requests (from CMS) Rejected - Set 1 : Vi=
ctim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_CHA_RxC_IPQ1_REJECT.VICTIM",
         "PerPkg": "1",
@@ -1690,6 +1884,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : AD=
 REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -1699,6 +1894,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : AD=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -1708,6 +1904,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -1717,6 +1914,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -1726,6 +1924,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -1735,6 +1934,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -1744,6 +1944,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -1753,6 +1954,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_CHA_RxC_IRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -1762,6 +1964,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : Al=
low Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -1770,6 +1973,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : AN=
Y0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -1779,6 +1983,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : HA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.HA",
         "PerPkg": "1",
@@ -1787,6 +1992,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : LL=
C or SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -1796,6 +2002,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : LL=
C Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_VICTIM",
         "PerPkg": "1",
@@ -1804,6 +2011,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Phy=
Addr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -1812,6 +2020,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : SF=
 Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -1821,6 +2030,7 @@
     },
     {
         "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : Vi=
ctim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.VICTIM",
         "PerPkg": "1",
@@ -1829,6 +2039,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -1838,6 +2049,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -1847,6 +2059,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -1856,6 +2069,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -1865,6 +2079,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -1874,6 +2089,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -1883,6 +2099,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -1892,6 +2109,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -1901,6 +2119,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -1910,6 +2129,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -1919,6 +2139,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -1928,6 +2149,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -1937,6 +2159,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -1946,6 +2169,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -1955,6 +2179,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -1964,6 +2189,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -1973,6 +2199,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -1982,6 +2209,7 @@
     },
     {
         "BriefDescription": "ISMQ Rejects - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.HA",
         "PerPkg": "1",
@@ -1991,6 +2219,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.ANY0",
         "PerPkg": "1",
@@ -2000,6 +2229,7 @@
     },
     {
         "BriefDescription": "ISMQ Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.HA",
         "PerPkg": "1",
@@ -2036,6 +2266,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2045,6 +2276,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2054,6 +2286,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2063,6 +2296,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2072,6 +2306,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2081,6 +2316,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2090,6 +2326,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2099,6 +2336,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_CHA_RxC_OTHER0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2108,6 +2346,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2117,6 +2356,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ANY0",
         "PerPkg": "1",
@@ -2126,6 +2366,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.HA",
         "PerPkg": "1",
@@ -2135,6 +2376,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : LLC OR SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -2144,6 +2386,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_VICTIM",
         "PerPkg": "1",
@@ -2153,6 +2396,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : PhyAddr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2162,6 +2406,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.SF_VICTIM",
         "PerPkg": "1",
@@ -2171,6 +2416,7 @@
     },
     {
         "BriefDescription": "Other Retries - Set 1 : Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_CHA_RxC_OTHER1_RETRY.VICTIM",
         "PerPkg": "1",
@@ -2180,6 +2426,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : AD=
 REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2189,6 +2436,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : AD=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2198,6 +2446,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2207,6 +2456,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2216,6 +2466,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2225,6 +2476,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2234,6 +2486,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2243,6 +2496,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_CHA_RxC_PRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2252,6 +2506,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Al=
low Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2260,6 +2515,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : AN=
Y0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -2269,6 +2525,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : HA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.HA",
         "PerPkg": "1",
@@ -2277,6 +2534,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : LL=
C OR SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -2286,6 +2544,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : LL=
C Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_VICTIM",
         "PerPkg": "1",
@@ -2294,6 +2553,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Ph=
yAddr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2303,6 +2563,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : SF=
 Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2312,6 +2573,7 @@
     },
     {
         "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Vi=
ctim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_CHA_RxC_PRQ1_REJECT.VICTIM",
         "PerPkg": "1",
@@ -2320,6 +2582,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : AD REQ on VN0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2329,6 +2592,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : AD RSP on VN0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2338,6 +2602,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : Non UPI AK Re=
quest",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2347,6 +2612,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : BL NCB on VN0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2356,6 +2622,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : BL NCS on VN0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2365,6 +2632,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : BL RSP on VN0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2374,6 +2642,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
@@ -2383,6 +2652,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 0 : Non UPI IV Re=
quest",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2392,6 +2662,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2401,6 +2672,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ANY0",
         "PerPkg": "1",
@@ -2410,6 +2682,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.HA",
         "PerPkg": "1",
@@ -2419,6 +2692,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : LLC OR SF Way=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -2428,6 +2702,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_VICTIM",
         "PerPkg": "1",
@@ -2437,6 +2712,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : PhyAddr Match=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2446,6 +2722,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.SF_VICTIM",
         "PerPkg": "1",
@@ -2455,6 +2732,7 @@
     },
     {
         "BriefDescription": "Request Queue Retries - Set 1 : Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.VICTIM",
         "PerPkg": "1",
@@ -2464,6 +2742,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2473,6 +2752,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2482,6 +2762,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2491,6 +2772,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2500,6 +2782,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2509,6 +2792,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2518,6 +2802,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2527,6 +2812,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_CHA_RxC_RRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2536,6 +2822,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2545,6 +2832,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -2554,6 +2842,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.HA",
         "PerPkg": "1",
@@ -2563,6 +2852,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : LLC OR SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -2572,6 +2862,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.LLC_VICTIM",
         "PerPkg": "1",
@@ -2581,6 +2872,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : PhyAddr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2590,6 +2882,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2599,6 +2892,7 @@
     },
     {
         "BriefDescription": "RRQ Rejects - Set 1 : Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_CHA_RxC_RRQ1_REJECT.VICTIM",
         "PerPkg": "1",
@@ -2608,6 +2902,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
@@ -2617,6 +2912,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
@@ -2626,6 +2922,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2635,6 +2932,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2644,6 +2942,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2653,6 +2952,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
@@ -2662,6 +2962,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
@@ -2671,6 +2972,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_CHA_RxC_WBQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2680,6 +2982,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2689,6 +2992,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.ANY0",
         "PerPkg": "1",
@@ -2698,6 +3002,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : HA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.HA",
         "PerPkg": "1",
@@ -2707,6 +3012,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : LLC OR SF Way",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.LLC_OR_SF_WAY",
         "PerPkg": "1",
@@ -2716,6 +3022,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.LLC_VICTIM",
         "PerPkg": "1",
@@ -2725,6 +3032,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : PhyAddr Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2734,6 +3042,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
@@ -2743,6 +3052,7 @@
     },
     {
         "BriefDescription": "WBQ Rejects - Set 1 : Victim",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_CHA_RxC_WBQ1_REJECT.VICTIM",
         "PerPkg": "1",
@@ -2752,6 +3062,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.ALL",
         "PerPkg": "1",
@@ -2761,6 +3072,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Broadcast snoop for Local Reque=
sts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.BCST_LOCAL",
         "PerPkg": "1",
@@ -2770,6 +3082,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Broadcast snoops for Remote Req=
uests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.BCST_REMOTE",
         "PerPkg": "1",
@@ -2779,6 +3092,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Directed snoops for Local Reque=
sts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.DIRECT_LOCAL",
         "PerPkg": "1",
@@ -2788,6 +3102,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Directed snoops for Remote Requ=
ests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.DIRECT_REMOTE",
         "PerPkg": "1",
@@ -2797,6 +3112,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Broadcast or directed Snoops se=
nt for Local Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.LOCAL",
         "PerPkg": "1",
@@ -2806,6 +3122,7 @@
     },
     {
         "BriefDescription": "Snoops Sent : Broadcast or directed Snoops se=
nt for Remote Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_CHA_SNOOPS_SENT.REMOTE",
         "PerPkg": "1",
@@ -2815,6 +3132,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received : RSPCNFLCT*",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCT",
         "PerPkg": "1",
@@ -2824,6 +3142,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received : RspFwd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPFWD",
         "PerPkg": "1",
@@ -2833,6 +3152,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received : Rsp*Fwd*WB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPFWDWB",
         "PerPkg": "1",
@@ -2842,6 +3162,7 @@
     },
     {
         "BriefDescription": "RspI Snoop Responses Received",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
         "PerPkg": "1",
@@ -2851,6 +3172,7 @@
     },
     {
         "BriefDescription": "RspIFwd Snoop Responses Received",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
         "PerPkg": "1",
@@ -2860,6 +3182,7 @@
     },
     {
         "BriefDescription": "RspS Snoop Responses Received",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPS",
         "PerPkg": "1",
@@ -2869,6 +3192,7 @@
     },
     {
         "BriefDescription": "RspSFwd Snoop Responses Received",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
@@ -2878,6 +3202,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received : Rsp*WB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPWB",
         "PerPkg": "1",
@@ -2887,6 +3212,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspCnflct",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPCNFLCT",
         "PerPkg": "1",
@@ -2896,6 +3222,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspFwd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPFWD",
         "PerPkg": "1",
@@ -2905,6 +3232,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : Rsp*FWD*WB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPFWDWB",
         "PerPkg": "1",
@@ -2914,6 +3242,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspI",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPI",
         "PerPkg": "1",
@@ -2923,6 +3252,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspIFwd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPIFWD",
         "PerPkg": "1",
@@ -2932,6 +3262,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPS",
         "PerPkg": "1",
@@ -2941,6 +3272,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : RspSFwd",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPSFWD",
         "PerPkg": "1",
@@ -2950,6 +3282,7 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local : Rsp*WB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPWB",
         "PerPkg": "1",
@@ -2959,6 +3292,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : MtoI RspIData=
M",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.MTOI_RSPDATAM",
         "PerPkg": "1",
@@ -2967,6 +3301,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : MtoI RspIFwdM=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.MTOI_RSPIFWDM",
         "PerPkg": "1",
@@ -2975,6 +3310,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : Pull Data Par=
tial - Hit LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.PULLDATAPTL_HITLLC",
         "PerPkg": "1",
@@ -2983,6 +3319,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : Pull Data Par=
tial - Hit SF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.PULLDATAPTL_HITSF",
         "PerPkg": "1",
@@ -2991,6 +3328,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : RspIFwdPtl Hi=
t LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.RSPIFWDMPTL_HITLLC",
         "PerPkg": "1",
@@ -2999,6 +3337,7 @@
     },
     {
         "BriefDescription": "Misc Snoop Responses Received : RspIFwdPtl Hi=
t SF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6b",
         "EventName": "UNC_CHA_SNOOP_RSP_MISC.RSPIFWDMPTL_HITSF",
         "PerPkg": "1",
@@ -3007,6 +3346,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.ALL",
         "PerPkg": "1",
@@ -3016,6 +3356,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DDR Access",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.DDR",
         "PerPkg": "1",
@@ -3024,6 +3365,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : SF/LLC Evictions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.EVICT",
         "PerPkg": "1",
@@ -3033,6 +3375,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just Hits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.HIT",
         "PerPkg": "1",
@@ -3041,6 +3384,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; All from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA",
         "PerPkg": "1",
@@ -3050,6 +3394,7 @@
     },
     {
         "BriefDescription": "TOR Inserts;CLFlush from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
         "PerPkg": "1",
@@ -3059,6 +3404,7 @@
     },
     {
         "BriefDescription": "TOR Inserts;CLFlushOpt from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
         "PerPkg": "1",
@@ -3068,6 +3414,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; CRd from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
         "PerPkg": "1",
@@ -3077,6 +3424,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; CRd Pref from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
         "PerPkg": "1",
@@ -3086,6 +3434,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD",
         "PerPkg": "1",
@@ -3095,6 +3444,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRDPTE",
         "PerPkg": "1",
@@ -3104,6 +3454,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
         "PerPkg": "1",
@@ -3113,6 +3464,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt Pref from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -3122,6 +3474,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Pref from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_PREF",
         "PerPkg": "1",
@@ -3131,6 +3484,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; Hits from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
         "PerPkg": "1",
@@ -3140,6 +3494,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; CRd hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
         "PerPkg": "1",
@@ -3149,6 +3504,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; CRd Pref hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
         "PerPkg": "1",
@@ -3158,6 +3514,7 @@
     },
     {
         "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that hit the LLC.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC",
         "PerPkg": "1",
@@ -3166,6 +3523,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3175,6 +3533,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
         "PerPkg": "1",
@@ -3184,6 +3543,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Hit the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRDPTE",
         "PerPkg": "1",
@@ -3193,6 +3553,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
         "PerPkg": "1",
@@ -3202,6 +3563,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt Pref hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -3211,6 +3573,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Pref hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_PREF",
         "PerPkg": "1",
@@ -3220,6 +3583,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that H=
it LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
         "PerPkg": "1",
@@ -3229,6 +3593,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefCode hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
         "PerPkg": "1",
@@ -3238,6 +3603,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefData hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
         "PerPkg": "1",
@@ -3247,6 +3613,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefRFO hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
         "PerPkg": "1",
@@ -3256,6 +3623,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
         "PerPkg": "1",
@@ -3265,6 +3633,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO Pref hits from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
         "PerPkg": "1",
@@ -3274,6 +3643,7 @@
     },
     {
         "BriefDescription": "TOR Inserts;ItoM from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
         "PerPkg": "1",
@@ -3283,6 +3653,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : ItoMCacheNears issued by iA Cor=
es",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -3292,6 +3663,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefCode from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
         "PerPkg": "1",
@@ -3301,6 +3673,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefData from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
         "PerPkg": "1",
@@ -3310,6 +3683,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefRFO from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
         "PerPkg": "1",
@@ -3319,6 +3693,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; misses from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
         "PerPkg": "1",
@@ -3328,6 +3703,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for CRd misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
         "PerPkg": "1",
@@ -3337,6 +3713,7 @@
     },
     {
         "BriefDescription": "CRds and equivalent opcodes issued from an IA=
 core which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRDMORPH_CXL_ACC",
         "PerPkg": "1",
@@ -3345,6 +3722,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
         "PerPkg": "1",
@@ -3354,6 +3732,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; CRd Pref misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
         "PerPkg": "1",
@@ -3363,6 +3742,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
         "PerPkg": "1",
@@ -3372,6 +3752,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
         "PerPkg": "1",
@@ -3381,6 +3762,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
         "PerPkg": "1",
@@ -3390,6 +3772,7 @@
     },
     {
         "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that miss the LLC.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC",
         "PerPkg": "1",
@@ -3398,6 +3781,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC_LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3407,6 +3791,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
         "PerPkg": "1",
@@ -3416,6 +3801,7 @@
     },
     {
         "BriefDescription": "DRds and equivalent opcodes issued from an IA=
 core which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDMORPH_CXL_ACC",
         "PerPkg": "1",
@@ -3424,6 +3810,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDPTE",
         "PerPkg": "1",
@@ -3433,6 +3820,7 @@
     },
     {
         "BriefDescription": "DRds issued from an IA core which miss the L3=
 and target memory in a CXL type 2 memory expander card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC",
         "PerPkg": "1",
@@ -3441,6 +3829,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC_LOCAL=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3450,6 +3839,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRds issued by IA Cores targe=
ting DDR Mem that Missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR",
         "PerPkg": "1",
@@ -3459,6 +3849,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting local memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
         "PerPkg": "1",
@@ -3468,6 +3859,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_DDR",
         "PerPkg": "1",
@@ -3477,6 +3869,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_PMM",
         "PerPkg": "1",
@@ -3486,6 +3879,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
         "PerPkg": "1",
@@ -3495,6 +3889,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_CXL_ACC_L=
OCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3504,6 +3899,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; DRd Opt Pref misses from local I=
A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -3513,6 +3909,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_CXL_=
ACC_LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_CXL_ACC_LOC=
AL",
         "PerPkg": "1",
@@ -3522,6 +3919,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM",
         "PerPkg": "1",
@@ -3531,6 +3929,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF",
         "PerPkg": "1",
@@ -3540,6 +3939,7 @@
     },
     {
         "BriefDescription": "L2 data prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC",
         "PerPkg": "1",
@@ -3548,6 +3948,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC_=
LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3557,6 +3958,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_DDR",
         "PerPkg": "1",
@@ -3566,6 +3968,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting local memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL",
         "PerPkg": "1",
@@ -3575,6 +3978,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_DDR",
         "PerPkg": "1",
@@ -3584,6 +3988,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_PMM",
         "PerPkg": "1",
@@ -3593,6 +3998,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_PMM",
         "PerPkg": "1",
@@ -3602,6 +4008,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting remote memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE",
         "PerPkg": "1",
@@ -3611,6 +4018,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_DDR",
         "PerPkg": "1",
@@ -3620,6 +4028,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_PMM",
         "PerPkg": "1",
@@ -3629,6 +4038,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting remote memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
         "PerPkg": "1",
@@ -3638,6 +4048,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_DDR",
         "PerPkg": "1",
@@ -3647,6 +4058,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_PMM",
         "PerPkg": "1",
@@ -3656,6 +4068,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that M=
issed LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
         "PerPkg": "1",
@@ -3665,6 +4078,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefCode misses from local IA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
         "PerPkg": "1",
@@ -3674,6 +4088,7 @@
     },
     {
         "BriefDescription": "LLC Prefetch Code transactions issued from an=
 IA core which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE_CXL_ACC",
         "PerPkg": "1",
@@ -3682,6 +4097,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefData misses from local IA=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
         "PerPkg": "1",
@@ -3691,6 +4107,7 @@
     },
     {
         "BriefDescription": "LLC data prefetches issued from an IA core wh=
ich miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC",
         "PerPkg": "1",
@@ -3699,6 +4116,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_A=
CC_LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC_LOCA=
L",
         "PerPkg": "1",
@@ -3708,6 +4126,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; LLCPrefRFO misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
         "PerPkg": "1",
@@ -3717,6 +4136,7 @@
     },
     {
         "BriefDescription": "L2 RFO prefetches issued from an IA core whic=
h miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC",
         "PerPkg": "1",
@@ -3725,6 +4145,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_AC=
C_LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC_LOCAL=
",
         "PerPkg": "1",
@@ -3734,6 +4155,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
         "PerPkg": "1",
@@ -3743,6 +4165,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
         "PerPkg": "1",
@@ -3752,6 +4175,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
         "PerPkg": "1",
@@ -3761,6 +4185,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed locally",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
         "PerPkg": "1",
@@ -3770,6 +4195,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
         "PerPkg": "1",
@@ -3779,6 +4205,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
         "PerPkg": "1",
@@ -3788,6 +4215,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
         "PerPkg": "1",
@@ -3797,6 +4225,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed remotely",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
         "PerPkg": "1",
@@ -3806,6 +4235,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
         "PerPkg": "1",
@@ -3815,6 +4245,7 @@
     },
     {
         "BriefDescription": "RFO and L2 RFO prefetches issued from an IA c=
ore which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFOMORPH_CXL_ACC",
         "PerPkg": "1",
@@ -3823,6 +4254,7 @@
     },
     {
         "BriefDescription": "RFOs issued from an IA core which miss the L3=
 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC",
         "PerPkg": "1",
@@ -3831,6 +4263,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC_LOCAL=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3840,6 +4273,7 @@
     },
     {
         "BriefDescription": "TOR Inserts RFO misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
         "PerPkg": "1",
@@ -3849,6 +4283,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO pref misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
         "PerPkg": "1",
@@ -3858,6 +4293,7 @@
     },
     {
         "BriefDescription": "LLC RFO prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC",
         "PerPkg": "1",
@@ -3866,6 +4302,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC_=
LOCAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC_LOCAL",
         "PerPkg": "1",
@@ -3875,6 +4312,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
         "PerPkg": "1",
@@ -3884,6 +4322,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
         "PerPkg": "1",
@@ -3893,6 +4332,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO misses from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
         "PerPkg": "1",
@@ -3902,6 +4342,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : UCRdFs issued by iA Cores that =
Missed LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
         "PerPkg": "1",
@@ -3911,6 +4352,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores that M=
issed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
         "PerPkg": "1",
@@ -3920,6 +4362,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores that M=
issed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
         "PerPkg": "1",
@@ -3929,6 +4372,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
         "PerPkg": "1",
@@ -3938,6 +4382,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
         "PerPkg": "1",
@@ -3947,6 +4392,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
         "PerPkg": "1",
@@ -3956,6 +4402,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
         "PerPkg": "1",
@@ -3965,6 +4412,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WiLs issued by iA Cores that Mi=
ssed LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
         "PerPkg": "1",
@@ -3974,6 +4422,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
         "PerPkg": "1",
@@ -3983,6 +4432,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO pref from local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
         "PerPkg": "1",
@@ -3992,6 +4442,7 @@
     },
     {
         "BriefDescription": "TOR Inserts;SpecItoM from Local IA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
         "PerPkg": "1",
@@ -4001,6 +4452,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
         "PerPkg": "1",
@@ -4010,6 +4462,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
         "PerPkg": "1",
@@ -4019,6 +4472,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
         "PerPkg": "1",
@@ -4028,6 +4482,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WbMtoIs issued by an iA Cores. =
Modified Write Backs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
         "PerPkg": "1",
@@ -4037,6 +4492,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
         "PerPkg": "1",
@@ -4046,6 +4502,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
         "PerPkg": "1",
@@ -4055,6 +4512,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
         "PerPkg": "1",
@@ -4064,6 +4522,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; All from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO",
         "PerPkg": "1",
@@ -4073,6 +4532,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : CLFlushes issued by IO Devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
         "PerPkg": "1",
@@ -4082,6 +4542,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; Hits from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
         "PerPkg": "1",
@@ -4091,6 +4552,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; ItoM hits from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
         "PerPkg": "1",
@@ -4100,6 +4562,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that hit the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -4109,6 +4572,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RdCur and FsRdCur hits from loca=
l IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
         "PerPkg": "1",
@@ -4118,6 +4582,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO hits from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
         "PerPkg": "1",
@@ -4127,6 +4592,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for ItoM from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
         "PerPkg": "1",
@@ -4136,6 +4602,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for ItoMCacheNears from IO device=
s.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -4145,6 +4612,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; Misses from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
         "PerPkg": "1",
@@ -4154,6 +4622,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; ItoM misses from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
@@ -4163,6 +4632,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -4172,6 +4642,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RdCur and FsRdCur misses from lo=
cal IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
@@ -4181,6 +4652,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO misses from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "PerPkg": "1",
@@ -4190,6 +4662,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for RdCur from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
         "PerPkg": "1",
@@ -4199,6 +4672,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; RFO from local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
         "PerPkg": "1",
@@ -4208,6 +4682,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
         "PerPkg": "1",
@@ -4217,6 +4692,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : IPQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -4226,6 +4702,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : IRQ - iA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IRQ_IA",
         "PerPkg": "1",
@@ -4235,6 +4712,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : IRQ - Non iA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IRQ_NON_IA",
         "PerPkg": "1",
@@ -4244,6 +4722,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just ISOC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.ISOC",
         "PerPkg": "1",
@@ -4252,6 +4731,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just Local Targets",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOCAL_TGT",
         "PerPkg": "1",
@@ -4260,6 +4740,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All from Local iA and IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
         "PerPkg": "1",
@@ -4269,6 +4750,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All from Local iA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
         "PerPkg": "1",
@@ -4278,6 +4760,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All from Local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
         "PerPkg": "1",
@@ -4287,6 +4770,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Match the Opcode in b[29:19] of=
 the extended umask field",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.MATCH_OPC",
         "PerPkg": "1",
@@ -4295,6 +4779,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just Misses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.MISS",
         "PerPkg": "1",
@@ -4303,6 +4788,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : MMCFG Access",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.MMCFG",
         "PerPkg": "1",
@@ -4311,6 +4797,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : MMIO Access",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.MMIO",
         "PerPkg": "1",
@@ -4319,6 +4806,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just NearMem",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.NEARMEM",
         "PerPkg": "1",
@@ -4327,6 +4815,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just NonCoherent",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.NONCOH",
         "PerPkg": "1",
@@ -4335,6 +4824,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just NotNearMem",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.NOT_NEARMEM",
         "PerPkg": "1",
@@ -4343,6 +4833,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : PMM Access",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.PMM",
         "PerPkg": "1",
@@ -4351,6 +4842,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Match the PreMorphed Opcode in =
b[29:19] of the extended umask field",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.PREMORPH_OPC",
         "PerPkg": "1",
@@ -4359,6 +4851,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : PRQ - IOSF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.PRQ_IOSF",
         "PerPkg": "1",
@@ -4368,6 +4861,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : PRQ - Non IOSF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.PRQ_NON_IOSF",
         "PerPkg": "1",
@@ -4377,6 +4871,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : Just Remote Targets",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.REMOTE_TGT",
         "PerPkg": "1",
@@ -4385,6 +4880,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All from Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
         "PerPkg": "1",
@@ -4394,6 +4890,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : All Snoops from Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
         "PerPkg": "1",
@@ -4403,6 +4900,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : RRQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.RRQ",
         "PerPkg": "1",
@@ -4412,6 +4910,7 @@
     },
     {
         "BriefDescription": "TOR Inserts; All Snoops from Remote",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.SNPS_FROM_REM",
         "PerPkg": "1",
@@ -4421,6 +4920,7 @@
     },
     {
         "BriefDescription": "TOR Inserts : WBQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.WBQ",
         "PerPkg": "1",
@@ -4591,7 +5091,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC_LOCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -4825,7 +5325,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC_LOCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -4870,7 +5370,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC_LOC=
AL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC_LOCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -4924,7 +5424,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_CXL_ACC=
_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_CXL_ACC_LOCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -4942,7 +5442,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF_CX=
L_ACC_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF_CXL_ACC_L=
OCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -4977,7 +5477,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_AC=
C_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC_LOCAL=
",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -5128,7 +5628,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL=
_ACC_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC_LO=
CAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -5154,7 +5654,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_=
ACC_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC_LOC=
AL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -5260,7 +5760,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC_LOC=
AL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC_LOCAL",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -5295,7 +5795,7 @@
     },
     {
         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_AC=
C_LOCAL",
-        "EventCode": "0x35",
+        "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC_LOCAL=
",
         "PerPkg": "1",
         "PortMask": "0x000",
@@ -5825,6 +6325,7 @@
     },
     {
         "BriefDescription": "WbPushMtoI : Pushed to LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_CHA_WB_PUSH_MTOI.LLC",
         "PerPkg": "1",
@@ -5834,6 +6335,7 @@
     },
     {
         "BriefDescription": "WbPushMtoI : Pushed to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_CHA_WB_PUSH_MTOI.MEM",
         "PerPkg": "1",
@@ -5843,6 +6345,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC0",
         "PerPkg": "1",
@@ -5852,6 +6355,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC1",
         "PerPkg": "1",
@@ -5861,6 +6365,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC2",
         "PerPkg": "1",
@@ -5870,6 +6375,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC3",
         "PerPkg": "1",
@@ -5879,6 +6385,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC4",
         "PerPkg": "1",
@@ -5888,6 +6395,7 @@
     },
     {
         "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC5",
         "PerPkg": "1",
@@ -5897,6 +6405,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Dropped (on 0?) - Conflict",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.DROP0_CONFLICT",
         "PerPkg": "1",
@@ -5906,6 +6415,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Dropped (on 0?) - No Credits=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.DROP0_NOCRD",
         "PerPkg": "1",
@@ -5915,6 +6425,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Dropped (on 1?) - Conflict",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.DROP1_CONFLICT",
         "PerPkg": "1",
@@ -5924,6 +6435,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Dropped (on 1?) - No Credits=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.DROP1_NOCRD",
         "PerPkg": "1",
@@ -5933,6 +6445,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Sent (on 0?)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.SENT0",
         "PerPkg": "1",
@@ -5942,6 +6455,7 @@
     },
     {
         "BriefDescription": "XPT Prefetches : Sent (on 1?)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x6f",
         "EventName": "UNC_CHA_XPT_PREF.SENT1",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cxl.json =
b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cxl.json
index f3e84fd88..147903614 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cxl.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cxl.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of lfclk ticks",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x01",
         "EventName": "UNC_CXLCM_CLOCKTICKS",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Rxx AGF 0",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.CACHE_DATA",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Req AGF0",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.CACHE_REQ0",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Rsp AGF",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.CACHE_REQ1",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Data AGF",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.CACHE_RSP0",
         "PerPkg": "1",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Rsp AGF",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.CACHE_RSP1",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Req AGF 1",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.MEM_DATA",
         "PerPkg": "1",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Data AGF",
+        "Counter": "4,5,6,7",
         "EventCode": "0x43",
         "EventName": "UNC_CXLCM_RxC_AGF_INSERTS.MEM_REQ",
         "PerPkg": "1",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with AK set",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.AK_HDR",
         "PerPkg": "1",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with BE set",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.BE_HDR",
         "PerPkg": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Count the number of control flits received",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.CTRL",
         "PerPkg": "1",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Count the number of Headerless flits received=
",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.NO_HDR",
         "PerPkg": "1",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Count the number of protocol flits received",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.PROT",
         "PerPkg": "1",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with SZ set",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.SZ_HDR",
         "PerPkg": "1",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "Count the number of flits received",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.VALID",
         "PerPkg": "1",
@@ -121,6 +136,7 @@
     },
     {
         "BriefDescription": "Count the number of valid messages in the fli=
t",
+        "Counter": "4,5,6,7",
         "EventCode": "0x4b",
         "EventName": "UNC_CXLCM_RxC_FLITS.VALID_MSG",
         "PerPkg": "1",
@@ -129,6 +145,7 @@
     },
     {
         "BriefDescription": "Count the number of CRC errors detected",
+        "Counter": "4,5,6,7",
         "EventCode": "0x40",
         "EventName": "UNC_CXLCM_RxC_MISC.CRC_ERRORS",
         "PerPkg": "1",
@@ -137,6 +154,7 @@
     },
     {
         "BriefDescription": "Count the number of Init flits sent",
+        "Counter": "4,5,6,7",
         "EventCode": "0x40",
         "EventName": "UNC_CXLCM_RxC_MISC.INIT",
         "PerPkg": "1",
@@ -145,6 +163,7 @@
     },
     {
         "BriefDescription": "Count the number of LLCRD flits sent",
+        "Counter": "4,5,6,7",
         "EventCode": "0x40",
         "EventName": "UNC_CXLCM_RxC_MISC.LLCRD",
         "PerPkg": "1",
@@ -153,6 +172,7 @@
     },
     {
         "BriefDescription": "Count the number of Retry flits sent",
+        "Counter": "4,5,6,7",
         "EventCode": "0x40",
         "EventName": "UNC_CXLCM_RxC_MISC.RETRY",
         "PerPkg": "1",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "Number of cycles the Packing Buffer is Full",
+        "Counter": "4,5,6,7",
         "EventCode": "0x52",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_FULL.CACHE_DATA",
         "PerPkg": "1",
@@ -169,6 +190,7 @@
     },
     {
         "BriefDescription": "Number of cycles the Packing Buffer is Full",
+        "Counter": "4,5,6,7",
         "EventCode": "0x52",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_FULL.CACHE_REQ",
         "PerPkg": "1",
@@ -177,6 +199,7 @@
     },
     {
         "BriefDescription": "Number of cycles the Packing Buffer is Full",
+        "Counter": "4,5,6,7",
         "EventCode": "0x52",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_FULL.CACHE_RSP",
         "PerPkg": "1",
@@ -185,6 +208,7 @@
     },
     {
         "BriefDescription": "Number of cycles the Packing Buffer is Full",
+        "Counter": "4,5,6,7",
         "EventCode": "0x52",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_FULL.MEM_DATA",
         "PerPkg": "1",
@@ -193,6 +217,7 @@
     },
     {
         "BriefDescription": "Number of cycles the Packing Buffer is Full",
+        "Counter": "4,5,6,7",
         "EventCode": "0x52",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_FULL.MEM_REQ",
         "PerPkg": "1",
@@ -201,6 +226,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Data Packing bu=
ffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.CACHE_DATA",
         "PerPkg": "1",
@@ -209,6 +235,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Req Packing buf=
fer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.CACHE_REQ",
         "PerPkg": "1",
@@ -217,6 +244,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Rsp Packing buf=
fer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.CACHE_RSP",
         "PerPkg": "1",
@@ -225,6 +253,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_DATA",
         "PerPkg": "1",
@@ -233,6 +262,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Rxx Packing buffe=
r",
+        "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_REQ",
         "PerPkg": "1",
@@ -241,6 +271,7 @@
     },
     {
         "BriefDescription": "Number of cycles of Not Empty for Cache Data =
Packing buffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x42",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_NE.CACHE_DATA",
         "PerPkg": "1",
@@ -249,6 +280,7 @@
     },
     {
         "BriefDescription": "Number of cycles of Not Empty for Cache Req P=
acking buffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x42",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_NE.CACHE_REQ",
         "PerPkg": "1",
@@ -257,6 +289,7 @@
     },
     {
         "BriefDescription": "Number of cycles of Not Empty for Cache Rsp P=
acking buffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x42",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_NE.CACHE_RSP",
         "PerPkg": "1",
@@ -265,6 +298,7 @@
     },
     {
         "BriefDescription": "Number of cycles of Not Empty for Mem Data Pa=
cking buffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x42",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_NE.MEM_DATA",
         "PerPkg": "1",
@@ -273,6 +307,7 @@
     },
     {
         "BriefDescription": "Number of cycles of Not Empty for Mem Rxx Pac=
king buffer",
+        "Counter": "4,5,6,7",
         "EventCode": "0x42",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_NE.MEM_REQ",
         "PerPkg": "1",
@@ -281,6 +316,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with AK set",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.AK_HDR",
         "PerPkg": "1",
@@ -289,6 +325,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with BE set",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.BE_HDR",
         "PerPkg": "1",
@@ -297,6 +334,7 @@
     },
     {
         "BriefDescription": "Count the number of control flits packed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.CTRL",
         "PerPkg": "1",
@@ -305,6 +343,7 @@
     },
     {
         "BriefDescription": "Count the number of Headerless flits packed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.NO_HDR",
         "PerPkg": "1",
@@ -313,6 +352,7 @@
     },
     {
         "BriefDescription": "Count the number of protocol flits packed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.PROT",
         "PerPkg": "1",
@@ -321,6 +361,7 @@
     },
     {
         "BriefDescription": "Count the number of Flits with SZ set",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.SZ_HDR",
         "PerPkg": "1",
@@ -329,6 +370,7 @@
     },
     {
         "BriefDescription": "Count the number of flits packed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_CXLCM_TxC_FLITS.VALID",
         "PerPkg": "1",
@@ -337,6 +379,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Data Packing bu=
ffer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.CACHE_DATA",
         "PerPkg": "1",
@@ -345,6 +388,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Req Packing buf=
fer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.CACHE_REQ0",
         "PerPkg": "1",
@@ -353,6 +397,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Rsp1 Packing bu=
ffer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.CACHE_REQ1",
         "PerPkg": "1",
@@ -361,6 +406,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Rsp0 Packing bu=
ffer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.CACHE_RSP0",
         "PerPkg": "1",
@@ -369,6 +415,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Cache Req Packing buf=
fer",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.CACHE_RSP1",
         "PerPkg": "1",
@@ -377,6 +424,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.MEM_DATA",
         "PerPkg": "1",
@@ -385,6 +433,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to Mem Rxx Packing buffe=
r",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLCM_TxC_PACK_BUF_INSERTS.MEM_REQ",
         "PerPkg": "1",
@@ -393,6 +442,7 @@
     },
     {
         "BriefDescription": "Counts the number of uclk ticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_CXLDP_CLOCKTICKS",
         "PerPkg": "1",
@@ -401,6 +451,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to M2S Data AGF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_DATA",
         "PerPkg": "1",
@@ -409,6 +460,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to M2S Req AGF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_REQ",
         "PerPkg": "1",
@@ -417,6 +469,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to U2C Data AGF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.U2C_DATA",
         "PerPkg": "1",
@@ -425,6 +478,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to U2C Req AGF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.U2C_REQ",
         "PerPkg": "1",
@@ -433,6 +487,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to U2C Rsp AGF 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.U2C_RSP0",
         "PerPkg": "1",
@@ -441,6 +496,7 @@
     },
     {
         "BriefDescription": "Number of Allocation to U2C Rsp AGF 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.U2C_RSP1",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnec=
t.json
index 09d840c7d..ee023a574 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Total IRP occupancy of inbound read and write=
 requests to coherent memory.",
+        "Counter": "0,1",
         "EventCode": "0x0f",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
         "PerPkg": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "IRP Clockticks",
+        "Counter": "0,1",
         "EventCode": "0x01",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "FAF RF full",
+        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_FAF_FULL",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "FAF - request insert from TC.",
+        "Counter": "0,1",
         "EventCode": "0x18",
         "EventName": "UNC_I_FAF_INSERTS",
         "PerPkg": "1",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "FAF occupancy",
+        "Counter": "0,1",
         "EventCode": "0x19",
         "EventName": "UNC_I_FAF_OCCUPANCY",
         "PerPkg": "1",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "FAF allocation -- sent to ADQ",
+        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_FAF_TRANSACTIONS",
         "PerPkg": "1",
@@ -46,6 +52,7 @@
     },
     {
         "BriefDescription": ": All Inserts Outbound (BL, AK, Snoops)",
+        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_I_IRP_ALL.EVICTS",
         "PerPkg": "1",
@@ -54,6 +61,7 @@
     },
     {
         "BriefDescription": ": All Inserts Inbound (p2p + faf + cset)",
+        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
         "PerPkg": "1",
@@ -62,6 +70,7 @@
     },
     {
         "BriefDescription": ": All Inserts Outbound (BL, AK, Snoops)",
+        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_I_IRP_ALL.OUTBOUND_INSERTS",
         "PerPkg": "1",
@@ -70,6 +79,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of At=
omic Transactions as Secondary",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
         "PerPkg": "1",
@@ -78,6 +88,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Re=
ad Transactions as Secondary",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
         "PerPkg": "1",
@@ -86,6 +97,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Wr=
ite Transactions as Secondary",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
         "PerPkg": "1",
@@ -94,6 +106,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.FAST_REJ",
         "PerPkg": "1",
@@ -102,6 +115,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.FAST_REQ",
         "PerPkg": "1",
@@ -110,6 +124,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Transfers =
From Primary to Secondary",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.FAST_XFER",
         "PerPkg": "1",
@@ -118,6 +133,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints =
From Primary to Secondary",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.PF_ACK_HINT",
         "PerPkg": "1",
@@ -126,6 +142,7 @@
     },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Slow path fwpf didn=
't find prefetch",
+        "Counter": "0,1",
         "EventCode": "0x1e",
         "EventName": "UNC_I_MISC0.SLOWPATH_FWPF_NO_PRF",
         "PerPkg": "1",
@@ -134,6 +151,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Lost Forward",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
@@ -143,6 +161,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Received Invalid",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
         "PerPkg": "1",
@@ -152,6 +171,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Received Valid",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
         "PerPkg": "1",
@@ -161,6 +181,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Slow Transfer of E Line=
",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SLOW_E",
         "PerPkg": "1",
@@ -170,6 +191,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Slow Transfer of I Line=
",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SLOW_I",
         "PerPkg": "1",
@@ -179,6 +201,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Slow Transfer of M Line=
",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SLOW_M",
         "PerPkg": "1",
@@ -188,6 +211,7 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Slow Transfer of S Line=
",
+        "Counter": "0,1",
         "EventCode": "0x1f",
         "EventName": "UNC_I_MISC1.SLOW_S",
         "PerPkg": "1",
@@ -197,6 +221,7 @@
     },
     {
         "BriefDescription": "Responses to snoops of any type that hit M, E=
, S or I line in the IIO",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.ALL_HIT",
         "PerPkg": "1",
@@ -206,6 +231,7 @@
     },
     {
         "BriefDescription": "Responses to snoops of any type that hit E or=
 S line in the IIO cache",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
         "PerPkg": "1",
@@ -215,6 +241,7 @@
     },
     {
         "BriefDescription": "Responses to snoops of any type that hit I li=
ne in the IIO cache",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
         "PerPkg": "1",
@@ -224,6 +251,7 @@
     },
     {
         "BriefDescription": "Responses to snoops of any type that hit M li=
ne in the IIO cache",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
         "PerPkg": "1",
@@ -233,6 +261,7 @@
     },
     {
         "BriefDescription": "Responses to snoops of any type that miss the=
 IIO cache",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
         "PerPkg": "1",
@@ -242,6 +271,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : Hit E or S",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
         "PerPkg": "1",
@@ -250,6 +280,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : Hit I",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.HIT_I",
         "PerPkg": "1",
@@ -258,6 +289,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : Hit M",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.HIT_M",
         "PerPkg": "1",
@@ -266,6 +298,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : Miss",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.MISS",
         "PerPkg": "1",
@@ -274,6 +307,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : SnpCode",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
         "PerPkg": "1",
@@ -282,6 +316,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : SnpData",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
         "PerPkg": "1",
@@ -290,6 +325,7 @@
     },
     {
         "BriefDescription": "Snoop Responses : SnpInv",
+        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_SNOOP_RESP.SNPINV",
         "PerPkg": "1",
@@ -298,6 +334,7 @@
     },
     {
         "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP.",
+        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
         "PerPkg": "1",
@@ -307,6 +344,7 @@
     },
     {
         "BriefDescription": "AK Egress Allocations",
+        "Counter": "0,1",
         "EventCode": "0x0b",
         "EventName": "UNC_I_TxC_AK_INSERTS",
         "PerPkg": "1",
@@ -314,6 +352,7 @@
     },
     {
         "BriefDescription": "BL DRS Egress Cycles Full",
+        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "UNC_I_TxC_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
@@ -321,6 +360,7 @@
     },
     {
         "BriefDescription": "BL DRS Egress Inserts",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_I_TxC_BL_DRS_INSERTS",
         "PerPkg": "1",
@@ -328,6 +368,7 @@
     },
     {
         "BriefDescription": "BL DRS Egress Occupancy",
+        "Counter": "0,1",
         "EventCode": "0x08",
         "EventName": "UNC_I_TxC_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
@@ -335,6 +376,7 @@
     },
     {
         "BriefDescription": "BL NCB Egress Cycles Full",
+        "Counter": "0,1",
         "EventCode": "0x06",
         "EventName": "UNC_I_TxC_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
@@ -342,6 +384,7 @@
     },
     {
         "BriefDescription": "BL NCB Egress Inserts",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_I_TxC_BL_NCB_INSERTS",
         "PerPkg": "1",
@@ -349,6 +392,7 @@
     },
     {
         "BriefDescription": "BL NCB Egress Occupancy",
+        "Counter": "0,1",
         "EventCode": "0x09",
         "EventName": "UNC_I_TxC_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
@@ -356,6 +400,7 @@
     },
     {
         "BriefDescription": "BL NCS Egress Cycles Full",
+        "Counter": "0,1",
         "EventCode": "0x07",
         "EventName": "UNC_I_TxC_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
@@ -363,6 +408,7 @@
     },
     {
         "BriefDescription": "BL NCS Egress Inserts",
+        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "UNC_I_TxC_BL_NCS_INSERTS",
         "PerPkg": "1",
@@ -370,6 +416,7 @@
     },
     {
         "BriefDescription": "BL NCS Egress Occupancy",
+        "Counter": "0,1",
         "EventCode": "0x0a",
         "EventName": "UNC_I_TxC_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
@@ -377,6 +424,7 @@
     },
     {
         "BriefDescription": "UNC_I_TxR2_AD01_STALL_CREDIT_CYCLES",
+        "Counter": "0,1",
         "EventCode": "0x1c",
         "EventName": "UNC_I_TxR2_AD01_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -385,6 +433,7 @@
     },
     {
         "BriefDescription": "No AD0 Egress Credits Stalls",
+        "Counter": "0,1",
         "EventCode": "0x1a",
         "EventName": "UNC_I_TxR2_AD0_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -393,6 +442,7 @@
     },
     {
         "BriefDescription": "No AD1 Egress Credits Stalls",
+        "Counter": "0,1",
         "EventCode": "0x1b",
         "EventName": "UNC_I_TxR2_AD1_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -401,6 +451,7 @@
     },
     {
         "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
         "EventCode": "0x1d",
         "EventName": "UNC_I_TxR2_BL_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -409,6 +460,7 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
         "EventCode": "0x0d",
         "EventName": "UNC_I_TxS_DATA_INSERTS_NCB",
         "PerPkg": "1",
@@ -417,6 +469,7 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
         "EventCode": "0x0e",
         "EventName": "UNC_I_TxS_DATA_INSERTS_NCS",
         "PerPkg": "1",
@@ -425,6 +478,7 @@
     },
     {
         "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
         "EventCode": "0x0c",
         "EventName": "UNC_I_TxS_REQUEST_OCCUPANCY",
         "PerPkg": "1",
@@ -433,6 +487,7 @@
     },
     {
         "BriefDescription": "M2M Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
@@ -441,6 +496,7 @@
     },
     {
         "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M2M_CMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -448,6 +504,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
@@ -456,6 +513,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to core mode, which bypass=
es the CHA, was disabled : Non Cisgress",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE.NON_CISGRESS",
         "PerPkg": "1",
@@ -465,6 +523,7 @@
     },
     {
         "BriefDescription": "Counts the time when FM didn't do d2c for fil=
l reads (cross tile case)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_NOTFORKED",
         "PerPkg": "1",
@@ -472,6 +531,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -480,6 +540,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to core trans=
action was overridden : Cisgress",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE.CISGRESS",
         "PerPkg": "1",
@@ -488,6 +549,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to core trans=
action was overridden : 2LM Hit?",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE.PMM_HIT",
         "PerPkg": "1",
@@ -496,6 +558,7 @@
     },
     {
         "BriefDescription": "Number of times a direct to UPI transaction w=
as overridden.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_M2M_DIRECT2UPITXN_OVERRIDE.PMM_HIT",
         "PerPkg": "1",
@@ -505,6 +568,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
         "PerPkg": "1",
@@ -513,6 +577,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to Intel UPI was disabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
@@ -521,6 +586,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Cisgres=
s D2U Ignored",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE.CISGRESS",
         "PerPkg": "1",
@@ -530,6 +596,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Egress =
Ignored D2U",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE.EGRESS",
         "PerPkg": "1",
@@ -539,6 +606,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Non Cis=
gress D2U Ignored",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE.NON_CISGRESS",
         "PerPkg": "1",
@@ -548,6 +616,7 @@
     },
     {
         "BriefDescription": "Messages sent direct to the Intel UPI",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
         "PerPkg": "1",
@@ -557,6 +626,7 @@
     },
     {
         "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -565,6 +635,7 @@
     },
     {
         "BriefDescription": "Number of times a direct to UPI transaction w=
as overridden.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE.CISGRESS",
         "PerPkg": "1",
@@ -573,6 +644,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_A",
         "PerPkg": "1",
@@ -581,6 +653,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_I",
         "PerPkg": "1",
@@ -589,6 +662,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_P",
         "PerPkg": "1",
@@ -597,6 +671,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_S",
         "PerPkg": "1",
@@ -605,6 +680,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_A",
         "PerPkg": "1",
@@ -613,6 +689,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_I",
         "PerPkg": "1",
@@ -621,6 +698,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_P",
         "PerPkg": "1",
@@ -629,6 +707,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_S",
         "PerPkg": "1",
@@ -637,6 +716,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
         "PerPkg": "1",
@@ -646,6 +726,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
         "PerPkg": "1",
@@ -655,6 +736,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
         "PerPkg": "1",
@@ -664,6 +746,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
         "PerPkg": "1",
@@ -673,6 +756,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_A",
         "PerPkg": "1",
@@ -681,6 +765,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_I",
         "PerPkg": "1",
@@ -689,6 +774,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_P",
         "PerPkg": "1",
@@ -697,6 +783,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_S",
         "PerPkg": "1",
@@ -705,6 +792,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_A",
         "PerPkg": "1",
@@ -713,6 +801,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_I",
         "PerPkg": "1",
@@ -721,6 +810,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_P",
         "PerPkg": "1",
@@ -729,6 +819,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_S",
         "PerPkg": "1",
@@ -737,6 +828,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
         "PerPkg": "1",
@@ -745,6 +837,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
         "PerPkg": "1",
@@ -753,6 +846,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
@@ -761,6 +855,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A_TO_I_HIT_NON_PMM",
         "PerPkg": "1",
@@ -770,6 +865,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A_TO_I_MISS_NON_PMM",
         "PerPkg": "1",
@@ -779,6 +875,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A_TO_S_HIT_NON_PMM",
         "PerPkg": "1",
@@ -788,6 +885,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A_TO_S_MISS_NON_PMM",
         "PerPkg": "1",
@@ -797,6 +895,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.HIT_NON_PMM",
         "PerPkg": "1",
@@ -806,6 +905,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
         "PerPkg": "1",
@@ -814,6 +914,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
         "PerPkg": "1",
@@ -822,6 +923,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I_TO_A_HIT_NON_PMM",
         "PerPkg": "1",
@@ -831,6 +933,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I_TO_A_MISS_NON_PMM",
         "PerPkg": "1",
@@ -840,6 +943,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I_TO_S_HIT_NON_PMM",
         "PerPkg": "1",
@@ -849,6 +953,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I_TO_S_MISS_NON_PMM",
         "PerPkg": "1",
@@ -858,6 +963,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.MISS_NON_PMM",
         "PerPkg": "1",
@@ -867,6 +973,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
         "PerPkg": "1",
@@ -875,6 +982,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
         "PerPkg": "1",
@@ -883,6 +991,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S_TO_A_HIT_NON_PMM",
         "PerPkg": "1",
@@ -892,6 +1001,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S_TO_A_MISS_NON_PMM",
         "PerPkg": "1",
@@ -901,6 +1011,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S_TO_I_HIT_NON_PMM",
         "PerPkg": "1",
@@ -910,6 +1021,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S_TO_I_MISS_NON_PMM",
         "PerPkg": "1",
@@ -919,6 +1031,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_DN",
         "PerPkg": "1",
@@ -928,6 +1041,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_UP",
         "PerPkg": "1",
@@ -937,6 +1051,7 @@
     },
     {
         "BriefDescription": "Count when Starve Glocab counter is at 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2M_IGR_STARVE_WINNER.MASK7",
         "PerPkg": "1",
@@ -945,6 +1060,7 @@
     },
     {
         "BriefDescription": "Reads to iMC issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.ALL",
         "PerPkg": "1",
@@ -953,6 +1069,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0.TO_NM1LM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0.TO_NM1LM",
         "PerPkg": "1",
@@ -961,6 +1078,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0.TO_NMCache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0.TO_NMCache",
         "PerPkg": "1",
@@ -969,6 +1087,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_ALL",
         "FCMask": "0x00000000",
@@ -979,6 +1098,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_FROM_TGR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_FROM_TGR",
         "PerPkg": "1",
@@ -987,6 +1107,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_ISOCH",
         "PerPkg": "1",
@@ -995,6 +1116,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_NORMAL",
         "FCMask": "0x00000000",
@@ -1005,6 +1127,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_TO_DDR_AS_CACHE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1013,6 +1136,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_TO_DDR_AS_MEM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1021,6 +1145,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH0_TO_PMM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH0_TO_PMM",
         "FCMask": "0x00000000",
@@ -1031,6 +1156,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1.TO_NM1LM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1.TO_NM1LM",
         "PerPkg": "1",
@@ -1039,6 +1165,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1.TO_NMCache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1.TO_NMCache",
         "PerPkg": "1",
@@ -1047,6 +1174,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_ALL",
         "FCMask": "0x00000000",
@@ -1057,6 +1185,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_FROM_TGR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_FROM_TGR",
         "PerPkg": "1",
@@ -1065,6 +1194,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_ISOCH",
         "PerPkg": "1",
@@ -1073,6 +1203,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_NORMAL",
         "FCMask": "0x00000000",
@@ -1083,6 +1214,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_TO_DDR_AS_CACHE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1091,6 +1223,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_TO_DDR_AS_MEM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1099,6 +1232,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.CH1_TO_PMM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.CH1_TO_PMM",
         "FCMask": "0x00000000",
@@ -1109,6 +1243,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.FROM_TGR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.FROM_TGR",
         "PerPkg": "1",
@@ -1117,6 +1252,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.ISOCH",
         "PerPkg": "1",
@@ -1125,6 +1261,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.NORMAL",
         "PerPkg": "1",
@@ -1133,6 +1270,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.TO_DDR_AS_CACHE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1141,6 +1279,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.TO_DDR_AS_MEM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1149,6 +1288,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.TO_NM1LM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.TO_NM1LM",
         "PerPkg": "1",
@@ -1157,6 +1297,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.TO_NMCACHE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.TO_NMCACHE",
         "PerPkg": "1",
@@ -1165,6 +1306,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_READS.TO_PMM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_IMC_READS.TO_PMM",
         "PerPkg": "1",
@@ -1173,6 +1315,7 @@
     },
     {
         "BriefDescription": "All Writes - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.ALL",
         "PerPkg": "1",
@@ -1181,6 +1324,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0.NI",
         "PerPkg": "1",
@@ -1188,6 +1332,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_ALL",
         "FCMask": "0x00000000",
@@ -1198,6 +1343,7 @@
     },
     {
         "BriefDescription": "From TGR - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FROM_TGR",
         "PerPkg": "1",
@@ -1205,6 +1351,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_FULL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FULL",
         "FCMask": "0x00000000",
@@ -1215,6 +1362,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_FULL_ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FULL_ISOCH",
         "PerPkg": "1",
@@ -1223,6 +1371,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI",
         "PerPkg": "1",
@@ -1230,6 +1379,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI_MISS",
         "PerPkg": "1",
@@ -1237,6 +1387,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_PARTIAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_PARTIAL",
         "FCMask": "0x00000000",
@@ -1247,6 +1398,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_PARTIAL_ISOCH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -1255,6 +1407,7 @@
     },
     {
         "BriefDescription": "DDR, acting as Cache - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1263,6 +1416,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_IMC_WRITES.CH0_TO_DDR_AS_MEM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1271,6 +1425,7 @@
     },
     {
         "BriefDescription": "PMM - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH0_TO_PMM",
         "FCMask": "0x00000000",
@@ -1282,6 +1437,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1.NI",
         "PerPkg": "1",
@@ -1289,6 +1445,7 @@
     },
     {
         "BriefDescription": "All Writes - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_ALL",
         "FCMask": "0x00000000",
@@ -1299,6 +1456,7 @@
     },
     {
         "BriefDescription": "From TGR - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FROM_TGR",
         "PerPkg": "1",
@@ -1306,6 +1464,7 @@
     },
     {
         "BriefDescription": "Full Line Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FULL",
         "FCMask": "0x00000000",
@@ -1316,6 +1475,7 @@
     },
     {
         "BriefDescription": "ISOCH Full Line - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FULL_ISOCH",
         "PerPkg": "1",
@@ -1324,6 +1484,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI",
         "PerPkg": "1",
@@ -1331,6 +1492,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI_MISS",
         "PerPkg": "1",
@@ -1338,6 +1500,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_PARTIAL",
         "FCMask": "0x00000000",
@@ -1348,6 +1511,7 @@
     },
     {
         "BriefDescription": "ISOCH Partial - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -1356,6 +1520,7 @@
     },
     {
         "BriefDescription": "DDR, acting as Cache - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1364,6 +1529,7 @@
     },
     {
         "BriefDescription": "DDR - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1372,6 +1538,7 @@
     },
     {
         "BriefDescription": "PMM - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.CH1_TO_PMM",
         "FCMask": "0x00000000",
@@ -1383,6 +1550,7 @@
     },
     {
         "BriefDescription": "From TGR - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.FROM_TGR",
         "PerPkg": "1",
@@ -1390,6 +1558,7 @@
     },
     {
         "BriefDescription": "Full Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -1398,6 +1567,7 @@
     },
     {
         "BriefDescription": "ISOCH Full Line - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.FULL_ISOCH",
         "PerPkg": "1",
@@ -1406,6 +1576,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.NI",
         "PerPkg": "1",
@@ -1413,6 +1584,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.NI_MISS",
         "PerPkg": "1",
@@ -1420,6 +1592,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -1428,6 +1601,7 @@
     },
     {
         "BriefDescription": "ISOCH Partial - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -1436,6 +1610,7 @@
     },
     {
         "BriefDescription": "DDR, acting as Cache - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.TO_DDR_AS_CACHE",
         "PerPkg": "1",
@@ -1444,6 +1619,7 @@
     },
     {
         "BriefDescription": "DDR - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.TO_DDR_AS_MEM",
         "PerPkg": "1",
@@ -1452,6 +1628,7 @@
     },
     {
         "BriefDescription": "PMM - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_IMC_WRITES.TO_PMM",
         "PerPkg": "1",
@@ -1460,6 +1637,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_PREFCAM_CIS_DROPS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_M2M_PREFCAM_CIS_DROPS",
         "PerPkg": "1",
@@ -1467,6 +1645,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_UPI",
         "PerPkg": "1",
@@ -1475,6 +1654,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_XPT",
         "PerPkg": "1",
@@ -1483,6 +1663,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_UPI",
         "PerPkg": "1",
@@ -1491,6 +1672,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_XPT",
         "PerPkg": "1",
@@ -1499,6 +1681,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped : UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.UPI_ALLCH",
         "PerPkg": "1",
@@ -1507,6 +1690,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.XPT_ALLCH",
         "PerPkg": "1",
@@ -1515,6 +1699,7 @@
     },
     {
         "BriefDescription": ": UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.UPI_ALLCH",
         "PerPkg": "1",
@@ -1523,6 +1708,7 @@
     },
     {
         "BriefDescription": ": XPT - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.XPT_ALLCH",
         "PerPkg": "1",
@@ -1531,6 +1717,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.RD_MERGED",
         "PerPkg": "1",
@@ -1539,6 +1726,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.WR_MERGED",
         "PerPkg": "1",
@@ -1547,6 +1735,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5E",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.WR_SQUASHED",
         "PerPkg": "1",
@@ -1555,6 +1744,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.CH0_UPI",
         "PerPkg": "1",
@@ -1563,6 +1753,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.CH0_XPT",
         "PerPkg": "1",
@@ -1571,6 +1762,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.CH1_UPI",
         "PerPkg": "1",
@@ -1579,6 +1771,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.CH1_XPT",
         "PerPkg": "1",
@@ -1587,6 +1780,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.UPI_ALLCH",
         "PerPkg": "1",
@@ -1595,6 +1789,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_INSERTS.XPT_ALLCH",
         "PerPkg": "1",
@@ -1604,6 +1799,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.ALLCH",
         "PerPkg": "1",
@@ -1612,6 +1808,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1620,6 +1817,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1628,6 +1826,7 @@
     },
     {
         "BriefDescription": "All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5F",
         "EventName": "UNC_M2M_PREFCAM_RESP_MISS.ALLCH",
         "PerPkg": "1",
@@ -1636,6 +1835,7 @@
     },
     {
         "BriefDescription": ": Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_M2M_PREFCAM_RESP_MISS.CH0",
         "PerPkg": "1",
@@ -1644,6 +1844,7 @@
     },
     {
         "BriefDescription": ": Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_M2M_PREFCAM_RESP_MISS.CH1",
         "PerPkg": "1",
@@ -1652,6 +1853,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_PREFCAM_RxC_DEALLOCS.1LM_POSTED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2M_PREFCAM_RxC_DEALLOCS.1LM_POSTED",
         "PerPkg": "1",
@@ -1660,6 +1862,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_PREFCAM_RxC_DEALLOCS.CIS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2M_PREFCAM_RxC_DEALLOCS.CIS",
         "PerPkg": "1",
@@ -1668,6 +1871,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_PREFCAM_RxC_DEALLOCS.PMM_MEMMODE_ACCE=
PT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2M_PREFCAM_RxC_DEALLOCS.PMM_MEMMODE_ACCEPT",
         "PerPkg": "1",
@@ -1676,6 +1880,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_PREFCAM_RxC_DEALLOCS.SQUASHED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2M_PREFCAM_RxC_DEALLOCS.SQUASHED",
         "PerPkg": "1",
@@ -1684,6 +1889,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) Occupancy - Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_M2M_PREFCAM_RxC_OCCUPANCY",
         "PerPkg": "1",
@@ -1691,6 +1897,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) : AD Ingress (from CMS)=
 Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M2M_RxC_AD_INSERTS",
         "PerPkg": "1",
@@ -1699,6 +1906,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
         "PerPkg": "1",
@@ -1706,6 +1914,7 @@
     },
     {
         "BriefDescription": "Clean NearMem Read Hit",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_M2M_TAG_HIT.NM_RD_HIT_CLEAN",
         "PerPkg": "1",
@@ -1715,6 +1924,7 @@
     },
     {
         "BriefDescription": "Dirty NearMem Read Hit",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_M2M_TAG_HIT.NM_RD_HIT_DIRTY",
         "PerPkg": "1",
@@ -1724,6 +1934,7 @@
     },
     {
         "BriefDescription": "Tag Hit : Clean NearMem Underfill Hit",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_CLEAN",
         "PerPkg": "1",
@@ -1733,6 +1944,7 @@
     },
     {
         "BriefDescription": "Tag Hit : Dirty NearMem Underfill Hit",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_DIRTY",
         "PerPkg": "1",
@@ -1742,6 +1954,7 @@
     },
     {
         "BriefDescription": "UNC_M2M_TAG_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4b",
         "EventName": "UNC_M2M_TAG_MISS",
         "PerPkg": "1",
@@ -1750,6 +1963,7 @@
     },
     {
         "BriefDescription": "Number AD Ingress Credits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M2M_TGR_AD_CREDITS",
         "PerPkg": "1",
@@ -1757,6 +1971,7 @@
     },
     {
         "BriefDescription": "Number BL Ingress Credits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_M2M_TGR_BL_CREDITS",
         "PerPkg": "1",
@@ -1764,6 +1979,7 @@
     },
     {
         "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2M_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
@@ -1772,6 +1988,7 @@
     },
     {
         "BriefDescription": "Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2M_TRACKER_INSERTS.CH1",
         "PerPkg": "1",
@@ -1780,6 +1997,7 @@
     },
     {
         "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1788,6 +2006,7 @@
     },
     {
         "BriefDescription": "Tracker Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1796,6 +2015,7 @@
     },
     {
         "BriefDescription": "WPQ Flush : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2M_WPQ_FLUSH.CH0",
         "PerPkg": "1",
@@ -1804,6 +2024,7 @@
     },
     {
         "BriefDescription": "WPQ Flush : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2M_WPQ_FLUSH.CH1",
         "PerPkg": "1",
@@ -1812,6 +2033,7 @@
     },
     {
         "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular : Cha=
nnel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN0",
         "PerPkg": "1",
@@ -1820,6 +2042,7 @@
     },
     {
         "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular : Cha=
nnel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN1",
         "PerPkg": "1",
@@ -1828,6 +2051,7 @@
     },
     {
         "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special : Cha=
nnel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN0",
         "PerPkg": "1",
@@ -1836,6 +2060,7 @@
     },
     {
         "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special : Cha=
nnel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN1",
         "PerPkg": "1",
@@ -1844,6 +2069,7 @@
     },
     {
         "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2M_WR_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
@@ -1852,6 +2078,7 @@
     },
     {
         "BriefDescription": "Write Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2M_WR_TRACKER_INSERTS.CH1",
         "PerPkg": "1",
@@ -1860,6 +2087,7 @@
     },
     {
         "BriefDescription": "Write Tracker Cycles Not Empty : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_M2M_WR_TRACKER_NE.CH0",
         "PerPkg": "1",
@@ -1868,6 +2096,7 @@
     },
     {
         "BriefDescription": "Write Tracker Cycles Not Empty : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_M2M_WR_TRACKER_NE.CH1",
         "PerPkg": "1",
@@ -1876,6 +2105,7 @@
     },
     {
         "BriefDescription": "Write Tracker Cycles Not Empty : Mirror",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR",
         "PerPkg": "1",
@@ -1884,6 +2114,7 @@
     },
     {
         "BriefDescription": "Write Tracker Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR_NONTGR",
         "PerPkg": "1",
@@ -1892,6 +2123,7 @@
     },
     {
         "BriefDescription": "Write Tracker Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR_PWR",
         "PerPkg": "1",
@@ -1900,6 +2132,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_INSERTS.CH0",
         "PerPkg": "1",
@@ -1908,6 +2141,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_INSERTS.CH1",
         "PerPkg": "1",
@@ -1916,6 +2150,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1924,6 +2159,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1932,6 +2168,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2M_WR_TRACKER_POSTED_INSERTS.CH0",
         "PerPkg": "1",
@@ -1940,6 +2177,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2M_WR_TRACKER_POSTED_INSERTS.CH1",
         "PerPkg": "1",
@@ -1948,6 +2186,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2M_WR_TRACKER_POSTED_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1956,6 +2195,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2M_WR_TRACKER_POSTED_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1964,6 +2204,7 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty : Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.REQ",
         "PerPkg": "1",
@@ -1973,6 +2214,7 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty : Snoops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.SNP",
         "PerPkg": "1",
@@ -1982,6 +2224,7 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty : VNA Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -1991,6 +2234,7 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty : Writebacks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.WB",
         "PerPkg": "1",
@@ -2000,6 +2244,7 @@
     },
     {
         "BriefDescription": "M3UPI Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M3UPI_CLOCKTICKS",
         "PerPkg": "1",
@@ -2008,6 +2253,7 @@
     },
     {
         "BriefDescription": "M3UPI CMS Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M3UPI_CMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -2015,6 +2261,7 @@
     },
     {
         "BriefDescription": "D2C Sent",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_M3UPI_D2C_SENT",
         "PerPkg": "1",
@@ -2023,6 +2270,7 @@
     },
     {
         "BriefDescription": "D2U Sent",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_M3UPI_D2U_SENT",
         "PerPkg": "1",
@@ -2031,6 +2279,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M3UPI_EGRESS_ORDERING.IV_SNOOPGO_DN",
         "PerPkg": "1",
@@ -2040,6 +2289,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M3UPI_EGRESS_ORDERING.IV_SNOOPGO_UP",
         "PerPkg": "1",
@@ -2049,6 +2299,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO0 and IIO1 share the=
 same ring destination. (1 VN0 credit only)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO1_NCB",
         "PerPkg": "1",
@@ -2058,6 +2309,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO2_NCB",
         "PerPkg": "1",
@@ -2067,6 +2319,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO3_NCB",
         "PerPkg": "1",
@@ -2076,6 +2329,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO4_NCB",
         "PerPkg": "1",
@@ -2085,6 +2339,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO5_NCB",
         "PerPkg": "1",
@@ -2094,6 +2349,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : All IIO targets for NCS=
 are in single mask. ORs them together",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.NCS",
         "PerPkg": "1",
@@ -2103,6 +2359,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : Selected M2p BL NCS cre=
dits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.NCS_SEL",
         "PerPkg": "1",
@@ -2112,6 +2369,7 @@
     },
     {
         "BriefDescription": "M2 BL Credits Empty : IIO5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.UBOX_NCB",
         "PerPkg": "1",
@@ -2121,6 +2379,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : AD - Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT0",
         "PerPkg": "1",
@@ -2130,6 +2389,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : AD - Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT1",
         "PerPkg": "1",
@@ -2139,6 +2399,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : AD - Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT2",
         "PerPkg": "1",
@@ -2148,6 +2409,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : AK - Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AK_SLOT0",
         "PerPkg": "1",
@@ -2157,6 +2419,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : AK - Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AK_SLOT2",
         "PerPkg": "1",
@@ -2166,6 +2429,7 @@
     },
     {
         "BriefDescription": "Multi Slot Flit Received : BL - Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.BL_SLOT0",
         "PerPkg": "1",
@@ -2625,6 +2889,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Bypasses : AD to Slot 0 on BL A=
rb",
+        "Counter": "0,1,2",
         "EventCode": "0x40",
         "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S0_BL_ARB",
         "PerPkg": "1",
@@ -2634,6 +2899,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Bypasses : AD to Slot 0 on Idle=
",
+        "Counter": "0,1,2",
         "EventCode": "0x40",
         "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S0_IDLE",
         "PerPkg": "1",
@@ -2643,6 +2909,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Bypasses : AD + BL to Slot 1",
+        "Counter": "0,1,2",
         "EventCode": "0x40",
         "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S1_BL_SLOT",
         "PerPkg": "1",
@@ -2652,6 +2919,7 @@
     },
     {
         "BriefDescription": "Ingress Queue Bypasses : AD + BL to Slot 2",
+        "Counter": "0,1,2",
         "EventCode": "0x40",
         "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S2_BL_SLOT",
         "PerPkg": "1",
@@ -3296,6 +3564,7 @@
     },
     {
         "BriefDescription": "Message Held : Can't Slot AD",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.CANT_SLOT_AD",
         "PerPkg": "1",
@@ -3305,6 +3574,7 @@
     },
     {
         "BriefDescription": "Message Held : Can't Slot BL",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.CANT_SLOT_BL",
         "PerPkg": "1",
@@ -3314,6 +3584,7 @@
     },
     {
         "BriefDescription": "Message Held : Parallel Attempt",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_ATTEMPT",
         "PerPkg": "1",
@@ -3323,6 +3594,7 @@
     },
     {
         "BriefDescription": "Message Held : Parallel Success",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_SUCCESS",
         "PerPkg": "1",
@@ -3332,6 +3604,7 @@
     },
     {
         "BriefDescription": "Message Held : VN0",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.VN0",
         "PerPkg": "1",
@@ -3341,6 +3614,7 @@
     },
     {
         "BriefDescription": "Message Held : VN1",
+        "Counter": "0,1,2",
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.VN1",
         "PerPkg": "1",
@@ -3350,6 +3624,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : REQ on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_REQ",
         "PerPkg": "1",
@@ -3359,6 +3634,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : RSP on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_RSP",
         "PerPkg": "1",
@@ -3368,6 +3644,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : SNP on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_SNP",
         "PerPkg": "1",
@@ -3377,6 +3654,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : NCB on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_NCB",
         "PerPkg": "1",
@@ -3386,6 +3664,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : NCS on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_NCS",
         "PerPkg": "1",
@@ -3395,6 +3674,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : RSP on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_RSP",
         "PerPkg": "1",
@@ -3404,6 +3684,7 @@
     },
     {
         "BriefDescription": "VN0 message can't slot into flit : WB on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4e",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_WB",
         "PerPkg": "1",
@@ -3413,6 +3694,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : REQ on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_REQ",
         "PerPkg": "1",
@@ -3422,6 +3704,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : RSP on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_RSP",
         "PerPkg": "1",
@@ -3431,6 +3714,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : SNP on AD",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_SNP",
         "PerPkg": "1",
@@ -3440,6 +3724,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : NCB on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_NCB",
         "PerPkg": "1",
@@ -3449,6 +3734,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : NCS on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_NCS",
         "PerPkg": "1",
@@ -3458,6 +3744,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : RSP on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_RSP",
         "PerPkg": "1",
@@ -3467,6 +3754,7 @@
     },
     {
         "BriefDescription": "VN1 message can't slot into flit : WB on BL",
+        "Counter": "0,1,2",
         "EventCode": "0x4f",
         "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_WB",
         "PerPkg": "1",
@@ -3674,6 +3962,7 @@
     },
     {
         "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS",
         "FCMask": "0x00000000",
@@ -3684,6 +3973,7 @@
     },
     {
         "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT0",
         "PerPkg": "1",
@@ -3693,6 +3983,7 @@
     },
     {
         "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT1",
         "PerPkg": "1",
@@ -3702,6 +3993,7 @@
     },
     {
         "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT2",
         "PerPkg": "1",
@@ -3711,6 +4003,7 @@
     },
     {
         "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.BL_EARLY_RSP",
         "PerPkg": "1",
@@ -3720,6 +4013,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN0 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_REQ",
         "PerPkg": "1",
@@ -3729,6 +4023,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN0 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_RSP",
         "PerPkg": "1",
@@ -3738,6 +4033,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN0 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_SNP",
         "PerPkg": "1",
@@ -3747,6 +4043,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN0 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_WB",
         "PerPkg": "1",
@@ -3756,6 +4053,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN1 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_REQ",
         "PerPkg": "1",
@@ -3765,6 +4063,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN1 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_RSP",
         "PerPkg": "1",
@@ -3774,6 +4073,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN1 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_SNP",
         "PerPkg": "1",
@@ -3783,6 +4083,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Not Empty : VN1 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_WB",
         "PerPkg": "1",
@@ -3792,6 +4093,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN0 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_REQ",
         "PerPkg": "1",
@@ -3801,6 +4103,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN0 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_RSP",
         "PerPkg": "1",
@@ -3810,6 +4113,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN0 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_SNP",
         "PerPkg": "1",
@@ -3819,6 +4123,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN0 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_WB",
         "PerPkg": "1",
@@ -3828,6 +4133,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN1 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_REQ",
         "PerPkg": "1",
@@ -3837,6 +4143,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN1 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_RSP",
         "PerPkg": "1",
@@ -3846,6 +4153,7 @@
     },
     {
         "BriefDescription": "AD Flow Q Inserts : VN1 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_SNP",
         "PerPkg": "1",
@@ -3911,6 +4219,7 @@
     },
     {
         "BriefDescription": "AK Flow Q Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_M3UPI_TxC_AK_FLQ_INSERTS",
         "PerPkg": "1",
@@ -3997,6 +4306,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN0 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_REQ",
         "PerPkg": "1",
@@ -4006,6 +4316,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN0 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_RSP",
         "PerPkg": "1",
@@ -4015,6 +4326,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN0 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_SNP",
         "PerPkg": "1",
@@ -4024,6 +4336,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN0 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_WB",
         "PerPkg": "1",
@@ -4033,6 +4346,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN1 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_REQ",
         "PerPkg": "1",
@@ -4042,6 +4356,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN1 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_RSP",
         "PerPkg": "1",
@@ -4051,6 +4366,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN1 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_SNP",
         "PerPkg": "1",
@@ -4060,6 +4376,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Not Empty : VN1 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_WB",
         "PerPkg": "1",
@@ -4069,6 +4386,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN0 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_NCB",
         "PerPkg": "1",
@@ -4078,6 +4396,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN0 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_NCS",
         "PerPkg": "1",
@@ -4087,6 +4406,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN0 NCS Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_RSP",
         "PerPkg": "1",
@@ -4096,6 +4416,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN0 NCB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_WB",
         "PerPkg": "1",
@@ -4105,6 +4426,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN1 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_NCB",
         "PerPkg": "1",
@@ -4114,6 +4436,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN1 WB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_NCS",
         "PerPkg": "1",
@@ -4123,6 +4446,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN1_NCB Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_RSP",
         "PerPkg": "1",
@@ -4132,6 +4456,7 @@
     },
     {
         "BriefDescription": "BL Flow Q Inserts : VN1_NCS Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_WB",
         "PerPkg": "1",
@@ -4253,6 +4578,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN0 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_REQ",
         "PerPkg": "1",
@@ -4262,6 +4588,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN0 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_RSP",
         "PerPkg": "1",
@@ -4271,6 +4598,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN0 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_SNP",
         "PerPkg": "1",
@@ -4280,6 +4608,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN1 REQ Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_REQ",
         "PerPkg": "1",
@@ -4289,6 +4618,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN1 RSP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_RSP",
         "PerPkg": "1",
@@ -4298,6 +4628,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VN1 SNP Messages",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_SNP",
         "PerPkg": "1",
@@ -4307,6 +4638,7 @@
     },
     {
         "BriefDescription": "UPI0 AD Credits Empty : VNA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -4379,6 +4711,7 @@
     },
     {
         "BriefDescription": "FlowQ Generated Prefetch",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
         "PerPkg": "1",
@@ -4826,6 +5159,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AD Bouncable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.AD_BNC",
         "PerPkg": "1",
@@ -4835,6 +5169,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AD credited)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.AD_CRD",
         "PerPkg": "1",
@@ -4844,6 +5179,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AK)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.AK",
         "PerPkg": "1",
@@ -4853,6 +5189,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AKC)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.AKC",
         "PerPkg": "1",
@@ -4862,6 +5199,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (BL Bouncable)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.BL_BNC",
         "PerPkg": "1",
@@ -4871,6 +5209,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (BL credited)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.BL_CRD",
         "PerPkg": "1",
@@ -4880,6 +5219,7 @@
     },
     {
         "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (IV)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.IV",
         "PerPkg": "1",
@@ -4889,6 +5229,7 @@
     },
     {
         "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AD)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AD",
         "PerPkg": "1",
@@ -4898,6 +5239,7 @@
     },
     {
         "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AK)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AK",
         "PerPkg": "1",
@@ -4907,6 +5249,7 @@
     },
     {
         "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (AKC)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.AKC",
         "PerPkg": "1",
@@ -4916,6 +5259,7 @@
     },
     {
         "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (BL)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.BL",
         "PerPkg": "1",
@@ -4925,6 +5269,7 @@
     },
     {
         "BriefDescription": "Number of cycles incoming messages from the v=
ertical ring that are bounced at the SBO\r\nIngress (V-EMIB) (IV)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_MDF_CRS_TxR_V_BOUNCES.IV",
         "PerPkg": "1",
@@ -4934,6 +5279,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when the distress=
 signals are asserted based on SBO Ingress threshold",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_MDF_FAST_ASSERTED.AD_BNC",
         "PerPkg": "1",
@@ -4943,6 +5289,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when the distress=
 signals are asserted based on SBO Ingress threshold",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_MDF_FAST_ASSERTED.BL_CRD",
         "PerPkg": "1",
@@ -4952,6 +5299,7 @@
     },
     {
         "BriefDescription": "UPI Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_UPI_CLOCKTICKS",
         "PerPkg": "1",
@@ -4960,6 +5308,7 @@
     },
     {
         "BriefDescription": "Direct packet attempts : D2C",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
         "PerPkg": "1",
@@ -4969,6 +5318,7 @@
     },
     {
         "BriefDescription": "Direct packet attempts : D2K",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2K",
         "PerPkg": "1",
@@ -4978,6 +5328,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ0",
         "PerPkg": "1",
@@ -4986,6 +5337,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ1",
         "PerPkg": "1",
@@ -4994,6 +5346,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ2",
         "PerPkg": "1",
@@ -5002,6 +5355,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ0",
         "PerPkg": "1",
@@ -5010,6 +5364,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ1",
         "PerPkg": "1",
@@ -5018,6 +5373,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ2",
         "PerPkg": "1",
@@ -5026,6 +5382,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ3",
         "PerPkg": "1",
@@ -5034,6 +5391,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.BL_VNA_EQ0",
         "PerPkg": "1",
@@ -5042,6 +5400,7 @@
     },
     {
         "BriefDescription": "Cycles in L1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_UPI_L1_POWER_CYCLES",
         "PerPkg": "1",
@@ -5050,6 +5409,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.BGF_CRD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_UPI_M3_BYP_BLOCKED.BGF_CRD",
         "PerPkg": "1",
@@ -5058,6 +5418,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AD_VNA_LE2",
         "PerPkg": "1",
@@ -5066,6 +5427,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AK_VNA_LE3",
         "PerPkg": "1",
@@ -5074,6 +5436,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_BL_VNA_EQ0",
         "PerPkg": "1",
@@ -5082,6 +5445,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.GV_BLOCK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_UPI_M3_BYP_BLOCKED.GV_BLOCK",
         "PerPkg": "1",
@@ -5090,6 +5454,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_CRD_RETURN_BLOCKED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_UPI_M3_CRD_RETURN_BLOCKED",
         "PerPkg": "1",
@@ -5097,6 +5462,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.BGF_CRD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.BGF_CRD",
         "PerPkg": "1",
@@ -5105,6 +5471,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_BTW_2_THR=
ESH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_BTW_2_THRESH",
         "PerPkg": "1",
@@ -5113,6 +5480,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_LE2",
         "PerPkg": "1",
@@ -5121,6 +5489,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AK_VNA_LE3",
         "PerPkg": "1",
@@ -5129,6 +5498,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_BTW_0_THR=
ESH",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_BTW_0_THRESH",
         "PerPkg": "1",
@@ -5137,6 +5507,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_EQ0",
         "PerPkg": "1",
@@ -5145,6 +5516,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.GV_BLOCK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_UPI_M3_RXQ_BLOCKED.GV_BLOCK",
         "PerPkg": "1",
@@ -5153,6 +5525,7 @@
     },
     {
         "BriefDescription": "Cycles where phy is not in L0, L0c, L0p, L1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_UPI_PHY_INIT_CYCLES",
         "PerPkg": "1",
@@ -5160,6 +5533,7 @@
     },
     {
         "BriefDescription": "L1 Req Nack",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_UPI_POWER_L1_NACK",
         "PerPkg": "1",
@@ -5168,6 +5542,7 @@
     },
     {
         "BriefDescription": "L1 Req (same as L1 Ack).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_UPI_POWER_L1_REQ",
         "PerPkg": "1",
@@ -5176,6 +5551,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.ACK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.ACK",
         "PerPkg": "1",
@@ -5184,6 +5560,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VN0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VN0",
         "PerPkg": "1",
@@ -5192,6 +5569,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VN1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VN1",
         "PerPkg": "1",
@@ -5200,6 +5578,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VNA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VNA",
         "PerPkg": "1",
@@ -5208,6 +5587,7 @@
     },
     {
         "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -5216,6 +5596,7 @@
     },
     {
         "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_UPI_RxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -5224,6 +5605,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.DATA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.DATA",
         "PerPkg": "1",
@@ -5232,6 +5614,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.LLCRD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.LLCRD",
         "PerPkg": "1",
@@ -5240,6 +5623,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.LLCTRL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.LLCTRL",
         "PerPkg": "1",
@@ -5248,6 +5632,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.NULL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.NULL",
         "PerPkg": "1",
@@ -5256,6 +5641,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.PROTHDR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.PROTHDR",
         "PerPkg": "1",
@@ -5264,6 +5650,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.SLOT0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.SLOT0",
         "PerPkg": "1",
@@ -5272,6 +5659,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.SLOT1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.SLOT1",
         "PerPkg": "1",
@@ -5280,6 +5668,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_ANY_FLITS.SLOT2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4B",
         "EventName": "UNC_UPI_RxL_ANY_FLITS.SLOT2",
         "PerPkg": "1",
@@ -5288,6 +5677,7 @@
     },
     {
         "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
@@ -5297,6 +5687,7 @@
     },
     {
         "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
@@ -5306,6 +5697,7 @@
     },
     {
         "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
@@ -5315,6 +5707,7 @@
     },
     {
         "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
@@ -5324,6 +5717,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
         "PerPkg": "1",
@@ -5333,6 +5727,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
         "PerPkg": "1",
@@ -5342,6 +5737,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
         "PerPkg": "1",
@@ -5351,6 +5747,7 @@
     },
     {
         "BriefDescription": "CRC Errors Detected",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0b",
         "EventName": "UNC_UPI_RxL_CRC_ERRORS",
         "PerPkg": "1",
@@ -5359,6 +5756,7 @@
     },
     {
         "BriefDescription": "LLR Requests Sent",
+        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "UNC_UPI_RxL_CRC_LLR_REQ_TRANSMIT",
         "PerPkg": "1",
@@ -5367,6 +5765,7 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VN0",
         "PerPkg": "1",
@@ -5375,6 +5774,7 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VN1",
         "PerPkg": "1",
@@ -5383,6 +5783,7 @@
     },
     {
         "BriefDescription": "VNA Credit Consumed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VNA",
         "FCMask": "0x00000000",
@@ -5393,6 +5794,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : All Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
         "PerPkg": "1",
@@ -5402,6 +5804,7 @@
     },
     {
         "BriefDescription": "Null FLITs received from any slot",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
         "PerPkg": "1",
@@ -5410,6 +5813,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.DATA",
         "PerPkg": "1",
@@ -5419,6 +5823,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Idle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.IDLE",
         "PerPkg": "1",
@@ -5428,6 +5833,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : LLCRD Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
         "PerPkg": "1",
@@ -5437,6 +5843,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : LLCTRL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
         "PerPkg": "1",
@@ -5446,6 +5853,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : All Non Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
         "PerPkg": "1",
@@ -5455,6 +5863,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.NULL",
         "PerPkg": "1",
@@ -5464,6 +5873,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Protocol Header",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
         "PerPkg": "1",
@@ -5473,6 +5883,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
         "PerPkg": "1",
@@ -5482,6 +5893,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
         "PerPkg": "1",
@@ -5491,6 +5903,7 @@
     },
     {
         "BriefDescription": "Valid Flits Received : Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
         "PerPkg": "1",
@@ -5500,6 +5913,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
         "PerPkg": "1",
@@ -5509,6 +5923,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
         "PerPkg": "1",
@@ -5518,6 +5933,7 @@
     },
     {
         "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
         "PerPkg": "1",
@@ -5527,6 +5943,7 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
         "PerPkg": "1",
@@ -5536,6 +5953,7 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
         "PerPkg": "1",
@@ -5545,6 +5963,7 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
         "PerPkg": "1",
@@ -5554,6 +5973,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ1",
         "PerPkg": "1",
@@ -5562,6 +5982,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ2",
         "PerPkg": "1",
@@ -5570,6 +5991,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ0",
         "PerPkg": "1",
@@ -5578,6 +6000,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ2",
         "PerPkg": "1",
@@ -5586,6 +6009,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ0",
         "PerPkg": "1",
@@ -5594,6 +6018,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ1",
         "PerPkg": "1",
@@ -5602,6 +6027,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.CFG_CTL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.CFG_CTL",
         "PerPkg": "1",
@@ -5610,6 +6036,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.DFX",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.DFX",
         "PerPkg": "1",
@@ -5618,6 +6045,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RETRY",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RETRY",
         "PerPkg": "1",
@@ -5626,6 +6054,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ",
         "PerPkg": "1",
@@ -5634,6 +6063,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_BYPASS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_BYPASS",
         "PerPkg": "1",
@@ -5642,6 +6072,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_CRED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_CRED",
         "PerPkg": "1",
@@ -5650,6 +6081,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.SPARE",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.SPARE",
         "PerPkg": "1",
@@ -5658,6 +6090,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.TXQ",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.TXQ",
         "PerPkg": "1",
@@ -5666,6 +6099,7 @@
     },
     {
         "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -5674,6 +6108,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
         "PerPkg": "1",
@@ -5681,6 +6116,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
         "PerPkg": "1",
@@ -5688,6 +6124,7 @@
     },
     {
         "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_UPI_TxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -5696,6 +6133,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.DATA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.DATA",
         "PerPkg": "1",
@@ -5704,6 +6142,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.LLCRD",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.LLCRD",
         "PerPkg": "1",
@@ -5712,6 +6151,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.LLCTRL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.LLCTRL",
         "PerPkg": "1",
@@ -5720,6 +6160,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.NULL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.NULL",
         "PerPkg": "1",
@@ -5728,6 +6169,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.PROTHDR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.PROTHDR",
         "PerPkg": "1",
@@ -5736,6 +6178,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.SLOT0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.SLOT0",
         "PerPkg": "1",
@@ -5744,6 +6187,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.SLOT1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.SLOT1",
         "PerPkg": "1",
@@ -5752,6 +6196,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_TxL_ANY_FLITS.SLOT2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4A",
         "EventName": "UNC_UPI_TxL_ANY_FLITS.SLOT2",
         "PerPkg": "1",
@@ -5760,6 +6205,7 @@
     },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
@@ -5769,6 +6215,7 @@
     },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
@@ -5778,6 +6225,7 @@
     },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
@@ -5787,6 +6235,7 @@
     },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
@@ -5796,6 +6245,7 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_UPI_TxL_BYPASSED",
         "PerPkg": "1",
@@ -5804,6 +6254,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : All Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
         "PerPkg": "1",
@@ -5813,6 +6264,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : All LLCRD Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_LLCRD",
         "PerPkg": "1",
@@ -5822,6 +6274,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : All LLCTRL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_LLCTRL",
         "PerPkg": "1",
@@ -5831,6 +6284,7 @@
     },
     {
         "BriefDescription": "All Null Flits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
         "PerPkg": "1",
@@ -5839,6 +6293,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : All Protocol Header",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_PROTHDR",
         "PerPkg": "1",
@@ -5848,6 +6303,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.DATA",
         "PerPkg": "1",
@@ -5857,6 +6313,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Idle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.IDLE",
         "PerPkg": "1",
@@ -5866,6 +6323,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : LLCRD Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
         "PerPkg": "1",
@@ -5875,6 +6333,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : LLCTRL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
         "PerPkg": "1",
@@ -5884,6 +6343,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : All Non Data",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
         "PerPkg": "1",
@@ -5893,6 +6353,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.NULL",
         "PerPkg": "1",
@@ -5902,6 +6363,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Protocol Header",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
         "PerPkg": "1",
@@ -5911,6 +6373,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Slot 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
         "PerPkg": "1",
@@ -5920,6 +6383,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Slot 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
         "PerPkg": "1",
@@ -5929,6 +6393,7 @@
     },
     {
         "BriefDescription": "Valid Flits Sent : Slot 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
         "PerPkg": "1",
@@ -5938,6 +6403,7 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_UPI_TxL_INSERTS",
         "PerPkg": "1",
@@ -5946,6 +6412,7 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_UPI_TxL_OCCUPANCY",
         "PerPkg": "1",
@@ -5954,6 +6421,7 @@
     },
     {
         "BriefDescription": "UNC_UPI_VNA_CREDIT_RETURN_BLOCKED_VN01",
+        "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_UPI_VNA_CREDIT_RETURN_BLOCKED_VN01",
         "PerPkg": "1",
@@ -5961,6 +6429,7 @@
     },
     {
         "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_UPI_VNA_CREDIT_RETURN_OCCUPANCY",
         "PerPkg": "1",
@@ -5969,6 +6438,7 @@
     },
     {
         "BriefDescription": "Message Received : Doorbell",
+        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
@@ -5977,6 +6447,7 @@
     },
     {
         "BriefDescription": "Message Received : Interrupt",
+        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "PerPkg": "1",
@@ -5986,6 +6457,7 @@
     },
     {
         "BriefDescription": "Message Received : IPI",
+        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
         "PerPkg": "1",
@@ -5995,6 +6467,7 @@
     },
     {
         "BriefDescription": "Message Received : MSI",
+        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
         "PerPkg": "1",
@@ -6004,6 +6477,7 @@
     },
     {
         "BriefDescription": "Message Received : VLW",
+        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
         "PerPkg": "1",
@@ -6157,6 +6631,7 @@
     },
     {
         "BriefDescription": "Cycles PHOLD Assert to Ack : Assert to ACK",
+        "Counter": "0,1",
         "EventCode": "0x45",
         "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
@@ -6190,6 +6665,7 @@
     },
     {
         "BriefDescription": "RACU Request",
+        "Counter": "0,1",
         "EventCode": "0x46",
         "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
index 8b5f54fed..caf82e7ba 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "1",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "2",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART1_FREERUN",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "3",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART2_FREERUN",
         "PerPkg": "1",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "4",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART3_FREERUN",
         "PerPkg": "1",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "5",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART4_FREERUN",
         "PerPkg": "1",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "6",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART5_FREERUN",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "7",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART6_FREERUN",
         "PerPkg": "1",
@@ -57,6 +64,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "8",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_IN.PART7_FREERUN",
         "PerPkg": "1",
@@ -65,6 +73,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "9",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART0_FREERUN",
         "PerPkg": "1",
@@ -73,6 +82,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "10",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART1_FREERUN",
         "PerPkg": "1",
@@ -81,6 +91,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "11",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART2_FREERUN",
         "PerPkg": "1",
@@ -89,6 +100,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "12",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART3_FREERUN",
         "PerPkg": "1",
@@ -97,6 +109,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "13",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART4_FREERUN",
         "PerPkg": "1",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "14",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART5_FREERUN",
         "PerPkg": "1",
@@ -113,6 +127,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "15",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART6_FREERUN",
         "PerPkg": "1",
@@ -121,6 +136,7 @@
     },
     {
         "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "16",
         "EventCode": "0xff",
         "EventName": "UNC_IIO_BANDWIDTH_OUT.PART7_FREERUN",
         "PerPkg": "1",
@@ -129,6 +145,7 @@
     },
     {
         "BriefDescription": "IIO Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
@@ -146,6 +163,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0-7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
         "FCMask": "0x07",
@@ -157,6 +175,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
         "FCMask": "0x07",
@@ -168,6 +187,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
         "FCMask": "0x07",
@@ -179,6 +199,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
         "FCMask": "0x07",
@@ -190,6 +211,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
         "FCMask": "0x07",
@@ -201,6 +223,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
         "FCMask": "0x07",
@@ -212,6 +235,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 5",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
         "FCMask": "0x07",
@@ -223,6 +247,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 6",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
         "FCMask": "0x07",
@@ -234,6 +259,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
         "FCMask": "0x07",
@@ -245,6 +271,7 @@
     },
     {
         "BriefDescription": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
         "FCMask": "0x07",
@@ -254,6 +281,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 0",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
         "FCMask": "0x07",
@@ -265,6 +293,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 1",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
         "FCMask": "0x07",
@@ -276,6 +305,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 2",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
         "FCMask": "0x07",
@@ -287,6 +317,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 3",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
         "FCMask": "0x07",
@@ -298,6 +329,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 4",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
         "FCMask": "0x07",
@@ -309,6 +341,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 5",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
         "FCMask": "0x07",
@@ -320,6 +353,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 6",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
         "FCMask": "0x07",
@@ -331,6 +365,7 @@
     },
     {
         "BriefDescription": "PCIe Completion Buffer Occupancy : Part 7",
+        "Counter": "2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
         "FCMask": "0x07",
@@ -342,6 +377,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part0-7",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.ALL_PARTS",
         "FCMask": "0x07",
@@ -352,6 +388,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part0",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -363,6 +400,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part1",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -374,6 +412,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part2",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -385,6 +424,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part3",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -396,6 +436,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reading from=
 Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -407,6 +448,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reading from=
 Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -418,6 +460,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reading from=
 Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -429,6 +472,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reading from=
 Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -440,6 +484,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made to IIO Part0-7 =
by the CPU",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
         "FCMask": "0x07",
@@ -450,6 +495,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU0",
         "FCMask": "0x07",
@@ -461,6 +507,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU1",
         "FCMask": "0x07",
@@ -472,6 +519,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made to IIO Part0 by=
 the CPU",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -483,6 +531,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made to IIO Part1 by=
 the CPU",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -494,6 +543,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made to IIO Part2 by=
 the CPU",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -505,6 +555,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made to IIO Part3 by=
 the CPU",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -516,6 +567,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -527,6 +579,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -538,6 +591,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -549,6 +603,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -560,6 +615,7 @@
     },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
         "FCMask": "0x07",
@@ -571,6 +627,7 @@
     },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
         "FCMask": "0x07",
@@ -582,6 +639,7 @@
     },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
         "FCMask": "0x07",
@@ -593,6 +651,7 @@
     },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
         "FCMask": "0x07",
@@ -604,6 +663,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART4",
         "FCMask": "0x07",
@@ -615,6 +675,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART5",
         "FCMask": "0x07",
@@ -626,6 +687,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART6",
         "FCMask": "0x07",
@@ -637,6 +699,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART7",
         "FCMask": "0x07",
@@ -648,6 +711,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
@@ -659,6 +723,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
@@ -670,6 +735,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
@@ -681,6 +747,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
@@ -692,6 +759,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART4",
         "FCMask": "0x07",
@@ -703,6 +771,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART5",
         "FCMask": "0x07",
@@ -714,6 +783,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART6",
         "FCMask": "0x07",
@@ -725,6 +795,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART7",
         "FCMask": "0x07",
@@ -736,6 +807,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.ALL_PARTS",
         "FCMask": "0x07",
@@ -747,6 +819,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART0",
         "FCMask": "0x07",
@@ -758,6 +831,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART1",
         "FCMask": "0x07",
@@ -769,6 +843,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART2",
         "FCMask": "0x07",
@@ -780,6 +855,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART3",
         "FCMask": "0x07",
@@ -791,6 +867,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART4",
         "FCMask": "0x07",
@@ -802,6 +879,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART5",
         "FCMask": "0x07",
@@ -813,6 +891,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART6",
         "FCMask": "0x07",
@@ -824,6 +903,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART7",
         "FCMask": "0x07",
@@ -835,6 +915,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by IIO Part0-7 =
to Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS",
         "FCMask": "0x07",
@@ -845,6 +926,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by IIO Part0 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -856,6 +938,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by IIO Part1 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -867,6 +950,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by IIO Part2 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -878,6 +962,7 @@
     },
     {
         "BriefDescription": "Read request for 4 bytes made by IIO Part3 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -889,6 +974,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -900,6 +986,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -911,6 +998,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -922,6 +1010,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -933,6 +1022,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made by IIO Part0-7 =
to Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS",
         "FCMask": "0x07",
@@ -943,6 +1033,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made by IIO Part0 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -954,6 +1045,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made by IIO Part1 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -965,6 +1057,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made by IIO Part2 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -976,6 +1069,7 @@
     },
     {
         "BriefDescription": "Write request of 4 bytes made by IIO Part3 to=
 Memory",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -987,6 +1081,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -998,6 +1093,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -1009,6 +1105,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -1020,6 +1117,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -1031,6 +1129,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
@@ -1042,6 +1141,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
@@ -1053,6 +1153,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
@@ -1064,6 +1165,7 @@
     },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
@@ -1075,6 +1177,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
         "FCMask": "0x07",
@@ -1086,6 +1189,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
         "FCMask": "0x07",
@@ -1097,6 +1201,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
         "FCMask": "0x07",
@@ -1108,6 +1213,7 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
         "FCMask": "0x07",
@@ -1119,6 +1225,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Passing data =
to be written",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.DATA",
         "FCMask": "0x07",
@@ -1130,6 +1237,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Issuing final=
 read or write of line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.FINAL_RD_WR",
         "FCMask": "0x07",
@@ -1141,6 +1249,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Processing re=
sponse from IOMMU",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.IOMMU_HIT",
         "FCMask": "0x07",
@@ -1152,6 +1261,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Issuing to IO=
MMU",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.IOMMU_REQ",
         "FCMask": "0x07",
@@ -1163,6 +1273,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Request Owner=
ship",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.REQ_OWN",
         "FCMask": "0x07",
@@ -1174,6 +1285,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests : Writing line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_IIO_INBOUND_ARB_REQ.WR",
         "FCMask": "0x07",
@@ -1185,6 +1297,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Passi=
ng data to be written",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.DATA",
         "FCMask": "0x07",
@@ -1196,6 +1309,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Issui=
ng final read or write of line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.FINAL_RD_WR",
         "FCMask": "0x07",
@@ -1207,6 +1321,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Proce=
ssing response from IOMMU",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.IOMMU_HIT",
         "FCMask": "0x07",
@@ -1218,6 +1333,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Issui=
ng to IOMMU",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.IOMMU_REQ",
         "FCMask": "0x07",
@@ -1229,6 +1345,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Reque=
st Ownership",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.REQ_OWN",
         "FCMask": "0x07",
@@ -1240,6 +1357,7 @@
     },
     {
         "BriefDescription": "Incoming arbitration requests granted : Writi=
ng line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_IIO_INBOUND_ARB_WON.WR",
         "FCMask": "0x07",
@@ -1300,6 +1418,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 2M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWC_1G_HITS",
         "PerPkg": "1",
@@ -1309,6 +1428,7 @@
     },
     {
         "BriefDescription": ": PWT Hit to a 256T page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWC_256T_HITS",
         "PerPkg": "1",
@@ -1318,6 +1438,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 4K page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWC_2M_HITS",
         "PerPkg": "1",
@@ -1327,6 +1448,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 1G page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWC_512G_HITS",
         "PerPkg": "1",
@@ -1336,6 +1458,7 @@
     },
     {
         "BriefDescription": ": PageWalk cache fill",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWC_CACHE_FILLS",
         "PerPkg": "1",
@@ -1345,6 +1468,7 @@
     },
     {
         "BriefDescription": ": PageWalk cache lookup",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.PWT_CACHE_LOOKUPS",
         "PerPkg": "1",
@@ -1354,6 +1478,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 2M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_1G_HITS",
         "PerPkg": "1",
@@ -1363,6 +1488,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 2M page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_256T_HITS",
         "PerPkg": "1",
@@ -1372,6 +1498,7 @@
     },
     {
         "BriefDescription": ": PWC Hit to a 1G page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_512G_HITS",
         "PerPkg": "1",
@@ -1381,6 +1508,7 @@
     },
     {
         "BriefDescription": ": Global IOTLB invalidation cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_IIO_IOMMU3.PWT_OCCUPANCY_MSB",
         "PerPkg": "1",
@@ -1391,6 +1519,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0",
         "PerPkg": "1",
@@ -1401,6 +1530,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus a=
nd PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_BUS1",
         "PerPkg": "1",
@@ -1411,6 +1541,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus a=
nd !(PCIE bus)",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_NOT_BUS1",
         "PerPkg": "1",
@@ -1421,6 +1552,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.BUS1",
         "PerPkg": "1",
@@ -1431,6 +1563,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : !(Non-PCIE bus=
) and PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_BUS1",
         "PerPkg": "1",
@@ -1441,6 +1574,7 @@
     },
     {
         "BriefDescription": "AND Mask/match for debug bus : !(Non-PCIE bus=
) and !(PCIE bus)",
+        "Counter": "0,1",
         "EventCode": "0x02",
         "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_NOT_BUS1",
         "PerPkg": "1",
@@ -1451,6 +1585,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0",
         "PerPkg": "1",
@@ -1461,6 +1596,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus an=
d PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_BUS1",
         "PerPkg": "1",
@@ -1471,6 +1607,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus an=
d !(PCIE bus)",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_NOT_BUS1",
         "PerPkg": "1",
@@ -1481,6 +1618,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.BUS1",
         "PerPkg": "1",
@@ -1491,6 +1629,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : !(Non-PCIE bus)=
 and PCIE bus",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_BUS1",
         "PerPkg": "1",
@@ -1501,6 +1640,7 @@
     },
     {
         "BriefDescription": "OR Mask/match for debug bus : !(Non-PCIE bus)=
 and !(PCIE bus)",
+        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_NOT_BUS1",
         "PerPkg": "1",
@@ -1511,6 +1651,7 @@
     },
     {
         "BriefDescription": "Number requests PCIe makes of the main die : =
All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU.COMMIT.ALL",
         "FCMask": "0x07",
@@ -1522,6 +1663,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Abort=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
         "FCMask": "0x07",
@@ -1532,6 +1674,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Confi=
ned P2P",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
         "FCMask": "0x07",
@@ -1542,6 +1685,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Local=
 P2P",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
         "FCMask": "0x07",
@@ -1552,6 +1696,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Multi=
-cast",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
         "FCMask": "0x07",
@@ -1562,6 +1707,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Memor=
y",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
         "FCMask": "0x07",
@@ -1572,6 +1718,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : MsgB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
         "FCMask": "0x07",
@@ -1582,6 +1729,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Remot=
e P2P",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
         "FCMask": "0x07",
@@ -1592,6 +1740,7 @@
     },
     {
         "BriefDescription": "Num requests sent by PCIe - by target : Ubox",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
         "FCMask": "0x07",
@@ -1602,6 +1751,7 @@
     },
     {
         "BriefDescription": "ITC address map 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8f",
         "EventName": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
         "PerPkg": "1",
@@ -1611,6 +1761,7 @@
     },
     {
         "BriefDescription": "Outbound cacheline requests issued : 64B requ=
ests issued to device",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd0",
         "EventName": "UNC_IIO_OUTBOUND_CL_REQS_ISSUED.TO_IO",
         "FCMask": "0x07",
@@ -1622,6 +1773,7 @@
     },
     {
         "BriefDescription": "Outbound TLP (transaction layer packet) reque=
sts issued : To device",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd1",
         "EventName": "UNC_IIO_OUTBOUND_TLP_REQS_ISSUED.TO_IO",
         "FCMask": "0x07",
@@ -1633,6 +1785,7 @@
     },
     {
         "BriefDescription": "PWT occupancy.  Does not include 9th bit of o=
ccupancy (will undercount if PWT is greater than 255 per cycle).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_IIO_PWT_OCCUPANCY",
         "PerPkg": "1",
@@ -1643,6 +1796,7 @@
     },
     {
         "BriefDescription": "Request Ownership : PCIe Request complete",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.DATA",
         "FCMask": "0x07",
@@ -1654,6 +1808,7 @@
     },
     {
         "BriefDescription": "Request Ownership : Writing line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.FINAL_RD_WR",
         "FCMask": "0x07",
@@ -1665,6 +1820,7 @@
     },
     {
         "BriefDescription": "Request Ownership : Issuing final read or wri=
te of line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.REQ_OWN",
         "FCMask": "0x07",
@@ -1676,6 +1832,7 @@
     },
     {
         "BriefDescription": "Request Ownership : Passing data to be writte=
n",
+        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.WR",
         "FCMask": "0x07",
@@ -1687,6 +1844,7 @@
     },
     {
         "BriefDescription": "Processing response from IOMMU : Passing data=
 to be written",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.FINAL_RD_WR",
         "FCMask": "0x07",
@@ -1698,6 +1856,7 @@
     },
     {
         "BriefDescription": "Processing response from IOMMU : Issuing fina=
l read or write of line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.IOMMU_HIT",
         "FCMask": "0x07",
@@ -1708,6 +1867,7 @@
     },
     {
         "BriefDescription": "Processing response from IOMMU : Request Owne=
rship",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.IOMMU_REQ",
         "FCMask": "0x07",
@@ -1719,6 +1879,7 @@
     },
     {
         "BriefDescription": "Processing response from IOMMU : Writing line=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.REQ_OWN",
         "FCMask": "0x07",
@@ -1730,6 +1891,7 @@
     },
     {
         "BriefDescription": "PCIe Request - pass complete : Passing data t=
o be written",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.DATA",
         "FCMask": "0x07",
@@ -1741,6 +1903,7 @@
     },
     {
         "BriefDescription": "PCIe Request - pass complete : Issuing final =
read or write of line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.FINAL_RD_WR",
         "FCMask": "0x07",
@@ -1752,6 +1915,7 @@
     },
     {
         "BriefDescription": "PCIe Request - pass complete : Request Owners=
hip",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.REQ_OWN",
         "FCMask": "0x07",
@@ -1763,6 +1927,7 @@
     },
     {
         "BriefDescription": "PCIe Request - pass complete : Writing line",
+        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.WR",
         "FCMask": "0x07",
@@ -1774,6 +1939,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -1785,6 +1951,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part1",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -1796,6 +1963,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part2",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -1807,6 +1975,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part3",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -1818,6 +1987,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -1829,6 +1999,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -1840,6 +2011,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -1851,6 +2023,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -1862,6 +2035,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part0 by the CPU",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -1873,6 +2047,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part1 by the CPU",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -1884,6 +2059,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part2 by the CPU",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -1895,6 +2071,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part3 by the CPU",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -1906,6 +2083,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -1917,6 +2095,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -1928,6 +2107,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -1939,6 +2119,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -1950,6 +2131,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
@@ -1961,6 +2143,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
@@ -1972,6 +2155,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
@@ -1983,6 +2167,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
@@ -1994,6 +2179,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART4",
         "FCMask": "0x07",
@@ -2005,6 +2191,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART5",
         "FCMask": "0x07",
@@ -2016,6 +2203,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART6",
         "FCMask": "0x07",
@@ -2027,6 +2215,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART7",
         "FCMask": "0x07",
@@ -2038,6 +2227,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART0",
         "FCMask": "0x07",
@@ -2049,6 +2239,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART1",
         "FCMask": "0x07",
@@ -2060,6 +2251,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART2",
         "FCMask": "0x07",
@@ -2071,6 +2263,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART3",
         "FCMask": "0x07",
@@ -2082,6 +2275,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART4",
         "FCMask": "0x07",
@@ -2093,6 +2287,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART5",
         "FCMask": "0x07",
@@ -2104,6 +2299,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART6",
         "FCMask": "0x07",
@@ -2115,6 +2311,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART7",
         "FCMask": "0x07",
@@ -2126,6 +2323,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -2137,6 +2335,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is  made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -2148,6 +2347,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -2159,6 +2359,7 @@
     },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -2170,6 +2371,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -2181,6 +2383,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -2192,6 +2395,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -2203,6 +2407,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -2214,6 +2419,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -2225,6 +2431,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -2236,6 +2443,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -2247,6 +2455,7 @@
     },
     {
         "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -2258,6 +2467,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -2269,6 +2479,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -2280,6 +2491,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -2291,6 +2503,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -2302,6 +2515,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
@@ -2313,6 +2527,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
@@ -2324,6 +2539,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
@@ -2335,6 +2551,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
@@ -2346,6 +2563,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
         "FCMask": "0x07",
@@ -2357,6 +2575,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
         "FCMask": "0x07",
@@ -2368,6 +2587,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
         "FCMask": "0x07",
@@ -2379,6 +2599,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
         "FCMask": "0x07",
@@ -2390,6 +2611,7 @@
     },
     {
         "BriefDescription": "M2P Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M2P_CLOCKTICKS",
         "PerPkg": "1",
@@ -2398,6 +2620,7 @@
     },
     {
         "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M2P_CMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -2405,6 +2628,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2P_EGRESS_ORDERING.IV_SNOOPGO_DN",
         "PerPkg": "1",
@@ -2414,6 +2638,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2P_EGRESS_ORDERING.IV_SNOOPGO_UP",
         "PerPkg": "1",
@@ -2423,6 +2648,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.DRS_0",
         "PerPkg": "1",
@@ -2432,6 +2658,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.DRS_1",
         "PerPkg": "1",
@@ -2441,6 +2668,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCB_0",
         "PerPkg": "1",
@@ -2450,6 +2678,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCB_1",
         "PerPkg": "1",
@@ -2459,6 +2688,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCS_0",
         "PerPkg": "1",
@@ -2468,6 +2698,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credit Acquired : NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCS_1",
         "PerPkg": "1",
@@ -2477,6 +2708,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_M2P_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -2486,6 +2718,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_M2P_IIO_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -2495,6 +2728,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_M2P_IIO_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -2504,6 +2738,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : DRS to CMS Port 0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.DRS_0",
         "PerPkg": "1",
@@ -2513,6 +2748,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : DRS to CMS Port 1=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.DRS_1",
         "PerPkg": "1",
@@ -2522,6 +2758,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : NCB to CMS Port 0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.NCB_0",
         "PerPkg": "1",
@@ -2531,6 +2768,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : NCB to CMS Port 1=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.NCB_1",
         "PerPkg": "1",
@@ -2540,6 +2778,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : NCS to CMS Port 0=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.NCS_0",
         "PerPkg": "1",
@@ -2549,6 +2788,7 @@
     },
     {
         "BriefDescription": "M2PCIe IIO Credits in Use : NCS to CMS Port 1=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2P_IIO_CREDITS_USED.NCS_1",
         "PerPkg": "1",
@@ -2558,6 +2798,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
0 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF0_NCB",
         "PerPkg": "1",
@@ -2566,6 +2807,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
0 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF0_NCS",
         "PerPkg": "1",
@@ -2574,6 +2816,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
1 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF1_NCB",
         "PerPkg": "1",
@@ -2582,6 +2825,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
1 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF1_NCS",
         "PerPkg": "1",
@@ -2590,6 +2834,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
2 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF2_NCB",
         "PerPkg": "1",
@@ -2598,6 +2843,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
2 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF2_NCS",
         "PerPkg": "1",
@@ -2606,6 +2852,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
3 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF3_NCB",
         "PerPkg": "1",
@@ -2614,6 +2861,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
3 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF3_NCS",
         "PerPkg": "1",
@@ -2622,6 +2870,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
4 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF4_NCB",
         "PerPkg": "1",
@@ -2630,6 +2879,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
4 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF4_NCS",
         "PerPkg": "1",
@@ -2638,6 +2888,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
5 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF5_NCB",
         "PerPkg": "1",
@@ -2646,6 +2897,7 @@
     },
     {
         "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
5 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF5_NCS",
         "PerPkg": "1",
@@ -2654,6 +2906,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF0 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF0_NCB",
         "PerPkg": "1",
@@ -2662,6 +2915,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF0 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF0_NCS",
         "PerPkg": "1",
@@ -2670,6 +2924,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF1 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF1_NCB",
         "PerPkg": "1",
@@ -2678,6 +2933,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF1 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF1_NCS",
         "PerPkg": "1",
@@ -2686,6 +2942,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF2 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF2_NCB",
         "PerPkg": "1",
@@ -2694,6 +2951,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF2 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF2_NCS",
         "PerPkg": "1",
@@ -2702,6 +2960,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF3 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF3_NCB",
         "PerPkg": "1",
@@ -2710,6 +2969,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF3 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF3_NCS",
         "PerPkg": "1",
@@ -2718,6 +2978,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF4 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF4_NCB",
         "PerPkg": "1",
@@ -2726,6 +2987,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF4 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF4_NCS",
         "PerPkg": "1",
@@ -2734,6 +2996,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF5 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF5_NCB",
         "PerPkg": "1",
@@ -2742,6 +3005,7 @@
     },
     {
         "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF5 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF5_NCS",
         "PerPkg": "1",
@@ -2750,6 +3014,7 @@
     },
     {
         "BriefDescription": "Local P2P Shared Credits Returned : Agent0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_0",
         "PerPkg": "1",
@@ -2758,6 +3023,7 @@
     },
     {
         "BriefDescription": "Local P2P Shared Credits Returned : Agent1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_1",
         "PerPkg": "1",
@@ -2766,6 +3032,7 @@
     },
     {
         "BriefDescription": "Local P2P Shared Credits Returned : Agent2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_2",
         "PerPkg": "1",
@@ -2774,6 +3041,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_0",
         "PerPkg": "1",
@@ -2782,6 +3050,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_1",
         "PerPkg": "1",
@@ -2790,6 +3059,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_2",
         "PerPkg": "1",
@@ -2798,6 +3068,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_3",
         "PerPkg": "1",
@@ -2806,6 +3077,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent4",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_4",
         "PerPkg": "1",
@@ -2814,6 +3086,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent5",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_5",
         "PerPkg": "1",
@@ -2822,6 +3095,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF0 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF0_NCB",
         "PerPkg": "1",
@@ -2830,6 +3104,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF0 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF0_NCS",
         "PerPkg": "1",
@@ -2838,6 +3113,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF1 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF1_NCB",
         "PerPkg": "1",
@@ -2846,6 +3122,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF1 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF1_NCS",
         "PerPkg": "1",
@@ -2854,6 +3131,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF2 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF2_NCB",
         "PerPkg": "1",
@@ -2862,6 +3140,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF2 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF2_NCS",
         "PerPkg": "1",
@@ -2870,6 +3149,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF3 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF3_NCB",
         "PerPkg": "1",
@@ -2878,6 +3158,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF3 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF3_NCS",
         "PerPkg": "1",
@@ -2886,6 +3167,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF4 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF4_NCB",
         "PerPkg": "1",
@@ -2894,6 +3176,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF4 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF4_NCS",
         "PerPkg": "1",
@@ -2902,6 +3185,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF5 -=
 NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF5_NCB",
         "PerPkg": "1",
@@ -2910,6 +3194,7 @@
     },
     {
         "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF5 -=
 NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF5_NCS",
         "PerPkg": "1",
@@ -2918,6 +3203,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF0 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF0_NCB",
         "PerPkg": "1",
@@ -2926,6 +3212,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF0 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF0_NCS",
         "PerPkg": "1",
@@ -2934,6 +3221,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF1 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF1_NCB",
         "PerPkg": "1",
@@ -2942,6 +3230,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF1 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF1_NCS",
         "PerPkg": "1",
@@ -2950,6 +3239,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF2 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF2_NCB",
         "PerPkg": "1",
@@ -2958,6 +3248,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF2 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF2_NCS",
         "PerPkg": "1",
@@ -2966,6 +3257,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF3 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF3_NCB",
         "PerPkg": "1",
@@ -2974,6 +3266,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF3 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF3_NCS",
         "PerPkg": "1",
@@ -2982,6 +3275,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF4 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4b",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF4_NCB",
         "PerPkg": "1",
@@ -2990,6 +3284,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF4 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4b",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF4_NCS",
         "PerPkg": "1",
@@ -2998,6 +3293,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF5 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4b",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF5_NCB",
         "PerPkg": "1",
@@ -3006,6 +3302,7 @@
     },
     {
         "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF5 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4b",
         "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF5_NCS",
         "PerPkg": "1",
@@ -3014,6 +3311,7 @@
     },
     {
         "BriefDescription": "P2P Credit Occupancy : All",
+        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -3022,6 +3320,7 @@
     },
     {
         "BriefDescription": "P2P Credit Occupancy : Local NCB",
+        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.LOCAL_NCB",
         "PerPkg": "1",
@@ -3030,6 +3329,7 @@
     },
     {
         "BriefDescription": "P2P Credit Occupancy : Local NCS",
+        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.LOCAL_NCS",
         "PerPkg": "1",
@@ -3038,6 +3338,7 @@
     },
     {
         "BriefDescription": "P2P Credit Occupancy : Remote NCB",
+        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.REMOTE_NCB",
         "PerPkg": "1",
@@ -3046,6 +3347,7 @@
     },
     {
         "BriefDescription": "P2P Credit Occupancy : Remote NCS",
+        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.REMOTE_NCS",
         "PerPkg": "1",
@@ -3054,6 +3356,7 @@
     },
     {
         "BriefDescription": "Dedicated Credits Received : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2P_P2P_DED_RECEIVED.ALL",
         "PerPkg": "1",
@@ -3062,6 +3365,7 @@
     },
     {
         "BriefDescription": "Dedicated Credits Received : Local NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2P_P2P_DED_RECEIVED.LOCAL_NCB",
         "PerPkg": "1",
@@ -3070,6 +3374,7 @@
     },
     {
         "BriefDescription": "Dedicated Credits Received : Local NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2P_P2P_DED_RECEIVED.LOCAL_NCS",
         "PerPkg": "1",
@@ -3078,6 +3383,7 @@
     },
     {
         "BriefDescription": "Dedicated Credits Received : Remote NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2P_P2P_DED_RECEIVED.REMOTE_NCB",
         "PerPkg": "1",
@@ -3086,6 +3392,7 @@
     },
     {
         "BriefDescription": "Dedicated Credits Received : Remote NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2P_P2P_DED_RECEIVED.REMOTE_NCS",
         "PerPkg": "1",
@@ -3094,6 +3401,7 @@
     },
     {
         "BriefDescription": "Shared Credits  Received : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.ALL",
         "PerPkg": "1",
@@ -3102,6 +3410,7 @@
     },
     {
         "BriefDescription": "Shared Credits  Received : Local NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.LOCAL_NCB",
         "PerPkg": "1",
@@ -3110,6 +3419,7 @@
     },
     {
         "BriefDescription": "Shared Credits  Received : Local NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.LOCAL_NCS",
         "PerPkg": "1",
@@ -3118,6 +3428,7 @@
     },
     {
         "BriefDescription": "Shared Credits  Received : Remote NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.REMOTE_NCB",
         "PerPkg": "1",
@@ -3126,6 +3437,7 @@
     },
     {
         "BriefDescription": "Shared Credits  Received : Remote NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.REMOTE_NCS",
         "PerPkg": "1",
@@ -3134,6 +3446,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI0 =
- DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI0_DRS",
         "PerPkg": "1",
@@ -3142,6 +3455,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI0 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI0_NCB",
         "PerPkg": "1",
@@ -3150,6 +3464,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI0 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI0_NCS",
         "PerPkg": "1",
@@ -3158,6 +3473,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI1 =
- DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI1_DRS",
         "PerPkg": "1",
@@ -3166,6 +3482,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI1 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI1_NCB",
         "PerPkg": "1",
@@ -3174,6 +3491,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 0 : UPI1 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_0.UPI1_NCS",
         "PerPkg": "1",
@@ -3182,6 +3500,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 1 : UPI2 =
- DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_1.UPI2_DRS",
         "PerPkg": "1",
@@ -3190,6 +3509,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 1 : UPI2 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_1.UPI2_NCB",
         "PerPkg": "1",
@@ -3198,6 +3518,7 @@
     },
     {
         "BriefDescription": "Remote Dedicated P2P Credit Taken - 1 : UPI2 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "UNC_M2P_REMOTE_DED_P2P_CRD_TAKEN_1.UPI2_NCS",
         "PerPkg": "1",
@@ -3206,6 +3527,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI0 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI0_NCB",
         "PerPkg": "1",
@@ -3214,6 +3536,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI0 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI0_NCS",
         "PerPkg": "1",
@@ -3222,6 +3545,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI1 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI1_NCB",
         "PerPkg": "1",
@@ -3230,6 +3554,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI1 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI1_NCS",
         "PerPkg": "1",
@@ -3238,6 +3563,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI2 =
- NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI2_NCB",
         "PerPkg": "1",
@@ -3246,6 +3572,7 @@
     },
     {
         "BriefDescription": "Remote P2P Dedicated Credits Returned : UPI2 =
- NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2P_REMOTE_P2P_DED_RETURNED.UPI2_NCS",
         "PerPkg": "1",
@@ -3254,6 +3581,7 @@
     },
     {
         "BriefDescription": "Remote P2P Shared Credits Returned : Agent0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_0",
         "PerPkg": "1",
@@ -3262,6 +3590,7 @@
     },
     {
         "BriefDescription": "Remote P2P Shared Credits Returned : Agent1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_1",
         "PerPkg": "1",
@@ -3270,6 +3599,7 @@
     },
     {
         "BriefDescription": "Remote P2P Shared Credits Returned : Agent2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_2",
         "PerPkg": "1",
@@ -3278,6 +3608,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_0",
         "PerPkg": "1",
@@ -3286,6 +3617,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_1",
         "PerPkg": "1",
@@ -3294,6 +3626,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_2",
         "PerPkg": "1",
@@ -3302,6 +3635,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI0 - D=
RS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI0_DRS",
         "PerPkg": "1",
@@ -3310,6 +3644,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI0 - N=
CB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI0_NCB",
         "PerPkg": "1",
@@ -3318,6 +3653,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI0 - N=
CS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI0_NCS",
         "PerPkg": "1",
@@ -3326,6 +3662,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI1 - D=
RS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI1_DRS",
         "PerPkg": "1",
@@ -3334,6 +3671,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI1 - N=
CB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI1_NCB",
         "PerPkg": "1",
@@ -3342,6 +3680,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 0 : UPI1 - N=
CS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_0.UPI1_NCS",
         "PerPkg": "1",
@@ -3350,6 +3689,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 1 : UPI2 - D=
RS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_1.UPI2_DRS",
         "PerPkg": "1",
@@ -3358,6 +3698,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 1 : UPI2 - N=
CB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_1.UPI2_NCB",
         "PerPkg": "1",
@@ -3366,6 +3707,7 @@
     },
     {
         "BriefDescription": "Remote Shared P2P Credit Taken - 1 : UPI2 - N=
CS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_TAKEN_1.UPI2_NCS",
         "PerPkg": "1",
@@ -3374,6 +3716,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
0 - DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI0_DRS",
         "PerPkg": "1",
@@ -3382,6 +3725,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
0 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI0_NCB",
         "PerPkg": "1",
@@ -3390,6 +3734,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
0 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI0_NCS",
         "PerPkg": "1",
@@ -3398,6 +3743,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
1 - DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI1_DRS",
         "PerPkg": "1",
@@ -3406,6 +3752,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
1 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI1_NCB",
         "PerPkg": "1",
@@ -3414,6 +3761,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 0 : UPI=
1 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_0.UPI1_NCS",
         "PerPkg": "1",
@@ -3422,6 +3770,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 1 : UPI=
2 - DRS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_1.UPI2_DRS",
         "PerPkg": "1",
@@ -3430,6 +3779,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 1 : UPI=
2 - NCB",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_1.UPI2_NCB",
         "PerPkg": "1",
@@ -3438,6 +3788,7 @@
     },
     {
         "BriefDescription": "Waiting on Remote Shared P2P Credit - 1 : UPI=
2 - NCS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_WAIT_1.UPI2_NCS",
         "PerPkg": "1",
@@ -3446,6 +3797,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3455,6 +3807,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_IDI",
         "PerPkg": "1",
@@ -3464,6 +3817,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_NCB",
         "PerPkg": "1",
@@ -3473,6 +3827,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_NCS",
         "PerPkg": "1",
@@ -3482,6 +3837,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.IIO_NCB",
         "PerPkg": "1",
@@ -3491,6 +3847,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.IIO_NCS",
         "PerPkg": "1",
@@ -3500,6 +3857,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.UPI_NCB",
         "PerPkg": "1",
@@ -3509,6 +3867,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_RxC_CYCLES_NE.UPI_NCS",
         "PerPkg": "1",
@@ -3518,6 +3877,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.ALL",
         "PerPkg": "1",
@@ -3527,6 +3887,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.CHA_IDI",
         "PerPkg": "1",
@@ -3536,6 +3897,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.CHA_NCB",
         "PerPkg": "1",
@@ -3545,6 +3907,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.CHA_NCS",
         "PerPkg": "1",
@@ -3554,6 +3917,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.IIO_NCB",
         "PerPkg": "1",
@@ -3563,6 +3927,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.IIO_NCS",
         "PerPkg": "1",
@@ -3572,6 +3937,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.UPI_NCB",
         "PerPkg": "1",
@@ -3581,6 +3947,7 @@
     },
     {
         "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M2P_RxC_INSERTS.UPI_NCS",
         "PerPkg": "1",
@@ -3590,6 +3957,7 @@
     },
     {
         "BriefDescription": "UNC_M2P_TxC_CREDITS.PMM",
+        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_M2P_TxC_CREDITS.PMM",
         "PerPkg": "1",
@@ -3598,6 +3966,7 @@
     },
     {
         "BriefDescription": "UNC_M2P_TxC_CREDITS.PRQ",
+        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_M2P_TxC_CREDITS.PRQ",
         "PerPkg": "1",
@@ -3606,6 +3975,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_TxC_CYCLES_FULL.PMM_BLOCK_0",
         "FCMask": "0x00000000",
@@ -3617,6 +3987,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_TxC_CYCLES_FULL.PMM_BLOCK_1",
         "FCMask": "0x00000000",
@@ -3628,6 +3999,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_TxC_CYCLES_NE.PMM_DISTRESS_0",
         "FCMask": "0x00000000",
@@ -3639,6 +4011,7 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_TxC_CYCLES_NE.PMM_DISTRESS_1",
         "FCMask": "0x00000000",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
index 3ff9e9b72..20c064e81 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Cycles - at UCLK",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M2HBM_CLOCKTICKS",
         "PerPkg": "1",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M2HBM_CMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2HBM_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to core mode, which bypass=
es the CHA, was disabled : Non Cisgress",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M2HBM_DIRECT2CORE_NOT_TAKEN_DIRSTATE.NON_CISGRES=
S",
         "PerPkg": "1",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Counts the time when FM didn't do d2c for fil=
l reads (cross tile case)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_M2HBM_DIRECT2CORE_NOT_TAKEN_NOTFORKED",
         "PerPkg": "1",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2HBM_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -47,6 +53,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to core trans=
action was overridden : Cisgress",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M2HBM_DIRECT2CORE_TXN_OVERRIDE.CISGRESS",
         "PerPkg": "1",
@@ -55,6 +62,7 @@
     },
     {
         "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M2HBM_DIRECT2UPI_NOT_TAKEN_CREDITS",
         "PerPkg": "1",
@@ -63,6 +71,7 @@
     },
     {
         "BriefDescription": "Cycles when direct to Intel UPI was disabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M2HBM_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
@@ -71,6 +80,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Cisgres=
s D2U Ignored",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2HBM_DIRECT2UPI_NOT_TAKEN_DIRSTATE.CISGRESS",
         "FCMask": "0x00000000",
@@ -82,6 +92,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Egress =
Ignored D2U",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2HBM_DIRECT2UPI_NOT_TAKEN_DIRSTATE.EGRESS",
         "FCMask": "0x00000000",
@@ -93,6 +104,7 @@
     },
     {
         "BriefDescription": "Cycles when Direct2UPI was Disabled : Non Cis=
gress D2U Ignored",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_M2HBM_DIRECT2UPI_NOT_TAKEN_DIRSTATE.NON_CISGRESS=
",
         "FCMask": "0x00000000",
@@ -104,6 +116,7 @@
     },
     {
         "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_M2HBM_DIRECT2UPI_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -112,6 +125,7 @@
     },
     {
         "BriefDescription": "Number of times a direct to UPI transaction w=
as overridden.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_M2HBM_DIRECT2UPI_TXN_OVERRIDE.CISGRESS",
         "PerPkg": "1",
@@ -120,6 +134,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.CLEAN_A",
         "PerPkg": "1",
@@ -128,6 +143,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.CLEAN_I",
         "PerPkg": "1",
@@ -136,6 +152,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.CLEAN_P",
         "PerPkg": "1",
@@ -144,6 +161,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.CLEAN_S",
         "PerPkg": "1",
@@ -152,6 +170,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.DIRTY_A",
         "PerPkg": "1",
@@ -160,6 +179,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.DIRTY_I",
         "PerPkg": "1",
@@ -168,6 +188,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.DIRTY_P",
         "PerPkg": "1",
@@ -176,6 +197,7 @@
     },
     {
         "BriefDescription": "Directory Hit : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_M2HBM_DIRECTORY_HIT.DIRTY_S",
         "PerPkg": "1",
@@ -184,6 +206,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2HBM_DIRECTORY_LOOKUP.ANY",
         "PerPkg": "1",
@@ -193,6 +216,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2HBM_DIRECTORY_LOOKUP.STATE_A",
         "PerPkg": "1",
@@ -202,6 +226,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2HBM_DIRECTORY_LOOKUP.STATE_I",
         "PerPkg": "1",
@@ -211,6 +236,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M2HBM_DIRECTORY_LOOKUP.STATE_S",
         "PerPkg": "1",
@@ -220,6 +246,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.CLEAN_A",
         "PerPkg": "1",
@@ -228,6 +255,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.CLEAN_I",
         "PerPkg": "1",
@@ -236,6 +264,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.CLEAN_P",
         "PerPkg": "1",
@@ -244,6 +273,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.CLEAN_S",
         "PerPkg": "1",
@@ -252,6 +282,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.DIRTY_A",
         "PerPkg": "1",
@@ -260,6 +291,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.DIRTY_I",
         "PerPkg": "1",
@@ -268,6 +300,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in L State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.DIRTY_P",
         "PerPkg": "1",
@@ -276,6 +309,7 @@
     },
     {
         "BriefDescription": "Directory Miss : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_M2HBM_DIRECTORY_MISS.DIRTY_S",
         "PerPkg": "1",
@@ -284,6 +318,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A2I",
         "PerPkg": "1",
@@ -292,6 +327,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A2S",
         "PerPkg": "1",
@@ -300,6 +336,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
@@ -308,6 +345,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A_TO_I_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -319,6 +357,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A_TO_I_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -330,6 +369,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A_TO_S_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -341,6 +381,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.A_TO_S_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -352,6 +393,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -363,6 +405,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I2A",
         "PerPkg": "1",
@@ -371,6 +414,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I2S",
         "PerPkg": "1",
@@ -379,6 +423,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I_TO_A_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -390,6 +435,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I_TO_A_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -401,6 +447,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I_TO_S_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -412,6 +459,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.I_TO_S_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -423,6 +471,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -434,6 +483,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S2A",
         "PerPkg": "1",
@@ -442,6 +492,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S2I",
         "PerPkg": "1",
@@ -450,6 +501,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S_TO_A_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -461,6 +513,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S_TO_A_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -472,6 +525,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S_TO_I_HIT_NON_PMM",
         "FCMask": "0x00000000",
@@ -483,6 +537,7 @@
     },
     {
         "BriefDescription": "Multi-socket cacheline Directory Updates",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M2HBM_DIRECTORY_UPDATE.S_TO_I_MISS_NON_PMM",
         "FCMask": "0x00000000",
@@ -494,6 +549,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on AkAd cmp message",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.AD",
         "PerPkg": "1",
@@ -502,6 +558,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on any packet type",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.ALL",
         "PerPkg": "1",
@@ -510,6 +567,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on Bl Cmp message",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.BL_CMP",
         "PerPkg": "1",
@@ -518,6 +576,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on NM fill write mes=
sage",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.CROSSTILE_NMWR",
         "PerPkg": "1",
@@ -526,6 +585,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on D2Cha message",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.D2CHA",
         "PerPkg": "1",
@@ -534,6 +594,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on D2c message",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.D2CORE",
         "PerPkg": "1",
@@ -542,6 +603,7 @@
     },
     {
         "BriefDescription": "Count distress signalled on D2k message",
+        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_M2HBM_DISTRESS.D2UPI",
         "PerPkg": "1",
@@ -550,6 +612,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2HBM_EGRESS_ORDERING.IV_SNOOPGO_DN",
         "PerPkg": "1",
@@ -559,6 +622,7 @@
     },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
         "EventCode": "0xba",
         "EventName": "UNC_M2HBM_EGRESS_ORDERING.IV_SNOOPGO_UP",
         "PerPkg": "1",
@@ -568,6 +632,7 @@
     },
     {
         "BriefDescription": "Count when Starve Glocab counter is at 7",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M2HBM_IGR_STARVE_WINNER.MASK7",
         "FCMask": "0x00000000",
@@ -578,6 +643,7 @@
     },
     {
         "BriefDescription": "Reads to iMC issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.ALL",
         "PerPkg": "1",
@@ -586,6 +652,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH0.ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0.ALL",
         "PerPkg": "1",
@@ -594,6 +661,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH0.NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0.NORMAL",
         "PerPkg": "1",
@@ -602,6 +670,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH0_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0_ALL",
         "FCMask": "0x00000000",
@@ -612,6 +681,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH0_FROM_TGR",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0_FROM_TGR",
         "PerPkg": "1",
@@ -620,6 +690,7 @@
     },
     {
         "BriefDescription": "Critical Priority - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0_ISOCH",
         "PerPkg": "1",
@@ -628,6 +699,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH0_NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH0_NORMAL",
         "FCMask": "0x00000000",
@@ -638,6 +710,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH1.ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1.ALL",
         "PerPkg": "1",
@@ -646,6 +719,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH1.NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1.NORMAL",
         "PerPkg": "1",
@@ -654,6 +728,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH1_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1_ALL",
         "FCMask": "0x00000000",
@@ -664,6 +739,7 @@
     },
     {
         "BriefDescription": "From TGR - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1_FROM_TGR",
         "PerPkg": "1",
@@ -672,6 +748,7 @@
     },
     {
         "BriefDescription": "Critical Priority - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1_ISOCH",
         "PerPkg": "1",
@@ -680,6 +757,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.CH1_NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.CH1_NORMAL",
         "FCMask": "0x00000000",
@@ -690,6 +768,7 @@
     },
     {
         "BriefDescription": "From TGR - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.FROM_TGR",
         "PerPkg": "1",
@@ -698,6 +777,7 @@
     },
     {
         "BriefDescription": "Critical Priority - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.ISOCH",
         "PerPkg": "1",
@@ -706,6 +786,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_READS.NORMAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2HBM_IMC_READS.NORMAL",
         "PerPkg": "1",
@@ -714,6 +795,7 @@
     },
     {
         "BriefDescription": "All Writes - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.ALL",
         "PerPkg": "1",
@@ -722,6 +804,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0.ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0.ALL",
         "PerPkg": "1",
@@ -730,6 +813,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0.FULL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0.FULL",
         "PerPkg": "1",
@@ -738,6 +822,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0.PARTIAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0.PARTIAL",
         "PerPkg": "1",
@@ -746,6 +831,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0_ALL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_ALL",
         "FCMask": "0x00000000",
@@ -756,6 +842,7 @@
     },
     {
         "BriefDescription": "From TGR - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_FROM_TGR",
         "PerPkg": "1",
@@ -763,6 +850,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0_FULL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_FULL",
         "FCMask": "0x00000000",
@@ -773,6 +861,7 @@
     },
     {
         "BriefDescription": "ISOCH Full Line - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_FULL_ISOCH",
         "PerPkg": "1",
@@ -781,6 +870,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_NI",
         "FCMask": "0x00000000",
@@ -790,6 +880,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_NI_MISS",
         "FCMask": "0x00000000",
@@ -799,6 +890,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_IMC_WRITES.CH0_PARTIAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_PARTIAL",
         "FCMask": "0x00000000",
@@ -809,6 +901,7 @@
     },
     {
         "BriefDescription": "ISOCH Partial - Ch0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -817,6 +910,7 @@
     },
     {
         "BriefDescription": "All Writes - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1.ALL",
         "PerPkg": "1",
@@ -825,6 +919,7 @@
     },
     {
         "BriefDescription": "Full Line Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1.FULL",
         "PerPkg": "1",
@@ -833,6 +928,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1.PARTIAL",
         "PerPkg": "1",
@@ -841,6 +937,7 @@
     },
     {
         "BriefDescription": "All Writes - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_ALL",
         "FCMask": "0x00000000",
@@ -851,6 +948,7 @@
     },
     {
         "BriefDescription": "From TGR - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_FROM_TGR",
         "PerPkg": "1",
@@ -858,6 +956,7 @@
     },
     {
         "BriefDescription": "Full Line Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_FULL",
         "FCMask": "0x00000000",
@@ -868,6 +967,7 @@
     },
     {
         "BriefDescription": "ISOCH Full Line - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_FULL_ISOCH",
         "PerPkg": "1",
@@ -876,6 +976,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_NI",
         "FCMask": "0x00000000",
@@ -885,6 +986,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_NI_MISS",
         "FCMask": "0x00000000",
@@ -894,6 +996,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_PARTIAL",
         "FCMask": "0x00000000",
@@ -904,6 +1007,7 @@
     },
     {
         "BriefDescription": "ISOCH Partial - Ch1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -912,6 +1016,7 @@
     },
     {
         "BriefDescription": "From TGR - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.FROM_TGR",
         "PerPkg": "1",
@@ -919,6 +1024,7 @@
     },
     {
         "BriefDescription": "Full Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -927,6 +1033,7 @@
     },
     {
         "BriefDescription": "ISOCH Full Line - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.FULL_ISOCH",
         "PerPkg": "1",
@@ -935,6 +1042,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.NI",
         "FCMask": "0x00000000",
@@ -944,6 +1052,7 @@
     },
     {
         "BriefDescription": "Non-Inclusive Miss - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.NI_MISS",
         "FCMask": "0x00000000",
@@ -953,6 +1062,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -961,6 +1071,7 @@
     },
     {
         "BriefDescription": "ISOCH Partial - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2HBM_IMC_WRITES.PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -969,6 +1080,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_PREFCAM_CIS_DROPS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5c",
         "EventName": "UNC_M2HBM_PREFCAM_CIS_DROPS",
         "PerPkg": "1",
@@ -976,6 +1088,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.CH0_UPI",
         "PerPkg": "1",
@@ -984,6 +1097,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.CH0_XPT",
         "PerPkg": "1",
@@ -992,6 +1106,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.CH1_UPI",
         "PerPkg": "1",
@@ -1000,6 +1115,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.CH1_XPT",
         "PerPkg": "1",
@@ -1008,6 +1124,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped : UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.UPI_ALLCH",
         "PerPkg": "1",
@@ -1016,6 +1133,7 @@
     },
     {
         "BriefDescription": "Data Prefetches Dropped",
+        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_DROPS.XPT_ALLCH",
         "PerPkg": "1",
@@ -1024,6 +1142,7 @@
     },
     {
         "BriefDescription": ": UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_MERGE.UPI_ALLCH",
         "PerPkg": "1",
@@ -1032,6 +1151,7 @@
     },
     {
         "BriefDescription": ": XPT - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5d",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_MERGE.XPT_ALLCH",
         "PerPkg": "1",
@@ -1040,6 +1160,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5e",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_NO_MERGE.RD_MERGED",
         "PerPkg": "1",
@@ -1048,6 +1169,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5e",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_NO_MERGE.WR_MERGED",
         "PerPkg": "1",
@@ -1056,6 +1178,7 @@
     },
     {
         "BriefDescription": "Demands Not Merged with CAMed Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5e",
         "EventName": "UNC_M2HBM_PREFCAM_DEMAND_NO_MERGE.WR_SQUASHED",
         "PerPkg": "1",
@@ -1064,6 +1187,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.CH0_UPI",
         "PerPkg": "1",
@@ -1072,6 +1196,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.CH0_XPT",
         "PerPkg": "1",
@@ -1080,6 +1205,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.CH1_UPI",
         "PerPkg": "1",
@@ -1088,6 +1214,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.CH1_XPT",
         "PerPkg": "1",
@@ -1096,6 +1223,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.UPI_ALLCH",
         "PerPkg": "1",
@@ -1104,6 +1232,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2HBM_PREFCAM_INSERTS.XPT_ALLCH",
         "PerPkg": "1",
@@ -1113,6 +1242,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2HBM_PREFCAM_OCCUPANCY.ALLCH",
         "PerPkg": "1",
@@ -1121,6 +1251,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2HBM_PREFCAM_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1129,6 +1260,7 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_M2HBM_PREFCAM_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1137,6 +1269,7 @@
     },
     {
         "BriefDescription": "All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_M2HBM_PREFCAM_RESP_MISS.ALLCH",
         "PerPkg": "1",
@@ -1145,6 +1278,7 @@
     },
     {
         "BriefDescription": ": Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_M2HBM_PREFCAM_RESP_MISS.CH0",
         "PerPkg": "1",
@@ -1153,6 +1287,7 @@
     },
     {
         "BriefDescription": ": Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5f",
         "EventName": "UNC_M2HBM_PREFCAM_RESP_MISS.CH1",
         "PerPkg": "1",
@@ -1161,6 +1296,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.1LM_POSTED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.1LM_POSTED",
         "PerPkg": "1",
@@ -1169,6 +1305,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.CIS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.CIS",
         "PerPkg": "1",
@@ -1177,6 +1314,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.SQUASHED",
+        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_M2HBM_PREFCAM_RxC_DEALLOCS.SQUASHED",
         "PerPkg": "1",
@@ -1185,6 +1323,7 @@
     },
     {
         "BriefDescription": "UNC_M2HBM_PREFCAM_RxC_OCCUPANCY",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_M2HBM_PREFCAM_RxC_OCCUPANCY",
         "FCMask": "0x00000000",
@@ -1194,6 +1333,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) : AD Ingress (from CMS)=
 Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M2HBM_RxC_AD.INSERTS",
         "FCMask": "0x00000000",
@@ -1204,6 +1344,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) : AD Ingress (from CMS)=
 Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M2HBM_RxC_AD_INSERTS",
         "PerPkg": "1",
@@ -1212,6 +1353,7 @@
     },
     {
         "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M2HBM_RxC_AD_OCCUPANCY",
         "PerPkg": "1",
@@ -1219,6 +1361,7 @@
     },
     {
         "BriefDescription": "BL Ingress (from CMS) : BL Ingress (from CMS)=
 Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_M2HBM_RxC_BL.INSERTS",
         "FCMask": "0x00000000",
@@ -1230,6 +1373,7 @@
     },
     {
         "BriefDescription": "BL Ingress (from CMS) : BL Ingress (from CMS)=
 Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_M2HBM_RxC_BL_INSERTS",
         "PerPkg": "1",
@@ -1239,6 +1383,7 @@
     },
     {
         "BriefDescription": "BL Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M2HBM_RxC_BL_OCCUPANCY",
         "PerPkg": "1",
@@ -1246,6 +1391,7 @@
     },
     {
         "BriefDescription": "Number AD Ingress Credits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "UNC_M2HBM_TGR_AD_CREDITS",
         "PerPkg": "1",
@@ -1253,6 +1399,7 @@
     },
     {
         "BriefDescription": "Number BL Ingress Credits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_M2HBM_TGR_BL_CREDITS",
         "PerPkg": "1",
@@ -1260,6 +1407,7 @@
     },
     {
         "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2HBM_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
@@ -1268,6 +1416,7 @@
     },
     {
         "BriefDescription": "Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_M2HBM_TRACKER_INSERTS.CH1",
         "PerPkg": "1",
@@ -1276,6 +1425,7 @@
     },
     {
         "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2HBM_TRACKER_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1284,6 +1434,7 @@
     },
     {
         "BriefDescription": "Tracker Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_M2HBM_TRACKER_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1292,6 +1443,7 @@
     },
     {
         "BriefDescription": "AD Egress (to CMS) : AD Egress (to CMS) Alloc=
ations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M2HBM_TxC_AD.INSERTS",
         "FCMask": "0x00000000",
@@ -1303,6 +1455,7 @@
     },
     {
         "BriefDescription": "AD Egress (to CMS) : AD Egress (to CMS) Alloc=
ations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M2HBM_TxC_AD_INSERTS",
         "PerPkg": "1",
@@ -1312,6 +1465,7 @@
     },
     {
         "BriefDescription": "AD Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x07",
         "EventName": "UNC_M2HBM_TxC_AD_OCCUPANCY",
         "PerPkg": "1",
@@ -1319,6 +1473,7 @@
     },
     {
         "BriefDescription": "BL Egress (to CMS) : Inserts - CMS0 - Near Si=
de",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UNC_M2HBM_TxC_BL.INSERTS_CMS0",
         "FCMask": "0x00000000",
@@ -1330,6 +1485,7 @@
     },
     {
         "BriefDescription": "BL Egress (to CMS) : Inserts - CMS1 - Far Sid=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UNC_M2HBM_TxC_BL.INSERTS_CMS1",
         "FCMask": "0x00000000",
@@ -1341,6 +1497,7 @@
     },
     {
         "BriefDescription": "BL Egress (to CMS) Occupancy : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0f",
         "EventName": "UNC_M2HBM_TxC_BL_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -1349,6 +1506,7 @@
     },
     {
         "BriefDescription": "BL Egress (to CMS) Occupancy : Common Mesh St=
op - Near Side",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0f",
         "EventName": "UNC_M2HBM_TxC_BL_OCCUPANCY.CMS0",
         "PerPkg": "1",
@@ -1357,6 +1515,7 @@
     },
     {
         "BriefDescription": "BL Egress (to CMS) Occupancy : Common Mesh St=
op - Far Side",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0f",
         "EventName": "UNC_M2HBM_TxC_BL_OCCUPANCY.CMS1",
         "PerPkg": "1",
@@ -1365,6 +1524,7 @@
     },
     {
         "BriefDescription": "WPQ Flush : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2HBM_WPQ_FLUSH.CH0",
         "PerPkg": "1",
@@ -1373,6 +1533,7 @@
     },
     {
         "BriefDescription": "WPQ Flush : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_M2HBM_WPQ_FLUSH.CH1",
         "PerPkg": "1",
@@ -1381,6 +1542,7 @@
     },
     {
         "BriefDescription": "M2M and iMC WPQ Cycles w/Credits - Regular : =
Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2HBM_WPQ_NO_REG_CRD.CHN0",
         "PerPkg": "1",
@@ -1389,6 +1551,7 @@
     },
     {
         "BriefDescription": "M2M and iMC WPQ Cycles w/Credits - Regular : =
Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2HBM_WPQ_NO_REG_CRD.CHN1",
         "PerPkg": "1",
@@ -1397,6 +1560,7 @@
     },
     {
         "BriefDescription": "M2M and iMC WPQ Cycles w/Credits - Special : =
Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2HBM_WPQ_NO_SPEC_CRD.CHN0",
         "PerPkg": "1",
@@ -1405,6 +1569,7 @@
     },
     {
         "BriefDescription": "M2M and iMC WPQ Cycles w/Credits - Special : =
Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2HBM_WPQ_NO_SPEC_CRD.CHN1",
         "PerPkg": "1",
@@ -1413,6 +1578,7 @@
     },
     {
         "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2HBM_WR_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
@@ -1421,6 +1587,7 @@
     },
     {
         "BriefDescription": "Write Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_M2HBM_WR_TRACKER_INSERTS.CH1",
         "PerPkg": "1",
@@ -1429,6 +1596,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2HBM_WR_TRACKER_NONPOSTED_INSERTS.CH0",
         "PerPkg": "1",
@@ -1437,6 +1605,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4d",
         "EventName": "UNC_M2HBM_WR_TRACKER_NONPOSTED_INSERTS.CH1",
         "PerPkg": "1",
@@ -1445,6 +1614,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2HBM_WR_TRACKER_NONPOSTED_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1453,6 +1623,7 @@
     },
     {
         "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "UNC_M2HBM_WR_TRACKER_NONPOSTED_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1461,6 +1632,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2HBM_WR_TRACKER_POSTED_INSERTS.CH0",
         "PerPkg": "1",
@@ -1469,6 +1641,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "UNC_M2HBM_WR_TRACKER_POSTED_INSERTS.CH1",
         "PerPkg": "1",
@@ -1477,6 +1650,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2HBM_WR_TRACKER_POSTED_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -1485,6 +1659,7 @@
     },
     {
         "BriefDescription": "Write Tracker Posted Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M2HBM_WR_TRACKER_POSTED_OCCUPANCY.CH1",
         "PerPkg": "1",
@@ -1493,6 +1668,7 @@
     },
     {
         "BriefDescription": "Activate due to read, write, underfill, or by=
pass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.ALL",
         "PerPkg": "1",
@@ -1502,6 +1678,7 @@
     },
     {
         "BriefDescription": "Activate due to read",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.RD",
         "PerPkg": "1",
@@ -1511,6 +1688,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count : Activate due to Read in =
PCH0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.RD_PCH0",
         "PerPkg": "1",
@@ -1520,6 +1698,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count : Activate due to Read in =
PCH1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.RD_PCH1",
         "PerPkg": "1",
@@ -1529,6 +1708,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count : Underfill Read transacti=
on on Page Empty or Page Miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.UFILL",
         "PerPkg": "1",
@@ -1538,6 +1718,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.UFILL_PCH0",
         "PerPkg": "1",
@@ -1547,6 +1728,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.UFILL_PCH1",
         "PerPkg": "1",
@@ -1556,6 +1738,7 @@
     },
     {
         "BriefDescription": "Activate due to write",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.WR",
         "PerPkg": "1",
@@ -1565,6 +1748,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count : Activate due to Write in=
 PCH0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.WR_PCH0",
         "PerPkg": "1",
@@ -1574,6 +1758,7 @@
     },
     {
         "BriefDescription": "HBM Activate Count : Activate due to Write in=
 PCH1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_MCHBM_ACT_COUNT.WR_PCH1",
         "PerPkg": "1",
@@ -1583,6 +1768,7 @@
     },
     {
         "BriefDescription": "All CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.ALL",
         "PerPkg": "1",
@@ -1591,6 +1777,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.PCH0",
         "PerPkg": "1",
@@ -1600,6 +1787,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.PCH1",
         "PerPkg": "1",
@@ -1609,6 +1797,7 @@
     },
     {
         "BriefDescription": "Read CAS commands issued (regular and underfi=
ll)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.RD",
         "PerPkg": "1",
@@ -1617,6 +1806,7 @@
     },
     {
         "BriefDescription": "Regular read CAS commands with precharge",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.RD_PRE_REG",
         "PerPkg": "1",
@@ -1625,6 +1815,7 @@
     },
     {
         "BriefDescription": "Underfill read CAS commands with precharge",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.RD_PRE_UNDERFILL",
         "PerPkg": "1",
@@ -1633,6 +1824,7 @@
     },
     {
         "BriefDescription": "Regular read CAS commands issued (does not in=
clude underfills)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.RD_REG",
         "PerPkg": "1",
@@ -1641,6 +1833,7 @@
     },
     {
         "BriefDescription": "Underfill read CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
@@ -1649,6 +1842,7 @@
     },
     {
         "BriefDescription": "Write CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.WR",
         "PerPkg": "1",
@@ -1657,6 +1851,7 @@
     },
     {
         "BriefDescription": "HBM RD_CAS and WR_CAS Commands. : HBM WR_CAS =
commands w/o auto-pre",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.WR_NONPRE",
         "PerPkg": "1",
@@ -1665,6 +1860,7 @@
     },
     {
         "BriefDescription": "Write CAS commands with precharge",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_MCHBM_CAS_COUNT.WR_PRE",
         "PerPkg": "1",
@@ -1673,6 +1869,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.PCH0",
         "PerPkg": "1",
@@ -1681,6 +1878,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.PCH1",
         "PerPkg": "1",
@@ -1689,6 +1887,7 @@
     },
     {
         "BriefDescription": "Read CAS Command in Interleaved Mode (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.RD_32B",
         "PerPkg": "1",
@@ -1697,6 +1896,7 @@
     },
     {
         "BriefDescription": "Read CAS Command in Regular Mode (64B) in Pse=
udochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.RD_64B",
         "PerPkg": "1",
@@ -1705,6 +1905,7 @@
     },
     {
         "BriefDescription": "Underfill Read CAS Command in Interleaved Mod=
e (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.RD_UFILL_32B",
         "PerPkg": "1",
@@ -1713,6 +1914,7 @@
     },
     {
         "BriefDescription": "Underfill Read CAS Command in Regular Mode (6=
4B) in Pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.RD_UFILL_64B",
         "PerPkg": "1",
@@ -1721,6 +1923,7 @@
     },
     {
         "BriefDescription": "Write CAS Command in Interleaved Mode (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.WR_32B",
         "PerPkg": "1",
@@ -1729,6 +1932,7 @@
     },
     {
         "BriefDescription": "Write CAS Command in Regular Mode (64B) in Ps=
eudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_MCHBM_CAS_ISSUED_REQ_LEN.WR_64B",
         "PerPkg": "1",
@@ -1737,6 +1941,7 @@
     },
     {
         "BriefDescription": "IMC Clockticks at DCLK frequency",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_MCHBM_CLOCKTICKS",
         "PerPkg": "1",
@@ -1745,6 +1950,7 @@
     },
     {
         "BriefDescription": "HBM Precharge All Commands",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_MCHBM_HBM_PREALL.PCH0",
         "PerPkg": "1",
@@ -1754,6 +1960,7 @@
     },
     {
         "BriefDescription": "HBM Precharge All Commands",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_MCHBM_HBM_PREALL.PCH1",
         "PerPkg": "1",
@@ -1763,6 +1970,7 @@
     },
     {
         "BriefDescription": "All Precharge Commands",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_MCHBM_HBM_PRE_ALL",
         "PerPkg": "1",
@@ -1772,6 +1980,7 @@
     },
     {
         "BriefDescription": "IMC Clockticks at HCLK frequency",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_MCHBM_HCLOCKTICKS",
         "PerPkg": "1",
@@ -1779,6 +1988,7 @@
     },
     {
         "BriefDescription": "All precharge events",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.ALL",
         "PerPkg": "1",
@@ -1788,6 +1998,7 @@
     },
     {
         "BriefDescription": "Precharge from MC page table",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.PGT",
         "PerPkg": "1",
@@ -1797,6 +2008,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands. : Precharges from Pag=
e Table",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.PGT_PCH0",
         "PerPkg": "1",
@@ -1806,6 +2018,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.PGT_PCH1",
         "PerPkg": "1",
@@ -1815,6 +2028,7 @@
     },
     {
         "BriefDescription": "Precharge due to read on page miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.RD",
         "PerPkg": "1",
@@ -1824,6 +2038,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands. : Precharge due to re=
ad",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.RD_PCH0",
         "PerPkg": "1",
@@ -1833,6 +2048,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.RD_PCH1",
         "PerPkg": "1",
@@ -1842,6 +2058,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.UFILL",
         "PerPkg": "1",
@@ -1851,6 +2068,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.UFILL_PCH0",
         "PerPkg": "1",
@@ -1860,6 +2078,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.UFILL_PCH1",
         "PerPkg": "1",
@@ -1869,6 +2088,7 @@
     },
     {
         "BriefDescription": "Precharge due to write on page miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.WR",
         "PerPkg": "1",
@@ -1878,6 +2098,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands. : Precharge due to wr=
ite",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.WR_PCH0",
         "PerPkg": "1",
@@ -1887,6 +2108,7 @@
     },
     {
         "BriefDescription": "HBM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_MCHBM_PRE_COUNT.WR_PCH1",
         "PerPkg": "1",
@@ -1896,6 +2118,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles where the read bu=
ffer has greater than UMASK elements.  NOTE: Umask must be set to the maxim=
um number of elements in the queue (24 entries for SPR).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_MCHBM_RDB_FULL",
         "PerPkg": "1",
@@ -1903,6 +2126,7 @@
     },
     {
         "BriefDescription": "Counts the number of inserts into the read bu=
ffer.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_MCHBM_RDB_INSERTS",
         "PerPkg": "1",
@@ -1911,6 +2135,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_MCHBM_RDB_INSERTS.PCH0",
         "PerPkg": "1",
@@ -1919,6 +2144,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_MCHBM_RDB_INSERTS.PCH1",
         "PerPkg": "1",
@@ -1927,6 +2153,7 @@
     },
     {
         "BriefDescription": "Counts the number of elements in the read buf=
fer per cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_MCHBM_RDB_OCCUPANCY",
         "PerPkg": "1",
@@ -1934,6 +2161,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_MCHBM_RPQ_INSERTS.PCH0",
         "PerPkg": "1",
@@ -1943,6 +2171,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_MCHBM_RPQ_INSERTS.PCH1",
         "PerPkg": "1",
@@ -1952,6 +2181,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_MCHBM_RPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
@@ -1960,6 +2190,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_MCHBM_RPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
@@ -1968,6 +2199,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_MCHBM_WPQ_INSERTS.PCH0",
         "PerPkg": "1",
@@ -1977,6 +2209,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_MCHBM_WPQ_INSERTS.PCH1",
         "PerPkg": "1",
@@ -1986,6 +2219,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_MCHBM_WPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
@@ -1994,6 +2228,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_MCHBM_WPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
@@ -2002,6 +2237,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_MCHBM_WPQ_READ_HIT",
         "FCMask": "0x00000000",
@@ -2012,6 +2248,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_MCHBM_WPQ_READ_HIT.PCH0",
         "PerPkg": "1",
@@ -2021,6 +2258,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_MCHBM_WPQ_READ_HIT.PCH1",
         "PerPkg": "1",
@@ -2030,6 +2268,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_MCHBM_WPQ_WRITE_HIT",
         "FCMask": "0x00000000",
@@ -2040,6 +2279,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_MCHBM_WPQ_WRITE_HIT.PCH0",
         "PerPkg": "1",
@@ -2049,6 +2289,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_MCHBM_WPQ_WRITE_HIT.PCH1",
         "PerPkg": "1",
@@ -2058,6 +2299,7 @@
     },
     {
         "BriefDescription": "Activate due to read, write, underfill, or by=
pass",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M_ACT_COUNT.ALL",
         "PerPkg": "1",
@@ -2067,6 +2309,7 @@
     },
     {
         "BriefDescription": "All DRAM CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
@@ -2076,6 +2319,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.PCH0",
         "PerPkg": "1",
@@ -2085,6 +2329,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.PCH1",
         "PerPkg": "1",
@@ -2094,6 +2339,7 @@
     },
     {
         "BriefDescription": "All DRAM read CAS commands issued (including =
underfills)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
@@ -2103,6 +2349,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD_PRE_REG",
         "PerPkg": "1",
@@ -2112,6 +2359,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD_PRE_UNDERFILL",
         "PerPkg": "1",
@@ -2121,6 +2369,7 @@
     },
     {
         "BriefDescription": "All DRAM read CAS commands issued (does not i=
nclude underfills)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
@@ -2130,6 +2379,7 @@
     },
     {
         "BriefDescription": "DRAM underfill read CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
@@ -2139,6 +2389,7 @@
     },
     {
         "BriefDescription": "All DRAM write CAS commands issued",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
@@ -2148,6 +2399,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_CA=
S commands w/o auto-pre",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.WR_NONPRE",
         "PerPkg": "1",
@@ -2157,6 +2409,7 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.WR_PRE",
         "PerPkg": "1",
@@ -2166,6 +2419,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.PCH0",
         "PerPkg": "1",
@@ -2174,6 +2428,7 @@
     },
     {
         "BriefDescription": "Pseudo Channel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.PCH1",
         "PerPkg": "1",
@@ -2182,6 +2437,7 @@
     },
     {
         "BriefDescription": "Read CAS Command in Interleaved Mode (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.RD_32B",
         "PerPkg": "1",
@@ -2190,6 +2446,7 @@
     },
     {
         "BriefDescription": "Read CAS Command in Regular Mode (64B) in Pse=
udochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.RD_64B",
         "PerPkg": "1",
@@ -2198,6 +2455,7 @@
     },
     {
         "BriefDescription": "Underfill Read CAS Command in Interleaved Mod=
e (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.RD_UFILL_32B",
         "PerPkg": "1",
@@ -2206,6 +2464,7 @@
     },
     {
         "BriefDescription": "Underfill Read CAS Command in Regular Mode (6=
4B) in Pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.RD_UFILL_64B",
         "PerPkg": "1",
@@ -2214,6 +2473,7 @@
     },
     {
         "BriefDescription": "Write CAS Command in Interleaved Mode (32B)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.WR_32B",
         "PerPkg": "1",
@@ -2222,6 +2482,7 @@
     },
     {
         "BriefDescription": "Write CAS Command in Regular Mode (64B) in Ps=
eudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_ISSUED_REQ_LEN.WR_64B",
         "PerPkg": "1",
@@ -2230,6 +2491,7 @@
     },
     {
         "BriefDescription": "IMC Clockticks at DCLK frequency",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
@@ -2239,6 +2501,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_M_DRAM_PRE_ALL",
         "PerPkg": "1",
@@ -2248,6 +2511,7 @@
     },
     {
         "BriefDescription": "IMC Clockticks at HCLK frequency",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_HCLOCKTICKS",
         "PerPkg": "1",
@@ -2256,6 +2520,7 @@
     },
     {
         "BriefDescription": "UNC_M_PCLS.RD",
+        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_PCLS.RD",
         "PerPkg": "1",
@@ -2264,6 +2529,7 @@
     },
     {
         "BriefDescription": "UNC_M_PCLS.TOTAL",
+        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_PCLS.TOTAL",
         "PerPkg": "1",
@@ -2272,6 +2538,7 @@
     },
     {
         "BriefDescription": "UNC_M_PCLS.WR",
+        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_PCLS.WR",
         "PerPkg": "1",
@@ -2280,6 +2547,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe3",
         "EventName": "UNC_M_PMM_RPQ_INSERTS",
         "PerPkg": "1",
@@ -2288,6 +2556,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL_SCH0",
         "PerPkg": "1",
@@ -2297,6 +2566,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL_SCH1",
         "PerPkg": "1",
@@ -2306,6 +2576,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH0",
         "PerPkg": "1",
@@ -2315,6 +2586,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH1",
         "PerPkg": "1",
@@ -2324,6 +2596,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH0",
         "PerPkg": "1",
@@ -2333,6 +2606,7 @@
     },
     {
         "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH1",
         "PerPkg": "1",
@@ -2342,6 +2616,7 @@
     },
     {
         "BriefDescription": "PMM (for IXP) Write Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe5",
         "EventName": "UNC_M_PMM_WPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -2349,6 +2624,7 @@
     },
     {
         "BriefDescription": "PMM Write Pending Queue inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe7",
         "EventName": "UNC_M_PMM_WPQ_INSERTS",
         "PerPkg": "1",
@@ -2357,6 +2633,7 @@
     },
     {
         "BriefDescription": "PMM Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -2366,6 +2643,7 @@
     },
     {
         "BriefDescription": "PMM Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL_SCH0",
         "PerPkg": "1",
@@ -2375,6 +2653,7 @@
     },
     {
         "BriefDescription": "PMM Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xE4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL_SCH1",
         "PerPkg": "1",
@@ -2384,6 +2663,7 @@
     },
     {
         "BriefDescription": "PMM (for IXP) Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.CAS",
         "PerPkg": "1",
@@ -2393,6 +2673,7 @@
     },
     {
         "BriefDescription": "PMM (for IXP) Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0xe4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.PWR",
         "PerPkg": "1",
@@ -2402,6 +2683,7 @@
     },
     {
         "BriefDescription": "Channel PPD Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "PerPkg": "1",
@@ -2410,6 +2692,7 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_0",
         "PerPkg": "1",
@@ -2419,6 +2702,7 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_1",
         "PerPkg": "1",
@@ -2428,6 +2712,7 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_2",
         "PerPkg": "1",
@@ -2437,6 +2722,7 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
         "EventCode": "0x47",
         "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_3",
         "PerPkg": "1",
@@ -2446,6 +2732,7 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRIT_THROTTLE_CYCLES.SLOT0",
         "PerPkg": "1",
@@ -2455,6 +2742,7 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRIT_THROTTLE_CYCLES.SLOT1",
         "PerPkg": "1",
@@ -2464,6 +2752,7 @@
     },
     {
         "BriefDescription": "Clock-Enabled Self-Refresh",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "PerPkg": "1",
@@ -2472,6 +2761,7 @@
     },
     {
         "BriefDescription": "Precharge due to read, write, underfill, or P=
GT.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.ALL",
         "PerPkg": "1",
@@ -2481,6 +2771,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
         "PerPkg": "1",
@@ -2490,6 +2781,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Precharges from Pa=
ge Table",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT_PCH0",
         "PerPkg": "1",
@@ -2499,6 +2791,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT_PCH1",
         "PerPkg": "1",
@@ -2508,6 +2801,7 @@
     },
     {
         "BriefDescription": "Precharge due to read on page miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
@@ -2517,6 +2811,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Precharge due to r=
ead",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.RD_PCH0",
         "PerPkg": "1",
@@ -2526,6 +2821,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.RD_PCH1",
         "PerPkg": "1",
@@ -2535,6 +2831,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.UFILL",
         "PerPkg": "1",
@@ -2544,6 +2841,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.UFILL_PCH0",
         "PerPkg": "1",
@@ -2553,6 +2851,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.UFILL_PCH1",
         "PerPkg": "1",
@@ -2562,6 +2861,7 @@
     },
     {
         "BriefDescription": "Precharge due to write on page miss",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
@@ -2571,6 +2871,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Precharge due to w=
rite",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.WR_PCH0",
         "PerPkg": "1",
@@ -2580,6 +2881,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.WR_PCH1",
         "PerPkg": "1",
@@ -2589,6 +2891,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles where the read bu=
ffer has greater than UMASK elements.  This includes reads to both DDR and =
PMEM.  NOTE: Umask must be set to the maximum number of elements in the que=
ue (24 entries for SPR).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_M_RDB_FULL",
         "PerPkg": "1",
@@ -2596,6 +2899,7 @@
     },
     {
         "BriefDescription": "Counts the number of inserts into the read bu=
ffer destined for DDR.  Does not count reads destined for PMEM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M_RDB_INSERTS",
         "PerPkg": "1",
@@ -2604,6 +2908,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M_RDB_INSERTS.PCH0",
         "PerPkg": "1",
@@ -2612,6 +2917,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M_RDB_INSERTS.PCH1",
         "PerPkg": "1",
@@ -2620,6 +2926,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles where there's at =
least one element in the read buffer.  This includes reads to both DDR and =
PMEM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M_RDB_NE",
         "PerPkg": "1",
@@ -2628,6 +2935,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M_RDB_NE.PCH0",
         "PerPkg": "1",
@@ -2636,6 +2944,7 @@
     },
     {
         "BriefDescription": "Read Data Buffer Not Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M_RDB_NE.PCH1",
         "PerPkg": "1",
@@ -2644,6 +2953,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles where there's at =
least one element in the read buffer.  This includes reads to both DDR and =
PMEM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_M_RDB_NOT_EMPTY",
         "PerPkg": "1",
@@ -2652,6 +2962,7 @@
     },
     {
         "BriefDescription": "Counts the number of elements in the read buf=
fer, including reads to both DDR and PMEM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M_RDB_OCCUPANCY",
         "PerPkg": "1",
@@ -2659,6 +2970,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.PCH0",
         "PerPkg": "1",
@@ -2668,6 +2980,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.PCH1",
         "PerPkg": "1",
@@ -2677,6 +2990,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
@@ -2685,6 +2999,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_M_RPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
@@ -2693,6 +3008,7 @@
     },
     {
         "BriefDescription": "Scoreboard accepts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.ACCEPTS",
         "PerPkg": "1",
@@ -2701,6 +3017,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : Write Accepts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.FM_RD_CMPS",
         "PerPkg": "1",
@@ -2709,6 +3026,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : Write Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.FM_WR_CMPS",
         "PerPkg": "1",
@@ -2717,6 +3035,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : FM read completions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.NM_RD_CMPS",
         "PerPkg": "1",
@@ -2725,6 +3044,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : FM write completions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.NM_WR_CMPS",
         "PerPkg": "1",
@@ -2733,6 +3053,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : Read Accepts",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.RD_ACCEPTS",
         "PerPkg": "1",
@@ -2741,6 +3062,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : Read Rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.RD_REJECTS",
         "PerPkg": "1",
@@ -2749,6 +3071,7 @@
     },
     {
         "BriefDescription": "Scoreboard rejects",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.REJECTS",
         "PerPkg": "1",
@@ -2757,6 +3080,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : NM read completions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.WR_ACCEPTS",
         "PerPkg": "1",
@@ -2765,6 +3089,7 @@
     },
     {
         "BriefDescription": "Scoreboard Accesses : NM write completions",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd2",
         "EventName": "UNC_M_SB_ACCESSES.WR_REJECTS",
         "PerPkg": "1",
@@ -2773,6 +3098,7 @@
     },
     {
         "BriefDescription": ": Alloc",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.ALLOC",
         "PerPkg": "1",
@@ -2781,6 +3107,7 @@
     },
     {
         "BriefDescription": ": Dealloc",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.DEALLOC",
         "PerPkg": "1",
@@ -2789,6 +3116,7 @@
     },
     {
         "BriefDescription": ": Near Mem Write Starved",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.FM_RD_STARVED",
         "PerPkg": "1",
@@ -2797,6 +3125,7 @@
     },
     {
         "BriefDescription": ": Far Mem Write Starved",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.FM_TGR_WR_STARVED",
         "PerPkg": "1",
@@ -2805,6 +3134,7 @@
     },
     {
         "BriefDescription": ": Far Mem Read Starved",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.FM_WR_STARVED",
         "PerPkg": "1",
@@ -2813,6 +3143,7 @@
     },
     {
         "BriefDescription": ": Valid",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.NM_RD_STARVED",
         "PerPkg": "1",
@@ -2821,6 +3152,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read Starved",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.NM_WR_STARVED",
         "PerPkg": "1",
@@ -2829,6 +3161,7 @@
     },
     {
         "BriefDescription": ": Reject",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd9",
         "EventName": "UNC_M_SB_CANARY.VLD",
         "PerPkg": "1",
@@ -2837,6 +3170,7 @@
     },
     {
         "BriefDescription": "Scoreboard Cycles Full",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd1",
         "EventName": "UNC_M_SB_CYCLES_FULL",
         "PerPkg": "1",
@@ -2844,6 +3178,7 @@
     },
     {
         "BriefDescription": "Scoreboard Cycles Not-Empty",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd0",
         "EventName": "UNC_M_SB_CYCLES_NE",
         "PerPkg": "1",
@@ -2851,6 +3186,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Block region reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.BLOCK_RDS",
         "PerPkg": "1",
@@ -2859,6 +3195,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Block region writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.BLOCK_WRS",
         "PerPkg": "1",
@@ -2867,6 +3204,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Persistent Mem reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.PMM_RDS",
         "PerPkg": "1",
@@ -2875,6 +3213,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Persistent Mem writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.PMM_WRS",
         "PerPkg": "1",
@@ -2883,6 +3222,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.RDS",
         "PerPkg": "1",
@@ -2891,6 +3231,7 @@
     },
     {
         "BriefDescription": "Scoreboard Inserts : Writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd6",
         "EventName": "UNC_M_SB_INSERTS.WRS",
         "PerPkg": "1",
@@ -2899,6 +3240,7 @@
     },
     {
         "BriefDescription": "Scoreboard Occupancy : Block region reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_M_SB_OCCUPANCY.BLOCK_RDS",
         "PerPkg": "1",
@@ -2907,6 +3249,7 @@
     },
     {
         "BriefDescription": "Scoreboard Occupancy : Block region writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_M_SB_OCCUPANCY.BLOCK_WRS",
         "PerPkg": "1",
@@ -2915,6 +3258,7 @@
     },
     {
         "BriefDescription": "Scoreboard Occupancy : Persistent Mem reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_M_SB_OCCUPANCY.PMM_RDS",
         "PerPkg": "1",
@@ -2923,6 +3267,7 @@
     },
     {
         "BriefDescription": "Scoreboard Occupancy : Persistent Mem writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_M_SB_OCCUPANCY.PMM_WRS",
         "PerPkg": "1",
@@ -2931,6 +3276,7 @@
     },
     {
         "BriefDescription": "Scoreboard Occupancy : Reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd5",
         "EventName": "UNC_M_SB_OCCUPANCY.RDS",
         "PerPkg": "1",
@@ -2939,6 +3285,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Inserts : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0xda",
         "EventName": "UNC_M_SB_PREF_INSERTS.ALL",
         "PerPkg": "1",
@@ -2947,6 +3294,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Inserts : DDR4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xda",
         "EventName": "UNC_M_SB_PREF_INSERTS.DDR",
         "PerPkg": "1",
@@ -2955,6 +3303,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Inserts : PMM",
+        "Counter": "0,1,2,3",
         "EventCode": "0xda",
         "EventName": "UNC_M_SB_PREF_INSERTS.PMM",
         "PerPkg": "1",
@@ -2963,6 +3312,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Occupancy : All",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdb",
         "EventName": "UNC_M_SB_PREF_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -2971,6 +3321,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Occupancy : DDR4",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdb",
         "EventName": "UNC_M_SB_PREF_OCCUPANCY.DDR",
         "PerPkg": "1",
@@ -2979,6 +3330,7 @@
     },
     {
         "BriefDescription": "Scoreboard Prefetch Occupancy : Persistent Me=
m",
+        "Counter": "0,1,2,3",
         "EventCode": "0xDB",
         "EventName": "UNC_M_SB_PREF_OCCUPANCY.PMM",
         "FCMask": "0x00000000",
@@ -2989,6 +3341,7 @@
     },
     {
         "BriefDescription": "Number of Scoreboard Requests Rejected",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd4",
         "EventName": "UNC_M_SB_REJECT.CANARY",
         "PerPkg": "1",
@@ -2997,6 +3350,7 @@
     },
     {
         "BriefDescription": "Number of Scoreboard Requests Rejected",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd4",
         "EventName": "UNC_M_SB_REJECT.DDR_EARLY_CMP",
         "PerPkg": "1",
@@ -3005,6 +3359,7 @@
     },
     {
         "BriefDescription": "Number of Scoreboard Requests Rejected : FM r=
equests rejected due to full address conflict",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd4",
         "EventName": "UNC_M_SB_REJECT.FM_ADDR_CNFLT",
         "PerPkg": "1",
@@ -3013,6 +3368,7 @@
     },
     {
         "BriefDescription": "Number of Scoreboard Requests Rejected : NM r=
equests rejected due to set conflict",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd4",
         "EventName": "UNC_M_SB_REJECT.NM_SET_CNFLT",
         "PerPkg": "1",
@@ -3021,6 +3377,7 @@
     },
     {
         "BriefDescription": "Number of Scoreboard Requests Rejected : Patr=
ol requests rejected due to set conflict",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd4",
         "EventName": "UNC_M_SB_REJECT.PATROL_SET_CNFLT",
         "PerPkg": "1",
@@ -3029,6 +3386,7 @@
     },
     {
         "BriefDescription": ": Far Mem Read - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd7",
         "EventName": "UNC_M_SB_STRV_ALLOC.FM_RD",
         "PerPkg": "1",
@@ -3037,6 +3395,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read - Clear",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd7",
         "EventName": "UNC_M_SB_STRV_ALLOC.FM_TGR",
         "PerPkg": "1",
@@ -3045,6 +3404,7 @@
     },
     {
         "BriefDescription": ": Far Mem Write - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd7",
         "EventName": "UNC_M_SB_STRV_ALLOC.FM_WR",
         "PerPkg": "1",
@@ -3053,6 +3413,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd7",
         "EventName": "UNC_M_SB_STRV_ALLOC.NM_RD",
         "PerPkg": "1",
@@ -3061,6 +3422,7 @@
     },
     {
         "BriefDescription": ": Near Mem Write - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd7",
         "EventName": "UNC_M_SB_STRV_ALLOC.NM_WR",
         "PerPkg": "1",
@@ -3069,6 +3431,7 @@
     },
     {
         "BriefDescription": ": Far Mem Read - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xde",
         "EventName": "UNC_M_SB_STRV_DEALLOC.FM_RD",
         "PerPkg": "1",
@@ -3077,6 +3440,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read - Clear",
+        "Counter": "0,1,2,3",
         "EventCode": "0xde",
         "EventName": "UNC_M_SB_STRV_DEALLOC.FM_TGR",
         "PerPkg": "1",
@@ -3085,6 +3449,7 @@
     },
     {
         "BriefDescription": ": Far Mem Write - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xde",
         "EventName": "UNC_M_SB_STRV_DEALLOC.FM_WR",
         "PerPkg": "1",
@@ -3093,6 +3458,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xde",
         "EventName": "UNC_M_SB_STRV_DEALLOC.NM_RD",
         "PerPkg": "1",
@@ -3101,6 +3467,7 @@
     },
     {
         "BriefDescription": ": Near Mem Write - Set",
+        "Counter": "0,1,2,3",
         "EventCode": "0xde",
         "EventName": "UNC_M_SB_STRV_DEALLOC.NM_WR",
         "PerPkg": "1",
@@ -3109,6 +3476,7 @@
     },
     {
         "BriefDescription": ": Far Mem Read",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd8",
         "EventName": "UNC_M_SB_STRV_OCC.FM_RD",
         "PerPkg": "1",
@@ -3117,6 +3485,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read - Clear",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd8",
         "EventName": "UNC_M_SB_STRV_OCC.FM_TGR",
         "PerPkg": "1",
@@ -3125,6 +3494,7 @@
     },
     {
         "BriefDescription": ": Far Mem Write",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd8",
         "EventName": "UNC_M_SB_STRV_OCC.FM_WR",
         "PerPkg": "1",
@@ -3133,6 +3503,7 @@
     },
     {
         "BriefDescription": ": Near Mem Read",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd8",
         "EventName": "UNC_M_SB_STRV_OCC.NM_RD",
         "PerPkg": "1",
@@ -3141,6 +3512,7 @@
     },
     {
         "BriefDescription": ": Near Mem Write",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd8",
         "EventName": "UNC_M_SB_STRV_OCC.NM_WR",
         "PerPkg": "1",
@@ -3149,6 +3521,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.DDR4_CMP",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.DDR4_CMP",
         "PerPkg": "1",
@@ -3157,6 +3530,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.NEW",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.NEW",
         "PerPkg": "1",
@@ -3165,6 +3539,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.OCC",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.OCC",
         "PerPkg": "1",
@@ -3173,6 +3548,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.PMM0_CMP",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.PMM0_CMP",
         "PerPkg": "1",
@@ -3181,6 +3557,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.PMM1_CMP",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.PMM1_CMP",
         "PerPkg": "1",
@@ -3189,6 +3566,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.PMM2_CMP",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.PMM2_CMP",
         "PerPkg": "1",
@@ -3197,6 +3575,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.RD_HIT",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.RD_HIT",
         "PerPkg": "1",
@@ -3205,6 +3584,7 @@
     },
     {
         "BriefDescription": "UNC_M_SB_TAGGED.RD_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0xdd",
         "EventName": "UNC_M_SB_TAGGED.RD_MISS",
         "PerPkg": "1",
@@ -3213,6 +3593,7 @@
     },
     {
         "BriefDescription": "2LM Tag check hit in near memory cache (DDR4)=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "UNC_M_TAGCHK.HIT",
         "PerPkg": "1",
@@ -3221,6 +3602,7 @@
     },
     {
         "BriefDescription": "2LM Tag check miss, no data at this line",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "UNC_M_TAGCHK.MISS_CLEAN",
         "PerPkg": "1",
@@ -3229,6 +3611,7 @@
     },
     {
         "BriefDescription": "2LM Tag check miss, existing data may be evic=
ted to PMM",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "UNC_M_TAGCHK.MISS_DIRTY",
         "PerPkg": "1",
@@ -3237,6 +3620,7 @@
     },
     {
         "BriefDescription": "2LM Tag check hit due to memory read",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "UNC_M_TAGCHK.NM_RD_HIT",
         "PerPkg": "1",
@@ -3245,6 +3629,7 @@
     },
     {
         "BriefDescription": "2LM Tag check hit due to memory write",
+        "Counter": "0,1,2,3",
         "EventCode": "0xd3",
         "EventName": "UNC_M_TAGCHK.NM_WR_HIT",
         "PerPkg": "1",
@@ -3253,6 +3638,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS.PCH0",
         "PerPkg": "1",
@@ -3262,6 +3648,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS.PCH1",
         "PerPkg": "1",
@@ -3271,6 +3658,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
@@ -3279,6 +3667,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
@@ -3287,6 +3676,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M_WPQ_READ_HIT",
         "FCMask": "0x00000000",
@@ -3297,6 +3687,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M_WPQ_WRITE_HIT",
         "FCMask": "0x00000000",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
index 8948e8507..4d669afb1 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "PCU PCLK Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "UNC_P_CORE_TRANSITION_CYCLES",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_P_CORE_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "UNC_P_DEMOTIONS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_P_DEMOTIONS",
         "PerPkg": "1",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Phase Shed 0 Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "UNC_P_FIVR_PS_PS0_CYCLES",
         "PerPkg": "1",
@@ -31,6 +35,7 @@
     },
     {
         "BriefDescription": "Phase Shed 1 Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UNC_P_FIVR_PS_PS1_CYCLES",
         "PerPkg": "1",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "Phase Shed 2 Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x77",
         "EventName": "UNC_P_FIVR_PS_PS2_CYCLES",
         "PerPkg": "1",
@@ -47,6 +53,7 @@
     },
     {
         "BriefDescription": "Phase Shed 3 Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x78",
         "EventName": "UNC_P_FIVR_PS_PS3_CYCLES",
         "PerPkg": "1",
@@ -55,6 +62,7 @@
     },
     {
         "BriefDescription": "AVX256 Frequency Clipping",
+        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "UNC_P_FREQ_CLIP_AVX256",
         "PerPkg": "1",
@@ -62,6 +70,7 @@
     },
     {
         "BriefDescription": "AVX512 Frequency Clipping",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4a",
         "EventName": "UNC_P_FREQ_CLIP_AVX512",
         "PerPkg": "1",
@@ -69,6 +78,7 @@
     },
     {
         "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x04",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "PerPkg": "1",
@@ -77,6 +87,7 @@
     },
     {
         "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "PerPkg": "1",
@@ -85,6 +96,7 @@
     },
     {
         "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
         "PerPkg": "1",
@@ -93,6 +105,7 @@
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "PerPkg": "1",
@@ -101,6 +114,7 @@
     },
     {
         "BriefDescription": "Memory Phase Shedding Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
@@ -109,6 +123,7 @@
     },
     {
         "BriefDescription": "Package C State Residency - C0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
         "PerPkg": "1",
@@ -117,6 +132,7 @@
     },
     {
         "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
         "PerPkg": "1",
@@ -125,6 +141,7 @@
     },
     {
         "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
         "PerPkg": "1",
@@ -140,6 +157,7 @@
     },
     {
         "BriefDescription": "Number of cores in C0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
         "PerPkg": "1",
@@ -148,6 +166,7 @@
     },
     {
         "BriefDescription": "Number of cores in C3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C3",
         "PerPkg": "1",
@@ -156,6 +175,7 @@
     },
     {
         "BriefDescription": "Number of cores in C6",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
         "PerPkg": "1",
@@ -164,6 +184,7 @@
     },
     {
         "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0a",
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "PerPkg": "1",
@@ -172,6 +193,7 @@
     },
     {
         "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
         "EventCode": "0x09",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
@@ -180,6 +202,7 @@
     },
     {
         "BriefDescription": "Total Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -188,6 +211,7 @@
     },
     {
         "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
index a1e3b8d2e..609a9549c 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
@@ -66,6 +74,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
@@ -75,6 +84,7 @@
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
@@ -83,6 +93,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -91,6 +102,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
@@ -99,6 +111,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -107,6 +120,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
@@ -115,6 +129,7 @@
     },
     {
         "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
@@ -123,6 +138,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
@@ -132,6 +148,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -140,6 +157,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
@@ -148,6 +166,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
@@ -156,6 +175,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
--=20
2.39.3

