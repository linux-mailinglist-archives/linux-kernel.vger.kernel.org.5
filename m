Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B381280C2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjLKIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjLKICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:02:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA385101;
        Mon, 11 Dec 2023 00:02:54 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB7aoV9013723;
        Mon, 11 Dec 2023 08:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=+FEzrFKs6ZPhCQRBlfYnh24zV5xaPlV/IKpddkGjXTw=; b=ja
        oQqXLkSUd5O5JXVKrGhXAYK5sZ/4VSVYd3xR7Iknkbqi8y3vIR3OPp/FxBNu+XC5
        aXMgVwVDIDU1UWeCU1Lh2Pkk97hCi8l/p94KLqE3knOPklp6nP+fApnGoRYsfR4X
        kLx4kiXqTuyqsvqDciG/tQdCnbi1hyUxyReQ/eG8dtroTxDpmLTg770IVUXzaTnN
        0+/8umhD3ToL0IcAuiEKSajMadLigc9F5vuH2eNqbzmiiCmUPpWxR5TZTvjsk+65
        IXak+PtHVomGeN1ytfsPqi27ma93Wzjd19bw/9gHkeSpk8gTwYJSqZ+VyL2InmCW
        hxM2QwA4dQoXlWYOy9uA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uwjyjrynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:02:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB82eYp003204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:02:40 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 00:02:30 -0800
From:   Suraj Jaiswal <quic_jsuraj@quicinc.com>
To:     <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v5 3/3] net: stmmac: Add driver support for DWMAC5 safety IRQ support
Date:   Mon, 11 Dec 2023 13:31:53 +0530
Message-ID: <20231211080153.3005122-4-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
References: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x5JuBftQhK7WbrtJsDHr2lL8fsUiMgXn
X-Proofpoint-ORIG-GUID: x5JuBftQhK7WbrtJsDHr2lL8fsUiMgXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQ support to listen HW safety IRQ like ECC(error
correction code), DPP(data path parity), FSM(finite state
machine) fault and print the fault information in the kernel
log.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..cb9645fe16d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -347,6 +347,7 @@ enum request_irq_err {
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
 	REQ_IRQ_ERR_LPI,
+	REQ_IRQ_ERR_SAFETY,
 	REQ_IRQ_ERR_WOL,
 	REQ_IRQ_ERR_MAC,
 	REQ_IRQ_ERR_NO,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 9f89acf31050..aa2eda6fb927 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -33,6 +33,7 @@ struct stmmac_resources {
 	int irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
+	int safety_common_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
 	int tx_irq[MTL_MAX_TX_QUEUES];
 };
@@ -299,6 +300,7 @@ struct stmmac_priv {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	int sfty_ce_irq;
 	int sfty_ue_irq;
+	int safety_common_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
 	int tx_irq[MTL_MAX_TX_QUEUES];
 	/*irq name */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47de466e432c..e4a0d9ec8b3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
 			free_irq(priv->wol_irq, dev);
 		fallthrough;
+	case REQ_IRQ_ERR_SAFETY:
+		if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq)
+			free_irq(priv->safety_common_irq, dev);
+		fallthrough;
 	case REQ_IRQ_ERR_WOL:
 		free_irq(dev->irq, dev);
 		fallthrough;
@@ -3798,6 +3802,18 @@ static int stmmac_request_irq_single(struct net_device *dev)
 		}
 	}
 
+	if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq) {
+		ret = request_irq(priv->safety_common_irq, stmmac_safety_interrupt,
+				  0, "safety", dev);
+		if (unlikely(ret < 0)) {
+			netdev_err(priv->dev,
+				   "%s: alloc safety failed %d (error: %d)\n",
+				   __func__, priv->safety_common_irq, ret);
+			irq_err = REQ_IRQ_ERR_SAFETY;
+			goto irq_error;
+		}
+	}
+
 	return 0;
 
 irq_error:
@@ -7464,6 +7480,8 @@ int stmmac_dvr_probe(struct device *device,
 	priv->lpi_irq = res->lpi_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
+	priv->safety_common_irq = res->safety_common_irq;
+
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
 		priv->rx_irq[i] = res->rx_irq[i];
 	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 1ffde555da47..41a4a253d75b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -726,6 +726,15 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	stmmac_res->safety_common_irq =
+		platform_get_irq_byname_optional(pdev, "safety");
+
+	if (stmmac_res->safety_common_irq < 0) {
+		if (stmmac_res->safety_common_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
-- 
2.25.1

