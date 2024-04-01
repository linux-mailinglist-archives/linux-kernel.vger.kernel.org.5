Return-Path: <linux-kernel+bounces-126705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3A893BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB641C21458
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD645029;
	Mon,  1 Apr 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="pHAZ8pFp"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59E41740;
	Mon,  1 Apr 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980466; cv=none; b=MVOveNjlMdUr0dghI9XtumalF0YLa8HqPRBfJDlCxG5PTxN/VLY95NQj5sEVaV9i9yF4+GvsqJM64DUTszSWDOFDPkBjg002cUOBmK5gfXW8cA7wXU497w/RzUuKKbBb9fes/2Ha2Oym1XgpSlFcF2XhlkrQmVAYECMthpjS09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980466; c=relaxed/simple;
	bh=5w81oYHEQ+BcdjixU8ONmPv0yzoEfSqp7jz7iguKro8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9DGtuR5JtrXlYwa7ls0i/I92tsEN8Gqq5W3//+Q9y+w6zRvihd8UoXuOSvqHb0U5wGNepkFqEdcvk12tGSCmAkGrKBqTB8joIBiXSl9ao5H+QPMfFYtqyVnIZjpXfJKjBUJqUHsp4YLWNEDc34ti2eQhSFYnXg7gf8pvCisVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=pHAZ8pFp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1711980456; x=1712585256; i=j.neuschaefer@gmx.net;
	bh=03Hg8b51Cm5OObGCW/j93uamiBzZPOMrP5OQOfimxno=;
	h=X-UI-Sender-Class:From:Date:Subject:References:In-Reply-To:To:
	 Cc;
	b=pHAZ8pFpBOM2udi+Ii1KCXEPp9nziO2n9MFzmFafA16Qh2rQgWdGr13yDEQANjlT
	 /IxG4EsILCamuDniiphaWV2tL+R9bB3xRlkJ1DHOuAka4sVKF4Yy2A2RufkzP8dSg
	 r+NwupU0YQ1Jq6lUXlWyoaFHlonEtTGdQJadyRJfxEUCKK2hHZNvUYIi5qu6tiBDD
	 cp5osGsZWzEl27zGQJik4e83ATEktWtbbeD/opGdNOkDvVt/koPjkAjCjo2LmAbd1
	 86MUBUjRrx0erk8I18lYzSSjazvNqRVQ5i7Vvd3lHHYJtQsghpbBPFgCJdX6oY+ML
	 arPUztEgmDmVQ1DyHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([5.145.135.152]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1rpu4u3ssx-0048uB; Mon, 01
 Apr 2024 16:07:36 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 01 Apr 2024 16:06:33 +0200
Subject: [PATCH v11 4/4] ARM: dts: wpcm450: Switch clocks to clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240401-wpcm-clk-v11-4-379472961244@gmx.net>
References: <20240401-wpcm-clk-v11-0-379472961244@gmx.net>
In-Reply-To: <20240401-wpcm-clk-v11-0-379472961244@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711980406; l=2958;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=a9wNsKmL9/9Z7nom3X5WWjX3p1JuZBHq/uxqGugc7ps=;
 b=KGfgbs04pht1J+1uPQNB6x7oJPqB1LMucztRdVek963PA4D9lgD12YD7farcMuKl9mLBc56hP
 krx4rGmhdTWAc+VMBUXfDtYShzX7561Vv3+vYwRlHHuITIq9uoml3Hq
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:FZ/9Dlh8rpTmwnWT25lRAV1iH6piY77RpmH+PLrywqIQ0fx7QBX
 VS4ZCdGy7Ju/y3eeR5EdmzwsnOUCmLPSqwVuBs6Ow4Vo+fK3y6VUIgSuOsgqiux1MB5RkL7
 JXmdoSnpQ1doIbfPlGOlfeI6na87nT+zfc7+n8iKWxwbJLg6bJ9OqtNVG2RVa3VrDchCKaV
 5PAApv3dRzpl1gvuVXcQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jPwf5GocbN8=;NOKGBzIo48IViiMM5Ri4xK5HzR8
 I/Jz/Pmkv9LdbYisEXDD9pzEBlbPbXKBHvm+fzNvJd66qmHWiIlti9Cj0NzQdP/RyKnNehDGL
 PfpqLW7wVlzPQ3AY0PUAxEPQ39N4JWLGUUxBtUdC6vDgzbVtemf/AFQY4zLPnucrV7HfYbPph
 y6wV6ahBFo0a2qO8C26t+FGkRqKtMT0NqBoKan/5/Q6dSUlMwPM+zo2+rJZ0xjUnZPF3bqxcw
 pY4EJJHnLLPqy7SQjiUHZpqWjVjoyhsU3uk52lolI/EL3oMbb0tFuasD++vs3gxw8QgBODzsm
 mY0qjKOvm6rQm8B0GpwzBlYmGsYnbyPyQhuJvq1PXUvJcqL3lx7uOkzxvRSRvjroywwXILjPH
 tLYc+zCRIDfOVN6wyuTz/M0ppd+0mAEHfXUCky4juafGyPvdyaDkR5J33lNpM4w+s6JUls9W4
 6vetW+ElOX0TGf/n2szTOyu9IC7XI+GjRQ8gIo43Ai/iNlv207ocCP1C6AzyMoAdqpBNmZvJo
 eX+W9vNAupxIJBAQ3qdgXR94VCkibkEMKzfreBfKJ6DHUzqlsYgZOfg3rKiSFr1qhae1pnxHy
 q4wX+j/mREILlLxfefqq9MzfuJEhp24OXTg7SSfAxTcANPWxhzEqSe2XUURhJ6xT72zbjNjyL
 RWyq9krgx5bg8Ho5juB3iDLJtXVnxVpy3/hTyuZ0JgOS3S2YyBM2YC/4GCOOdsTTDuB8IRR1V
 isKPZa87dlSm851zpvSwj/uogiWrsR1FzHOUpkPs6pn9JFAWmgqDUR6mfHA3yOlbs5y/kgzrm
 Jj91kEJlzWPCCqkS6M7+tVuL4gHJgJK1Uoq6KEsUmg+THejPAVLv8TZCxt1nvAkPmt

This change is incompatible with older kernels because it requires the
clock controller driver, but I think that's acceptable because WPCM450
support is generally still in an early phase.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

It's probably best to delay merging of this patch until after the driver
is merged; I'm including it here for review, and in case someone wants
to set up a shared branch between the clock and devicetree parts.

v11:
- no changes

v10:
- Reintroducing this patch as part of the clock/reset controller series
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 22 ++++++++++-----------=
-
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index 9dfdd8f67319d3..7e3ea8b31151b3 100644
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
 	refclk: clock-48mhz {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
@@ -70,7 +64,7 @@ serial0: serial@b8000000 {
 			reg =3D <0xb8000000 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART0>;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&bsp_pins>;
 			status =3D "disabled";
@@ -81,7 +75,7 @@ serial1: serial@b8000100 {
 			reg =3D <0xb8000100 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART1>;
 			status =3D "disabled";
 		};

@@ -89,14 +83,18 @@ timer0: timer@b8001000 {
 			compatible =3D "nuvoton,wpcm450-timer";
 			interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb8001000 0x1c>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_TIMER0>,
+				 <&clk WPCM450_CLK_TIMER1>,
+				 <&clk WPCM450_CLK_TIMER2>,
+				 <&clk WPCM450_CLK_TIMER3>,
+				 <&clk WPCM450_CLK_TIMER4>;
 		};

 		watchdog0: watchdog@b800101c {
 			compatible =3D "nuvoton,wpcm450-wdt";
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_WDT>;
 		};

 		aic: interrupt-controller@b8002000 {
@@ -480,7 +478,7 @@ fiu: spi-controller@c8000000 {
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


