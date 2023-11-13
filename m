Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D557E9833
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjKMIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjKMIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:55:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF81703;
        Mon, 13 Nov 2023 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865715; x=1731401715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KPZCNptc1GbxF5k9MX2KawY04ffstfPzRi4pRIz12Ow=;
  b=heyIFOOylhrrESJ1VDMkHTM2jxer9GO9RwE+szLxiIle81Kem9uwMR/l
   wIINnbv/JGv8R/vBPJihFNMuV7YDALau2pYO+8A9+BAINbLPm1Kiv3j08
   2JgU7CZc+n+hyXgDg3Kgp2AI4TgNDRVXxCJYEM4mJjEOR7Cj4hJM/R6dy
   gW/btOxTZD4tctigD2ni071V6jtl10R9BRHqYoVaR6QpyllxDPb+YOCqq
   zyddkKZ/cb2nQPppcXoc8bZdAjzCiEaSzbXjtXhTEjp4DIFjVP+7TVKvA
   psdA8YtMXpvveob3RAKJQ7c6nWLw0DP8eVS3r1pj8aWqm8g/zVP7Am/4D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044632"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044632"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688226"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688226"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:55:11 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] EDAC/igen6: Add Intel Meteor Lake-PS SoCs support
Date:   Mon, 13 Nov 2023 16:53:17 +0800
Message-Id: <20231113085318.26783-5-qiuxu.zhuo@intel.com>
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

Add Intel Meteor Lake-PS SoC compute die IDs for EDAC support.
These SoCs share similar IBECC registers with Alder Lake-P SoCs.
The only difference is that IBECC presence is detected through an
MMIO-mapped register instead of the capability register in the
PCI configuration space.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index f7914ce3d3d7..d336ba53e67c 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -245,6 +245,12 @@ static struct work_struct ecclog_work;
 #define DID_RPL_P_SKU4	0xa716
 #define DID_RPL_P_SKU5	0xa718
 
+/* Compute die IDs for Meteor Lake-PS with IBECC */
+#define DID_MTL_PS_SKU1	0x7d21
+#define DID_MTL_PS_SKU2	0x7d22
+#define DID_MTL_PS_SKU3	0x7d23
+#define DID_MTL_PS_SKU4	0x7d24
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -325,6 +331,29 @@ static bool tgl_ibecc_available(struct pci_dev *pdev)
 	return !(CAPID_E_IBECC & v);
 }
 
+static bool mtl_ps_ibecc_available(struct pci_dev *pdev)
+{
+#define MCHBAR_MEMSS_IBECCDIS	0x13c00
+	void __iomem *window;
+	u64 mchbar;
+	u32 val;
+
+	if (get_mchbar(pdev, &mchbar))
+		return false;
+
+	window = ioremap(mchbar, MCHBAR_SIZE * 2);
+	if (!window) {
+		igen6_printk(KERN_ERR, "Failed to ioremap 0x%llx\n", mchbar);
+		return false;
+	}
+
+	val = readl(window + MCHBAR_MEMSS_IBECCDIS);
+	iounmap(window);
+
+	/* Bit6: 1 - IBECC is disabled, 0 - IBECC isn't disabled */
+	return !GET_BITFIELD(val, 6, 6);
+}
+
 static u64 mem_addr_to_sys_addr(u64 maddr)
 {
 	if (maddr < igen6_tolud)
@@ -484,6 +513,17 @@ static struct res_config rpl_p_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
+static struct res_config mtl_ps_cfg = {
+	.machine_check		= true,
+	.num_imc		= 2,
+	.imc_base		= 0xd800,
+	.ibecc_base		= 0xd400,
+	.ibecc_error_log_offset	= 0x170,
+	.ibecc_available	= mtl_ps_ibecc_available,
+	.err_addr_to_sys_addr	= adl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
+};
+
 static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -521,6 +561,10 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU4), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU5), (kernel_ulong_t)&rpl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU1), (kernel_ulong_t)&mtl_ps_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU2), (kernel_ulong_t)&mtl_ps_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU3), (kernel_ulong_t)&mtl_ps_cfg },
+	{ PCI_VDEVICE(INTEL, DID_MTL_PS_SKU4), (kernel_ulong_t)&mtl_ps_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.17.1

