Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5144B7DCC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjJaMEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjJaMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:03:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761F5584;
        Tue, 31 Oct 2023 05:03:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VA9RQ1028243;
        Tue, 31 Oct 2023 12:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=qtUqTgzQz/X6OXajNpTGiJjqSqC/Bp2kFW5ZPsnmIdI=;
 b=U+0xTrYb4INDqcogLq0XdzDTFVVJVXNCRmTVFzjimW26Oe1DB+8b4zcvUO9Db6vTpit/
 6nEZHk7sogaJ2bCHztPKHx4qKKzlC/Yr212BBFzCJ1bB8FthhORl6lgV3UQYrGIv9f19
 vKZrNN5RXYCXL9no/bu5phETw1zhvJ94Pc42ElUw0ChGFPL4u+ZmY2ABwqWn84mAA41N
 ej67webd1SqT+6BXWhGBZVj/dUYeGJe2cKQ0hhIUBsyKjfXu1yRXeuiYsWHrK8ya6VRb
 iXeEHC9sWBnVNL4w0LawrcLhRxoooTpe2/Dptsfj0MVp7xrv5miNFCTuTp/AkkkzK9In nQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcyhp8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:16 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VC3D92005310;
        Tue, 31 Oct 2023 12:03:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3u0uckvvpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VC3AjH005252;
        Tue, 31 Oct 2023 12:03:13 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 39VC3Dp3005300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:13 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id 3F0E94162D; Tue, 31 Oct 2023 17:33:12 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, quic_srichara@quicinc.com,
        qpic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [RFC PATCH 5/5] arm64: dts: qcom: ipq9574: Add support for SPI nand
Date:   Tue, 31 Oct 2023 17:33:07 +0530
Message-Id: <20231031120307.1600689-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PQfZ8XCUGpMR_GKZ7TRZR8wmCWmWjqrc
X-Proofpoint-ORIG-GUID: PQfZ8XCUGpMR_GKZ7TRZR8wmCWmWjqrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=888 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for QPIC SPI NAND for IPQ9574

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 56 ++++++++++-----------
 arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 30 ++++++++++-
 2 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1bb8d96c9a82..5e4200edb873 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -15,48 +15,48 @@ / {
 	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
 };
 
-&sdhc_1 {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	max-frequency = <384000000>;
-	bus-width = <8>;
-	status = "okay";
-};
-
 &tlmm {
-	sdc_default_state: sdc-default-state {
-		clk-pins {
+	qspi_nand_pins: qspi_nand_pins {
+		spi_clock {
 			pins = "gpio5";
-			function = "sdc_clk";
+			function = "qspi_clk";
 			drive-strength = <8>;
 			bias-disable;
 		};
 
-		cmd-pins {
+		qspi_cs {
 			pins = "gpio4";
-			function = "sdc_cmd";
+			function = "qspi_cs";
 			drive-strength = <8>;
 			bias-pull-up;
 		};
 
-		data-pins {
-			pins = "gpio0", "gpio1", "gpio2",
-			       "gpio3", "gpio6", "gpio7",
-			       "gpio8", "gpio9";
-			function = "sdc_data";
+		qspi_data {
+			pins = "gpio0", "gpio1", "gpio2";
+			function = "qspi_data";
 			drive-strength = <8>;
 			bias-pull-up;
 		};
 
-		rclk-pins {
-			pins = "gpio10";
-			function = "sdc_rclk";
-			drive-strength = <8>;
-			bias-pull-down;
-		};
+	};
+};
+
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	status = "okay";
+	pinctrl-0 = <&qspi_nand_pins>;
+	pinctrl-names = "default";
+	spi_nand: spi_nand@0 {
+		compatible = "spi-nand";
+		nand-ecc-engine = <&qpic_nand>;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		spi-max-frequency = <8000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index b44acb1fac74..f9c21373f5e6 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -336,10 +336,38 @@ sdhc_1: mmc@7804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7984000 0x1c000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq9574-nand";
+			reg = <0x79b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+			<&gcc GCC_QPIC_AHB_CLK>,
+			<&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core", "aon", "io_macro";
+			dmas = <&qpic_bam 0>,
+				<&qpic_bam 1>,
+				<&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			nand-ecc-engine = <&bch>;
+			status = "disabled";
+		};
+
 		bch: qpic_ecc {
 			compatible = "qcom,ipq9574-ecc";
 			status = "ok";
-		}
+		};
 
 		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
-- 
2.34.1

