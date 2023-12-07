Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C92808481
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378470AbjLGI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378452AbjLGI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:58:58 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4DD53;
        Thu,  7 Dec 2023 00:59:04 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1efb9571b13so468957fac.2;
        Thu, 07 Dec 2023 00:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939544; x=1702544344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMotijnh/qiarlNtyEfMGI6pNts/0ixAszGWpmQazv8=;
        b=AgIICz0iiva4A0f1MqZT6dkoQa1H63dHZtUcVklYFSEyyN6NwvHHb89jljAGt2j0ui
         DsUZvBwSE7DsCrezUv8t78VyxW3ooVwB/cGpxd/H1AuPESEZFFf99ZvXD2HwxVLWPMwg
         qVJdFDT+lGUDV3nROLZRXC1JHUIBU5veR3CwjY7Cn4lIy3msdsz7U5qEoMzErYGYPPZE
         MhoKlsGIy8yGFBemI0ueUOSBOf6Px9ZW2Iv23+3JQ91/pa4rqAaoc6aFZDryC37tnA9p
         mEJzsj5bT4z6IzxeR9V3Trqp6++4jlxdsAdhJf2RtosRJ8aiQEo9xQugfn9uixjTr3Zq
         gXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939544; x=1702544344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMotijnh/qiarlNtyEfMGI6pNts/0ixAszGWpmQazv8=;
        b=kb+3rvRKDt6oR12TL3w6GUPHrwXG5KaiwofX59LeQTIJhz86GuyJj8MMc9K2JAFQB9
         j6ljoeJrfmwVXX52xKltNJpaw4IIIFdzA/6P8NtwIHF1sWqGtBQPZopwjiNtDiW4+n60
         1e+ke+2TpjL923HGdPjLybOYxeyC6W7ZiJKKju9YJnI9Zs2NChpZ46abiSmivz7EN/FB
         QqxRFEiQFvCQ3k5Y1YmHDwRpVGsyrYJ+lC059pHzBtoX1edcCt91wEs8renM5v1cuElx
         J6ktM37DQ5ZBo2lRnf3OSs86i3T3gAQr0VstcMV4gZiyjXE7y9BoJJJT+xFrjXgi1EXa
         sNJQ==
X-Gm-Message-State: AOJu0Ywx5y8UuHcrWhDDaJEeGBgmZ8/PKDV+/LgayZTkhc0BLXSbxqOn
        q9H4Se5Dqk/SCqNRF02JKWI=
X-Google-Smtp-Source: AGHT+IEXTbQq8dYkPSJIMFuDzSIa2jJdfeAvsDSzpCTKkjrNj1lYR7HKeNF3KhBamgosP45aezeo2g==
X-Received: by 2002:a05:6871:2b1b:b0:1fb:75a:7797 with SMTP id dr27-20020a0568712b1b00b001fb075a7797mr2467585oac.72.1701939544160;
        Thu, 07 Dec 2023 00:59:04 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m25-20020a9d7ad9000000b006d84f49497fsm153756otn.23.2023.12.07.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:59:03 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 4/4] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date:   Thu,  7 Dec 2023 16:58:54 +0800
Message-Id: <8e58ac40c02e13ed09c5bb896f1cb5aaa01d82c6.1701938395.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701938395.git.unicorn_wang@outlook.com>
References: <cover.1701938395.git.unicorn_wang@outlook.com>
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
uart.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  4 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 79 +++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..0b3b3b2b0c64 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,10 @@ chosen {
 	};
 };
 
+&cgi {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..f08c41dda216 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
 
 #include "sg2042-cpus.dtsi"
 
@@ -18,6 +19,12 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	cgi: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi";
+		#clock-cells = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -311,12 +318,84 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		sys_ctrl: system-controller@7030010000 {
+			compatible = "sophgo,sg2042-sysctrl";
+			reg = <0x70 0x30010000 0x0 0x1000>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			sophgo,system-ctrl = <&sys_ctrl>;
+			#clock-cells = <1>;
+			clocks = <&cgi>;
+			assigned-clocks = \
+				<&clkgen DIV_CLK_FPLL_RP_CPU_NORMAL_1>,
+				<&clkgen DIV_CLK_FPLL_50M_A53>,
+				<&clkgen DIV_CLK_FPLL_TOP_RP_CMN_DIV2>,
+				<&clkgen DIV_CLK_FPLL_UART_500M>,
+				<&clkgen DIV_CLK_FPLL_AHB_LPC>,
+				<&clkgen DIV_CLK_FPLL_EFUSE>,
+				<&clkgen DIV_CLK_FPLL_TX_ETH0>,
+				<&clkgen DIV_CLK_FPLL_PTP_REF_I_ETH0>,
+				<&clkgen DIV_CLK_FPLL_REF_ETH0>,
+				<&clkgen DIV_CLK_FPLL_EMMC>,
+				<&clkgen DIV_CLK_FPLL_SD>,
+				<&clkgen DIV_CLK_FPLL_TOP_AXI0>,
+				<&clkgen DIV_CLK_FPLL_TOP_AXI_HSPERI>,
+				<&clkgen DIV_CLK_FPLL_AXI_DDR_1>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER1>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER2>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER3>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER4>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER5>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER6>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER7>,
+				<&clkgen DIV_CLK_FPLL_DIV_TIMER8>,
+				<&clkgen DIV_CLK_FPLL_100K_EMMC>,
+				<&clkgen DIV_CLK_FPLL_100K_SD>,
+				<&clkgen DIV_CLK_FPLL_GPIO_DB>,
+				<&clkgen DIV_CLK_MPLL_RP_CPU_NORMAL_0>,
+				<&clkgen DIV_CLK_MPLL_AXI_DDR_0>;
+			assigned-clock-rates = \
+				<2000000000>,
+				<50000000>,
+				<1000000000>,
+				<500000000>,
+				<200000000>,
+				<25000000>,
+				<125000000>,
+				<50000000>,
+				<25000000>,
+				<100000000>,
+				<100000000>,
+				<100000000>,
+				<250000000>,
+				<1000000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<50000000>,
+				<100000>,
+				<100000>,
+				<100000>,
+				<2000000000>,
+				<1000000000>;
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

