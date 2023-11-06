Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84ED7E1E72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjKFKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjKFKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:33:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D84D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:33:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so2768845f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699266804; x=1699871604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92KaagYK4Q6I8Q+kS3VXik470FxeSDcwqV61XGzdHMc=;
        b=zlWSZlJzYrihOzHq0xF43byD4qqSalUCPgLvb2Y7VHMEQEGT13KvquQtRjOF2Za1K3
         LKCIJo3s8Seklmn2r0OrbzU3/YPqBBkdYTIQkO43i+HV46mqO8E8uryhmRsSjP8Fqpb7
         mLWY62oKZBNMFOCe0UX1ZRXjg7mWrlN5MthE9xihO+1EuIaO9/4Vy7BFCSDvVV0mmwf8
         8FJxmcePOW/7rNc1FHFQ7bdsAnY0iBiTudccQRlM96/dlQCgkH5Rx7V78Tn6uZccyLci
         8denZ7i+uYRM4Qul5G1ClBrCO6v44YwSEBKcDfa8Hnr9TRybib2T5kRfmjNzB5i3hPBt
         zfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266804; x=1699871604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92KaagYK4Q6I8Q+kS3VXik470FxeSDcwqV61XGzdHMc=;
        b=AplI+rnYlqiql5ucbUO7nF2rwmEN9UMpGnLBnm/LR04Jn6XTHmVEc4zf4Hzpi9BMrU
         h8a8LztZ5QgvY4TMAnOxsq6vrAVT5NEkHwHx16cZsTUJsfP05Zd7treX06q9CNEXU5iB
         FzGaH0VSwxi6aHAnS0EAlJd0MLmDQTaAYEL4zvDVnlSXV6ThMKrYrrKFeUwt6DjrYTff
         IsBqppq2VfAZgRgAvAZuGG39WFKlyCldvMovdscMgysl/vkKJ32iDzWjQ0OSFqIqKV7q
         29VG1qZQMR2IAvWA3shirFkJauwkpVUE9pLGGYth0wjODXtIUhQ9qRjPfbZxAmGLhUmT
         uYyw==
X-Gm-Message-State: AOJu0YxI0gMdXvYPLOOViVXpjLE6w89W+QlwqZciwhBwvvS5L1foWcpq
        z/KBEHlC12+ytUmca0l80h3LlUTyIfxrnXVwGLQ=
X-Google-Smtp-Source: AGHT+IGpgXgs9p/haq5uFAdeKOCNvuVctlHcdsKy+IZR9rejMAGaON1iexlBhPyBttWrugvf4qR/Cg==
X-Received: by 2002:a5d:59ab:0:b0:32f:8a7f:f00f with SMTP id p11-20020a5d59ab000000b0032f8a7ff00fmr17945772wrr.60.1699266804234;
        Mon, 06 Nov 2023 02:33:24 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056000114100b0032415213a6fsm9033602wrx.87.2023.11.06.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:33:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2 binding
Date:   Mon,  6 Nov 2023 11:32:52 +0100
Message-ID: <20231106103259.703417-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106103259.703417-1-jbrunet@baylibre.com>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
 arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
 arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
index 8e3860d5d916..80cc004ad5fe 100644
--- a/arch/arm/boot/dts/amlogic/meson.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson.dtsi
@@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
 			};
 
 			pwm_ab: pwm@8550 {
-				compatible = "amlogic,meson-pwm";
+				compatible = "amlogic,meson8-pwm-v2";
 				reg = <0x8550 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
 			pwm_cd: pwm@8650 {
-				compatible = "amlogic,meson-pwm";
+				compatible = "amlogic,meson8-pwm-v2";
 				reg = <0x8650 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 59932fbfd5d5..153b8fe9c506 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -450,10 +450,14 @@ analog_top: analog-top@81a8 {
 	};
 
 	pwm_ef: pwm@86c0 {
-		compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+		compatible = "amlogic,meson8-pwm-v2";
 		reg = <0x86c0 0x10>;
 		#pwm-cells = <3>;
 		status = "disabled";
+		clocks = <&xtal>,
+			 <0>,
+			 <&clkc CLKID_FCLK_DIV4>,
+			 <&clkc CLKID_FCLK_DIV3>;
 	};
 
 	clock-measure@8758 {
@@ -702,11 +706,17 @@ timer@600 {
 };
 
 &pwm_ab {
-	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &pwm_cd {
-	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
index 3da47349eaaf..cdd7d04db256 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
@@ -441,8 +441,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
index 7adedd3258c3..68f4f70f4f03 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
@@ -162,8 +162,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &uart_AO {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
index 941682844faf..ff955b960688 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
@@ -347,8 +347,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 5198f5177c2c..6c91eda92e8b 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -404,10 +404,14 @@ analog_top: analog-top@81a8 {
 	};
 
 	pwm_ef: pwm@86c0 {
-		compatible = "amlogic,meson8b-pwm";
+		compatible = "amlogic,meson8-pwm-v2";
 		reg = <0x86c0 0x10>;
 		#pwm-cells = <3>;
 		status = "disabled";
+		clocks = <&xtal>,
+			 <0>,
+			 <&clkc CLKID_FCLK_DIV4>,
+			 <&clkc CLKID_FCLK_DIV3>;
 	};
 
 	clock-measure@8758 {
@@ -677,11 +681,17 @@ timer@600 {
 };
 
 &pwm_ab {
-	compatible = "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &pwm_cd {
-	compatible = "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &rtc {
-- 
2.42.0

