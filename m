Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073227B7B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbjJDJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbjJDJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F4C6;
        Wed,  4 Oct 2023 02:05:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3947JECq007431;
        Wed, 4 Oct 2023 09:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=WizBBjvzfHe/M4gVG+KD2+2FRFMf6Q9R0WWoVVUYLeg=;
 b=IyYRjb3qT5ky0eV4AfrmuRfHMyIo9cIcd2tDIPdYQ3jNdXWVwNTZKYCbOHrR69JtLwyT
 Wt9aueAElYp8XvjL12yXAtfLzmyIsHOTyu2omlnDyglE4sB3FkIAfuSI++TY6x1SxDM6
 G2vrSvEMgv+Sg1NUhb35RHoWOMzPNmjrbp79R8eCW4fLVAA7UHps2SOObAqLRdZCAXWQ
 i41mrhy09fgk+febLHyqqcJy1/Nu2yohRIlek5i8B4aaHB8lHD2mHT+RGh57QkPXd5lm
 pFK8sUMx/RApSKTB0db4Mw54A6B4yqHnl3YjaJQdZnSyzsYFJRJi025G0x/oNYo4/YjP rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th1cy0e78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:05:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39495AY0013710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:05:10 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 02:05:05 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: [PATCH V13 0/4] Add PWM support for IPQ chipsets
Date:   Wed, 4 Oct 2023 14:34:45 +0530
Message-ID: <20231004090449.256229-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WSAaW2dMo11pPaLlfJ7V2E6qZC_Efxli
X-Proofpoint-GUID: WSAaW2dMo11pPaLlfJ7V2E6qZC_Efxli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=780 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040064
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

Devi Priya (4):
  pwm: driver for qualcomm ipq6018 pwm block
  dt-bindings: pwm: add IPQ6018 binding
  dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
  arm64: dts: ipq6018: add pwm node

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 100 +++++--
 .../bindings/pwm/qcom,ipq6018-pwm.yaml        |  45 +++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
 6 files changed, 423 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ipq.c

-- 
2.34.1

