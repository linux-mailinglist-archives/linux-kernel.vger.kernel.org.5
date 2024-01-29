Return-Path: <linux-kernel+bounces-43522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADF841525
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB661C21972
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D515956A;
	Mon, 29 Jan 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="c7VetOAL"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1201586CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563443; cv=none; b=pMecfhuTpPyY3G2x0HsW1qF93tBQLSQTUXUkA97bYbLbLLfXN1w3j7liQpZXokg10R5nPyaorw6ydk6pd49IwmV0DI4Sen7ZLx2cWBNYb8vZ90bx3b3/HBz99p7uXFbSeHEpqTfwgvR2FvA5NMeeX3vKjIFm1EZYmknkEixFo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563443; c=relaxed/simple;
	bh=k1GRh25etFTzV0TbJNBHdGdMzhY9M6eqleb+ccaQwX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGe3I2UkhE0PReriPDPxDAMjCTZXZC6SuxEhqs67KNrqIvgnbzXUePN6cxIFxUKbT/Z8fpCMADjlsSv9olCPV8ue/0xLry2wpl34NwJLnDxM21OvkGs7R8GTxOv6FB34fce3FrIJ4HwmNwx7pypYzt5IykKoj97QmPczp+5hrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=c7VetOAL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=tnP8mYbKnfOf93yFIfgxQY+r9CeIktlYjlPhdDrf66o=; b=c7VetO
	ALxwXnZOTAsIi+htvwSI6NyI/3HhxGDwBngFdRqmnv8ldKP/m/Dj2teMG9gNjD8F
	a7tsQAYB947gDzrjvveTz/c0LeKQzL7TnpuL5sLHvPvllQATs/qrcxRZ0zK1zjJz
	P3k3WQhqdKTBamAsoRlcwrqcHP8fsm+Kv/XnwohobIhpWHoDSFyp6tdrTvMaUxol
	MduK8Lc3c9RDCiPnHQfVxq9+VklcQJNJEQn3koj0y8Cas1nxj4S1TxsgfmlgzWXU
	6i5fSwbFDtOWmHQshnzdgAzlxiWh9Pga0Dlkqar3ZikDwYJ1muL7pnGe0JtqzDYl
	6jgHwJLSPfiFJM1Q==
Received: (qmail 2612167 invoked from network); 29 Jan 2024 22:23:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2024 22:23:56 +0100
X-UD-Smtp-Session: l3s3148p1@xtBuQxwQhOdehhtJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] arm64: dts: renesas: ulcb-kf: adapt sound 5v regulator to schematics
Date: Mon, 29 Jan 2024 22:23:50 +0100
Message-Id: <20240129212350.33370-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129212350.33370-1-wsa+renesas@sang-engineering.com>
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sound uses the standard 5V supply, so rename the fixed regulator as
such. Also add properties dcoumenting it is always on, also during boot.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Or shall we move the regulator to ulcb.dtsi? I tend to leave it here
because 5V are not used on ULCB, but I am open to change it.

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 6b6a0a8bc1db..84b0976503b7 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -59,11 +59,13 @@ pcie_3v3: regulator-pcie-3v3 {
 		enable-active-high;
 	};
 
-	snd_vcc5v: regulator-snd_vcc5v {
+	reg_5v: regulator-5v {
 		compatible = "regulator-fixed";
-		regulator-name = "snd-vcc5v";
+		regulator-name = "fixed-5V";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
 	};
 
 	wlan_en: regulator-wlan_en {
@@ -210,10 +212,10 @@ pcm3168a: audio-codec@44 {
 
 				VDD1-supply = <&reg_3p3v>;
 				VDD2-supply = <&reg_3p3v>;
-				VCCAD1-supply = <&snd_vcc5v>;
-				VCCAD2-supply = <&snd_vcc5v>;
-				VCCDA1-supply = <&snd_vcc5v>;
-				VCCDA2-supply = <&snd_vcc5v>;
+				VCCAD1-supply = <&reg_5v>;
+				VCCAD2-supply = <&reg_5v>;
+				VCCDA1-supply = <&reg_5v>;
+				VCCDA2-supply = <&reg_5v>;
 			};
 
 			gyroscope@6b {
-- 
2.39.2


