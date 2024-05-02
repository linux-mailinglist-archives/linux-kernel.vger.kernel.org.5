Return-Path: <linux-kernel+bounces-166338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB28B9935
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183B52868ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5912FF9E;
	Thu,  2 May 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="hxRrl8zu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD2605BB;
	Thu,  2 May 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646422; cv=none; b=L6WqYzIpuBoaT97y81YBhSuu9PRdhNNetotY16Fb6wTTyLkPTZu9X2RoqKVaKQvxSKn3GVi0ah8SH5XQGXvTblC3nfgbChqG8dDISPqtNNi0ZmUC194HDdMtKUxYq+EBBb/FZDYvOfagBSzVPm0k1zoIjk5oSZZAzf42ID7DW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646422; c=relaxed/simple;
	bh=ScRaDhIpV127IN2u4IRMxbcJ62UMUy4jPlUrmCzVMKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7Gduiy4GZeaXJJoZ2zm9/B37gKsHCf69nK6StLzrbUGBOthX0hQXeOFziKNoLJvHod0Oy8LAzR2amV3baqh6fsYsikqhpb2Cy4RrjgNA9VyeY72vflPk9SzJpRFx/SOnMWcW1NIw5DjnAHpJNdx9hTXavaPfr5xnkaTTlh2XlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=hxRrl8zu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1714646412; x=1715251212; i=j.neuschaefer@gmx.net;
	bh=6OXJA6Op8AyXGG0UDDxLGH3tvgeicFvPJqUw6T5kUbc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hxRrl8zuChzw55RMQflwp7LKbYiPFy0ZZt8yx8NZ/Dq4g/FCU31fUP3+FmwR3exN
	 TF8U2y79hG2fWEX7VhYBgzLn5dowiT1R5GAU51LrqgANiVsWk0/5DgQJtiX89Ptya
	 LP509nGTPoKexTIIo7QT0TUebmRmoFsFRagEOYj/ZXffpmyd+k75r8FCk91CR7kSW
	 8Xt7WK3kHD71rZZdkGW1zvRuO0DYOLcjBivEXh9Gy+xS5sjG4Qq9BaiJqZelQFQyd
	 uPDYTuO5eChJKxLwT062m8ysSW/OxLb9SUTW6zM9YmdchYC/XD0mkTuQtK+hU40bq
	 w3c8BBruMWTXhVMJpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1sBRu72x6N-00QZRI; Thu, 02
 May 2024 12:40:12 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 02 May 2024 12:40:05 +0200
Subject: [PATCH v12 6/6] ARM: dts: wpcm450: Switch clocks to clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240502-wpcm-clk-v12-6-1d065d58df07@gmx.net>
References: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
In-Reply-To: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714646407; l=3443;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=kTIwYF9CzV7EiefFtPbjPQBui0vN/ls9WsnRdurtK5Q=;
 b=i5Nq00oyRbu3AdZD8yy38vGM7GdRnEMZs+mGG+3ay/O/Wyfg8NaGHyiZFF5+okDYgRRB5h3DN
 Q5d4gVOoKhUB7XDLKtjAK4YSHebPDyraHUvCX+G5sAcIoTajJGKy06S
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:hIS1j75iLlGFzDqsq+dZOPH9oD8RRwRngZCC2XzrPED0kjl9VzG
 tctJWpzU85h5nTaGYuPEsGU2Ky/yE9g/qqf1HuxSBl3vHOK0DM4Aa48KUwfcYciYcMbCZL1
 JdT/xpRZRmdNe7nDiUp4nYSPbm7NKM2foniMSld5PbS15DUIClvJq9fZNvvKxsNE2wtYhtW
 yF23+xG8cKN2iKxoG4Z0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:utNei+oMAA8=;d1JrV2fj7oGow4bds/UHwSLcGsk
 NF95oW2ztrNogQOM35PCLwCEQcGiQXhqQpgYD9hDo0x5RxsvxnAKrx8Y2tF318a8FTSOPIRB2
 UQt2DRubFbpXhYu07L65+mjg2u512e6XjbffsrnMSlzhcozhuN/Iwz0kBt9K8VLfFJjwh8Hc/
 vlV8XGLc/+nhD21Ts04HnFowEZ7cE49/BNBdC3AwM1jZLZ2cL74jcUjFiZTtfcHPSC6I075gi
 06kuJazbup6OcY+w9Qjsf9Hqkvp/4XBPBSopB90ydCdFSAFueeEwaNg5zPyr8Wmr3iVfG1qR1
 Btc5IbQrdFeFp5axBdVGJ1lm/9BgcGghiGZzihlHgXkq6ILkA+kAtjopoMCZ9CyAoRZ48FuWK
 pFvRPRlPO5HbVPg0fWsMCoNsyE8CCL1gTf9UTRR0kG3cSF2yw58Xi+f0ZZ4+rqNCe1oUJ2jNp
 TbZEMOQYNPFklJU7G/HITEBaCP9+c8ny9ibM/8Hd0m80pr7NCmXYwP0tCWeqlsQX7Wogq7Zpz
 LSqQChOTl2fopbHLj/aGi8IdiaStThcN0T/AXa2OAR01zPV0IDiu9YMC14vOv+tknIDRVmRvK
 ge8Lxb7NcGjSLXVpWFP+0Cb9m4vjTM3oO3PYUrW95Vb9/kHRgldm3DjtjK66mBrjsOo++HlXw
 l1QFtAHIbe7XZVLIKBgn7l6tVgq1VCEc9go2lW392HBwERZrdPdeVm14KE5+bFxylnQ6eDs+i
 jOoD35HXeK89INu8Y0QXSGqslX4n1phWKTF6GHvCkl9nhM9XrJqkpQTtvHEG+zRI/p+cbcCNC
 o6sIB36qBvzXd0FdcapQCnmhJhNm5j5umVdX1J80AbQRQ=

This change is incompatible with older kernels because it requires the
clock controller driver, but I think that's acceptable because WPCM450
support is generally still in an early phase.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

It's probably best to delay merging of this patch until after the driver
is merged; I'm including it here for review, and in case someone wants
to set up a shared branch between the clock and devicetree parts.

v12:
- work around timer-npcm7xx driver issue by providing timer clock separate=
ly

v11:
- no changes

v10:
- Reintroducing this patch as part of the clock/reset controller series
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 32 ++++++++++++++++-----=
-----
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index ff153858801ccf..daf4d399ecab4c 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -2,6 +2,7 @@
 // Copyright 2021 Jonathan Neusch=C3=A4fer

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/nuvoton,wpcm450-clk.h>

 / {
 	compatible =3D "nuvoton,wpcm450";
@@ -30,13 +31,6 @@ cpu@0 {
 		};
 	};

-	clk24m: clock-24mhz {
-		/* 24 MHz dummy clock */
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <24000000>;
-		#clock-cells =3D <0>;
-	};
-
 	refclk: clock-ref {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
@@ -44,6 +38,19 @@ refclk: clock-ref {
 		#clock-cells =3D <0>;
 	};

+	refclk_div2: clock-refdiv2 {
+		/*
+		 * reference oscillator divided by 2, as a workaround because
+		 * the npcm7xx-timer driver needs its clock earlier than the
+		 * clk-wpcm450 driver (as a platform driver) can provide it.
+		 */
+		compatible =3D "fixed-factor-clock";
+		clocks =3D <&refclk>;
+		#clock-cells =3D <0>;
+		clock-mult =3D <1>;
+		clock-div =3D <2>;
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -70,7 +77,7 @@ serial0: serial@b8000000 {
 			reg =3D <0xb8000000 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART0>;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&bsp_pins>;
 			status =3D "disabled";
@@ -81,7 +88,7 @@ serial1: serial@b8000100 {
 			reg =3D <0xb8000100 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART1>;
 			status =3D "disabled";
 		};

@@ -89,14 +96,15 @@ timer0: timer@b8001000 {
 			compatible =3D "nuvoton,wpcm450-timer";
 			interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb8001000 0x1c>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&refclk_div2>,
+				 <&refclk_div2>;
 		};

 		watchdog0: watchdog@b800101c {
 			compatible =3D "nuvoton,wpcm450-wdt";
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_WDT>;
 		};

 		aic: interrupt-controller@b8002000 {
@@ -480,7 +488,7 @@ fiu: spi-controller@c8000000 {
 			#size-cells =3D <0>;
 			reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
 			reg-names =3D "control", "memory";
-			clocks =3D <&clk 0>;
+			clocks =3D <&clk WPCM450_CLK_FIU>;
 			nuvoton,shm =3D <&shm>;
 			status =3D "disabled";
 		};

=2D-
2.43.0


