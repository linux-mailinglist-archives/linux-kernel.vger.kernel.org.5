Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462607BEA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378358AbjJITGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbjJITGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0049D;
        Mon,  9 Oct 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878362; x=1728414362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXy3qAy84UAqa6rr2FC6hF0O3EtdwdGB+Op/XW6RxRI=;
  b=T1mX5qCJKK7PTml59axXhYzNjKt6MfcySzzCg1fapa//Smxc5G1Xz76i
   Jfys0Ji7j44zJZUkjrUiWL/1vcPB8fyjSRc5cnWUa8Abv2t0aPukd8s9u
   a3rsInM0/72QE2urVx3PQHk04qfZPEhPL7WXfE2kvwm5WmPKEoAOrz+MA
   QVUDQFwhaj/3lbHqen9Rrpti94jEj4KMFpKUW9PwNwyusidf1Fj9PZ+Ih
   awut9Echf/oeNkLoTCDe50NvdcLMjAFgLoqoTprcdmDrSl7PHmT07i7jd
   Rf8nFUSF3lZcWlkg8DklWw5MTk0uTScAklGaSAcsWptEsnJR885ka9lLQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213774"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213774"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445845"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445845"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/7] thermal: int340x: processor_thermal: Set feature mask before proc_thermal_add
Date:   Mon,  9 Oct 2023 12:05:34 -0700
Message-Id: <20231009190538.2488792-4-srinivas.pandruvada@linux.intel.com>
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
v2:
No change

 .../processor_thermal_device_pci.c            | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index d353a190ce44..ae70fabffb2d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -266,19 +266,19 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
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
 
@@ -288,7 +288,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
 		ret = PTR_ERR(pci_info->tzone);
-		goto err_ret_mmio;
+		goto err_del_legacy;
 	}
 
 	if (use_msi && (pdev->msi_enabled || pdev->msix_enabled)) {
@@ -325,11 +325,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
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
2.40.1

