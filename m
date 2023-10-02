Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D97B58FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbjJBROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbjJBROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:14:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A5FAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:14:12 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4542d7e9bcfso11776137.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696266851; x=1696871651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mtj4NCPRxZ6VOa3hAfKfXCzeZnGQjZkkPegFeXl3ak=;
        b=dcBt5dq4PmXpgwCWCtvzziGiKdoAEkVeOXd9VspMbpP8IkbsSSzzu2iHhiTEnrrdVv
         +pEJ5lZG0BbWwwAqA/8hjVy3mgvLUVvuTQyxlC1KM6ha8mUVopN9WHev8H1s6JGORj8V
         gstip1+CgTy6eIxNp9cQ7gTpzxzFa81RHyfMaC4GM7mThKJGFztUhG7RH6JO8xrAAhxN
         /TP1eSfxO9WXkJND5KtHW4VZLv9CZ8Ovnj9ga35Svm6DX5FBIONpJdd/8VMviasTGqIi
         Qz7VoQjn3El8RTPnyOHtIU4hVS73cCislSYskBuCLPBtexiG1wUNrcEmnIgCWeUAH3a/
         yuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266851; x=1696871651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Mtj4NCPRxZ6VOa3hAfKfXCzeZnGQjZkkPegFeXl3ak=;
        b=YMGskO30q9cm1fDkz51tYfrIw97blpJ4TBxLl7kscGNKBXmS4QIN44e2rVdDfI/WOv
         SPK47HrQ5qkcXLutXGINzskKbh6/TM+RB4q+UpJZPtvoFJHfqvIspJS61b3P/fkrVt42
         eOMdcGJKRBB8+NQpPSQmYumRa0TRJYrXzq9sVk4eUEfiDnv5DkafPvN7nTf6SiYr9/qd
         dEKISiMxH4iy1KKzo7iGRfjSgkOjW7FGBUBLgfi4QJDfYtGb/YwyI0E0ghZdjQ3TVhGn
         AajmqlOhJExmoXoOWcHzCbN2a4ez5AfOe1IdZ65TNmdIHR5aoQgylI3Y3cOvIHbq82r9
         faQg==
X-Gm-Message-State: AOJu0YySKKCQ64rO9OrdxVdD6fwmiOfo8uKEngQtTxsISf4/0EVB50Jy
        VlWlHeHGsUCMcx4X5I2rL07f4A==
X-Google-Smtp-Source: AGHT+IH3XNpYfmGvb7OL9Qkhu2zYZC2IvCPU6H6n+N4txNDekG4/DSCJW9S/TxcZ4yyvcTicsIFB7Q==
X-Received: by 2002:a67:e8d0:0:b0:452:8717:1fa3 with SMTP id y16-20020a67e8d0000000b0045287171fa3mr10481368vsn.3.1696266850932;
        Mon, 02 Oct 2023 10:14:10 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dy52-20020a05620a60f400b007678973eaa1sm9132660qkb.127.2023.10.02.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:14:10 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add stm32f7 SDIO sleep pins
Date:   Mon,  2 Oct 2023 13:13:38 -0400
Message-ID: <20231002171339.1594470-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002171339.1594470-1-ben.wolsieffer@hefring.com>
References: <20231002171339.1594470-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDIO sleep pin definitions that place the pins in analog mode to
save power.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
index 9f65403295ca..26f91ca0d458 100644
--- a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
@@ -253,6 +253,17 @@ pins2 {
 				};
 			};
 
+			sdio_pins_sleep_a: sdio-pins-sleep-a-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1 D0 */
+						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1 D1 */
+						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1 D2 */
+						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1 D3 */
+						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1 CLK */
+						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1 CMD */
+				};
+			};
+
 			sdio_pins_b: sdio-pins-b-0 {
 				pins {
 					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
@@ -284,6 +295,17 @@ pins2 {
 				};
 			};
 
+			sdio_pins_sleep_b: sdio-pins-sleep-b-0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 9, ANALOG)>, /* SDMMC2 D0 */
+						 <STM32_PINMUX('G', 10, ANALOG)>, /* SDMMC2 D1 */
+						 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2 D2 */
+						 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2 D3 */
+						 <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC2 CLK */
+						 <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC2 CMD */
+				};
+			};
+
 			can1_pins_a: can1-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
-- 
2.42.0

