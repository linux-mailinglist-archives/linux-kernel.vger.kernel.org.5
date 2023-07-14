Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B94753085
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjGNEWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGNEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:22:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428EC2699;
        Thu, 13 Jul 2023 21:22:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E2etcP028186;
        Fri, 14 Jul 2023 04:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5UoERwpVcmVx8sbdtYq2WKZ4YFLmqqAapGxiz/O3IXU=;
 b=ILiZDLP9eE7nC40c03mngawJT6G/vkoh84ySYQz55S10qfPvmbTta2L7V5lXfc2aEDI7
 0MQWOaPUaS0qyowJFfKOfLRXq769+lDDyss0kU/oasp4LzVPNy+hiWRdAm4xcUnwzqoQ
 MCNevbyI4yXJC0Joc8LZETsAklXR1hZVN8mAI6vXC+XZazyE4K4sa/FZzIhsPlZNPutY
 Bj8SyEfjjsnMgipEOK2NfWcHuaeKuGFc7xUN1hnVFfRsfcP0186s+/zcguihwIRb54xN
 WTzk8wSR2wMupDtO4c6Q7rCQb4rxlyHfoL4mq00B3WguhQnx3xi70IYCjXVPL2zryUuI bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpugrsf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 04:22:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E4MYQE015589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 04:22:34 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 21:22:30 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v7 0/2] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3
Date:   Fri, 14 Jul 2023 09:52:01 +0530
Message-ID: <20230714042203.14251-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6txhHlXatY__YsikTcVsD554SmtWM-bU
X-Proofpoint-ORIG-GUID: 6txhHlXatY__YsikTcVsD554SmtWM-bU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_01,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 mlxlogscore=464 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds spi device mode functionality to geni based Qupv3.
The common header file contains spi slave related registers and masks.

Praveen Talari (2):
  soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
  spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
---
v6 -> v7:
- Corrected author mail

v5 -> v6:
- Added code comments
- Dropped get_spi_master api

v4 -> v5:
- Addressed review comments in driver

v3 -> v4:
- Used existing property spi-slave
- Hence dropped dt-binding changes

v2 -> v3:
- Modified commit message
- Addressed comment on dt-binding

v1 -> v2:
- Added dt-binding change for spi slave
- Modified commit message
- Addressed review comments in driver

 drivers/spi/spi-geni-qcom.c      | 53 ++++++++++++++++++++++++++++----
 include/linux/soc/qcom/geni-se.h |  9 ++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.17.1

