Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5D80E543
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbjLLHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346040AbjLLHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:31 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62F11F;
        Mon, 11 Dec 2023 23:54:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c21e185df5so4466541a12.1;
        Mon, 11 Dec 2023 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367666; x=1702972466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR87eIuDn9C0HsT6AC1CHUaEI+JGnco8C87tfDzAy1Q=;
        b=Djqrb1M6Plqw+TpH4E3GjvtDloKEkXCerliNIBhAthMt4nXv2czV6mlpetZThvaVpZ
         1vOjnLfyjUHXHY694YWgY2AKJggYu6txyR6qjl+s1GmWoJ4+J/KH4ShaMakSiSrefwvZ
         VMyyV7PNnubGuotjJ6UUtGyyqY6H+qwoPwWorwc82mtdaMAjosTtOVyBN8rlqQk+1s9b
         SpuR5FPJbEZtoe0l06UbIpEFej5FjTacKC6b4+wMl3az0Y65lkVJe6LRted/h+ucj8Cv
         7Y59Shq82J/5CXQ3XgMRWq3wmTa0S18CIrvyEsHags7D9eUPHyDDvc1OkA2HgsImncXD
         lfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367666; x=1702972466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR87eIuDn9C0HsT6AC1CHUaEI+JGnco8C87tfDzAy1Q=;
        b=fdiE3Et/MqDxp07+DULhB9q8axNOtsWjdri0dg3HlAdvrncJChhyHeID3Q3NBn1n7O
         G0P2bLyjHmkvEq6AmJRQitqXL1G2yFo2llmuFSedG5Ygg7jwe2jhDrFrhpdgAenqMtYx
         BN/TDda6Y8m5r0lPKZNxqebL7R0vSfu1MqIaYNlQHOxAw5qTvRUTE0ce7z1lMDnkh7pQ
         3A753asnjT/8Tcd78OQRCcg3KUbNZP3g50to/LKayszeBNesWDdibXL93VIQLm/JPFhJ
         0Dkfe4/7p4elb14TW5wXoHAJ1lutp6M0A75LE31wKhsWCKluqz6bpJadbvvmrWJKtsXd
         W2gQ==
X-Gm-Message-State: AOJu0YwLHKhyeJ5+TAcj6KAFpNSBHpDNy/HU3KmKBgNT2D7boZ8PVMq3
        RMlN0M0wz9JQ/eI1Y2obiSuyN8Z7jFY=
X-Google-Smtp-Source: AGHT+IFfyvBm3LnqNo7atzJ1xVUp4Yr9OqqLlbZGbP/nazODJ02yLWDVkfZj65sI030MwL8J6JU4fQ==
X-Received: by 2002:a05:6a20:3d08:b0:18f:97c:9766 with SMTP id y8-20020a056a203d0800b0018f097c9766mr8171271pzi.78.1702367666749;
        Mon, 11 Dec 2023 23:54:26 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:26 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 08/11] ARM: dts: aspeed: minerva: add fan rpm controller
Date:   Tue, 12 Dec 2023 15:51:57 +0800
Message-Id: <20231212075200.983536-9-yangchen.openbmc@gmail.com>
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

Add fan rpm controller max31790 on all bus of FCB.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f4cb5ef72310..c7445c819baf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -158,6 +158,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux17: i2c@1 {
@@ -169,6 +176,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux18: i2c@2 {
@@ -180,6 +194,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux19: i2c@3 {
@@ -191,6 +212,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux20: i2c@4 {
@@ -202,6 +230,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux21: i2c@5 {
@@ -213,6 +248,13 @@ eeprom@50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm@5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.34.1

