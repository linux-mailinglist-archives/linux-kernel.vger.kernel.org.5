Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BEA803520
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbjLDNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjLDNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:38:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620926BA;
        Mon,  4 Dec 2023 05:27:29 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BcVUG013058;
        Mon, 4 Dec 2023 13:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Gcy1w3PefWJh243SAeR1phCMPiO1eZ4dlFAMhh8tH48=;
 b=PdWrtqnQtNveZPhwR5OrfP12g66s8LeOh0cenOrAuZW/Ccuwg4c/Yx1Y42t2AXtMbySk
 aAu/T+yHXgORqstFAvrzQCwXn44YnCLx9r8hA/7JTe2R074jU5As8uD6YtSFbYJctOEP
 vHAsMaDHZvNI8OAm8ooqETrLowtRgM2IJ+aWJRsG5Tnxhmr21fMBL9UdN+Mj4xHHoBJY
 xy5zE3d6zhYa2dukenjD6MyZ0cJ2onFUnCmOUS9CGWDgup5qQlNZs2fZQm+u0NpLinuN
 mlG7bTKhaha33toYCGRz25uM+SRfMhVk8E1FzuMJqz5231h+mJt7mR0L7Ik/kT7KrWkz lA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwrvv11n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 13:27:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4DR9dn004045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 13:27:09 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 05:27:00 -0800
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
        Andrew Halaney <ahalaney@redhat.com>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v3 3/3] net: stmmac: Add driver support for DWMAC5 safety IRQ Support
Date:   Mon, 4 Dec 2023 18:56:17 +0530
Message-ID: <d915004a7c45dc96fa326924c467e1f59af9ccbd.1701695218.git.quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1701695218.git.quic_jsuraj@quicinc.com>
References: <cover.1701695218.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UKLH59-fwy_VhQPC-tByT52VPU6dgYiT
X-Proofpoint-GUID: UKLH59-fwy_VhQPC-tByT52VPU6dgYiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQ support to listen HW safety IRQ like ECC,DPP,FSM
fault and print the fault information in the kernel
log.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 6b935922054d..c4821c7ab674 100644
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
index 686c94c2e8a7..8eac37ff002d 100644
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
@@ -343,6 +344,7 @@ struct stmmac_priv {
 	/* XDP BPF Program */
 	unsigned long *af_xdp_zc_qps;
 	struct bpf_prog *xdp_prog;
+	int safety_common_irq;
 };
 
 enum stmmac_state {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ac88aaffed..46a5cb20e4b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3591,6 +3591,10 @@ static void stmmac_free_irq(struct net_device *dev,
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
@@ -3797,6 +3801,18 @@ static int stmmac_request_irq_single(struct net_device *dev)
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
@@ -7459,6 +7475,8 @@ int stmmac_dvr_probe(struct device *device,
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

