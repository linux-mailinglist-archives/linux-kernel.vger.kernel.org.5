Return-Path: <linux-kernel+bounces-46799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7A84446D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B9D1C20DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210E13B787;
	Wed, 31 Jan 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eidMrhta"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2D12FF6A;
	Wed, 31 Jan 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718445; cv=none; b=jw5Nnva/KhxVOQzWZoZb/mH6S9/hTngXJIhDWqvFNTr6gVPl5+jI7IsPRsTNPJ7cJEk6B4GwqvKT+vFHNnvCT03IHaPhk2f0nr07e0ifWF7BhWV19oieT2nvm0QIlaSdCLJa81h1Z77WrEFHQU1ugCLdqLuDvP+GS1TRD2Ipb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718445; c=relaxed/simple;
	bh=mSTYl+S5y2Cjmbl5fY1+m8VOf05Ry9pXVxOCn1/aiGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8O1c+lIox7IHRkKF29W0tKlTnlqej/SNW150iAqOAMJfzKNSY281hYZwvRuPo4KUCs0TDcBt3X98+ClzDmhjr3ExYZxwGKIyVjvtQRJ3iQXHzNa16YvcTxxWHjYRqxIoletdo3bl2v8BXtky+24yZ0XzOL2rS8EoB0KpVCBXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eidMrhta; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3062440014;
	Wed, 31 Jan 2024 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fORjDlsDhrIYNSllDnl+lAljmgE3xSz15qek+qYmWrk=;
	b=eidMrhtaP0pvp7ETrGL/Tbun1n7+k2Qi3uKYyTp9hXDNMSDQCS21cCug4228h26Rk4kNRS
	5fB20NqUhwpG4r1YC1Mq2s0cPgj3pTSUQ3eeHQ29SC15KsXMFe6AbdDHf6zsMgfMiesUt8
	Ds1FLsp0EbTGs7TY3Fr835D6tdJ9MCRkNAXkTjSeO29bsRpsBRoR1fxIbw2Z7lymwzL4Bt
	lJI7z4aBPXPccSYYXeeYdXq1iNkG5SOZE4sfJIuCaOMgIpYChcA9XQHuGZkYMK3gsh5b0z
	s6RKqhksoD5ISG6R+jH/6RcKk5INjyjPnCRGFAcuid4fT/ngxvT8sO4iwNM0Og==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:26 +0100
Subject: [PATCH v4 13/18] MIPS: mobileye: eyeq5: add memory translation
 inside OLB syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-13-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

The OLB syscon block is host to a few peripherals (clock, reset,
pinctrl). Simplify declarations by mapping memory to have relative
addresses.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 03e7e942ee22..732e21be65b4 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -103,6 +103,9 @@ uart2: serial@a00000 {
 		olb: system-controller@e00000 {
 			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
 			reg = <0 0xe00000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe00000 0x400>;
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.0


