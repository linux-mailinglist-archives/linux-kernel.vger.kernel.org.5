Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18657580AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGRPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGRPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:20:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A31C0;
        Tue, 18 Jul 2023 08:20:56 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IEwMV5012825;
        Tue, 18 Jul 2023 15:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=zBxMLxrshoA515GzC/92CK8Ep8DAbPsE2YSnOq/7Vn0=;
 b=gijkUF0te+mIn43KUZnCUFAYD/lgI/yd0VSwoA+BNrowAt8aIYd20M4lGfJ2NH+WafOJ
 ZirRmhgBpu5YcAEiQLm8FJkbQBRKeYnfYzqZpPlf6D/5Vf0UT9nX/vMV4gMhIMmWtV5n
 1P/rPqPLkLzferyMsEbZoyZneOu7/lZZ+tnsbCO7V83AoUfIxZB9iNrSmyMy2YXD4pnn
 9l8PXaePqQUPRTfiXHnUb9XOcZq9jXd9FLXqVDJY349kDWtpZ108dulg47Xaq7Egy7e8
 pXgEUav3yhWTf8oJIZ7/sLB3qILFEoOcqL1PFvYbioeQ24wLKq63d7Rd0X98BKrropEA Tw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwqqg8xf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 15:20:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36IFKoH8026369;
        Tue, 18 Jul 2023 15:20:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rumhkb0gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Jul 2023 15:20:50 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IFKnof026206;
        Tue, 18 Jul 2023 15:20:49 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36IFKnJd026054;
        Tue, 18 Jul 2023 15:20:49 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id F1E674B0A; Tue, 18 Jul 2023 20:50:48 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v9 3/4] arm: dts: qcom: sdx55: Add CPU PCIe interconnect path
Date:   Tue, 18 Jul 2023 20:50:44 +0530
Message-Id: <1689693645-28254-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
References: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aFTrNRazKpJM_xwmjNb_czRy-DjdqFe_
X-Proofpoint-ORIG-GUID: aFTrNRazKpJM_xwmjNb_czRy-DjdqFe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=815 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180141
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu-pcie interconnect path to sdx65 platform.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index df3cd9c..a7c0c26 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -422,8 +422,9 @@
 			interrupt-names = "global",
 					  "doorbell";
 
-			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
-			interconnect-names = "pcie-mem";
+			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
+					<&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
-- 
2.7.4

