Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA177BC43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjHNPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjHNPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:00:57 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D818F;
        Mon, 14 Aug 2023 08:00:49 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7AD66160897;
        Mon, 14 Aug 2023 17:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1692025246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7C2w+0tWL4XQt5OLTpreLub8Xk8xFwshC1CAe/wfDZs=;
        b=QYklDSJFJ6+RGAkfa/CLMPH3Qn0WzV3psx6rHvu5qQD4WsobEYtEw1zpx/42SiydDHNPyD
        1KHljAAe6laKnXjutI1uTM+rp93kSn887m++ZZRfg1Zq6dUdnEKU2/hpHdLH2HlCwB2r30
        DLHKLd/WG2o9YvW7CDRGN2qbrtwABpQ=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: apq8064: add support to gsbi4 uart
Date:   Mon, 14 Aug 2023 17:00:40 +0200
Message-Id: <20230814150040.64133-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to gsbi4 uart which is used in LG Mako.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - incorporated Krzysztof hints: added -state to the node name,
   and -pins to the sub-nodes

 arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
index 1f15186dd710..3ece5260ee51 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
@@ -233,6 +233,22 @@ pinconf {
 		};
 	};
 
+	gsbi4_uart_pin_a: gsbi4-uart-pin-active-state {
+		rx-pins {
+			pins = "gpio11";
+			function = "gsbi4";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "gsbi4";
+			drive-strength = <4>;
+			bias-disable;
+		};
+	};
+
 	gsbi6_uart_2pins: gsbi6_uart_2pins {
 		mux {
 			pins = "gpio14", "gpio15";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 2ab69dd69862..870205028f5c 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -547,6 +547,18 @@ gsbi4: gsbi@16300000 {
 			#size-cells = <1>;
 			ranges;
 
+			gsbi4_serial: serial@16340000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x16340000 0x100>,
+				      <0x16300000 0x3>;
+				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&gsbi4_uart_pin_a>;
+				pinctrl-names = "default";
+				clocks = <&gcc GSBI4_UART_CLK>, <&gcc GSBI4_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
 			gsbi4_i2c: i2c@16380000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				pinctrl-0 = <&i2c4_pins>;
-- 
2.40.1

