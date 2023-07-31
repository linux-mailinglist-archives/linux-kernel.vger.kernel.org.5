Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BD7692F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjGaKTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGaKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40469B8;
        Mon, 31 Jul 2023 03:19:34 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osDBC9Ye9I2OsASPnSxVHOt0lMVcBIdMZSvoeoSPX30=;
        b=oY0PBm92/Y5hNt74oi8crd8WQWLpMcISqJDF2n0F46X/z5EXRznZNAFabM9kbJRIyMAVTG
        Mb5nwCBbzTH7j3FGjw/7OJiaywlBq1p4PoYKtNrZXJgXgY4rDYBilsfYP93MX/7c32rwDs
        NznmRgWQONelfaHgg6DZ8peXwn94jn8U8m6+L2rnL8jAJfEPRMGKYuQyip0lP5zVsyqGgD
        05k2pC7yrTEg+c7p087vituI3TOgY68xBoz6VLfwA0m72D0aZj/l/BKDJNgJQJ/ZXwYVC6
        CFoNLy75dZvyvWCUqYs2Qyk8SLHTVLmNgvw4dzzWW2UzwNLXf5t3jkxqqeYIIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osDBC9Ye9I2OsASPnSxVHOt0lMVcBIdMZSvoeoSPX30=;
        b=4CQa6qcnIjzwhXdJxrVSAO0zx4mw6lWanefF+ZYxMK9hoafTkb8E1j1JNpTiwZyo7AmOFR
        tP2lwwyW3npWohBg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/ibs: Set mem_lvl_num, mem_remote and
 mem_hops for data_src
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725150206.184-4-ravi.bangoria@amd.com>
References: <20230725150206.184-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <169079877229.28540.14475733550664250304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8bfc20baa9355d2ce6b031ff8bdb62c9456923f7
Gitweb:        https://git.kernel.org/tip/8bfc20baa9355d2ce6b031ff8bdb62c9456923f7
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 25 Jul 2023 20:32:06 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:45 +02:00

perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
limitations. Mainly:

1. mem_lvl_num doesn't allow setting multiple sources whereas old API
   allows it. Setting multiple data sources is useful because IBS on
   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
   is only one such DataSrc(2h) though).
2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
   c2c (c2c_decode_stats()) does not use mem_lvl_num at all.

1st one can be handled using ANY_CACHE with HOPS_0. 2nd is purely perf
tool specific issue and should be fixed separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230725150206.184-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 156 ++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 88 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7d29be0..6911c53 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -728,38 +728,63 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
 	return op_data2->data_src_lo;
 }
 
-static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
-				 union ibs_op_data3 *op_data3,
-				 struct perf_sample_data *data)
+#define	L(x)		(PERF_MEM_S(LVL, x) | PERF_MEM_S(LVL, HIT))
+#define	LN(x)		PERF_MEM_S(LVLNUM, x)
+#define	REM		PERF_MEM_S(REMOTE, REMOTE)
+#define	HOPS(x)		PERF_MEM_S(HOPS, x)
+
+static u64 g_data_src[8] = {
+	[IBS_DATA_SRC_LOC_CACHE]	  = L(L3) | L(REM_CCE1) | LN(ANY_CACHE) | HOPS(0),
+	[IBS_DATA_SRC_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_REM_CACHE]	  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_IO]		  = L(IO) | LN(IO),
+};
+
+#define RMT_NODE_BITS			(1 << IBS_DATA_SRC_DRAM)
+#define RMT_NODE_APPLICABLE(x)		(RMT_NODE_BITS & (1 << x))
+
+static u64 g_zen4_data_src[32] = {
+	[IBS_DATA_SRC_EXT_LOC_CACHE]	  = L(L3) | LN(L3),
+	[IBS_DATA_SRC_EXT_NEAR_CCX_CACHE] = L(REM_CCE1) | LN(ANY_CACHE) | REM | HOPS(0),
+	[IBS_DATA_SRC_EXT_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_EXT_FAR_CCX_CACHE]  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_EXT_PMEM]		  = LN(PMEM),
+	[IBS_DATA_SRC_EXT_IO]		  = L(IO) | LN(IO),
+	[IBS_DATA_SRC_EXT_EXT_MEM]	  = LN(CXL),
+};
+
+#define ZEN4_RMT_NODE_BITS		((1 << IBS_DATA_SRC_EXT_DRAM) | \
+					 (1 << IBS_DATA_SRC_EXT_PMEM) | \
+					 (1 << IBS_DATA_SRC_EXT_EXT_MEM))
+#define ZEN4_RMT_NODE_APPLICABLE(x)	(ZEN4_RMT_NODE_BITS & (1 << x))
+
+static __u64 perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
 {
 	union perf_mem_data_src *data_src = &data->data_src;
 	u8 ibs_data_src = perf_ibs_data_src(op_data2);
 
 	data_src->mem_lvl = 0;
+	data_src->mem_lvl_num = 0;
 
 	/*
 	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
 	 * memory accesses. So, check DcUcMemAcc bit early.
 	 */
-	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
+		return L(UNC) | LN(UNC);
 
 	/* L1 Hit */
-	if (op_data3->dc_miss == 0) {
-		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss == 0)
+		return L(L1) | LN(L1);
 
 	/* L2 Hit */
 	if (op_data3->l2_miss == 0) {
 		/* Erratum #1293 */
 		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
-		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
-			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
-			return;
-		}
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc))
+			return L(L2) | LN(L2);
 	}
 
 	/*
@@ -769,82 +794,36 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (data_src->mem_op != PERF_MEM_OP_LOAD)
 		goto check_mab;
 
-	/* L3 Hit */
 	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
-					    PERF_MEM_LVL_HIT;
-			return;
-		}
-	}
+		u64 val = g_zen4_data_src[ibs_data_src];
 
-	/* A peer cache in a near CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* A peer cache in a far CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && ZEN4_RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-	}
 
-	/* DRAM */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
-		if (op_data2->rmt_node == 0)
-			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
-		else
-			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		return val;
+	} else {
+		u64 val = g_data_src[ibs_data_src];
 
-	/* PMEM */
-	if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* Extension Memory */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-		return;
-	}
 
-	/* IO */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_IO;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
+		return val;
 	}
 
 check_mab:
@@ -855,12 +834,11 @@ check_mab:
 	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
 	 * MAB only when IBS fails to provide DataSrc.
 	 */
-	if (op_data3->dc_miss_no_mab_alloc) {
-		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss_no_mab_alloc)
+		return L(LFB) | LN(LFB);
 
-	data_src->mem_lvl = PERF_MEM_LVL_NA;
+	/* Don't set HIT with NA */
+	return PERF_MEM_S(LVL, NA) | LN(NA);
 }
 
 static bool perf_ibs_cache_hit_st_valid(void)
@@ -950,7 +928,9 @@ static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
 				  union ibs_op_data2 *op_data2,
 				  union ibs_op_data3 *op_data3)
 {
-	perf_ibs_get_mem_lvl(op_data2, op_data3, data);
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->val |= perf_ibs_get_mem_lvl(op_data2, op_data3, data);
 	perf_ibs_get_mem_snoop(op_data2, data);
 	perf_ibs_get_tlb_lvl(op_data3, data);
 	perf_ibs_get_mem_lock(op_data3, data);
