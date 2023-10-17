Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9F7CC12A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjJQKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbjJQKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C5107;
        Tue, 17 Oct 2023 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540070; x=1729076070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGoSuQvM02t+1kKV0fVXKud+Y2AeNdZHn1i35D3tr3I=;
  b=L7AIYeXczyrTfPHawhudhwfBvFpVEdU7fuWsa6YYgjiNb4yLNNWCdudF
   MksJECql6eSrO9SNKUcOb5A1nV70S9PAaxP0bUbtnj7Crf8877vibAD1m
   AHr3Ba/wHrCThG53hhVn20M4ziQA6W3mmRguhp4tokvszIgqU7C1Hyynk
   Go5NlA94kmXAK+/MVz2uP1KtREJjopkOlLk7CkeQbTH4dSOJj46MTyDy3
   x/qvR1F/N/9e2YnL7LgODyO9eBNft+HF4UUUNZnnDPadGrP7PL9RHi2Bk
   9aAVWBkydbp9T7SSqMEErGepkrldtLUM1ckYA1u2HiBZshTo1mVR+++dV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012666"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445319"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445319"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:22 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 88AEF312C0;
        Tue, 17 Oct 2023 11:54:19 +0100 (IST)
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
Subject: [PATCH net-next v2 05/11] hinic: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:35 +0200
Message-Id: <20231017105341.415466-6-przemyslaw.kitszel@intel.com>
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
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-317 (-317)
---
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 217 +++++-------------
 1 file changed, 56 insertions(+), 161 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 1749d26f4bef..03e42512a2d5 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -315,220 +315,115 @@ void hinic_devlink_unregister(struct hinic_devlink_priv *priv)
 	devlink_unregister(devlink);
 }
 
-static int chip_fault_show(struct devlink_fmsg *fmsg,
-			   struct hinic_fault_event *event)
+static void chip_fault_show(struct devlink_fmsg *fmsg,
+			    struct hinic_fault_event *event)
 {
 	const char * const level_str[FAULT_LEVEL_MAX + 1] = {
 		"fatal", "reset", "flr", "general", "suggestion", "Unknown"};
 	u8 fault_level;
-	int err;
 
 	fault_level = (event->event.chip.err_level < FAULT_LEVEL_MAX) ?
 		event->event.chip.err_level : FAULT_LEVEL_MAX;
-	if (fault_level == FAULT_LEVEL_SERIOUS_FLR) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "Function level err func_id",
-						(u32)event->event.chip.func_id);
-		if (err)
-			return err;
-	}
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "module_id", event->event.chip.node_id);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_type", (u32)event->event.chip.err_type);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "err_level", level_str[fault_level]);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_addr",
-					event->event.chip.err_csr_addr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_value",
-					event->event.chip.err_csr_value);
-	if (err)
-		return err;
-
-	return 0;
+	if (fault_level == FAULT_LEVEL_SERIOUS_FLR)
+		devlink_fmsg_u32_pair_put(fmsg, "Function level err func_id",
+					  (u32)event->event.chip.func_id);
+	devlink_fmsg_u8_pair_put(fmsg, "module_id", event->event.chip.node_id);
+	devlink_fmsg_u32_pair_put(fmsg, "err_type", (u32)event->event.chip.err_type);
+	devlink_fmsg_string_pair_put(fmsg, "err_level", level_str[fault_level]);
+	devlink_fmsg_u32_pair_put(fmsg, "err_csr_addr",
+				  event->event.chip.err_csr_addr);
+	devlink_fmsg_u32_pair_put(fmsg, "err_csr_value",
+				  event->event.chip.err_csr_value);
 }
 
-static int fault_report_show(struct devlink_fmsg *fmsg,
-			     struct hinic_fault_event *event)
+static void fault_report_show(struct devlink_fmsg *fmsg,
+			      struct hinic_fault_event *event)
 {
 	const char * const type_str[FAULT_TYPE_MAX + 1] = {
 		"chip", "ucode", "mem rd timeout", "mem wr timeout",
 		"reg rd timeout", "reg wr timeout", "phy fault", "Unknown"};
 	u8 fault_type;
-	int err;
 
 	fault_type = (event->type < FAULT_TYPE_MAX) ? event->type : FAULT_TYPE_MAX;
 
-	err = devlink_fmsg_string_pair_put(fmsg, "Fault type", type_str[fault_type]);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_binary_pair_put(fmsg, "Fault raw data",
-					   event->event.val, sizeof(event->event.val));
-	if (err)
-		return err;
+	devlink_fmsg_string_pair_put(fmsg, "Fault type", type_str[fault_type]);
+	devlink_fmsg_binary_pair_put(fmsg, "Fault raw data", event->event.val,
+				     sizeof(event->event.val));
 
 	switch (event->type) {
 	case FAULT_TYPE_CHIP:
-		err = chip_fault_show(fmsg, event);
-		if (err)
-			return err;
+		chip_fault_show(fmsg, event);
 		break;
 	case FAULT_TYPE_UCODE:
-		err = devlink_fmsg_u8_pair_put(fmsg, "Cause_id", event->event.ucode.cause_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "core_id", event->event.ucode.core_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "c_id", event->event.ucode.c_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "epc", event->event.ucode.epc);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "Cause_id", event->event.ucode.cause_id);
+		devlink_fmsg_u8_pair_put(fmsg, "core_id", event->event.ucode.core_id);
+		devlink_fmsg_u8_pair_put(fmsg, "c_id", event->event.ucode.c_id);
+		devlink_fmsg_u8_pair_put(fmsg, "epc", event->event.ucode.epc);
 		break;
 	case FAULT_TYPE_MEM_RD_TIMEOUT:
 	case FAULT_TYPE_MEM_WR_TIMEOUT:
-		err = devlink_fmsg_u32_pair_put(fmsg, "Err_csr_ctrl",
-						event->event.mem_timeout.err_csr_ctrl);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_data",
-						event->event.mem_timeout.err_csr_data);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "ctrl_tab",
-						event->event.mem_timeout.ctrl_tab);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "mem_index",
-						event->event.mem_timeout.mem_index);
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "Err_csr_ctrl",
+					  event->event.mem_timeout.err_csr_ctrl);
+		devlink_fmsg_u32_pair_put(fmsg, "err_csr_data",
+					  event->event.mem_timeout.err_csr_data);
+		devlink_fmsg_u32_pair_put(fmsg, "ctrl_tab",
+					  event->event.mem_timeout.ctrl_tab);
+		devlink_fmsg_u32_pair_put(fmsg, "mem_index",
+					  event->event.mem_timeout.mem_index);
 		break;
 	case FAULT_TYPE_REG_RD_TIMEOUT:
 	case FAULT_TYPE_REG_WR_TIMEOUT:
-		err = devlink_fmsg_u32_pair_put(fmsg, "Err_csr", event->event.reg_timeout.err_csr);
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "Err_csr", event->event.reg_timeout.err_csr);
 		break;
 	case FAULT_TYPE_PHY_FAULT:
-		err = devlink_fmsg_u8_pair_put(fmsg, "Op_type", event->event.phy_fault.op_type);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "port_id", event->event.phy_fault.port_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "dev_ad", event->event.phy_fault.dev_ad);
-		if (err)
-			return err;
-
-		err = devlink_fmsg_u32_pair_put(fmsg, "csr_addr", event->event.phy_fault.csr_addr);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "op_data", event->event.phy_fault.op_data);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "Op_type", event->event.phy_fault.op_type);
+		devlink_fmsg_u8_pair_put(fmsg, "port_id", event->event.phy_fault.port_id);
+		devlink_fmsg_u8_pair_put(fmsg, "dev_ad", event->event.phy_fault.dev_ad);
+		devlink_fmsg_u32_pair_put(fmsg, "csr_addr", event->event.phy_fault.csr_addr);
+		devlink_fmsg_u32_pair_put(fmsg, "op_data", event->event.phy_fault.op_data);
 		break;
 	default:
 		break;
 	}
-
-	return 0;
 }
 
 static int hinic_hw_reporter_dump(struct devlink_health_reporter *reporter,
 				  struct devlink_fmsg *fmsg, void *priv_ctx,
 				  struct netlink_ext_ack *extack)
 {
 	if (priv_ctx)
-		return fault_report_show(fmsg, priv_ctx);
+		fault_report_show(fmsg, priv_ctx);
 
 	return 0;
 }
 
-static int mgmt_watchdog_report_show(struct devlink_fmsg *fmsg,
-				     struct hinic_mgmt_watchdog_info *watchdog_info)
+static void mgmt_watchdog_report_show(struct devlink_fmsg *fmsg,
+				      struct hinic_mgmt_watchdog_info *winfo)
 {
-	int err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "Mgmt deadloop time_h", watchdog_info->curr_time_h);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "time_l", watchdog_info->curr_time_l);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "task_id", watchdog_info->task_id);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "sp", watchdog_info->sp);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_current_used", watchdog_info->curr_used);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "peak_used", watchdog_info->peak_used);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "\n Overflow_flag", watchdog_info->is_overflow);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_top", watchdog_info->stack_top);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_bottom", watchdog_info->stack_bottom);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "mgmt_pc", watchdog_info->pc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "lr", watchdog_info->lr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cpsr", watchdog_info->cpsr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_binary_pair_put(fmsg, "Mgmt register info",
-					   watchdog_info->reg, sizeof(watchdog_info->reg));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_binary_pair_put(fmsg, "Mgmt dump stack(start from sp)",
-					   watchdog_info->data, sizeof(watchdog_info->data));
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_u32_pair_put(fmsg, "Mgmt deadloop time_h", winfo->curr_time_h);
+	devlink_fmsg_u32_pair_put(fmsg, "time_l", winfo->curr_time_l);
+	devlink_fmsg_u32_pair_put(fmsg, "task_id", winfo->task_id);
+	devlink_fmsg_u32_pair_put(fmsg, "sp", winfo->sp);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_current_used", winfo->curr_used);
+	devlink_fmsg_u32_pair_put(fmsg, "peak_used", winfo->peak_used);
+	devlink_fmsg_u32_pair_put(fmsg, "\n Overflow_flag", winfo->is_overflow);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_top", winfo->stack_top);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_bottom", winfo->stack_bottom);
+	devlink_fmsg_u32_pair_put(fmsg, "mgmt_pc", winfo->pc);
+	devlink_fmsg_u32_pair_put(fmsg, "lr", winfo->lr);
+	devlink_fmsg_u32_pair_put(fmsg, "cpsr", winfo->cpsr);
+	devlink_fmsg_binary_pair_put(fmsg, "Mgmt register info", winfo->reg,
+				     sizeof(winfo->reg));
+	devlink_fmsg_binary_pair_put(fmsg, "Mgmt dump stack(start from sp)",
+				     winfo->data, sizeof(winfo->data));
 }
 
 static int hinic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 				  struct devlink_fmsg *fmsg, void *priv_ctx,
 				  struct netlink_ext_ack *extack)
 {
 	if (priv_ctx)
-		return mgmt_watchdog_report_show(fmsg, priv_ctx);
+		mgmt_watchdog_report_show(fmsg, priv_ctx);
 
 	return 0;
 }
-- 
2.40.1

