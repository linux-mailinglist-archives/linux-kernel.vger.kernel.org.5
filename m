Return-Path: <linux-kernel+bounces-35910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265CE8398BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BFEB27D18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B312CD83;
	Tue, 23 Jan 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i9Q34Mml"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831A129A97;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035637; cv=none; b=PkGQM7hEceaJgnRyM7BWYLSRH1QUayeugQIpV4QmQ8cssh9aR/Ayor2a5WJccogSspTkUZuAYcODz+yIUa30x05EtTo6mKWUc47C5Kt88vL0gegl/lsR4KPIGbBoLplmbjikQkxeulV5BBWSgm0j2A6/kds9Dgom2C3m9yF8xHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035637; c=relaxed/simple;
	bh=BcYgSuGsmUgQc7+2j9PtwGdIZqvNCZsf9bcw5mP7bUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcbbJP25leLzaRECVe83VfNhE8A/HoyQCjEblNxkKF84f8FGTKewFgs3po4t2WZxHQ0OFatbDBJcOy2koEbqKVnX0XTuHzMGWdtYXqQ2Wz7k+KvPeG399T3AsTjklOjY2/Aph53dyDMUnlY4/ghLAd/WapITDS1RFJSlfypYqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i9Q34Mml; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6ECAAC0016;
	Tue, 23 Jan 2024 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qk8YOpcHtDGg66bCtfZqmVSEEO+Y3NAgtJEniv2d3iQ=;
	b=i9Q34MmlA7EiVXhBOYpjklbKnhDYR6ZjubDZjsRUHTOsDdOg9qJshHwbA4UA68mIrtjoub
	kNASSiZrw0yuoa0tH2eNf8Z/l91uru6JaiExiEQK6thB7/3UonJlQCWP0ZnS0hnuxZgFHg
	qm6EZpGohNm87JOAGOBmrNd7s/Ska68HQtVxYZ8oT2veefxcUt5Ylcyaw4KJ27jKIc7ZqV
	ibjQcF/klhM+7h5MnBgSvLCGg6LM5RZrUqGPTtp39Xxkjx8h1HeMjwtcFsJWNYfu/5uhUd
	eCuCaesZRYIboCx8QNUvq6Nv2eEoRtxyVKTO4ESxQNWRzwlDrVCPXVMUY8i5ZQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:59 +0100
Subject: [PATCH v3 14/17] MIPS: mobileye: eyeq5: add OLB reset controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-14-392b010b8281@bootlin.com>
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

Add the devicetree node for the reset controller on the Mobileye EyeQ5
platform. It appears as a subnode to the OLB syscon as its registers
are located in this shared register region.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 935c095d1423..a246df6e3c85 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -110,6 +110,11 @@ clocks: clock-controller {
 				clocks = <&xtal>;
 				clock-names = "ref";
 			};
+
+			reset: reset-controller {
+				compatible = "mobileye,eyeq5-reset";
+				#reset-cells = <2>;
+			};
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.0


