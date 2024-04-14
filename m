Return-Path: <linux-kernel+bounces-144196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5938A42FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A071F212A1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B445C8E4;
	Sun, 14 Apr 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aQCVfiwD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6B5B682;
	Sun, 14 Apr 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104592; cv=none; b=Aw8NKmbaqT2Agv3gBiMfOCXq5/YV0kzy//uCRdDNjLuc8PBbNxkRF+ZQhWjGs1kRDFu89LfKeBrPGS+uFZhuYwxTl49hH7zeSVeuBFBkXE25g3eQNQmvGvsCy3oEAsfq9WQjJirkQ07jqALPAVEIN3sG9cSD5CBBG59Pu1Qlurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104592; c=relaxed/simple;
	bh=dtSdtLY5S1JCjKQc288BE2kE0KGyNXIy8KTYVYnl+8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFTfpl8Jc7pmwh95hqMWrgLgmb8P2yTAckVCHxm/OizEZ6qXiEcBMbzWDyVsMoK3nAD/QwvDOyT/ZVLt8tH6ZdHXyXh/lXuLerkbjNeVD1sNZNFkHlabCB8toteYAyjkAG+sQOOeu6pImoGzbkTT4mLavwo+n8BseJqrBKxTOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aQCVfiwD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1240C0002;
	Sun, 14 Apr 2024 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2h2/SifOa2nfmPr79ocv/8rZS3VlzAogGYtg+7WevQ=;
	b=aQCVfiwDEGSrqyvEYQ2+ooGXulORN5+Ui6Kza0MeChP34xq0DsB61Hnw7AwcKqCGHQzp6D
	dJ598cn9fv9EJee9h3fSNnWakg+qtk6NmJ4XaImRQ8GnzKTvObkfbPea35F2hZ89FFTqFr
	lZMRzB5IL8T4F6GoGL8CO3rUBGLuLmoQyxrqGSUkcqqcbmiH8Rx7YFGOh1Ys4xzBmSmgHC
	rr9Y6yP9IK5p93EStl86lmlmPWdCw35+p4nwnqau5BJDkr/Xlbq/TpCx3Wq8X/CNw1xiow
	ZEYzrSIH3E3nQL8Vt3dE9X1zvHtYIdIUsZRZxpQJMI7fpNFP78iu+dCla5y5xw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:54 +0200
Subject: [PATCH net-next v8 05/17] net: pse-pd: Introduce PSE types
 enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-5-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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
index 29ac06d66228..baf2b8e0d72f 100644
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


