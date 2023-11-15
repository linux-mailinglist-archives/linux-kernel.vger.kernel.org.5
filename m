Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADB7EBBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjKOD01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjKOD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDCD113;
        Tue, 14 Nov 2023 19:26:11 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF0gcgt026841;
        Wed, 15 Nov 2023 03:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=g0/qPsDTNoEdeIs09TNS+xr7pEYRW5QEHcQfrwDkAmM=;
 b=M3b/yl5H9p57BvpELKyjLqT+Ca3fLjzIv/lXjAhwCvFlD/mxjv1pR/dRcrQxkjC8/tHB
 n8tZuLDxjd2ymLOlAh6NoMypOjKGf1UZap++h60hOgelI1E3uPqD7axt7J1uW5ctfwXX
 AAbrS7ET9tLXeBsqhtr7M4vkc7aC3jEvYxXov0DFLXK9W6MijJa0qgOnadFZXZv2dlUA
 RekgJ4EJQZWh06MPIccDvcqtCwGxrajQwHZmvBxIyQPSzD9KsKNrKyUr56fZvebC9U3y
 AhHVnfodGH14ThCp8jb7I5uIHDshl8N1VwL6HYzdjN/qdl/bW8HtTMnm6vMiEBlIDTiA 4w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uchkyghg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:26:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3PxvZ029492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:59 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:55 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH 7/9] net: mdio: ipq4019: program phy address when "fixup" defined
Date:   Wed, 15 Nov 2023 11:25:13 +0800
Message-ID: <20231115032515.4249-8-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115032515.4249-1-quic_luoj@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TJUdN1DJWmnlHOIpUDZXM3jgGvOWxbTF
X-Proofpoint-ORIG-GUID: TJUdN1DJWmnlHOIpUDZXM3jgGvOWxbTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY/PCS MDIO address can be programed when the property
"fixup" of phy node is defined.

The qca8084 PHY/PCS address configuration register is accessed
by MDIO bus with the special MDIO sequence.

The PHY address configuration register of IPQ5018 is accessed
by local bus.

Add the function ipq_mdio_preinit, which should be called before
the PHY device scanned and registered.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 107 +++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 8dc611666c34..1c461c243ae0 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -61,6 +61,15 @@
 #define IPQ_HIGH_ADDR_PREFIX			0x18
 #define IPQ_LOW_ADDR_PREFIX			0x10
 
+/* QCA8084 PHY & PCS address can be customized, 4 PHYs and 3 PCSs are
+ * available.
+ */
+#define QCA8084_PHY_ADDR_LENGTH			5
+#define QCA8084_PHY_ADDR_NUM			4
+#define QCA8084_PCS_ADDR_NUM			3
+#define QCA8084_PHY_ADDR_MASK			GENMASK(19, 0)
+#define QCA8084_PCS_ADDR_MASK			GENMASK(14, 0)
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -317,6 +326,102 @@ static int qca8084_modify(struct mii_bus *bus, u32 regaddr, u32 clear, u32 set)
 	return qca8084_mii_write(bus, IPQ_LOW_ADDR_PREFIX | addr, reg, val);
 };
 
+/* The PHY/PCS MDIO address can be programed when the device tree property
+ * "fixup" of PHY node is specified.
+ */
+static int ipq_phy_addr_fixup(struct mii_bus *bus, struct device_node *mdio_node)
+{
+	const __be32 *phy_cfg;
+	u32 phy_addr_val, pcs_addr_val;
+	int ret, phy_index, pcs_index;
+	struct device_node *child;
+
+	phy_index = 0;
+	pcs_index = 0;
+	phy_addr_val = 0;
+	pcs_addr_val = 0;
+	for_each_available_child_of_node(mdio_node, child) {
+		ret = of_mdio_parse_addr(&bus->dev, child);
+		if (ret < 0)
+			continue;
+
+		if (!of_property_present(child, "fixup"))
+			continue;
+
+		if (of_property_present(child, "compatible")) {
+			pcs_addr_val |= ret << (QCA8084_PHY_ADDR_LENGTH * pcs_index);
+			pcs_index++;
+		} else {
+			phy_addr_val |= ret << (QCA8084_PHY_ADDR_LENGTH * phy_index);
+			phy_index++;
+		}
+	}
+
+	if (!phy_addr_val && !pcs_addr_val)
+		return 0;
+
+	if (phy_index > QCA8084_PHY_ADDR_NUM || pcs_index > QCA8084_PCS_ADDR_NUM) {
+		dev_err(&bus->dev,
+			"Too many MDIO address(phy number %d, pcs number %d) to be programed\n",
+			phy_index, pcs_index);
+		return -1;
+	}
+
+	phy_cfg = of_get_property(mdio_node, "phyaddr-fixup", &ret);
+
+	/* For MDIO access, phyaddr-fixup only provides the register address,
+	 * such as qca8084 PHY.
+	 *
+	 * As for local bus, the register length also needs to be provided,
+	 * such as the internal PHY of IPQ5018, only PHY address can be programed.
+	 */
+	if (!phy_cfg || (ret != (2 * sizeof(__be32)) && ret != sizeof(__be32)))
+		return 0;
+
+	if (ret == sizeof(__be32)) {
+		const __be32 *pcs_cfg;
+
+		/* MDIO access for customizing PHY address of qca8084 */
+		if (phy_addr_val != 0) {
+			ret = qca8084_modify(bus, be32_to_cpup(phy_cfg),
+					     QCA8084_PHY_ADDR_MASK, phy_addr_val);
+			if (ret)
+				return ret;
+		}
+
+		pcs_cfg = of_get_property(mdio_node, "pcsaddr-fixup", NULL);
+		/* Programe the PCS address if pcsaddr-fixup specified */
+		if (pcs_cfg && pcs_addr_val != 0) {
+			ret = qca8084_modify(bus, be32_to_cpup(pcs_cfg),
+					     QCA8084_PCS_ADDR_MASK, pcs_addr_val);
+			if (ret)
+				return ret;
+		}
+	} else {
+		void __iomem *ephy_cfg_base;
+
+		/* Local bus access for customizing internal PHY address of IPQ5018 */
+		ephy_cfg_base = ioremap(be32_to_cpup(phy_cfg), be32_to_cpup(phy_cfg + 1));
+		if (!ephy_cfg_base)
+			return -ENOMEM;
+
+		if (phy_addr_val != 0)
+			writel(phy_addr_val, ephy_cfg_base);
+	}
+
+	return 0;
+}
+
+static int ipq_mdio_preinit(struct mii_bus *bus)
+{
+	struct device_node *mdio_node = dev_of_node(&bus->dev);
+
+	if (!mdio_node)
+		return 0;
+
+	return ipq_phy_addr_fixup(bus, mdio_node);
+}
+
 /* For the CMN PLL block, the reference clock can be configured according to
  * the device tree property "cmn_ref_clk", the internal 48MHZ is used by default
  * on the ipq533 platform.
@@ -455,7 +560,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 	if (ret == 0)
 		mdelay(10);
 
-	return ret;
+	return ipq_mdio_preinit(bus);
 }
 
 static int ipq4019_mdio_probe(struct platform_device *pdev)
-- 
2.42.0

