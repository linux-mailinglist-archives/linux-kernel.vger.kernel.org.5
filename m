Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110CE808464
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjLGJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLGJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:07:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED9137
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:07:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-333630e9e43so688203f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701940031; x=1702544831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fczg9wafsPen1iAORs4/lUjis9zp/tI+lvQFW8HLlHc=;
        b=fewSFTIygTDkm9p9Gevi+c7FXgo9qFF2ciiP+gX6GCEtS/R5RQhhanrPnIFCOLBZWi
         uVagOBVyPJx5ZNCB9is7FXOKC+YGPc8XPq/rU3ocpf+MbIR9mw3GcE+/tbxDUTSYTM14
         VL6LtOACmCGg3i0yo67D0ZSMlEomVxTtfT1X0vsbmysxJCjdri/UAJuW+eJyIG9qV2vx
         RRe2viljFy/mTxu42IywB+9vsNbz4E3Mx1WfKU2l6FvpGQaiYwY6l6KQqE8L7AmKk7Sk
         og1s+sacGZOAfhUvGGpwTGAercvGoYfnbMojxQz2aTBIcp5fgDMS1to6Wv7YDdtYTju9
         0YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940031; x=1702544831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fczg9wafsPen1iAORs4/lUjis9zp/tI+lvQFW8HLlHc=;
        b=ZV5PNKRWEw808SWwrXw5KRIVm92NnT+mb/Xi0B1gWKqZd9CxbrqcFyiL8DoBkUh/45
         M4m5uK5isSpEoxJAsKIiEvD+KLvlxzN/dwMu3mA3SIePEcrw8BiddxW+7LURJRknroDq
         b847VObc0DHYCHBj6pHJ+jpgKC2HNq/wDIxiOJ/ca9KFLDeNBFQczh/770lgk4mEKmPZ
         hngmi6NR6GMgHKVRYZkvQKgBrZgqWcVhWMg8rLvvd/qk01Syj5e11/CgpM3Y5OVEQwNQ
         dJiZ69u3/X8YCwxgN2nUECbE4sw9FhHmVwnGu3NA9UutSYp15+3FRoLfY4tn6inNnE8E
         MTnw==
X-Gm-Message-State: AOJu0YxPssheIdvH7/8c//f5WLKgZiBFG8Q1912tMlWowMnQyotMD8rU
        8dOVqqYMdnGdlQysypKgR9shxQ==
X-Google-Smtp-Source: AGHT+IEB1kvVa/ehNh5w94LzI6k+F8Di8MwhhGmEgFQOIc3rrUmUd3Jw6yhiiSxgJjW8hRCSEWSfHg==
X-Received: by 2002:adf:e70d:0:b0:333:3ae4:616f with SMTP id c13-20020adfe70d000000b003333ae4616fmr900525wrm.97.1701940031027;
        Thu, 07 Dec 2023 01:07:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:de32:8b0f:dc9a:4dce])
        by smtp.gmail.com with ESMTPSA id w8-20020adfcd08000000b003334675634bsm896035wrm.29.2023.12.07.01.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:07:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node
Date:   Thu,  7 Dec 2023 10:07:06 +0100
Message-Id: <20231207090706.19134-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the Bluetooth node for RB5 as well as its dependencies in the form
of the uart6 -> serial1 alias and the pin function for the Bluetooth
enable GPIO.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- squash the three device-tree patches into one
- as we're only using a single pin for the BT enable GPIOs, there's no
  need for a separate named node
- change the naming convention for regulators to follow the bindings

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index c8cd40a462a3..dfda57568dc5 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -23,6 +23,7 @@ / {
 
 	aliases {
 		serial0 = &uart12;
+		serial1 = &uart6;
 		sdhc2 = &sdhc_2;
 	};
 
@@ -1263,6 +1264,14 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	bt_en_state: bt-default-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
+
 	lt9611_irq_pin: lt9611-irq-state {
 		pins = "gpio63";
 		function = "gpio";
@@ -1296,6 +1305,26 @@ sdc2_card_det_n: sd-card-det-n-state {
 	};
 };
 
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>;
+
+		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddrfa0p9-supply = <&vreg_s2f_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p3>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+	};
+};
+
 &uart12 {
 	status = "okay";
 };
-- 
2.40.1

