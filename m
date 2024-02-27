Return-Path: <linux-kernel+bounces-83423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3018698E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D5E1C23394
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3197151CD3;
	Tue, 27 Feb 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mlsYqbSF"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B714CAC8;
	Tue, 27 Feb 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045008; cv=none; b=KFF2nHWw78VSajPo4LoNimsSHeiKxLymzAKQjCSvbvv40fled2C3bbQviROg3+V2uxlbMYjCUb+f9bDm3TIAFfzCL8aC9BMZCL+ISYVIKU6IrJPmiKMsZqZabdfhK5vmWkoEOQkncGl7Merl0J7H2hJ/KepfnlzpBa2Voouul/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045008; c=relaxed/simple;
	bh=wPtpiDRgxKHfD1bMQTt+e880G9bYUvNvMEeUYVBFiLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6z8qja97OLYqFyJuzJoQgfsMiC7EV186lpNNQyVLnP4JPrUDK9Z2wVFbDi2JvPOEEz8CTyv0jdcDkpElDMhDpGrQwbWHM3OuWI8Bw8aASBOa6//YEywJd8/4RQW1Dri+AV/yYlmyXBnTHRHoTm5psjdMabdssvI2bUbGQX9xSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mlsYqbSF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A19A20008;
	Tue, 27 Feb 2024 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709045002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP0wJc1YkEML4peKWNYGGrLBrWszFL1m98G5gSNq3Gk=;
	b=mlsYqbSFyHrLJMgaeDwhYNLSEykPotUfmM5Oe7oUyAAiSY34lL+hKOWHV7VAntV5OK9Ny6
	MGVRfDGBTLeM6m5rve7OTmVYkcMAYZf+DpUaYaFSqr9dS+6orqMpUeXsyE1TMc289ZyQ41
	zalV65SDvGUSp9nek2/WFMmqxsW+LufuEFOPSDniHIfsNp6ePuGEL1/WsB1SXCoCIoWbGR
	UqgXTntubNLVrEzSmTAVza3krAdj/LTPpTaGZnqUUl/qM45RjDcrRd7ytkSatsxelyLTQy
	JOEhhcTW3vN4A+kDYRqD2qEkk8PjTXWZ117cdYVrmbX+Sp8D9BtnURdx02tzdg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:55 +0100
Subject: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
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

Integrate the regulator framework to the PSE framework for enhanced
access to features such as voltage, power measurement, and limits, which
are akin to regulators. Additionally, PSE features like port priorities
could potentially enhance the regulator framework. Note that this
integration introduces some implementation complexity, including wrapper
callbacks and nested locks, but the potential benefits make it worthwhile.

Regulator are using enable counter with specific behavior.
Two calls to regulator_disable will trigger kernel warnings.
If the counter exceeds one, regulator_disable call won't disable the
PSE PI. These behavior isn't suitable for PSE control.
Added a boolean 'enabled' state to prevent multiple calls to
regulator_enable/disable. These calls will only be called from PSE
framework as it won't have any regulator children, therefore no mutex are
needed to safeguards this boolean.

regulator_get uses the consumer device pointer therefore of_pse_control_get
is modified accordingly to pass the PSE consumer device alongside its
device node.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch

Changes in v4:
- Remove the nested lock as the regulator_enable/disable ops will only
  be called from the PSE framework. No need to protect the 'enabled'
  boolean.
- Update regulator to current instead of voltage.
---
 drivers/net/mdio/fwnode_mdio.c     |  29 +++---
 drivers/net/pse-pd/pse_core.c      | 192 +++++++++++++++++++++++++++++++++----
 drivers/net/pse-pd/pse_regulator.c |  48 ++++++----
 include/linux/pse-pd/pse.h         |  18 +++-
 4 files changed, 230 insertions(+), 57 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index fd02f5cbc853..aa20b2ac7f2d 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -17,19 +17,17 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
 static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode)
+dev_find_pse_control(struct device *dev)
 {
 	struct pse_control *psec;
-	struct device_node *np;
 
 	if (!IS_ENABLED(CONFIG_PSE_CONTROLLER))
 		return NULL;
 
-	np = to_of_node(fwnode);
-	if (!np)
+	if (!dev->of_node)
 		return NULL;
 
-	psec = of_pse_control_get(np);
+	psec = of_pse_control_get(dev, dev->of_node);
 	if (PTR_ERR(psec) == -ENOENT)
 		return NULL;
 
@@ -120,15 +118,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	u32 phy_id;
 	int rc;
 
-	psec = fwnode_find_pse_control(child);
-	if (IS_ERR(psec))
-		return PTR_ERR(psec);
-
 	mii_ts = fwnode_find_mii_timestamper(child);
-	if (IS_ERR(mii_ts)) {
-		rc = PTR_ERR(mii_ts);
-		goto clean_pse;
-	}
+	if (IS_ERR(mii_ts))
+		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
@@ -161,6 +153,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 			goto clean_phy;
 	}
 
+	psec = dev_find_pse_control(&phy->mdio.dev);
+	if (IS_ERR(psec)) {
+		rc = PTR_ERR(psec);
+		goto unregister_phy;
+	}
+
 	phy->psec = psec;
 
 	/* phy->mii_ts may already be defined by the PHY driver. A
@@ -172,12 +170,13 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	return 0;
 
+unregister_phy:
+	if (is_acpi_node(child) || is_of_node(child))
+		phy_device_remove(phy);
 clean_phy:
 	phy_device_free(phy);
 clean_mii_ts:
 	unregister_mii_timestamper(mii_ts);
-clean_pse:
-	pse_control_put(psec);
 
 	return rc;
 }
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a2eb9a424668..58113718a47b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -8,6 +8,8 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
@@ -16,12 +18,14 @@ static LIST_HEAD(pse_controller_list);
  * struct pse_control - a PSE control
  * @pcdev: a pointer to the PSE controller device
  *         this PSE control belongs to
+ * @ps: PSE PI supply of the PSE control
  * @list: list entry for the pcdev's PSE controller list
  * @id: ID of the PSE line in the PSE controller device
  * @refcnt: Number of gets of this pse_control
  */
 struct pse_control {
 	struct pse_controller_dev *pcdev;
+	struct regulator *ps;
 	struct list_head list;
 	unsigned int id;
 	struct kref refcnt;
@@ -160,13 +164,121 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+static int pse_pi_is_enabled(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_is_enabled)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_is_enabled(pcdev, id);
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
+static int pse_pi_enable(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_enable)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_enable(pcdev, id);
+	if (!ret)
+		pcdev->pi[id].enabled = 1;
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
+static int pse_pi_disable(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_disable)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_disable(pcdev, id);
+	if (!ret)
+		pcdev->pi[id].enabled = 0;
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
+static const struct regulator_ops pse_pi_ops = {
+	.is_enabled = pse_pi_is_enabled,
+	.enable = pse_pi_enable,
+	.disable = pse_pi_disable,
+};
+
+static const struct regulator_init_data pse_pi_initdata = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static int
+devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
+			       char *name, int id)
+{
+	struct regulator_config rconfig = {0};
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+
+	rdesc = devm_kzalloc(pcdev->dev, sizeof(*rdesc), GFP_KERNEL);
+	if (!rdesc)
+		return -ENOMEM;
+
+	/* Regulator descriptor id have to be the same as its associated
+	 * PSE PI id for the well functioning of the PSE controls.
+	 */
+	rdesc->id = id;
+	rdesc->name = name;
+	rdesc->type = REGULATOR_CURRENT;
+	rdesc->ops = &pse_pi_ops;
+	rdesc->owner = pcdev->owner;
+
+	rconfig.dev = pcdev->dev;
+	rconfig.driver_data = pcdev;
+	rconfig.init_data = &pse_pi_initdata;
+
+	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);
+	if (IS_ERR(rdev)) {
+		dev_err_probe(pcdev->dev, PTR_ERR(rdev),
+			      "Failed to register regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	pcdev->pi[id].rdev = rdev;
+
+	return 0;
+}
+
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
-	int ret;
+	size_t reg_name_len;
+	int ret, i;
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
@@ -184,6 +296,31 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			return ret;
 	}
 
+	/* Each regulator name len is pcdev dev name + 7 char +
+	 * int max digit number (10) + 1
+	 */
+	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
+
+	/* Register PI regulators */
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		char *reg_name;
+
+		/* Do not register regulator for PIs not described */
+		if (!pcdev->of_legacy && !pcdev->pi[i].np)
+			continue;
+
+		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
+		if (!reg_name)
+			return -ENOMEM;
+
+		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
+			 dev_name(pcdev->dev), i);
+
+		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
@@ -281,6 +418,9 @@ void pse_control_put(struct pse_control *psec)
 	if (IS_ERR_OR_NULL(psec))
 		return;
 
+	if (psec->pcdev->pi[psec->id].enabled)
+		regulator_disable(psec->ps);
+
 	mutex_lock(&pse_list_mutex);
 	__pse_control_put_internal(psec);
 	mutex_unlock(&pse_list_mutex);
@@ -288,9 +428,11 @@ void pse_control_put(struct pse_control *psec)
 EXPORT_SYMBOL_GPL(pse_control_put);
 
 static struct pse_control *
-pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
+pse_control_get_internal(struct device *dev, struct pse_controller_dev *pcdev,
+			 unsigned int index)
 {
 	struct pse_control *psec;
+	int ret;
 
 	lockdep_assert_held(&pse_list_mutex);
 
@@ -310,6 +452,20 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 		return ERR_PTR(-ENODEV);
 	}
 
+	psec->ps = devm_regulator_get_exclusive(dev,
+						rdev_get_name(pcdev->pi[index].rdev));
+	if (IS_ERR(psec->ps)) {
+		kfree(psec);
+		return ERR_CAST(psec->ps);
+	}
+
+	ret = regulator_is_enabled(psec->ps);
+	if (ret < 0) {
+		kfree(psec);
+		return ERR_PTR(ret);
+	}
+	pcdev->pi[index].enabled = ret;
+
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
@@ -344,7 +500,8 @@ static int psec_id_legacy_xlate(struct pse_controller_dev *pcdev,
 	return pse_spec->args[0];
 }
 
-struct pse_control *of_pse_control_get(struct device_node *node)
+struct pse_control *of_pse_control_get(struct device *dev,
+				       struct device_node *node)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -394,7 +551,7 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
-	psec = pse_control_get_internal(pcdev, psec_id);
+	psec = pse_control_get_internal(dev, pcdev, psec_id);
 
 out:
 	mutex_unlock(&pse_list_mutex);
@@ -443,21 +600,24 @@ int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config)
 {
-	const struct pse_controller_ops *ops;
-	int err;
-
-	ops = psec->pcdev->ops;
+	int err = 0;
 
-	if (!ops->ethtool_set_config) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not configuration");
-		return -EOPNOTSUPP;
+	/* Look at enabled status to not call regulator_enable or
+	 * regulator_disable twice creating a regulator counter mismatch
+	 */
+	switch (config->c33_admin_control) {
+	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
+		if (!psec->pcdev->pi[psec->id].enabled)
+			err = regulator_enable(psec->ps);
+		break;
+	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
+		if (psec->pcdev->pi[psec->id].enabled)
+			err = regulator_disable(psec->ps);
+		break;
+	default:
+		err = -EOPNOTSUPP;
 	}
 
-	mutex_lock(&psec->pcdev->lock);
-	err = ops->ethtool_set_config(psec->pcdev, psec->id, extack, config);
-	mutex_unlock(&psec->pcdev->lock);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 547af384764b..64ab36974fe0 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -24,37 +24,41 @@ static struct pse_reg_priv *to_pse_reg(struct pse_controller_dev *pcdev)
 }
 
 static int
-pse_reg_ethtool_set_config(struct pse_controller_dev *pcdev, unsigned long id,
-			   struct netlink_ext_ack *extack,
-			   const struct pse_control_config *config)
+pse_reg_pi_enable(struct pse_controller_dev *pcdev, int id)
 {
 	struct pse_reg_priv *priv = to_pse_reg(pcdev);
 	int ret;
 
-	if (priv->admin_state == config->podl_admin_control)
-		return 0;
-
-	switch (config->podl_admin_control) {
-	case ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED:
-		ret = regulator_enable(priv->ps);
-		break;
-	case ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED:
-		ret = regulator_disable(priv->ps);
-		break;
-	default:
-		dev_err(pcdev->dev, "Unknown admin state %i\n",
-			config->podl_admin_control);
-		ret = -ENOTSUPP;
-	}
-
+	ret = regulator_enable(priv->ps);
 	if (ret)
 		return ret;
 
-	priv->admin_state = config->podl_admin_control;
+	priv->admin_state = ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED;
+	return 0;
+}
+
+static int
+pse_reg_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_reg_priv *priv = to_pse_reg(pcdev);
+	int ret;
 
+	ret = regulator_disable(priv->ps);
+	if (ret)
+		return ret;
+
+	priv->admin_state = ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED;
 	return 0;
 }
 
+static int
+pse_reg_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_reg_priv *priv = to_pse_reg(pcdev);
+
+	return regulator_is_enabled(priv->ps);
+}
+
 static int
 pse_reg_ethtool_get_status(struct pse_controller_dev *pcdev, unsigned long id,
 			   struct netlink_ext_ack *extack,
@@ -80,7 +84,9 @@ pse_reg_ethtool_get_status(struct pse_controller_dev *pcdev, unsigned long id,
 
 static const struct pse_controller_ops pse_reg_ops = {
 	.ethtool_get_status = pse_reg_ethtool_get_status,
-	.ethtool_set_config = pse_reg_ethtool_set_config,
+	.pi_enable = pse_reg_pi_enable,
+	.pi_is_enabled = pse_reg_pi_is_enabled,
+	.pi_disable = pse_reg_pi_disable,
 };
 
 static int
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 522115cc6cef..a3e297cc2150 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -55,10 +55,10 @@ struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
 		unsigned long id, struct netlink_ext_ack *extack,
 		struct pse_control_status *status);
-	int (*ethtool_set_config)(struct pse_controller_dev *pcdev,
-		unsigned long id, struct netlink_ext_ack *extack,
-		const struct pse_control_config *config);
 	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
+	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 };
 
 struct module;
@@ -90,10 +90,14 @@ struct pse_pi_pairset {
  *
  * @pairset: table of the PSE PI pinout alternative for the two pairset
  * @np: device node pointer of the PSE PI node
+ * @rdev: regulator represented by the PSE PI
+ * @enabled: PI enabled state
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
 	struct device_node *np;
+	struct regulator_dev *rdev;
+	bool enabled;
 };
 
 /**
@@ -107,6 +111,8 @@ struct pse_pi {
  * @of_pse_n_cells: number of cells in PSE line specifiers
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
+ * @lock_owner: current owner of the mutex
+ * @ref_cnt: mutex's reference count
  * @types: types of the PSE controller
  * @pi: table of PSE PIs described in this controller device
  * @of_legacy: flag set if the pse_pis devicetree node is not used
@@ -132,7 +138,8 @@ struct device;
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev);
 
-struct pse_control *of_pse_control_get(struct device_node *node);
+struct pse_control *of_pse_control_get(struct device *dev,
+				       struct device_node *node);
 void pse_control_put(struct pse_control *psec);
 
 int pse_ethtool_get_status(struct pse_control *psec,
@@ -147,7 +154,8 @@ bool pse_has_c33(struct pse_control *psec);
 
 #else
 
-static inline struct pse_control *of_pse_control_get(struct device_node *node)
+static inline struct pse_control *of_pse_control_get(struct device *dev,
+						     struct device_node *node)
 {
 	return ERR_PTR(-ENOENT);
 }

-- 
2.25.1


