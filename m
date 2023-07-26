Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8E762C94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGZHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGZHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:05:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2649D3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso4376491a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355015; x=1690959815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KDOr8lmHhSQc4kSLIBTngZ/PO46LSeqTh+hZ/Wh1rk=;
        b=PdwjHsUAYpm2rxK8shLHLhFMW/8Geg9oWWPt/GAjP2tNoQcI9/cnSNqdWjSQNbq5Pi
         Pcs8g3lPlbXgLJsjvOo/CBLMXQCU5frh+HkjVCyi++maUcMrN50i7zahD9rOt+ZSszRw
         he1tg4GHgSvm7Dd3p0KcyzlS9VIdDy53wbeExZdVi5aXMY6DXdw3pWsEyg1eD6Nm2ivB
         Z7IAln7yvRVxnrO07e9gaHHEcwSkKtKAhdrnMU2ukN8S5x8QS85bSYtaNz2KDJVX3ysf
         jXvC60uov9gJMA3axrNetLSkYL60An3qXsopMurrLI8+UdV+LDKHIMZ3ec26vYWhmoKb
         FraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355015; x=1690959815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KDOr8lmHhSQc4kSLIBTngZ/PO46LSeqTh+hZ/Wh1rk=;
        b=Gmk3br+TvGzMw/f4zlyvA1zaEVIobsSlQHf5+fhLzGhjwtfbrfXfAPqJDJDAhlzQKl
         z9EbQ1IUZN9kmgeA1X6OZ1xp6AAujZhrWoIl1taybTUAFtJHABEFoCowlo+slV825bWu
         eBZwn3CsUG4AT3QxUZ4k4+aHziG+GkTPNPK6iP5u60Zzf9Hk/e40y+YVIVyzOy2Eeqoe
         pzkXSHjkv9KGJMNtao2CgsJ1s9kR+Y0bi9HvakMRWyaQ4w7hrqGJ3z1LCKXuYSUO7kky
         whXXI9pH6qBN6kUVHIx3LuBxsz4NHV+rQTmZKnmmPf/izqQpxxmeLLCEfrwS3m2KhrjB
         QVJQ==
X-Gm-Message-State: ABy/qLY3hA+nutM6zw2ecIE79xeW8PsfDMSep6I3g3zAjub6CBiub0in
        ryRrnZUM/M7qumS3MVYx5FV8kQ==
X-Google-Smtp-Source: APBJJlFrQ7uiahYO7hvBRb11BV4XesFvHQuCYhuaQHwgQ7xYZrKDEkBE+yyKvIQcMaeYcivkC9ir7Q==
X-Received: by 2002:a05:6402:180f:b0:51d:88b2:872e with SMTP id g15-20020a056402180f00b0051d88b2872emr615987edy.42.1690355015815;
        Wed, 26 Jul 2023 00:03:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm1572003edb.60.2023.07.26.00.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/8] ARM: dts: imx23: drop incorrect reg in fixed regulators
Date:   Wed, 26 Jul 2023 09:03:19 +0200
Message-Id: <20230726070322.103871-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators are not in some bus and bindings do not allow a "reg"
property.  Move them out of "regulators" node to top-level.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts | 23 +++++++------------
 .../boot/dts/nxp/mxs/imx23-stmp378x_devb.dts  | 19 +++++----------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts b/arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts
index 0729e72f2283..229e727b222e 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dts
@@ -101,21 +101,14 @@ usb0: usb@80080000 {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb0_vbus: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb0_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			startup-delay-us = <300>; /* LAN9215 requires a POR of 200us minimum */
-			gpio = <&gpio0 17 0>;
-		};
+	reg_usb0_vbus: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		startup-delay-us = <300>; /* LAN9215 requires a POR of 200us minimum */
+		gpio = <&gpio0 17 0>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts
index da4b88f32eaa..69124ba6a666 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-stmp378x_devb.dts
@@ -59,18 +59,11 @@ duart: serial@80070000 {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_vddio_sd0: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vddio-sd0";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 29 0>;
-		};
+	reg_vddio_sd0: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 29 0>;
 	};
 };
-- 
2.34.1

