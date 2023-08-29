Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85478BC17
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjH2AYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjH2AXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5B132;
        Mon, 28 Aug 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693268630; x=1724804630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oDiV9x4vh0Gd/Qfn0fopyBUXiHGswpCDdJCQ9Qg5fD8=;
  b=CMZ9bHLWf5XJQ2f+8xDyvTVVTHfoODxIbHBsayKiOEyUkgPj1xTlXQQR
   Ai7KajXY+28T7jxFYzPrkwo10wiWl67GxcH8X3fg3PUeZa4rGex5QGKE+
   fUnk9uhvd8NjUkDHWiJizQWo8+cXOiEZaYvhMWmFL7dIj/e0yEns4jA5g
   XodOxqvfoyaaGol9pXUhLWKpM7IAGSF3NYGoxDxEbsTtJuC0MlX/Ff0lG
   N5623vMmG8YuqcYMdiIJrGu+baO4nEDICvoEiEe8I3aJpIwO74IFIgijz
   xYAWWwaTn2x0V+kiJn3g1C/nyXEULZ/5zzFLZJOixDLDyHC7bkTzy2HRV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354754230"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="354754230"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="731989696"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="731989696"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 17:23:47 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 6/7] thermal/drivers/int340x: Support workload hint interrupts
Date:   Mon, 28 Aug 2023 17:23:45 -0700
Message-Id: <20230829002346.2104251-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On thermal device interrupt, if the interrupt is generated for passing
workload hint, call the callback to pass notification to the user
space.

First call proc_thermal_check_wt_intr() to check interrupt, if this
callback returns true, wake IRQ thread. Call
proc_thermal_wt_intr_callback() to notify user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
As suggested by Rafael:
- Undo the pkg_thermal_schedule_work() change to simlify
 
v2:
No change

 .../processor_thermal_device_pci.c            | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index eed59630fe59..7253277e476a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -122,20 +122,43 @@ static void pkg_thermal_schedule_work(struct delayed_work *work)
 	schedule_delayed_work(work, ms);
 }
 
+static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
+{
+	struct proc_thermal_pci *pci_info = devid;
+
+	proc_thermal_wt_intr_callback(pci_info->pdev, pci_info->proc_priv);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
+	struct proc_thermal_device *proc_priv;
+	int ret = IRQ_HANDLED;
 	u32 status;
 
-	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
+	proc_priv = pci_info->proc_priv;
 
-	/* Disable enable interrupt flag */
-	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
-	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT) {
+		if (proc_thermal_check_wt_intr(pci_info->proc_priv))
+			ret = IRQ_WAKE_THREAD;
+	}
 
-	pkg_thermal_schedule_work(&pci_info->work);
+	/*
+	 * Since now there are two sources of interrupts: one from thermal threshold
+	 * and another from workload hint, add a check if there was really a threshold
+	 * interrupt before scheduling work function for thermal threshold.
+	 */
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
+	if (status) {
+		/* Disable enable interrupt flag */
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
+		pkg_thermal_schedule_work(&pci_info->work);
+	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
@@ -270,7 +293,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, NULL,
+					proc_thermal_irq_handler, proc_thermal_irq_thread_handler,
 					irq_flag, KBUILD_MODNAME, pci_info);
 	if (ret) {
 		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
@@ -384,6 +407,8 @@ static struct pci_driver proc_thermal_pci_driver = {
 
 module_pci_driver(proc_thermal_pci_driver);
 
+MODULE_IMPORT_NS(INT340X_THERMAL);
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.40.1

