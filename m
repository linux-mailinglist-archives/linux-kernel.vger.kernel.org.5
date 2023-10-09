Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC47BEA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378312AbjJITGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbjJITGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99072AC;
        Mon,  9 Oct 2023 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878361; x=1728414361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0pSvviFA5AoruGIntOrKR03lWulECbMxsPJ5KXdB0o=;
  b=OoPN8y0sXNkE4Z63ZzirpcI8VbUdoOmyY9pzdOPJrQ87ji2R3RxF7A8Y
   +JLWA2+J2JwQhS9+ONWvN5XFYLEXRQsXDQCvI2hl0P8/XgShDnsQSVcI4
   OZfnqcDXxJF6mzQ4F76ZenuCC2fR7FbnvN/NYH9hw0Eyx6fE1xHCexMo1
   gsmfziN/w+2aXgM4xW8xV6CRQH8H411cbU9k21dwKLzuc3G1zwJXgPTP4
   7qEgN5iL7sQGfD8YqwT1miTaCHET5UL6Q0dm0YyZxkaV0ccdoy9a2mM4J
   HUFJ8E9f+aTgwHxTCPxUHy+uTt2jMeZpTymxiiKdtSFX4+BsMeZHfQdak
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213771"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213771"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445842"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445842"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/7] thermal: int340x: processor_thermal: Common function to clear SOC interrupt
Date:   Mon,  9 Oct 2023 12:05:33 -0700
Message-Id: <20231009190538.2488792-3-srinivas.pandruvada@linux.intel.com>
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

The SOC interrupt status register contains multiple interrupt sources
(workload hint interrupt and power floor interrupt). This is not possible
to clear individual interrupt source with read-modify-write, as it may
clear the new interrupt from the firmware after read operation. This is
also not possible to set the interrupt status bit to 1 for the other
interrupt source, which is not part of clearing.

Hence create a common function, which does clear all status bits at once.
Call this function after processing all interrupt sources.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- New patch in the series

 .../int340x_thermal/processor_thermal_device.h      |  1 +
 .../int340x_thermal/processor_thermal_device_pci.c  | 13 +++++++++++++
 .../int340x_thermal/processor_thermal_wt_hint.c     |  2 --
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 8ed6e8e94c8a..f9a381b3e55c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -92,6 +92,7 @@ void proc_thermal_wt_req_remove(struct pci_dev *pdev);
 #define MBOX_DATA_BIT_VALID		31
 
 #define SOC_WT_RES_INT_STATUS_OFFSET	0x5B18
+#define SOC_WT_RES_INT_STATUS_MASK	GENMASK_ULL(3, 2)
 
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 3c5ced79ead0..d353a190ce44 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -122,11 +122,24 @@ static void pkg_thermal_schedule_work(struct delayed_work *work)
 	schedule_delayed_work(work, ms);
 }
 
+static void proc_thermal_clear_soc_int_status(struct proc_thermal_device *proc_priv)
+{
+	u64 status;
+
+	if (!(proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT))
+		return;
+
+	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	writeq(status & ~SOC_WT_RES_INT_STATUS_MASK,
+	       proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+}
+
 static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
 
 	proc_thermal_wt_intr_callback(pci_info->pdev, pci_info->proc_priv);
+	proc_thermal_clear_soc_int_status(pci_info->proc_priv);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
index c08838eb10c8..9d5e4c169d1b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -215,8 +215,6 @@ void proc_thermal_wt_intr_callback(struct pci_dev *pdev, struct proc_thermal_dev
 	if (!(status & SOC_WT_PREDICTION_INT_ACTIVE))
 		return;
 
-	writeq(status & ~SOC_WT_PREDICTION_INT_ACTIVE,
-		       proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
 	sysfs_notify(&pdev->dev.kobj, "workload_hint", "workload_type_index");
 }
 EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_intr_callback, INT340X_THERMAL);
-- 
2.40.1

