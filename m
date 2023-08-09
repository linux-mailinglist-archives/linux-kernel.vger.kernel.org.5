Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A8775E97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHIMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHIMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:12:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678311999;
        Wed,  9 Aug 2023 05:12:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379AqXL7014019;
        Wed, 9 Aug 2023 12:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=wIwDEsDwmZWTIMj9zAhU0yuFWxfk5UetXJNBCBioavM=;
 b=Awgs9dStOxUkFcy8jbyz5UEai/6hNlm50mfXjUFoIo12xz1pA0DfEmzsWfndMQYEkFuS
 lasU1vyQN3f7PjD3LTHdtTP8dFmeZEt/t+Bymj6qg8aIaCM0WFywLYLznBN7czK/E9di
 BGUDvbmCVKgtUBwiS5nkQ9LX3WHEtaHcPvC623xZVKwphSDUeJTCXOjKABZHmJZR6BMn
 djkbKy/O1aB4ml9pMm38DcWSH48yu1sO52afJ0SXcnbdA3L2an7MaAP/9+5KiXSuiblR
 SZEVyQdo4iAhxhS2q/DN1iQokoMDeMbrUI7zEePBvKzdO2gscRPfYe8Ern8LDgH4CS+1 Eg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbpqs2gbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 12:11:51 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 379CBlF9004603;
        Wed, 9 Aug 2023 12:11:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s9fgm2j6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 09 Aug 2023 12:11:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379CBkxH004597;
        Wed, 9 Aug 2023 12:11:46 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 379CBkrQ004596;
        Wed, 09 Aug 2023 12:11:46 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id AA7184CFB; Wed,  9 Aug 2023 17:41:45 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary sequencer irq status after cancel_tx
Date:   Wed,  9 Aug 2023 17:41:40 +0530
Message-Id: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gZXX0T9TSdnwxcdjvq5X4_Ko-qhTSAYP
X-Proofpoint-ORIG-GUID: gZXX0T9TSdnwxcdjvq5X4_Ko-qhTSAYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=951 malwarescore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090107
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TX is handled by primary sequencer. After cancelling primary command, poll
primary sequencer's irq status instead of that of secondary.
While at it, also remove a couple of redundant lines that read from IRQ_EN
register and write back same.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3ca5db2..b8aa4c1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -591,7 +591,6 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	bool done;
-	u32 m_irq_en;
 
 	if (!qcom_geni_serial_main_active(uport))
 		return;
@@ -603,12 +602,10 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 		port->tx_remaining = 0;
 	}
 
-	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	geni_se_cancel_m_cmd(&port->se);
 
-	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
-					 S_CMD_CANCEL_EN, true);
+	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+					 M_CMD_CANCEL_EN, true);
 	if (!done) {
 		geni_se_abort_m_cmd(&port->se);
 		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-- 
2.7.4

