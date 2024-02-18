Return-Path: <linux-kernel+bounces-70424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DC85978E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23E31C20A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CAC6D1DA;
	Sun, 18 Feb 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VM2aNk6R"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9D6BFC6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269245; cv=none; b=ATvtxtIvcaM4J+z9s1N2Fjr//lj46KLp98+qX0lEo7GOb1pDlJLc0IEayi6D1k8zT3rZh4pIKEr5XAeu5BJEwmP5fDpoPk+nOBT/3vvhs6jmmxhCZgfbq+8bajmEjmaKOev3GAEJtuGuru43KYT+juNMP5fZq0GYPvkcPL9Sxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269245; c=relaxed/simple;
	bh=H/zv3C2CZW90tPZxYHeGW7zgfgaSRZPYhb1fQURgdAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n37zXDCNUvBwGK9H1Yb0MKf4bNeRa66D4P2Uf6vyu1ze4SlBql+YdC6DCi/cscdB+OK9GHJ55MpGu5h5dHJnhXEci0WOYaKYbQ7IckQr9pzzueID6c3Rm7YSPeLBt2/De6/ju+EYKP31B6Pixl5+8O0nS/Ml9T1UbhLUttX+Rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VM2aNk6R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso15865215e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708269241; x=1708874041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUVUdAZbUjy9PIf6dchfSb+esF5ISu8GKcQonMOR4P4=;
        b=VM2aNk6Ra1FZrytl2GO2hvpYVrHLrjrqiWXI060997d7qZvoDe0Jo38Szcg7sqx8n2
         eKzofLTipHwJenKF8OM0ZJMi+kT8y1xTxaV3z6KR21x3f56eIvjk/RDWqKWzUGn3cacL
         PfdLo7i8vVrCUdMcIzVltCN5kgJ6isOoYffX80oiB6wzXIyVeMOad9YM80nEjAgA7zrm
         gmhA3esT7k/zxfxJUbvCAdyuDDmfMwngsyB/DvKBfLSL3Q/Bsk0fCMI6Q9QwWEYudjek
         jqDj1BVW4lz1zvyapNnhGUxAC7cee0SkwOSqtXM6E42nHM01xxQ/gTpZ6GL2uRbTxtrM
         Cabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708269241; x=1708874041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUVUdAZbUjy9PIf6dchfSb+esF5ISu8GKcQonMOR4P4=;
        b=Ehe+j7c6yGBAnjVBlY8+CPqx7gu1KdlBTXTWJL///LKnsUNH1hmsGgyVoN6Pp0S7Rd
         60VMZzBC4Bp4WYEodRsZaEIht9J9E9urtRMk6tJwFWKab4g43+XbSH4Aqy+DRTw5OOHM
         eMu/Q99WXyxMeBXdfMZBfVbVmaXB0XGNOaLM6vbNIHWLDx0l0+ux8WRnoUSAqwkUC37S
         YHSMle7BrZuo10r+imXNCZLmZEZILf+o0U6vUfqVmct3EErEVaQLXwIO/2FqfZmjOKq1
         5yOPmFte/YqDAlakY1MV6GMwyAfzlQLmrTZ7npP4mvy48cfNp7A/MPAR29S3LqhzfcA4
         y+kA==
X-Forwarded-Encrypted: i=1; AJvYcCXhvwoAtjxgCHMg+XyKgJvYEEyPp5xeK0wcGA6ggyxWXFENH2nFvBJ0Qkg4IxoLDkCbruQGYLdbbIG+mF6eK0PEDj1DkNnUvFoih9ec
X-Gm-Message-State: AOJu0Yzkn59QNp3ldsjJ2sTaREs2FrV41PyYOgpCWsHT7TbLDnSRH8Fz
	KqTUJ+EwfY/vBe6794YCDrZspqSd1meyPeQT2u/YBGGfRJI6mcu6F+PGmJLLTFs=
X-Google-Smtp-Source: AGHT+IHPY/uYbUsFh8NAHBidCxBRlYJWKA3yPNIeNzU/Hvd+FQ/6eB1Ps/L+ZOzOynGdFvmYV+vBDQ==
X-Received: by 2002:a05:600c:46d0:b0:410:3ffb:87dc with SMTP id q16-20020a05600c46d000b004103ffb87dcmr6994676wmo.35.1708269241669;
        Sun, 18 Feb 2024 07:14:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056000079300b0033d3d9447e3sm2150744wrb.83.2024.02.18.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:14:01 -0800 (PST)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 2/2] ARM: dts: microchip: sam9x60: align dmas to the opening '<'
Date: Sun, 18 Feb 2024 17:13:53 +0200
Message-Id: <20240218151353.3612621-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218151353.3612621-1-claudiu.beznea@tuxon.dev>
References: <20240218151353.3612621-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align dmas to the opening '<' to comply with the dts coding style,
indentation section, point 3: "For arrays spanning across lines, it is
preferred to align the continued entries with opening < from the first
line."

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 64 ++++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 73d570a17269..291540e5d81e 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -179,7 +179,7 @@ uart4: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(8))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(9))>;
@@ -202,7 +202,7 @@ spi4: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(8))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(9))>;
@@ -220,7 +220,7 @@ i2c4: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(8))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(9))>;
@@ -248,7 +248,7 @@ uart5: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(10))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(11))>;
@@ -271,7 +271,7 @@ spi5: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(10))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(11))>;
@@ -289,7 +289,7 @@ i2c5: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(10))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(11))>;
@@ -377,7 +377,7 @@ uart11: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(22))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(23))>;
@@ -399,7 +399,7 @@ i2c11: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(22))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(23))>;
@@ -426,7 +426,7 @@ uart12: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(24))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(25))>;
@@ -448,7 +448,7 @@ i2c12: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(24))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(25))>;
@@ -583,7 +583,7 @@ uart6: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(13))>;
@@ -605,7 +605,7 @@ i2c6: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(13))>;
@@ -632,7 +632,7 @@ uart7: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(15))>;
@@ -654,7 +654,7 @@ i2c7: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(15))>;
@@ -681,7 +681,7 @@ uart8: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(17))>;
@@ -703,7 +703,7 @@ i2c8: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(17))>;
@@ -730,7 +730,7 @@ uart0: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(0))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(1))>;
@@ -753,7 +753,7 @@ spi0: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(0))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(1))>;
@@ -771,7 +771,7 @@ i2c0: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(0))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(1))>;
@@ -798,7 +798,7 @@ uart1: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(2))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(3))>;
@@ -821,7 +821,7 @@ spi1: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(2))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(3))>;
@@ -839,7 +839,7 @@ i2c1: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(2))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(3))>;
@@ -866,7 +866,7 @@ uart2: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(4))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(5))>;
@@ -889,7 +889,7 @@ spi2: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(4))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(5))>;
@@ -907,7 +907,7 @@ i2c2: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(4))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(5))>;
@@ -934,7 +934,7 @@ uart3: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(6))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(7))>;
@@ -957,7 +957,7 @@ spi3: spi@400 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(6))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(7))>;
@@ -975,7 +975,7 @@ i2c3: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(6))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(7))>;
@@ -1057,7 +1057,7 @@ uart9: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(18))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(19))>;
@@ -1079,7 +1079,7 @@ i2c9: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(18))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(19))>;
@@ -1106,7 +1106,7 @@ uart10: serial@200 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(21))>;
@@ -1128,7 +1128,7 @@ i2c10: i2c@600 {
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>,
-						<&dma0
+					       <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(21))>;
-- 
2.39.2


