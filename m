Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACB812DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443798AbjLNKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443765AbjLNKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:53:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D9183
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c41df5577so47847125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551181; x=1703155981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n04YHHXnObXth/lRrr+Q3z77edsJBvJwDkmKe5TSvMY=;
        b=lsDi/Y2xp3PQ5DxPJ0ayoDq8cKv/wCs68rJTtac16MrfegvIKgacdCrJOcVUhUDuvb
         IJQXBVdlZ06YDaGDwOxm2VsRIGlr+m7IQExpUAss+LLnu31aUClbj0eQPxW4fI7hB5ZJ
         t7suzTq8tsbGKzX3GovPGU6+0whyCnVC/PpyJpNGGzBqMsAeAH8vxSWHkjToUj9aHGYh
         KXAIsViJd3MZxWiskp0kC54cObgN1WbK8WA7bo4oJKFEOY1XjOr2VMgzkZnZrPwUcrtr
         Il5cYeqczAltfeapc6e4pyAa977wI9NS0SqRKqNxGhtxgI5OHQd1VGcrLaOOaMIPO40k
         x2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551181; x=1703155981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n04YHHXnObXth/lRrr+Q3z77edsJBvJwDkmKe5TSvMY=;
        b=O3NkoZheXHEIpOhCILBCW7jfA2hsf5FT23Zu6uj4w714yPX4JnqeUs8zZXT+WExpGR
         9R4+5TU9VbehQZ9hnAsEeTP+Fsdxqf13ITrKE3Zr3oXOORb/H4bkOUjNXt/UB23haB1Y
         1LHG/xYrg0mWz5/Ik1fYSQwkhyVhf65fWId/IT3LhwaFjlQIdmv6PpI/uIlu9AOc3aEy
         nmWePgXFD80AL+E+lcm86+SI1VkuBQB7/zLP1AieD1g1tm2Q9rbVIXtQBJ7nAYleLDNa
         RV1PBnChosV/aXiGkdg2JWHyNOecPDPP7KKrwr4c/gCC6r6ZSDRl6Fsm80n6oyGdiy0X
         Z2XQ==
X-Gm-Message-State: AOJu0YwhR/iefvbJSyV5X2ekEjaYOND1VHMDXQ5NXh0pMyKdRNBD/uk8
        mJxYxCbfraBHZ3NhmjCYWGV/vA==
X-Google-Smtp-Source: AGHT+IFPYRnFgVJ8F0lvC2CYA+Pq15xboTIuQDttBmZqX6u/hWOKR6HBqPMGZXYdzie/T4oEpP0Nrw==
X-Received: by 2002:a05:600c:2d84:b0:40c:31f6:1dae with SMTP id i4-20020a05600c2d8400b0040c31f61daemr2299352wmg.69.1702551181240;
        Thu, 14 Dec 2023 02:53:01 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:53:00 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 11/13] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
Date:   Thu, 14 Dec 2023 10:52:41 +0000
Message-ID: <20231214105243.3707730-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the eeprom found on the battery connector.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../boot/dts/exynos/google/gs101-oriole.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 4a71f752200d..11b299d21c5d 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -63,6 +63,19 @@ &ext_200m {
 	clock-frequency = <200000000>;
 };
 
+&hsi2c_8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsi2c8_bus>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+	};
+};
+
 &pinctrl_far_alive {
 	key_voldown: key-voldown-pins {
 		samsung,pins = "gpa7-3";
@@ -99,6 +112,11 @@ &usi_uart {
 	status = "okay";
 };
 
+&usi8 {
+	samsung,mode = <USI_V2_I2C>;
+	status = "okay";
+};
+
 &watchdog_cl0 {
 	timeout-sec = <30>;
 	status = "okay";
-- 
2.43.0.472.g3155946c3a-goog

