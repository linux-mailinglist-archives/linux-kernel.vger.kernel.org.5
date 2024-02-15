Return-Path: <linux-kernel+bounces-67265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731848568D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B78928607F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152F137C37;
	Thu, 15 Feb 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dQxJTlQX"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CE135A78;
	Thu, 15 Feb 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013011; cv=none; b=EKCDE2cEiAsNpPGUOz6fMR5jGJg2e/IP3ev7Skx2SRvu7rlYNEoA7a8CRF5p0P8CinopzG7Z9YtxHYaUDp0VxTo9/mE3hJnuDzfhr5CONdOgrs/VU4LheJSX2kf7XlkIbpaAl3ck4PhhpUJtKm+c855A4CpYIel8ftIqgMa5FGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013011; c=relaxed/simple;
	bh=UY+Olov0pqFpwRUMX5nn7XVoTupiRCg1p/+5IMf4gx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdCqatAC8QUV+dy7Vbx1l35eS0eCdytxBmiZoGJ4zwJKzq1wHh+hScEY9DiVgJ5CsBg5lHieYOVaFfnakF3iKbnEU3NUK4mQWBV3Q+s5OHH1PYT+VFSGTgJU72JVrA+u9Uott/Ssw32rcfcIo2uQryODtHJvcrfWHSI2s3KvKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dQxJTlQX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FCA420015;
	Thu, 15 Feb 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LSoUlK48psgrf3t++4V6weY4ZsbfKRfzUaFraUGeVY=;
	b=dQxJTlQX73OiyTN2df5s3b3VhjC5tUXFG+Fm+8Ae8eGY5bJ9zreDIk8EpOn75DQGDP+cMM
	UygwUe0zJwTxHQkYVijGS+P18gi7ySVCx8/yxCd3BJkArjt8luRg6c/9kAqsGpVHp1y+vd
	kwN7dQ2iuc1tVVcTV/uXapc7R9lDsjLTkIidBeI8rKOq7J6Ni0/oq9AtHAXAebzws1+zpU
	qZ3dWs6oVPrFWjCK+4FtV153BiifppMqNvb1wp8da8SAgYccoiFwtMCbY8H6qWX9doBX0G
	lLTLECwStdD40eGOCxnS34AqfjxZO8/lx9gX99Bk7Cl7odCw02njOIDykGSbrQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:46 +0100
Subject: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
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

Introduce an enumeration to define PSE types (C33 or PoDL),
utilizing a bitfield for potential future support of both types.
Include 'pse_get_types' helper for external access to PSE type info.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Rename PSE_POE to PSE_C33 to have naming consistency.
- Use "static inline" instead of simple static in the header

Changes in v3:
- Move the pse_type enum in uapi.
- Replace pse_get_types helper by pse_has_podl and pse_has_c33.
---
 drivers/net/pse-pd/pse_core.c      | 12 ++++++++++++
 drivers/net/pse-pd/pse_regulator.c |  1 +
 include/linux/pse-pd/pse.h         | 16 ++++++++++++++++
 include/uapi/linux/pse.h           | 23 +++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 146b81f08a89..090e04c32f9e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -312,3 +312,15 @@ int pse_ethtool_set_config(struct pse_control *psec,
 	return err;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
+
+bool pse_has_podl(struct pse_control *psec)
+{
+	return psec->pcdev->types & PSE_PODL;
+}
+EXPORT_SYMBOL_GPL(pse_has_podl);
+
+bool pse_has_c33(struct pse_control *psec)
+{
+	return psec->pcdev->types & PSE_C33;
+}
+EXPORT_SYMBOL_GPL(pse_has_c33);
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 1dedf4de296e..e34ab8526067 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -116,6 +116,7 @@ pse_reg_probe(struct platform_device *pdev)
 	priv->pcdev.owner = THIS_MODULE;
 	priv->pcdev.ops = &pse_reg_ops;
 	priv->pcdev.dev = dev;
+	priv->pcdev.types = PSE_PODL;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret) {
 		dev_err(dev, "failed to register PSE controller (%pe)\n",
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index be4e5754eb24..f006cbdf8b3b 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -8,6 +8,7 @@
 #include <linux/ethtool.h>
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
+#include <uapi/linux/pse.h>
 
 struct phy_device;
 struct pse_controller_dev;
@@ -77,6 +78,7 @@ struct pse_control;
  *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
+ * @types: types of the PSE controller
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -89,6 +91,7 @@ struct pse_controller_dev {
 			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
+	u32 types;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
@@ -108,6 +111,9 @@ int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
 
+bool pse_has_podl(struct pse_control *psec);
+bool pse_has_c33(struct pse_control *psec);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node)
@@ -133,6 +139,16 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
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
diff --git a/include/uapi/linux/pse.h b/include/uapi/linux/pse.h
new file mode 100644
index 000000000000..ebd9b4be9d9d
--- /dev/null
+++ b/include/uapi/linux/pse.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Userspace API for Power Sourcing Equipment
+ *
+ * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
+ */
+#ifndef _PSE_CONTROLLER_H
+#define _PSE_CONTROLLER_H
+
+/**
+ * enum - Types of PSE controller.
+ *
+ * @PSE_UNKNOWN: Type of PSE controller is unknown
+ * @PSE_PODL: PSE controller which support PoDL
+ * @PSE_C33: PSE controller which support Clause 33 (PoE)
+ */
+enum {
+	PSE_UNKNOWN =	1 << 0,
+	PSE_PODL =	1 << 1,
+	PSE_C33 =	1 << 2,
+};
+
+#endif /* _PSE_CONTROLLER_H */

-- 
2.25.1


