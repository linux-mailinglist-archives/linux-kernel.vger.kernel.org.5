Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA087AD0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjIYHAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjIYG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:59:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF4CF;
        Sun, 24 Sep 2023 23:59:51 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P5DdZ4028258;
        Mon, 25 Sep 2023 06:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Ui/rR6BUBsfiSpLCNBIjp14VY6rQXxkTQ8UdtHdSN3M=;
 b=ODaAXr3GwntTHubRmK8FEmuFqOTIUh6Kj0cJYMJcwIaxywzasbvQtUHedNS88wpPMobi
 AHmhKfBAz57MMEOf9vGKr7pV85uwmqTKixhZ2eEmAF7AlbEhWndB/sGrSKM7YIyEFz2d
 e9kAD7pemSR1B4YBaPz6UwTK4+L7QtNCn4A/eSrBW30FcMm+NmirtfwB1qXq4Mcf/pAQ
 u9oSF98jl2R9z2dq/s2miMjqu3t4L9dAOXrHJKPoqXk9Hteb7OoEACzdf3hTES+TgRix
 yOkLVtra8gTdNPc+ysBxvvI7kl0tgiIZEGu7bXp3qIgXZ4IpvqXVqztJvjCTbgNO3+IB kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9qbpu3x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:59:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P6xXPB025886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:59:33 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 24 Sep 2023 23:59:28 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
Subject: [PATCH V12 0/3] Add PWM support for IPQ chipsets
Date:   Mon, 25 Sep 2023 12:29:12 +0530
Message-ID: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MbP2NKkmWh8SzeQhJqXqaY68dKJC1xfz
X-Proofpoint-ORIG-GUID: MbP2NKkmWh8SzeQhJqXqaY68dKJC1xfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=755 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM driver and binding support for IPQ chipsets.
Also, add support for pwm in ipq6018.

Devi Priya (3):
  pwm: driver for qualcomm ipq6018 pwm block
  dt-bindings: pwm: add IPQ6018 binding
  arm64: dts: ipq6018: add pwm node

 .../devicetree/bindings/pwm/ipq-pwm.yaml      |  53 ++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
 5 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ipq.c


base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.34.1

