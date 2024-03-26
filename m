Return-Path: <linux-kernel+bounces-119121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2488C470
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A8E1C2C5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97182867;
	Tue, 26 Mar 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYWa+s8h"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434B75814;
	Tue, 26 Mar 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461899; cv=none; b=mL7RYHuZlF3ezMbtFZeu5IdwuHESlf7qJj6lThbCthRRJDTBQwLZBM6TLy+mJoDRSJJr4+cCoiuRINXZm8JYyVfU05Hleot5a83O863sLe1yqauYK2fYuaFvC7/+wMV26b+5EqFpGr/ommazoxbezHQutK9BZoISaBzCBn1+J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461899; c=relaxed/simple;
	bh=2g+Rb4k6mwvnytIx+JbzdLKgrPbH2TQlVYzTmvcdeio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPhnbz6MsZ4WNJ6y2Ua778GW46W3sRS4FPEb34zRK4ojdnHtZ24HBlcT0FGJ+2AaEdcVLOctu+pbk3Tc3XXhLzFwoqYj1FwxfDTTPdVRrlV2UJAojX8TNxcOCmDv50t+xGAs3wa+CiEewZ2r/fYms3pNWs2jrVfk9fk3OJ79rQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYWa+s8h; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9B641C0009;
	Tue, 26 Mar 2024 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVKg1srvGV0u9Yby6NC6W19LV5l9sd0ycpn/q/ojt4I=;
	b=HYWa+s8hsWSFlC/DftzHqY1shXFc7Rbix12mT9oLWsinklkh3isV3LFIPSxIKQno7EjYaW
	VtW2xrEDLY59Mbve/VorK6jcyzNiPQsMIcAUr+WiYQHTUp9APmxMN82RVgg8TSzacHNlIT
	nL3VrgTzAH4dlaKfOVI5rJZL0TZv8Xy4dvYj0r0bONj8jfKQUH22lXZGHjNMi+5X5DFguC
	kWODYh6Mb9mMjZWlW4aedeGyltB/K28OZAhTDNicO1sOcsUvbkyYyKHBsh/0PVuyHiVsbG
	hB5aalx9fXTRdDuCRhX4inN4PazOv8xBeKt3grM8hRMVsaOsSp6du855p1qlCg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:39 +0100
Subject: [PATCH net-next v6 02/17] of: property: Add fw_devlink support for
 pse parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-2-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
In-Reply-To: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This allows fw_devlink to create device links between consumers of
a PSE and the supplier of the PSE.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a6358ee99b74..cc064151853e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1252,6 +1252,7 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
 DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
+DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1357,6 +1358,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_backlight, },
 	{ .parse_prop = parse_panel, },
 	{ .parse_prop = parse_msi_parent, },
+	{ .parse_prop = parse_pses, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },

-- 
2.25.1


