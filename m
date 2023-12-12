Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D280E545
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbjLLHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjLLHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE3125;
        Mon, 11 Dec 2023 23:54:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28ab5adae8dso424596a91.0;
        Mon, 11 Dec 2023 23:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367669; x=1702972469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4mYkdYycHvWmTb171qbHq/sz7aJZKJF/gRqwbu8etE=;
        b=D648w1f2KYRYkou2puDk5LtcQkFbCMh44PN+EJ/FCqRx7lXYxl3adZ7cIOKZ9Tpzwa
         LGpm32OtAOZMcmL1N0XHl3H6dj8y/N1q3i4KM9btwajk7Fv7gYWdxXv0o/glLLw19AAW
         6/e4STAIzaVgAfMUFEh/Y6RmsfY8QaMe9tNAODZiM6neIkdxkvuHWUOLddjYo75Vx1qh
         Msoq28/rBDFWDC5gQtm5U6ucxQ/tqvYIM8hONy3/qqrblim8GesyWTvvFWLouX+cb8aB
         Xrh6qMiBXDfFj+Ot3wIgNA2723rZ+LqkeaIzSszUsPhvvJEScHPPclQHF9iPMfMipvwm
         vIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367669; x=1702972469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4mYkdYycHvWmTb171qbHq/sz7aJZKJF/gRqwbu8etE=;
        b=sQZe2k+9byHez7js1RfMriJ4OVGSY4l3oZyWIEO/naj7lvJKA9EE/aCyw354saewYq
         qv4G7+640rgE4oV4mnQpQmzkeotepz7qzLWJORVtYjJOgnt/sBiWcekA6rQ/Wl5k80+X
         8AK1xonIWQdIq7DPXJv/tRrTKnDCgmUMIOvs0Jdlf6E2FRKdjhbMV5kuuLMDPaiq7fRQ
         Y2K39lLm83+QPpE6+8q4AW92WcmTDSiDa6QMpwtaRPxcpQQgeOVoyJU9FkS9e+pyCzw2
         bfv+80MKWJUsTxjWaDVUVYPbDRgz4xN+xYjFPrmuSTaVvoqcjcPqFLAEtHyEuGiqqkao
         VPFA==
X-Gm-Message-State: AOJu0Yx69xgvMoLf334USTbOESgzbOVRnDN5CDZBDz+Y+Oa2l4pEam0/
        SqlqPkWROpa8GbteQTLLlXc=
X-Google-Smtp-Source: AGHT+IFhcUk3+zn1WOPec1hfNcGWO7RYN20xNkP0qg6H1/aL9nQaFz6qfkOIai5Ug1sjkeV10C5dHg==
X-Received: by 2002:a17:90a:cb94:b0:286:9cdc:c2e1 with SMTP id a20-20020a17090acb9400b002869cdcc2e1mr2369677pju.13.1702367669434;
        Mon, 11 Dec 2023 23:54:29 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:29 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 09/11] ARM: dts: aspeed: minerva: Add led-fan-fault gpio
Date:   Tue, 12 Dec 2023 15:51:58 +0800
Message-Id: <20231212075200.983536-10-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
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

Add led-fan-fault gpio pin on the PCA9555 on the i2c bus 0.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index c7445c819baf..090fe2f6b1d8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -39,6 +39,16 @@ iio-hwmon {
 			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 			<&adc1 2>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan-fault {
+			label = "led-fan-fault";
+			gpios = <&leds_gpio 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &uart6 {
@@ -118,6 +128,13 @@ power-monitor@68 {
 		compatible = "adi,ltc2945";
 		reg = <0x68>;
 	};
+
+	leds_gpio: gpio@19 {
+		compatible = "nxp,pca9555";
+		reg = <0x19>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c1 {
-- 
2.34.1

