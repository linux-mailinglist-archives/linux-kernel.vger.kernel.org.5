Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247EE8007E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378129AbjLAKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAKGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:06:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FBB2;
        Fri,  1 Dec 2023 02:06:18 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B14mDrR030535;
        Fri, 1 Dec 2023 10:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=A1EGrq2r/Zjw8fa3aqVFo2FlroFAid1G/BIBvjuO6XE=;
 b=EolkPQDcG1j3zhat+vvfRdu5KMutWS9ebFOytYPeKH34926T1Fy4QjTwnIXJyUeoKiGG
 QKzL8mon3wb6igqPzbAHzbVFP9S+YnNyh59iUmBq3xgHziu3s1IArhuzVvEsOZuQk8RO
 U62qDOJfQ/IMLGqTWHLzlKdDdhWf7/CpdS0vyvWP/OG1y9sQUICF1imGBh/kqcppNnus
 Uvlh3tpXKg/88lgNWoIl0iI1AUZL2HyEh/1Osm9uyKl9IZGaFLlL+rmz4TszjTz47tiS
 a5TjpqmBhnyvlh4HdxJ+WuFML4t7Vu09xZasH3yRalVzmIlvTnh9dWt0kRm8wXnT3zGC zQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhdu3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 10:06:02 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B1A5urY026649;
        Fri, 1 Dec 2023 10:05:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3unmf087ye-1;
        Fri, 01 Dec 2023 10:05:56 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1A5uQd026644;
        Fri, 1 Dec 2023 10:05:56 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-snehshah-hyd.qualcomm.com [10.147.246.35])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3B1A5ulh026640;
        Fri, 01 Dec 2023 10:05:56 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2319345)
        id 6DC595001C3; Fri,  1 Dec 2023 15:35:55 +0530 (+0530)
From:   Sneh Shah <quic_snehshah@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sneh Shah <quic_snehshah@quicinc.com>, kernel@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2] net: stmmac: update Rx clk divider for 10M SGMII
Date:   Fri,  1 Dec 2023 15:35:48 +0530
Message-Id: <20231201100548.12994-1-quic_snehshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H7GjdgLppbe_t5WTRxU9l3iP1t53Znd7
X-Proofpoint-GUID: H7GjdgLppbe_t5WTRxU9l3iP1t53Znd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=763
 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010067
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
Update configure SGMII function with rx clk divider programming.

Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
---
v2 changelog:
- Use FIELD_PREP to prepare bifield values in place of GENMASK
- Add fixes tag
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d3bf42d0fceb..df6ff8bcdb5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -34,6 +34,7 @@
 #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
 #define RGMII_CONFIG_PROG_SWAP			BIT(1)
 #define RGMII_CONFIG_DDR_MODE			BIT(0)
+#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
 
 /* SDCC_HC_REG_DLL_CONFIG fields */
 #define SDCC_DLL_CONFIG_DLL_RST			BIT(30)
@@ -617,6 +618,9 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 	case SPEED_10:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL;
 		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
+		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
+			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31),
+			      RGMII_IO_MACRO_CONFIG);
 		break;
 	}
 
-- 
2.17.1

