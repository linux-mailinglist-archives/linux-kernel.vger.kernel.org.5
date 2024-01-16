Return-Path: <linux-kernel+bounces-27066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0F82E9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E7B284672
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48A111A2;
	Tue, 16 Jan 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+wFDVJ4"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68010A3F;
	Tue, 16 Jan 2024 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21080bacc6fso53843fac.0;
        Mon, 15 Jan 2024 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389747; x=1705994547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSNu/F0YjWWvZJ8YEGZOLrkQaebTdrL0bEYeNxkjWKw=;
        b=e+wFDVJ4qt7wJHsUt49BsyFF5oT/gSL5eyElCI5m4b2rilfySUi1uTmBix8UKOyvq/
         ajK1S55BKtfKujVTnqnpKLGZ9bOo/vygUEixJEtmIew454CgLsTO0MWit+W55dJnUgh4
         zAs1XC/fMW1xFcImYKR/QXJZCuUulDPsmT5tV5U+RBs64lY7wW1voO/I1uPBWX3L3aB1
         vGAZNSssuAbamq9leUmW14S+w4d1Jr3OPagQ4tn0m14QgPOdSseouBJ/NWJM0UwBBjCh
         vrwO/UHVSne4C6hJMLcRwSxD99OuRA1BU19eoqhbZm77iZSYEWZPWxXuVU9yVfAbikQZ
         Ni2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389747; x=1705994547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSNu/F0YjWWvZJ8YEGZOLrkQaebTdrL0bEYeNxkjWKw=;
        b=CX+wQRaZK/5TAx0waJ6SmDmhfi8Q9WlqOJi5qdZiuYSDoWTUNhFvmCTG1RKAV7OPhO
         pU428/EaHLB+AQ1HFLJPSC3SRbv5LWSFkJwKsZacARLWPeOCH1MUPawppQIff2liJhbo
         EDml7e6zV6MY7sj9Q+IwaWWDWYdf7SUzm+ZycdAbpVxlniZy0oxfmDBEMC0H1Duqbhu+
         cfoQs+BaSpH4fJB6fRzul8+fQeU/HbPHqOIG8M+eZJ2E5YWgB31qYmG6ijVK2lvNnLS6
         wY7NNc6pxYMduh7cZz8rU2wfJ8IMuTgZmsg13haFmz+91EDR9Ioy3OgW5JsBpMrSmcKn
         cmmw==
X-Gm-Message-State: AOJu0YxHprTbDtmwCRkZCrDigln1P1u+/PJWUKuncVytrCnDKyPomBWd
	W5e1I+TkOlOIndBJ9PLNcmE=
X-Google-Smtp-Source: AGHT+IH69Ohci1IK5bZui+I6s85n29iczQYaPx877llDqKJLtWt+hCvbGqWnV03YlB5FQwI24tl4OQ==
X-Received: by 2002:a05:6870:3128:b0:210:7b00:e811 with SMTP id v40-20020a056870312800b002107b00e811mr389496oaa.71.1705389747085;
        Mon, 15 Jan 2024 23:22:27 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id t20-20020a05687044d400b002060e99b486sm2905903oai.22.2024.01.15.23.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:22:26 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v8 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Tue, 16 Jan 2024 15:22:20 +0800
Message-Id: <f2edd136c97cea465a81e8949a36471c26db9b09.1705388518.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705388518.git.unicorn_wang@outlook.com>
References: <cover.1705388518.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add clock generator node to device tree for SG2042, and enable clock for
uart.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 39 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..80cb017974d8 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,18 @@ chosen {
 	};
 };
 
+&cgi_main {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll0 {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..6dd8d89d4833 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
 
 #include "sg2042-cpus.dtsi"
 
@@ -18,6 +19,24 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	cgi_main: oscillator0 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_main";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll0: oscillator1 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll0";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll1: oscillator2 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll1";
+		#clock-cells = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -311,12 +330,32 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		system-control@7030010000 {
+			compatible = "sophgo,sg2042-sysctrl";
+			reg = <0x70 0x30010000 0x0 0x1000>;
+
+			sysclk: clock-controller {
+				compatible = "sophgo,sg2042-sysclk";
+				clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+				#clock-cells = <1>;
+			};
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			#clock-cells = <1>;
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


