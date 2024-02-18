Return-Path: <linux-kernel+bounces-70166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51A85943E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714D61C20C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387F17FF;
	Sun, 18 Feb 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5bxRjg5"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CE5677;
	Sun, 18 Feb 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224756; cv=none; b=SxicewdjO1mJadeTJdrNtUwfc149TEH+Bv82qjG1eHJzFZmue2B4f8qMlW08dCYiedJD2ECXyZHM3XpBdfY14eDNVLiL8Rpptc8aibf7Niywn4npita+2b2z9wZuGeDWhK0DxP28Kh6/wA/wAKKL4SvQsKvZANOSgmUf3EIxm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224756; c=relaxed/simple;
	bh=FePf3EyOVTsisp4gCWFACVV6RZHdDOhtdVjERgnF8VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfgLZUlpzWKuA3veQYIlsdkW/O3pu9iwhK/EXEO7DVUSr6PrrlAxj+XnFgWHFsOGKO7f+vu+8xHw+OBgg8Akv+9gcfCPKgvKb+rSYAFaLjm9XVFUBlAyTmzWausBYsxtkducNdODLQDK47XXcKTnVMghCUm/guNg5tuKVkJTfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5bxRjg5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2e6b405aaso1149259a34.3;
        Sat, 17 Feb 2024 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708224754; x=1708829554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3n19RkNDdq8dbMgQjlCr52ofvg6XvVFhLZ4eyMaEeA=;
        b=V5bxRjg5icsIEz9KlHXReDIXuom532qoIVtJDvwaqkaq9zgRBIjbAzWkA2bvBFE2QT
         xg+/XZlnG5pSWCD6vu1UoNhT7ScyUi2PPlvc3K7anWAIVUi/bS6teL1m1WgSe+sj1HF2
         OqCP1vI1Ej6zZ5zEx6++ixDFKo1uH5dQH8l7t+WnURVleoIHXCtLPLAaXcEJNQUv9NX6
         tJ1CicPVIbnq6dMkA6hmSJzf2VLePZwvfv2mDdSvcKXoIFozPWwXLVtNiyzmFhmGQp41
         WRPBihXbHb7ZFNSG3+L3jmlj8S9xF54p/7wY/leXw5RnW0VJGo0R1iEqRM7RdkQw7Kqw
         wJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708224754; x=1708829554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3n19RkNDdq8dbMgQjlCr52ofvg6XvVFhLZ4eyMaEeA=;
        b=ZWUjR9B4E6QtHzED6vpjIeUqIBS+9kkyY4EcudOaNal6/LTzo8YrL6W+mCFCDD03jP
         qpQz9ssbK4u3SUDopWw/RLNsyt/xIaaniQcDTW85ZE/Tb4k80VYmAbGcf7IBErlLs2g9
         IoLSGQHF3DwnALnVW/FBh+cstdMih0UZhD0JqMW7Z19kbkWQRxYlraR4cFSYmiKt2R4x
         h0ufDAUaChdv+kj/XHm3qKPil4VVosSCMvS+K9n7gzjsd9WX/lNH+irW+/R8In40fONt
         MJNBmKjtEHGVs3CJT+X0O6oL9j4eskWXKiZjzWvulgYZW2ouul3fehUX3Gxbe79HLLzi
         /a6w==
X-Forwarded-Encrypted: i=1; AJvYcCWn0ZTZroaNbLhdBc8UDKv1AyMDdzBbJUGj+g8v33YHWg+J4iJW6YD0tNsCfLHPOqmZMNUZx/j+k7/A8sxm0pI3g4bqIQi3DqNF5UxZW6YBtj3IqIpm2N+Hjo5lKbfAbOCG6zZhVpNObYb2tAaZV2OJQHmWBru+nkpKjm8Iux5CVmcFYw==
X-Gm-Message-State: AOJu0YyhcTO6rDavHCcw72gt9Zb8vE0lwvZ5kSdIZ7bDMEYr1ATjVfUC
	RTKX83f4QR0HdnxjC4PO8q1zE3Wb1tiVh9zfM8psGGuWIxw7ieHv
X-Google-Smtp-Source: AGHT+IEeVIqfdYbflCRrTg3/7Jkh/cxWMWj69qHzmn3fE+cLdGKkNtKHAdwy21byuai9OMmNLmxB4w==
X-Received: by 2002:a9d:6415:0:b0:6e2:e50b:7ac5 with SMTP id h21-20020a9d6415000000b006e2e50b7ac5mr8331462otl.17.1708224753896;
        Sat, 17 Feb 2024 18:52:33 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id d7-20020a4a9187000000b0059d97d9f75fsm549603ooh.14.2024.02.17.18.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 18:52:33 -0800 (PST)
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
Subject: [PATCH v10 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Sun, 18 Feb 2024 10:52:26 +0800
Message-Id: <dc899c89e5c30e2267965f185b52d6dded4eb1ac.1708223519.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708223519.git.unicorn_wang@outlook.com>
References: <cover.1708223519.git.unicorn_wang@outlook.com>
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


