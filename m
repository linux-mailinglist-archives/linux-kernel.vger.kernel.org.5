Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409876226C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGYTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGYTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:36:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651C2109;
        Tue, 25 Jul 2023 12:36:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJO3Mx022146;
        Tue, 25 Jul 2023 19:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=U4ugMQoKqr2BDtj344YTHiHFUMbVp5SWf69DpzFrCvY=;
 b=JjPoJQksej7sAgMczwKTNGQ9CZp5xssR8xN9X9Z/Os3U8PRGJiPy5Bl5j8wAMn9qs1pB
 m5StvyKGRGlzSjkcM7KmImKsRA3ICwnSlL2SbakSR2iPmWbkxqrS2y+PwmMmxHZP1PPl
 Sc8QbJJ6dI+bYwJYrdN0WWXjfrXC0q1pTFXW9fYngIPQl8O1I/XJ8mY0jGkUerZB6QcJ
 xSlRC0nnGEnSeayEPtadMhxYHVaEXbVa8fWA3aT1+4ZSNezSSHgRCUutreMWC/jJLxrn
 MKgGOGaXr2rQyd9TFqqq9bWMkI3Kf5XtR+ts9PqALHb7ChTuCd4bKmu3R/K9UW0uPHxz AQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gxd0htn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:35:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJZwrC014134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:35:58 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 12:35:58 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 0/7] Add support for LUT PPG
Date:   Tue, 25 Jul 2023 12:34:16 -0700
Message-ID: <20230725193423.25047-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: avQ4zb8W6o0zdiib4g1PWdRiFf9gQ1i1
X-Proofpoint-ORIG-GUID: avQ4zb8W6o0zdiib4g1PWdRiFf9gQ1i1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=914 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain PMICs, LUT pattern and LPG configuration can be stored in SDAM
modules instead of LUT peripheral. This feature is called PPG.

This change series adds support for PPG. Thanks!

Changes since v1:
  - Patch 1/7
    - Fix dt_binding_check errors
    - Update binding description
  - Path 2/7
    - Fix dt_binding_check errors
    - Update per variant constraints
    - Update nvmem description
  - Patch 3/7
    - Update get_pbs_client_device()
    - Drop use of printk
    - Remove unused function

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pmi632)

Anjelique Melendez (7):
  dt-bindings: soc: qcom: Add qcom-pbs bindings
  dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
  soc: qcom: add QCOM PBS driver
  leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
  leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
  leds: rgb: leds-qcom-lpg: Support two-nvmem PPG Scheme
  leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme

 .../bindings/leds/leds-qcom-lpg.yaml          |  92 +++-
 .../bindings/soc/qcom/qcom-pbs.yaml           |  40 ++
 drivers/leds/rgb/leds-qcom-lpg.c              | 395 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 302 +++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 ++
 7 files changed, 836 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0

