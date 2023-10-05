Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328F7BA603
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbjJEQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbjJEQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:18:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660B3F024;
        Thu,  5 Oct 2023 09:06:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395ESXaV024333;
        Thu, 5 Oct 2023 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=a1aM1vRSIVXNKe9ey/sJJp8ITSVIKnBHHHgqr/71Noo=;
 b=V2jCbnevPtAH4P7huTKahG6eBI61tiss5vupzEsyAlbBug8mJa8wEsvBS8uSCJxpjsSx
 QwM58UUFBaOsg5lMWhWWbm1oUa/VfDGiqRgcoPc6thDA+InzDYAZLMYCcHW0fUc2l5uW
 xP16e0uocpMd4Y9qALCPlv9J0S1UpMLpFJjc/FZQCDSQXRMv4ZOUd2PGH1YfFoJLuEqR
 qILnZGwDlI/1d7xOnhSbjKm2B4h2VIvxqwq4rk0+A0dSeFfD+uafyOcJ3FzOo6r+qyBO
 dv5b1qnS1oTLneI5fy+g0O5gobvWUFrO6JS/iQgPZZuV33okfGYst/1EPaT7HYcnhUnq 2g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thnfa9b9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:06:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395G6F0Z025344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 16:06:15 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 09:06:10 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
Subject: [PATCH V15 0/4] Add PWM support for IPQ chipsets
Date:   Thu, 5 Oct 2023 21:35:46 +0530
Message-ID: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J5UNpgl0t--lsTn1f4hyvxjJLvPOcMv1
X-Proofpoint-ORIG-GUID: J5UNpgl0t--lsTn1f4hyvxjJLvPOcMv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=671 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM driver and binding support for IPQ chipsets.
Also, add support for pwm node in ipq6018.

V15:
Detailed Change logs are added to the respective patches.

V14 can be found at:
https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/

Devi Priya (4):
  pwm: driver for qualcomm ipq6018 pwm block
  dt-bindings: pwm: add IPQ6018 binding
  dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
  arm64: dts: qcom: ipq6018: add pwm node

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 112 +++++--
 .../bindings/pwm/qcom,ipq6018-pwm.yaml        |  45 +++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
 6 files changed, 435 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ipq.c

-- 
2.34.1

