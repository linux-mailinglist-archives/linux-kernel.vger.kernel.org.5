Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67C7BEA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbjJITGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbjJITGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F3DAF;
        Mon,  9 Oct 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878362; x=1728414362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gt0OEXf5yCXtZ8JHNFgavK0pqZGrMUKjiML+Ljc5m7M=;
  b=LpJyOJlkeiCJYMw2iWcAH9Bl0yVYWe2kb70MG/VNWUyJZtAtzd7Vgmoa
   f1AXmAmeHPza7yQFIgWYXQRspprumgScrJlwEJoODvTsCgYBUBxinKx/v
   G6MH4aM72daNMC+5iGywxRzAAmyxbmBeAud+rEwbY/VL9OpR1lTg72ltN
   20wfc2nkmQmrB48Yjcdhmy1Pz788WHsYogQpwBKechxPSLjBPKO2rdOJp
   dKbG3wHuwWA4R+YsPWuoBrvVxgLW97aNUNj9scLDaURoxXDIpyf4IKPj/
   Y31/44aY5fGQLW2dx8p9Mt+ufdOYJkfr8KrWUlSFIa95XLdM43iVt6yVS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213780"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213780"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445851"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445851"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 5/7] thermal: int340x: processor_thermal: Handle power floor interrupts
Date:   Mon,  9 Oct 2023 12:05:36 -0700
Message-Id: <20231009190538.2488792-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On thermal device interrupt, if the interrupt is generated for passing
power floor status, call the callback to pass notification to the user
space.

First call proc_thermal_check_power_floor_intr() to check interrupt, if
this callback returns true, wake the IRQ thread to call
proc_thermal_power_floor_intr_callback() to notify user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Use common interrupt clearing function to clear interrupt.
Previously it was cleared in the callback function
proc_thermal_power_floor_intr_callback().

 .../intel/int340x_thermal/processor_thermal_device_pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ae70fabffb2d..4c2194f19ed2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -126,7 +126,8 @@ static void proc_thermal_clear_soc_int_status(struct proc_thermal_device *proc_p
 {
 	u64 status;
 
-	if (!(proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT))
+	if (!(proc_priv->mmio_feature_mask &
+	    (PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR)))
 		return;
 
 	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
@@ -139,6 +140,7 @@ static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 	struct proc_thermal_pci *pci_info = devid;
 
 	proc_thermal_wt_intr_callback(pci_info->pdev, pci_info->proc_priv);
+	proc_thermal_power_floor_intr_callback(pci_info->pdev, pci_info->proc_priv);
 	proc_thermal_clear_soc_int_status(pci_info->proc_priv);
 
 	return IRQ_HANDLED;
@@ -158,6 +160,11 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 			ret = IRQ_WAKE_THREAD;
 	}
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR) {
+		if (proc_thermal_check_power_floor_intr(pci_info->proc_priv))
+			ret = IRQ_WAKE_THREAD;
+	}
+
 	/*
 	 * Since now there are two sources of interrupts: one from thermal threshold
 	 * and another from workload hint, add a check if there was really a threshold
-- 
2.40.1

