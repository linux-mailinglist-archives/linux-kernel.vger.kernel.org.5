Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2747854D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjHWKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjHWJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:39:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ED9026BA;
        Wed, 23 Aug 2023 02:33:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25FB1042;
        Wed, 23 Aug 2023 02:34:11 -0700 (PDT)
Received: from [10.57.3.6] (unknown [10.57.3.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3C33F740;
        Wed, 23 Aug 2023 02:33:25 -0700 (PDT)
Message-ID: <46a0917c-e288-7ef9-d72d-cdd53bb52a0a@arm.com>
Date:   Wed, 23 Aug 2023 10:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 7/8] perf jevents: Add support for Arm CMN PMU aliasing
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
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
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-8-git-send-email-renyu.zj@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1692606977-92009-8-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-21 09:36, Jing Zhang wrote:
> Currently just add aliases for part of Arm CMN PMU events which
> are general and compatible for any SoC and CMN-ANY.
> 
> "Compat" value "434*;436*;43c*;43a*" means it is compatible with
> all CMN600/CMN650/CMN700/Ci700, which can be obtained from
> commit 7819e05a0dce ("perf/arm-cmn: Revamp model detection").
> 
> The arm-cmn PMU events got from:
> [0] https://developer.arm.com/documentation/100180/0302/?lang=en
> [1] https://developer.arm.com/documentation/101408/0100/?lang=en
> [2] https://developer.arm.com/documentation/102308/0302/?lang=en
> [3] https://developer.arm.com/documentation/101569/0300/?lang=en
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>   .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>   tools/perf/pmu-events/jevents.py                   |   1 +
>   2 files changed, 267 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> new file mode 100644
> index 0000000..30435a3
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> @@ -0,0 +1,266 @@
> +[
> +	{
> +		"EventName": "hnf_cache_miss",
> +		"EventIdCode": "0x1",
> +		"NodeType": "0x5",

Given my other comment, I also think there would be no harm in just 
having these as:
	
		"ConfigCode" : "0x10005"

if you'd rather make life easier to begin with, then be able to come 
back and improve things later. IMO it doesn't affect the readability of 
the important values *all* that much, since it's not like they're tighly 
packed together in oddly-aligned bitfields.

Thanks,
Robin.

> +		"BriefDescription": "Counts total cache misses in first lookup result (high priority).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_slc_sf_cache_access",
> +		"EventIdCode": "0x2",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of cache accesses in first access (high priority).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_cache_fill",
> +		"EventIdCode": "0x3",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts total allocations in HN SLC (all cache line allocations to SLC).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_pocq_retry",
> +		"EventIdCode": "0x4",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of retried requests.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_pocq_reqs_recvd",
> +		"EventIdCode": "0x5",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of requests that HN receives.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_sf_hit",
> +		"EventIdCode": "0x6",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of SF hits.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_sf_evictions",
> +		"EventIdCode": "0x7",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of SF eviction cache invalidations initiated.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_dir_snoops_sent",
> +		"EventIdCode": "0x8",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of directed snoops sent (not including SF back invalidation).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_brd_snoops_sent",
> +		"EventIdCode": "0x9",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of multicast snoops sent (not including SF back invalidation).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_slc_eviction",
> +		"EventIdCode": "0xa",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of SLC evictions (dirty only).",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_slc_fill_invalid_way",
> +		"EventIdCode": "0xb",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of SLC fills to an invalid way.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_mc_retries",
> +		"EventIdCode": "0xc",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of retried transactions by the MC.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_mc_reqs",
> +		"EventIdCode": "0xd",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of requests that are sent to MC.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hnf_qos_hh_retry",
> +		"EventIdCode": "0xe",
> +		"NodeType": "0x5",
> +		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_s0_rdata_beats",
> +		"EventIdCode": "0x1",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 0. This event measures the read bandwidth, including CMO responses.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_s1_rdata_beats",
> +		"EventIdCode": "0x2",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 1. This event measures the read bandwidth, including CMO responses.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_s2_rdata_beats",
> +		"EventIdCode": "0x3",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 2. This event measures the read bandwidth, including CMO responses.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_rxdat_flits",
> +		"EventIdCode": "0x4",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of RXDAT flits received. This event measures the true read data bandwidth, excluding CMOs.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_txdat_flits",
> +		"EventIdCode": "0x5",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of TXDAT flits dispatched. This event measures the write bandwidth.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_txreq_flits_total",
> +		"EventIdCode": "0x6",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of TXREQ flits dispatched. This event measures the total request bandwidth.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "rnid_txreq_flits_retried",
> +		"EventIdCode": "0x7",
> +		"NodeType": "0xa",
> +		"BriefDescription": "Number of retried TXREQ flits dispatched. This event measures the retry rate.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "sbsx_txrsp_retryack",
> +		"EventIdCode": "0x4",
> +		"NodeType": "0x7",
> +		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "sbsx_txdat_flitv",
> +		"EventIdCode": "0x5",
> +		"NodeType": "0x7",
> +		"BriefDescription": "Number of TXDAT flits dispatched from XP to SBSX. This event is a measure of the write bandwidth.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "sbsx_arvalid_no_arready",
> +		"EventIdCode": "0x21",
> +		"NodeType": "0x7",
> +		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AR channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "sbsx_awvalid_no_awready",
> +		"EventIdCode": "0x22",
> +		"NodeType": "0x7",
> +		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AW channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "sbsx_wvalid_no_wready",
> +		"EventIdCode": "0x23",
> +		"NodeType": "0x7",
> +		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on W channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_txrsp_retryack",
> +		"EventIdCode": "0x2a",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_arvalid_no_arready",
> +		"EventIdCode": "0x2b",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AR channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_arready_no_arvalid",
> +		"EventIdCode": "0x2c",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of cycles the AR channel is waiting for new requests from HN-I bridge.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_awvalid_no_awready",
> +		"EventIdCode": "0x2d",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AW channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_awready_no_awvalid",
> +		"EventIdCode": "0x2e",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of cycles the AW channel is waiting for new requests from HN-I bridge.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_wvalid_no_wready",
> +		"EventIdCode": "0x2f",
> +		"NodeType": "0x4",
> +		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on W channel.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	},
> +	{
> +		"EventName": "hni_txdat_stall",
> +		"EventIdCode": "0x30",
> +		"NodeType": "0x4",
> +		"BriefDescription": "TXDAT valid but no link credit available.",
> +		"Unit": "arm_cmn",
> +		"Compat": "434*;436*;43c*;43a*"
> +	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 369c8bf..935bd4b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -272,6 +272,7 @@ class JsonEvent:
>             'DFPMC': 'amd_df',
>             'cpu_core': 'cpu_core',
>             'cpu_atom': 'cpu_atom',
> +          'arm_cmn': 'arm_cmn',
>         }
>         return table[unit] if unit in table else f'uncore_{unit.lower()}'
>   
