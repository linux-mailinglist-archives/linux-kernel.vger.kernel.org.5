Return-Path: <linux-kernel+bounces-65532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B580F854E53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725E928326A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3060BA5;
	Wed, 14 Feb 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Apa3abPS"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE164CC9;
	Wed, 14 Feb 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927905; cv=none; b=RyNawBzkWFHJmOPcTbEDPkmouVLuYSI1ZSKnBHoyJzxKkFDdQ9rajVkgUJQ6059yAe9qPN26jy8v1fEAq00rNwZghXwTf+D/EImFx1MDeZnY2h2S+th1XJQdT2twHpLzDFpX5rT29PgfU/ivlXPvcVgo0bc3/3YZ5lI3+Xtfuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927905; c=relaxed/simple;
	bh=jE59l1hQdJ6b8RKKgPMwUnCh0zBDZH06+B3YTqOvXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHFCK6cYm1YdZnbMZUlry2BGxnEVTA7AH8OR91xG+7wwb86oEydurb8prGRMYrtJV3PqffYwH2OSbVa46IFa0MLxfet+jh3Ase0XKTQQBga3YkAf3Xec+N7y/Ziiz7EqNOKdrQ+Vtf3O8gg1xt9/kxUecGlQ0NhJntKlhqq1Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Apa3abPS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7097760017;
	Wed, 14 Feb 2024 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcvezGLfQdXtUL5sGSqQSv1w307vpQUkHkSaTgIyV2Y=;
	b=Apa3abPSfUCEdMoLJGpsUkBANHMIMVnSkGBGpZB9hl69DgPzzWcQHmMQy1ohL+obotpQV+
	qxez17vO9hEi3Z0byd+wkKBLSI0W54KJx8N18O48hMkUAZjkSaTCCllo7TqUXqhDy7aoqy
	RHvNp12iZJ5XEag2sgimN1SgRTojKee+f6cbdIqY6+L3J/Ny0U6HRvQ6h+GD2WaqsYRCvt
	6yk7oohDAmloxgKw0fqnQGuUeHgZjIXW8GLmCe2D9KhAvXyrUL50eU6E9MWzzGnRWSE2Fv
	6rr6eOcH+XTXcySgwF9ikCRqkvrhrS6SeTYYROB7I6nZ4++VfxG7ue/fDRa+xQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:15 +0100
Subject: [PATCH 22/23] MIPS: mobileye: eyeq5: add resets to GPIO banks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-22-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

The two GPIO banks share a single reset line.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 0f18ac73620b..5f00d129c057 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -170,6 +170,7 @@ gpio0: gpio@1400000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			resets = <&reset 0 26>;
 		};
 
 		gpio1: gpio@1500000 {
@@ -183,6 +184,7 @@ gpio1: gpio@1500000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			resets = <&reset 0 26>;
 		};
 	};
 };

-- 
2.43.1


