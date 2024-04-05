Return-Path: <linux-kernel+bounces-133029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D572C899DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECCB28480B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927F16D4D4;
	Fri,  5 Apr 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHZT7Qfx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55116D321;
	Fri,  5 Apr 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321832; cv=none; b=pt13soeE2zL+SmvLTQbQxuI4KAXd6MPilmkC+SDcfGf+bV2s0A/v9xLdqCJcZlxGB8O7D93Xj4fopVivvvXlDs4Q2qVxbdFeYQfz0XZ2tm4p3VFyLt5JkQ47zXiV++h/OjLWU8yhlrDq5sCtBVEhvnT6PopBp+iugbKiw/WLT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321832; c=relaxed/simple;
	bh=yKgA9sAlFa4rhHcz5S8y0PWm6KRTN4dWIdDxEVAupN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2O+UAPSvIQ0s1FJBaWAl4LzfnQ+h7rgcYnoROxiyfte6lyKFIUHjqrWpk05T16UqYJ6iYI3DXNnrmsU1/8u/GF9Lk0NY5xNlEdYNCjVjw0ufknKXKu6/0Z3ApspqWrIOphyeYWJYCHdxvl8ldRkLVfUcXqNFUZrwzrUEO7ofX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHZT7Qfx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so1027658e87.2;
        Fri, 05 Apr 2024 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321829; x=1712926629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8PBrcXDQ2BEEKeipvNb0BLB7juYOf2uUh41C8OBtyo=;
        b=CHZT7Qfx0IXtKoLGTWbztDjQG4C/Ny86GU9yK6He+LVgy28oB1N1st6TP24OdutxyZ
         Y/2NEBvQMYHbTLoVQKzxn1Y0d4oAXLHC+YIcSNOPQBJPZpaF3pDUcRWFIkv18TebqOdc
         4dcidPkMGw3WBEtdOy58DKTaaraQIihT1CRSjBQyZ3L8nyzCtLCf39TuUJnER9EObSJO
         50bL+R62b2a7O2Mho9ihYS/Y8bt6/VRbslXxIn1LrkChoUSKZMlKJB9QmXEGLB4uuvUd
         zisugA4cWb1zxwr1mRRumi8lPDNzaNPKkQHf6WsWXw4oIU3ndqUz96aa9LbnDd/pzN3W
         pQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321829; x=1712926629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8PBrcXDQ2BEEKeipvNb0BLB7juYOf2uUh41C8OBtyo=;
        b=gI0knCauAI+poQ7h98w7yNcDf8TYffeM9MtUcfgTRXWHS3XMsiISEx+cscGRE7NpbJ
         pAVMddZL7F1RyWN3KB2kvnrdfW7a5fNXuESVzXvmVV0nCIZp9q3p3To9S3gnZdghu5OY
         iu4tMIjw6/4sCKYbye7qUxW3Q5u3a5+XlxB2tbVOzkUQ3bn9nX3P0UhL2J4hfNJEBVD0
         8GqKMfkTLjKv8HQ4Kpm9JyfUWNIUtBpwXxHB63y3ELIRzc5iHnuocpFRa7QUWw6W4r6L
         g6dHoZXfgk9J82A4g2L9itsRaobDDEh0apH/Ixxdvf3tbbVoVoNa7zJZV36GSwwgerAV
         GW7g==
X-Forwarded-Encrypted: i=1; AJvYcCX6cX/XxzVREfdf4DCbyNJSDh2f/9daVcjjKDxsjD/W6F36a72nHjxhU8OIvmyKae7kY/m3BMPwZ9hrGjTznTkr4hXB7ClIYjZd76jt
X-Gm-Message-State: AOJu0Yz/6gMCd1YDK2GRuoJPVWXubddKGE3YlMM5TgXCqcAPxntZugXb
	D5P88rsHRQTXZsIvtOXHpXTxJxfdYBLtbjqQwHQwAjcv8z8c0xJzN/B46Tdp
X-Google-Smtp-Source: AGHT+IHaZY4iKt9n3n3j/0D1aeU1Xk8VSlzUQa+bqB5aEtyH4fkDn/INz6NWvpT6EkAdWhtxPUNCJA==
X-Received: by 2002:a19:7605:0:b0:516:c696:9078 with SMTP id c5-20020a197605000000b00516c6969078mr864412lff.50.1712321829015;
        Fri, 05 Apr 2024 05:57:09 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id gx5-20020a1709068a4500b00a4e579ce949sm812121ejc.51.2024.04.05.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:57:08 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7988: add I2C controllers
Date: Fri,  5 Apr 2024 14:55:49 +0200
Message-Id: <20240405125549.11972-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240405125549.11972-1-zajec5@gmail.com>
References: <20240405125549.11972-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988 has three on-SoC I2C controllers that are the same hardware
blocks as already noticed on MT7981 chipsets.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 27098f724b7a..b4dc81881cc7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -124,6 +124,51 @@ pwm@10048000 {
 			status = "disabled";
 		};
 
+		i2c@11003000 {
+			compatible = "mediatek,mt7981-i2c";
+			reg = <0 0x11003000 0 0x1000>,
+			      <0 0x10217080 0 0x80>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
+				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c@11004000 {
+			compatible = "mediatek,mt7981-i2c";
+			reg = <0 0x11004000 0 0x1000>,
+			      <0 0x10217100 0 0x80>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
+				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c@11005000 {
+			compatible = "mediatek,mt7981-i2c";
+			reg = <0 0x11005000 0 0x1000>,
+			      <0 0x10217180 0 0x80>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
+				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
-- 
2.35.3


