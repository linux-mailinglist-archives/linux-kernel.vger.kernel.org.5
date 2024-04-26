Return-Path: <linux-kernel+bounces-159472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9B8B2F04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128241C225B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C07828B;
	Fri, 26 Apr 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeefcGHs"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7078C7D;
	Fri, 26 Apr 2024 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102551; cv=none; b=kcHdiluA6MmDJaAvKC6xW6T80QbRa42KXvp2zpEnP5Re/44e85AZ+NSSBOvsSLJNA0PuTWI35T/eJ1Bwph98RTeqRCHtJgFv7jNXG4JITbj9CdhObJrHyeV9EyCE6bvoVcyYsWHL2vVd30VEqtXyzRaZ6E487if2WsJbfdSIcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102551; c=relaxed/simple;
	bh=HYy0uBIq7a4XYMVsAB46Cm0zvk1JrXNzFX9UbTeng8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ph46KsnQ4bjpjTQcW7fy2Qso1o7pcHurxHXWGgfXvtoAbpPBQyH7kIZR+cRwXxAiZPxyFAdZB+kneNcSCV3usatypYcxajhF2qtAs3NHZ6IrHAo/TzhWC5YNf7+8jtOhtbPeIfUeHURuZ5X/V0DT8kM8PMYm3Mo4W+AcVC9n3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeefcGHs; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5af27a0dde1so1048705eaf.3;
        Thu, 25 Apr 2024 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102549; x=1714707349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXXhn+viEW5QNpw1s0JwBzkpEksiOVn61xZJPP4n0t4=;
        b=SeefcGHsE5FY6/HsWwbus2q+0IRzCSsNhHwGX/whvQ+7PYOEST2JbHQ1svVi2E8ewU
         SBBQlr8GeVehKk42vLyM/JJBlXiEE9wCruik8zghFZj9fi3FJZBCA7ybrsT+T/kkLl9H
         9O07VG6ioPszTlaaSjKULLkWWZJ13HMGnKL0ErM//W4EAy2TRvOiZv/GfRDxgGHHwtoQ
         0OG+v3UEGCENXeDs41tuqkWykWkzytTMWrCROsB8x+xq+JyHiwVE6T0RsfZ2ZfrbXfoK
         shSfaHgYitrlwu8M/PR85AxggYAHRbpeGNt+Yl/DFlJYdbDKL7HodRv5KgAM+wzWygXI
         xt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102549; x=1714707349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXXhn+viEW5QNpw1s0JwBzkpEksiOVn61xZJPP4n0t4=;
        b=Upu4OI2WZ/CKZmU1EQUB7ZF/RrOtZtVCLmKKaN2l7jHbXJje56FU3a7282GE6fHBSR
         oABUd3rb59V72YLExncBuRs8XPMKo1OpKMErsuXv37ahZSIY7o6St6wwtaLxMq4BWVa6
         T4QEvnhs+25hnwVMxrAHvg5QCZkkcmNbH0RR9qXXE7K/HUtL0oWlUNFl8IVR8cMdlO+W
         ePnwCKgNL6mb/vlZsYSgAGDuMGa/N6DBonMn35ZfvWGNK4Wv5VVo25ECTzrjdsMFQbCH
         5sy4D6c1Pzg8iVWk38DDiJqpqGdEARp5UZd33QHGQ3v48+GhQluz3kQvbIAUFYtge9ch
         pw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV99CM1ldWabD5D7wMr0XhV4Jh5AoZLM6zjbHcaMCreK6ZH6QjPeLazrILQjf6o9yd2Uy9kWmHhFdRC5lnTmIlnUYdRUjoqyJlpc1ni4IXi3xCYjcbcVBuWsdxZ5B0tz495jIpH4aZ9z8+26/T7ftvtMGtmkrMzg8cA1KwPSvYqdXP8fw==
X-Gm-Message-State: AOJu0Yx2paOWg+ejNA5VlyzuHFna2fZUoqkI6vhRRJt1H6sWDWXJ4kpq
	ROXsCz79ta+CHg15R6k/9H9M44C3fKR477brT6sdMWc0BHydUKMD
X-Google-Smtp-Source: AGHT+IEX1Yl4DmsmzzdNoNze02IpPzWs9NOhtIoV+GjVXyhjDg3kt28K2sha83urXPLmjFKuEKK36Q==
X-Received: by 2002:a4a:98ed:0:b0:5aa:5206:30aa with SMTP id b42-20020a4a98ed000000b005aa520630aamr1882521ooj.7.1714102548735;
        Thu, 25 Apr 2024 20:35:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a09c4000000b005a4b2172e48sm3669565ooa.41.2024.04.25.20.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:35:48 -0700 (PDT)
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
Subject: [PATCH v15 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Fri, 26 Apr 2024 11:35:42 +0800
Message-Id: <165c49ca3823043a14420e3001c2657f0a1b9802.1714101547.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714101547.git.unicorn_wang@outlook.com>
References: <cover.1714101547.git.unicorn_wang@outlook.com>
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
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 55 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

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
index 81fda312f988..34c802bd3f9b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -4,8 +4,10 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
+#include <dt-bindings/clock/sophgo,sg2042-pll.h>
+#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-
 #include <dt-bindings/reset/sophgo,sg2042-reset.h>
 
 #include "sg2042-cpus.dtsi"
@@ -20,12 +22,60 @@ aliases {
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
+			clock-names = "cgi_main", "cgi_dpll0", "cgi_dpll1";
+			#clock-cells = <1>;
+		};
+
+		rpgate: clock-controller@7030010368 {
+			compatible = "sophgo,sg2042-rpgate";
+			reg = <0x70 0x30010368 0x0 0x98>;
+			clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
+			clock-names = "rpgate";
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
+			clock-names = "mpll",
+				      "fpll",
+				      "dpll0",
+				      "dpll1";
+			#clock-cells = <1>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
@@ -341,6 +391,9 @@ uart0: serial@7040000000 {
 			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
+			clocks = <&clkgen GATE_CLK_UART_500M>,
+				 <&clkgen GATE_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			resets = <&rstgen RST_UART0>;
-- 
2.25.1


