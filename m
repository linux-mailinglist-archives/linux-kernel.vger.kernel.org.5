Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269FB756DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGQTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGQTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:55:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA5134;
        Mon, 17 Jul 2023 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623698; x=1721159698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SCVtq0jwJnIgDEqSUfdMECCxn6Y1V/lCZdkQvBUQFQ=;
  b=JhQ3cDb4CepQ1TI6LNZVwwll9qkPsUNy+OlEFYn6wQckhmJs6MPi7+wA
   Muw+nXNfwnZGIcoqsqrUGjNH3wi5ienB4gbaEYuLkX7jlZotsW64QDg9/
   NIQ9y7h711I7upAa+4pUGfJhJHdIDgQ3K98A98BNcYYR5tjuD2jhiNtde
   9u7zjnfWrbXiwwsBtl4uFp8ZtB/PGA+CcLgjORD0UHGMNwAsfPU4tozkw
   5RIoHAqO/BVMvvl4zEmV4BaXbeJLfqR+/ydFrjhilT4mv7atCpcyrpjjU
   g2a5crmasFpNs+96R9j8OL4X2/mGoCgQjBvJmsCT81MOMu0OvlK40AC5h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064615"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770763"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770763"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:55 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 6/7] thermal/drivers/int340x: Support workload hint interrupts
Date:   Mon, 17 Jul 2023 12:54:04 -0700
Message-Id: <20230717195405.730869-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On thermal device interrupt, if the interrupt is generated for passing
workload hint, call the callback to pass notification to the user
space.

First call proc_thermal_check_wlt_intr() to check interrupt, if this
callback returns true, wake IRQ thread. Call
proc_thermal_wlt_intr_callback() to notify user space.

While here remove function pkg_thermal_schedule_work() and move the
processing to the caller. The function pkg_thermal_schedule_work() just
called schedule_delayed_work().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
No change

 .../processor_thermal_device_pci.c            | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ee5a4c227d96..83177ed9db49 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -115,27 +115,40 @@ static void proc_thermal_threshold_work_fn(struct work_struct *work)
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
 }
 
-static void pkg_thermal_schedule_work(struct delayed_work *work)
+static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 {
-	unsigned long ms = msecs_to_jiffies(notify_delay_ms);
+	struct proc_thermal_pci *pci_info = devid;
+
+	proc_thermal_wlt_intr_callback(pci_info->pdev, pci_info->proc_priv);
 
-	schedule_delayed_work(work, ms);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
+	struct proc_thermal_device *proc_priv;
+	int ret = IRQ_HANDLED;
 	u32 status;
 
+	proc_priv = pci_info->proc_priv;
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WLT_HINT) {
+		if (proc_thermal_check_wlt_intr(pci_info->proc_priv))
+			ret = IRQ_WAKE_THREAD;
+	}
+
 	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
+	if (status) {
+		unsigned long ms = msecs_to_jiffies(notify_delay_ms);
 
-	/* Disable enable interrupt flag */
-	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		/* Disable enable interrupt flag */
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		schedule_delayed_work(&pci_info->work, ms);
+	}
 	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
 
-	pkg_thermal_schedule_work(&pci_info->work);
-
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
@@ -269,7 +282,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, NULL,
+					proc_thermal_irq_handler, proc_thermal_irq_thread_handler,
 					irq_flag, KBUILD_MODNAME, pci_info);
 	if (ret) {
 		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
@@ -383,6 +396,8 @@ static struct pci_driver proc_thermal_pci_driver = {
 
 module_pci_driver(proc_thermal_pci_driver);
 
+MODULE_IMPORT_NS(INT340X_THERMAL);
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.38.1

