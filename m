Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C27AF6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjIZXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjIZXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418EA1BFB;
        Tue, 26 Sep 2023 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695769095; x=1727305095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGBmkv18AJ8NQSetLizt3WEiHIboDKU+3XyS5pnAK38=;
  b=XiKOksCMudTRcp44rDc6i8At5MKK0yoT/QFnbiM/HAbRne/N2hLlQtyL
   fITc3J6UXF8HHYK7U6VkA1ELC48DvJEORX/z/CMndZCMACchjEKnxh+WB
   esxlC4YZPX3aLSbOblK3NUbQK5ZXR+9RAwQuKl9jjcXBCp9dZLIKAfyNR
   bMvhQCCjUUde4XlTRL58CQnBNVT847IJj1FWoyzbr9pzRSqerZB21N+Yx
   4xmrJRNmPqBqWqGaoGrKlLpr+v/kj348jqMOSE0xUFrOCLeHr1WaVRr6l
   HKolqJCGFAAlwhRVhIWEwluWIbTAwOw3dgPfJ80RjWsA+0n/5QurQU4LK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412599580"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412599580"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752346082"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752346082"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 15:58:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/5] thermal: int340x: processor_thermal: Set feature mask before proc_thermal_add
Date:   Tue, 26 Sep 2023 15:58:09 -0700
Message-Id: <20230926225813.995948-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com>
References: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function proc_thermal_add() adds sysfs entries for power limits.
The feature mask of available features is not present by this time.
If feature mask is available, then this can be used to selectively
create attributes.

Feature mask is set during call to proc_thermal_mmio_add(). Change the
order of calls so that proc_thermal_mmio_add() is called before
proc_thermal_add().

There is no functional impact with this change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device_pci.c            | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 3c5ced79ead0..e2c7beb91c60 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -253,19 +253,19 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
 	INIT_DELAYED_WORK(&pci_info->work, proc_thermal_threshold_work_fn);
 
-	ret = proc_thermal_add(&pdev->dev, proc_priv);
-	if (ret) {
-		dev_err(&pdev->dev, "error: proc_thermal_add, will continue\n");
-		pci_info->no_legacy = 1;
-	}
-
 	proc_priv->priv_data = pci_info;
 	pci_info->proc_priv = proc_priv;
 	pci_set_drvdata(pdev, proc_priv);
 
 	ret = proc_thermal_mmio_add(pdev, proc_priv, id->driver_data);
 	if (ret)
-		goto err_ret_thermal;
+		return ret;
+
+	ret = proc_thermal_add(&pdev->dev, proc_priv);
+	if (ret) {
+		dev_err(&pdev->dev, "error: proc_thermal_add, will continue\n");
+		pci_info->no_legacy = 1;
+	}
 
 	psv_trip.temperature = get_trip_temp(pci_info);
 
@@ -275,7 +275,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
 		ret = PTR_ERR(pci_info->tzone);
-		goto err_ret_mmio;
+		goto err_del_legacy;
 	}
 
 	if (use_msi && (pdev->msi_enabled || pdev->msix_enabled)) {
@@ -312,11 +312,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		pci_free_irq_vectors(pdev);
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
-err_ret_mmio:
-	proc_thermal_mmio_remove(pdev, proc_priv);
-err_ret_thermal:
+err_del_legacy:
 	if (!pci_info->no_legacy)
 		proc_thermal_remove(proc_priv);
+	proc_thermal_mmio_remove(pdev, proc_priv);
 	pci_disable_device(pdev);
 
 	return ret;
-- 
2.41.0

