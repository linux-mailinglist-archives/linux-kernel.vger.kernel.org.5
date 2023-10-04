Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17D7B768C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbjJDCEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjJDCED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5363CC8;
        Tue,  3 Oct 2023 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384992; x=1727920992;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=uXsaRxl1cg960R4xfYGboSA0ReN1bHlkZDKxInnxuzY=;
  b=HYspSFQjxgeXKh5tv0HJzIxnBvT/XvOsAwepVQblzCJwdwApggYSJAWc
   rzyg/na9G7thuC7rXoAPXRIX4MgsVtU0/nKwGUehTwgsK1oeWoDZn1Lrl
   KK/6F0ELfhagLEMbiRN+B9jIbGJdhU3xU7Raao9u/Za5zSno0mIbiKfM7
   oMMNZU7zVNOL/DyRQN3TgmuXKdE3qEQLfrSuRSfo73FsJ9uWpQBgXvCKh
   OKeH4e3V/7/Y0dT4nvluxwmmdFM32TzFvpP79Wm5wSUfsEY+gnPoAnrzP
   HsNANd1onmxeSg/ucRObIQBI93RxDoWIcKLqDxIWtnx3lieSsdyOYHJJE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1625877"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1625877"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700926305"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="700926305"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id BAFC6580C73;
        Tue,  3 Oct 2023 19:02:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 12/13] platform/x86/intel/pmc: Read low power mode requirements for MTL-M and MTL-P
Date:   Tue,  3 Oct 2023 19:02:21 -0700
Message-Id: <20231004020222.193445-13-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

Add support to read the low power mode requirements for Meteor Lake M and
Meteor Lake P.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V2 - fixed unused return value

 drivers/platform/x86/intel/pmc/mtl.c | 41 +++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 780874142a90..78c9a80bd929 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -11,6 +11,13 @@
 #include <linux/pci.h>
 #include "core.h"
 
+/* PMC SSRAM PMT Telemetry GUIDS */
+#define SOCP_LPM_REQ_GUID	0x2625030
+#define IOEM_LPM_REQ_GUID	0x4357464
+#define IOEP_LPM_REQ_GUID	0x5077612
+
+static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 /*
  * Die Mapping to Product.
  * Product SOCDie IOEDie PCHDie
@@ -465,6 +472,7 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_sts = mtl_socm_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioep_pfear_map[] = {
@@ -782,6 +790,13 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
 	.ltr_show_sts = mtl_ioep_ltr_show_map,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
+	.lpm_num_maps = ADL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
+	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
+	.lpm_en_offset = MTL_LPM_EN_OFFSET,
+	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioem_pfear_map[] = {
@@ -922,6 +937,13 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
 	.ltr_show_sts = mtl_ioep_ltr_show_map,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
+	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
+	.lpm_num_maps = ADL_LPM_NUM_MAPS,
+	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
+	.lpm_en_offset = MTL_LPM_EN_OFFSET,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 #define PMC_DEVID_SOCM	0x7e7f
@@ -929,16 +951,19 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
 #define PMC_DEVID_IOEM	0x7ebf
 static struct pmc_info mtl_pmc_info_list[] = {
 	{
-		.devid = PMC_DEVID_SOCM,
-		.map = &mtl_socm_reg_map,
+		.guid	= SOCP_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_SOCM,
+		.map	= &mtl_socm_reg_map,
 	},
 	{
-		.devid = PMC_DEVID_IOEP,
-		.map = &mtl_ioep_reg_map,
+		.guid	= IOEP_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_IOEP,
+		.map	= &mtl_ioep_reg_map,
 	},
 	{
-		.devid = PMC_DEVID_IOEM,
-		.map = &mtl_ioem_reg_map
+		.guid	= IOEM_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_IOEM,
+		.map	= &mtl_ioem_reg_map
 	},
 	{}
 };
@@ -1012,5 +1037,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 	pmc_core_send_ltr_ignore(pmcdev, 3);
 
-	return 0;
+	ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
+
+	return ret;
 }
-- 
2.34.1

