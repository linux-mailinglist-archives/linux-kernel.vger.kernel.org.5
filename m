Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BE80818B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377929AbjLGHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377955AbjLGHIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:08:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E401703
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:08:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so806310a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701932907; x=1702537707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkghlNv0V/SuTZPxwTXU6oUm+Z1UHMMmkJLyVfH/CTs=;
        b=g/FdR8q3/4gaKLPC8MwlRS/lbel73uuZR48NvnIibK2EOkCYK2zG1KKQqgbedZ+QYg
         QZl7U+t6GYvkqgyy0UHteWcQXtZNAiYkxgKUAggwFp5R2HbUj84Js79Wk5z8NdwR9Qws
         QO1o5UuUGDa7FOyCAQ0iElD31ChRCVEMmmmR5pZ3cCPZvWmg5SkJFYEgc2MH61vOWFtg
         jj8bernaxRzi9DBWC1jmRsdflj8tBILAXKyV1BgNuubyGy0UnDCvcEyK/w4hXE8kqe+B
         vT/VoVHjbRXu88yhGKI4IvLCO4taRoPGOrhuWipA7rf6pE3qJV/o0lrhoN+D7UEYvNPv
         8Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701932907; x=1702537707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkghlNv0V/SuTZPxwTXU6oUm+Z1UHMMmkJLyVfH/CTs=;
        b=cDg1hIm6hxAOM/egngaGPvgs1TCQPzCXXeaW5cY5bHPahLMBuxlZe039SNljwv01Dr
         pPLKgg2oQBUW31Yw5l4Nc1Wd3KgCJE53lxsviJ6mgCTFgfoYCrhRoe1JtSl5nWG1yTHK
         CKCNQZpUbREOBGbH7eYGq/epfrxNJN78F+2gCgdUG+l0Mf+JLqY7XI5n7iz2/S3f/WnP
         Ag4wwAG71kVCdKfxtQ9EH2Ftr9mB+JSVXP5boRuAEZ2aCLACt+JU+wEUzjKiCbDm+mwm
         5S/T3Tr0hKEyjUmuHGYL6vhlnnuUO9iBl17t37Q+oH6/MBT6RxjmTHMn5/EXrHk0yFwJ
         B/ew==
X-Gm-Message-State: AOJu0YwGXX5Qt90c23YLGYNOT8mLCkH/gXbppG8K+OrCBSi+EGu/FeS/
        qfFZTMjV3OxMqCUD5cs0JxaaNA==
X-Google-Smtp-Source: AGHT+IF47v7X3q8qD6gB4ZCRiRsvI7r4bTbz5pfTw8z2mVo3VWRWVZ6UtqKRrNoxLAAITVBzD5hyZg==
X-Received: by 2002:a50:f692:0:b0:54c:4837:a65d with SMTP id d18-20020a50f692000000b0054c4837a65dmr1419834edn.74.1701932907528;
        Wed, 06 Dec 2023 23:08:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id b41-20020a509f2c000000b0054cb88a353dsm420818edf.14.2023.12.06.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:08:27 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 10/11] arm64: renesas: rzg3s-smarc-som: Use switches' names to select on-board functionalities
Date:   Thu,  7 Dec 2023 09:06:59 +0200
Message-Id: <20231207070700.4156557-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The intention of the SW_SD0_DEV_SEL and SW_SD2_EN macros was to reflect the
state of SW_CONFIG individual switches available on the RZ/G3S Smarc Module
and at the same time to have a descriptive name for the switch itself.
Each individual switch is associated with a signal name, which might be
active-low or not on the board. Using signal names instead of SW_CONFIG
switch names may be confusing for a user who just playes with switches to
select individual functionalities, but also for the advanced user that
looks over schematics. To avoid even further confusions, use the switches'
names here and instantitate them with an ON/OFF state. This should be
simpler, even though the name of the switch is not that intuitive. The
switch names documentation reflects the switch's purpose.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is new and aims to replace patch "arm64: renesas: rzg3s-smarc-som:
  Invert the logic of the SW_SD2_EN macro" from v1


 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 01a4a9da7afc..f59094701a4a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -9,23 +9,31 @@
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 /*
- * Signals of SW_CONFIG switches:
- * @SW_SD0_DEV_SEL:
- *	0 - SD0 is connected to eMMC
- *	1 - SD0 is connected to uSD0 card
- * @SW_SD2_EN:
- *	0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
- *	1 - SD2 is connected to SoC
+ * On-board switches' states:
+ * @SW_OFF: switch's state is OFF
+ * @SW_ON:  switch's state is ON
  */
-#define SW_SD0_DEV_SEL	1
-#define SW_SD2_EN	1
+#define SW_OFF		0
+#define SW_ON		1
+
+/*
+ * SW_CONFIG[x] switches' states:
+ * @SW_CONFIG2:
+ *	SW_OFF - SD0 is connected to eMMC
+ *	SW_ON  - SD0 is connected to uSD0 card
+ * @SW_CONFIG3:
+ *	SW_OFF - SD2 is connected to SoC
+ *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ */
+#define SW_CONFIG2	SW_ON
+#define SW_CONFIG3	SW_OFF
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
 		mmc0 = &sdhi0;
-#if SW_SD2_EN
+#if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
 #endif
 	};
@@ -50,7 +58,7 @@ vcc_sdhi0: regulator0 {
 		enable-active-high;
 	};
 
-#if SW_SD0_DEV_SEL
+#if SW_CONFIG2 == SW_ON
 	vccq_sdhi0: regulator1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI0 VccQ";
@@ -85,7 +93,7 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
-#if SW_SD0_DEV_SEL
+#if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
@@ -116,7 +124,7 @@ &sdhi0 {
 };
 #endif
 
-#if SW_SD2_EN
+#if SW_CONFIG3 == SW_OFF
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
 	pinctrl-names = "default";
-- 
2.39.2

