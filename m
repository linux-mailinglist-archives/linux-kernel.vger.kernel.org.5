Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE078C6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjH2OAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbjH2OAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:00:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904911AC;
        Tue, 29 Aug 2023 07:00:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9uak8009805;
        Tue, 29 Aug 2023 13:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=A8nLVX31e8UXJUuE0fdvtxJ+biraOTNRrTnNs5rj5j4=;
 b=Y4ZGBx2Xu1/4YYUToIm3+OqKbJrJZz9MtKQSwbgBBNLLRD4Dj+Y1fjpWXbVTazOVbycV
 lEY9pk941tquZABnLi4nUUn7i2zAf6iad76vfOfFWYv14Vh6k0kAEPb4nVQLcaptU5Aq
 JVa/IS2+KPzMNajwDqSIhpnQmpP7dT85M8Vilk6mvZgYVj1AF+TOkqbfvZogYBfdh3H+
 bzsBJPpt7G1ZZJCRkDcGgC7tp/MUq61Iiimso4+mDX2WsMoHzlADga7c8vLSEMPFKTHU
 7MaZB7PvVluLwujPcB8ac9RnHU10PI3woWx7I8aerCe/M8/Ah8XdAASL0OQrLitvY0tF kg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4wq1k4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDxcJu002789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:38 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:59:31 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <quic_ipkumar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 8/9] phy: qcom: uniphy: Add ipq5332 USB UNIPHY support
Date:   Tue, 29 Aug 2023 19:28:17 +0530
Message-ID: <20230829135818.2219438-9-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1sxQEjl-qba1Iao-dHIICqjnz8PKQ6TS
X-Proofpoint-ORIG-GUID: 1sxQEjl-qba1Iao-dHIICqjnz8PKQ6TS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ipq5332 USB SS UNIPHY support.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
This patch depends on the below series which adds support for USB2 in
IPQ5332
https://lore.kernel.org/all/cover.1692699472.git.quic_varada@quicinc.com/

 drivers/phy/qualcomm/phy-qcom-uniphy.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.c b/drivers/phy/qualcomm/phy-qcom-uniphy.c
index eb71588f5417..91487e68bb6e 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy.c
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.c
@@ -26,6 +26,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#define PCIE_USB_COMBO_PHY_CFG_MISC1		0x214
+#define PCIE_USB_COMBO_PHY_CFG_RX_AFE_2		0x7C4
+#define PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2	0x7E8
+
 struct uniphy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -37,6 +41,12 @@ struct uniphy_init_tbl {
 		.val = v,		\
 	}
 
+static const struct uniphy_init_tbl ipq5332_usb_ssphy_init_tbl[] = {
+	UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_AFE_2, 0x1076),
+	UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2, 0x3142),
+	UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_MISC1, 0x3),
+};
+
 struct uniphy_cfg {
 	const struct uniphy_init_tbl *init_seq;
 	int num_init_seq;
@@ -83,6 +93,32 @@ static const struct uniphy_cfg ipq4019_usb_hsphy_cfg = {
 	.reset_udelay	= 10000,
 };
 
+static const char * const ipq5332_usb_ssphy_clk_l[] = {
+	"phy_ahb", "phy_cfg_ahb", "pipe",
+};
+
+static const char * const ipq5332_usb_ssphy_reset_l[] = {
+	"por_rst",
+};
+
+static const char * const ipq5332_usb_ssphy_vreg_l[] = {
+	"vdda-phy",
+};
+
+static const struct uniphy_cfg ipq5332_usb_ssphy_cfg = {
+	.init_seq	= ipq5332_usb_ssphy_init_tbl,
+	.num_init_seq	= ARRAY_SIZE(ipq5332_usb_ssphy_init_tbl),
+	.clk_list	= ipq5332_usb_ssphy_clk_l,
+	.num_clks	= ARRAY_SIZE(ipq5332_usb_ssphy_clk_l),
+	.reset_list	= ipq5332_usb_ssphy_reset_l,
+	.num_resets	= ARRAY_SIZE(ipq5332_usb_ssphy_reset_l),
+	.vreg_list	= ipq5332_usb_ssphy_vreg_l,
+	.num_vregs	= ARRAY_SIZE(ipq5332_usb_ssphy_vreg_l),
+	.pipe_clk_rate	= 250000000,
+	.reset_udelay	= 1,
+	.autoload_udelay = 35,
+};
+
 static int phy_mux_sel(struct phy *phy)
 {
 	struct qcom_uniphy *uniphy = phy_get_drvdata(phy);
@@ -396,6 +432,7 @@ static int qcom_uniphy_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_uniphy_of_match[] = {
 	{ .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hsphy_cfg},
 	{ .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ssphy_cfg},
+	{ .compatible = "qcom,ipq5332-usb-ssphy", .data = &ipq5332_usb_ssphy_cfg},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qcom_uniphy_of_match);
-- 
2.34.1

