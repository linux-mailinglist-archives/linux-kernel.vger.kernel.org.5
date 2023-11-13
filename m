Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9617E9823
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjKMIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjKMIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:54:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3D10F7;
        Mon, 13 Nov 2023 00:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865690; x=1731401690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=n/pgnHEuf80IEt9I/UkKarq647lAz4wEOukkZ58y5Kw=;
  b=ZzM/TOpebSlnnWs9Nwq9+ANLnqfFxZXTS9J8NoVEfzZ3yv6ll1Vlv0ds
   H9e15QrxkFutGbMexkE8UuCYbZdF+RCfmo8H8Gm2IHYk4HOf+avlA+ewy
   Kh1+JXob8QPDOXWkJ7dKTR36UZe9XNCJsHSQAEWFn+Shpn5ChqrJYdn/4
   WJkfc6/D46aX0l0RSN0+hSQ4fXBog5wwnpI0lweKVH32othEgIhA1Q8fx
   ynjQpMiSRFc1qefF1kYVGw0fqThsOsuvd8e4DWmL0kNqaemIGzhKNsU+M
   2IZCTT7e5nGTb3G8JMM7/Y6Uyv+32ZUTMgcJMJoYHY98CDP3Kl0dV3Ztf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044615"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044615"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688125"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688125"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:47 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] EDAC/igen6: Add Intel Alder Lake-N SoCs support
Date:   Mon, 13 Nov 2023 16:53:15 +0800
Message-Id: <20231113085318.26783-3-qiuxu.zhuo@intel.com>
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

Add Intel Alder Lake-N SoC compute die IDs for EDAC support.
Alder Lake-N, with one memory controller, is a reduced version of
Alder Lake-P, which has two memory controllers.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index eadc3e559311..6e9b0cd076b4 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -222,6 +222,19 @@ static struct work_struct ecclog_work;
 #define DID_ADL_SKU3	0x4621
 #define DID_ADL_SKU4	0x4641
 
+/* Compute die IDs for Alder Lake-N with IBECC */
+#define DID_ADL_N_SKU1	0x4614
+#define DID_ADL_N_SKU2	0x4617
+#define DID_ADL_N_SKU3	0x461b
+#define DID_ADL_N_SKU4	0x461c
+#define DID_ADL_N_SKU5	0x4673
+#define DID_ADL_N_SKU6	0x4674
+#define DID_ADL_N_SKU7	0x4675
+#define DID_ADL_N_SKU8	0x4677
+#define DID_ADL_N_SKU9	0x4678
+#define DID_ADL_N_SKU10	0x4679
+#define DID_ADL_N_SKU11	0x467c
+
 static int get_mchbar(struct pci_dev *pdev, u64 *mchbar)
 {
 	union  {
@@ -433,6 +446,17 @@ static struct res_config adl_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
+static struct res_config adl_n_cfg = {
+	.machine_check		= true,
+	.num_imc		= 1,
+	.imc_base		= 0xd800,
+	.ibecc_base		= 0xd400,
+	.ibecc_error_log_offset	= 0x68,
+	.ibecc_available	= tgl_ibecc_available,
+	.err_addr_to_sys_addr	= adl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
+};
+
 static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -454,6 +478,17 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_SKU2), (kernel_ulong_t)&adl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_SKU3), (kernel_ulong_t)&adl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_SKU4), (kernel_ulong_t)&adl_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU1), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU2), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU3), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU4), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU5), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU6), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU7), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU8), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU9), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU10), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU11), (kernel_ulong_t)&adl_n_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.17.1

