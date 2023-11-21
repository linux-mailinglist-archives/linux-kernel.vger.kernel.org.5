Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E97F30CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjKUObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKUObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:31:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86E90;
        Tue, 21 Nov 2023 06:31:19 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE2LG1024641;
        Tue, 21 Nov 2023 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=mS5lpO1pQal3MndLWJq7JlecLvEPze68AS+UktMGphA=;
 b=RRqmT+chsmkCLIjqq4O/5Ikar+e3jPjVaq6yLtFmxTK5Sqpade/KR03pLk00DMRIKxkB
 3fHA4s7/PZRjQIsySy0nydTZTbyQq5xi5r/PzndkkxisCyMK6JpUqTMaPfl5zERHqeTI
 KR4gvL+KRJhZiHTaFieap8XHx4WjMV7xoKlYKTyPBZ2WZ/nC8YG9aKq0x5fXhBCHcHGC
 tREzy1A8++sHSvlFb4EagexpGO4l3YYiIE8B8xAEOLeadiiwO5S6+GQ2LMB3uybBNs3h
 mr3tu7gyjwiAE5IRM8bH4xr5ufot04Z4GqzjwH7tEI+P9zA/0CUH2ZApEUlxsFHUSnlb dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugdxmjknm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEV6O0027329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:06 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:01 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v2 0/9] Add NSS clock controller support for Qualcomm
 IPQ5332
Date:   Tue, 21 Nov 2023 20:00:42 +0530
Message-ID: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABK/XGUC/3XMQQ7CIBCF4as0sxYDg5DoynuYLsg4tbOQtlCJp
 uHuYvcu/5e8b4PMSTjDpdsgcZEsU2yBhw5oDPHBSu6tATVao61WMi/OWlQxZyIVONCZjbP65KB
 95sSDvHfv1rceJa9T+ux8wd/6TypGaeWNx4Dk3aDDdXkJSaQjTU/oa61fCwFL1qwAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=2190;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=V3e9HOo0Prh+0sVYu6OBkKtzBPya9k/mvTsnXsdzeBQ=;
 b=092KjIA5Vs8qRQVNaXEaZ41a3/A47dax2I/FKKYeXpok7/16wTnAVmhSbhzOXYn2iETsF6T72
 hnMDTWbjdP8AsPds5oDXvVUYvrNzw0sCeqWnHQv9n0B6K4MYM4lZUJs
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7B7Si-JmLaceIE4wPKn33xd8EEVAOSWw
X-Proofpoint-ORIG-GUID: 7B7Si-JmLaceIE4wPKn33xd8EEVAOSWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for networking sub system clock
controller on IPQ5332. Some of the nssnoc clocks present in GCC driver is
enabled by default and its RCG is configured by bootloaders, so enable
those clocks in driver probe.

The NSS clock controller driver depends on the below patchset which adds
support for multiple configurations for same frequency.
https://lore.kernel.org/linux-arm-msm/20230531222654.25475-1-ansuelsmth@gmail.com/

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v2:
- Change logs are in respective patches
- Link to v1: https://lore.kernel.org/r/20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com

---
Kathiravan Thirumoorthy (9):
      clk: qcom: ipq5332: add const qualifier to the clk_init_data structure
      clk: qcom: ipq5332: enable few nssnoc clocks in driver probe
      dt-bindings: clock: ipq5332: drop the few nss clocks definition
      dt-bindings: clock: ipq5332: add definition for GPLL0_OUT_AUX clock
      clk: qcom: ipq5332: add gpll0_out_aux clock
      dt-bindings: clock: add Qualcomm IPQ5332 NSSCC clock and reset definitions
      clk: qcom: add NSS clock Controller driver for Qualcomm IPQ5332
      arm64: dts: qcom: ipq5332: add support for the NSSCC
      arm64: defconfig: build NSS Clock Controller driver for Qualcomm IPQ5332

 .../bindings/clock/qcom,ipq5332-nsscc.yaml         |   60 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |   28 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |    7 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                     |  122 +--
 drivers/clk/qcom/nsscc-ipq5332.c                   | 1035 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h       |    4 +-
 include/dt-bindings/clock/qcom,ipq5332-nsscc.h     |   86 ++
 9 files changed, 1264 insertions(+), 80 deletions(-)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231030-ipq5332-nsscc-aeac9e153045

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

