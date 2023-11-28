Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50D7FB179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbjK1Foi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjK1Fo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:44:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9523D0;
        Mon, 27 Nov 2023 21:44:33 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5iM0B042816;
        Mon, 27 Nov 2023 23:44:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701150262;
        bh=vdRFuuK893UD4rU+C8SivGsR6/Yo5lUUWHFtiT9ZlRY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VXXsY5l7bntvU6h03PTtqCc7ZYKWnrn7dTGT4XmqXAX9H1kGyqCOfFCnWwKqp7aoj
         Bf+tpqRb0Hf9GKm2ktpv68vuNXk+vIHw8im2KLHAETqsCPzpL8astQ3B+54DuWW7Hl
         zhXGF7Vp2DdoTqG900d9UG/A2OyDTKRpHwun5PZA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5iL4U001211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 23:44:22 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:44:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:44:21 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i2uR096776;
        Mon, 27 Nov 2023 23:44:17 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <nm@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v13 3/5] PCI: j721e: Add per platform maximum lane settings
Date:   Tue, 28 Nov 2023 11:14:00 +0530
Message-ID: <20231128054402.2155183-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
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

From: Matt Ranostay <mranostay@ti.com>

Various platforms have different maximum amount of lanes that can be
selected. Add max_lanes to struct j721e_pcie to allow for detection of this
which is needed to calculate the needed bitmask size for the possible lane
count.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 2c87e7728a65..63c758b14314 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -47,8 +47,6 @@ enum link_status {
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
-#define MAX_LANES			2
-
 struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	struct clk		*refclk;
@@ -71,6 +69,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		max_lanes;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -290,11 +289,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j7200_pcie_rc_data = {
@@ -302,23 +303,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
 	.quirk_disable_flr = true,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data am64_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 1,
 };
 
 static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.max_lanes = 1,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -432,8 +437,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > MAX_LANES)
+	if (ret || num_lanes > data->max_lanes) {
+		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
 		num_lanes = 1;
+	}
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
-- 
2.34.1

