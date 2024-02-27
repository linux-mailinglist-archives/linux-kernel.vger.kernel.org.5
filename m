Return-Path: <linux-kernel+bounces-83414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAA8698BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2461C22957
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F45148305;
	Tue, 27 Feb 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TZTSyRxl"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D313B29B;
	Tue, 27 Feb 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044998; cv=none; b=bB+Xh2IggGzq9zosH+IHiSWl/CgSAExINLDS5y+ST18TRYEcA1bvrHyDj7FtxmKj9MIuBECCy9Wokku7ZDKYvrRbUh+9DcGiVl8PNC6UsOnGeyCNk8l6nDKll8SSPKA6k8x6oLmyuiYYT4II+DemkF3VPwmPcIWW9Z6B1GskErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044998; c=relaxed/simple;
	bh=3Dn5Z7gs9ooWjrdQoGkSDWdaFikj6YkWqQme8khskjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=becLDcLZK4IUWgo+k0EQCJoDUpdVm0T2bKVHDCwDZxKHZC3T+Lz7A6AbICGchqQ66YCR5kMmwoWagz7iNP0y/ZCGBJegZl0/dzEJ5g2qrlfJZUMayDcN2TZUFiInhe/T8svSvH16hlz7q2rbuPaCWYyD9leQ5w/Z8ZX7GaJMqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TZTSyRxl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2612220014;
	Tue, 27 Feb 2024 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709044988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AT7HF8blg+QUl+1AkEF4c8gKh4Um8SfTBovXNKYLb20=;
	b=TZTSyRxlWWjFgduXF3LReHlKZFl749ZA2QVAkyNuvPYKGn3Oeqoe6CySRaIxmibXvUEXB/
	T4WAxdXbTvZqAL+zcbgYdQyniUof6/P436iQDZB6BK4S2n+Ndujfz4K45S5GMSo7hdk0ev
	h+STWA9s5YX3Gj9MnFnf1VZNAJfVj4tyUVbgnSPe2amE1Wi8QLOiExsQQRYh4uAvW4HiPt
	qAshu0f1bO1oSseyJgM3xGgb8SM0TzosZ5HQqxjUh31NPMvZUuIjJ2ikyE1na/KcjU5YZ0
	UibA57DEdoeSLE9mTMPF6TXtJi4Zht9pELJMCdSxix/xb0oS3TN3u4nWgoqHDw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:44 +0100
Subject: [PATCH net-next v5 02/17] of: property: Add fw_devlink support for
 pse parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-2-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
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
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

This allows fw_devlink to create device links between consumers of
a PSE and the supplier of the PSE.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index b71267c6667c..c14001d40cd2 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1240,6 +1240,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
+DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1344,6 +1345,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_backlight, },
 	{ .parse_prop = parse_panel, },
 	{ .parse_prop = parse_msi_parent, },
+	{ .parse_prop = parse_pses, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },

-- 
2.25.1


