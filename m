Return-Path: <linux-kernel+bounces-548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA48142C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D76287238
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9951DDF1;
	Fri, 15 Dec 2023 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HlI6XGqb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714681947C;
	Fri, 15 Dec 2023 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4o2O0022299;
	Fri, 15 Dec 2023 07:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=dJ5kQvuoEbVrG4WmjFAM8eSccltqgqQY4QEeEFSI+gk=; b=Hl
	I6XGqb3okTHmJAtVktLZ/3egBSh309JPdCBGLNWklZlBe6SvWdoX32SpYE3Ulnq5
	QBXoDTKOdPc6o4SiOyxl4WxPE4pWMaZb5qPzjq3wHAYnj0HgPt7g2ksmfVQjDvfj
	1106D0VZINS4K8f5IlttrXqeXD1adMr1qJAE2XYAUI7OCL1F/JPX/BWT159rDxU8
	yTR7owizsmZqDbxiVvJ54slzsLpSRXqbakmejYc5W663wVfl/UzifM4RFaeLW2Ra
	aQkLYj2qZQW8+ySVAmlsPZqIp5McAmmDqHcMm1nG6koR/FnkRZ8yIxRyYuJ7EBj4
	fkT/udd3GkHlc9zUJ73g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v07c6286b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7ev71021940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:57 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:40:53 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 07/14] net: phy: at803x: add the possible_interfaces
Date: Fri, 15 Dec 2023 15:39:57 +0800
Message-ID: <20231215074005.26976-8-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215074005.26976-1-quic_luoj@quicinc.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Z0uW0s37wvLdjGJ4fJsZZfAowzMiEOz
X-Proofpoint-ORIG-GUID: 9Z0uW0s37wvLdjGJ4fJsZZfAowzMiEOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=954
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150047

When qca808x works on the interface mode sgmii or
2500base-x, the interface mode can be switched according
to the PHY link speed.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index bb382089ab77..cd1bdb61d122 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2179,10 +2179,22 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_10G_QXGMII) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+		__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+	}
+}
+
 static int qca8084_config_init(struct phy_device *phydev)
 {
 	int ret;
 
+	qca808x_fill_possible_interfaces(phydev);
+
 	/* Invert ADC clock edge */
 	ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
 				    QCA8084_ADC_CLK_SEL_ACLK,
-- 
2.42.0


