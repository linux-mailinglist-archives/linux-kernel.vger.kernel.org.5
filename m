Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5976176A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGYLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjGYLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:48:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD1E74;
        Tue, 25 Jul 2023 04:48:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PAVuMd013198;
        Tue, 25 Jul 2023 11:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=3e0b7EvvEVtXP6Zq2CP3Qw3EoqOYKi7wp2ZLSG6MY5c=;
 b=Svy1parQ5axKRJZK3rvr8Wg0JNL0bpCmqAaDxcRt/7u14LaDZVT7dZSQ3RNVIcowdM9F
 X2UqeOJ9XD27JdtHN3VgideIRtRXNAmkzzPj4BdT8/tfRnod+rnjhPNA7Rdzvjay/Uyy
 7V0HlcNIbKmaxUsQeuZbuZ+hkL+GfqR8la/WXTzcYyJCzKYv+nI4iFGVMUMrYszVFky2
 zcLX1YgeGQ+HZbukrOUZ+Ne2VwEbCuVpn9lWiyrgxNcug/PYBcVZwah7uwZKrc/Krcn7
 8MpGKH/u2rLB9GZUHmsac4WUpUBJRjfZtOe8tJPQEEsuY1kkSDN5hrof9dwG3Tu/8/5V uw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29j5gjse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 11:48:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PBmLsH008490;
        Tue, 25 Jul 2023 11:48:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086kv0yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 11:48:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PBmKi8008485;
        Tue, 25 Jul 2023 11:48:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36PBmKii008484;
        Tue, 25 Jul 2023 11:48:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D6CA13434; Tue, 25 Jul 2023 17:18:19 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        dan.carpenter@linaro.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 4/4] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
Date:   Tue, 25 Jul 2023 17:18:09 +0530
Message-Id: <1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: znj9Rg9zXRfC7u0xWKRV3DrYy7bjHiQO
X-Proofpoint-GUID: znj9Rg9zXRfC7u0xWKRV3DrYy7bjHiQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=688 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add latest added DMA_CHAIN_DONE irq to QSPI_ALL_IRQS that encompasses all
of the qspi IRQs.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-qcom-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index d75234d..b56cb16 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -69,7 +69,7 @@
 				 WR_FIFO_OVERRUN)
 #define QSPI_ALL_IRQS		(QSPI_ERR_IRQS | RESP_FIFO_RDY | \
 				 WR_FIFO_EMPTY | WR_FIFO_FULL | \
-				 TRANSACTION_DONE)
+				 TRANSACTION_DONE | DMA_CHAIN_DONE)
 
 #define PIO_XFER_CTRL		0x0014
 #define REQUEST_COUNT_MSK	0xffff
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

