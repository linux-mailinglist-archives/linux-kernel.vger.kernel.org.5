Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F857AF0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjIZQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjIZQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57BBF;
        Tue, 26 Sep 2023 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746507; x=1727282507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h7zweQMwZvx4bkSFW3iiH67gMv1GrI7MVKHwE7FVFTs=;
  b=TQ2FTalHS8tq0o6qIUz8XV+H9xLSDg5BES+pldnM8ogHDvEBXH8F8Nc0
   7VlGhnoeBoliKJlzRFT5Qvaadxc1uzxJsomlmgS95D7bxMg3PTzW3+hFo
   x+EDnFtbHrqilyH86+rC+RTgP1oFQaAeFWx14QDfgIb/JHaCOQm2fnkKo
   a9mtnXnHwe6E674cfWFx06sQDnMt+ZTcE0wsfP4QDitNpkTPj20HE6cDQ
   nRJL0CNkkCwA4CMCdWk/dIuEEefQeQb5A4Xguu/O5rJ3meMXFG5aDfiL8
   gt5pPkLs5pbzHtFOgwdfRK3pn2i0s/ggTHtmdI0ISOgJ8wDHqiAVIHULG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="360992239"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="360992239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752249443"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752249443"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:41:41 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 09F43580D9B;
        Tue, 26 Sep 2023 09:41:37 -0700 (PDT)
Message-ID: <2259d20d-e418-6358-ee62-670263a1544b@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:41:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 25/25] perf pmu-events: Add event counter data for
 Tigerlake
Content-Language: en-US
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-26-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-26-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
>=20
> The added new fields are required in this new grouping method. Currentl=
y,
> the format of added fields are temporary for experiments.
>=20
> This platform is not tested yet.

Please does sanity test before posting the patch. I think it's better to
add a test case in the perf test for the new option.

Thanks,
Kan

>=20
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../pmu-events/arch/x86/tigerlake/cache.json  | 65 +++++++++++++
>  .../arch/x86/tigerlake/counter.json           |  7 ++
>  .../arch/x86/tigerlake/floating-point.json    | 13 +++
>  .../arch/x86/tigerlake/frontend.json          | 56 +++++++++++
>  .../pmu-events/arch/x86/tigerlake/memory.json | 31 ++++++
>  .../pmu-events/arch/x86/tigerlake/other.json  |  4 +
>  .../arch/x86/tigerlake/pipeline.json          | 96 +++++++++++++++++++=

>  .../x86/tigerlake/uncore-interconnect.json    | 11 +++
>  .../arch/x86/tigerlake/uncore-memory.json     |  6 ++
>  .../arch/x86/tigerlake/uncore-other.json      |  1 +
>  .../arch/x86/tigerlake/virtual-memory.json    | 20 ++++
>  11 files changed, 310 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.js=
on
>=20
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/tool=
s/perf/pmu-events/arch/x86/tigerlake/cache.json
> index c54fb65d3..1b50e92d7 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Counts the number of cache lines replaced=
 in L1 data cache.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x51",
>          "EventName": "L1D.REPLACEMENT",
>          "PublicDescription": "Counts L1D data line replacements includ=
ing opportunistic replacements, and replacements that require stall-for-r=
eplace or block-for-replace.",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Number of cycles a demand request has wai=
ted due to L1D Fill Buffer (FB) unavailability.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x48",
>          "EventName": "L1D_PEND_MISS.FB_FULL",
>          "PublicDescription": "Counts number of cycles a demand request=
 has waited due to L1D Fill Buffer (FB) unavailability. Demand requests i=
nclude cacheable/uncacheable demand load, store, lock or SW prefetch acce=
sses.",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Number of phases a demand request has wai=
ted due to L1D Fill Buffer (FB) unavailability.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0x48",
> @@ -27,6 +30,7 @@
>      },
>      {
>          "BriefDescription": "Number of cycles a demand request has wai=
ted due to L1D due to lack of L2 resources.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x48",
>          "EventName": "L1D_PEND_MISS.L2_STALL",
>          "PublicDescription": "Counts number of cycles a demand request=
 has waited due to L1D due to lack of L2 resources. Demand requests inclu=
de cacheable/uncacheable demand load, store, lock or SW prefetch accesses=
=2E",
> @@ -35,6 +39,7 @@
>      },
>      {
>          "BriefDescription": "Number of L1D misses that are outstanding=
",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x48",
>          "EventName": "L1D_PEND_MISS.PENDING",
>          "PublicDescription": "Counts number of L1D misses that are out=
standing in each cycle, that is each cycle the number of Fill Buffers (FB=
) outstanding required by Demand Reads. FB either is held by demand loads=
, or it is held by non-demand loads and gets hit at least once by demand.=
 The valid outstanding interval is defined until the FB deallocation by o=
ne of the following ways: from FB allocation, if FB is allocated by deman=
d from the demand Hit FB, if it is allocated by hardware or software pref=
etch. Note: In the L1D, a Demand Read contains cacheable or noncacheable =
demand loads, including ones causing cache-line splits and reads due to p=
age walks resulted from any request type.",
> @@ -43,6 +48,7 @@
>      },
>      {
>          "BriefDescription": "Cycles with L1D load Misses outstanding."=
,
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x48",
>          "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
> @@ -52,6 +58,7 @@
>      },
>      {
>          "BriefDescription": "L2 cache lines filling L2",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf1",
>          "EventName": "L2_LINES_IN.ALL",
>          "PublicDescription": "Counts the number of L2 cache lines fill=
ing the L2. Counting does not cover rejects.",
> @@ -60,6 +67,7 @@
>      },
>      {
>          "BriefDescription": "Modified cache lines that are evicted by =
L2 cache when triggered by an L2 cache fill.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf2",
>          "EventName": "L2_LINES_OUT.NON_SILENT",
>          "PublicDescription": "Counts the number of lines that are evic=
ted by L2 cache when triggered by an L2 cache fill. Those lines are in Mo=
dified state. Modified lines are written back to L3",
> @@ -68,6 +76,7 @@
>      },
>      {
>          "BriefDescription": "Non-modified cache lines that are silentl=
y dropped by L2 cache when triggered by an L2 cache fill.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf2",
>          "EventName": "L2_LINES_OUT.SILENT",
>          "PublicDescription": "Counts the number of lines that are sile=
ntly dropped by L2 cache when triggered by an L2 cache fill. These lines =
are typically in Shared or Exclusive state. A non-threaded event.",
> @@ -76,6 +85,7 @@
>      },
>      {
>          "BriefDescription": "L2 code requests",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.ALL_CODE_RD",
>          "PublicDescription": "Counts the total number of L2 code reque=
sts.",
> @@ -84,6 +94,7 @@
>      },
>      {
>          "BriefDescription": "Demand Data Read access L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
>          "PublicDescription": "Counts Demand Data Read requests accessi=
ng the L2 cache. These requests may hit or miss L2 cache. True-miss exclu=
de misses that were merged with ongoing L2 misses. An access is counted o=
nce.",
> @@ -92,6 +103,7 @@
>      },
>      {
>          "BriefDescription": "RFO requests to L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.ALL_RFO",
>          "PublicDescription": "Counts the total number of RFO (read for=
 ownership) requests to L2 cache. L2 RFO requests include both L1D demand=
 RFO misses as well as L1D RFO prefetches.",
> @@ -100,6 +112,7 @@
>      },
>      {
>          "BriefDescription": "L2 cache hits when fetching instructions,=
 code reads.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.CODE_RD_HIT",
>          "PublicDescription": "Counts L2 cache hits when fetching instr=
uctions, code reads.",
> @@ -108,6 +121,7 @@
>      },
>      {
>          "BriefDescription": "L2 cache misses when fetching instruction=
s",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.CODE_RD_MISS",
>          "PublicDescription": "Counts L2 cache misses when fetching ins=
tructions.",
> @@ -116,6 +130,7 @@
>      },
>      {
>          "BriefDescription": "Demand Data Read requests that hit L2 cac=
he",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
>          "PublicDescription": "Counts the number of demand Data Read re=
quests initiated by load instructions that hit L2 cache.",
> @@ -124,6 +139,7 @@
>      },
>      {
>          "BriefDescription": "Demand Data Read miss L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
>          "PublicDescription": "Counts demand Data Read requests with tr=
ue-miss in the L2 cache. True-miss excludes misses that were merged with =
ongoing L2 misses. An access is counted once.",
> @@ -132,6 +148,7 @@
>      },
>      {
>          "BriefDescription": "Read requests with true-miss in L2 cache"=
,
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.MISS",
>          "PublicDescription": "Counts read requests of any type with tr=
ue-miss in the L2 cache. True-miss excludes L2 misses that were merged wi=
th ongoing L2 misses.",
> @@ -140,6 +157,7 @@
>      },
>      {
>          "BriefDescription": "All accesses to L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.REFERENCES",
>          "PublicDescription": "Counts all requests that were hit or tru=
e misses in L2 cache. True-miss excludes misses that were merged with ong=
oing L2 misses.",
> @@ -148,6 +166,7 @@
>      },
>      {
>          "BriefDescription": "RFO requests that hit L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.RFO_HIT",
>          "PublicDescription": "Counts the RFO (Read-for-Ownership) requ=
ests that hit L2 cache.",
> @@ -156,6 +175,7 @@
>      },
>      {
>          "BriefDescription": "RFO requests that miss L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.RFO_MISS",
>          "PublicDescription": "Counts the RFO (Read-for-Ownership) requ=
ests that miss L2 cache.",
> @@ -164,6 +184,7 @@
>      },
>      {
>          "BriefDescription": "SW prefetch requests that hit L2 cache.",=

> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.SWPF_HIT",
>          "PublicDescription": "Counts Software prefetch requests that h=
it the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions=
 when FB is not full.",
> @@ -172,6 +193,7 @@
>      },
>      {
>          "BriefDescription": "SW prefetch requests that miss L2 cache."=
,
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x24",
>          "EventName": "L2_RQSTS.SWPF_MISS",
>          "PublicDescription": "Counts Software prefetch requests that m=
iss the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instruction=
s when FB is not full.",
> @@ -180,6 +202,7 @@
>      },
>      {
>          "BriefDescription": "L2 writebacks that access L2 cache",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf0",
>          "EventName": "L2_TRANS.L2_WB",
>          "PublicDescription": "Counts L2 writebacks that access L2 cach=
e.",
> @@ -188,6 +211,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when L1D is locked",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x63",
>          "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
>          "PublicDescription": "This event counts the number of cycles w=
hen the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.=
BUS_LOCK_DURATION).",
> @@ -196,6 +220,7 @@
>      },
>      {
>          "BriefDescription": "Core-originated cacheable requests that m=
issed L3  (Except hardware prefetches to the L3)",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x2e",
>          "EventName": "LONGEST_LAT_CACHE.MISS",
>          "PublicDescription": "Counts core-originated cacheable request=
s that miss the L3 cache (Longest Latency cache). Requests include data a=
nd code reads, Reads-for-Ownership (RFOs), speculative accesses and hardw=
are prefetches to the L1 and L2.  It does not include hardware prefetches=
 to the L3, and may not count other types of requests to the L3.",
> @@ -204,6 +229,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ALL_LOADS",
> @@ -214,6 +240,7 @@
>      },
>      {
>          "BriefDescription": "Retired store instructions.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ALL_STORES",
> @@ -224,6 +251,7 @@
>      },
>      {
>          "BriefDescription": "All retired memory instructions.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ANY",
> @@ -234,6 +262,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions with locked acc=
ess.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
> @@ -244,6 +273,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions that split acro=
ss a cacheline boundary.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
> @@ -254,6 +284,7 @@
>      },
>      {
>          "BriefDescription": "Retired store instructions that split acr=
oss a cacheline boundary.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
> @@ -264,6 +295,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions that miss the S=
TLB.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
> @@ -274,6 +306,7 @@
>      },
>      {
>          "BriefDescription": "Retired store instructions that miss the =
STLB.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
> @@ -284,6 +317,7 @@
>      },
>      {
>          "BriefDescription": "Snoop hit a modified(HITM) or clean line(=
HIT_W_FWD) in another on-pkg core which forwarded the data back due to a =
retired load instruction.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> @@ -294,6 +328,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions whose data sour=
ces were L3 hit and cross-core snoop missed in on-pkg core cache.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
> @@ -304,6 +339,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions whose data sour=
ces were hits in L3 without snoops required",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
> @@ -314,6 +350,7 @@
>      },
>      {
>          "BriefDescription": "Snoop hit without forwarding in another o=
n-pkg core due to a retired load instruction, data was supplied by the L3=
=2E",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> @@ -324,6 +361,7 @@
>      },
>      {
>          "BriefDescription": "Retired instructions with at least 1 unca=
cheable load or lock.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd4",
>          "EventName": "MEM_LOAD_MISC_RETIRED.UC",
> @@ -334,6 +372,7 @@
>      },
>      {
>          "BriefDescription": "Number of completed demand load requests =
that missed the L1, but hit the FB(fill buffer), because a preceding miss=
 to the same cacheline initiated the line to be brought into L1, but data=
 is not yet ready in L1.",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.FB_HIT",
> @@ -344,6 +383,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions with L1 cache h=
its as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L1_HIT",
> @@ -354,6 +394,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions missed L1 cache=
 as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L1_MISS",
> @@ -364,6 +405,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions with L2 cache h=
its as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L2_HIT",
> @@ -374,6 +416,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions missed L2 cache=
 as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L2_MISS",
> @@ -384,6 +427,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions with L3 cache h=
its as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L3_HIT",
> @@ -394,6 +438,7 @@
>      },
>      {
>          "BriefDescription": "Retired load instructions missed L3 cache=
 as data sources",
> +        "Counter": "0,1,2,3",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L3_MISS",
> @@ -404,6 +449,7 @@
>      },
>      {
>          "BriefDescription": "Counts demand data reads that hit a cache=
line in the L3 where a snoop hit in another cores caches, data forwarding=
 is required as the data is modified.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xB7, 0xBB",
>          "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -413,6 +459,7 @@
>      },
>      {
>          "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_=
FWD",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xB7, 0xBB",
>          "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -422,6 +469,7 @@
>      },
>      {
>          "BriefDescription": "Counts demand reads for ownership (RFO) r=
equests and software prefetches for exclusive ownership (PREFETCHW) that =
hit a cacheline in the L3 where a snoop hit in another cores caches, data=
 forwarding is required as the data is modified.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xB7, 0xBB",
>          "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -431,6 +479,7 @@
>      },
>      {
>          "BriefDescription": "Demand and prefetch data reads",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xb0",
>          "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
>          "PublicDescription": "Counts the demand and prefetch data read=
s. All Core Data Reads include cacheable 'Demands' and L2 prefetchers (no=
t L3 prefetchers). Counting also covers reads due to page walks resulted =
from any request type.",
> @@ -439,6 +488,7 @@
>      },
>      {
>          "BriefDescription": "Any memory transaction that reached the S=
Q.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xb0",
>          "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
>          "PublicDescription": "Counts memory transactions reached the s=
uper queue including requests initiated by the core, all L3 prefetches, p=
age walks, etc..",
> @@ -447,6 +497,7 @@
>      },
>      {
>          "BriefDescription": "Demand Data Read requests sent to uncore"=
,
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xb0",
>          "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
>          "PublicDescription": "Counts the Demand Data Read requests sen=
t to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to d=
etermine average latency in the uncore.",
> @@ -455,6 +506,7 @@
>      },
>      {
>          "BriefDescription": "Demand RFO requests including regular RFO=
s, locks, ItoM",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xb0",
>          "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
>          "PublicDescription": "Counts the demand RFO (read for ownershi=
p) requests including regular RFOs, locks, ItoM.",
> @@ -463,6 +515,7 @@
>      },
>      {
>          "BriefDescription": "Offcore outstanding cacheable Core Data R=
ead transactions in SuperQueue (SQ), queue to uncore",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
>          "PublicDescription": "Counts the number of offcore outstanding=
 cacheable Core Data Read transactions in the super queue every cycle. A =
transaction is considered to be in the Offcore outstanding state between =
L2 miss and transaction completion sent to requestor (SQ de-allocation). =
See corresponding Umask under OFFCORE_REQUESTS.",
> @@ -471,6 +524,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when offcore outstanding cacheable=
 Core Data Read transactions are present in SuperQueue (SQ), queue to unc=
ore.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD=
",
> @@ -480,6 +534,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when offcore outstanding Demand Da=
ta Read transactions are present in SuperQueue (SQ), queue to uncore",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_=
DATA_RD",
> @@ -489,6 +544,7 @@
>      },
>      {
>          "BriefDescription": "Cycles with offcore outstanding demand rf=
o reads transactions in SuperQueue (SQ), queue to uncore.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_=
RFO",
> @@ -498,6 +554,7 @@
>      },
>      {
>          "BriefDescription": "Demand Data Read transactions pending for=
 off-core. Highly correlated.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
>          "PublicDescription": "Counts the number of off-core outstandin=
g Demand Data Read transactions every cycle. A transaction is considered =
to be in the Off-core outstanding state between L2 cache miss and data-re=
turn to the core.",
> @@ -506,6 +563,7 @@
>      },
>      {
>          "BriefDescription": "Cycles with at least 6 offcore outstandin=
g Demand Data Read transactions in uncore queue.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "6",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6=
",
> @@ -514,6 +572,7 @@
>      },
>      {
>          "BriefDescription": "Store Read transactions pending for off-c=
ore. Highly correlated.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x60",
>          "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
>          "PublicDescription": "Counts the number of off-core outstandin=
g read-for-ownership (RFO) store transactions every cycle. An RFO transac=
tion is considered to be in the Off-core outstanding state between L2 cac=
he miss and transaction completion.",
> @@ -522,6 +581,7 @@
>      },
>      {
>          "BriefDescription": "Counts bus locks, accounts for cache line=
 split locks and UC locks.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf4",
>          "EventName": "SQ_MISC.BUS_LOCK",
>          "PublicDescription": "Counts the more expensive bus lock neede=
d to enforce cache coherency for certain memory accesses that need to be =
done atomically.  Can be created by issuing an atomic instruction (via th=
e LOCK prefix) which causes a cache line split or accesses uncacheable me=
mory.",
> @@ -530,6 +590,7 @@
>      },
>      {
>          "BriefDescription": "Cycles the superQ cannot take any more en=
tries.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xf4",
>          "EventName": "SQ_MISC.SQ_FULL",
>          "PublicDescription": "Counts the cycles for which the thread i=
s active and the superQ cannot take any more entries.",
> @@ -538,6 +599,7 @@
>      },
>      {
>          "BriefDescription": "Number of PREFETCHNTA instructions execut=
ed.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x32",
>          "EventName": "SW_PREFETCH_ACCESS.NTA",
>          "PublicDescription": "Counts the number of PREFETCHNTA instruc=
tions executed.",
> @@ -546,6 +608,7 @@
>      },
>      {
>          "BriefDescription": "Number of PREFETCHW instructions executed=
=2E",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x32",
>          "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
>          "PublicDescription": "Counts the number of PREFETCHW instructi=
ons executed.",
> @@ -554,6 +617,7 @@
>      },
>      {
>          "BriefDescription": "Number of PREFETCHT0 instructions execute=
d.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x32",
>          "EventName": "SW_PREFETCH_ACCESS.T0",
>          "PublicDescription": "Counts the number of PREFETCHT0 instruct=
ions executed.",
> @@ -562,6 +626,7 @@
>      },
>      {
>          "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instru=
ctions executed.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x32",
>          "EventName": "SW_PREFETCH_ACCESS.T1_T2",
>          "PublicDescription": "Counts the number of PREFETCHT1 or PREFE=
TCHT2 instructions executed.",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/counter.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/counter.json
> new file mode 100644
> index 000000000..98fdc5892
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/counter.json
> @@ -0,0 +1,7 @@
> +[
> +  {
> +      "Unit": "Core",
> +      "Size": "8",
> +      "FixedSize": "4"
> +  }
> +]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
> index 63b5b56d1..0b04972d0 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Counts all microcode FP assists.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc1",
>          "EventName": "ASSISTS.FP",
>          "PublicDescription": "Counts all microcode Floating Point assi=
sts.",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational 12=
8-bit packed double precision floating-point instructions retired; some i=
nstructions will count twice as noted below.  Each count represents 2 com=
putation operations, one for each element.  Applies to SSE* and AVX* pack=
ed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD=
 MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instruction=
s count twice as they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
>          "PublicDescription": "Number of SSE/AVX computational 128-bit =
packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL D=
IV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions coun=
t twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Number of SSE/AVX computational 128-bit p=
acked single precision floating-point instructions retired; some instruct=
ions will count twice as noted below.  Each count represents 4 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed sing=
le precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 R=
SQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
>          "PublicDescription": "Number of SSE/AVX computational 128-bit =
packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed sin=
gle precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL D=
IV MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instruc=
tions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events."=
,
> @@ -25,6 +28,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational 25=
6-bit packed double precision floating-point instructions retired; some i=
nstructions will count twice as noted below.  Each count represents 4 com=
putation operations, one for each element.  Applies to SSE* and AVX* pack=
ed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD=
 MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twic=
e as they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
>          "PublicDescription": "Number of SSE/AVX computational 256-bit =
packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL D=
IV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as t=
hey perform 2 calculations per element. The DAZ and FTZ flags in the MXCS=
R register need to be set when using these events.",
> @@ -33,6 +37,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational 25=
6-bit packed single precision floating-point instructions retired; some i=
nstructions will count twice as noted below.  Each count represents 8 com=
putation operations, one for each element.  Applies to SSE* and AVX* pack=
ed single precision floating-point instructions: ADD SUB HADD HSUB SUBADD=
 MUL DIV MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB i=
nstructions count twice as they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
>          "PublicDescription": "Number of SSE/AVX computational 256-bit =
packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed sin=
gle precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL D=
IV MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instruc=
tions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events."=
,
> @@ -41,6 +46,7 @@
>      },
>      {
>          "BriefDescription": "Number of SSE/AVX computational 128-bit p=
acked single and 256-bit packed double precision FP instructions retired;=
 some instructions will count twice as noted below.  Each count represent=
s 2 or/and 4 computation operations, 1 for each element.  Applies to SSE*=
 and AVX* packed single precision and packed double precision FP instruct=
ions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(=
N)ADD/SUB.  DPP and FM(N)ADD/SUB count twice as they perform 2 calculatio=
ns per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
>          "PublicDescription": "Number of SSE/AVX computational 128-bit =
packed single precision and 256-bit packed double precision  floating-poi=
nt instructions retired; some instructions will count twice as noted belo=
w.  Each count represents 2 or/and 4 computation operations, one for each=
 element.  Applies to SSE* and AVX* packed single precision floating-poin=
t and packed double precision floating-point instructions: ADD SUB HADD H=
SUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and =
FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element. The DAZ and FTZ flags in the MXCSR register need to be set when =
using these events.",
> @@ -49,6 +55,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational 51=
2-bit packed double precision floating-point instructions retired; some i=
nstructions will count twice as noted below.  Each count represents 8 com=
putation operations, one for each element.  Applies to SSE* and AVX* pack=
ed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX =
SQRT RSQRT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as=
 they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
>          "PublicDescription": "Number of SSE/AVX computational 512-bit =
packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computati=
on operations, one for each element.  Applies to SSE* and AVX* packed dou=
ble precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT R=
SQRT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they =
perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
> @@ -57,6 +64,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational 51=
2-bit packed single precision floating-point instructions retired; some i=
nstructions will count twice as noted below.  Each count represents 16 co=
mputation operations, one for each element.  Applies to SSE* and AVX* pac=
ked single precision floating-point instructions: ADD SUB MUL DIV MIN MAX=
 SQRT RSQRT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice a=
s they perform 2 calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
>          "PublicDescription": "Number of SSE/AVX computational 512-bit =
packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computat=
ion operations, one for each element.  Applies to SSE* and AVX* packed si=
ngle precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT =
RSQRT14 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they=
 perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR r=
egister need to be set when using these events.",
> @@ -65,6 +73,7 @@
>      },
>      {
>          "BriefDescription": "Number of SSE/AVX computational 256-bit p=
acked single precision and 512-bit packed double precision  FP instructio=
ns retired; some instructions will count twice as noted below.  Each coun=
t represents 8 computation operations, 1 for each element.  Applies to SS=
E* and AVX* packed single precision and double precision FP instructions:=
 ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DP=
P FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB count twice as they perform 2 calcu=
lations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
>          "PublicDescription": "Number of SSE/AVX computational 256-bit =
packed single precision and 512-bit packed double precision  floating-poi=
nt instructions retired; some instructions will count twice as noted belo=
w.  Each count represents 8 computation operations, one for each element.=
  Applies to SSE* and AVX* packed single precision and double precision f=
loating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT=
 RSQRT RSQRT14 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instruct=
ions count twice as they perform 2 calculations per element. The DAZ and =
FTZ flags in the MXCSR register need to be set when using these events.",=

> @@ -73,6 +82,7 @@
>      },
>      {
>          "BriefDescription": "Number of SSE/AVX computational scalar fl=
oating-point instructions retired; some instructions will count twice as =
noted below.  Applies to SSE* and AVX* scalar, double and single precisio=
n floating-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM=
(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perfor=
m multiple calculations per element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
>          "PublicDescription": "Number of SSE/AVX computational scalar s=
ingle precision and double precision floating-point instructions retired;=
 some instructions will count twice as noted below.  Each count represent=
s 1 computational operation. Applies to SSE* and AVX* scalar single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP =
FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 ca=
lculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
> @@ -81,6 +91,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational sc=
alar double precision floating-point instructions retired; some instructi=
ons will count twice as noted below.  Each count represents 1 computation=
al operation. Applies to SSE* and AVX* scalar double precision floating-p=
oint instructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/S=
UB instructions count twice as they perform 2 calculations per element.",=

> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
>          "PublicDescription": "Number of SSE/AVX computational scalar d=
ouble precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SSE* and AVX* scalar double precision floating-point i=
nstructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ=
 and FTZ flags in the MXCSR register need to be set when using these even=
ts.",
> @@ -89,6 +100,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of SSE/AVX computational sc=
alar single precision floating-point instructions retired; some instructi=
ons will count twice as noted below.  Each count represents 1 computation=
al operation. Applies to SSE* and AVX* scalar single precision floating-p=
oint instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  =
FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
>          "PublicDescription": "Number of SSE/AVX computational scalar s=
ingle precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational ope=
ration. Applies to SSE* and AVX* scalar single precision floating-point i=
nstructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)A=
DD/SUB instructions count twice as they perform 2 calculations per elemen=
t. The DAZ and FTZ flags in the MXCSR register need to be set when using =
these events.",
> @@ -97,6 +109,7 @@
>      },
>      {
>          "BriefDescription": "Number of any Vector retired FP arithmeti=
c instructions",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc7",
>          "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
>          "SampleAfterValue": "1000003",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json b/t=
ools/perf/pmu-events/arch/x86/tigerlake/frontend.json
> index d7b972452..bba638c5e 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Counts the total number when the front en=
d is resteered, mainly when the BPU cannot provide a correct prediction a=
nd this is corrected by other branch handling mechanisms at the front end=
=2E",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xe6",
>          "EventName": "BACLEARS.ANY",
>          "PublicDescription": "Counts the number of times the front-end=
 is resteered when it finds a branch instruction in a fetch line. This oc=
curs for the first time a branch instruction is fetched or when the branc=
h is not tracked by the BPU (Branch Prediction Unit) anymore.",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Stalls caused by changing prefix length o=
f the instruction. [This event is alias to ILD_STALL.LCP]",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x87",
>          "EventName": "DECODE.LCP",
>          "PublicDescription": "Counts cycles that the Instruction Lengt=
h decoder (ILD) stalls occurred due to dynamically changing prefix length=
 of the decoded instruction (by operand size prefix instruction 0x66, add=
ress size prefix instruction 0x67 or REX.W for Intel64). Count is proport=
ional to the number of prefixes in a 16B-line. This may result in a three=
-cycle penalty for each LCP (Length changing prefix) in a 16-byte chunk. =
[This event is alias to ILD_STALL.LCP]",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transi=
tions count.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0xab",
> @@ -27,6 +30,7 @@
>      },
>      {
>          "BriefDescription": "DSB-to-MITE switch true penalty cycles.",=

> +        "Counter": "0,1,2,3",
>          "EventCode": "0xab",
>          "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
>          "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cach=
e that holds translations of previously fetched instructions that were de=
coded by the legacy x86 decode pipeline (MITE). This event counts fetch p=
enalty cycles when a transition occurs from DSB to MITE.",
> @@ -35,6 +39,7 @@
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced DSB =
miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
>          "MSRIndex": "0x3F7",
> @@ -42,10 +47,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experie=
nced DSB (Decode stream buffer i.e. the decoded instruction-cache) miss."=
,
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced a cr=
itical DSB miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.DSB_MISS",
>          "MSRIndex": "0x3F7",
> @@ -53,10 +60,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Number of retired Instructions that expe=
rienced a critical DSB (Decode stream buffer i.e. the decoded instruction=
-cache) miss. Critical means stalls were exposed to the back-end as a res=
ult of the DSB miss.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced iTLB=
 true miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.ITLB_MISS",
>          "MSRIndex": "0x3F7",
> @@ -64,10 +73,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experie=
nced iTLB (Instruction TLB) true miss.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced Inst=
ruction L1 Cache true miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.L1I_MISS",
>          "MSRIndex": "0x3F7",
> @@ -75,10 +86,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions who experien=
ced Instruction L1 Cache true miss.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced Inst=
ruction L2 Cache true miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.L2_MISS",
>          "MSRIndex": "0x3F7",
> @@ -86,10 +99,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions who experien=
ced Instruction L2 Cache true miss.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions after front-end star=
vation of at least 1 cycle",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
>          "MSRIndex": "0x3F7",
> @@ -97,10 +112,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Retired instructions that are fetched af=
ter an interval where the front-end delivered no uops for a period of at =
least 1 cycle which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 128 =
cycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
>          "MSRIndex": "0x3F7",
> @@ -108,10 +125,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period=
 of 128 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 16 c=
ycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
>          "MSRIndex": "0x3F7",
> @@ -119,10 +138,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 16 cycles. Dur=
ing this period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions after front-end star=
vation of at least 2 cycles",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
>          "MSRIndex": "0x3F7",
> @@ -130,10 +151,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Retired instructions that are fetched af=
ter an interval where the front-end delivered no uops for a period of at =
least 2 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 256 =
cycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
>          "MSRIndex": "0x3F7",
> @@ -141,10 +164,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period=
 of 256 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end had at least 1 bubble-slot for a perio=
d of 2 cycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
>          "MSRIndex": "0x3F7",
> @@ -152,10 +177,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after the front-end had at least 1 bubble-slot for=
 a period of 2 cycles. A bubble-slot is an empty issue-pipeline slot whil=
e there was no RAT stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 32 c=
ycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
>          "MSRIndex": "0x3F7",
> @@ -163,10 +190,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 32 cycles. Dur=
ing this period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 4 cy=
cles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
>          "MSRIndex": "0x3F7",
> @@ -174,10 +203,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period=
 of 4 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 512 =
cycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
>          "MSRIndex": "0x3F7",
> @@ -185,10 +216,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period=
 of 512 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 64 c=
ycles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
>          "MSRIndex": "0x3F7",
> @@ -196,10 +229,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fet=
ched after an interval where the front-end delivered no uops for a period=
 of 64 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired instructions that are fetched aft=
er an interval where the front-end delivered no uops for a period of 8 cy=
cles which was not interrupted by a back-end stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
>          "MSRIndex": "0x3F7",
> @@ -207,10 +242,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are del=
ivered to the back-end after a front-end stall of at least 8 cycles. Duri=
ng this period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Retired Instructions who experienced STLB=
 (2nd level TLB) true miss.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc6",
>          "EventName": "FRONTEND_RETIRED.STLB_MISS",
>          "MSRIndex": "0x3F7",
> @@ -218,10 +255,12 @@
>          "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experie=
nced STLB (2nd level TLB) true miss.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache miss. [This event is alias to ICACHE_DATA.STALLS]=
",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x80",
>          "EventName": "ICACHE_16B.IFDATA_STALL",
>          "PublicDescription": "Counts cycles where a code line fetch is=
 stalled due to an L1 instruction cache miss. The legacy decode pipeline =
works at a 16 Byte granularity. [This event is alias to ICACHE_DATA.STALL=
S]",
> @@ -230,6 +269,7 @@
>      },
>      {
>          "BriefDescription": "Instruction fetch tag lookups that hit in=
 the instruction cache (L1I). Counts at 64-byte cache-line granularity.",=

> +        "Counter": "0,1,2,3",
>          "EventCode": "0x83",
>          "EventName": "ICACHE_64B.IFTAG_HIT",
>          "PublicDescription": "Counts instruction fetch tag lookups tha=
t hit in the instruction cache (L1I). Counts at 64-byte cache-line granul=
arity. Accounts for both cacheable and uncacheable accesses.",
> @@ -238,6 +278,7 @@
>      },
>      {
>          "BriefDescription": "Instruction fetch tag lookups that miss i=
n the instruction cache (L1I). Counts at 64-byte cache-line granularity."=
,
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x83",
>          "EventName": "ICACHE_64B.IFTAG_MISS",
>          "PublicDescription": "Counts instruction fetch tag lookups tha=
t miss in the instruction cache (L1I). Counts at 64-byte cache-line granu=
larity. Accounts for both cacheable and uncacheable accesses.",
> @@ -246,6 +287,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache tag miss. [This event is alias to ICACHE_TAG.STAL=
LS]",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x83",
>          "EventName": "ICACHE_64B.IFTAG_STALL",
>          "PublicDescription": "Counts cycles where a code fetch is stal=
led due to L1 instruction cache tag miss. [This event is alias to ICACHE_=
TAG.STALLS]",
> @@ -254,6 +296,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache miss. [This event is alias to ICACHE_16B.IFDATA_S=
TALL]",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x80",
>          "EventName": "ICACHE_DATA.STALLS",
>          "PublicDescription": "Counts cycles where a code line fetch is=
 stalled due to an L1 instruction cache miss. The legacy decode pipeline =
works at a 16 Byte granularity. [This event is alias to ICACHE_16B.IFDATA=
_STALL]",
> @@ -262,6 +305,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where a code fetch is stalled due =
to L1 instruction cache tag miss. [This event is alias to ICACHE_64B.IFTA=
G_STALL]",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x83",
>          "EventName": "ICACHE_TAG.STALLS",
>          "PublicDescription": "Counts cycles where a code fetch is stal=
led due to L1 instruction cache tag miss. [This event is alias to ICACHE_=
64B.IFTAG_STALL]",
> @@ -270,6 +314,7 @@
>      },
>      {
>          "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deli=
vering any Uop",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x79",
>          "EventName": "IDQ.DSB_CYCLES_ANY",
> @@ -279,6 +324,7 @@
>      },
>      {
>          "BriefDescription": "Cycles DSB is delivering optimal number o=
f Uops",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "5",
>          "EventCode": "0x79",
>          "EventName": "IDQ.DSB_CYCLES_OK",
> @@ -288,6 +334,7 @@
>      },
>      {
>          "BriefDescription": "Uops delivered to Instruction Decode Queu=
e (IDQ) from the Decode Stream Buffer (DSB) path",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x79",
>          "EventName": "IDQ.DSB_UOPS",
>          "PublicDescription": "Counts the number of uops delivered to I=
nstruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",=

> @@ -296,6 +343,7 @@
>      },
>      {
>          "BriefDescription": "Cycles MITE is delivering any Uop",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MITE_CYCLES_ANY",
> @@ -305,6 +353,7 @@
>      },
>      {
>          "BriefDescription": "Cycles MITE is delivering optimal number =
of Uops",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "5",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MITE_CYCLES_OK",
> @@ -314,6 +363,7 @@
>      },
>      {
>          "BriefDescription": "Uops delivered to Instruction Decode Queu=
e (IDQ) from MITE path",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MITE_UOPS",
>          "PublicDescription": "Counts the number of uops delivered to I=
nstruction Decode Queue (IDQ) from the MITE path. This also means that uo=
ps are not being delivered from the Decode Stream Buffer (DSB).",
> @@ -322,6 +372,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when uops are being delivered to I=
DQ while MS is busy",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MS_CYCLES_ANY",
> @@ -331,6 +382,7 @@
>      },
>      {
>          "BriefDescription": "Number of switches from DSB or MITE to th=
e MS",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0x79",
> @@ -341,6 +393,7 @@
>      },
>      {
>          "BriefDescription": "Uops delivered to IDQ while MS is busy",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x79",
>          "EventName": "IDQ.MS_UOPS",
>          "PublicDescription": "Counts the total number of uops delivere=
d by the Microcode Sequencer (MS). Any instruction over 4 uops will be de=
livered by the MS. Some instructions such as transcendentals may addition=
ally generate uops from the MS.",
> @@ -349,6 +402,7 @@
>      },
>      {
>          "BriefDescription": "Uops not delivered by IDQ when backend of=
 the machine is not stalled",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
>          "PublicDescription": "Counts the number of uops not delivered =
to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline =
when there was no back-end stalls. This event counts for one SMT thread i=
n a given cycle.",
> @@ -357,6 +411,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when no uops are not delivered by =
the IDQ when backend of the machine is not stalled",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "5",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE"=
,
> @@ -366,6 +421,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when optimal number of uops was de=
livered to the back-end when the back-end is not stalled",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/memory.json b/too=
ls/perf/pmu-events/arch/x86/tigerlake/memory.json
> index 8848fcbcc..b8ef8abb3 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/memory.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Execution stalls while L3 cache miss dema=
nd load is outstanding.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "6",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Number of machine clears due to memory or=
dering conflicts.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc3",
>          "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
>          "PublicDescription": "Counts the number of Machine Clears dete=
cted dye to memory ordering. Memory Ordering Machine Clears may apply whe=
n a memory read may not conform to the memory ordering rules of the x86 a=
rchitecture",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 128 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
> @@ -25,10 +28,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 128 cycles.  Re=
ported latency may be longer than just the memory latency.",
>          "SampleAfterValue": "1009",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 16 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
> @@ -37,10 +42,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 16 cycles.  Rep=
orted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "20011",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 256 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
> @@ -49,10 +56,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 256 cycles.  Re=
ported latency may be longer than just the memory latency.",
>          "SampleAfterValue": "503",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 32 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
> @@ -61,10 +70,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 32 cycles.  Rep=
orted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "100007",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 4 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
> @@ -73,10 +84,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 4 cycles.  Repo=
rted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "100003",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 512 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
> @@ -85,10 +98,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 512 cycles.  Re=
ported latency may be longer than just the memory latency.",
>          "SampleAfterValue": "101",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 64 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
> @@ -97,10 +112,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 64 cycles.  Rep=
orted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "2003",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 8 cycles.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
> @@ -109,10 +126,12 @@
>          "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 8 cycles.  Repo=
rted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "50021",
> +        "TakenAlone": "1",
>          "UMask": "0x1"
>      },
>      {
>          "BriefDescription": "Demand Data Read requests who miss L3 cac=
he",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xb0",
>          "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
>          "PublicDescription": "Demand Data Read requests who miss L3 ca=
che.",
> @@ -121,6 +140,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution aborted.=
",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.ABORTED",
>          "PublicDescription": "Counts the number of times RTM abort was=
 triggered.",
> @@ -129,6 +149,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution aborted =
due to none of the previous 4 categories (e.g. interrupt)",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.ABORTED_EVENTS",
>          "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to none of the previous 4 categories (e.g. interrupt).",
> @@ -137,6 +158,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution aborted =
due to various memory events (e.g. read/write capacity and conflicts)",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.ABORTED_MEM",
>          "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to various memory events (e.g. read/write capacity and co=
nflicts).",
> @@ -145,6 +167,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution aborted =
due to incompatible memory type",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
>          "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to incompatible memory type.",
> @@ -153,6 +176,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution aborted =
due to HLE-unfriendly instructions",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
>          "PublicDescription": "Counts the number of times an RTM execut=
ion aborted due to HLE-unfriendly instructions.",
> @@ -161,6 +185,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution successf=
ully committed",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.COMMIT",
>          "PublicDescription": "Counts the number of times RTM commit su=
cceeded.",
> @@ -169,6 +194,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an RTM execution started.=
",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc9",
>          "EventName": "RTM_RETIRED.START",
>          "PublicDescription": "Counts the number of times we entered an=
 RTM region. Does not count nested transactions.",
> @@ -177,6 +203,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of times a class of ins=
tructions that may cause a transactional abort was executed inside a tran=
sactional region",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x5d",
>          "EventName": "TX_EXEC.MISC2",
>          "PublicDescription": "Counts Unfriendly TSX abort triggered by=
 a vzeroupper instruction.",
> @@ -185,6 +212,7 @@
>      },
>      {
>          "BriefDescription": "Number of times an instruction execution =
caused the transactional nest count supported to be exceeded",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x5d",
>          "EventName": "TX_EXEC.MISC3",
>          "PublicDescription": "Counts Unfriendly TSX abort triggered by=
 a nest count that is too deep.",
> @@ -193,6 +221,7 @@
>      },
>      {
>          "BriefDescription": "Speculatively counts the number of TSX ab=
orts due to a data capacity limitation for transactional reads",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x54",
>          "EventName": "TX_MEM.ABORT_CAPACITY_READ",
>          "PublicDescription": "Speculatively counts the number of Trans=
actional Synchronization Extensions (TSX) aborts due to a data capacity l=
imitation for transactional reads",
> @@ -201,6 +230,7 @@
>      },
>      {
>          "BriefDescription": "Speculatively counts the number of TSX ab=
orts due to a data capacity limitation for transactional writes.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x54",
>          "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
>          "PublicDescription": "Speculatively counts the number of Trans=
actional Synchronization Extensions (TSX) aborts due to a data capacity l=
imitation for transactional writes.",
> @@ -209,6 +239,7 @@
>      },
>      {
>          "BriefDescription": "Number of times a transactional abort was=
 signaled due to a data conflict on a transactionally accessed address",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x54",
>          "EventName": "TX_MEM.ABORT_CONFLICT",
>          "PublicDescription": "Counts the number of times a TSX line ha=
d a cache conflict.",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tool=
s/perf/pmu-events/arch/x86/tigerlake/other.json
> index 55f3048bc..77ba139cd 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x28",
>          "EventName": "CORE_POWER.LVL0_TURBO_LICENSE",
>          "PublicDescription": "Counts Core cycles where the core was ru=
nning with power-delivery for baseline license level 0.  This includes no=
n-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes.",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the AVX2 turbo schedule.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x28",
>          "EventName": "CORE_POWER.LVL1_TURBO_LICENSE",
>          "PublicDescription": "Counts Core cycles where the core was ru=
nning with power-delivery for license level 1.  This includes high curren=
t AVX 256-bit instructions as well as low current AVX 512-bit instruction=
s.",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles where the core was running in=
 a manner where Turbo may be clipped to the AVX512 turbo schedule.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x28",
>          "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
>          "PublicDescription": "Core cycles where the core was running w=
ith power-delivery for license level 2 (introduced in Skylake Server micr=
oarchtecture).  This includes high current AVX 512-bit instructions.",
> @@ -25,6 +28,7 @@
>      },
>      {
>          "BriefDescription": "Counts streaming stores that have any typ=
e of response.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xB7, 0xBB",
>          "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
>          "MSRIndex": "0x1a6,0x1a7",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> index 541bf1dd1..3fd22fc0a 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Cycles when divide unit is busy executing=
 divide or square root operations.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0x14",
>          "EventName": "ARITH.DIVIDER_ACTIVE",
> @@ -10,6 +11,7 @@
>      },
>      {
>          "BriefDescription": "Number of occurrences where a microcode a=
ssist is invoked by hardware.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc1",
>          "EventName": "ASSISTS.ANY",
>          "PublicDescription": "Counts the number of occurrences where a=
 microcode assist is invoked by hardware Examples include AD (page Access=
 Dirty), FP and AVX related assists.",
> @@ -18,6 +20,7 @@
>      },
>      {
>          "BriefDescription": "All branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
>          "PEBS": "1",
> @@ -26,6 +29,7 @@
>      },
>      {
>          "BriefDescription": "Conditional branch instructions retired."=
,
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND",
>          "PEBS": "1",
> @@ -35,6 +39,7 @@
>      },
>      {
>          "BriefDescription": "Not taken branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND_NTAKEN",
>          "PEBS": "1",
> @@ -44,6 +49,7 @@
>      },
>      {
>          "BriefDescription": "Taken conditional branch instructions ret=
ired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND_TAKEN",
>          "PEBS": "1",
> @@ -53,6 +59,7 @@
>      },
>      {
>          "BriefDescription": "Far branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.FAR_BRANCH",
>          "PEBS": "1",
> @@ -62,6 +69,7 @@
>      },
>      {
>          "BriefDescription": "Indirect near branch instructions retired=
 (excluding returns)",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.INDIRECT",
>          "PEBS": "1",
> @@ -71,6 +79,7 @@
>      },
>      {
>          "BriefDescription": "Direct and indirect near call instruction=
s retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_CALL",
>          "PEBS": "1",
> @@ -80,6 +89,7 @@
>      },
>      {
>          "BriefDescription": "Return instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_RETURN",
>          "PEBS": "1",
> @@ -89,6 +99,7 @@
>      },
>      {
>          "BriefDescription": "Taken branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
>          "PEBS": "1",
> @@ -98,6 +109,7 @@
>      },
>      {
>          "BriefDescription": "All mispredicted branch instructions reti=
red.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
>          "PEBS": "1",
> @@ -106,6 +118,7 @@
>      },
>      {
>          "BriefDescription": "Mispredicted conditional branch instructi=
ons retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND",
>          "PEBS": "1",
> @@ -115,6 +128,7 @@
>      },
>      {
>          "BriefDescription": "Mispredicted non-taken conditional branch=
 instructions retired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
>          "PEBS": "1",
> @@ -124,6 +138,7 @@
>      },
>      {
>          "BriefDescription": "number of branch instructions retired tha=
t were mispredicted and taken.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND_TAKEN",
>          "PEBS": "1",
> @@ -133,6 +148,7 @@
>      },
>      {
>          "BriefDescription": "All miss-predicted indirect branch instru=
ctions retired (excluding RETs. TSX aborts is considered indirect branch)=
=2E",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT",
>          "PEBS": "1",
> @@ -142,6 +158,7 @@
>      },
>      {
>          "BriefDescription": "Mispredicted indirect CALL instructions r=
etired.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
>          "PEBS": "1",
> @@ -151,6 +168,7 @@
>      },
>      {
>          "BriefDescription": "Number of near branch instructions retire=
d that were mispredicted and taken.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
>          "PEBS": "1",
> @@ -160,6 +178,7 @@
>      },
>      {
>          "BriefDescription": "This event counts the number of mispredic=
ted ret instructions retired. Non PEBS",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.RET",
>          "PEBS": "1",
> @@ -169,6 +188,7 @@
>      },
>      {
>          "BriefDescription": "Cycle counts are evenly distributed betwe=
en active threads in the Core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xec",
>          "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
>          "PublicDescription": "This event distributes cycle counts betw=
een active hyperthreads, i.e., those in C0.  A hyperthread becomes inacti=
ve when it executes the HLT or MWAIT instructions.  If all other hyperthr=
eads are inactive (or disabled or do not exist), all counts are attribute=
d to this hyperthread. To obtain the full count when the Core is active, =
sum the counts from each hyperthread.",
> @@ -177,6 +197,7 @@
>      },
>      {
>          "BriefDescription": "Core crystal clock cycles when this threa=
d is unhalted and the other thread is halted.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
>          "PublicDescription": "Counts Core crystal clock cycles when cu=
rrent thread is unhalted and the other thread is halted.",
> @@ -185,6 +206,7 @@
>      },
>      {
>          "BriefDescription": "Core crystal clock cycles. Cycle counts a=
re evenly distributed between active threads in the Core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
>          "PublicDescription": "This event distributes Core crystal cloc=
k cycle counts between active hyperthreads, i.e., those in C0 sleep-state=
=2E A hyperthread becomes inactive when it executes the HLT or MWAIT inst=
ructions. If one thread is active in a core, all counts are attributed to=
 this hyperthread. To obtain the full count when the Core is active, sum =
the counts from each hyperthread.",
> @@ -193,6 +215,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in =
halt state.",
> +        "Counter": "Fixed counter 2",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles wh=
en the core is not in a halt state. The core enters the halt state when i=
t is running the HLT instruction or the MWAIT instruction. This event is =
not affected by core frequency changes (for example, P states, TM2 transi=
tions) but has the same incrementing frequency as the time stamp counter.=
 This event can approximate elapsed time while the core was not in a halt=
 state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCL=
K event. It is counted on a dedicated fixed counter, leaving the eight pr=
ogrammable counters available for other events. Note: On all current plat=
forms this event stops counting during 'throttling (TM)' states duty off =
periods the processor is 'halted'.  The counter update is done at a lower=
 clock rate then the core clock the overflow status bit for this counter =
may appear 'sticky'.  After the counter has overflowed and software clear=
s the overflow status bit and resets the counter to less than MAX. The re=
set value to the counter is not clocked immediately so the overflow statu=
s bit will flip 'high (1)' and generate another PMI (if enabled) after wh=
ich the reset value gets clocked into the counter. Therefore, software wi=
ll get the interrupt, read the overflow status bit '1 for bit 34 while th=
e counter value is less than MAX. Software should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -200,6 +223,7 @@
>      },
>      {
>          "BriefDescription": "Core crystal clock cycles when the thread=
 is unhalted.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
>          "PublicDescription": "Counts core crystal clock cycles when th=
e thread is unhalted.",
> @@ -208,6 +232,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in hal=
t state",
> +        "Counter": "Fixed counter 1",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while t=
he thread is not in a halt state. The thread enters the halt state when i=
t is running the HLT instruction. This event is a component in many key e=
vent ratios. The core frequency may change from time to time due to trans=
itions associated with Enhanced Intel SpeedStep Technology or TM2. For th=
is reason this event may have a changing ratio with regards to time. When=
 the core frequency is constant, this event can approximate elapsed time =
while the core was not in the halt state. It is counted on a dedicated fi=
xed counter, leaving the eight programmable counters available for other =
events.",
>          "SampleAfterValue": "2000003",
> @@ -215,6 +240,7 @@
>      },
>      {
>          "BriefDescription": "Thread cycles when thread is not in halt =
state",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_P",
>          "PublicDescription": "This is an architectural event that coun=
ts the number of thread cycles while the thread is not in a halt state. T=
he thread enters the halt state when it is running the HLT instruction. T=
he core frequency may change from time to time due to power or thermal th=
rottling. For this reason, this event may have a changing ratio with rega=
rds to wall clock time.",
> @@ -222,6 +248,7 @@
>      },
>      {
>          "BriefDescription": "Cycles while L1 cache miss demand load is=
 outstanding.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "8",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
> @@ -230,6 +257,7 @@
>      },
>      {
>          "BriefDescription": "Cycles while L2 cache miss demand load is=
 outstanding.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
> @@ -238,6 +266,7 @@
>      },
>      {
>          "BriefDescription": "Cycles while memory subsystem has an outs=
tanding load.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "16",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
> @@ -246,6 +275,7 @@
>      },
>      {
>          "BriefDescription": "Execution stalls while L1 cache miss dema=
nd load is outstanding.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "12",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
> @@ -254,6 +284,7 @@
>      },
>      {
>          "BriefDescription": "Execution stalls while L2 cache miss dema=
nd load is outstanding.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "5",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
> @@ -262,6 +293,7 @@
>      },
>      {
>          "BriefDescription": "Execution stalls while memory subsystem h=
as an outstanding load.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "20",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
> @@ -270,6 +302,7 @@
>      },
>      {
>          "BriefDescription": "Total execution stalls.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "4",
>          "EventCode": "0xa3",
>          "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
> @@ -278,6 +311,7 @@
>      },
>      {
>          "BriefDescription": "Cycles total of 1 uop is executed on all =
ports and Reservation Station was not empty.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
>          "PublicDescription": "Counts cycles during which a total of 1 =
uop was executed on all ports and Reservation Station (RS) was not empty.=
",
> @@ -286,6 +320,7 @@
>      },
>      {
>          "BriefDescription": "Cycles total of 2 uops are executed on al=
l ports and Reservation Station was not empty.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
>          "PublicDescription": "Counts cycles during which a total of 2 =
uops were executed on all ports and Reservation Station (RS) was not empt=
y.",
> @@ -294,6 +329,7 @@
>      },
>      {
>          "BriefDescription": "Cycles total of 3 uops are executed on al=
l ports and Reservation Station was not empty.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
>          "PublicDescription": "Cycles total of 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
> @@ -302,6 +338,7 @@
>      },
>      {
>          "BriefDescription": "Cycles total of 4 uops are executed on al=
l ports and Reservation Station was not empty.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
>          "PublicDescription": "Cycles total of 4 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
> @@ -310,6 +347,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when the memory subsystem has an o=
utstanding load. Increments by 4 for every such cycle.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "5",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
> @@ -319,6 +357,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where the Store Buffer was full an=
d no loads caused an execution stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "2",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
> @@ -328,6 +367,7 @@
>      },
>      {
>          "BriefDescription": "Cycles no uop executed while RS was not e=
mpty, the SB was not full and there was no outstanding load.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa6",
>          "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
>          "PublicDescription": "Number of cycles total of 0 uops execute=
d on all ports, Reservation Station (RS) was not empty, the Store Buffer =
(SB) was not full and there was no outstanding load.",
> @@ -336,6 +376,7 @@
>      },
>      {
>          "BriefDescription": "Stalls caused by changing prefix length o=
f the instruction. [This event is alias to DECODE.LCP]",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x87",
>          "EventName": "ILD_STALL.LCP",
>          "PublicDescription": "Counts cycles that the Instruction Lengt=
h decoder (ILD) stalls occurred due to dynamically changing prefix length=
 of the decoded instruction (by operand size prefix instruction 0x66, add=
ress size prefix instruction 0x67 or REX.W for Intel64). Count is proport=
ional to the number of prefixes in a 16B-line. This may result in a three=
-cycle penalty for each LCP (Length changing prefix) in a 16-byte chunk. =
[This event is alias to DECODE.LCP]",
> @@ -344,6 +385,7 @@
>      },
>      {
>          "BriefDescription": "Instruction decoders utilized in a cycle"=
,
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x55",
>          "EventName": "INST_DECODED.DECODERS",
>          "PublicDescription": "Number of decoders utilized in a cycle w=
hen the MITE (legacy decode pipeline) fetches instructions.",
> @@ -352,6 +394,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Cou=
nter - architectural event",
> +        "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions re=
tired - an Architectural PerfMon event. Counting continues during hardwar=
e interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.A=
NY is counted by a designated fixed counter freeing up programmable count=
ers to count other events. INST_RETIRED.ANY_P is counted by a programmabl=
e counter.",
> @@ -360,6 +403,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. General C=
ounter - architectural event",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.ANY_P",
>          "PEBS": "1",
> @@ -368,6 +412,7 @@
>      },
>      {
>          "BriefDescription": "Retired NOP instructions.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.NOP",
>          "PEBS": "1",
> @@ -377,6 +422,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired event with a =
reduced effect of PEBS shadow in IP distribution",
> +        "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows fo=
r a more unbiased distribution of samples across instructions retired. It=
 utilizes the Precise Distribution of Instructions Retired (PDIR) feature=
 to mitigate some bias in how retired instructions get sampled. Use on Fi=
xed Counter 0.",
> @@ -385,6 +431,7 @@
>      },
>      {
>          "BriefDescription": "Cycles the Backend cluster is recovering =
after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0x0d",
>          "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
> @@ -394,6 +441,7 @@
>      },
>      {
>          "BriefDescription": "Clears speculative count",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0x0d",
> @@ -404,6 +452,7 @@
>      },
>      {
>          "BriefDescription": "Counts cycles after recovery from a branc=
h misprediction or machine clear till the first uop is issued from the re=
steered path.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x0d",
>          "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
>          "PublicDescription": "Cycles after recovery from a branch misp=
rediction or machine clear till the first uop is issued from the resteere=
d path.",
> @@ -412,6 +461,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles the allocator was stalled due=
 to recovery from earlier clear event for this thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x0d",
>          "EventName": "INT_MISC.RECOVERY_CYCLES",
>          "PublicDescription": "Counts core cycles when the Resource all=
ocator was stalled due to recovery from an earlier branch misprediction o=
r machine clear event.",
> @@ -420,6 +470,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots where uops got dropped",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x0d",
>          "EventName": "INT_MISC.UOP_DROPPING",
>          "PublicDescription": "Estimated number of Top-down Microarchit=
ecture Analysis slots that got dropped due to non front-end reasons",
> @@ -428,6 +479,7 @@
>      },
>      {
>          "BriefDescription": "The number of times that split load opera=
tions are temporarily blocked because all resources for handling the spli=
t accesses are in use.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.NO_SR",
>          "PublicDescription": "Counts the number of times that split lo=
ad operations are temporarily blocked because all resources for handling =
the split accesses are in use.",
> @@ -436,6 +488,7 @@
>      },
>      {
>          "BriefDescription": "Loads blocked due to overlapping with a p=
receding store that cannot be forwarded.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.STORE_FORWARD",
>          "PublicDescription": "Counts the number of times where store f=
orwarding was prevented for a load operation. The most common case is a l=
oad blocked due to the address of memory access (partially) overlapping w=
ith a preceding uncompleted store. Note: See the table of not supported s=
tore forwards in the Optimization Guide.",
> @@ -444,6 +497,7 @@
>      },
>      {
>          "BriefDescription": "False dependencies in MOB due to partial =
compare on address.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x07",
>          "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
>          "PublicDescription": "Counts the number of times a load got bl=
ocked due to false dependencies in MOB due to partial compare on address.=
",
> @@ -452,6 +506,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of demand load dispatch=
es that hit L1D fill buffer (FB) allocated for software prefetch.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x4c",
>          "EventName": "LOAD_HIT_PREFETCH.SWPF",
>          "PublicDescription": "Counts all not software-prefetch load di=
spatches that hit the fill buffer (FB) allocated for the software prefetc=
h. It can also be incremented by some lock instructions. So it should onl=
y be used with profiling so that the locks can be excluded by ASM (Assemb=
ly File) inspection of the nearby instructions.",
> @@ -460,6 +515,7 @@
>      },
>      {
>          "BriefDescription": "Cycles Uops delivered by the LSD, but did=
n't come from the decoder.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0xa8",
>          "EventName": "LSD.CYCLES_ACTIVE",
> @@ -469,6 +525,7 @@
>      },
>      {
>          "BriefDescription": "Cycles optimal number of Uops delivered b=
y the LSD, but did not come from the decoder.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "5",
>          "EventCode": "0xa8",
>          "EventName": "LSD.CYCLES_OK",
> @@ -478,6 +535,7 @@
>      },
>      {
>          "BriefDescription": "Number of Uops delivered by the LSD.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xa8",
>          "EventName": "LSD.UOPS",
>          "PublicDescription": "Counts the number of uops delivered to t=
he back-end by the LSD(Loop Stream Detector).",
> @@ -486,6 +544,7 @@
>      },
>      {
>          "BriefDescription": "Number of machine clears (nukes) of any t=
ype.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0xc3",
> @@ -496,6 +555,7 @@
>      },
>      {
>          "BriefDescription": "Self-modifying code (SMC) detected.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc3",
>          "EventName": "MACHINE_CLEARS.SMC",
>          "PublicDescription": "Counts self-modifying code (SMC) detecte=
d, which causes a machine clear.",
> @@ -504,6 +564,7 @@
>      },
>      {
>          "BriefDescription": "Increments whenever there is an update to=
 the LBR array.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xcc",
>          "EventName": "MISC_RETIRED.LBR_INSERTS",
>          "PublicDescription": "Increments when an entry is added to the=
 Last Branch Record (LBR) array (or removed from the array in case of RET=
URNs in call stack mode). The event requires LBR enable via IA32_DEBUGCTL=
 MSR and branch type selection via MSR_LBR_SELECT.",
> @@ -512,6 +573,7 @@
>      },
>      {
>          "BriefDescription": "Number of retired PAUSE instructions. Thi=
s event is not supported on first SKL and KBL products.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xcc",
>          "EventName": "MISC_RETIRED.PAUSE_INST",
>          "PublicDescription": "Counts number of retired PAUSE instructi=
ons. This event is not supported on first SKL and KBL products.",
> @@ -520,6 +582,7 @@
>      },
>      {
>          "BriefDescription": "Cycles stalled due to no store buffers av=
ailable. (not including draining form sync).",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa2",
>          "EventName": "RESOURCE_STALLS.SB",
>          "PublicDescription": "Counts allocation stall cycles caused by=
 the store buffer (SB) being full. This counts cycles that the pipeline b=
ack-end blocked uop delivery from the front-end.",
> @@ -528,6 +591,7 @@
>      },
>      {
>          "BriefDescription": "Counts cycles where the pipeline is stall=
ed due to serializing operations.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa2",
>          "EventName": "RESOURCE_STALLS.SCOREBOARD",
>          "SampleAfterValue": "100003",
> @@ -535,6 +599,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when Reservation Station (RS) is e=
mpty for the thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x5e",
>          "EventName": "RS_EVENTS.EMPTY_CYCLES",
>          "PublicDescription": "Counts cycles during which the reservati=
on station (RS) is empty for this logical processor. This is usually caus=
ed when the front-end pipeline runs into stravation periods (e.g. branch =
mispredictions or i-cache misses)",
> @@ -543,6 +608,7 @@
>      },
>      {
>          "BriefDescription": "Counts end of periods where the Reservati=
on Station (RS) was empty.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EdgeDetect": "1",
>          "EventCode": "0x5e",
> @@ -554,6 +620,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots where no uops were being issued=
 due to lack of back-end resources.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa4",
>          "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
>          "PublicDescription": "Counts the number of Top-down Microarchi=
tecture Analysis (TMA) method's  slots where no micro-operations were bei=
ng issued from front-end to back-end of the machine due to lack of back-e=
nd resources.",
> @@ -562,6 +629,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots wasted due to incorrect specula=
tion by branch mispredictions",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa4",
>          "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
>          "PublicDescription": "Number of TMA slots that were wasted due=
 to incorrect speculation by branch mispredictions. This event estimates =
number of operations that were issued but not retired from the speculativ=
e path as well as the out-of-order engine recovery past a branch mispredi=
ction.",
> @@ -570,6 +638,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logic=
al processor. Fixed counter - architectural event",
> +        "Counter": "Fixed counter 3",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalte=
d logical processor. The event increments by machine-width of the narrowe=
st pipeline as employed by the Top-down Microarchitecture Analysis method=
 (TMA). The count is distributed among unhalted logical processors (hyper=
-threads) who share the same physical core. Software can use this event a=
s the denominator for the top-level metrics of the TMA method. This archi=
tectural event is counted on a designated fixed counter (Fixed Counter 3)=
=2E",
>          "SampleAfterValue": "10000003",
> @@ -577,6 +646,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logic=
al processor. General counter - architectural event",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa4",
>          "EventName": "TOPDOWN.SLOTS_P",
>          "PublicDescription": "Counts the number of available slots for=
 an unhalted logical processor. The event increments by machine-width of =
the narrowest pipeline as employed by the Top-down Microarchitecture Anal=
ysis method. The count is distributed among unhalted logical processors (=
hyper-threads) who share the same physical core.",
> @@ -585,6 +655,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops decoded out of instruction=
s exclusively fetched by decoder 0",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x56",
>          "EventName": "UOPS_DECODED.DEC0",
>          "PublicDescription": "Uops exclusively fetched by decoder 0",
> @@ -593,6 +664,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 0",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_0",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to port 0.",
> @@ -601,6 +673,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 1",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_1",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to port 1.",
> @@ -609,6 +682,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 2 and 3",=

> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_2_3",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to ports 2 and 3.",
> @@ -617,6 +691,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 4 and 9",=

> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_4_9",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to ports 5 and 9.",
> @@ -625,6 +700,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 5",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_5",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to port 5.",
> @@ -633,6 +709,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 6",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_6",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to port 6.",
> @@ -641,6 +718,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on port 7 and 8",=

> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xa1",
>          "EventName": "UOPS_DISPATCHED.PORT_7_8",
>          "PublicDescription": "Counts, on the per-thread basis, cycles =
during which at least one uop is dispatched from the Reservation Station =
(RS) to ports 7 and 8.",
> @@ -649,6 +727,7 @@
>      },
>      {
>          "BriefDescription": "Number of uops executed on the core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CORE",
>          "PublicDescription": "Counts the number of uops executed from =
any thread.",
> @@ -657,6 +736,7 @@
>      },
>      {
>          "BriefDescription": "Cycles at least 1 micro-op is executed fr=
om any thread on physical core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
> @@ -666,6 +746,7 @@
>      },
>      {
>          "BriefDescription": "Cycles at least 2 micro-op is executed fr=
om any thread on physical core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "2",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
> @@ -675,6 +756,7 @@
>      },
>      {
>          "BriefDescription": "Cycles at least 3 micro-op is executed fr=
om any thread on physical core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "3",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
> @@ -684,6 +766,7 @@
>      },
>      {
>          "BriefDescription": "Cycles at least 4 micro-op is executed fr=
om any thread on physical core.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "4",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
> @@ -693,6 +776,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where at least 1 uop was executed =
per-thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
> @@ -702,6 +786,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where at least 2 uops were execute=
d per-thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "2",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
> @@ -711,6 +796,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where at least 3 uops were execute=
d per-thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "3",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
> @@ -720,6 +806,7 @@
>      },
>      {
>          "BriefDescription": "Cycles where at least 4 uops were execute=
d per-thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "4",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
> @@ -729,6 +816,7 @@
>      },
>      {
>          "BriefDescription": "Counts number of cycles no uops were disp=
atched to be executed on this thread.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.STALL_CYCLES",
> @@ -739,6 +827,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of uops to be executed =
per-thread each cycle.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.THREAD",
>          "SampleAfterValue": "2000003",
> @@ -746,6 +835,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of x87 uops dispatched.=
",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xb1",
>          "EventName": "UOPS_EXECUTED.X87",
>          "PublicDescription": "Counts the number of x87 uops executed."=
,
> @@ -754,6 +844,7 @@
>      },
>      {
>          "BriefDescription": "Uops that RAT issues to RS",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x0e",
>          "EventName": "UOPS_ISSUED.ANY",
>          "PublicDescription": "Counts the number of uops that the Resou=
rce Allocation Table (RAT) issues to the Reservation Station (RS).",
> @@ -762,6 +853,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when RAT does not issue Uops to RS=
 for the thread",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0x0e",
>          "EventName": "UOPS_ISSUED.STALL_CYCLES",
> @@ -772,6 +864,7 @@
>      },
>      {
>          "BriefDescription": "Uops inserted at issue-stage in order to =
preserve upper bits of vector registers.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0x0e",
>          "EventName": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH",
>          "PublicDescription": "Counts the number of Blend Uops issued b=
y the Resource Allocation Table (RAT) to the reservation station (RS) in =
order to preserve upper bits of vector registers. Starting with the Skyla=
ke microarchitecture, these Blend uops are needed since every Intel SSE i=
nstruction executed in Dirty Upper State needs to preserve bits 128-255 o=
f the destination register. For more information, refer to Mixing Intel A=
VX and Intel SSE Code section of the Optimization Guide.",
> @@ -780,6 +873,7 @@
>      },
>      {
>          "BriefDescription": "Retirement slots used.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.SLOTS",
>          "PublicDescription": "Counts the retirement slots used each cy=
cle.",
> @@ -788,6 +882,7 @@
>      },
>      {
>          "BriefDescription": "Cycles without actually retired uops.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "1",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.STALL_CYCLES",
> @@ -798,6 +893,7 @@
>      },
>      {
>          "BriefDescription": "Cycles with less than 10 actually retired=
 uops.",
> +        "Counter": "0,1,2,3,4,5,6,7",
>          "CounterMask": "10",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.js=
on
> index eed1b90a2..28bb52268 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json=

> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json=

> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "UNC_ARB_COH_TRK_REQUESTS.ALL",
> +        "Counter": "0,1",
>          "EventCode": "0x84",
>          "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
>          "PerPkg": "1",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Each cycle counts number of any coherent =
request at memory controller that were issued by any core.",
> +        "Counter": "0",
>          "EventCode": "0x85",
>          "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
>          "PerPkg": "1",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Each cycle counts number of coherent read=
s pending on data return from memory controller that were issued by any c=
ore.",
> +        "Counter": "0",
>          "EventCode": "0x85",
>          "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
>          "PerPkg": "1",
> @@ -25,6 +28,7 @@
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new ev=
ent UNC_ARB_REQ_TRK_REQUEST.DRD",
> +        "Counter": "0,1",
>          "EventCode": "0x81",
>          "EventName": "UNC_ARB_DAT_REQUESTS.RD",
>          "PerPkg": "1",
> @@ -33,6 +37,7 @@
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new ev=
ent UNC_ARB_DAT_OCCUPANCY.ALL",
> +        "Counter": "0",
>          "EventCode": "0x85",
>          "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
>          "PerPkg": "1",
> @@ -41,6 +46,7 @@
>      },
>      {
>          "BriefDescription": "Each cycle count number of 'valid' cohere=
nt Data Read entries . Such entry is defined as valid when it is allocate=
d till deallocation. Doesn't include prefetches [This event is alias to U=
NC_ARB_TRK_OCCUPANCY.RD]",
> +        "Counter": "0",
>          "EventCode": "0x80",
>          "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
>          "PerPkg": "1",
> @@ -49,6 +55,7 @@
>      },
>      {
>          "BriefDescription": "Number of all coherent Data Read entries.=
 Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.=
RD]",
> +        "Counter": "0,1",
>          "EventCode": "0x81",
>          "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
>          "PerPkg": "1",
> @@ -57,6 +64,7 @@
>      },
>      {
>          "BriefDescription": "Each cycle count number of all outgoing v=
alid entries in ReqTrk. Such entry is defined as valid from it's allocati=
on in ReqTrk till deallocation. Accounts for Coherent and non-coherent tr=
affic.",
> +        "Counter": "0",
>          "EventCode": "0x80",
>          "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
>          "PerPkg": "1",
> @@ -65,6 +73,7 @@
>      },
>      {
>          "BriefDescription": "Each cycle count number of 'valid' cohere=
nt Data Read entries . Such entry is defined as valid when it is allocate=
d till deallocation. Doesn't include prefetches [This event is alias to U=
NC_ARB_REQ_TRK_OCCUPANCY.DRD]",
> +        "Counter": "0",
>          "EventCode": "0x80",
>          "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
>          "PerPkg": "1",
> @@ -73,6 +82,7 @@
>      },
>      {
>          "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
> +        "Counter": "0,1",
>          "EventCode": "0x81",
>          "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
>          "PerPkg": "1",
> @@ -81,6 +91,7 @@
>      },
>      {
>          "BriefDescription": "Number of all coherent Data Read entries.=
 Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUE=
ST.DRD]",
> +        "Counter": "0,1",
>          "EventCode": "0x81",
>          "EventName": "UNC_ARB_TRK_REQUESTS.RD",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-memory.json
> index 99fb5259f..ea213045c 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-memory.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Counts every read (RdCAS) issued by the M=
emory Controller to DRAM (sum of all channels). All requests result in 64=
 byte data transfers from DRAM.",
> +        "Counter": "1",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
>          "PerPkg": "1",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Counts every 64B read and write request e=
ntering the Memory Controller to DRAM (sum of all channels). Each write r=
equest counts as a new request incrementing this counter. However, same c=
ache line write requests (both full and partial) are combined to a single=
 64 byte data transfer to DRAM.",
> +        "Counter": "0",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC0_TOTAL_REQCOUNT_FREERUN",
>          "PerPkg": "1",
> @@ -17,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Counts every write (WrCAS) issued by the =
Memory Controller to DRAM (sum of all channels). All requests result in 6=
4 byte data transfers from DRAM.",
> +        "Counter": "2",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
>          "PerPkg": "1",
> @@ -25,6 +28,7 @@
>      },
>      {
>          "BriefDescription": "Counts every read (RdCAS) issued by the M=
emory Controller to DRAM (sum of all channels). All requests result in 64=
 byte data transfers from DRAM.",
> +        "Counter": "4",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
>          "PerPkg": "1",
> @@ -33,6 +37,7 @@
>      },
>      {
>          "BriefDescription": "Counts every 64B read and write request e=
ntering the Memory Controller to DRAM (sum of all channels). Each write r=
equest counts as a new request incrementing this counter. However, same c=
ache line write requests (both full and partial) are combined to a single=
 64 byte data transfer to DRAM.",
> +        "Counter": "3",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC1_TOTAL_REQCOUNT_FREERUN",
>          "PerPkg": "1",
> @@ -41,6 +46,7 @@
>      },
>      {
>          "BriefDescription": "Counts every write (WrCAS) issued by the =
Memory Controller to DRAM (sum of all channels). All requests result in 6=
4 byte data transfers from DRAM.",
> +        "Counter": "5",
>          "EventCode": "0xff",
>          "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json=
 b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
> index c6596ba09..87de3bbc4 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "UNC_CLOCK.SOCKET",
> +        "Counter": "Fixed",
>          "EventCode": "0xff",
>          "EventName": "UNC_CLOCK.SOCKET",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
> index adb2f6b3e..62dc0fc76 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Loads that miss the DTLB and hit the STLB=
=2E",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
>          "PublicDescription": "Counts loads that miss the DTLB (Data TL=
B) and hit the STLB (Second level TLB).",
> @@ -9,6 +10,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for a demand load.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
> @@ -18,6 +20,7 @@
>      },
>      {
>          "BriefDescription": "Load miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
>          "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data loads. This implies it missed in the DTLB and=
 further levels of TLB. The page walk can end with or without a fault.",
> @@ -26,6 +29,7 @@
>      },
>      {
>          "BriefDescription": "Page walks completed due to a demand data=
 load to a 2M/4M page.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
>          "PublicDescription": "Counts completed page walks  (2M/4M size=
s) caused by demand data loads. This implies address translations missed =
in the DTLB and further levels of TLB. The page walk can end with or with=
out a fault.",
> @@ -34,6 +38,7 @@
>      },
>      {
>          "BriefDescription": "Page walks completed due to a demand data=
 load to a 4K page.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
>          "PublicDescription": "Counts completed page walks  (4K sizes) =
caused by demand data loads. This implies address translations missed in =
the DTLB and further levels of TLB. The page walk can end with or without=
 a fault.",
> @@ -42,6 +47,7 @@
>      },
>      {
>          "BriefDescription": "Number of page walks outstanding for a de=
mand load in the PMH each cycle.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x08",
>          "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
>          "PublicDescription": "Counts the number of page walks outstand=
ing for a demand load in the PMH (Page Miss Handler) each cycle.",
> @@ -50,6 +56,7 @@
>      },
>      {
>          "BriefDescription": "Stores that miss the DTLB and hit the STL=
B.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.STLB_HIT",
>          "PublicDescription": "Counts stores that miss the DTLB (Data T=
LB) and hit the STLB (2nd Level TLB).",
> @@ -58,6 +65,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for a store.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
> @@ -67,6 +75,7 @@
>      },
>      {
>          "BriefDescription": "Store misses in all TLB levels causes a p=
age walk that completes. (All page sizes)",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
>          "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data stores. This implies it missed in the DTLB an=
d further levels of TLB. The page walk can end with or without a fault.",=

> @@ -75,6 +84,7 @@
>      },
>      {
>          "BriefDescription": "Page walks completed due to a demand data=
 store to a 2M/4M page.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
>          "PublicDescription": "Counts page walks completed due to deman=
d data stores whose address translations missed in the TLB and were mappe=
d to 2M/4M pages.  The page walks can end with or without a page fault.",=

> @@ -83,6 +93,7 @@
>      },
>      {
>          "BriefDescription": "Page walks completed due to a demand data=
 store to a 4K page.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
>          "PublicDescription": "Counts page walks completed due to deman=
d data stores whose address translations missed in the TLB and were mappe=
d to 4K pages.  The page walks can end with or without a page fault.",
> @@ -91,6 +102,7 @@
>      },
>      {
>          "BriefDescription": "Number of page walks outstanding for a st=
ore in the PMH each cycle.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x49",
>          "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
>          "PublicDescription": "Counts the number of page walks outstand=
ing for a store in the PMH (Page Miss Handler) each cycle.",
> @@ -99,6 +111,7 @@
>      },
>      {
>          "BriefDescription": "Instruction fetch requests that miss the =
ITLB and hit the STLB.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.STLB_HIT",
>          "PublicDescription": "Counts instruction fetch requests that m=
iss the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
> @@ -107,6 +120,7 @@
>      },
>      {
>          "BriefDescription": "Cycles when at least one PMH is busy with=
 a page walk for code (instruction fetch) request.",
> +        "Counter": "0,1,2,3",
>          "CounterMask": "1",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.WALK_ACTIVE",
> @@ -116,6 +130,7 @@
>      },
>      {
>          "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.WALK_COMPLETED",
>          "PublicDescription": "Counts completed page walks (all page si=
zes) caused by a code fetch. This implies it missed in the ITLB (Instruct=
ion TLB) and further levels of TLB. The page walk can end with or without=
 a fault.",
> @@ -124,6 +139,7 @@
>      },
>      {
>          "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (2M/4M)",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
>          "PublicDescription": "Counts completed page walks (2M/4M page =
sizes) caused by a code fetch. This implies it missed in the ITLB (Instru=
ction TLB) and further levels of TLB. The page walk can end with or witho=
ut a fault.",
> @@ -132,6 +148,7 @@
>      },
>      {
>          "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (4K)",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
>          "PublicDescription": "Counts completed page walks (4K page siz=
es) caused by a code fetch. This implies it missed in the ITLB (Instructi=
on TLB) and further levels of TLB. The page walk can end with or without =
a fault.",
> @@ -140,6 +157,7 @@
>      },
>      {
>          "BriefDescription": "Number of page walks outstanding for an o=
utstanding code request in the PMH each cycle.",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0x85",
>          "EventName": "ITLB_MISSES.WALK_PENDING",
>          "PublicDescription": "Counts the number of page walks outstand=
ing for an outstanding code (instruction fetch) request in the PMH (Page =
Miss Handler) each cycle.",
> @@ -148,6 +166,7 @@
>      },
>      {
>          "BriefDescription": "DTLB flush attempts of the thread-specifi=
c entries",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xbd",
>          "EventName": "TLB_FLUSH.DTLB_THREAD",
>          "PublicDescription": "Counts the number of DTLB flush attempts=
 of the thread-specific entries.",
> @@ -156,6 +175,7 @@
>      },
>      {
>          "BriefDescription": "STLB flush attempts",
> +        "Counter": "0,1,2,3",
>          "EventCode": "0xbd",
>          "EventName": "TLB_FLUSH.STLB_ANY",
>          "PublicDescription": "Counts the number of any STLB flush atte=
mpts (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
