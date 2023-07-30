Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866A7684D8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjG3KpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Ko7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:44:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CBE173D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:44:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc512526cso556358366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690713895; x=1691318695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvks5yY1E7N6EZzE9v93J4jxOXQSUnmzcPH5eaYu9/k=;
        b=GxFw/gQPVacNnJHRn8SzlVNdZ/g7cJlKJB/Wzy7FiuT0fyke9TUC3V/ocD7kRjRXyl
         zBOps0xNULUIorJMcDnoXzoWgN6gk5CLIK+x6taL4HgxRiUgnwohSuxqqtfIA4JIckFj
         6/HnoC9CUAMDrnuqule0ssdrS5J3ndnXBZWnidcfw4YuSfEa3CnY7k+GKvn7wLadK7GA
         zaXOgpbzF6S3BaB6X4lzDHj0o+HffDEscoKfN3JiH7EsBn2qwE8ncQouo4xwQ+r2NQ+v
         2eKCXf/siL6iEqojTp/wFzu3oOpraxoSu1bdqT5NvBZzp0O65oollozleL6UhIRBhItY
         FRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690713895; x=1691318695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pvks5yY1E7N6EZzE9v93J4jxOXQSUnmzcPH5eaYu9/k=;
        b=IakdwR/JTY15xUisvlshzjGj67XgdfMxkylRXrn86gNL4zUf1qzD4o6Z205HAdUj1v
         0Lt7+wSQCZVlMRxlqKd2BnT7uX0Ux0S7MSAtRKOKolgw7EXjB6Dm6GNXN4dInSGRxYiP
         R397fQ2Gtr3kpi4Q1862NScS5EoQBiQ5WZLId11KAkbiv5pVpgz9IcDzO6XPwuzJbwWx
         XraUqmEYec+++rQKTtg/TkHFriTH/qP1lN6EYBJWakap/9fgFf2H9au5omblLCeIbaLs
         J9QWo72mPzzl6kvOlkA9W5Wv04wrp9SgtcSULfTlO4Xght2RQGHajhJ3DdoYOzpV221/
         heGw==
X-Gm-Message-State: ABy/qLbv+tm7Hc6ddYTn62wKRpPIaqUIOMGoAZNgoEattwhDf9GeNRzX
        SkKutt/gJ/onz68M6Hhrjvpm5Q==
X-Google-Smtp-Source: APBJJlGBK0hIBPmiKeAMU2D5B5LAQTlyKhUrgDg+47cONQAOnz+jsSugbOaXgqAtSNiNrN4LO1qbWg==
X-Received: by 2002:a17:906:3f1e:b0:98d:cd3e:c193 with SMTP id c30-20020a1709063f1e00b0098dcd3ec193mr4380032ejj.46.1690713895474;
        Sun, 30 Jul 2023 03:44:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090686cd00b0098884f86e41sm4447546ejy.123.2023.07.30.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 03:44:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ARM: dts: broadcom: split interrupts per cells
Date:   Sun, 30 Jul 2023 12:44:52 +0200
Message-Id: <20230730104452.32230-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each interrupt should be in its own cell.  This is much more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/broadcom/bcm-hr2.dtsi  |  4 ++--
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi  |  4 ++--
 arch/arm/boot/dts/broadcom/bcm11351.dtsi | 13 ++++++-------
 arch/arm/boot/dts/broadcom/bcm21664.dtsi |  9 ++++-----
 arch/arm/boot/dts/broadcom/bcm23550.dtsi |  9 ++++-----
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-hr2.dtsi b/arch/arm/boot/dts/broadcom/bcm-hr2.dtsi
index 33e6ba63a1ee..788a6806191a 100644
--- a/arch/arm/boot/dts/broadcom/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-hr2.dtsi
@@ -54,8 +54,8 @@ cpu0: cpu@0 {
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>;
 	};
 
diff --git a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
index 5b1dc58d40ba..9d20ba3b1ffb 100644
--- a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
@@ -72,8 +72,8 @@ cpu1: cpu@1 {
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
diff --git a/arch/arm/boot/dts/broadcom/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
index b271a9bf06a9..53857e572080 100644
--- a/arch/arm/boot/dts/broadcom/bcm11351.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
@@ -111,13 +111,12 @@ timer@35006000 {
 	gpio: gpio@35003000 {
 		compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
 		reg = <0x35003000 0x800>;
-		interrupts =
-		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		#interrupt-cells = <2>;
 		gpio-controller;
diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
index 2eb7f5b0c1dc..fa73600e883e 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -101,11 +101,10 @@ timer@35006000 {
 	gpio: gpio@35003000 {
 		compatible = "brcm,bcm21664-gpio", "brcm,kona-gpio";
 		reg = <0x35003000 0x524>;
-		interrupts =
-		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		#interrupt-cells = <2>;
 		gpio-controller;
diff --git a/arch/arm/boot/dts/broadcom/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
index 445eadb8d871..50ebe93d6bd0 100644
--- a/arch/arm/boot/dts/broadcom/bcm23550.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
@@ -101,11 +101,10 @@ resetmgr: reset-controller@1001f00 {
 		gpio: gpio@1003000 {
 			compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
 			reg = <0x01003000 0x524>;
-			interrupts =
-			       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
-				GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
-				GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
-				GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			#interrupt-cells = <2>;
 			gpio-controller;
-- 
2.34.1

