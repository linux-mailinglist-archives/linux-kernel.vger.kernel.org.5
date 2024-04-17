Return-Path: <linux-kernel+bounces-148691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE48A863D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C4C1F228E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E11428FF;
	Wed, 17 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I8yd9ZF3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C8142640;
	Wed, 17 Apr 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364858; cv=none; b=AoXdmyzF0awbqkHfSk+dXK3uFPnLjYxYvCVkm/47WEX4mq6zLx0bD94ktV0yWXvONuCRTT7sZAxnz789jV+Y1eult6GO5wPTnX414DfNAcrwFSmGJwqtYJI/6QxVcMVWkiSISBhK0jtkeHVmH9qwojjiUjewSln2+fnECqSX1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364858; c=relaxed/simple;
	bh=7yzi97Zi+bCMwtz1p8JacgcNWPsCua5gj4g4Wzfu7IY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNRk4BzRFFB209Re8/F+tSMdC8p3RbmdEfE61Fc0N1sZqar09ERc1rXMPgEZtQhGD1CwcgiK829iRW5qBDnY4UIoMTuvQ6Nd+yi7IaF0Y0cSIMM7t/EGXJKI0Tw8jToXUZFb+AOuIUx+nRQPj6QPcBSqumwmzB2mYzTfgNRP2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I8yd9ZF3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A2181BF214;
	Wed, 17 Apr 2024 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0crV4Qgy689LLIUw77xbTVbl+c1fhIBuxMGWIT7FdA=;
	b=I8yd9ZF3uQICf9KGe62bsTN3YkjC5ycxcXJMgAAwi6N/fcvgbDQamoYJcY+qgIGcRQBFNo
	36Yxb/9bdNfqEg6WBooTskHfbtnvVAazyjg9+r+xHzzWhQSghcRfGXf8KK95zrhslmwCeM
	Qu9ZEYrkmFHZUIsrDAvzLjL0csbdhPedwl5IvAQ2I+wuf9uhAA5m2Zn2YV+vTbqQXDEIvj
	eq4s8nm7XqSFtUJsmP7x1OtyJvt4Tc3VScJASas4IruiRpWBieIYwk+QOkHibpY0IFjdoc
	4xMAtohairUAB++P5soLdSjLDtRnyLD4MlkHmPQa6V5aGwm5ArVl9Akfoeb/Zg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 17 Apr 2024 16:39:50 +0200
Subject: [PATCH net-next v9 02/14] net: pse-pd: Introduce PSE types
 enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-feature_poe-v9-2-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce an enumeration to define PSE types (C33 or PoDL),
utilizing a bitfield for potential future support of both types.
Include 'pse_get_types' helper for external access to PSE type info.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Rename PSE_POE to PSE_C33 to have naming consistency.
- Use "static inline" instead of simple static in the header

Changes in v3:
- Move the pse_type enum in uapi.
- Replace pse_get_types helper by pse_has_podl and pse_has_c33.

Changes in v5:
- Move the pse types enum in ethtool.
- Add ethtool prefix to the value.

Changes in v6:
- Fix a kdoc nit.
---
 drivers/net/pse-pd/pse_core.c      | 12 ++++++++++++
 drivers/net/pse-pd/pse_regulator.c |  1 +
 include/linux/pse-pd/pse.h         | 15 +++++++++++++++
 include/uapi/linux/ethtool.h       | 12 ++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 146b81f08a89..fed006cbc185 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -312,3 +312,15 @@ int pse_ethtool_set_config(struct pse_control *psec,
 	return err;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
+
+bool pse_has_podl(struct pse_control *psec)
+{
+	return psec->pcdev->types & ETHTOOL_PSE_PODL;
+}
+EXPORT_SYMBOL_GPL(pse_has_podl);
+
+bool pse_has_c33(struct pse_control *psec)
+{
+	return psec->pcdev->types & ETHTOOL_PSE_C33;
+}
+EXPORT_SYMBOL_GPL(pse_has_c33);
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 1dedf4de296e..547af384764b 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -116,6 +116,7 @@ pse_reg_probe(struct platform_device *pdev)
 	priv->pcdev.owner = THIS_MODULE;
 	priv->pcdev.ops = &pse_reg_ops;
 	priv->pcdev.dev = dev;
+	priv->pcdev.types = ETHTOOL_PSE_PODL;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret) {
 		dev_err(dev, "failed to register PSE controller (%pe)\n",
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index be4e5754eb24..19589571157f 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -77,6 +77,7 @@ struct pse_control;
  *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
+ * @types: types of the PSE controller
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -89,6 +90,7 @@ struct pse_controller_dev {
 			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
+	enum ethtool_pse_types types;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -108,6 +110,9 @@ int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
 
+bool pse_has_podl(struct pse_control *psec);
+bool pse_has_c33(struct pse_control *psec);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node)
@@ -133,6 +138,16 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
 	return -ENOTSUPP;
 }
 
+static inline bool pse_has_podl(struct pse_control *psec)
+{
+	return false;
+}
+
+static inline bool pse_has_c33(struct pse_control *psec)
+{
+	return false;
+}
+
 #endif
 
 #endif
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 7b9a3d890949..041e09c3515d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -752,6 +752,18 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_pse_types - Types of PSE controller.
+ * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
+ * @ETHTOOL_PSE_PODL: PSE controller which support PoDL
+ * @ETHTOOL_PSE_C33: PSE controller which support Clause 33 (PoE)
+ */
+enum ethtool_pse_types {
+	ETHTOOL_PSE_UNKNOWN =	1 << 0,
+	ETHTOOL_PSE_PODL =	1 << 1,
+	ETHTOOL_PSE_C33 =	1 << 2,
+};
+
 /**
  * enum ethtool_c33_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState

-- 
2.34.1


