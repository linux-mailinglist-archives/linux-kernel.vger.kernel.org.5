Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132017E9D04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjKMNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKMNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:20:23 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CED6F;
        Mon, 13 Nov 2023 05:20:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce31c4a653so2672521a34.3;
        Mon, 13 Nov 2023 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881619; x=1700486419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2oQtEPIutglTe0zePH4EdTxwpuD5Zb7G2ePiU4NwmQ=;
        b=dX8IAVIipejWr13GMB0Tf4XdlVCWCfTvV/dzXTTKduEkMBgGyCQaR216iLiyj2KGXX
         WrDCi4Zluc89Plnt5U9wA96kCDzoN6JWtblFG89f5n3zyrVV3LE0WAOASRQUjBOb1nhH
         aLEAchxgMn4jv/1OvhHPHsTN+xzoZo5YSGVKVcOllOVhwkzuujo750UthOkM2Lm6cP81
         3DIyfr7T2nj0O/uOlKEwr7RIBE8kJS8CD7Rw4ENLzAuFDk8Z/Wvy6KXYf/FCDW3PWN97
         Za8nSyZHoi5vN/GhbLvRxYAhySt+xq8dXg7IEWC28o2KTW0JGainnRj5TgOJsAlwlH+j
         UaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881619; x=1700486419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2oQtEPIutglTe0zePH4EdTxwpuD5Zb7G2ePiU4NwmQ=;
        b=rlX/8XNfxCFWzAYWHZOZ5Ikr8tIP0vE9xOO0WoGDWREICt7ZeCpwyEYhw/ha/O4/h9
         SeRntU6A6sZwxiy4+gwDNgiMDVIYaaGD3d9mpMSoGggf2uKuJCRqacZ67i5pIrYSLdHj
         zcBEHL4MbgfQ+pSIpFHgh7rjyD8gUHULzXkOCNk+W73zjF1Vq8ndbLQ+GJcZPNUv69u0
         H3/bj27W1UWJGYBgNsmVIHVtXSyWSkYcr1MOFeUZUn9qXyC0vzHd2JwAJLlYGw0Ku4Wm
         DMm7YHySEm3EojtZmt0Ybnh3a4hvqVZ6bU3pJG5imAbtBTnDQcUGqtGibRQ1DaHVaXpn
         GGvw==
X-Gm-Message-State: AOJu0Yy0nKdAA4QbV/pquDIcfZIfwBj3eRWptKR/4FOSs4Gii3RQAoJ4
        0UDs9QuxWMLHqt1HDxC1Jss=
X-Google-Smtp-Source: AGHT+IGdyfd3Iw8wc2oNjooMchUT5EXKOY6OdN9KO1iBklie7kMMadIh4BY1epZEyrW1KogBEF8e+w==
X-Received: by 2002:a9d:7752:0:b0:6d6:4cf3:d908 with SMTP id t18-20020a9d7752000000b006d64cf3d908mr7631954otl.33.1699881619198;
        Mon, 13 Nov 2023 05:20:19 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d69c7000000b006d646763942sm799989oto.23.2023.11.13.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:20:18 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date:   Mon, 13 Nov 2023 21:20:11 +0800
Message-Id: <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699879741.git.unicorn_wang@outlook.com>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
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

From: Chen Wang <unicorn_wang@outlook.com>

Add clock generator node to device tree for SG2042, and enable clock for
uart0.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi | 76 ++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi       | 10 +++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
new file mode 100644
index 000000000000..66d2723fab35
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+/ {
+	cgi: oscillator {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		clock-output-names = "cgi";
+		#clock-cells = <0>;
+	};
+
+	clkgen: clock-controller {
+		compatible = "sophgo,sg2042-clkgen";
+		#clock-cells = <1>;
+		system-ctrl = <&sys_ctrl>;
+		clocks = <&cgi>;
+		assigned-clocks = \
+			<&clkgen DIV_CLK_FPLL_RP_CPU_NORMAL_1>,
+			<&clkgen DIV_CLK_FPLL_50M_A53>,
+			<&clkgen DIV_CLK_FPLL_TOP_RP_CMN_DIV2>,
+			<&clkgen DIV_CLK_FPLL_UART_500M>,
+			<&clkgen DIV_CLK_FPLL_AHB_LPC>,
+			<&clkgen DIV_CLK_FPLL_EFUSE>,
+			<&clkgen DIV_CLK_FPLL_TX_ETH0>,
+			<&clkgen DIV_CLK_FPLL_PTP_REF_I_ETH0>,
+			<&clkgen DIV_CLK_FPLL_REF_ETH0>,
+			<&clkgen DIV_CLK_FPLL_EMMC>,
+			<&clkgen DIV_CLK_FPLL_SD>,
+			<&clkgen DIV_CLK_FPLL_TOP_AXI0>,
+			<&clkgen DIV_CLK_FPLL_TOP_AXI_HSPERI>,
+			<&clkgen DIV_CLK_FPLL_AXI_DDR_1>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER1>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER2>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER3>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER4>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER5>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER6>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER7>,
+			<&clkgen DIV_CLK_FPLL_DIV_TIMER8>,
+			<&clkgen DIV_CLK_FPLL_100K_EMMC>,
+			<&clkgen DIV_CLK_FPLL_100K_SD>,
+			<&clkgen DIV_CLK_FPLL_GPIO_DB>,
+			<&clkgen DIV_CLK_MPLL_RP_CPU_NORMAL_0>,
+			<&clkgen DIV_CLK_MPLL_AXI_DDR_0>;
+		assigned-clock-rates = \
+			<2000000000>,
+			<50000000>,
+			<1000000000>,
+			<500000000>,
+			<200000000>,
+			<25000000>,
+			<125000000>,
+			<50000000>,
+			<25000000>,
+			<100000000>,
+			<100000000>,
+			<100000000>,
+			<250000000>,
+			<1000000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<50000000>,
+			<100000>,
+			<100000>,
+			<100000>,
+			<2000000000>,
+			<1000000000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..de79c0cdb4c1 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,8 +5,10 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo-sg2042-clk.h>
 
 #include "sg2042-cpus.dtsi"
+#include "sg2042-clock.dtsi"
 
 / {
 	compatible = "sophgo,sg2042";
@@ -311,12 +313,20 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		sys_ctrl: syscon@7030010000 {
+			compatible = "sophgo,sg2042-syscon", "syscon";
+			reg = <0x70 0x30010000 0x0 0x8000>;
+		};
+
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
 			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
+			clocks = <&clkgen GATE_CLK_UART_500M>,
+				 <&clkgen GATE_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
-- 
2.25.1

