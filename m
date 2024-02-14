Return-Path: <linux-kernel+bounces-65536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2A854E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3E1F23852
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27260DDF;
	Wed, 14 Feb 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZT6oWVC"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5360254;
	Wed, 14 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928079; cv=none; b=hSBHw7FI5SikyvRsPuVVf5/yz1j1/cD5IOmUFL5HvGjEK98TILHxDJbcpcMud1yWw2KVLsk4UY9RzLofC9kqFTTatnrNXn6EG4IYAz2MLhBnrvS8YFsnVx6YKMrSXgzZHSdDOkDZsdUxWC59slg/Tpj2r966vJSWFIJ+5yc7dYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928079; c=relaxed/simple;
	bh=gkzIDPBhbpsxlhS4z5fA9N1ChaypZSZnRYF85URpX9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwNmPDigjzrs1CRkwxL+aXDWAcI3MoTrlxj2uAFcqLiHVHVQraiHO6YcF+8bkVeNNXgas4HH71K3fCp/p/TDPjXSo3fgQVmybmafQXQWrdlZoM0MkopAoUGWYvwXTdxbNSdCu1IEjrSRctjm8PRHUZzB+AsUgmhrjPlenIuEspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZT6oWVC; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1BE49C38A6;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E90CF6000C;
	Wed, 14 Feb 2024 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEGVQIPYrR9p4tX/tbtVIC0DOlSZ7UXY1VMCWpcAW7w=;
	b=fZT6oWVCx/rcP7GQqHgs39SJICb/r+M7nYb6geBYtNZi56fzkf123YVJ/3td9bkwglQrXh
	IPGssRSe3xsLloiVNvlItB5ng6o3mnNudCRXBR0qDAlTcW9mLHdfdVDBYliBt7IX5j2Dc7
	QO+Z4FvttrtMhSiCLSXHd6WCvT3cuRdrEyqI+WUfn79VoTqAVSK7rganJiKOIcu5ow4Crr
	xrddk+6vH5v5vgpWgZrAWj64ECbLCaxhPUAKa8YnwSwz4SuBJb/bPtupiveoL0gjpYmiMY
	fnsKUv/IY9O60Zl/B9VGw7GmsEACEOD1n7cSYm3IgFw9iMkipdevffzVJUxDmA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:23:57 +0100
Subject: [PATCH 04/23] dt-bindings: gpio: nomadik: add optional reset
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-4-f88c0ccf372b@bootlin.com>
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

Add optional reset device-tree property to the Nomadik GPIO controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index e44cf292bc6d..d104662ec445 100644
--- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -56,6 +56,9 @@ properties:
     minimum: 0
     maximum: 32
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.43.1


