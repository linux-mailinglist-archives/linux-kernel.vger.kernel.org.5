Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B52766404
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjG1GRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjG1GRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:17:40 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB9272D;
        Thu, 27 Jul 2023 23:17:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VoOxEJI_1690525052;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoOxEJI_1690525052)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 14:17:32 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 4/5] perf jevents: Add support for Arm CMN PMU aliasing
Date:   Fri, 28 Jul 2023 14:17:19 +0800
Message-Id: <1690525040-77423-5-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently just add aliases for part of Arm CMN PMU events which are
general and compatible for any SoC and CMN-ANY.

"Compat" value "434*;436*;43c*;43a*" means it is compatible with all
CMN600/CMN650/CMN700/Ci700.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
 tools/perf/pmu-events/jevents.py                   |   1 +
 2 files changed, 267 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
new file mode 100644
index 0000000..e54036c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
@@ -0,0 +1,266 @@
+[
+	{
+		"EventName": "hnf_cache_miss",
+		"EventIdCode": "0x1",
+		"Type": "0x5",
+		"BriefDescription": "Counts total cache misses in first lookup result (high priority).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_slc_sf_cache_access",
+		"EventIdCode": "0x2",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of cache accesses in first access (high priority).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_cache_fill",
+		"EventIdCode": "0x3",
+		"Type": "0x5",
+		"BriefDescription": "Counts total allocations in HN SLC (all cache line allocations to SLC).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_pocq_retry",
+		"EventIdCode": "0x4",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of retried requests.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_pocq_reqs_recvd",
+		"EventIdCode": "0x5",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of requests that HN receives.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_sf_hit",
+		"EventIdCode": "0x6",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of SF hits.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_sf_evictions",
+		"EventIdCode": "0x7",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of SF eviction cache invalidations initiated.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_dir_snoops_sent",
+		"EventIdCode": "0x8",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of directed snoops sent (not including SF back invalidation).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_brd_snoops_sent",
+		"EventIdCode": "0x9",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of multicast snoops sent (not including SF back invalidation).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_slc_eviction",
+		"EventIdCode": "0xa",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of SLC evictions (dirty only).",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_slc_fill_invalid_way",
+		"EventIdCode": "0xb",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of SLC fills to an invalid way.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_mc_retries",
+		"EventIdCode": "0xc",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of retried transactions by the MC.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_mc_reqs",
+		"EventIdCode": "0xd",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of requests that are sent to MC.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hnf_qos_hh_retry",
+		"EventIdCode": "0xe",
+		"Type": "0x5",
+		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_s0_rdata_beats",
+		"EventIdCode": "0x1",
+		"Type": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 0. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_s1_rdata_beats",
+		"EventIdCode": "0x2",
+		"Type": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 1. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_s2_rdata_beats",
+		"EventIdCode": "0x3",
+		"Type": "0xa",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 2. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_rxdat_flits",
+		"EventIdCode": "0x4",
+		"Type": "0xa",
+		"BriefDescription": "Number of RXDAT flits received. This event measures the true read data bandwidth, excluding CMOs.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_txdat_flits",
+		"EventIdCode": "0x5",
+		"Type": "0xa",
+		"BriefDescription": "Number of TXDAT flits dispatched. This event measures the write bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_txreq_flits_total",
+		"EventIdCode": "0x6",
+		"Type": "0xa",
+		"BriefDescription": "Number of TXREQ flits dispatched. This event measures the total request bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "rnid_txreq_flits_retried",
+		"EventIdCode": "0x7",
+		"Type": "0xa",
+		"BriefDescription": "Number of retried TXREQ flits dispatched. This event measures the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "sbsx_txrsp_retryack",
+		"EventIdCode": "0x4",
+		"Type": "0x7",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "sbsx_txdat_flitv",
+		"EventIdCode": "0x5",
+		"Type": "0x7",
+		"BriefDescription": "Number of TXDAT flits dispatched from XP to SBSX. This event is a measure of the write bandwidth.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "sbsx_arvalid_no_arready",
+		"EventIdCode": "0x21",
+		"Type": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AR channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "sbsx_awvalid_no_awready",
+		"EventIdCode": "0x22",
+		"Type": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AW channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "sbsx_wvalid_no_wready",
+		"EventIdCode": "0x23",
+		"Type": "0x7",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on W channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_txrsp_retryack",
+		"EventIdCode": "0x2a",
+		"Type": "0x4",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_arvalid_no_arready",
+		"EventIdCode": "0x2b",
+		"Type": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AR channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_arready_no_arvalid",
+		"EventIdCode": "0x2c",
+		"Type": "0x4",
+		"BriefDescription": "Number of cycles the AR channel is waiting for new requests from HN-I bridge.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_awvalid_no_awready",
+		"EventIdCode": "0x2d",
+		"Type": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AW channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_awready_no_awvalid",
+		"EventIdCode": "0x2e",
+		"Type": "0x4",
+		"BriefDescription": "Number of cycles the AW channel is waiting for new requests from HN-I bridge.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_wvalid_no_wready",
+		"EventIdCode": "0x2f",
+		"Type": "0x4",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on W channel.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"EventName": "hni_txdat_stall",
+		"EventIdCode": "0x30",
+		"Type": "0x4",
+		"BriefDescription": "TXDAT valid but no link credit available.",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 9c0f63a..bfdfb67 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -272,6 +272,7 @@ class JsonEvent:
           'DFPMC': 'amd_df',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
+          'arm_cmn': 'arm_cmn',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-- 
1.8.3.1

