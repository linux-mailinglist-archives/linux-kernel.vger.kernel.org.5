Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867AC812C19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443571AbjLNJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443544AbjLNJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:49:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36051D50;
        Thu, 14 Dec 2023 01:49:17 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9bdrf019740;
        Thu, 14 Dec 2023 09:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=hpvMBuARU64hMyagAI+sVm+34y+gMIefztSa1JH/fjY=; b=Db
        fTmDbsP65AALl2nqOe9GU6Jbw6o+Jdb9fqiTxJANH4nsu9h8X+nAJ6UEEfy8lChQ
        DRSsWBTHXIfIr+SKfVLShtoVUmuB66nk4v2WRZoxsWShJ7+FcW0LEdpPRaBOY1fW
        Y/yHXH0XZGaO9h3s8r+p/nmmOAWgVRgPeJMXXxpMPG3qbBY9wn1NYDIQ6ncsuUFo
        0jGeubj95Q3vdGFJIUfTOgdIWam+N3oRT0URULwruberLa/Rqf6zOce6sA5OI0VI
        emcEX+BxYaKKq0HdSNgUL3/qq939+Qz5yz0Eb6rOwAmRmkxFqVT3kmeWwNWukQLA
        Z1m9y5+QwVuN9o1ALSGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynja94qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9n3N2016687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:03 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:59 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 08/14] net: phy: at803x: add qca8084 switch registe access
Date:   Thu, 14 Dec 2023 17:48:07 +0800
Message-ID: <20231214094813.24690-9-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aGsADAo4H8C-Ks1W9KkGLFrJyk7dtA-k
X-Proofpoint-ORIG-GUID: aGsADAo4H8C-Ks1W9KkGLFrJyk7dtA-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For qca8084 chip, there are GCC, TLMM and security control
modules besides the PHY, these moudles are accessed with 32
bits value, which has the special MDIO sequences to read or
write this 32bit register.

There are initial configurations configured to make qca8084 PHY
probeable, and the MDIO address of qca8084 can be programmed for
the PHY device and PCS device.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c186ef8e798f..016e40e32982 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -296,6 +296,13 @@
 #define QCA8084_MMD7_IPG_OP			0x901d
 #define QCA8084_IPG_10_TO_11_EN			BIT(0)
 
+/* QCA8084 includes secure control module, which supports customizing the
+ * MDIO address of PHY device and PCS device, the register of secure control
+ * is accessed by MDIO bus with the special MDIO sequences.
+ */
+#define QCA8084_HIGH_ADDR_PREFIX		0x18
+#define QCA8084_LOW_ADDR_PREFIX			0x10
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -408,6 +415,85 @@ static int at803x_read_page(struct phy_device *phydev)
 	return AT803X_PAGE_FIBER;
 }
 
+static void qca8084_split_addr(u32 regaddr, u16 *r1, u16 *r2,
+			       u16 *page, u16 *sw_addr)
+{
+	*r1 = regaddr & 0x1c;
+
+	regaddr >>= 5;
+	*r2 = regaddr & 0x7;
+
+	regaddr >>= 3;
+	*page = regaddr & 0xffff;
+
+	regaddr >>= 16;
+	*sw_addr = regaddr & 0xff;
+}
+
+static int __qca8084_set_page(struct mii_bus *bus, u16 sw_addr, u16 page)
+{
+	return __mdiobus_write(bus, QCA8084_HIGH_ADDR_PREFIX | (sw_addr >> 5),
+			       sw_addr & 0x1f, page);
+}
+
+static int __qca8084_mii_read(struct mii_bus *bus, u16 addr, u16 reg, u32 *val)
+{
+	int ret, data;
+
+	ret = __mdiobus_read(bus, addr, reg);
+	if (ret >= 0) {
+		data = ret;
+
+		ret = __mdiobus_read(bus, addr, reg | BIT(1));
+		if (ret >= 0)
+			*val =  data | ret << 16;
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static int __qca8084_mii_write(struct mii_bus *bus, u16 addr, u16 reg, u32 val)
+{
+	int ret;
+
+	ret = __mdiobus_write(bus, addr, reg, lower_16_bits(val));
+	if (!ret)
+		ret = __mdiobus_write(bus, addr, reg | BIT(1), upper_16_bits(val));
+
+	return ret;
+}
+
+static int qca8084_mii_modify(struct phy_device *phydev, u32 regaddr,
+			      u32 clear, u32 set)
+{
+	struct mii_bus *bus;
+	u16 reg, addr, page, sw_addr;
+	u32 val;
+	int ret;
+
+	bus = phydev->mdio.bus;
+	mutex_lock(&bus->mdio_lock);
+
+	qca8084_split_addr(regaddr, &reg, &addr, &page, &sw_addr);
+	ret = __qca8084_set_page(bus, sw_addr, page);
+	if (ret < 0)
+		goto qca8084_mii_modify_exit;
+
+	ret = __qca8084_mii_read(bus, QCA8084_LOW_ADDR_PREFIX | addr,
+				 reg, &val);
+	if (ret < 0)
+		goto qca8084_mii_modify_exit;
+
+	val &= ~clear;
+	val |= set;
+	ret = __qca8084_mii_write(bus, QCA8084_LOW_ADDR_PREFIX | addr,
+				  reg, val);
+
+qca8084_mii_modify_exit:
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+};
+
 static int at803x_enable_rx_delay(struct phy_device *phydev)
 {
 	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL, 0,
-- 
2.42.0

