Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691C7EBBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjKOD00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjKOD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C1FED;
        Tue, 14 Nov 2023 19:26:09 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF2kpSd006526;
        Wed, 15 Nov 2023 03:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ch3fs4DOJF9AEat2vjf10IuYor92WSy7oL8pvdQzo3Y=;
 b=SG1ICeDDrpxMlA07PCTYgZgrHYUX6U/uYc/KOp/xrSdqgK2KxAmJhG9v5lT5Uy61tHmw
 8cNSHrhmsq3dCuZ9UXCntXj4ZmgY1wgY4g9vupT+ro2Q6DUXID03xUm8ysRW6EMxXGbE
 iciksqBsNORf2KYPOJivXlUHabC5o9nRI2Zk/ylDFvhBWkjEWu+B0NQDYLCpghuiN/Ds
 k1lcvxZWG+aNs1mtIxzulhu57JNLdlefvf+XlVZYzF7f//RnRuMqqCThUmCrfsFL05qG
 2bR9vXDsstFbrcxoPu+UQiJZuAoERkqWHLwh8fRKxDWfzR7/8uJKro2hFD+1XSE84EwV MQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uc6nujbdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3Ptxh019626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:55 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:51 -0800
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
Subject: [PATCH 6/9] net: mdio: ipq4019: Support qca8084 switch register access
Date:   Wed, 15 Nov 2023 11:25:12 +0800
Message-ID: <20231115032515.4249-7-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iRXbT_UTQK-CqxY2pwrtibLUTNavA9FY
X-Proofpoint-GUID: iRXbT_UTQK-CqxY2pwrtibLUTNavA9FY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For qca8084 chip, there are GCC, TLMM and security control
modules besides the PHY, these moudles are accessed with 32
bits value, which has the special MDIO sequences to read or
write this 32bit register.

There are initial configurations needed to make qca8084 PHY
probeable, and the PHY address of qca8084 can also be customized
before creating the PHY device on MDIO bus register, all these
configurations are located in switch modules that are accessed
by the 32bit register.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 44a8a866f8ee..8dc611666c34 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -53,6 +53,14 @@
 #define CMN_PLL_POWER_ON_AND_RESET		0x780
 #define CMN_ANA_EN_SW_RSTN			BIT(6)
 
+/* QCA8084 includes the PHY chip, GCC/TLMM and the control modules,
+ * except for the PHY register, other registers are accessed by MDIO bus
+ * with 32bit value, which has the special MDIO sequences to access the
+ * switch modules register.
+ */
+#define IPQ_HIGH_ADDR_PREFIX			0x18
+#define IPQ_LOW_ADDR_PREFIX			0x10
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -243,6 +251,72 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page, u16 *sw_addr)
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
+static int qca8084_set_page(struct mii_bus *bus, u16 sw_addr, u16 page)
+{
+	return bus->write(bus, IPQ_HIGH_ADDR_PREFIX | (sw_addr >> 5), sw_addr & 0x1f, page);
+}
+
+static int qca8084_mii_read(struct mii_bus *bus, u16 addr, u16 reg, u32 *val)
+{
+	int ret, data;
+
+	ret = bus->read(bus, addr, reg);
+	if (ret >= 0) {
+		data = ret;
+
+		ret = bus->read(bus, addr, reg | BIT(1));
+		if (ret >= 0)
+			*val =  data | ret << 16;
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static int qca8084_mii_write(struct mii_bus *bus, u16 addr, u16 reg, u32 val)
+{
+	int ret;
+
+	ret = bus->write(bus, addr, reg, lower_16_bits(val));
+	if (!ret)
+		ret = bus->write(bus, addr, reg | BIT(1), upper_16_bits(val));
+
+	return ret;
+}
+
+static int qca8084_modify(struct mii_bus *bus, u32 regaddr, u32 clear, u32 set)
+{
+	u16 reg, addr, page, sw_addr;
+	u32 val;
+	int ret;
+
+	split_addr(regaddr, &reg, &addr, &page, &sw_addr);
+	ret = qca8084_set_page(bus, sw_addr, page);
+	if (ret < 0)
+		return ret;
+
+	ret = qca8084_mii_read(bus, IPQ_LOW_ADDR_PREFIX | addr, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= ~clear;
+	val |= set;
+	return qca8084_mii_write(bus, IPQ_LOW_ADDR_PREFIX | addr, reg, val);
+};
+
 /* For the CMN PLL block, the reference clock can be configured according to
  * the device tree property "cmn_ref_clk", the internal 48MHZ is used by default
  * on the ipq533 platform.
-- 
2.42.0

