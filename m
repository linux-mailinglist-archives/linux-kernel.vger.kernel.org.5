Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9F784442
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjHVObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjHVObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:31:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2AFB;
        Tue, 22 Aug 2023 07:31:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4103aa6229cso24522861cf.2;
        Tue, 22 Aug 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714665; x=1693319465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij4iII3kET4AquK7NA+5uE9piCz+Tm+vsG2ScePYKZA=;
        b=ndo9Uyr5d3TqW/Ju7EDXM5ytELrSZEUmUZAgLB0XMolZ4fexP5oTWUgHy8hrgtWcfE
         88o+gLrDy4XEBCsNyaZ69jKPR3HW6rJyc9OsnPn7JTxTqb9noLfy8ROX1nUsRqpXp76f
         7NPHM6T0ArVAJzW9FfXWEWmkjHwaIF1T/ifmonJdEAvamgZe7UGizq+EE76lzgb640mR
         6J24nHAhY55j85N9g7OKuOCqoUn4DhNoTBUc11tAvJ4F5/6asWuoUt82u5x7Fvwn/YsI
         WoQW+5jXW2uIsnDH7znkl9+kGGy0zp6a9wo6o/oTR1EA44p5IsCj2FGBmeKRs06UjJ+j
         EFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714665; x=1693319465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij4iII3kET4AquK7NA+5uE9piCz+Tm+vsG2ScePYKZA=;
        b=H2XlByEtddTHGGVlQRO/7X7zxA+mZVZLKUFlnZSp+9SoU0+2fKDkC7eCxVW/QspjH2
         XSJcrCvFsC7GM7oVkM8ixBpme/41BnmuZJPMOBGE3donzJ3U/tCFyYRXxE9bPnuZPMRi
         EyCBp9zWHUxlVsh6Vw3ingoyYIHtyn75uSlEh1WeSAgz4AvPx2yGcv36AIWrMrZmOkQo
         NlnkyA29Fg0J1VJW8Pm/xMt6hxjcvjpZ6l8XnPP/uRdsz1H3YBEhobgwejaDNu9fS6Db
         hqpvA5lwHgz0gy8UckPSurpOCxLH3+n/bFtKYL25QsQ2egrqZO+Xpa4uuKIB5U7YQklT
         SNSg==
X-Gm-Message-State: AOJu0Yzt0IovdbL32bMleLGBioVJjJ4F6ksHTShxDUPg7Lc1KIywAE/P
        3BFqZLzot6YwYOKwlAC0se8=
X-Google-Smtp-Source: AGHT+IF1Je84nJKuJClnYcJ9eAiQjLLg+oLwcKU4O6UcUV8ucxBFV6300FTQzqTnctRAHEEqEr6YgA==
X-Received: by 2002:ac8:5a55:0:b0:40f:df11:8bef with SMTP id o21-20020ac85a55000000b0040fdf118befmr11766976qta.52.1692714665214;
        Tue, 22 Aug 2023 07:31:05 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3055750qtp.63.2023.08.22.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:04 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     robertcnelson@gmail.com, drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v3 1/4] ARM: dts: am335x-pocketbeagle: update LED information
Date:   Tue, 22 Aug 2023 10:30:47 -0400
Message-ID: <20230822143051.7640-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230822143051.7640-1-twoerner@gmail.com>
References: <20230822143051.7640-1-twoerner@gmail.com>
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

Add the "color" and "description" properties.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index 5dfe4d4bab93..667dded1a167 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -8,6 +8,7 @@
 
 #include "am33xx.dtsi"
 #include "am335x-osd335x-common.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "TI AM335x PocketBeagle";
@@ -25,6 +26,8 @@ leds {
 
 		led-usr0 {
 			label = "beaglebone:green:usr0";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
@@ -32,6 +35,8 @@ led-usr0 {
 
 		led-usr1 {
 			label = "beaglebone:green:usr1";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
@@ -39,6 +44,8 @@ led-usr1 {
 
 		led-usr2 {
 			label = "beaglebone:green:usr2";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_CPU;
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
 			default-state = "off";
@@ -46,6 +53,8 @@ led-usr2 {
 
 		led-usr3 {
 			label = "beaglebone:green:usr3";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-- 
2.41.0.327.gaa9166bcc0ba

