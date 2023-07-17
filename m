Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34521756DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGQTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGQTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:54:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63981B1;
        Mon, 17 Jul 2023 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623693; x=1721159693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTo3Yud6uChlFvaxyEtnYv/+Do5A9H0JVT6jB8D4gS8=;
  b=nO/xRwfUfPbcGt83BIXUM4r+7jXuma8kTmvIGyPG+6x425zpBYfd6SbV
   2rTcdkwi4466EkoLNvnyVxEvw/K1Xmv+nbCkKMpeXD5o7Kt7usxGbYEP9
   7ezsLiJP66KmgLqZahOgCHLtQIjUOW4FO+rH/nt0r2aEUyvTV12no2mO4
   Qiyu615Uaz22Tb824FAtyS36XWVwx63XR/6lAn6U6H91yrebb59BeGS55
   nWhoVnbLFjKnXbFG0dNBAAY94vcdoS/IL5wAMSLn0htjDiVpyXzEKzjKX
   hdin0ZOyw4LCZD3QxSHx963IpK7rKK1zfsEtIYVkyR3y/wk68EXM5ZguM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064602"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770748"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770748"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/7] thermal: int340x: processor_thermal: Use non MSI interrupts
Date:   Mon, 17 Jul 2023 12:54:01 -0700
Message-Id: <20230717195405.730869-4-srinivas.pandruvada@linux.intel.com>
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

There are issues in using MSI interrupts for processor thermal device.
The support is not consistent across generations. But the legacy PCI
interrupts work on all current generations.

Hence always use legacy PCI interrupts by default, instead of MSI.
Add a module param to use of MSI, so that MSI can be still used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Changed msi_enabled to type bool

 .../processor_thermal_device_pci.c            | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 5a2bcfff0a68..2be9b7f660d1 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -15,6 +15,11 @@
 
 #define DRV_NAME "proc_thermal_pci"
 
+static bool msi_enabled;
+module_param(msi_enabled, bool, 0644);
+MODULE_PARM_DESC(msi_enabled,
+	"Use PCI MSI based interrupts for processor thermal device.");
+
 struct proc_thermal_pci {
 	struct pci_dev *pdev;
 	struct proc_thermal_device *proc_priv;
@@ -219,8 +224,6 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		return ret;
 	}
 
-	pci_set_master(pdev);
-
 	INIT_DELAYED_WORK(&pci_info->work, proc_thermal_threshold_work_fn);
 
 	ret = proc_thermal_add(&pdev->dev, proc_priv);
@@ -248,16 +251,23 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		goto err_ret_mmio;
 	}
 
-	/* request and enable interrupt */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
-		goto err_ret_tzone;
-	}
-	if (!pdev->msi_enabled && !pdev->msix_enabled)
+	if (msi_enabled) {
+		pci_set_master(pdev);
+		/* request and enable interrupt */
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to allocate vectors!\n");
+			goto err_ret_tzone;
+		}
+		if (!pdev->msi_enabled && !pdev->msix_enabled)
+			irq_flag = IRQF_SHARED;
+
+		irq =  pci_irq_vector(pdev, 0);
+	} else {
 		irq_flag = IRQF_SHARED;
+		irq = pdev->irq;
+	}
 
-	irq =  pci_irq_vector(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					proc_thermal_irq_handler, NULL,
 					irq_flag, KBUILD_MODNAME, pci_info);
@@ -273,7 +283,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	return 0;
 
 err_free_vectors:
-	pci_free_irq_vectors(pdev);
+	if (msi_enabled)
+		pci_free_irq_vectors(pdev);
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
 err_ret_mmio:
-- 
2.38.1

