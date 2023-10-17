Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B47CC130
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbjJQKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbjJQKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6211F;
        Tue, 17 Oct 2023 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540074; x=1729076074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H++Dc72O8IdIh7g42+cbgWlh8nCWzFguUK/XzSLlb60=;
  b=L3IljEMC9c1aLvDrNHnN3BkSRR4lyFDnBRuNml5FdtgdRSeBCO5ECB68
   uPyQNJ9s0cWGhLwfNjgOuVB5Koh12fXHMqP6OndH2VuLgW2Wdq6tU8Nqt
   4duX5JnI/vkgGCbagJTFMAzeq8Kjq/oW044Jng50j8wjaijAt2SgjHr+k
   /Jzr94+fo2MgumTBxbmi0hwoY1bZMxOgt0S2ueJL9WWv9SVEDDYaeYmSj
   RMZ9K7HxRLcNk+395E72CxDJcXPRO3iGX5XjqWPPnhGYV60rZ7dezqS8G
   HiBhmzxPBL2vJCJM9yHY7Hc6WgBx7qBDjIu5mPKQJiXzY0knQ0N048vPU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012686"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012686"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445336"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445336"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:25 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E900312CF;
        Tue, 17 Oct 2023 11:54:22 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v2 06/11] octeontx2-af: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:36 +0200
Message-Id: <20231017105341.415466-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 2/2 up/down: 150/-585 (-435)
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 464 +++++-------------
 1 file changed, 133 insertions(+), 331 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 41df5ac23f92..c70932625d0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -14,26 +14,16 @@
 
 #define DRV_NAME "octeontx2-af"
 
-static int rvu_report_pair_start(struct devlink_fmsg *fmsg, const char *name)
+static void rvu_report_pair_start(struct devlink_fmsg *fmsg, const char *name)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	return  devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_obj_nest_start(fmsg);
 }
 
-static int rvu_report_pair_end(struct devlink_fmsg *fmsg)
+static void rvu_report_pair_end(struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 
 static bool rvu_common_request_irq(struct rvu *rvu, int offset,
@@ -284,175 +274,81 @@ static int rvu_nix_report_show(struct devlink_fmsg *fmsg, void *ctx,
 {
 	struct rvu_nix_event_ctx *nix_event_context;
 	u64 intr_val;
-	int err;
 
 	nix_event_context = ctx;
 	switch (health_reporter) {
 	case NIX_AF_RVU_INTR:
 		intr_val = nix_event_context->nix_af_rvu_int;
-		err = rvu_report_pair_start(fmsg, "NIX_AF_RVU");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNIX RVU Interrupt Reg ",
-						nix_event_context->nix_af_rvu_int);
-		if (err)
-			return err;
-		if (intr_val & BIT_ULL(0)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tUnmap Slot Error");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NIX_AF_RVU");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNIX RVU Interrupt Reg ",
+					  nix_event_context->nix_af_rvu_int);
+		if (intr_val & BIT_ULL(0))
+			devlink_fmsg_string_put(fmsg, "\n\tUnmap Slot Error");
+		rvu_report_pair_end(fmsg);
 		break;
 	case NIX_AF_RVU_GEN:
 		intr_val = nix_event_context->nix_af_rvu_gen;
-		err = rvu_report_pair_start(fmsg, "NIX_AF_GENERAL");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNIX General Interrupt Reg ",
-						nix_event_context->nix_af_rvu_gen);
-		if (err)
-			return err;
-		if (intr_val & BIT_ULL(0)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tRx multicast pkt drop");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(1)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tRx mirror pkt drop");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(4)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tSMQ flush done");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NIX_AF_GENERAL");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNIX General Interrupt Reg ",
+					  nix_event_context->nix_af_rvu_gen);
+		if (intr_val & BIT_ULL(0))
+			devlink_fmsg_string_put(fmsg, "\n\tRx multicast pkt drop");
+		if (intr_val & BIT_ULL(1))
+			devlink_fmsg_string_put(fmsg, "\n\tRx mirror pkt drop");
+		if (intr_val & BIT_ULL(4))
+			devlink_fmsg_string_put(fmsg, "\n\tSMQ flush done");
+		rvu_report_pair_end(fmsg);
 		break;
 	case NIX_AF_RVU_ERR:
 		intr_val = nix_event_context->nix_af_rvu_err;
-		err = rvu_report_pair_start(fmsg, "NIX_AF_ERR");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNIX Error Interrupt Reg ",
-						nix_event_context->nix_af_rvu_err);
-		if (err)
-			return err;
-		if (intr_val & BIT_ULL(14)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_AQ_INST_S read");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(13)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_AQ_RES_S write");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(12)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAQ Doorbell Error");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(6)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tRx on unmapped PF_FUNC");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(5)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tRx multicast replication error");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(4)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_RX_MCE_S read");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(3)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on multicast WQE read");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(2)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on mirror WQE read");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(1)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on mirror pkt write");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(0)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on multicast pkt write");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NIX_AF_ERR");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNIX Error Interrupt Reg ",
+					  nix_event_context->nix_af_rvu_err);
+		if (intr_val & BIT_ULL(14))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_AQ_INST_S read");
+		if (intr_val & BIT_ULL(13))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_AQ_RES_S write");
+		if (intr_val & BIT_ULL(12))
+			devlink_fmsg_string_put(fmsg, "\n\tAQ Doorbell Error");
+		if (intr_val & BIT_ULL(6))
+			devlink_fmsg_string_put(fmsg, "\n\tRx on unmapped PF_FUNC");
+		if (intr_val & BIT_ULL(5))
+			devlink_fmsg_string_put(fmsg, "\n\tRx multicast replication error");
+		if (intr_val & BIT_ULL(4))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on NIX_RX_MCE_S read");
+		if (intr_val & BIT_ULL(3))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on multicast WQE read");
+		if (intr_val & BIT_ULL(2))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on mirror WQE read");
+		if (intr_val & BIT_ULL(1))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on mirror pkt write");
+		if (intr_val & BIT_ULL(0))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on multicast pkt write");
+		rvu_report_pair_end(fmsg);
 		break;
 	case NIX_AF_RVU_RAS:
 		intr_val = nix_event_context->nix_af_rvu_err;
-		err = rvu_report_pair_start(fmsg, "NIX_AF_RAS");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNIX RAS Interrupt Reg ",
-						nix_event_context->nix_af_rvu_err);
-		if (err)
-			return err;
-		err = devlink_fmsg_string_put(fmsg, "\n\tPoison Data on:");
-		if (err)
-			return err;
-		if (intr_val & BIT_ULL(34)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_INST_S");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(33)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_RES_S");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(32)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tHW ctx");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(4)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tPacket from mirror buffer");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(3)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tPacket from multicast buffer");
-
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(2)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tWQE read from mirror buffer");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(1)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tWQE read from multicast buffer");
-			if (err)
-				return err;
-		}
-		if (intr_val & BIT_ULL(0)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX_RX_MCE_S read");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NIX_AF_RAS");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNIX RAS Interrupt Reg ",
+					  nix_event_context->nix_af_rvu_err);
+		devlink_fmsg_string_put(fmsg, "\n\tPoison Data on:");
+		if (intr_val & BIT_ULL(34))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_INST_S");
+		if (intr_val & BIT_ULL(33))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_RES_S");
+		if (intr_val & BIT_ULL(32))
+			devlink_fmsg_string_put(fmsg, "\n\tHW ctx");
+		if (intr_val & BIT_ULL(4))
+			devlink_fmsg_string_put(fmsg, "\n\tPacket from mirror buffer");
+		if (intr_val & BIT_ULL(3))
+			devlink_fmsg_string_put(fmsg, "\n\tPacket from multicast buffer");
+		if (intr_val & BIT_ULL(2))
+			devlink_fmsg_string_put(fmsg, "\n\tWQE read from mirror buffer");
+		if (intr_val & BIT_ULL(1))
+			devlink_fmsg_string_put(fmsg, "\n\tWQE read from multicast buffer");
+		if (intr_val & BIT_ULL(0))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX_RX_MCE_S read");
+		rvu_report_pair_end(fmsg);
 		break;
 	default:
 		return -EINVAL;
@@ -922,181 +818,87 @@ static int rvu_npa_report_show(struct devlink_fmsg *fmsg, void *ctx,
 	struct rvu_npa_event_ctx *npa_event_context;
 	unsigned int alloc_dis, free_dis;
 	u64 intr_val;
-	int err;
 
 	npa_event_context = ctx;
 	switch (health_reporter) {
 	case NPA_AF_RVU_GEN:
 		intr_val = npa_event_context->npa_af_rvu_gen;
-		err = rvu_report_pair_start(fmsg, "NPA_AF_GENERAL");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNPA General Interrupt Reg ",
-						npa_event_context->npa_af_rvu_gen);
-		if (err)
-			return err;
-		if (intr_val & BIT_ULL(32)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tUnmap PF Error");
-			if (err)
-				return err;
-		}
+		rvu_report_pair_start(fmsg, "NPA_AF_GENERAL");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNPA General Interrupt Reg ",
+					  npa_event_context->npa_af_rvu_gen);
+		if (intr_val & BIT_ULL(32))
+			devlink_fmsg_string_put(fmsg, "\n\tUnmap PF Error");
 
 		free_dis = FIELD_GET(GENMASK(15, 0), intr_val);
-		if (free_dis & BIT(NPA_INPQ_NIX0_RX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX0: free disabled RX");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_NIX0_TX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX0:free disabled TX");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_NIX1_RX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX1: free disabled RX");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_NIX1_TX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX1:free disabled TX");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_SSO)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for SSO");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_TIM)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for TIM");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_DPI)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for DPI");
-			if (err)
-				return err;
-		}
-		if (free_dis & BIT(NPA_INPQ_AURA_OP)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for AURA");
-			if (err)
-				return err;
-		}
+		if (free_dis & BIT(NPA_INPQ_NIX0_RX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX0: free disabled RX");
+		if (free_dis & BIT(NPA_INPQ_NIX0_TX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX0:free disabled TX");
+		if (free_dis & BIT(NPA_INPQ_NIX1_RX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX1: free disabled RX");
+		if (free_dis & BIT(NPA_INPQ_NIX1_TX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX1:free disabled TX");
+		if (free_dis & BIT(NPA_INPQ_SSO))
+			devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for SSO");
+		if (free_dis & BIT(NPA_INPQ_TIM))
+			devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for TIM");
+		if (free_dis & BIT(NPA_INPQ_DPI))
+			devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for DPI");
+		if (free_dis & BIT(NPA_INPQ_AURA_OP))
+			devlink_fmsg_string_put(fmsg, "\n\tFree Disabled for AURA");
 
 		alloc_dis = FIELD_GET(GENMASK(31, 16), intr_val);
-		if (alloc_dis & BIT(NPA_INPQ_NIX0_RX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX0: alloc disabled RX");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_NIX0_TX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX0:alloc disabled TX");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_NIX1_RX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX1: alloc disabled RX");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_NIX1_TX)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tNIX1:alloc disabled TX");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_SSO)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for SSO");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_TIM)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for TIM");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_DPI)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for DPI");
-			if (err)
-				return err;
-		}
-		if (alloc_dis & BIT(NPA_INPQ_AURA_OP)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for AURA");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		if (alloc_dis & BIT(NPA_INPQ_NIX0_RX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX0: alloc disabled RX");
+		if (alloc_dis & BIT(NPA_INPQ_NIX0_TX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX0:alloc disabled TX");
+		if (alloc_dis & BIT(NPA_INPQ_NIX1_RX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX1: alloc disabled RX");
+		if (alloc_dis & BIT(NPA_INPQ_NIX1_TX))
+			devlink_fmsg_string_put(fmsg, "\n\tNIX1:alloc disabled TX");
+		if (alloc_dis & BIT(NPA_INPQ_SSO))
+			devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for SSO");
+		if (alloc_dis & BIT(NPA_INPQ_TIM))
+			devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for TIM");
+		if (alloc_dis & BIT(NPA_INPQ_DPI))
+			devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for DPI");
+		if (alloc_dis & BIT(NPA_INPQ_AURA_OP))
+			devlink_fmsg_string_put(fmsg, "\n\tAlloc Disabled for AURA");
+
+		rvu_report_pair_end(fmsg);
 		break;
 	case NPA_AF_RVU_ERR:
-		err = rvu_report_pair_start(fmsg, "NPA_AF_ERR");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNPA Error Interrupt Reg ",
-						npa_event_context->npa_af_rvu_err);
-		if (err)
-			return err;
-
-		if (npa_event_context->npa_af_rvu_err & BIT_ULL(14)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on NPA_AQ_INST_S read");
-			if (err)
-				return err;
-		}
-		if (npa_event_context->npa_af_rvu_err & BIT_ULL(13)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tFault on NPA_AQ_RES_S write");
-			if (err)
-				return err;
-		}
-		if (npa_event_context->npa_af_rvu_err & BIT_ULL(12)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tAQ Doorbell Error");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NPA_AF_ERR");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNPA Error Interrupt Reg ",
+					  npa_event_context->npa_af_rvu_err);
+		if (npa_event_context->npa_af_rvu_err & BIT_ULL(14))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on NPA_AQ_INST_S read");
+		if (npa_event_context->npa_af_rvu_err & BIT_ULL(13))
+			devlink_fmsg_string_put(fmsg, "\n\tFault on NPA_AQ_RES_S write");
+		if (npa_event_context->npa_af_rvu_err & BIT_ULL(12))
+			devlink_fmsg_string_put(fmsg, "\n\tAQ Doorbell Error");
+		rvu_report_pair_end(fmsg);
 		break;
 	case NPA_AF_RVU_RAS:
-		err = rvu_report_pair_start(fmsg, "NPA_AF_RVU_RAS");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNPA RAS Interrupt Reg ",
-						npa_event_context->npa_af_rvu_ras);
-		if (err)
-			return err;
-		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(34)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tPoison data on NPA_AQ_INST_S");
-			if (err)
-				return err;
-		}
-		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(33)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tPoison data on NPA_AQ_RES_S");
-			if (err)
-				return err;
-		}
-		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(32)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tPoison data on HW context");
-			if (err)
-				return err;
-		}
-		err = rvu_report_pair_end(fmsg);
-		if (err)
-			return err;
+		rvu_report_pair_start(fmsg, "NPA_AF_RVU_RAS");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNPA RAS Interrupt Reg ",
+					  npa_event_context->npa_af_rvu_ras);
+		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(34))
+			devlink_fmsg_string_put(fmsg, "\n\tPoison data on NPA_AQ_INST_S");
+		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(33))
+			devlink_fmsg_string_put(fmsg, "\n\tPoison data on NPA_AQ_RES_S");
+		if (npa_event_context->npa_af_rvu_ras & BIT_ULL(32))
+			devlink_fmsg_string_put(fmsg, "\n\tPoison data on HW context");
+		rvu_report_pair_end(fmsg);
 		break;
 	case NPA_AF_RVU_INTR:
-		err = rvu_report_pair_start(fmsg, "NPA_AF_RVU");
-		if (err)
-			return err;
-		err = devlink_fmsg_u64_pair_put(fmsg, "\tNPA RVU Interrupt Reg ",
-						npa_event_context->npa_af_rvu_int);
-		if (err)
-			return err;
-		if (npa_event_context->npa_af_rvu_int & BIT_ULL(0)) {
-			err = devlink_fmsg_string_put(fmsg, "\n\tUnmap Slot Error");
-			if (err)
-				return err;
-		}
-		return rvu_report_pair_end(fmsg);
+		rvu_report_pair_start(fmsg, "NPA_AF_RVU");
+		devlink_fmsg_u64_pair_put(fmsg, "\tNPA RVU Interrupt Reg ",
+					  npa_event_context->npa_af_rvu_int);
+		if (npa_event_context->npa_af_rvu_int & BIT_ULL(0))
+			devlink_fmsg_string_put(fmsg, "\n\tUnmap Slot Error");
+		rvu_report_pair_end(fmsg);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.40.1

