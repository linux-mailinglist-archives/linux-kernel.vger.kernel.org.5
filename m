Return-Path: <linux-kernel+bounces-107308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F6E87FAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FB11C21BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0567E59E;
	Tue, 19 Mar 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV0DW5gc"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343697E0E5;
	Tue, 19 Mar 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840939; cv=none; b=McVrDqY9mBF07mrxCy1ZocOgNISxwFqPJPQIqnnTAVxaovFmrhUk3e9KnhAkOXP4a4LCzm9lT0GJOdN33r46zqDjG0gA/q7oqsQsYOX7qhAbwa1HOuM8aGpHWVKTdAViciQZRMVqSKHIegKJ9WlHcEBZGeodiftikMtmQ5bm5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840939; c=relaxed/simple;
	bh=cSwfBpuoJcFNSTaEm/gL66nsvv27NulapeoxSmeRZkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecHndU9xBDfaSx5+zfiQIvCOLn557g4cHal+erpBSpeqml0tBC1qKy832NkixymdaS/OtxlGCVcb8GldUCK+HdfzuxncAKDvndyYH5EwIy8dmezt7qKHN0hzDvfHm4IDk/taWpq9YUNg7+mK4rqOLNBhjqV/yTn/IXZci3szCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV0DW5gc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0511a4383so234025ad.2;
        Tue, 19 Mar 2024 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840937; x=1711445737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8lLJjV9sz++A3S70yTL0kgzPdOoYGF0BKRxiCCU5iY=;
        b=WV0DW5gcpteBmC4VeO2zVpJYGERpeD5wYyuL9hDF9xv+RPHdsPKziDUwMQkqatF75+
         /YI6Ba1CJQJ0eGKjM8XrrI9afgFnYhs59tkW5aXWxmlVwTetqxHLby076low6TZWwWoY
         UBA6mCwL5/H4HohfW2k2yxcf4QFPfboWluHoDwx2MtSpSHkDRKqfoBAKXTC0m7/PceCC
         VDenQQpru44x0qkADyRjf32v6Y9Fyg5mbI4tEWkLHmWCBdaIiXD3F2tPQdavseROe0iQ
         RURF6bl1Q1hKpuIjMm6gJ1bb040NFdK6191khm1glwyNHri9zt8aCKy2XstNtORiuJV4
         t/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840937; x=1711445737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8lLJjV9sz++A3S70yTL0kgzPdOoYGF0BKRxiCCU5iY=;
        b=p2n8T5yVHZnQgKiZpUk5UJB1vkQN8ydUHAM2EVLwCiDLn6JPUfiYeoeGyeZliciKwm
         2Qbvfq5ZPhKZb16+MGx5LQRK7lnf4n5Tygh3gjL8kJ4qX330qEVF2WdUaNTu14LhuJwP
         eD9CbFPEg8USDQ6hGQ1D98BSwAH9dwa5ZWrcImEvtnlFIPMlQjCMSZgW8bfn0WhokKwi
         0nwfRgNn2d1vVnoYRFzV6pCdzUmRbrHyKvyWvIKjswX7oIuWzO+RUmDB1Hn2IkLyYcli
         45eIeZNFEsMyMqICBD+Df/wZTlugJKRDKgYNg1f0AmzJordoGeWfpxefmzPWTq7F4FQ2
         Dz0g==
X-Forwarded-Encrypted: i=1; AJvYcCVgmg38AntbQM9oNYRNztczS1f7DXpenpLG488/VP2k9U2kFZ2sbPmmjLq3uEbCbHZvHBsgrhdfrm21cfyMAxZwgrP7mdH22AAdRQr/HwrmfSLHWfaME2lmBHpkcLv9r27vrueVyII2rw==
X-Gm-Message-State: AOJu0YweoDrfY+al3CC0Y5wYmaA57v+wd4D8a0Z6wJu3CfOJZKvHgTfr
	RGffff/chEvcrkmqAHSXFDHJ95m2VBrbxHQMMN2aHXr3BVJATF6e
X-Google-Smtp-Source: AGHT+IGMXcgzPbiRbAaZnXiJWR2s96AphzV/ePKBVZUQDbytucyVA3PArFmkTCYWRUbf042LO6gbGA==
X-Received: by 2002:a17:902:cecc:b0:1dd:8bc5:afe3 with SMTP id d12-20020a170902cecc00b001dd8bc5afe3mr18719900plg.1.1710840937439;
        Tue, 19 Mar 2024 02:35:37 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.3])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001ddc0bc5934sm10942432plh.249.2024.03.19.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:35:37 -0700 (PDT)
From: Manojkiran Eda <manojkiran.eda@gmail.com>
To: patrick.rudolph@9elements.com,
	chiawei_wang@aspeedtech.com,
	ryan_chen@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	manojkiran.eda@gmail.com,
	jk@codeconstruct.com.au,
	openbmc@lists.ozlabs.org
Subject: [PATCH v2 3/4] ARM: dts: aspeed: Add eSPI node
Date: Tue, 19 Mar 2024 15:04:04 +0530
Message-Id: <20240319093405.39833-4-manojkiran.eda@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds eSPI to the device tree for aspeed 5/6th
generation SoCs.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..eaf7d82b6f46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -343,6 +343,25 @@ sdhci1: sdhci@200 {
 					status = "disabled";
 				};
 			};
+			espi: espi@1e6ee000 {
+				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl@0 {
+					compatible = "aspeed,ast2500-espi-ctrl";
+					reg = <0x0 0x800>,<0x0 0x4000000>;
+					reg-names = "espi_ctrl","espi_flash";
+					interrupts = <23>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_espi_default>;
+				};
+			};
 
 			gpio: gpio@1e780000 {
 				#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c4d1faade8be..094e14442101 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -454,6 +454,26 @@ video: video@1e700000 {
 				status = "disabled";
 			};
 
+			espi: espi@1e6ee000 {
+				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl@0 {
+					compatible = "aspeed,ast2500-espi-ctrl";
+					reg = <0x0 0x800>,<0x0 0x4000000>;
+					reg-names = "espi_ctrl","espi_flash";
+					interrupts = <23>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_espi_default>;
+				};
+			};
+
 			gpio0: gpio@1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.40.1


