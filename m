Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF077AFA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjI0GAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjI0GAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:00:12 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A58DD;
        Tue, 26 Sep 2023 23:00:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VszCdPE_1695794405;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VszCdPE_1695794405)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 14:00:06 +0800
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
Subject: [PATCH v11 6/7] perf jevents: Add support for Arm CMN PMU aliasing
Date:   Wed, 27 Sep 2023 13:59:50 +0800
Message-Id: <1695794391-34817-7-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently just add aliases for part of Arm CMN PMU events which
are general and compatible for any SoC and CMN-ANY.

"Compat" value "(434|436|43c|43a).*" means it is compatible with
all CMN600/CMN650/CMN700/Ci700, which can be obtained from
commit 7819e05a0dce ("perf/arm-cmn: Revamp model detection").

The arm-cmn PMU events got from:
[0] https://developer.arm.com/documentation/100180/0302/?lang=en
[1] https://developer.arm.com/documentation/101408/0100/?lang=en
[2] https://developer.arm.com/documentation/102308/0302/?lang=en
[3] https://developer.arm.com/documentation/101569/0300/?lang=en

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
 tools/perf/pmu-events/jevents.py                   |   1 +
 2 files changed, 267 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
new file mode 100644
index 0000000..428605c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
@@ -0,0 +1,266 @@
+[
+	{
+		"EventName": "hnf_cache_miss",
+		"EventidCode": "0x1",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts total cache misses in first lookup result (high priority).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_slc_sf_cache_access",
+		"EventidCode": "0x2",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of cache accesses in first access (high priority).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_cache_fill",
+		"EventidCode": "0x3",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts total allocations in HN SLC (all cache line allocations to SLC).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_pocq_retry",
+		"EventidCode": "0x4",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of retried requests.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_pocq_reqs_recvd",
+		"EventidCode": "0x5",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of requests that HN receives.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_sf_hit",
+		"EventidCode": "0x6",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of SF hits.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_sf_evictions",
+		"EventidCode": "0x7",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of SF eviction cache invalidations initiated.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_dir_snoops_sent",
+		"EventidCode": "0x8",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of directed snoops sent (not including SF back invalidation).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_brd_snoops_sent",
+		"EventidCode": "0x9",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of multicast snoops sent (not including SF back invalidation).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_slc_eviction",
+		"EventidCode": "0xa",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of SLC evictions (dirty only).",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_slc_fill_invalid_way",
+		"EventidCode": "0xb",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of SLC fills to an invalid way.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_mc_retries",
+		"EventidCode": "0xc",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of retried transactions by the MC.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_mc_reqs",
+		"EventidCode": "0xd",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of requests that are sent to MC.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hnf_qos_hh_retry",
+		"EventidCode": "0xe",
+		"NodeType": "0x5",
+		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_s0_rdata_beats",
+		"EventidCode": "0x1",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 0. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_s1_rdata_beats",
+		"EventidCode": "0x2",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 1. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_s2_rdata_beats",
+		"EventidCode": "0x3",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 2. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_rxdat_flits",
+		"EventidCode": "0x4",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of RXDAT flits received. This event measures the true read data bandwidth, excluding CMOs.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_txdat_flits",
+		"EventidCode": "0x5",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of TXDAT flits dispatched. This event measures the write bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_txreq_flits_total",
+		"EventidCode": "0x6",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of TXREQ flits dispatched. This event measures the total request bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "rnid_txreq_flits_retried",
+		"EventidCode": "0x7",
+		"NodeType": "0xa",
+		"BriefDescription": "Number of retried TXREQ flits dispatched. This event measures the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "sbsx_txrsp_retryack",
+		"EventidCode": "0x4",
+		"NodeType": "0x7",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "sbsx_txdat_flitv",
+		"EventidCode": "0x5",
+		"NodeType": "0x7",
+		"BriefDescription": "Number of TXDAT flits dispatched from XP to SBSX. This event is a measure of the write bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "sbsx_arvalid_no_arready",
+		"EventidCode": "0x21",
+		"NodeType": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AR channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "sbsx_awvalid_no_awready",
+		"EventidCode": "0x22",
+		"NodeType": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AW channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "sbsx_wvalid_no_wready",
+		"EventidCode": "0x23",
+		"NodeType": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on W channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_txrsp_retryack",
+		"EventidCode": "0x2a",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_arvalid_no_arready",
+		"EventidCode": "0x2b",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AR channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_arready_no_arvalid",
+		"EventidCode": "0x2c",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of cycles the AR channel is waiting for new requests from HN-I bridge.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_awvalid_no_awready",
+		"EventidCode": "0x2d",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AW channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_awready_no_awvalid",
+		"EventidCode": "0x2e",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of cycles the AW channel is waiting for new requests from HN-I bridge.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_wvalid_no_wready",
+		"EventidCode": "0x2f",
+		"NodeType": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on W channel.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	},
+	{
+		"EventName": "hni_txdat_stall",
+		"EventidCode": "0x30",
+		"NodeType": "0x4",
+		"BriefDescription": "TXDAT valid but no link credit available.",
+		"Unit": "arm_cmn",
+		"Compat": "(434|436|43c|43a).*"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f863aec..fd00975 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -289,6 +289,7 @@ class JsonEvent:
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
+          'arm_cmn': 'arm_cmn',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-- 
1.8.3.1

