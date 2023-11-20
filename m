Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879887F11DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjKTLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjKTLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:19:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D65D4F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so9012135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700479122; x=1701083922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGvXvdztvnU1Noz3qGE9zeJXlVtwjcExrfXoSufIG6g=;
        b=pOOKuEFpUEgBmFpMI7RSjFsYDT8AECq+ge4189kqw49264Pci3accNK65X1Yf3aS/g
         I4nxjk57NyAcOHvIE6fYwJZJdH8OYdnqhwhoDssmwhb9ZGhW54/HSRkY2pI2WIC7ODg9
         2iMl2yVWw84bPANMe9c/KmT7g+QLk6fuTPKvQ8Z3V5vW78ia38oQB4mzk4UMx4jq/JyK
         bj2LMa/CIff+KipplMElmGK6yz9cy5X2mAe6hhcQFzDwBmYoDPlQVi8+6VHyYVL8F0TX
         lp6AfpK9LyGIXT2cRMe6vmLpw/ulYQ4xLuiygh1aKMC8Z8FiIS043M/6mtsd1c0zisbu
         +I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479122; x=1701083922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGvXvdztvnU1Noz3qGE9zeJXlVtwjcExrfXoSufIG6g=;
        b=rmtlBpMkw2tTCUAeRAZAeON2FhADWUO3UAmhCEsxAwkvNZdiiBCWCpUSUUEd8Vzpk/
         c2+bU3+UHUju9XZzAWZlb/jkExl42BWeuS93AOdosLA8covCbpTMKgrjiVvEXGvQgHas
         E3yVMWiBH5lbVYTPq0NZJNuI/kzftD2os/X/EUXoOI938FvNS5QWVU69k16/i2+bsI5o
         zblHrlMo1OOwAwVi1GyMQv4fqReS8mj+MHviO+XTFNspRjYq7nWu3z0hCXTCBghUW7pW
         wyPVuh6fQ7JYRxqxoGA3lG+ikQmZ/Qfile6NhvqsI2MrxQ2gD7QnkYAHLlOZwGghNODl
         EE3Q==
X-Gm-Message-State: AOJu0YyGycHiNOnVerSw53+d2yFJBLIfYLOAWZ4BUS5/1fF+IsqPyUFw
        koL8sTq5LfgQfeiA2Ue9Qz6vLg==
X-Google-Smtp-Source: AGHT+IFiqC0hAoROkF8bGe1DWe/xZ03qtfGR9V52jRRdovggVx9Iq3wYl/7ufgUAj6kVUgCoo0FR1g==
X-Received: by 2002:a05:600c:358e:b0:409:6e0e:e95a with SMTP id p14-20020a05600c358e00b004096e0ee95amr5778715wmq.19.1700479122593;
        Mon, 20 Nov 2023 03:18:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b0040651505684sm13142676wmo.29.2023.11.20.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:18:42 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 9/9] arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node
Date:   Mon, 20 Nov 2023 13:18:20 +0200
Message-Id: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add IA55 interrupt controller node and set it as interrupt parent for pin
controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 02a5dc9a0a3e..793512c4b31c 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -101,6 +101,7 @@ pinctrl: pinctrl@11030000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			interrupt-parent = <&irqc>;
 			gpio-ranges = <&pinctrl 0 0 152>;
 			clocks = <&cpg CPG_MOD R9A08G045_GPIO_HCLK>;
 			power-domains = <&cpg>;
@@ -109,6 +110,73 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
 		};
 
+		irqc: interrupt-controller@11050000 {
+			compatible = "renesas,r9a08g045-irqc", "renesas,rzg2l-irqc";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0x11050000 0 0x10000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "nmi",
+					  "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err";
+			clocks = <&cpg CPG_MOD R9A08G045_IA55_CLK>,
+				 <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
+			clock-names = "clk", "pclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_IA55_RESETN>;
+		};
+
 		sdhi0: mmc@11c00000  {
 			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-- 
2.39.2

