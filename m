Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19A80BFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjLKC4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjLKC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:56:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A3DA;
        Sun, 10 Dec 2023 18:56:35 -0800 (PST)
X-UUID: e1ddec5097d011eeba30773df0976c77-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i8TXdqV2izRDW8z8vOxaWgfbe4KHJiTErHSBQzhe3vo=;
        b=jrEi+UOTNGcgL/gvvaZxIZZSPqFrcjOSVZY6IPGwGdL8EgkKx/QrWkSVZx9LzA5H3DFIVsUclcrbAtOCpbhSE9zZx0EtZ4ujl9v8jwa88i1rBckke9oPi/kOgV3ozvmWJ4l96dI3dx4aZHczbWoWNbdq+N7oz5j1B3tFHFz3cpI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:88bfec9e-42c8-45e7-8c98-366ff1d168ec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3ac1a173-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e1ddec5097d011eeba30773df0976c77-20231211
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1539842883; Mon, 11 Dec 2023 10:56:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 10:56:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 10:56:27 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v2 2/2] phy: mediatek: tphy: add support force phy mode switch
Date:   Mon, 11 Dec 2023 10:56:24 +0800
Message-ID: <20231211025624.28991-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
References: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.785000-8.000000
X-TMASE-MatchedRID: J/H5Ci0f1rnsfYO9ammJs7MsPmSZxbpkWjWsWQUWzVr4JyR+b5tvoCqz
        9bm0+YwHWuGOVkLXvWk9ihzfHXEWBD64jvoDlrOhT7jCYv2QJPEj3JVwc0NTtrdvX1ZhGqOag+P
        4tXhngjyspZWETm/Fhqe2l71iDpIWXcx4M+DrsF6WLCkl1lq7B0qAhuLHn5fEFkhFxjNOqqWjxY
        yRBa/qJcFwgTvxipFajoczmuoPCq3Yc5EAIY936FcqpFjVx+qYrS3dL9zfecXyRuykpGcD3ZoCD
        JtD8o3M697AQBlh8ge53S+3pi8iX5VrTkRxGMEBDSIVopyvNC3iw6uxviJP8r9tsSiUciBlQ5zs
        aM5qada/lr1yYih0SylGctXaTCsu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.785000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4065D60DE023CBD1411CFB6AA0FEE34A4CD7AE91A6B2014B1A780F9B41CCF38E2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is used to be compatible with old SoCs, such as mt8195, which shares
t-phy between usb3 and pcie controller, usually, it's default mode is pcie
rc mode, and could use force mode to switch into usb3 mode, because pericfg
layer doesn't provide mode switch, also no efuse or jumper can be used;
Currently, only support switch from default pcie mode to usb3;
Note: don't use this way on new SoCs, use pericfg layer's mode switch
instead (by perperty "mediatek,syscon-type").

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: modify commit message
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 05eab9014132..a4746f6cb8a1 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -185,6 +185,10 @@
 #define P3D_RG_CDR_BIR_LTD1		GENMASK(28, 24)
 #define P3D_RG_CDR_BIR_LTD0		GENMASK(12, 8)
 
+#define U3P_U3_PHYD_TOP1		0x100
+#define P3D_RG_PHY_MODE			GENMASK(2, 1)
+#define P3D_RG_FORCE_PHY_MODE		BIT(0)
+
 #define U3P_U3_PHYD_RXDET1		0x128
 #define P3D_RG_RXDET_STB2_SET		GENMASK(17, 9)
 
@@ -327,6 +331,7 @@ struct mtk_phy_instance {
 	int discth;
 	int pre_emphasis;
 	bool bc12_en;
+	bool type_force_mode;
 };
 
 struct mtk_tphy {
@@ -768,6 +773,23 @@ static void u3_phy_instance_init(struct mtk_tphy *tphy,
 	void __iomem *phya = u3_banks->phya;
 	void __iomem *phyd = u3_banks->phyd;
 
+	if (instance->type_force_mode) {
+		/* force phy as usb mode, default is pcie rc mode */
+		mtk_phy_update_field(phyd + U3P_U3_PHYD_TOP1, P3D_RG_PHY_MODE, 1);
+		mtk_phy_set_bits(phyd + U3P_U3_PHYD_TOP1, P3D_RG_FORCE_PHY_MODE);
+		/* power down phy by ip and pipe reset */
+		mtk_phy_set_bits(u3_banks->chip + U3P_U3_CHIP_GPIO_CTLD,
+				 P3C_FORCE_IP_SW_RST | P3C_MCU_BUS_CK_GATE_EN);
+		mtk_phy_set_bits(u3_banks->chip + U3P_U3_CHIP_GPIO_CTLE,
+				 P3C_RG_SWRST_U3_PHYD | P3C_RG_SWRST_U3_PHYD_FORCE_EN);
+		udelay(10);
+		/* power on phy again */
+		mtk_phy_clear_bits(u3_banks->chip + U3P_U3_CHIP_GPIO_CTLD,
+				   P3C_FORCE_IP_SW_RST | P3C_MCU_BUS_CK_GATE_EN);
+		mtk_phy_clear_bits(u3_banks->chip + U3P_U3_CHIP_GPIO_CTLE,
+				   P3C_RG_SWRST_U3_PHYD | P3C_RG_SWRST_U3_PHYD_FORCE_EN);
+	}
+
 	/* gating PCIe Analog XTAL clock */
 	mtk_phy_set_bits(u3_banks->spllc + U3P_SPLLC_XTALCTL3,
 			 XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD);
@@ -1120,6 +1142,9 @@ static void phy_parse_property(struct mtk_tphy *tphy,
 {
 	struct device *dev = &instance->phy->dev;
 
+	if (instance->type == PHY_TYPE_USB3)
+		instance->type_force_mode = device_property_read_bool(dev, "mediatek,force-mode");
+
 	if (instance->type != PHY_TYPE_USB2)
 		return;
 
-- 
2.18.0

