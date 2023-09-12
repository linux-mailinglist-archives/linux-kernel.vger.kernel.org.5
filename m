Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B773379C5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjILE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjILEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCA2D45
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so5037632a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494402; x=1695099202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0wmcdmkVNbn0/L3PZmaokyWaGN3oFJGgoH9joABJEY=;
        b=JcyiNTbyQwRldigLuD+30Zvt28sMZYspMCFD8d+tsVn4GSuD9fgHkalT6M1nkTtEfe
         NAZNaahE+pNGMH0XJF8oqAfsXIJ+2OywD+/LJQ5GELuK+P8wr8renCVIqeYAHhsDbUbS
         3sTG43vsMG7nZb/gmT8YRnuy+ACy+7sn73FhtlkshkzcF9QtJGjgZ3DJKEkht3NLD9cO
         h7UZE6ylymxJWklv7OK55KtFjYXttX+J9NbtHJ43lbFavbhhAsoN25g0uNUA1dGcToKC
         78us+WPNzf410dm+teDx6DBFzs5mvYwBPMod0Rf7t4gggmw02ERqNwM2la9wKo9as/Yx
         8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494402; x=1695099202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0wmcdmkVNbn0/L3PZmaokyWaGN3oFJGgoH9joABJEY=;
        b=PXLrr6TJ1EV4bV6Awja05QyoTr+t8wQcg/oigx9b8VirClFfOeNnqqomFkSsKUigu5
         hP01b/r6i/6AfIt43mpvuiKmUemCz5JOX6pwDjgwpwXZeBekiKPkVnnZtI+93WjMJoxK
         5sVQefkkp8044FObOKUBtVd0IOtU1WlajqFZsuhUM9SJdDFSGHGAs2xxQl716IqyUaXr
         v0ExRrY0EEuc63in3gxgMcw6RgPczjS5RD6NyCMwNdvmDUiiZqrokpcYQVYAeVcZ1fgt
         6+znvlt22/dzvnUdOQvrVh7qBRquIlwu4n8TfstcakgP650IFfglbAu1QdEap0r2EieJ
         61ww==
X-Gm-Message-State: AOJu0YxiAFAMcQYe2LlwNc+2bz3Or76+cK/BNykBMlM08EUGyXVrA2Xn
        IUR0h4ViD0XmuW/InaefKfVuTA==
X-Google-Smtp-Source: AGHT+IHIPViShMk+/t7cd11iyQpPz7PeJFn4FiDSD1OX75yRHQ2nJLSa6BJ+uD252JH202P3SGnqmA==
X-Received: by 2002:a05:6402:1287:b0:523:2e30:aaee with SMTP id w7-20020a056402128700b005232e30aaeemr9655209edv.32.1694494402040;
        Mon, 11 Sep 2023 21:53:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:21 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 32/37] arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:52 +0300
Message-Id: <20230912045157.177966-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial DTSI for RZ/G3S SoC. Files in commit has the following
meaning:
r9a08g045.dtsi		RZ/G3S family SoC common parts
r9a08g045s33.dtsi	RZ/G3S R0A08G045S33 SoC specific parts

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 139 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 ++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
new file mode 100644
index 000000000000..7971e44a5a0a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SoC
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a08g045-cpg.h>
+
+/ {
+	compatible = "renesas,r9a08g045";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			#cooling-cells = <2>;
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+		};
+	};
+
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@1004b800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004b800 0 0x400>;
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a08g045-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a08g045-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "lpm_int", "ca55stbydone_int",
+					  "cm33stbyr_int", "ca55_deny";
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a08g045-pinctrl";
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A08G045_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_GPIO_RSTN>,
+				 <&cpg R9A08G045_GPIO_PORT_RESETN>,
+				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
+		};
+
+		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c00000 0 0x10000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A08G045_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@12400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0x12400000 0 0x40000>,
+			      <0x0 0x12440000 0 0x60000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
new file mode 100644
index 000000000000..3351f26c7a2a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S R9A08G045S33 SoC specific part
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a08g045.dtsi"
+
+/ {
+	compatible = "renesas,r9a08g045s33", "renesas,r9a08g045";
+};
-- 
2.39.2

