Return-Path: <linux-kernel+bounces-74246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4605085D188
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F741C20BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA383C6BC;
	Wed, 21 Feb 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGWviKJA"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AA3C484;
	Wed, 21 Feb 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500973; cv=none; b=GEMiKHNP+KmvNxC2lRysT20j0o8fBK+32QpnqQDPKQmjWE2V3blCwo0VLRPI4JQPNXgpJe0vcukMs4h8/pjUYZslonZrhFnqszeIHYioJUS+0OTX5Eooz7r6dGiYb0HXo/+G7QGDiYjcoYa4dEYITYxvTWud67hUwu9Soh1ePRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500973; c=relaxed/simple;
	bh=F3Sf0JiF6x4iJ+PX/ACP+GxQSz0ogVWMEW4G4AWPfyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLgQWdsLKelC0uKVVmOvcqpEFA4swgN74u9gYO8sIhzqA5AsEK1vVTmbDUNxWariW6WIFROndy275xqEIOeXXkhgEKSgSn6pGuF40RaaBOfwEdm4Ox2d5mYWwceIKWFMOhwrj9nKaLiFWgacNofx8aSi2epkGm5JKUYKdVF7Is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGWviKJA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d1094b5568so83301761fa.1;
        Tue, 20 Feb 2024 23:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500970; x=1709105770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbLgMoZR4t08q5k+O843alwk/f3OePOmG2WLruO1CqU=;
        b=MGWviKJAA6dYyKCQ0aay8a7OCxazyH4xSQkHSfS9PdFNOGw/RdLpKl8C39Rb3J6sMr
         g5WdoRcC/mNSk0e1R2TscBkuusW2OBKEonTXOBdvTTVvvRmGx60L7xGQHGGYGvUElTxa
         tnDMsm0qvj1PDCdvX9W3tY57oE+wtZorBaRTueEI6x/584IlEcIkqUZJ3LrTYmxDvBJl
         V/b8LSWjGimmN9OM9f2zVk2PLHP21GtuSzd/NeN3SD+L477eJfIphDomm56RLgpB5/Vb
         ck7e+RITbdiihAC/pe0O4y3Ys8xEmiHBMsVs8z96MLjma8yr5DVL0+lmv0U3L1IAB/Eg
         Kkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500970; x=1709105770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbLgMoZR4t08q5k+O843alwk/f3OePOmG2WLruO1CqU=;
        b=Hjv1yw38SnsGKheS7AyBGmGFAEA960fHrkoTOaxvdSbsMZMapcvv7HAueS9RS8CbFZ
         FlruvwrcYyLNJbcG6HYTTFLmyCDZqIt6tMtNRIlipW+dlOQ3S7MkAtueMMESHEhpwMa+
         bcF9RWbbqA+xEwtsZ/90cljjXG+xpqLMXOCv5gU2rvRLGD77s2S6TvtpnvcnOvblF6ZE
         pbvzsP5tORs19zUlN3qAiuvwES2+QVJoeWCj3zxQO+IKNCVPc6bbYTtjMGcjzfILXaNa
         QCr+mCt6j4pC9oKZknoO5aX/Rx6Q3r5zYx+vClkJx+Ase6Xkwt6+i5QVx3O9Nd0YYVTF
         KJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCXyT42HF8LNgVQyRJqtcboZDD9OLLirhqvocJBfo7ly4VNwulkAoIJ44gWu9cvLXsrGgZm4v6JICm79CWNse7KXNK8TX2ZZIDMLILAcsFfc7GfjGD/V6U2Co9/KmZNKT7zofAuz1ReX2g==
X-Gm-Message-State: AOJu0YwWOr1V6zNtHY6m9WsX4HSJKSz43Sy382XFiVyWXQNUuKRhBl++
	byQuGc5rnN8Gbtzx5gViJmaHkvzyjqCwmE8GDvihNycI4NDlFCf2
X-Google-Smtp-Source: AGHT+IGbhTXvfJwY454gP9jL76eAJGY29TsXCEdiPrgqL7hjr4TGYQ2YlFcD/47YCPPm1w0ctPzyyA==
X-Received: by 2002:a2e:c49:0:b0:2d2:40cb:8182 with SMTP id o9-20020a2e0c49000000b002d240cb8182mr3976818ljd.49.1708500970465;
        Tue, 20 Feb 2024 23:36:10 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b002d0f99a7fc4sm1722330ljc.79.2024.02.20.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:36:10 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
Date: Wed, 21 Feb 2024 08:35:24 +0100
Message-Id: <20240221073524.20947-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221073524.20947-1-zajec5@gmail.com>
References: <20240221073524.20947-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
Ethernet ports.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..96da4ad640aa 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-acelink-ew-7886cax.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
new file mode 100644
index 000000000000..cb36a089518a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+#include "mt7981b.dtsi"
+
+/ {
+	compatible = "cudy,wr3000-v1", "mediatek,mt7981b";
+	model = "Cudy WR3000 V1";
+
+	memory@40000000 {
+		reg = <0 0x40000000 0 0x10000000>;
+		device_type = "memory";
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		key-wps {
+			label = "WPS";
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WPS_BUTTON>;
+		};
+
+		key-reset {
+			label = "RESET";
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			function = LED_FUNCTION_WLAN_2GHZ;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_WLAN_5GHZ;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			function = "online";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.35.3


