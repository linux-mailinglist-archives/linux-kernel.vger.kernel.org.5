Return-Path: <linux-kernel+bounces-72252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C285B12E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022692862F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF114437C;
	Tue, 20 Feb 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChAnyI5D"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AC47F4B;
	Tue, 20 Feb 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398620; cv=none; b=X1+nNbLRyx12VXVSfPGvI+IHZOvUvvFvfuPI3ZstfNUrN258vMVUnsNZep4KV04rC9Z/8XxsSxFNxPGbvK360HMJ2yTDSW8u6vcnEve6Yzey/bTNTNs5rFplnonxJsBYgOubIaQtFrWKVBA+84KpR7kdjADAwfzDhcHgfMifR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398620; c=relaxed/simple;
	bh=/hp9q7/rvX96KX1XzOHKL9Okixgs6uSm6RMgQKOPrmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMDnQ6A9cNVwZmUuuxLYvWKFUYDmh/9UrqCKQD4ExdewpEro8CfQFHkmDZzc6Vv4TdV7GKCJsm54h+8FGwRIePHfNtNSSvSx/gqGGR3uptarLpVukaBh0LYPAMDFYCU2hUuwkhPNfcGDYCM+3xyKtYG+X5qAdStKKg4D8YP5N7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChAnyI5D; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2185739b64cso2977242fac.0;
        Mon, 19 Feb 2024 19:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398618; x=1709003418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=981KgcDEWu0cp8w2YBjuMYv78Dw7iGFDfkFmvYcaFI8=;
        b=ChAnyI5DMPxqNE2O8U31y0PskhYmXl8VkqQ9g1BYOqyntG0jv9SppM96uvjxFbBG+q
         lp10pQmVoHF41M99iToEAHHeJ6+FwlLWS/h2NcQfLMqwHO8ME/bg3mAau8bCcgKptZ++
         EEOB42vEOyslYejTeE2+//Z7q85SlXzpTOfyUW4Ps7/dyy0cidEGnJo9g6d3g0tCNdE1
         K9x49k3MVZlsmWnWhJXZnxPv1g/SRcFuQkTRrg2sy5uEmrrCiJ4JV4SLKWareBezD6xW
         U9OZpleO403aqZlzvGg6JJlh4OyKQRmqy29E1Kdqt6aEcvY7o71QTQeNJWnvFu79+yD5
         U1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398618; x=1709003418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=981KgcDEWu0cp8w2YBjuMYv78Dw7iGFDfkFmvYcaFI8=;
        b=YyvHvGIrUG7XQUSOR9d3Te0GlRPxyqYyeiVmvccf0djqa26CXdpYXmd3GpW4rs4ojP
         h609S5uKgCvPXd8EBIdkU4cNGecUyqJoPQqQDSiVVUwKPV0RL0ddosZcMme1CLEEKr3H
         gw4NMGSV1eOyk/Awp9DoJqed4iELHAxm5wr6VaD8g3OSGyWhQyBTLfjk47p2kibNDZkJ
         M7cfCd2vDeMGu1alAZrF7zVjSkW5DlkhK4N3lt920T5bDWcNQBTPTlLpySzRq7L1dixY
         WxZBZVmjv/1I0+k4/7LDe7oWPPwaB60+cSYGMNlEPbxPKeHXgWlPnUyiRZ3neWMYPf0m
         kTRA==
X-Forwarded-Encrypted: i=1; AJvYcCVwnzI0kHslCfgqRzueMqyyaEU7GYP4Z1tuyYLATZC1rZI1T9UwbFlkAgXlgB35vkN46cG7gO7FsmcOOrLe0CIdOnDOUQdUrwQuZ20eiZCVP0cbIRg7sHMmIGszwTr2IL1wXYobs8Gtox/H30tdrtcxI4H/lNY8bi0T3yfBDZnLoJB1HA==
X-Gm-Message-State: AOJu0YwbHkpiUKyz0WldkAjyh9Lzhz53erjFc476C5JKySggEpb2qj8a
	nn07Y18mgHtr1wkY2LLnAtV0OO+UUZTv4RRrqtBxwGIhobNmcs0H
X-Google-Smtp-Source: AGHT+IGh/K1Gw6nt3yjR5+Y7Lvh2HpxgUnKIjZxAf221PtJHEHaunhI8NUHp3JWgmy2GEa0mEq/1Ug==
X-Received: by 2002:a05:6870:b6a4:b0:21e:4a2a:f058 with SMTP id cy36-20020a056870b6a400b0021e4a2af058mr15934161oab.18.1708398618390;
        Mon, 19 Feb 2024 19:10:18 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id wh14-20020a056871a68e00b0021e80b769edsm1679994oab.8.2024.02.19.19.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:10:18 -0800 (PST)
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
Subject: [PATCH v11 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Tue, 20 Feb 2024 11:10:11 +0800
Message-Id: <98b42a20f7f5a6938563b6a2ad839299ce3ab9fe.1708397315.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
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
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 48 +++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index ead1cc35d88b..e70c43e2ccbe 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -5,6 +5,9 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,sg2042-pll.h>
+#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
 
 #include "sg2042-cpus.dtsi"
 
@@ -18,12 +21,54 @@ aliases {
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
 		#size-cells = <2>;
 		ranges;
 
+		pllclk: clock-controller@70300100c0 {
+			compatible = "sophgo,sg2042-pll";
+			reg = <0x70 0x300100c0 0x0 0x40>;
+			clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+			#clock-cells = <1>;
+		};
+
+		rpgate: clock-controller@7030010368 {
+			compatible = "sophgo,sg2042-rpgate";
+			reg = <0x70 0x30010368 0x0 0x98>;
+			clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
+			#clock-cells = <1>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			clocks = <&pllclk MPLL_CLK>,
+				 <&pllclk FPLL_CLK>,
+				 <&pllclk DPLL0_CLK>,
+				 <&pllclk DPLL1_CLK>;
+			#clock-cells = <1>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
@@ -333,6 +378,9 @@ uart0: serial@7040000000 {
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


