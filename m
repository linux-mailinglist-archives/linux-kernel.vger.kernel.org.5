Return-Path: <linux-kernel+bounces-35907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0D8398A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE29B276CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F912BF29;
	Tue, 23 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZkVF00R"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9CE129A66;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035636; cv=none; b=pHBFS2YrziCBi+gNd50/bWzM7C+lDTH8qAK1FImSzjQjRKF1A8IfwS84nZ+D/4UmqUodG8iRS48L3X5gE5LZiAZsK7VU4jEXcohWosDXh2cglgObqE+yVXFV/ZHb5uARSvMwr9y+UVXz9tfjpGWWqnSnT5/cscca/lKKRSSuOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035636; c=relaxed/simple;
	bh=Ca1627Bi/LRqkg57RvGjDEp7fQ1+yNJRKdz4pZouRgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFicScDziavLpCGo+X4VIgC78mT1bndYyon7qQSnK+qXnfyAjoXEESTcdrW96W5hfR1R7TOI5ieKqWGVgrc0TM0qQYmizAvM27kXzIyofyXYRaDA3qzUtGDNxBmQhIjPIkD40S4QykOzFAQoJf+JtFbs/lTQSKCQiLsaJHMdE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZkVF00R; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB3FCC0013;
	Tue, 23 Jan 2024 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fze6uL+p3cNzuC9ojKFKCdUNTjWCOS7cfDLaOBgCOo=;
	b=HZkVF00RJd3Uxg2DxDPHZgt9+55g6zoqFNJH+Ne3X4+HAEiz2zjSjbycUtEgMDwjONR71A
	HPphHM8AKPHcJNApOk+POgcoed6Ok++yoZX0Y6IYGQFNGVDWbe46hQsCbugEUs7O+yXqzl
	IKMRfz6iD5ajUE9sR6XBrfRvdyp/8WmrNK3s3tJcM0OILnHj5GME81iVf8d78/f3bPc3CW
	RMhfvhsulzAMaVhAKv5TF+pB9TlkLd9b29+ekLuvxSqgikiFgTw1lMjyQ5OV07fpVZnOpY
	olRXvm+I3OWpKrv6rDMe2HMLZVe/69VcFSlYiy/ADYmoRDWzasl5sCFIlAfIvQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:57 +0100
Subject: [PATCH v3 12/17] MIPS: mobileye: eyeq5: remove reg-io-width
 property from OLB syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-12-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
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

Remove the `reg-io-width` property from the olb@e00000 syscon. The
default memory access width is what we desire: no need to make it
explicit.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 81497febcdee..03e7e942ee22 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -103,7 +103,6 @@ uart2: serial@a00000 {
 		olb: system-controller@e00000 {
 			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
 			reg = <0 0xe00000 0x0 0x400>;
-			reg-io-width = <4>;
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.0


