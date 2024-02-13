Return-Path: <linux-kernel+bounces-62871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458885271A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DFF1C25B22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70CAD2C;
	Tue, 13 Feb 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="cm+vuK/f"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DFA937;
	Tue, 13 Feb 2024 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789123; cv=none; b=f8d4w/XTKaKSYSZ4zn6Z4r0zE3F3verk3zuJdoZuLX6N4A+1cfQskkFgFLugVK76aTd3rHy2wuoeImkTa9xVno/TWfoHMV5MAm6rc4CFIbPC8dzjSy/KV0d8ecXypm/lFepzAhlHrZ5GUh+E+LkgTCSHKfwmicijA4rFQsKThaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789123; c=relaxed/simple;
	bh=TWXO2hZBdIqovo/18+auLeZhmPNeyNftRZkYDtp07Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbCCurC73vtgZ5w4N5T6hMsMZ1KTV2LJTsg8oFTXm3BYfXsph26SENjBfbpCxmTfBexMqsZbbA4pAaAnHm2yVH1fmVxqW998RcbS6zAyc1lNI3moXEVBS9TgvgbQK4IYQQHERer9IYz+OqrQ4w587KErq30ZuJbHUVidfWmhts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=cm+vuK/f; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 07BABA15;
	Mon, 12 Feb 2024 17:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707789115;
	bh=EU+GYVFoVSrVPFH+I5Rq0CxlWwOPwFjuP4K4HYrpXM4=;
	h=From:To:Cc:Subject:Date:From;
	b=cm+vuK/fGnBwBPyf2B1dtsj6Fmbr2traTegxGV8HfYLApU+8uRoVk+CP30oURWfcS
	 LPkpSr8LYDvy8geca9x+pCT47R8ELbeZVUASM2AktntmXpnVDJ1fyg9McwLcVPw7US
	 TavtV6qXQn+rSnvkc32hJBHfDlsT7lnRJXRNgE/4=
From: Zev Weiss <zev@bewilderbeest.net>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH] ARM: dts: aspeed: asrock: Add BIOS SPI flash chips
Date: Mon, 12 Feb 2024 17:51:36 -0800
Message-ID: <20240213015138.12452-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On e3c246d4i, e3c256d4i, romed8hm3, and spc621d8hm3 the host firmware
flash is accessible to the BMC via the AST2500 SPI1 interface with an
external GPIO-controlled mux switching the flash chip between the host
and the BMC.

The default state of the mux GPIO leaves it connected to the host, so
the BMC's attempt to bind a driver to it during its boot sequence will
fail, but a write to a sysfs 'bind' file after toggling the mux GPIO
(along with whatever other preparatory steps are required) can later
allow it to be attached and accessed by the BMC.  It's not an ideal
arrangement, but in the absence of DT overlays or any other
alternative it is at least a functional one, if somewhat clumsily so.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Note that this patch is based on Joel's for-next tree, since the
e3c256d4i and spc621d8hm3 device-trees haven't been merged in mainline
yet.

 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts  | 12 ++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts  | 12 ++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts  | 12 ++++++++++++
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts     | 12 ++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
index c4b2efbfdf56..557ce20e305d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,18 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <25000000>; /* 25 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
index 263fcc8106ff..bf752ff8204f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
@@ -69,6 +69,18 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <25000000>; /* 25 MHz */
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..8dff2cbf042b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -56,6 +56,18 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <33000000>; /* 33 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
index 555485871e7a..54b40776c7e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
@@ -66,6 +66,18 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <17000000>; /* 17 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.43.0


