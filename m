Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769F1762C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGZHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGZHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:05:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3F49C0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so9937778e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355011; x=1690959811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkfcJ6m4rMM+iyxRVIwvcMlF3hObn2JrNhl7UUZvcR8=;
        b=ovI7chw5qWg3NSsekWG+uefx619yR7xOgr2xvKsTvSgEz0QYgfZP2WBG9cNErcf0uu
         pWRMK/btYC/u+awhud4hNRW17nfQ7zpVaPsdqfYj50K8qWElHMSxpViotFrXCdGKazKZ
         OJcyghDNf77a1xJWN8aIp+/mzOd5jGpHFmFdg2dIlD6GtMDfMgXbHokt7WsK9cJbSjVt
         KXHbhFrCCf2RGu8G7w7x24OjFjDDAU15G2k/VR/EI1dx5iJZda1FBT7D4Mba2yWVrkNM
         uoW9Mqz2pukz52dzOcY6a4Qt9+tBLjEUtNnrgKuPxqIh7RjwTx0q2Qw0UGs3gX8zwWow
         xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355011; x=1690959811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkfcJ6m4rMM+iyxRVIwvcMlF3hObn2JrNhl7UUZvcR8=;
        b=LDlu6inEI1plNiOw6OguMc/Jh6ULLC4jV7VLZqX9DttJ+M7005j6AjR6q9FPHBR7I4
         BWu64dB9UVeAdEAhQDvQsnSmSJYIb8B8KrvkncJOd9TwBIF8zTWGE1r7Sdnt+I75jKom
         Sol5/q2VPePw7t5SuG+GNVzNX+1gWNttudMLSzUo4y3gRgVpnCChjzdcQZVCtml+lpz4
         x028dN96ojfr+NYNn7Wj8X2L9uPSCdr93csfwkjv4KGWQ6BzF1jZFY5Ug6ful4KZi2mY
         ECZL25Oaof/OCPbj2lWcKcX2ruFL+E43G1QAtcFcGXzAJ8nVopHSxcxfLn8j1nW7oOZ7
         MBKA==
X-Gm-Message-State: ABy/qLYDUsdfOZOV5+6OgcbobQSP+5pKeZwLmCtkeej1y0rFQM41BKMk
        rD2CXfvgfF/eO5dVzAmVAIZuEg==
X-Google-Smtp-Source: APBJJlEufPD2DcGYOU9R7Qm5kXmjp7K+eCgVpmZDKR2Uy3XPSFXWKnNqNHFEpagOzQm0KLH1eS4vMA==
X-Received: by 2002:ac2:4564:0:b0:4fe:d0f:1f1e with SMTP id k4-20020ac24564000000b004fe0d0f1f1emr635349lfm.25.1690355011565;
        Wed, 26 Jul 2023 00:03:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm1572003edb.60.2023.07.26.00.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:31 -0700 (PDT)
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
Subject: [PATCH 3/8] AMR: dts: imx28-m28evk: populate fixed regulators
Date:   Wed, 26 Jul 2023 09:03:17 +0200
Message-Id: <20230726070322.103871-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators put under "regulators" node will not be populated,
unless simple-bus or something similar is used.  Drop the "regulators"
wrapper node to fix this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts | 45 ++++++++++------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
index e350d57a4cec..6bf26f386a5e 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
@@ -18,33 +18,28 @@ backlight {
 		default-brightness-level = <6>;
 	};
 
-	regulators {
-		reg_vddio_sd0: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vddio-sd0";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 28 0>;
-		};
+	reg_vddio_sd0: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 28 0>;
+	};
 
-		reg_usb0_vbus: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usb0_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 12 0>;
-		};
+	reg_usb0_vbus: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 12 0>;
+	};
 
-		reg_usb1_vbus: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usb1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 13 0>;
-		};
+	reg_usb1_vbus: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 13 0>;
 	};
 
 	sound {
-- 
2.34.1

