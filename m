Return-Path: <linux-kernel+bounces-116676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105F88A272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C229C1C38BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518B143897;
	Mon, 25 Mar 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l3uGXkjs"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505A137C22
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353408; cv=none; b=h+9ipK8t3IxPpAHBh2/ZCsaUpa53yEnhZd03WhdFLOpAWn6iPrzvLLdA7T/k/4Wxs11FYXCSSzt9udqZXFNqQXLMkEZrHYvSQE9rC/7BglCXxdVxrjWxTAqrTHlo1El8xYHF5bV18qCfXlCvMNz9vXyCyruN6GPSPzFpAZq4clU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353408; c=relaxed/simple;
	bh=A1g9JztB5Pywe1EJsKY+CQBGaXRMW2hC6ZpyWTRjSnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0u7Wrnaxo2bWXHduxD1CTOoXUO3BMA7T6X/8l0jlP7qJOqOgy5bIQiQPkZNdItJtvhSXldoHm0kXu9AuIHhKABnQxRxIneB+tRnGhsfY9CfAyYtbRrbxl30D9yzXR9l7bwO3avH4I3RWDhQbly83wRWEOGTyU84w9cTrRNtUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=l3uGXkjs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c0652d37aso1564298a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1711353404; x=1711958204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a89LEVm7xD3V3aipTuTByCc7qaD6TInwfvfX/3rmr3k=;
        b=l3uGXkjscBHFukOlvOmsm8G4dS35a3QXA5h9XUa6LvhZiksqPGbbNKLfVmrMmLjX8l
         adCbtJ9weEP1OC0HqkiCtwVGXF5itcEJUREuPsQbfiXHEorfTrEZTH73K4iWwWGtHuIm
         V2hTEAT7aZK5LcoNAltI+WDxz4oVhugnzk60g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711353404; x=1711958204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a89LEVm7xD3V3aipTuTByCc7qaD6TInwfvfX/3rmr3k=;
        b=wi+30/tJBFbkDB4nkvhZ4uUtbj8vXZDs6AZPw5XHgX2l82xRVX7q6olFQ2q71UfQnm
         gi9SQNZnkKO8/IG1WepVYjPwRk/RyMxvPOBY/EhpmyPNvgBuKUhm9rjIi376l0NaMICS
         rdAsVb4UaGkTJLXpC9j2X9AsdBGpziNiQWuz6GXrm0dPiOBvVI2FS+s3NugvERh8NrVo
         H3MQervAH7Mc1O54FhJHMmfP49cKBD+/h0JDHmxG8pwEKhFgFIwBE6NgjA1ZvOwN6zDX
         sM1yCC4QoWdv7dlTP+ewQiMSErdZCLb4Z7cAKm/et+uqZOmvKn0uHVNrB4jFVMRiJPwN
         Iy/w==
X-Gm-Message-State: AOJu0Ywt9tX3dvHwXcEEA2OCyzxx7E8V2yeVeEeGPuq0Qj+K+qhBzfAj
	cSJA4TdZpa3q9JZ8RTuAJuBMMhSRGUk6pMBLU0Lo2ICSP+X4s8cubncznzX3gHsV8rv+jYXABQg
	As2Y=
X-Google-Smtp-Source: AGHT+IEeee43tChvxvBZH14MFQxubrof2GweXWpHdJI4TLqNPXlTq1m6/KkDZ6ZtyycHFcrYpdLjtg==
X-Received: by 2002:a17:906:b786:b0:a47:4145:3598 with SMTP id dt6-20020a170906b78600b00a4741453598mr4172639ejb.20.1711353404443;
        Mon, 25 Mar 2024 00:56:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-8-99-67.retail.telecomitalia.it. [87.8.99.67])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170906adcd00b00a4750131edasm1661001ejb.206.2024.03.25.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:56:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: move can3 node from stm32f746 to stm32f769
Date: Mon, 25 Mar 2024 08:56:28 +0100
Message-ID: <20240325075635.1382911-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to documents [1], [2] and [3], we have 2 CAN devices on the
stm32f746 platform and 3 on the stm32f769 platform. So let's move the
can3 node from stm32f746.dtsi to stm32f769.dtsi.

[1] https://www.st.com/en/microcontrollers-microprocessors/stm32f7-series.html
[2] RM0385: STM32F75xxx and STM32F74xxx advanced Arm®-based 32-bit MCUs
[3] RM0410: STM32F76xxx and STM32F77xxx advanced Arm®-based 32-bit MCUs
Fixes: df362914eead ("ARM: dts: stm32: re-add CAN support on stm32f746")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/boot/dts/st/stm32f746.dtsi | 17 -----------------
 arch/arm/boot/dts/st/stm32f769.dtsi | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index 65c72b6fcc83..2537b3d47e6f 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -257,23 +257,6 @@ rtc: rtc@40002800 {
 			status = "disabled";
 		};
 
-		can3: can@40003400 {
-			compatible = "st,stm32f4-bxcan";
-			reg = <0x40003400 0x200>;
-			interrupts = <104>, <105>, <106>, <107>;
-			interrupt-names = "tx", "rx0", "rx1", "sce";
-			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
-			st,gcan = <&gcan3>;
-			status = "disabled";
-		};
-
-		gcan3: gcan@40003600 {
-			compatible = "st,stm32f4-gcan", "syscon";
-			reg = <0x40003600 0x200>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
-		};
-
 		spi2: spi@40003800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/st/stm32f769.dtsi b/arch/arm/boot/dts/st/stm32f769.dtsi
index 4e7d9032149c..e8cbb99e81a6 100644
--- a/arch/arm/boot/dts/st/stm32f769.dtsi
+++ b/arch/arm/boot/dts/st/stm32f769.dtsi
@@ -7,6 +7,23 @@
 
 / {
 	soc {
+		can3: can@40003400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40003400 0x200>;
+			interrupts = <104>, <105>, <106>, <107>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+			st,gcan = <&gcan3>;
+			status = "disabled";
+		};
+
+		gcan3: gcan@40003600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40003600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+		};
+
 		dsi: dsi@40016c00 {
 			compatible = "st,stm32-dsi";
 			reg = <0x40016c00 0x800>;
-- 
2.43.0


