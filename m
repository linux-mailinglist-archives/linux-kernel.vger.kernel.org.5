Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741A7E9826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjKMIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjKMIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:55:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1A10FA;
        Mon, 13 Nov 2023 00:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865703; x=1731401703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jpAt0LcVlSjjUEbl/HM69I5nu47cevCw5mxd/6mq4EM=;
  b=eji8jRcHWmfm78o4b55Jvs1Dw1ikavC4qPlDTeoaBcCClLbnfxDJElkI
   iE03f3fx+86G+TmcIhtEtnAvU3VVFwgvxq3BSbJjHX16wyP9aEUshrp9f
   HMACt2azn0lPqP6rftHlCjtUEuihH9QVS5mvm6BAnHJF5fSQs0vyjtwtg
   uzvs4s8Uv06FjaIu2tK61gCS0Usv9WICVzf2xBIFVpiNyWiCgWU+h9SSl
   JvJvCIfmYeT+gID+KiMFB5cwIsaZTrVmqFpc2GEVCJDDXQg2K2wSu0K/q
   rfOh2wK8cCShvWGiOj/aXHuiOZ0J+zddZLLUBzy8hetdDf6d+X8lOPvxs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044623"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688195"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688195"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:00 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] EDAC/igen6: Add Intel Raptor Lake-P SoCs support
Date:   Mon, 13 Nov 2023 16:53:16 +0800
Message-Id: <20231113085318.26783-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
References: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Intel Raptor Lake-P SoC compute die IDs for EDAC support.
These Raptor Lake-P SoCs share similar IBECC registers with Alder Lake-P
SoCs but extend the most significant bit of the error address logged
in IBECC from bit 38 to bit 45.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 6e9b0cd076b4..f7914ce3d3d7 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -80,6 +80,7 @@
 #define ECC_ERROR_LOG_UE		BIT_ULL(63)
 #define ECC_ERROR_LOG_ADDR_SHIFT	5
 #define ECC_ERROR_LOG_ADDR(v)		GET_BITFIELD(v, 5, 38)
+#define ECC_ERROR_LOG_ADDR45(v)		GET_BITFIELD(v, 5, 45)
 #define ECC_ERROR_LOG_SYND(v)		GET_BITFIELD(v, 46, 61)
 
 /* Host MMIO base address */
@@ -133,6 +134,8 @@ static struct res_config {
 	u32 ibecc_base;
 	u32 ibecc_error_log_offset;
 	bool (*ibecc_available)(struct pci_dev *pdev);
+	/* Extract error address logged in IBECC */
+	u64 (*err_addr)(u64 ecclog);
 	/* Convert error address logged in IBECC to system physical address */
 	u64 (*err_addr_to_sys_addr)(u64 eaddr, int mc);
 	/* Convert error address logged in IBECC to integrated memory controller address */
@@ -235,6 +238,13 @@ static struct work_struct ecclog_work;
 #define DID_ADL_N_SKU10	0x4679
 #define DID_ADL_N_SKU11	0x467c
 
+/* Compute die IDs for Raptor Lake-P with IBECC */
+#define DID_RPL_P_SKU1	0xa706
+#define DID_RPL_P_SKU2	0xa707
+#define DID_RPL_P_SKU3	0xa708
+#define DID_RPL_P_SKU4	0xa716
+#define DID_RPL_P_SKU5	0xa718
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -401,6 +411,11 @@ static u64 adl_err_addr_to_imc_addr(u64 eaddr, int mc)
 	return imc_addr;
 }
 
+static u64 rpl_p_err_addr(u64 ecclog)
+{
+	return ECC_ERROR_LOG_ADDR45(ecclog);
+}
+
 static struct res_config ehl_cfg = {
 	.num_imc		= 1,
 	.imc_base		= 0x5000,
@@ -457,6 +472,18 @@ static struct res_config adl_n_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
+static struct res_config rpl_p_cfg = {
+	.machine_check		= true,
+	.num_imc		= 2,
+	.imc_base		= 0xd800,
+	.ibecc_base		= 0xd400,
+	.ibecc_error_log_offset	= 0x68,
+	.ibecc_available	= tgl_ibecc_available,
+	.err_addr		= rpl_p_err_addr,
+	.err_addr_to_sys_addr	= adl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
+};
+
 static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -489,6 +516,11 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU9), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU10), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU11), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU4), (kernel_ulong_t)&rpl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU5), (kernel_ulong_t)&rpl_p_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
@@ -744,8 +776,11 @@ static void ecclog_work_cb(struct work_struct *work)
 
 	llist_for_each_entry_safe(node, tmp, head, llnode) {
 		memset(&res, 0, sizeof(res));
-		eaddr = ECC_ERROR_LOG_ADDR(node->ecclog) <<
-			ECC_ERROR_LOG_ADDR_SHIFT;
+		if (res_cfg->err_addr)
+			eaddr = res_cfg->err_addr(node->ecclog);
+		else
+			eaddr = ECC_ERROR_LOG_ADDR(node->ecclog) <<
+				ECC_ERROR_LOG_ADDR_SHIFT;
 		res.mc	     = node->mc;
 		res.sys_addr = res_cfg->err_addr_to_sys_addr(eaddr, res.mc);
 		res.imc_addr = res_cfg->err_addr_to_imc_addr(eaddr, res.mc);
-- 
2.17.1

