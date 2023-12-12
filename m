Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786D80E535
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbjLLHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbjLLHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20012E;
        Mon, 11 Dec 2023 23:54:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4789071a12.0;
        Mon, 11 Dec 2023 23:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367658; x=1702972458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHK3yF+RxEWhkQj0oQiehpX/wc8FrqHwrN6Jvm7FyVU=;
        b=bFrf12Fg1X1bOGqv/9mNalTtKdB5BjirRWfQFubj2HxDu0VYck7XLkm+2xo+XXsvb6
         xUlJTOY67xtQq7WgV0rk4K9+hVePg8XM81d7bRvRXUxUnnaby8MWLtEb1rMIqMpqleUn
         +shGLl58CUDnjrClbtC+UbCyvZG7B8/bgRldXnrec4jAbHBWzCagcB7WYA/JB50YikoQ
         66siZ/f3douNRZfh9wbR7BzJqvyL39xl0EgBuiLcFc5S+i6zhTKng0fkRwr3dEoy3BMX
         Je8ztQVm8tprU+zwFgyC2e2b6rrNLhQN6PWRH4vm/KFQmqqlKww4rKJuS0Ch35vatgEs
         RVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367658; x=1702972458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHK3yF+RxEWhkQj0oQiehpX/wc8FrqHwrN6Jvm7FyVU=;
        b=ICBPmOoMDuTQqS1HYt9ZgsNeVMNXRedd2hl/fCRsilJcZYnlP7Sd7IJPyf719jxTA/
         aagJMloln2IyKqppyBa4BoQKkbtIKBqAUvCv3qvR2tty1ioqUElF6ZGr/YWzc/MS+si9
         iZ2agGtVpgflFh3kRSXRGNul+O3eE1cjdL2bl/HPvyB6d8S0KxR5sqPVQv18yC0dXDJm
         qzMLJn6QtarfenxMUuxwNE5nCpGKyf7ObPSrdd1wa7pqAdTm09JPg1U7T2I2QuDJ96I0
         3l0HOb/9NXaXoxKVhH6LmS4Cs0Jzrsxb33UyElWdrxy9C7eh2g1RLbaGBXxu8nFYXdje
         3MEg==
X-Gm-Message-State: AOJu0YznzqjJs9EspEgMBhQgbbHfvG/FwrvmNQHgZe6JAEt8zCkcesON
        IM5wuZ+7sHRa8gR7nUm6jy4=
X-Google-Smtp-Source: AGHT+IHfL94iq6tfgSml3eIh4XF0ifueCrBJMXSaicX+WmA5/rXwJDYCuVr3HYJ2SB4JyYi4ZAuA5Q==
X-Received: by 2002:a17:90a:c90e:b0:28a:bf87:90e0 with SMTP id v14-20020a17090ac90e00b0028abf8790e0mr603993pjt.22.1702367658484;
        Mon, 11 Dec 2023 23:54:18 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:18 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 05/11] ARM: dts: aspeed: minerva: Add temperature sensor
Date:   Tue, 12 Dec 2023 15:51:54 +0800
Message-Id: <20231212075200.983536-6-yangchen.openbmc@gmail.com>
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

Add one temperature sensor on i2c bus 1

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ee9691647e4a..783d4d5a8f3d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -115,7 +115,12 @@ &i2c1 {
 
 	temperature-sensor@4b {
 		compatible = "ti,tmp75";
-		reg = <0x4B>;
+		reg = <0x4b>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
 	};
 
 	eeprom@51 {
-- 
2.34.1

