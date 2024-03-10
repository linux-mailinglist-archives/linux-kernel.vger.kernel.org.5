Return-Path: <linux-kernel+bounces-98309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930F87783E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D41F2122A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C63A29E;
	Sun, 10 Mar 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="sl6aUEHa"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E139FDA;
	Sun, 10 Mar 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098535; cv=none; b=qSU6cSFBjNgmp30zVYfDJRTk41UiAXMZggfPp7RiDFcms37FTyQYTlaHBzlMU3hJtBURsrIgJ1q+ekX86tjChLIAc94m+23Bbwc72IJT8092gfCvM1an3k22MMkoNcFDiZF5pXYkQ8JD1RCF3oN/g65t4FkO33SH5jCqvbxX44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098535; c=relaxed/simple;
	bh=xwX/n31nVi07GwxabpiM+MILqJWpXLhlRC1o1CAJ1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTc1yVlooM9HqX1zp/6r0VfhgML1I4X6tAsVDvKBCMVPrU/BDRMs+NLe+dGBPHDVUAVwm74xJYtBWg5xr7JSvCI7bvK0//29iCFYjQtfw3dLZy/Lg6H7Rj6hVOZxUZjTsstIEWYHuhow5fUM/KfB3OAqjdX4z+vD2wBTELQBCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=sl6aUEHa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710098502; x=1710703302; i=j.neuschaefer@gmx.net;
	bh=xwX/n31nVi07GwxabpiM+MILqJWpXLhlRC1o1CAJ1TU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=sl6aUEHaMe2HjYr6QOmJyK1QsGHLZhzojcObbY47BAg79bK1VrstaRZrGjE4GVvK
	 p766bypEp/aScC5+yLwn2HSVZuB78+RUbp1fcXTVh7bpCRCAhb5u+ZltAOAuMgxeR
	 b/8mE5rR9emmpSGiBVZ0mLiNvY0zR9mVezmhOk9YvbufSlwtibPIRPbtFKuY8/o4j
	 jmCcgQNx+ZHfdtma8+ckf8inqnFUd/0Z9s5wCWMT+OvV56fwy+VuCt+GfJcjKuhcw
	 6xccW8M++fCT7eqnOWExhC5MSiM23cJmnZJkOmGmHC6OPlgcrYcKpVdoktyKODur5
	 k+GGtn40S1EWZNVMGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.216.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1rcZOX25HP-00GGJ0; Sun, 10
 Mar 2024 20:21:42 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-clk@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v10 2/4] ARM: dts: wpcm450: Remove clock-output-names from reference clock node
Date: Sun, 10 Mar 2024 20:21:00 +0100
Message-ID: <20240310192108.2747084-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
References: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yxv8vcS0CGRV2FQAe7UR+uwmKh8p4sYJxeQFqTQYP+MG3O7jaId
 NA7IC8wYRDxJy8yNxv+TZcTEmnSde5YphuZlzTDpuzM5e5rE74PC+tEvwCdM+V5JqefWDlo
 K11TyGY1UNv4K3xoTz4ej/8I9VumgcQnuzKKEmH2K1WdFz7aAMTnpdsDPaGkmxtt3R9g5yR
 pz4cCnktw9dfFSkbqDLKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZZGopwyhUfA=;tvpNE0Osvs/k022T2xl2BC/jc/y
 XNrWZyEdFWUtPhhsvlOPuEuDAvL+fPOKn1iZwyW1HHjag79DQJGyHLY3wG8KeKwEtva2CSZDx
 5zeLe9phCFSbCGT4BduAOqSpIQpYLe/kCY/EHbKbpTkVejeZh0HeB/LNFG7kMmB6NA5FCGF+O
 hiqHtd+08UUVqMbbTSUdmT5tg9PisN9Us+WaaQErDdFp0nZ+DRlX28ZQJt/DrNl7IKSsmY5ZI
 SqcUanas5sUzr8B7lZdi+XEXX4WiUZmXJUHDH+ONyzMumj4PW/xlpp8y5OH+isOZe1SfBHwIm
 W1/NiVkxsDO9KNm+ly2R/otndqHOyNweCMSl8aFdU7aHONhjS6JihFsY2b+JSEdVKn1qPG7jG
 044Ap75j80qa64a5AebhV0i5o0fn55dM7UDXk2Pppdb1w9wjrXHSHoU7wcs5K02dLpNBhYQ5b
 Np0CRq5D8r9AIFzAsECBHZ0HXlwUVRxM9gIYVJDGd2V/m1S+ZZlwb355hoHvEBx0Qvxti6jp1
 viwYP4mXP3tkbk+y6HoIVTk6fZg/KkZ73ST2SlZi4Z94dhth5mWgh5AykR4LLswoU/IZBe7Sf
 8UeagtHFs3F4tRUSQgXJ8knmHrp5yMm4qIFfwUwftsbRq9zkxUwHIT9GDmJ+Rg58Gt+sym30y
 3tOIg6f1oN0hPHDuVd5251OJTR1ksz8OjllK+sJzgNUlWuxg/3UIzHiw4DSdXzt/HVSLpfTdn
 YW4xpjfs62HzRHHikbKynuXMcKFkCGxuDUe3FaC9T9kbOEFeQ5BGs02MsP6ghfNEf5Vn5w4Hg
 DfNwfoGUeanbr0oC/DQWIzx+trAUnfdtztkNQHBCmX7ns=

This is not necessary anymore, because the clk-wpcm450 driver doesn't
rely on global clock names anymore.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v10:
- no changes

v9:
- New patch
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index 6e1f0f164cb4f5..9dfdd8f67319d3 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -40,7 +40,6 @@ clk24m: clock-24mhz {
 	refclk: clock-48mhz {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
-		clock-output-names =3D "ref";
 		clock-frequency =3D <48000000>;
 		#clock-cells =3D <0>;
 	};
=2D-
2.43.0


