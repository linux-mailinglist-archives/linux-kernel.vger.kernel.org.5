Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14686801B94
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjLBIuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjLBIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:50:32 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3AEB;
        Sat,  2 Dec 2023 00:50:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B28oJvO048633;
        Sat, 2 Dec 2023 02:50:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701507019;
        bh=5eLMeR7O3XmgWYr3v/Y9HZ53t+c9lMwwKXavX+OjuwA=;
        h=From:To:CC:Subject:Date;
        b=uPnW9bc0vJAgRIKvDOPa9kPaxyHNisBdNDhx+Xt7hyEAl4H71vXLypp+pm3aol2TV
         kzGVOWxwUPF+Bx84qEFNSWr8R+FceRZkJNOc+1dasAv/tbsXuWRrIKk2TImFKRMcJq
         oJsNwMf45Ia4opPErFX6h131kWvLFVo9RfMKWtnE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B28oJE9002281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 Dec 2023 02:50:19 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 2
 Dec 2023 02:50:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 2 Dec 2023 02:50:19 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B28oGEW067220;
        Sat, 2 Dec 2023 02:50:16 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4] PCI: Cadence: Clear the ARI Capability Next Function Number of the last function
Date:   Sat, 2 Dec 2023 14:20:15 +0530
Message-ID: <20231202085015.3048516-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>

Next Function Number field in ARI Capability Register for last function
must be zero by default as per the PCIe specification, indicating there
is no next higher number function but that's not happening in our case,
so this patch clears the Next Function Number field for last function used.

Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20231201.

v3:
https://patchwork.kernel.org/project/linux-pci/patch/20230316071156.200888-1-a-verma1@ti.com/
Changes since v3: - Rebased on next-20231201.
- Collected Reviewed-by tag from Vignesh Raghavendra <vigneshr@ti.com>.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pcie-cadence-ep.c | 14 +++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 3142feb8ac19..2dd4d7027659 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -566,7 +566,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
 	int max_epfs = sizeof(epc->function_num_map) * 8;
-	int ret, value, epf;
+	int ret, epf, last_fn;
+	u32 reg, value;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
@@ -574,6 +575,17 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 */
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
+	/*
+	 * Next function field in ARI_CAP_AND_CTR register for last function
+	 * should be 0.
+	 * Clearing Next Function Number field for the last function used.
+	 */
+	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
+	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
+	value  = cdns_pcie_readl(pcie, reg);
+	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
+	cdns_pcie_writel(pcie, reg, value);
+
 	if (ep->quirk_disable_flr) {
 		for (epf = 0; epf < max_epfs; epf++) {
 			if (!(epc->function_num_map & BIT(epf)))
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 373cb50fcd15..9c16745582eb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -130,6 +130,12 @@
 #define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
 #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
 
+/*
+ * Endpoint PF Registers
+ */
+#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
+#define CDNS_PCIE_ARI_CAP_NFN_MASK	GENMASK(15, 8)
+
 /*
  * Root Port Registers (PCI configuration space for the root port function)
  */
-- 
2.34.1

