Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3C7D152A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377974AbjJTRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377946AbjJTRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:51:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AF471A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:51:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F241E1595;
        Fri, 20 Oct 2023 10:52:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A5F23F762;
        Fri, 20 Oct 2023 10:51:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: [PATCH 3/3] perf/arm-cmn: Enable per-DTC counter allocation
Date:   Fri, 20 Oct 2023 18:51:27 +0100
Message-Id: <849f65566582cb102c6d0843d0f26e231180f8ac.1697824215.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1697824215.git.robin.murphy@arm.com>
References: <cover.1697824215.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally enable independent per-DTC-domain counter allocation, except on
CMN-600 where we still need to cope with not knowing the domain topology
and thus keep counter indices sychronised across domains. This allows
users to simultaneously count up to 8 targeted events per domain, rather
than 8 globally, for up to 4x wider coverage on maximum configurations.

Even though this now looks deceptively simple, I stand by my previous
assertion that it was a flippin' nightmare to implement; all the real
head-scratchers are hidden in the foundations in the previous patch...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 675f1638013e..9479e919c063 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1570,7 +1570,7 @@ struct arm_cmn_val {
 	u8 dtm_count[CMN_MAX_DTMS];
 	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
 	u8 wp[CMN_MAX_DTMS][4];
-	int dtc_count;
+	int dtc_count[CMN_MAX_DTCS];
 	bool cycles;
 };
 
@@ -1591,7 +1591,8 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 		return;
 	}
 
-	val->dtc_count++;
+	for_each_hw_dtc_idx(hw, dtc, idx)
+		val->dtc_count[dtc]++;
 
 	for_each_hw_dn(hw, dn, i) {
 		int wp_idx, dtm = dn->dtm, sel = hw->filter_sel;
@@ -1638,8 +1639,9 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		goto done;
 	}
 
-	if (val->dtc_count == CMN_DT_NUM_COUNTERS)
-		goto done;
+	for (i = 0; i < CMN_MAX_DTCS; i++)
+		if (val->dtc_count[i] == CMN_DT_NUM_COUNTERS)
+			goto done;
 
 	for_each_hw_dn(hw, dn, i) {
 		int wp_idx, wp_cmb, dtm = dn->dtm, sel = hw->filter_sel;
@@ -1806,9 +1808,9 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		return 0;
 	}
 
-	/* Grab a free global counter first... */
+	/* Grab the global counters first... */
 	for_each_hw_dtc_idx(hw, j, idx) {
-		if (j > 0) {
+		if (cmn->part == PART_CMN600 && j > 0) {
 			idx = hw->dtc_idx[0];
 		} else {
 			idx = 0;
@@ -1819,10 +1821,10 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		hw->dtc_idx[j] = idx;
 	}
 
-	/* ...then the local counters to feed it. */
+	/* ...then the local counters to feed them */
 	for_each_hw_dn(hw, dn, i) {
 		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
-		unsigned int dtm_idx, shift, d = 0;
+		unsigned int dtm_idx, shift, d = max_t(int, dn->dtc, 0);
 		u64 reg;
 
 		dtm_idx = 0;
-- 
2.39.2.101.g768bb238c484.dirty

