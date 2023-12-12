Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860EF80F353
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjLLQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjLLQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:41:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20EBA8;
        Tue, 12 Dec 2023 08:41:08 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCG5abA019281;
        Tue, 12 Dec 2023 16:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yjHegSqVjDhjWcSVzeGzclFYK8dS8i3S70eTx7VZKmE=;
 b=LjfjorD21sE/z9r68fWnWpo2JQTuQuVJKaBWpLYb50h9IXGQBcMMH+NoB1Chbu6Z8ZW2
 3ZBhyuSRJSVwiTRTvYKK87vnP+X/I85UU+v5rmo84uGJ2ldGfTnnZ50/CdIwEHal5cuf
 agkVZl8/nCU4CY2eqBn87h2ayyNlovZ1pNDxPlEs49PhTYa3tw3c04AwwSy2f6i3At8g
 se5WdsrbN2wTzxMMuqsprrd6ap29azUYwujfbSUCpohxlVR3+YYu7akDRq2dKzwXbE9k
 adqx7PmpGThDbV7SLVgTT1eHcDrLKczCD1kTnw/F1YJfMhKIVzb4DVjUYqEvbN/eEc3I lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCEHGAQ005341;
        Tue, 12 Dec 2023 16:40:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFUoJk004139;
        Tue, 12 Dec 2023 16:40:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4ska191-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCGePef46203274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 16:40:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E90958043;
        Tue, 12 Dec 2023 16:40:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 614A358053;
        Tue, 12 Dec 2023 16:40:23 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 16:40:23 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        ninad@linux.ibm.com, johannes.holland@infineon.com,
        linux@roeck-us.net, broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: [PATCH v1 6/8] ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
Date:   Tue, 12 Dec 2023 10:40:02 -0600
Message-Id: <20231212164004.1683589-7-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fE0s86fgFO-fH0_99PYVIC7m8yfHpD5l
X-Proofpoint-ORIG-GUID: 72-GEgrk1dBbT-mYkPZBhFuCSgLQMUzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=877 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds following devices to the device tree.
- GPIO pin assignements, GPIO expansion devices
- LED brinker devices
- Fan controllers

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 547 +++++++++++++++++-
 1 file changed, 542 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index b8e7e52d4600..75562aa63701 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -114,6 +114,99 @@ vga_memory: region@bf000000 {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		bmc-ready {
+			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		bmc-hb {
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
+		};
+
+		rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		fan0-fault-led {
+			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
+		};
+
+		fan1-fault-led {
+			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
+		};
+
+		fan2-fault-led {
+			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
+		};
+
+		fan3-fault-led {
+			gpios = <&pca3 8 GPIO_ACTIVE_LOW>;
+		};
+
+		fan4-fault-led {
+			gpios = <&pca3 9 GPIO_ACTIVE_LOW>;
+		};
+
+		fan5-fault-led {
+			gpios = <&pca3 10 GPIO_ACTIVE_LOW>;
+		};
+
+		fan6-fault-led {
+			gpios = <&pca3 11 GPIO_ACTIVE_LOW>;
+		};
+
+		nvmed0-fault-led {
+			gpios = <&pca4 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		nvmed1-fault-led {
+			gpios = <&pca4 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		nvmed2-fault-led {
+			gpios = <&pca4 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		nvmed3-fault-led {
+			gpios = <&pca4 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <1000>;
+
+		event-nvme0-presence {
+			label = "nvme0-presence";
+			gpios = <&pca4 0 GPIO_ACTIVE_LOW>;
+			linux,code = <0>;
+		};
+
+		event-nvme1-presence {
+			label = "nvme1-presence";
+			gpios = <&pca4 1 GPIO_ACTIVE_LOW>;
+			linux,code = <1>;
+		};
+
+		event-nvme2-presence {
+			label = "nvme2-presence";
+			gpios = <&pca4 2 GPIO_ACTIVE_LOW>;
+			linux,code = <2>;
+		};
+
+		event-nvme3-presence {
+			label = "nvme3-presence";
+			gpios = <&pca4 3 GPIO_ACTIVE_LOW>;
+			linux,code = <3>;
+		};
+	};
+
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
@@ -259,7 +352,7 @@ &uhci {
 &gpio0 {
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
-	/*B0-B7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",
 	/*C0-C7*/	"","","","","","","","",
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
@@ -269,17 +362,17 @@ &gpio0 {
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","bmc-ready",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","","","","","",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","bmc-hb",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
-	/*S0-S7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","","","power-chassis-control","","","","",
+	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","power-chassis-good","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
@@ -393,6 +486,171 @@ regulator@42 {
 		compatible = "infineon,ir38263";
 		reg = <0x42>;
 	};
+
+	led-controller@60 {
+		compatible = "nxp,pca9552";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			label = "nic1-perst";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			label = "bmc-perst";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@2 {
+			label = "reset-M2-SSD1-2-perst";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			label = "pcie-perst1";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@4 {
+			label = "pcie-perst2";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@5 {
+			label = "pcie-perst3";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@6 {
+			label = "pcie-perst4";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@7 {
+			label = "pcie-perst5";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@8 {
+			label = "pcie-perst6";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@9 {
+			label = "pcie-perst7";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@10 {
+			label = "pcie-perst8";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@11 {
+			label = "PV-cp0-sw1stk4-perst";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@12 {
+			label = "PV-cp0-sw1stk5-perst";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@13 {
+			label = "pe-cp-drv0-perst";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@14 {
+			label = "pe-cp-drv1-perst";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@15 {
+			label = "lom-perst";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pca0: pca9539@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PLUG_DETECT_PCIE_J101_N",
+			"PLUG_DETECT_PCIE_J102_N",
+			"PLUG_DETECT_PCIE_J103_N",
+			"PLUG_DETECT_PCIE_J104_N",
+			"PLUG_DETECT_PCIE_J105_N",
+			"PLUG_DETECT_PCIE_J106_N",
+			"PLUG_DETECT_PCIE_J107_N",
+			"PLUG_DETECT_PCIE_J108_N",
+			"PLUG_DETECT_M2_SSD1_N",
+			"PLUG_DETECT_NIC1_N",
+			"SEL_SMB_DIMM_CPU0",
+			"presence-ps2",
+			"presence-ps3",
+			"", "",
+			"PWRBRD_PLUG_DETECT2_N";
+	};
 };
 
 &i2c2 {
@@ -486,6 +744,20 @@ regulator@43 {
 &i2c6 {
 	status = "okay";
 
+	fan-controller@52 {
+		compatible = "maxim,max31785a";
+		reg = <0x52>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	fan-controller@54 {
+		compatible = "maxim,max31785a";
+		reg = <0x54>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	i2c-mux@70 {
 		compatible = "nxp,pca9548";
 		reg = <0x70>;
@@ -522,6 +794,48 @@ i2c6mux0chn4: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
+
+			led-controller@60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led@0 {
+					label = "enclosure-id-led";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@1 {
+					label = "attention-led";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@2 {
+					label = "enclosure-fault-rollup-led";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@3 {
+					label = "power-on-led";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 
 		i2c6mux0chn5: i2c@5 {
@@ -542,6 +856,44 @@ i2c6mux0chn7: i2c@7 {
 			reg = <7>;
 		};
 	};
+
+	pca3: pca9539@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca4: pca9539@77 {
+		compatible = "nxp,pca9539";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PE_NVMED0_EXP_PRSNT_N",
+			"PE_NVMED1_EXP_PRSNT_N",
+			"PE_NVMED2_EXP_PRSNT_N",
+			"PE_NVMED3_EXP_PRSNT_N",
+			"LED_FAULT_NVMED0",
+			"LED_FAULT_NVMED1",
+			"LED_FAULT_NVMED2",
+			"LED_FAULT_NVMED3",
+			"FAN0_PRESENCE_R_N",
+			"FAN1_PRESENCE_R_N",
+			"FAN2_PRESENCE_R_N",
+			"FAN3_PRESENCE_R_N",
+			"FAN4_PRESENCE_R_N",
+			"FAN5_PRESENCE_N",
+			"FAN6_PRESENCE_N",
+			"";
+	};
 };
 
 &i2c7 {
@@ -809,6 +1161,191 @@ regulator@41 {
 		compatible = "infineon,ir38263";
 		reg = <0x41>;
 	};
+
+	led-controller@61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			label = "efuse-12v-slots";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			label = "efuse-3p3v-slot";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			label = "nic2-pert";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@4 {
+			label = "pcie-perst9";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@5 {
+			label = "pcie-perst10";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@6 {
+			label = "pcie-perst11";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@7 {
+			label = "pcie-perst12";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@8 {
+			label = "pcie-perst13";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@9 {
+			label = "pcie-perst14";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@10 {
+			label = "pcie-perst15";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@11 {
+			label = "pcie-perst16";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@12 {
+			label = "PV-cp1-sw1stk4-perst";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@13 {
+			label = "PV-cp1-sw1stk5-perst";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@14 {
+			label = "pe-cp-drv2-perst";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@15 {
+			label = "pe-cp-drv3-perst";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pca1: pca9539@75 {
+		compatible = "nxp,pca9539";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PLUG_DETECT_PCIE_J109_N",
+			"PLUG_DETECT_PCIE_J110_N",
+			"PLUG_DETECT_PCIE_J111_N",
+			"PLUG_DETECT_PCIE_J112_N",
+			"PLUG_DETECT_PCIE_J113_N",
+			"PLUG_DETECT_PCIE_J114_N",
+			"PLUG_DETECT_PCIE_J115_N",
+			"PLUG_DETECT_PCIE_J116_N",
+			"PLUG_DETECT_M2_SSD2_N",
+			"PLUG_DETECT_NIC2_N",
+			"SEL_SMB_DIMM_CPU1",
+			"presence-ps0",
+			"presence-ps1",
+			"", "",
+			"PWRBRD_PLUG_DETECT1_N";
+	};
+
+	pca2: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SW1_BOOTRCVRYB1_N",
+			"SW1_BOOTRCVRYB0_N",
+			"SW2_BOOTRCVRYB1_N",
+			"SW2_BOOTRCVRYB0_N",
+			"SW3_4_BOOTRCVRYB1_N",
+			"SW3_4_BOOTRCVRYB0_N",
+			"SW5_BOOTRCVRYB1_N",
+			"SW5_BOOTRCVRYB0_N",
+			"SW6_BOOTRCVRYB1_N",
+			"SW6_BOOTRCVRYB0_N",
+			"SW1_RESET_N",
+			"SW3_RESET_N",
+			"SW4_RESET_N",
+			"SW2_RESET_N",
+			"SW5_RESET_N",
+			"SW6_RESET_N";
+	};
 };
 
 &i2c14 {
-- 
2.39.2

