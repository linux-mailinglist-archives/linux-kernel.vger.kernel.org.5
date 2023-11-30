Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6E7FE8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbjK3FcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Fb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:31:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA65BC;
        Wed, 29 Nov 2023 21:32:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf856663a4so5364695ad.3;
        Wed, 29 Nov 2023 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701322322; x=1701927122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t8tXe6ccmmDxngyTtST79lozTn11v8rTEVF91HUREg=;
        b=DaB09raa5YWV1R7zcFo7u/Bp7SZZdLJCUpxTBhy0r1d3BS/ipmNQhNV8elL3XetzLm
         nUxN+iKlmkr9RuxqhRuOYtULvWAXbZmdJGpaAjXQ4b8OUwmFx6i4DbEKuWEKda5ClTsu
         zebGKPnW1pGsTaOTSenQCT67VhTGq9bB+zUd/1MU21Hh2t3tbCKHhRCKCKL4LQBKL5cF
         JUiCJrBP0Z+moFawVzuvfy5rWbATxbgd4J7FLyDsVe8V3mGsnheyOcRU0bA+hNCK88yU
         Zs2g46fxYCPkYH19CY/U+2LI4TJWm86xr5/cqqbH/PM7skBrrW+6cNMfAsg2DT789jTM
         4XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701322322; x=1701927122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t8tXe6ccmmDxngyTtST79lozTn11v8rTEVF91HUREg=;
        b=lgbq2Xrya69d/du7wvfMTW4uTNO9ABdL2Z14w2l+3Uddko8aQp2hu8kEAjjlzs1q0u
         riQKE1yqBWcBVWOcC/t9hhY32jwR3ov/GJLZ+oxQaRBTbiR2rY7Z3TbdZLRuA41AfQlk
         C5g6HzzN8uXwUUV3XGgLh+aLyxa7jAeSU84L6FjrqdaAJqMwcG704pfSSpDN0FwTI4yC
         lecBL8UVnVdybpOMUHtk9eLW6R87aNU/hgM4CRhlEvSok7PZveUoSVtecHZ8uTTPXrSi
         n+W/nFqL0FPaa+7mLT1zM64qaMYXmL7YB5gs85JRE+TpG98IKQckpHHoSpbSaMPXCiaA
         LFpw==
X-Gm-Message-State: AOJu0YxOov7+2vMUUDp60xwIZueGEyvNpIlFMyx6QJC13snWEo7GEbHn
        2Zc35CaiLC36NXTbCLJ79A4=
X-Google-Smtp-Source: AGHT+IFkSs+BFMZkK/X6EAkUmwIyMPu/FcBsDElxRS2kmwraWkSpbAYx6zSlpvdYGXyQFuL5buv7Pw==
X-Received: by 2002:a17:902:6b41:b0:1cc:32df:40e7 with SMTP id g1-20020a1709026b4100b001cc32df40e7mr20277808plt.66.1701322322550;
        Wed, 29 Nov 2023 21:32:02 -0800 (PST)
Received: from localhost.localdomain ([49.205.245.83])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001cfad1a60cesm336330plq.137.2023.11.29.21.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 21:32:01 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Thu, 30 Nov 2023 11:01:27 +0530
Message-ID: <20231130053130.21966-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130053130.21966-1-linux.amoon@gmail.com>
References: <20231130053130.21966-1-linux.amoon@gmail.com>
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

