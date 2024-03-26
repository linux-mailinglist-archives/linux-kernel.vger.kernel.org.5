Return-Path: <linux-kernel+bounces-119274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42888C679
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691D01F622D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2213C909;
	Tue, 26 Mar 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1NxEESc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDC13C800
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465987; cv=none; b=IaUckSDLsZiQ6n5ZyKvJWNIz8e2+WRLYDEOkA5FoSGIZ1hV3Yo1WaPthAEFTtYlMRGm1gQx5jq2HFPOb3AujXe5cfqqqSYtsaBcnGdwJZo8eREpnc9vSBeO+QG872Jgb749R29Gor+XwTszdicNPJguUVqw1ULRYnL9HmnmxkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465987; c=relaxed/simple;
	bh=VR15R2WP+377srHz2NsdR72PZk2ShcAumCvdNJ/OrpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTKfYrdAvBSNpdUcgUnBY9mI3xzhe1Fj+wlzlfOR8c3IS68f+GI9GXAUODIdzOGrbh9Mz/z3omoZgqhcw42mOJG7CHoZBzre8Ax0bQubKmYezYBvDup6Jn83Ls6Rtz1Kr3nDoVcWy5GCCFK1l7mdnJLdhTQN1xSCm5pSCFR+gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1NxEESc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414925ba76eso315655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711465984; x=1712070784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn9m+1lA6AcpZGbpMknvvS6Xp0LvUkbLedZBp4mYCns=;
        b=L1NxEEScKfFmYVoLHmUItezgfxlAsSZzhoGK6TUj7X2onJ81++UxVkyjd3gkFgLsjl
         Me2UsnFfs5q6LW8eaZe8jqDW/jFK/Y2M2tF2d8cJ1q4sNjFY11saNbZvbkW7B7DiPHuI
         4mwO4qQpNjvZlk+p8XCAr2u9Ee7aFoiiofxbDLtHlvw4OYjVEU9TknP4BA66BCjyDpim
         oTdecwkb0Y15YgCvgV4BasGXKutz033WnJX9jwTFRr0ixkEVcwBq4bFXNLAMUPZ0xEiL
         XoQLiVHBQpoFm4hou7so+Br1LxKoexDlKmuJV8gmDSm2sEVGH9xqop9LqW1T4vWVMBFo
         Ai1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465984; x=1712070784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn9m+1lA6AcpZGbpMknvvS6Xp0LvUkbLedZBp4mYCns=;
        b=D00mpsnVkY7sN0UsiI8QYjyAOP82e9N+Acre0SXMISbjbUPGWdv+E9Ss2j3N4BhSUw
         kmOTS0BdUlC/IoI1V8nh4wUuucMXyfbz1SFnF85NFbHK1h1GrCqSz85spTnQERdchaPr
         TxwUOutWaS2YrfNygk+G36ysIvhzRwJ1LPdBatVmBR55P6et28afekvWfBGW3WT8OHoD
         bSKOZNoYl/SKDQvHoTPdZ1+It8QmS9dWTYgnb4qwzVHvFbquxarEZkz47479MluvO8s3
         PTzYYsrc/kC2AF0dEezVn9natLHDNfVk+bteJ95oqbGwu/BQ2gg1FuMnHx6e7fOsNhu6
         vGEg==
X-Forwarded-Encrypted: i=1; AJvYcCW1rzrHHWW5aSKJOEQ9HsAQPrUVEYOrMwq1THsr4bCyuDg3PhBCsC3ean89ML32WLdNQ7pJFtL3pUgim7CN9Ylrq1lE4qHewzB0iH/R
X-Gm-Message-State: AOJu0Yx5A4AVKZppqbMaM4eq1zhSi+c05SgnJ+lfydGeEBez5rHWH5ni
	YtX+Ip7sviZuaiqRBLNIGMlKbyWoKduh+ajSXggeLZtMjPBIuQpAny6ZCDpFl2o=
X-Google-Smtp-Source: AGHT+IGB7lFBQVEWs59x6w/DBERXvC6mjvqqcHglQjnQsaK6/Fp0y7bhjtErhQrG4DXYj7M5YgXYqw==
X-Received: by 2002:a5d:61cc:0:b0:341:be75:5e6c with SMTP id q12-20020a5d61cc000000b00341be755e6cmr1297348wrv.3.1711465984474;
        Tue, 26 Mar 2024 08:13:04 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b0033e7a204dc7sm12325692wrq.32.2024.03.26.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:13:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 1/5] arm64: dts: exynos: gs101: reorder pinctrl-* properties
Date: Tue, 26 Mar 2024 15:12:57 +0000
Message-ID: <20240326151301.348932-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240326151301.348932-1-tudor.ambarus@linaro.org>
References: <20240326151301.348932-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

The Preferred order for these is pinctrl-0 pinctrl-names.

Update the DTSI & DTS accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 4 ++--
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6ccade2c8cb4..40de2b0aa086 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -29,8 +29,8 @@ chosen {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		pinctrl-names = "default";
 		pinctrl-0 = <&key_voldown>, <&key_volup>, <&key_power>;
+		pinctrl-names = "default";
 
 		button-vol-down {
 			label = "KEY_VOLUMEDOWN";
@@ -103,8 +103,8 @@ key_power: key-power-pins {
 };
 
 &serial_0 {
-	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_bus>;
+	pinctrl-names = "default";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 55e6bcb3689e..5868c96c771f 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -393,8 +393,8 @@ hsi2c_8: i2c@10970000 {
 				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-names = "default";
 				pinctrl-0 = <&hsi2c8_bus>;
+				pinctrl-names = "default";
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>;
 				clock-names = "hsi2c", "hsi2c_pclk";
-- 
2.44.0.396.g6e790dbe36-goog


