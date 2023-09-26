Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE287AF6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjIZXoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjIZXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04971FD9;
        Tue, 26 Sep 2023 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695769096; x=1727305096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrcoEgVELLZi6Sw6jH1sTR/5AVns7yOWGtEjy7HI65E=;
  b=OONX9y8w67U95kXqmgpqlxToGqHT+/rqh5N2eKMxyDsrZsVuultehI9J
   /bp4lyePtxhcB9bqEu/WWrbNXjj1eLgaSWYnaWFCtyMQl73RRijlNRwS7
   ihXJJ2doAuurRz8B932IK7ly+0yUCroznLxpcJf+UmhCGgOYX6DhM7WCi
   RJk8OZrtW1wzYB50z5aQfZKPCnJ3ID7aDlp49a2gGQ6ffTCDC4lXa8RHP
   RVDuBEA8Hdg2XHm5F9vqPwTc9VJs2xyAY7pilJRwSKV6bzhQqG4kFO4BO
   605nHjyc1qrkCHsJ4GemeNQLbvFkehhQ0p9HSOANhSlDP7Uhiy4iKUCx7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412599587"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412599587"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752346088"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752346088"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 15:58:15 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/5] thermal: int340x: processor_thermal: Handle power floor interrupts
Date:   Tue, 26 Sep 2023 15:58:11 -0700
Message-Id: <20230926225813.995948-4-srinivas.pandruvada@linux.intel.com>
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

On thermal device interrupt, if the interrupt is generated for passing
power floor status, call the callback to pass notification to the user
space.

First call proc_thermal_check_power_floor_intr() to check interrupt, if
this callback returns true, wake the IRQ thread to call
proc_thermal_power_floor_intr_callback() to notify user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index e2c7beb91c60..a5accc290a3d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -127,6 +127,7 @@ static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 	struct proc_thermal_pci *pci_info = devid;
 
 	proc_thermal_wt_intr_callback(pci_info->pdev, pci_info->proc_priv);
+	proc_thermal_power_floor_intr_callback(pci_info->pdev, pci_info->proc_priv);
 
 	return IRQ_HANDLED;
 }
@@ -145,6 +146,11 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
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
2.41.0

