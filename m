Return-Path: <linux-kernel+bounces-58087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6E84E121
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F75FB23F58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E97EF08;
	Thu,  8 Feb 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VVcZ4GfE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5A7E59D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396261; cv=none; b=Regxyeu3DwgkvbX5ifbBlCZKChEJXtad/UpFxQ9Iy6MWSgmD3bRlVOvjb+z+lLl+bdIG6TdBVaXnvNULKIGpdIcT6+z4U/+gb+ktQ/jfdNm/I40x1VybHYQBRSyAlrb9k2KY/prJDi/5u+6jTZkUtukUdO2NWIl0+R+43yVDzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396261; c=relaxed/simple;
	bh=dKiLPHEJqEKqUnVf0lz6gCePZTKCt84dEy249ZdO6ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gzm6LAY16Iw8rqhDyqK10Htn+rb8COsu2J5m4hHdGquUMWi5KH0C7mHcK15kpId6sYqOnYlppMaI6qG0b+oDRUG7R+6P8B4e4/OX5WFQPpA0/eerLz0xNi/QcSKgMxiUqk9NhYtfFIxfGoSwEb/1nezoW8YqUutjEBnfm9L8nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VVcZ4GfE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116b017503so1582160e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396257; x=1708001057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5vDPFCyu4dKHPbIjfPJAR8Xl/z+7tvbrj2jQ3PSyCc=;
        b=VVcZ4GfEkQuP2QAMGuyY2Hy7zBxnvJrt8N1xDIvI1Y5nzHyVIRpSI+M9QXZqiLyNS1
         uwLVdHpc4cJHH0+U0LSi9hp945l6TxoeQYDudfXyoToyio7PzbWeLzQiBFViCbmeKjxF
         1MgQJkIquFKtV9ljU/CpxvNqDIKLWwVTC7LBSpUbZcEsxazeL4gESAn9kfPcSkHILy5K
         TP142r6DKnCg3qofIi3VLY9wqJnldnCv28+TunzXC3ZLegzjfD8aTTeFPy9gmDyO2Q/Q
         Zd4R0fUqOGwNNP6c8M00OOqszGurogTQ1Roa4FniqSEEDqJIuwiCABIYO1vN98QvX05r
         IW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396257; x=1708001057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5vDPFCyu4dKHPbIjfPJAR8Xl/z+7tvbrj2jQ3PSyCc=;
        b=Cz55B/Ba2tOfpi5MRLqK9puw4bBm/KfNauUftqWrAivhDAPJapHXQORc9GFP7G+pT8
         0ZvyxEwWFbJr4R+hRk35nS/Xq9GqGPFdEmUCfGSLIjsJvFzZAyRJYMuqwtHXI9FBz234
         CWF79ReCNHDmW1n2zqdeyEbye3epMldY1JZzXVvvFC5qxT4uO8h8C/R4q/IyY8r61Qel
         rXY00ZUAhH9Nu26s2MNmOfltziIH2zehxi//zRWbs50dcLFXO0ibsYRnVu39DU285V4e
         Vn2wRQg2anVHB0vrk5dHNr5rV3hIYgogUIst8DGhyMCz3iaICV+vUTswFL3YjBqBiaAe
         O5og==
X-Forwarded-Encrypted: i=1; AJvYcCXhybDybvQJr4+mXs4XYquFMvX+HuwJyYUqjlmv5F+eOtorXWCdUYqRHl8UV1rnEkbzgYeqk32aheX0EvE+QuauO3TaK3RlgY6IGX0t
X-Gm-Message-State: AOJu0YwlDhcHwRi52x+xH70590CW8+sSPFh6Nm2Xid3byF3ihrcDQsuz
	/lY9yZfq9ttl8IFLIXIvLRhHLu70cJx504lf6x4b5VYHoIQzuYJ2TEpNk3yJtIo=
X-Google-Smtp-Source: AGHT+IE0anga4wAVIHQGEO4kwt+FmMR+rPaVN3o1P4uZfxRfc3g4Ix7xiG++qj052jif9TxDdYe+Sg==
X-Received: by 2002:a19:7410:0:b0:50f:18f7:855e with SMTP id v16-20020a197410000000b0050f18f7855emr5896888lfe.39.1707396257242;
        Thu, 08 Feb 2024 04:44:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXE7c3sz4f5wWPPmFgkoRc8BY8A6X4pjg9pmgXzPlV8fvP2U6xbA+abb1l1nwiYJgCT7u6OewuD5z6gEJmGZPUtyVRvDWC0kOXVbIMjKhVhIu7ONfA2dsZB6vzVtPHreOtK1kFaVkBL2F98E3HbSsKPfa0OvjBiy/XBo0MDALyrxBO7WQKAVc1L8OVnpbdwAYDUI71K2HcIyTk5UimsmZWqzTZa+dJTkHkAFRa+ELtCDsHkoNMdDuF8iUfQP3cAmVZw5tqZJewtmvDUkX5XukL6Q25yUETVAYQHyZdbnOVTzjLnIUkc4tPhLwhrKsZIueQ4151kivB7MtT6ZOB0JWq2sHhvt1qe6ueKQdDWiqdpFsOleRXqlpUAVBJKphw/sQsYjG/xilfTzsEkquQd+WoD0gpXbKbxqVumkGEM/Q9WNogZxjRrtUyQJwdRf9TWFpmXIdNj4BXgnr25F7H2uwBW3+Qo8p3nOAp6pxpuNkFixHqt0oupKc0zwXpq2bQmnupyZufRU2Bqpi1hEq7REH/QsMPc9FYipFYJPU7L8077AGlwndFAz7DKBq7kJ5epoG8=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:44:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 15/17] arm64: dts: renesas: r9a07g054: Update #power-domain-cells = <1>
Date: Thu,  8 Feb 2024 14:42:58 +0200
Message-Id: <20240208124300.2740313-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
always on power domain as the driver has been modified to support multiple
power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 100 ++++++++++-----------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1f1d481dc783..15fc6e6f79ce 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -238,7 +238,7 @@ mtu3: timer@10001200 {
 					  "tgia8", "tgib8", "tgic8", "tgid8",
 					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G054_MTU_X_MCK_MTU3>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_MTU_X_PRESET_MTU3>;
 			#pwm-cells = <2>;
 			status = "disabled";
@@ -259,7 +259,7 @@ ssi0: ssi@10049c00 {
 			resets = <&cpg R9A07G054_SSI0_RST_M2_REG>;
 			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -279,7 +279,7 @@ ssi1: ssi@1004a000 {
 			resets = <&cpg R9A07G054_SSI1_RST_M2_REG>;
 			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -298,7 +298,7 @@ ssi2: ssi@1004a400 {
 			resets = <&cpg R9A07G054_SSI2_RST_M2_REG>;
 			dmas = <&dmac 0x265f>;
 			dma-names = "rt";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -318,7 +318,7 @@ ssi3: ssi@1004a800 {
 			resets = <&cpg R9A07G054_SSI3_RST_M2_REG>;
 			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
@@ -334,7 +334,7 @@ spi0: spi@1004ac00 {
 			resets = <&cpg R9A07G054_RSPI0_RST>;
 			dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -352,7 +352,7 @@ spi1: spi@1004b000 {
 			resets = <&cpg R9A07G054_RSPI1_RST>;
 			dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -370,7 +370,7 @@ spi2: spi@1004b400 {
 			resets = <&cpg R9A07G054_RSPI2_RST>;
 			dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -391,7 +391,7 @@ scif0: serial@1004b800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCIF0_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCIF0_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -410,7 +410,7 @@ scif1: serial@1004bc00 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCIF1_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCIF1_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -429,7 +429,7 @@ scif2: serial@1004c000 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCIF2_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCIF2_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -448,7 +448,7 @@ scif3: serial@1004c400 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCIF3_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCIF3_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -467,7 +467,7 @@ scif4: serial@1004c800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCIF4_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCIF4_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -482,7 +482,7 @@ sci0: serial@1004d000 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCI0_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCI0_RST>;
 			status = "disabled";
 		};
@@ -497,7 +497,7 @@ sci1: serial@1004d400 {
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G054_SCI1_CLKP>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_SCI1_RST>;
 			status = "disabled";
 		};
@@ -525,7 +525,7 @@ canfd: can@10050000 {
 			resets = <&cpg R9A07G054_CANFD_RSTP_N>,
 				 <&cpg R9A07G054_CANFD_RSTC_N>;
 			reset-names = "rstp_n", "rstc_n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			channel0 {
@@ -554,7 +554,7 @@ i2c0: i2c@10058000 {
 			clocks = <&cpg CPG_MOD R9A07G054_I2C0_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G054_I2C0_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -576,7 +576,7 @@ i2c1: i2c@10058400 {
 			clocks = <&cpg CPG_MOD R9A07G054_I2C1_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G054_I2C1_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -598,7 +598,7 @@ i2c2: i2c@10058800 {
 			clocks = <&cpg CPG_MOD R9A07G054_I2C2_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G054_I2C2_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -620,7 +620,7 @@ i2c3: i2c@10058c00 {
 			clocks = <&cpg CPG_MOD R9A07G054_I2C3_PCLK>;
 			clock-frequency = <100000>;
 			resets = <&cpg R9A07G054_I2C3_MRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -634,7 +634,7 @@ adc: adc@10059000 {
 			resets = <&cpg R9A07G054_ADC_PRESETN>,
 				 <&cpg R9A07G054_ADC_ADRST_N>;
 			reset-names = "presetn", "adrst-n";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -672,7 +672,7 @@ tsu: thermal@10059400 {
 			reg = <0 0x10059400 0 0x400>;
 			clocks = <&cpg CPG_MOD R9A07G054_TSU_PCLK>;
 			resets = <&cpg R9A07G054_TSU_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -687,7 +687,7 @@ sbc: spi@10060000 {
 			clocks = <&cpg CPG_MOD R9A07G054_SPI_CLK2>,
 				 <&cpg CPG_MOD R9A07G054_SPI_CLK>;
 			resets = <&cpg R9A07G054_SPI_RST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -707,7 +707,7 @@ cru: video@10830000 {
 			resets = <&cpg R9A07G054_CRU_PRESETN>,
 				 <&cpg R9A07G054_CRU_ARESETN>;
 			reset-names = "presetn", "aresetn";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			ports {
@@ -748,7 +748,7 @@ csi2: csi2@10830400 {
 			resets = <&cpg R9A07G054_CRU_PRESETN>,
 				 <&cpg R9A07G054_CRU_CMN_RSTB>;
 			reset-names = "presetn", "cmn-rstb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			ports {
@@ -796,7 +796,7 @@ dsi: dsi@10850000 {
 				 <&cpg R9A07G054_MIPI_DSI_ARESET_N>,
 				 <&cpg R9A07G054_MIPI_DSI_PRESET_N>;
 			reset-names = "rst", "arst", "prst";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -809,7 +809,7 @@ vspd: vsp@10870000 {
 				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_P>,
 				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_D>;
 			clock-names = "aclk", "pclk", "vclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_LCDC_RESET_N>;
 			renesas,fcp = <&fcpvd>;
 		};
@@ -822,7 +822,7 @@ fcpvd: fcp@10880000 {
 				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_P>,
 				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_D>;
 			clock-names = "aclk", "pclk", "vclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_LCDC_RESET_N>;
 		};
 
@@ -833,7 +833,7 @@ cpg: clock-controller@11010000 {
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
-			#power-domain-cells = <0>;
+			#power-domain-cells = <1>;
 		};
 
 		sysc: system-controller@11020000 {
@@ -859,7 +859,7 @@ pinctrl: pinctrl@11030000 {
 			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
 			clocks = <&cpg CPG_MOD R9A07G054_GPIO_HCLK>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_GPIO_RSTN>,
 				 <&cpg R9A07G054_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G054_GPIO_SPARE_RESETN>;
@@ -916,7 +916,7 @@ irqc: interrupt-controller@110a0000 {
 			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_IA55_RESETN>;
 		};
 
@@ -950,7 +950,7 @@ dmac: dma-controller@11820000 {
 			clocks = <&cpg CPG_MOD R9A07G054_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G054_DMAC_PCLK>;
 			clock-names = "main", "register";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_DMAC_ARESETN>,
 				 <&cpg R9A07G054_DMAC_RST_ASYNC>;
 			reset-names = "arst", "rst_async";
@@ -971,7 +971,7 @@ gpu: gpu@11840000 {
 				 <&cpg CPG_MOD R9A07G054_GPU_AXI_CLK>,
 				 <&cpg CPG_MOD R9A07G054_GPU_ACE_CLK>;
 			clock-names = "gpu", "bus", "bus_ace";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			resets = <&cpg R9A07G054_GPU_RESETN>,
 				 <&cpg R9A07G054_GPU_AXI_RESETN>,
 				 <&cpg R9A07G054_GPU_ACE_RESETN>;
@@ -1001,7 +1001,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G054_SDHI0_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1017,7 +1017,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G054_SDHI1_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1035,7 +1035,7 @@ eth0: ethernet@11c20000 {
 				 <&cpg CPG_CORE R9A07G054_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G054_ETH0_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1055,7 +1055,7 @@ eth1: ethernet@11c30000 {
 				 <&cpg CPG_CORE R9A07G054_CLK_HP>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A07G054_ETH1_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1067,7 +1067,7 @@ phyrst: usbphy-ctrl@11c40000 {
 			reg = <0 0x11c40000 0 0x10000>;
 			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>;
 			resets = <&cpg R9A07G054_USB_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			#reset-cells = <1>;
 			status = "disabled";
 		};
@@ -1082,7 +1082,7 @@ ohci0: usb@11c50000 {
 				 <&cpg R9A07G054_USB_U2H0_HRESETN>;
 			phys = <&usb2_phy0 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1096,7 +1096,7 @@ ohci1: usb@11c70000 {
 				 <&cpg R9A07G054_USB_U2H1_HRESETN>;
 			phys = <&usb2_phy1 1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1111,7 +1111,7 @@ ehci0: usb@11c50100 {
 			phys = <&usb2_phy0 2>;
 			phy-names = "usb";
 			companion = <&ohci0>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1126,7 +1126,7 @@ ehci1: usb@11c70100 {
 			phys = <&usb2_phy1 2>;
 			phy-names = "usb";
 			companion = <&ohci1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1139,7 +1139,7 @@ usb2_phy0: usb-phy@11c50200 {
 				 <&cpg CPG_MOD R9A07G054_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1152,7 +1152,7 @@ usb2_phy1: usb-phy@11c70200 {
 				 <&cpg CPG_MOD R9A07G054_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>;
 			#phy-cells = <1>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1171,7 +1171,7 @@ hsusb: usb@11c60000 {
 			renesas,buswait = <7>;
 			phys = <&usb2_phy0 3>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1186,7 +1186,7 @@ wdt0: watchdog@12800800 {
 				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G054_WDT0_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1201,7 +1201,7 @@ wdt1: watchdog@12800c00 {
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G054_WDT1_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1212,7 +1212,7 @@ ostm0: timer@12801000 {
 			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G054_OSTM0_PCLK>;
 			resets = <&cpg R9A07G054_OSTM0_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1223,7 +1223,7 @@ ostm1: timer@12801400 {
 			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G054_OSTM1_PCLK>;
 			resets = <&cpg R9A07G054_OSTM1_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1234,7 +1234,7 @@ ostm2: timer@12801800 {
 			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&cpg CPG_MOD R9A07G054_OSTM2_PCLK>;
 			resets = <&cpg R9A07G054_OSTM2_PRESETZ>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A07G054_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 	};
-- 
2.39.2


