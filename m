Return-Path: <linux-kernel+bounces-65540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F1854E73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBE1F28366
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FC60EE4;
	Wed, 14 Feb 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IeJl9k0B"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D876025C;
	Wed, 14 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928080; cv=none; b=ER3J8cRAUnxC2qBLDyRFEdIaqrAMGhhDIDg553Mu2nWJzsn5AOxQ5lJx2mMEiCb+eI89uifNWe4X+0dgV52Z12w+dsXpwP+iiTTEVlOrrY8Q5usvYC/81oiCf8Y3oJzOEpO+KZU4JgaERob0GuWq5nerbwdxUMioAFN2O3TeF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928080; c=relaxed/simple;
	bh=c/Rgi6OZdN5UF/IjNS97V3p/dpLK4o5ujnnGuwoRnN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyhORioHVq1beIFxfiIrSp64Su3YnS2FGU8ZZrvzqWCCxsvBieeFT6imB3DKKT0bN2WG1cA+P/MTCdTjCitdhoWn0LtVjv8lJRj/hsu5EBAGG6V0jKE/fd1ZY9GSpEryJRHIJT9yfYwxIiJhAYtbH7it7CovrZhR+ndrnNEvHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IeJl9k0B; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CF2E2C36E0;
	Wed, 14 Feb 2024 16:24:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 712CC60011;
	Wed, 14 Feb 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Jcap2Chj1MHbo2CpOWyieR81O/+3SAG9cXjwd6SZI=;
	b=IeJl9k0Baf99CIXWtvGdgtOLUQhdIEchFjR83qZtjXkrtyfqZMhVABudt0VVg6CuCplatA
	KxJJvg+rVogBnoIkLhVkNfOUEIAYwhSiMwNqfA/3z88EjyVGtYQpHZ/5+rvI6eBUH+/vLD
	YLA2n0nD8TRO5+DEGCtPAJhJzmTSQb4gmcxIjJPw/m9aaNkjREvJ+KqTlcS/rUVhwKsH6u
	RXYuSq9pDQ72z02XfAAqDXnsLZvyGfogiE+UUUoIiKmwJxIbcwIqh9CpLYhHYAQnUntrqD
	UpZr8n42uiPWZW0Uf5yYUcOPXNphqg4Wmu+XLGDQ+hcev5N5a++B1qQJfJ0qeg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:23:55 +0100
Subject: [PATCH 02/23] dt-bindings: gpio: nomadik: add optional ngpios
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-2-f88c0ccf372b@bootlin.com>
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

This GPIO controller can support a lesser number of GPIOs than 32.
Express that in devicetree using an optional, generic property.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index a999908173d2..bbd23daed229 100644
--- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -50,6 +50,10 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  ngpios:
+    minimum: 0
+    maximum: 32
+
 required:
   - compatible
   - reg

-- 
2.43.1


