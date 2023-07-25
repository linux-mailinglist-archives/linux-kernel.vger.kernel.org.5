Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA176178C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjGYLsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjGYLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:48:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868FA10E3;
        Tue, 25 Jul 2023 04:48:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PAVCh6024633;
        Tue, 25 Jul 2023 11:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Y8buMMzhQ7FtSPdJ2/drbMy2Q2nEihK3vxgah9dupxs=;
 b=hkHCdqjnspq/GdYZCqNQ9aVpD4kz5JCSt+zXwexp2MegcVRo5Rm9uCeUYGpxr+8RonVb
 /8duf56r6CGvhyGdvy4QIpOzPgP6deXEuPWJMUexIbEhLmzSyybzS6Su2OHHw9xoLAKq
 KI2jmWBcW2qBTxjLz2udOQsihILwwe8E6ZHSUQMfrjh8Tx29i7bGNAiznWMG+y2nEr0W
 rUKmURbZQRWAAWgzj/VqoEaWVPT3HplaRfUY9nM1gVglX8v+5bpOeLp4j6s1gqNgf0SF
 z7qjzF/Kei2LQXYnVtOnR4gQMw43jahXiYvHkJT3wFcPU1OwPW93MvemN5yqgcO+Q6Ao PQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qastu83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 11:48:20 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PBmHpj008447;
        Tue, 25 Jul 2023 11:48:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086kv0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 11:48:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PBmGgU008439;
        Tue, 25 Jul 2023 11:48:16 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36PBmG9F008437;
        Tue, 25 Jul 2023 11:48:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id EE50A3434; Tue, 25 Jul 2023 17:18:15 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        dan.carpenter@linaro.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 1/4] spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
Date:   Tue, 25 Jul 2023 17:18:06 +0530
Message-Id: <1690285689-30233-2-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J95l_wAvZ-t56Eurjd4jWKpSBQFejlIy
X-Proofpoint-GUID: J95l_wAvZ-t56Eurjd4jWKpSBQFejlIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=258 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During FIFO/DMA modes dynamic switching, only corresponding interrupts are
enabled. However its possible that FIFO related interrupt status registers
get set during DMA mode. For example WR_FIFO_EMPTY bit is set during DMA
TX.

Ignore such status bits so that they don't trip unwanted operations.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-qcom-qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index a0ad980..b995542 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -603,6 +603,9 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 	int_status = readl(ctrl->base + MSTR_INT_STATUS);
 	writel(int_status, ctrl->base + MSTR_INT_STATUS);
 
+	/* Ignore disabled interrupts */
+	int_status &= readl(ctrl->base + MSTR_INT_EN);
+
 	/* PIO mode handling */
 	if (ctrl->xfer.dir == QSPI_WRITE) {
 		if (int_status & WR_FIFO_EMPTY)
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

