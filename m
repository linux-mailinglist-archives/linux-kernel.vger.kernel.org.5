Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C17ABB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjIVVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIVVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC43C1;
        Fri, 22 Sep 2023 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418234; x=1726954234;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ShdByvzHZrIatOiiLohtDB7ahuIepttl4FPmXc1tWd0=;
  b=L2kIgiJAHiWoqzcB+ojIgpaqg5V9hZNZcNXdEm4qW+js73H3Px64mLir
   xZSiKNvWQs0yJfHUN+bgefWZRU2hoCCFSjVz5bvDGjDoYnZQGujr8mArF
   sbJhTgMCY72FdyaOMQuj2V/vdTpUMeqvvj7Iwtsrd9ttDLJKOfcBzBKfh
   RAOt53x1PQoMQR77fAS7jbncgbvfU6PxNKC7RJf9eY0uEgxjkJNoB8K3k
   RIsT1PcMr3tzMttwrJKT0sqMYftaZ39EwjH7YYO9nePeCYBcJ99RqG26m
   ud7xhFt6peY5wYfj7SBAOp4WM30dOUD3cK1NRHC3N8YOBQTZ6KLwYUf2o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="379828421"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="379828421"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813237856"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="813237856"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:34 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id E98B8580DB2;
        Fri, 22 Sep 2023 14:30:33 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 10/11] platform/x86/intel/pmc: Read low power mode requirements for MTL-M and MTL-P
Date:   Fri, 22 Sep 2023 14:30:31 -0700
Message-Id: <20230922213032.1770590-11-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922213032.1770590-1-david.e.box@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/platform/x86/intel/pmc/mtl.c | 39 +++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 780874142a90..c2ac50cfdd51 100644
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
 
+	ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
+
 	return 0;
 }
-- 
2.34.1

