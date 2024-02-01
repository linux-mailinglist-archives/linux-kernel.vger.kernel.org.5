Return-Path: <linux-kernel+bounces-47619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37F84504C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C51C237CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C938DE1;
	Thu,  1 Feb 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="iFPeHygO"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598833BB21;
	Thu,  1 Feb 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761957; cv=none; b=EXL4ILac5hsEc6RC11ECxTqJeIQcLjHt8wTJQpWnVsoPUn0zZHgZdc2iz/BxFlZnt8Ds+R+Q9+ntQf7+8TPhmtsXhw3flmITfX38l1qIqbopqZDCUroq3C4yjjYGSiukm1L1ObmqAVbuKmyU7moyEIRSQgJfOpTPWPXPlNr2t+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761957; c=relaxed/simple;
	bh=pda2Mn73eHui5hFlKn7PApNf/Yq+JvVcatVuU36ymJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcLjoNlMi7Gmy5W9d3gMAXYwU2ssEG9SXDfKejidB6oj7J1aJ2fapBt4lb0UmzeITl9YstWHGr8gIreXwUU5nLE8UhgHRPxQqOblbhjYJz/PlUmwr6GFo77kIWc6prS5PZMj8KJCEkn68S0u0Ucd33QXWbaCQYWpHIhwQytQhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=iFPeHygO; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 60C4598F;
	Wed, 31 Jan 2024 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1706761566;
	bh=91lQIC5ttis5jruXSHoJGTpRH5gY1g5HotYFr9Ay6KQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iFPeHygOCuHr7Kp3wqppIP4gtRLDrV4Mz4Z5BpokLensflO19IseUz6ay2/bV+XQu
	 9AN7IiOqjZdmpyvE2YxOaWAN52xPL8iv9rtqlkx/tCby/2Z9Mj1WIeVc8G+xHvI29S
	 KOSP0LVqgJm3VhVZnqXVAiO6ZhQWUtl+/jYfB2Z8=
From: Zev Weiss <zev@bewilderbeest.net>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
Date: Wed, 31 Jan 2024 20:25:54 -0800
Message-ID: <20240201042559.29795-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the more recently added ASRock BMC platforms, e3c246d4i and
romed8hm3 also have the BMC's MAC address available in the baseboard
FRU EEPROM, so let's add support for using it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts | 9 +++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
index c4b2efbfdf56..bb2e6ef609af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
@@ -83,6 +83,9 @@ &mac0 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
 };
 
 &i2c1 {
@@ -103,6 +106,12 @@ eeprom@57 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x57>;
 		pagesize = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress@3f80 {
+			reg = <0x3f80 6>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..f8a1764a4424 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -71,6 +71,9 @@ &mac0 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
 };
 
 &i2c0 {
@@ -131,6 +134,12 @@ eeprom@50 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress@3f80 {
+			reg = <0x3f80 6>;
+		};
 	};
 };
 
-- 
2.43.0


