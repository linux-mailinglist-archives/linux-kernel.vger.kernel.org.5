Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBA7F0418
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjKSCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:35:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444BC93;
        Sat, 18 Nov 2023 18:35:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc921a4632so29207335ad.1;
        Sat, 18 Nov 2023 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700361318; x=1700966118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I2bEA6cqofY2I8eKS0KNcDRLfU1oI5gxtSXCZkpuPA=;
        b=darAMRyypCmCUy3BgZ09zDz78omS8B9+zznQLnHdUjZ46EPgtCFVDxhsgQopLpaM7h
         IKGShJV76JSgVW5zhk2DAeTFhiJLMX9EJ33tdCboss/JjQiTvulqWRuGfd93jwExNF7u
         uC9uIc/2TIgBWwXzevFc3Gj3WGF+OJLa28cNpi6xZV85d3v/GoNKWJZGLd1RzOHqV4RC
         5RrtIBedJNyTmIVOgmkhEqxQ5e174+/+7gyWSOCq5hlHhae/aYzteob/wfuxHgiMEaB4
         4Hfs0MF3eQlpNwVFg3ea8MAblV7Eop8h/xwXUfVXQe6RqTqGL12HPEbtPJW5aHwjfXBk
         1FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700361318; x=1700966118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I2bEA6cqofY2I8eKS0KNcDRLfU1oI5gxtSXCZkpuPA=;
        b=EN2TevnmSL+AZ/AcUG/3sUCDQy1cGLXL2X064mRzA2lmq8JE4TRqGh8SHF1vy/ag6B
         2038ksuHmTrNGdO7tfgf6gpCOx2+lHXYrkQqO798P6VRunIFU/I17UGemQIOmnSwJBr3
         BsifEZV2cPUMg2w4jDFT1YBqtP4uDfh8KuywKyhWl7TB5ORZrJZ/1XtdOc9h6QrfTkml
         28kKMDxArmLqEFoj6G/0zBdjCrUpvKvju/V/S59bWfacJPdmCQU2XWIIBrzvz3pfWZtW
         G3gUIx745XJxyRhNz7WHj7F1SQA2gC/qx1EpI9w0NHFKKL4j9UpBOeyEgDqygqCP1DLv
         fAUw==
X-Gm-Message-State: AOJu0YwD/9+Ti+e5bvzeYXSwTD3bxKHRZXFRJaob+4vI+oMnLos4bubl
        C6wENt5wVNQ28hdFXP3FQHY=
X-Google-Smtp-Source: AGHT+IGvoNLZuLcgqp0tI86VONJQTmNikMKIsL2RDRu2+46Ky5lZx1dlKINhrxjnbjUZs+SPLvMGvw==
X-Received: by 2002:a17:902:ec02:b0:1cc:4467:a563 with SMTP id l2-20020a170902ec0200b001cc4467a563mr4361440pld.3.1700361317659;
        Sat, 18 Nov 2023 18:35:17 -0800 (PST)
Received: from localhost.localdomain ([49.205.245.83])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001cf53cd1508sm1526207plx.67.2023.11.18.18.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 18:35:17 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Sun, 19 Nov 2023 08:04:51 +0530
Message-ID: <20231119023454.1591-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119023454.1591-1-linux.amoon@gmail.com>
References: <20231119023454.1591-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: none
v2: none
v1: none
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 91c9769fda20..9e671444eca6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -31,6 +31,30 @@ hub_5v: regulator-hub_5v {
 		enable-active-high;
 	};
 
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 2.0 hub on port 1 */
+		hub_2_0: hub@1 {
+			compatible = "usb5e3,610";
+			reg = <1>;
+			peer-hub = <&hub_3_0>;
+			vdd-supply = <&usb_pwr_en>;
+		};
+
+		/* 3.0 hub on port 4 */
+		hub_3_0: hub@2 {
+			compatible = "usb5e3,620";
+			reg = <2>;
+			peer-hub = <&hub_2_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+	};
+
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "ODROID-N2";
@@ -234,18 +258,6 @@ &gpio {
 		"PIN_3",  /* GPIOX_17 */
 		"PIN_5",  /* GPIOX_18 */
 		"PIN_36"; /* GPIOX_19 */
-	/*
-	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub-hog {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &i2c3 {
-- 
2.42.0

