Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6F80BFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjLKDhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:37:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B9EA;
        Sun, 10 Dec 2023 19:37:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB2twI1015931;
        Mon, 11 Dec 2023 03:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding:to:cc; s=qcppdkim1; bh=Iy3NMnpxBD83P5
        N/K9x9lC3sCgLsQgh+v9RxbcLUjgA=; b=Ug928xMkFx6VOkdTclV9KSIKnh8y3c
        X4F4NVtfHLKfcXaBteUvHH6kKLKBLzf0E9OTQtOXdrMc/G4aXYU7B4PxXT2K2fzn
        SLOdTLj5/zF3zUQlf4QLO/YHZa8fVuoTOCRjPEAgcUcS9cXUetsJ/PsMbF3cmGqg
        D6/j71v6Ob5OnUQbf6nk+fdn0EIJUULlrhYVkPt+OVvKdrLgBpr44/hi6+0xOvFY
        fqSSvfHHVnNlAJ8V4RIULaMqLMKf431jTu7Npdw09bPf8vNp4iw825GXxyAyNIQW
        UKqGy/9wOFBf88TkjRqKSR71EvGhc3WimjoE2Zd3o2ECytR3DuKPc7LA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnyva3q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3bbSb025980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:37 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 19:37:32 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v3 0/8] Add NSS clock controller support for Qualcomm
 IPQ5332
Date:   Mon, 11 Dec 2023 09:07:22 +0530
Message-ID: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKDdmUC/3XMOw7CMBBF0a1EU2PkD7YEFftAKaxhQqbASTzBA
 kXeOyY95X3SOxsIZSaBS7dBpsLCU2rhDh3gGNODFN9bg9XWGe204nnxzlmVRBBVpIhnMt7pk4f
 2mTMN/N69W996ZFmn/Nn5Yn/rP6kYpVUwwUaLwQ86XpcXIyc84vSEvtb6BZFlmaSsAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702265852; l=2439;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=upKaqzFbEzN+y31BgMHs8lWTIVyBiWK2BO9X4S1Ib/k=;
 b=PDC6disO4cR2ZUaL3Gr0QHV6bZTB8dd4XZ3tV7knt50w6UoD7f0dHdnXwdd4J0XIA1uiJhpr8
 Z2tscxI8PsqBuqHw6fV+l9qcRnhUDFx1F73ZGUd9wGVFUZv6fhkiOpH
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0yBZLv1tvIeg5cZV2N1RQuzUMm8M81P
X-Proofpoint-ORIG-GUID: Q0yBZLv1tvIeg5cZV2N1RQuzUMm8M81P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
https://lore.kernel.org/linux-arm-msm/20231124151847.1915-1-ansuelsmth@gmail.com/

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v3:
- Collected the tags
- Dropped the dt-binding patch 3/9
- Cleaned up the header file inclusion and updated the module
  description in the driver
- Used the decimal number instead of hex in the NSSCC node
- Link to v2: https://lore.kernel.org/r/20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com

Changes in v2:
- Change logs are in respective patches
- Link to v1: https://lore.kernel.org/r/20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com

---
Kathiravan Thirumoorthy (8):
      clk: qcom: ipq5332: add const qualifier to the clk_init_data structure
      clk: qcom: ipq5332: enable few nssnoc clocks in driver probe
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
 drivers/clk/qcom/nsscc-ipq5332.c                   | 1031 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h       |    1 +
 include/dt-bindings/clock/qcom,ipq5332-nsscc.h     |   86 ++
 9 files changed, 1260 insertions(+), 77 deletions(-)
---
base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
change-id: 20231030-ipq5332-nsscc-aeac9e153045

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

