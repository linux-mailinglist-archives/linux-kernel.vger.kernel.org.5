Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943017F971F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjK0BQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjK0BQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:16:25 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B29E8;
        Sun, 26 Nov 2023 17:16:32 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2ea3a944so2535460a34.1;
        Sun, 26 Nov 2023 17:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701047792; x=1701652592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/U0t4lVPnM2IDbC1l080UWyb7I1vEq1c7QyaFDSq/c=;
        b=CmRx2zX0fVt3BL3gdTGsHkEIsDIXvtDYSyRiqUvw6eHhX2pSLKcV7tI2I+m+l80edy
         zHH/tsOo9oP5GNNL2t9UeWeNESyMlAIOty2P3tsx0OSXpgD58DhENbA/FNAznlUq3Mru
         n7LtvNtUXBjxYnXSQY1VkxTig7zlIkYXSzUixHLbZrRZU3hsM+hKTQMgWlYsuyDzAb+A
         rXGRUUP10BPPdYHCSbmQ9WY8JdcomiqEgiEOas8g/zNt68JG4qr9J+RhjFlVjBBm/Xqy
         C4FdPUa3/GdXjouKNr/hIt6tdw3a84fWrnJT0qKbZa3IBhJSGC0XpIPCV6KoWjsBVGiL
         kPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701047792; x=1701652592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/U0t4lVPnM2IDbC1l080UWyb7I1vEq1c7QyaFDSq/c=;
        b=MDpmhqfcLXbmow5cBSy3T0kb26hWPR9lTzgflQMTp+/7qiOV7YUcxGFMeHcq+Ni+oZ
         g5ZFGWW38Tv3BTQ9tEWxcGTaCA8xbIgzImZKaTUsBr/BX1h1OTaeywA/bjXATbo13mkW
         zjvdjl5r66WNUVuQ3UK+EIMcn5hRWv9ZViT7zIPz67xjkTHtUo+ImSMs65QpcJodliGG
         5adm+l7Jb67mhSnyh1NSo/Zqulh3lhM1+VcgzROv9hIqp1HORdxtljUgN/Rdr5b7mTN8
         AldSzk1CDV14ECc4dAvTibdx4BS/DQTa0/NZgXlVf0wwPEBgmDYIKdCzyFqk8gOK0mPg
         gFSw==
X-Gm-Message-State: AOJu0YzPX1z+KcUk5BPwUqs+qCUUSvOG3lwb2iFUpMnaXnnOGMMGz/qf
        QMpP5Cdw1nKLQnpQUPKHw+4=
X-Google-Smtp-Source: AGHT+IGbHdzoQeZ85sBN0SyEOpFNpyntrl82FC+nP1mZS4niHW8rfdJZzuYGim9/uM15OjkestW1Bg==
X-Received: by 2002:a05:6830:6b42:b0:6bb:1c30:6f3c with SMTP id dc2-20020a0568306b4200b006bb1c306f3cmr13168007otb.0.1701047791774;
        Sun, 26 Nov 2023 17:16:31 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm1241663otk.21.2023.11.26.17.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 17:16:31 -0800 (PST)
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
Subject: [PATCH v2 4/4] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date:   Mon, 27 Nov 2023 09:16:22 +0800
Message-Id: <70ad5faa3a4a012df328fa21e69eaffd377e99ca.1701044106.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701044106.git.unicorn_wang@outlook.com>
References: <cover.1701044106.git.unicorn_wang@outlook.com>
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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 77 +++++++++++++++++++
 2 files changed, 81 insertions(+)

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
index 93256540d078..c5849a0e74d0 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo-sg2042-clk.h>
 
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
@@ -311,12 +318,82 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		sys_ctrl: syscon@7030010000 {
+			compatible = "sophgo,sg2042-syscon", "syscon";
+			reg = <0x70 0x30010000 0x0 0x8000>;
+
+			clkgen: clock-controller {
+				compatible = "sophgo,sg2042-clkgen";
+				#clock-cells = <1>;
+				clocks = <&cgi>;
+				assigned-clocks = \
+					<&clkgen DIV_CLK_FPLL_RP_CPU_NORMAL_1>,
+					<&clkgen DIV_CLK_FPLL_50M_A53>,
+					<&clkgen DIV_CLK_FPLL_TOP_RP_CMN_DIV2>,
+					<&clkgen DIV_CLK_FPLL_UART_500M>,
+					<&clkgen DIV_CLK_FPLL_AHB_LPC>,
+					<&clkgen DIV_CLK_FPLL_EFUSE>,
+					<&clkgen DIV_CLK_FPLL_TX_ETH0>,
+					<&clkgen DIV_CLK_FPLL_PTP_REF_I_ETH0>,
+					<&clkgen DIV_CLK_FPLL_REF_ETH0>,
+					<&clkgen DIV_CLK_FPLL_EMMC>,
+					<&clkgen DIV_CLK_FPLL_SD>,
+					<&clkgen DIV_CLK_FPLL_TOP_AXI0>,
+					<&clkgen DIV_CLK_FPLL_TOP_AXI_HSPERI>,
+					<&clkgen DIV_CLK_FPLL_AXI_DDR_1>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER1>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER2>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER3>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER4>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER5>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER6>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER7>,
+					<&clkgen DIV_CLK_FPLL_DIV_TIMER8>,
+					<&clkgen DIV_CLK_FPLL_100K_EMMC>,
+					<&clkgen DIV_CLK_FPLL_100K_SD>,
+					<&clkgen DIV_CLK_FPLL_GPIO_DB>,
+					<&clkgen DIV_CLK_MPLL_RP_CPU_NORMAL_0>,
+					<&clkgen DIV_CLK_MPLL_AXI_DDR_0>;
+				assigned-clock-rates = \
+					<2000000000>,
+					<50000000>,
+					<1000000000>,
+					<500000000>,
+					<200000000>,
+					<25000000>,
+					<125000000>,
+					<50000000>,
+					<25000000>,
+					<100000000>,
+					<100000000>,
+					<100000000>,
+					<250000000>,
+					<1000000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<50000000>,
+					<100000>,
+					<100000>,
+					<100000>,
+					<2000000000>,
+					<1000000000>;
+			};
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

