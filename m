Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD52579FC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjINHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjINHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:00:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F8CE5;
        Thu, 14 Sep 2023 00:00:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6ohHl016670;
        Thu, 14 Sep 2023 07:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=u4EY5mYqhVxu6XA4m47wpl80mCwYKaw5E80Ja/QRAOQ=;
 b=HTGn4sO93wD9X+l8bZR4m23vCQGHS6nIfQHSpNwlTGCbpL6dS8WUaQ6NHIlDffdTcMvo
 E2Gp7H4jTzYyBt75TEZgRk5QTRleWGqy8oNwcz+6q4XqU3ECLR95R8VqPsHDLo4dLvtM
 o5BHuMrfX0T/p9pzD7QY7+KQjJES8v0YuO5C2taPStOze8i9JDaTldr4GXVbN9y8/rbc
 hR90aRSxTDT+4qtq3UR+6VUT0pCOW1J9oP4SFQAJK0HMzjc/qbKZwxct7/1RvO0Xcb6m
 TvsLJ/bbS4uZtg4pRTWfTRuqSoVp01Qo8k1COsIUF1oxmDfFrq0O9eu65oxQTUoIDNU8 CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ar3jmuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E70GOU003614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:16 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 00:00:10 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v2 00/11] Add GPLL0 as clock provider for the Qualcomm's
 IPQ mailbox controller
Date:   Thu, 14 Sep 2023 12:29:50 +0530
Message-ID: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGavAmUC/1WNyw6CMBBFf4XM2po+MIIr/8MQU9oBJoEWWyAaw
 r9biBuX596cnBUiBsIIt2yFgAtF8i6BPGVgOu1aZGQTg+RS8VIo1o59/zQ9ajeP7GK5VqrE2oo
 rJKXWEVkdtDPdLg06Thj2YwzY0PvoPKrEHcXJh8+RXcS+/go8/y8sgnFmUZo8LxohiuL+msmQM
 2fjB6i2bfsCkAqpOsMAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        <stable@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Robert Marko <robimarko@gmail.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694674810; l=3776;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=UDcuJGx9NCUsK6VJ+WDZmeZGkqWFuIL5bDHorMUBT7w=;
 b=RvFT2F3/EuAq/fIY1A1wU9WQM8iedTfS7Fb+xf2qTcfVawyAH15/j/uKnJBoQpsu+4PSj7qy8
 z5zI1klGQ65ArXFqIR/QVIKD3mh+dL7lRyD1un74WejNb02x0y1yJTa
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QV2GkuNJ3fK1hPvw1x94YvmTR3bWHQju
X-Proofpoint-ORIG-GUID: QV2GkuNJ3fK1hPvw1x94YvmTR3bWHQju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently mailbox controller takes the XO and APSS PLL as the input. It
can take the GPLL0 also as an input. This patch series adds the same and
fixes the issue caused by this.

Once the cpufreq driver is up, it tries to bump up the cpu frequency
above 800MHz, while doing so system is going to unusable state. Reason
being, with the GPLL0 included as clock source, clock framework tries to
achieve the required rate with the possible parent and since GPLL0
carries the CLK_SET_RATE_PARENT flag, clock rate of the GPLL0 is getting
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
Changes in v2:
- included the patch to drop the CLK_SET_RATE_PARENT from IPQ5018 GCC driver
- Splitted the DTS changes per target
- For IPQ8074 and IPQ6018 keep the CLK_SET_RATE_PARENT for UBI32 PLL
  since the PLL clock rates can be changed
- Pick up the tags in the relevant patches
- Link to v1: https://lore.kernel.org/r/20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com

---
Kathiravan Thirumoorthy (11):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq5018: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      dt-bindings: mailbox: qcom: add one more clock provider for IPQ mailbox
      clk: qcom: apss-ipq6018: add the GPLL0 clock also as clock provider
      arm64: dts: qcom: ipq8074: include the GPLL0 as clock provider for mailbox
      arm64: dts: qcom: ipq6018: include the GPLL0 as clock provider for mailbox
      arm64: dts: qcom: ipq9574: include the GPLL0 as clock provider for mailbox
      arm64: dts: qcom: ipq5332: include the GPLL0 as clock provider for mailbox

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml          | 2 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                               | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                               | 4 ++--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                               | 4 ++--
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                               | 4 ++--
 drivers/clk/qcom/apss-ipq6018.c                                     | 3 +++
 drivers/clk/qcom/gcc-ipq5018.c                                      | 3 ---
 drivers/clk/qcom/gcc-ipq5332.c                                      | 2 --
 drivers/clk/qcom/gcc-ipq6018.c                                      | 6 ------
 drivers/clk/qcom/gcc-ipq8074.c                                      | 6 ------
 drivers/clk/qcom/gcc-ipq9574.c                                      | 4 ----
 11 files changed, 13 insertions(+), 29 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230913-gpll_cleanup-5d0a339ebd17

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

