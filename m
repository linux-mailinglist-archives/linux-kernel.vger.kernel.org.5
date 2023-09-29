Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DB7B2BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjI2Fm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjI2Flq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8451FDC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1209413466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695966003; x=1696570803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC2N0NQesLpV+h5wgB+6cfaYIHKlUTcU15F3ltasIWI=;
        b=XIem3zKkailCkSybyBQl9IdNPMl8Gcos9UK8cToTV4yy0tmPjJyEmzSb7UWB3tU0/i
         xLWIGGiAONUoDBY3AyBU9cRlxIXanhjLQjQpZM9urOXlllDeUGMYyAUudw4LeatVL3J7
         +go8FNAYWdxqaU14boKSeBbWTVkohvpBjsXXr0WVi7LuspldySY61i/8tWVHrUyJgpyt
         mGZ5ocTefnhk8Il3gL2zUJZvVI/FFsKuryTSny1JdknJ+to3a6v5PgOqeoLaJ+JUOdUP
         x1JTn9mxrbdSQo5FBK5ijhnsgYCCMDXvKKF+eVbW6UfZ0TDznLlFWSKjQm6K68qWnZ7X
         ReNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695966003; x=1696570803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC2N0NQesLpV+h5wgB+6cfaYIHKlUTcU15F3ltasIWI=;
        b=f/pwR5Yy9tD9Fzuex0OP4u5tXlcEQHuNmIBU5kTf4dgyRHxBzxHtFfSXSGqYG9OKxq
         fE8VYDT42ZKlkOlociw13PHUZuPRkxNz0UY5p1b8h+ZYfUYIHBu9J1pHzvmJwprQAq6H
         w+lYt+4LO2bKboUtBN6ZmI1mT9auX4ga57yS3Jrqqzt0t0vr3uXBAtULEOetYxzuJuAi
         1Btm3DA5WIffOpdlfdmAoc8SkFDPDkTeib53GLP2E6qEwaQ6O06CpK0phUNIMiM7dDdO
         ako++7Z1+W7Itdb9+1koRW9JNJRuln9SAeu8rIqK42EH4k8bY5xqxCEPbmXDZcuXvVus
         ouag==
X-Gm-Message-State: AOJu0YwrhugDqI2sWP9XREB/yyH00ZE4vYlnfhHgu2z/jgLkr8ebe4pA
        h0Q+WTevaNRvCG+KYHC4ihvnCQ==
X-Google-Smtp-Source: AGHT+IHhxpKbbGdqx3TLi48TSHbS3dC2UsZAlixnmx0s9mPLg0wCUBALZUBxIMB+xAQUrTHbDFSMWQ==
X-Received: by 2002:a17:906:3186:b0:9b2:b9a3:d20c with SMTP id 6-20020a170906318600b009b2b9a3d20cmr2669257ejy.74.1695966003450;
        Thu, 28 Sep 2023 22:40:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:40:03 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 22/28] arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
Date:   Fri, 29 Sep 2023 08:39:09 +0300
Message-Id: <20230929053915.1530607-23-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial DTSI for RZ/G3S SoC. Files in commit has the following
meaning:
r9a08g045.dtsi		RZ/G3S family SoC common parts
r9a08g045s33.dtsi	RZ/G3S R0A08G045S33 SoC specific parts

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- collected tags

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

