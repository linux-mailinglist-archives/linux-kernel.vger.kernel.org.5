Return-Path: <linux-kernel+bounces-29014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE68306E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605801F252F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08431F927;
	Wed, 17 Jan 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AP4Ol74U"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F01EB40
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497514; cv=none; b=RTYp0cPeBT+V/DVpqfYEuvoO4GMis0i0tfGNtrV0hm5AFvfMfipIisWa1Q0L6ofFds5rrc5ouQENRUzFzK4jScvDj8WAkXqn6GoAJVHichGzViSWtDT0HcGj/HRRK9J1wSI4cw8FL+zHPAhr4YTTKe6Akl6XxIqggJL05uG4mqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497514; c=relaxed/simple;
	bh=0qy1MLpQ6p2dS2/1Q15w8I1HCtN755jfOJd1BS66sZs=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=Hj2vIoGUw/7Ms5UkrjVN9ao2cGNExHNsmznbzXiybje/YSQtKsunyn9jfaicnVVaafWTn9JcjVUrEhr2xlMqLdTS4wT5c3/VJsqhGtf1xTXERisg2i/2WpUgQLraBH54T2B+LboET75EiiI0TTDC8BJyFu0/CvVjFtriCtZfT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AP4Ol74U; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=AyLwU/dOyiUIxe1GTEza74hDuEoJNyCzqQJuYuqtMEg=; b=AP4Ol7
	4UaaZUnBUtlt8IO058qBQ5o68vB5G/UKnBAloYmcdOSOfWXD1BPq6TNxs4XmCwaJ
	gMbQwBuLH6FFNOrwdGWnypnk0wTU0s5z7IF+I0/vz9+/K2aukFTzBVd5DgwbxzMM
	AcrmpV45fNWM2bcwVqT7L5PWHn+HRaxxkpSZbI9TqSUeQFEk3GxjTUJFvPVRL+dj
	0pD8QAui8JR8M9rqKJR9uPv48joj/ACC9d73zcUuhvWnWebSodixhEybOBA57TFV
	8fHD0HwclTwu5HoeL5fD+wmOU39ZBDqZQFkczt/uwSyVp0aOA3JePN40LC7c0g2f
	Kr9YVG+CoBqCtj5A==
Received: (qmail 2754609 invoked from network); 17 Jan 2024 14:18:21 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 14:18:21 +0100
X-UD-Smtp-Session: l3s3148p1@AlKzFCQP3KpehhtJ
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
Subject: [RFC PATCH v3 1/2] arm64: dts: renesas: ulcb-kf: drop duplicate 3.3v regulators
Date: Wed, 17 Jan 2024 14:18:06 +0100
Message-Id: <20240117131807.24997-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Schematics say that all these 3.3v sources are driven by "D3.3V". We
have a regulator for it already in ulcb.dtsi. Use it instead.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Following a suggestion from Geert[1], let's inherit the 3.3V regulator
from ulcb.dtsi. I kept the other KF regulators because:

- 'hdmi_1v8' is really derived from d3.3v on the KingFisher board. It is
  named "T1.8V" in the schematics. Maybe we rename it?

- 'snd_vcc5v' looks like D5V to me. While it seems available on the
  connectors, it looks unused on the ULCB. So, keep it KingFisher only.
  But maybe rename it to "reg_5v"?

[1] https://lore.kernel.org/r/CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqVt_ciio+g@mail.gmail.com

Changes since last version:

* new patch

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 35 +++++-------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 3885ef3454ff..40a5f98c1190 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -32,13 +32,6 @@ hdmi1_con: endpoint {
 		};
 	};
 
-	accel_3v3: regulator-acc-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "accel-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	hdmi_1v8: regulator-hdmi-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "hdmi-1v8";
@@ -46,20 +39,6 @@ hdmi_1v8: regulator-hdmi-1v8 {
 		regulator-max-microvolt = <1800000>;
 	};
 
-	hdmi_3v3: regulator-hdmi-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "hdmi-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	snd_3p3v: regulator-snd_3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "snd-3.3v";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	snd_vcc5v: regulator-snd_vcc5v {
 		compatible = "regulator-fixed";
 		regulator-name = "snd-vcc5v";
@@ -160,7 +139,7 @@ hdmi@3d {
 				avdd-supply = <&hdmi_1v8>;
 				dvdd-supply = <&hdmi_1v8>;
 				pvdd-supply = <&hdmi_1v8>;
-				dvdd-3v-supply = <&hdmi_3v3>;
+				dvdd-3v-supply = <&reg_3p3v>;
 				bgvdd-supply = <&hdmi_1v8>;
 
 				adi,input-depth = <8>;
@@ -198,8 +177,8 @@ accelerometer@1d {
 				compatible = "st,lsm9ds0-imu";
 				reg = <0x1d>;
 
-				vdd-supply = <&accel_3v3>;
-				vddio-supply = <&accel_3v3>;
+				vdd-supply = <&reg_3p3v>;
+				vddio-supply = <&reg_3p3v>;
 			};
 
 			pcm3168a: audio-codec@44 {
@@ -209,8 +188,8 @@ pcm3168a: audio-codec@44 {
 				clocks = <&clksndsel>;
 				clock-names = "scki";
 
-				VDD1-supply = <&snd_3p3v>;
-				VDD2-supply = <&snd_3p3v>;
+				VDD1-supply = <&reg_3p3v>;
+				VDD2-supply = <&reg_3p3v>;
 				VCCAD1-supply = <&snd_vcc5v>;
 				VCCAD2-supply = <&snd_vcc5v>;
 				VCCDA1-supply = <&snd_vcc5v>;
@@ -221,8 +200,8 @@ gyroscope@6b {
 				compatible = "st,lsm9ds0-gyro";
 				reg = <0x6b>;
 
-				vdd-supply = <&accel_3v3>;
-				vddio-supply = <&accel_3v3>;
+				vdd-supply = <&reg_3p3v>;
+				vddio-supply = <&reg_3p3v>;
 			};
 		};
 	};
-- 
2.39.2


