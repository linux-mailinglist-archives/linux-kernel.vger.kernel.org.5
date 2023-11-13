Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1B7E9835
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjKMIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjKMIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:55:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBC410FE;
        Mon, 13 Nov 2023 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865727; x=1731401727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qyp+DhyGWDZjjRWexUcOxHl4CjPLxvuvw8u9oumPVVQ=;
  b=jJHpNT3rOHvGiuONWm1bwDpr6vbxE/Qj+OYbTMbfjYZkNJ6QpHdUy903
   gcgiAW+KZHsiErEgcqbHGJukwVTAomYddIJq1ZDkVbLHb03PVTAv/26XV
   tmOL8rNDXFZug17bPO12nFcrgliFhSIpgEmtcUPom3TH7m6JwgcF7/qQb
   bGrzHcoJIElEFOr1qusMXxbWIYwbzGlPHh326tNLxCFcDF3ujr2rPR2Cg
   i+dl+IxdE5hrYSSwvQFJ1nVBmz4W8m9B8+I4SYJYDiOhdD4wZGQDvm+hK
   RFXQ2kDKvCSWF5fzSQ3+cjzLRrwtg1u+9o6SUbwQP06I5DXSxwmBrN8+n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044648"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044648"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688289"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688289"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:24 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] EDAC/igen6: Add Intel Meteor Lake-P SoCs support
Date:   Mon, 13 Nov 2023 16:53:18 +0800
Message-Id: <20231113085318.26783-6-qiuxu.zhuo@intel.com>
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

Add Intel Meteor Lake-P SoC compute die IDs for EDAC support.
These Meteor Lake-P SoCs share similar IBECC registers with
Alder Lake-P SoCs.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index d336ba53e67c..2b0ecdeba5cd 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -58,6 +58,7 @@
 /* Capability register E */
 #define CAPID_E_OFFSET			0xf0
 #define CAPID_E_IBECC			BIT(12)
+#define CAPID_E_IBECC_BIT18		BIT(18)
 
 /* Error Status */
 #define ERRSTS_OFFSET			0xc8
@@ -251,6 +252,11 @@ static struct work_struct ecclog_work;
 #define DID_MTL_PS_SKU3	0x7d23
 #define DID_MTL_PS_SKU4	0x7d24
 
+/* Compute die IDs for Meteor Lake-P with IBECC */
+#define DID_MTL_P_SKU1	0x7d01
+#define DID_MTL_P_SKU2	0x7d02
+#define DID_MTL_P_SKU3	0x7d14
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -331,6 +337,16 @@ static bool tgl_ibecc_available(struct pci_dev *pdev)
 	return !(CAPID_E_IBECC & v);
 }
 
+static bool mtl_p_ibecc_available(struct pci_dev *pdev)
+{
+	u32 v;
+
+	if (pci_read_config_dword(pdev, CAPID_E_OFFSET, &v))
+		return false;
+
+	return !(CAPID_E_IBECC_BIT18 & v);
+}
+
 static bool mtl_ps_ibecc_available(struct pci_dev *pdev)
 {
 #define MCHBAR_MEMSS_IBECCDIS	0x13c00
@@ -524,6 +540,17 @@ static struct res_config mtl_ps_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
+static struct res_config mtl_p_cfg = {
+	.machine_check		= true,
+	.num_imc		= 2,
+	.imc_base		= 0xd800,
+	.ibecc_base		= 0xd400,
+	.ibecc_error_log_offset	= 0x170,
+	.ibecc_available	= mtl_p_ibecc_available,
+	.err_addr_to_sys_addr	= adl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
+};
+
 static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -565,6 +592,9 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU2), (kernel_ulong_t)&mtl_ps_cfg },
 	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU3), (kernel_ulong_t)&mtl_ps_cfg },
 	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU4), (kernel_ulong_t)&mtl_ps_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU1), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU2), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_P_SKU3), (kernel_ulong_t)&mtl_p_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.17.1

