Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1DC7F9CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjK0JeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjK0JeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:34:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624EEF5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a02d91ab199so541137366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701077663; x=1701682463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxjZg22ov6gQx8JLukqacT0gU0Tul8TKlesYhtgUQmM=;
        b=uRnFLI3Gf/3DWA6OhALjPc5CUCU0+HiFjvWK/ut47OrInttTGZjde0NZecte5GP+cU
         gBD7rWD89o1bSNzxwy8SVWAzlrYz9VdyJmsag4q37vESytMcVrCvNKuVoZ3/wxwOVEq3
         CS2w7GnrSIGlCuy2blrLIjrkMQc7SOADbZu3tmJ8Jf3FlmO1vbhKk3Di4/DYk4Nl45+j
         rSAEVA7wHM480BkmtW4Yg2Bd+FaefR2dk1qzYbmQZOkYItOYZz7LoPYuWAE7qq66cInR
         VhCFt2fkKSUQw4/ODHWv2SNEhg/HKzcWIxjgpEdFDzoc2qBZxvZnYjqQxCr9BIYuky4N
         C4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701077663; x=1701682463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxjZg22ov6gQx8JLukqacT0gU0Tul8TKlesYhtgUQmM=;
        b=X2I2Y4TZJFfnORHOTsc3Ys7sPqnIJkOLn1qhINi9/dfpvms2txSd1dHi4Zq/oGk3s+
         Y+PhYP/cWv8lTbnWjaOrFbMX/+66Stf5jrXUduJ9CgMw7kTqSaqoV0czAFv3B9c3QhdV
         XZvT1vR3k+jacLQsGoSdLJ5kd+sXZoITutESDLLi4uBzgSIbBNmgUjr1Uh5pzaymTtGS
         JvSswDOtocx4WD+0zp5YMx/KZ+4s+SzFsgI3DsykSwZPbe9sivrknpLnjPcVDZfGKwVI
         1r6fQmBb0ZMy95DMpqyBewywNaM1bBMItoKU+VM6zAN0VUn7WGDUZtGXTxkCupv2SYxT
         GLwA==
X-Gm-Message-State: AOJu0YzqMP3uitOEBhICt6mYuS+Mqsblat00njQReNiy2LblHaHUxyvf
        Pff0mG/fNpSSWhbPwPmD2Ibr+Q==
X-Google-Smtp-Source: AGHT+IHwjo3iCYneHAx17+3mDf/thozieQyTXj1EWQg79jKTCz1jo/XMchH7SbSIGHpMDbSOO2DORA==
X-Received: by 2002:a17:906:109b:b0:a0c:fe2f:c445 with SMTP id u27-20020a170906109b00b00a0cfe2fc445mr3149996eju.69.1701077662724;
        Mon, 27 Nov 2023 01:34:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id s20-20020a1709066c9400b009fd585a2155sm5452587ejr.0.2023.11.27.01.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:34:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ARM: dts: stm32: minor whitespace cleanup around '='
Date:   Mon, 27 Nov 2023 10:34:20 +0100
Message-Id: <20231127093420.20473-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Split previous commit touching entire 'st' directory.
---
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
index afcd6285890c..69d693ae26dd 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
@@ -59,7 +59,7 @@ &m4_rproc {
 	/delete-property/ st,syscfg-holdboot;
 	resets = <&scmi_reset RST_SCMI_MCU>,
 		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
-	reset-names =  "mcu_rst", "hold_boot";
+	reset-names = "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
index 39358d902000..89bfb4143ba7 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
@@ -65,7 +65,7 @@ &m4_rproc {
 	/delete-property/ st,syscfg-holdboot;
 	resets = <&scmi_reset RST_SCMI_MCU>,
 		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
-	reset-names =  "mcu_rst", "hold_boot";
+	reset-names = "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
index 07ea765a4553..ca7a3a0f16af 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
@@ -64,7 +64,7 @@ &m4_rproc {
 	/delete-property/ st,syscfg-holdboot;
 	resets = <&scmi_reset RST_SCMI_MCU>,
 		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
-	reset-names =  "mcu_rst", "hold_boot";
+	reset-names = "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
index 813086ec2489..f6510b93f912 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
@@ -70,7 +70,7 @@ &m4_rproc {
 	/delete-property/ st,syscfg-holdboot;
 	resets = <&scmi_reset RST_SCMI_MCU>,
 		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
-	reset-names =  "mcu_rst", "hold_boot";
+	reset-names = "mcu_rst", "hold_boot";
 };
 
 &rcc {
-- 
2.34.1

