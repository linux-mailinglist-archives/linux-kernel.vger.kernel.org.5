Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6E7C4914
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjJKFMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjJKFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:12:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333E98;
        Tue, 10 Oct 2023 22:12:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9b95943beso10556755ad.1;
        Tue, 10 Oct 2023 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697001138; x=1697605938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nigg6NOWWCn0hZudaM7Yq7CsxNtYAT49L0IXth0E2/M=;
        b=RxIBs9jHb03YRtxahdfipYOZZQ/2Pt/w/zJtRFaeJabolmMv6Au5EjUHZ4ENARVGWC
         MIj2GZl2dYmDzHqwN3mcG/zKtMm5zosyu9yijM3bDRGOC7p47S+OAqbkrX0i8jdBGPvu
         X6t14d8XPKO+XG09FfPb/1fggFjwrZWXo6exX4ZB8TqC8wJkeAz1mtRSspZJOZd47not
         0qSQNg0V86PTnwFaV1uUrNvbRDzHi06q29Gs/uUHoxX+BVv4DTn2+9Y8Wepj14fPakDS
         TxWpltatZAbxZi3pBbIWgLf5TsQRNZuPqYXrUkDjXgwMSvMQfTMJDcQVlRELyWamckLU
         8pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001138; x=1697605938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nigg6NOWWCn0hZudaM7Yq7CsxNtYAT49L0IXth0E2/M=;
        b=pZ5XP7Ux4ZzdgbYRjcccgJqtvXQhs0SghknU9ZFC+TgTsRH/mByEjAlJR6Z4aQpmzs
         ZTKzYSIcz0aPeo8TMOs/M7lihfJsADUyN9VecTPKAgwYF9pi6Jupj2oB2W4kIWERoG2x
         YO1AjIx2KMBK3K9w0k4wkUhJUWLkS6k9sTYXgRlXEixiwQr27xi2aiYB//gu/cLKBD7I
         febYx7dqLxUQsQRXPC3C1viwbeJHkk/6Z2m1nVY64L8ftaLkBz889mnm6DufaYyqeyf7
         bb/IG0qZE8pcibzqsfwgHLSrZusHisJnqjVObA1zBugN9DjDH8JZPD3GW5FaSiWWt1Cl
         MIGA==
X-Gm-Message-State: AOJu0YzIqb5ASQUqcs9JwF1z+skS4KenDxEzw8IKxKH7XANO34Rli5cf
        CwrCxGbNbAWoEK0yNk5bbzI=
X-Google-Smtp-Source: AGHT+IF3hPtVKNWgsn+MppgNKK1gYtLzV1soJc7B8Z4A5P2rhn/x3scK7LQNx53no261s3rHWSCI0Q==
X-Received: by 2002:a17:902:e749:b0:1b8:76ce:9d91 with SMTP id p9-20020a170902e74900b001b876ce9d91mr26018626plf.1.1697001138105;
        Tue, 10 Oct 2023 22:12:18 -0700 (PDT)
Received: from localhost.localdomain ([49.205.243.94])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001c5dea67c26sm12777083plf.233.2023.10.10.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:12:17 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Wed, 11 Oct 2023 10:41:49 +0530
Message-ID: <20231011051152.133257-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011051152.133257-1-linux.amoon@gmail.com>
References: <20231011051152.133257-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
v2 no change.
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

