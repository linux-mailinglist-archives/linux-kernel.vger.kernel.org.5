Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC741793483
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjIFE4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIFE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:56:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D21A8;
        Tue,  5 Sep 2023 21:56:50 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864o2OR021049;
        Wed, 6 Sep 2023 04:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=6dhCSufUff6PZdJkX6WqGu9v1sZ+SMsF2I6xUap+8wg=;
 b=Jw/FbjY+2ElbVI5X2FrNp0yccMZpj9fwAl5lGZI7jpLDfS4RffhM3QROgni8x5KOB8wE
 ursM2Lgbqj6lF5xv6wPUJJh2T0AgykrXXCQj2NAIuq3739erylG4WDK0MQnK6j+IH9+x
 /XSaoIH6XWbRGvIZXdSn2mv3/jNRK/Bk8Ooe24u7NMBbUPHWn1VTtoq2JIQq5nxasw2a
 VD69GSYf+vIfGamvCIsSrcuEGmXdBlAOgAjCeTDx5LDrqULr39MZGGi1LgOsbBMspwTO
 aFp7bp3EFPSsX+3paeeugao2cG6CmDyLs5Dbjpu/drWLpoamPiFM6XIvyXbCZZLjfO4v VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxha305gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:56:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864uZBb027323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:56:35 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:56:30 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH RESEND 0/7] Add GPLL0 as clock provider for the Qualcomm's
 IPQ mailbox controller
Date:   Wed, 6 Sep 2023 10:26:19 +0530
Message-ID: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=2969;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=PTzcvWf8C/T3ua26bVQjrUYtonB3P/rkcpv5LygGuzI=;
 b=QYOcC8vrEcm2J/ByWhipUteyU1ZkPEuV7xpIjwuf2KJsmst4baSee9GoLRGP/0TNM1QcYxIkX
 cflSfjhRzjFCOpddKR9jzfE7CpHYCCwhyIjIjgUmP3YoBkuvtzWJZa4
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bg-Jz2mytKI6fOi6VkvY0W5Tr_wZmz1a
X-Proofpoint-GUID: bg-Jz2mytKI6fOi6VkvY0W5Tr_wZmz1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=928 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently mailbox controller takes the XO and APSS PLL as the input. It
can take the GPLL0 also as an input. This patch series adds the same and
fixes the issue caused by this.

Once the cpufreq driver is up, it tries to bump up the cpu frequency
above 800MHz, while doing so system is going to unusable state. Reason
being, with the GPLL0 included as clock source, clock framework tries to
achieve the required rate with the possible parent and since GPLL0 carries
the CLK_SET_RATE_PARENT flag, clock rate of the GPLL0 is getting
changed, causing the issue.

First half of the series, removes the CLK_SET_RATE_PARENT flag from the
PLL clocks since the PLL clock rates shouldn't be changed. Another
half, add the necessary support to include the GPLL0 as clock provider
for mailbox and accomodate the changes in APSS clock driver.

This is also the preparatory series to enable the CPUFreq on IPQ5332
SoC. Dynamic scaling of CPUFreq is not supported on IPQ5332, so to
switch between the frequencies we need to park the APSS PLL in safe
source, here it is GPLL0 and then shutdown and bring up the APSS PLL in
the desired rate.

For IPQ5332 SoC, this series depends on the below patch
https://lore.kernel.org/linux-arm-msm/1693474133-10467-1-git-send-email-quic_varada@quicinc.com/

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Kathiravan Thirumoorthy (7):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      dt-bindings: mailbox: qcom: add one more clock provider for IPQ mailbox
      clk: qcom: apss-ipq6018: add the GPLL0 clock also as clock provider
      arm64: dts: qcom: include the GPLL0 as clock provider for IPQ mailbox

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml         | 2 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                              | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                              | 4 ++--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                              | 4 ++--
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                              | 4 ++--
 drivers/clk/qcom/apss-ipq6018.c                                    | 3 +++
 drivers/clk/qcom/gcc-ipq5332.c                                     | 2 --
 drivers/clk/qcom/gcc-ipq6018.c                                     | 7 -------
 drivers/clk/qcom/gcc-ipq8074.c                                     | 7 -------
 drivers/clk/qcom/gcc-ipq9574.c                                     | 4 ----
 10 files changed, 13 insertions(+), 28 deletions(-)
---
base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
change-id: 20230904-gpll_cleanup-8b3e8b058c8b

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

