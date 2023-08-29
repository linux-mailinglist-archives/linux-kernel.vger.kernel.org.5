Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6BF78BC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjH2AYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjH2AXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA9107;
        Mon, 28 Aug 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693268630; x=1724804630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvHC1y4lOrtaQ/HgDf+bS4CwG+MFrfnU69GuHDQTE5M=;
  b=TGDJzakQRO4zCtmQ0dY2oUJF9Kkp/bICS8PcGD5qKXLORAX2tHMbMEc6
   2fXVJVHLKe6vFN9kA8GLHJqX/pXGRVIqkJQ5WsirdwDMSgIZsGgbQbIkx
   ufJe2k1cE7IUJmKgV9DlFElxh5dZEwJFLto8IyfhEvAs7UIBWPVH9YJeq
   s0L/8KdTwngh/7rx0vcVbiv1GQ7QaLjhfkSeosmbRULed4SfECxExKPva
   5vRfl6AZj2O4CRHilFv/i1OK9QxEfiYS4YxmN5v3BSPdhcJw/A1P/5vhN
   5ot5FlbYRHu2wWKQK0QUAPBNhR5o6T9VtRZ6D4GAfPV3KNEysysYY3PCh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354754227"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="354754227"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="731989687"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="731989687"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 17:23:47 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/7] thermal: int340x: processor_thermal: Use non MSI interrupts by default
Date:   Mon, 28 Aug 2023 17:23:42 -0700
Message-Id: <20230829002346.2104251-4-srinivas.pandruvada@linux.intel.com>
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

There are issues in using MSI interrupts for processor thermal device.
The support is not consistent across generations. But the legacy PCI
interrupts work on all current generations.

Hence always use legacy PCI interrupts by default, instead of MSI.
Add a module param to use of MSI, so that MSI can be still used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
Address comments from Rafel for:
replace variable msi_enabled to use_msi
Add bus mastering for legacy PCI, even if it doesn't make any difference
Use module param along with pci device msi enabled to use MSI

v2:
Changed msi_enabled to type bool

 .../processor_thermal_device_pci.c            | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 314a726f35c7..f736688abe9b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -15,6 +15,11 @@
 
 #define DRV_NAME "proc_thermal_pci"
 
+static bool use_msi;
+module_param(use_msi, bool, 0644);
+MODULE_PARM_DESC(use_msi,
+	"Use PCI MSI based interrupts for processor thermal device.");
+
 struct proc_thermal_pci {
 	struct pci_dev *pdev;
 	struct proc_thermal_device *proc_priv;
@@ -203,6 +208,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	struct proc_thermal_device *proc_priv;
 	struct proc_thermal_pci *pci_info;
 	int irq_flag = 0, irq, ret;
+	bool msi_irq = false;
 
 	proc_priv = devm_kzalloc(&pdev->dev, sizeof(*proc_priv), GFP_KERNEL);
 	if (!proc_priv)
@@ -248,16 +254,21 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		goto err_ret_mmio;
 	}
 
-	/* request and enable interrupt */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
-		goto err_ret_tzone;
-	}
-	if (!pdev->msi_enabled && !pdev->msix_enabled)
+	if (use_msi && (pdev->msi_enabled || pdev->msix_enabled)) {
+		/* request and enable interrupt */
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to allocate vectors!\n");
+			goto err_ret_tzone;
+		}
+
+		irq =  pci_irq_vector(pdev, 0);
+		msi_irq = true;
+	} else {
 		irq_flag = IRQF_SHARED;
+		irq = pdev->irq;
+	}
 
-	irq =  pci_irq_vector(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					proc_thermal_irq_handler, NULL,
 					irq_flag, KBUILD_MODNAME, pci_info);
@@ -273,7 +284,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	return 0;
 
 err_free_vectors:
-	pci_free_irq_vectors(pdev);
+	if (msi_irq)
+		pci_free_irq_vectors(pdev);
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
 err_ret_mmio:
-- 
2.40.1

