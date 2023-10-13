Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC267C8E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjJMUwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjJMUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:52:41 -0400
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B9BE;
        Fri, 13 Oct 2023 13:52:37 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qrP9A-0002ny-05;
        Fri, 13 Oct 2023 22:52:36 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Fri, 13 Oct 2023 22:51:37 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB
 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231013-bq_leds-v1-2-cc374369fc56@apitzsch.eu>
References: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
In-Reply-To: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l9100 uses KTD2026 LED driver. Add it to the device tree.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
index 6802714fda3f..4eb33e36a8eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 
 / {
@@ -120,6 +121,46 @@ usb_id: usb-id {
 
 };
 
+&blsp_i2c2 {
+	status = "okay";
+
+	led-controller@30 {
+		compatible = "kinetic,ktd2026";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin-supply = <&pm8916_l17>;
+		vio-supply = <&pm8916_l6>;
+
+		pinctrl-0 = <&status_led_default>;
+		pinctrl-names = "default";
+
+		multi-led {
+			color = <LED_COLOR_ID_RGB>;
+			function = LED_FUNCTION_STATUS;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+	};
+};
+
 &blsp_i2c3 {
 	status = "okay";
 
@@ -184,6 +225,16 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&pm8916_gpios {
+	status_led_default: status-led-default-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <PM8916_GPIO_VPH>;
+		bias-disable;
+		output-high;
+	};
+};
+
 &pm8916_mpps {
 	pwm_out: mpp4-state {
 		pins = "mpp4";

-- 
2.42.0

