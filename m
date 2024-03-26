Return-Path: <linux-kernel+bounces-119130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BA688C49A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F24302AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF412C810;
	Tue, 26 Mar 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FdHSr5mE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC012A143;
	Tue, 26 Mar 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461908; cv=none; b=ia9tZFWRfu0DJRvfcF3DqHN5MPOn74sqTyWhJH610nAfWwkM5IunMPD8tdHWejvXQvH7YHPWj3wyAX28Fu1WolSD3nmipQoTr86oPn+OHKf70Pzgpvitf3ruMbLsePB/uCOCfFH0OuMSJW1tcTucrk+wcjRAg2ohsEIjagLWItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461908; c=relaxed/simple;
	bh=d391lLs7D79BqDUcQxmiIlhC55qDrR5ahlc0w9/TwuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kN/3cvo5kFV3JZVdwhZ2ZZc4SMRiLAGQVYQCG3YlmftsEI4Qf9+4dgshd/HVV0DCdp5wu0mvpXGkLmVHlISFcHg6sVx1XT+MFiaoWhD1PyDpvNy/ETNjiG/qLu9v/hx5vZHwrQU+aIOGiZD3yKluUCIy/QW4Y4lua9MfIQFiIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FdHSr5mE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0D151C0011;
	Tue, 26 Mar 2024 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tolsrl7SMMHW6V5a8XI3GCJ2T+d01x4mu6liK5Y7vcU=;
	b=FdHSr5mEYNHo+rnbVR8OmEO0Z0wHSo4Dynkwa5YuBbZI+xGxDscFT2iSQBGwr12K/GB2LG
	pzMPEvAPoHTyVVfDs9X5LpRt9e+BjWjnr25LYs2xY4fws/FeUISz/VtCCvpgwzPGe2FiAc
	odzQxiLJgECugzCtrJWpmPtdlMO0FBV26Zw70qsP1ic1789DKBqNfU5Bi1b5sou1BRbuKw
	cQ0dgsn4pm9KEF4HptsBCyFDaR3tAo1yfopGONb8yc3V5aLp7t8i9CQTeUkOdaJ60Ch1g1
	Dd6m3xvzF+ItyzBTba42aLpN8hJ5eeJ+L0sEpKoxZflDghPIomkxeDxyzuM6TA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:50 +0100
Subject: [PATCH net-next v6 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-13-c1011b6ea1cb@bootlin.com>
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

Integrate the regulator framework to the PSE framework for enhanced
access to features such as voltage, power measurement, and limits, which
are akin to regulators. Additionally, PSE features like port priorities
could potentially enhance the regulator framework. Note that this
integration introduces some implementation complexity, including wrapper
callbacks, but the potential benefits make it worthwhile.

Regulator are using enable counter with specific behavior.
Two calls to regulator_disable will trigger kernel warnings.
If the counter exceeds one, regulator_disable call won't disable the
PSE PI. These behavior isn't suitable for PSE control.
Added a boolean 'enabled' state to prevent multiple calls to
regulator_enable/disable. These calls will only be called from PSE
framework as it won't have any regulator children, therefore no mutex are
needed to safeguards this boolean.

regulator_get needs the consumer device pointer. Use PSE as regulator
provider and consumer device until we have RJ45 ports represented in
the Kernel.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch

Changes in v4:
- Remove the nested lock as the regulator_enable/disable ops will only
  be called from the PSE framework. No need to protect the 'enabled'
  boolean.
- Update regulator to current instead of voltage.

Changes in v5:
- Update Kernel documentation.
- Fix errors management in pse_control_get_internal function.

Changes in v6:
- Rename enable flag to admin_state_enable
- Fix a podl issue in pse_set_config.
- Use the pcdev device pointer as consumer and provider until we get Linux
  RJ45 port abstraction.
- Add a missing devm_regulator_put due to the device being the consumer
  and the provider.
---
 drivers/net/pse-pd/pse_core.c      | 247 ++++++++++++++++++++++++++++++++++---
 drivers/net/pse-pd/pse_regulator.c |  48 +++----
 include/linux/pse-pd/pse.h         |  18 ++-
 3 files changed, 269 insertions(+), 44 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 78513bda5bbb..611dff662706 100644
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
@@ -126,6 +130,10 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	if (!np)
 		return -ENODEV;
 
+	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
+	if (!pcdev->pi)
+		return -ENOMEM;
+
 	pis = of_get_child_by_name(np, "pse-pis");
 	if (!pis) {
 		/* no description of PSE PIs */
@@ -133,10 +141,6 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 		return 0;
 	}
 
-	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
-	if (!pcdev->pi)
-		return -ENOMEM;
-
 	for_each_child_of_node(pis, node) {
 		struct pse_pi pi = {0};
 		u32 id;
@@ -197,13 +201,124 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
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
+		pcdev->pi[id].admin_state_enabled = 1;
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
+		pcdev->pi[id].admin_state_enabled = 0;
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
+static int
+devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
+			       char *name, int id)
+{
+	struct regulator_init_data *rinit_data;
+	struct regulator_config rconfig = {0};
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+
+	rinit_data = devm_kzalloc(pcdev->dev, sizeof(*rinit_data),
+				  GFP_KERNEL);
+	if (!rinit_data)
+		return -ENOMEM;
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
+	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	rinit_data->supply_regulator = "vpwr";
+
+	rconfig.dev = pcdev->dev;
+	rconfig.driver_data = pcdev;
+	rconfig.init_data = rinit_data;
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
@@ -221,6 +336,31 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
+		if (!pcdev->no_of_pse_pi && !pcdev->pi[i].np)
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
@@ -289,6 +429,10 @@ static void __pse_control_release(struct kref *kref)
 
 	lockdep_assert_held(&pse_list_mutex);
 
+	if (psec->pcdev->pi[psec->id].admin_state_enabled)
+		regulator_disable(psec->ps);
+	devm_regulator_put(psec->ps);
+
 	module_put(psec->pcdev->owner);
 
 	list_del(&psec->list);
@@ -321,6 +465,7 @@ static struct pse_control *
 pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 {
 	struct pse_control *psec;
+	int ret;
 
 	lockdep_assert_held(&pse_list_mutex);
 
@@ -336,16 +481,38 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 		return ERR_PTR(-ENOMEM);
 
 	if (!try_module_get(pcdev->owner)) {
-		kfree(psec);
-		return ERR_PTR(-ENODEV);
+		ret = -ENODEV;
+		goto free_psec;
 	}
 
+	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
+						rdev_get_name(pcdev->pi[index].rdev));
+	if (IS_ERR(psec->ps)) {
+		ret = PTR_ERR(psec->ps);
+		goto put_module;
+	}
+
+	ret = regulator_is_enabled(psec->ps);
+	if (ret < 0)
+		goto regulator_put;
+
+	pcdev->pi[index].admin_state_enabled = ret;
+
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
 	kref_init(&psec->refcnt);
 
 	return psec;
+
+regulator_put:
+	devm_regulator_put(psec->ps);
+put_module:
+	module_put(pcdev->owner);
+free_psec:
+	kfree(psec);
+
+	return ERR_PTR(ret);
 }
 
 /**
@@ -476,6 +643,54 @@ int pse_ethtool_get_status(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_get_status);
 
+static int pse_ethtool_c33_set_config(struct pse_control *psec,
+				      const struct pse_control_config *config)
+{
+	int err = 0;
+
+	/* Look at admin_state_enabled status to not call regulator_enable
+	 * or regulator_disable twice creating a regulator counter mismatch
+	 */
+	switch (config->c33_admin_control) {
+	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
+		if (!psec->pcdev->pi[psec->id].admin_state_enabled)
+			err = regulator_enable(psec->ps);
+		break;
+	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
+		if (psec->pcdev->pi[psec->id].admin_state_enabled)
+			err = regulator_disable(psec->ps);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static int pse_ethtool_podl_set_config(struct pse_control *psec,
+				       const struct pse_control_config *config)
+{
+	int err = 0;
+
+	/* Look at admin_state_enabled status to not call regulator_enable
+	 * or regulator_disable twice creating a regulator counter mismatch
+	 */
+	switch (config->podl_admin_control) {
+	case ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED:
+		if (!psec->pcdev->pi[psec->id].admin_state_enabled)
+			err = regulator_enable(psec->ps);
+		break;
+	case ETHTOOL_PODL_PSE_ADMIN_STATE_DISABLED:
+		if (psec->pcdev->pi[psec->id].admin_state_enabled)
+			err = regulator_disable(psec->ps);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 /**
  * pse_ethtool_set_config - set PSE control configuration
  * @psec: PSE control pointer
@@ -486,20 +701,16 @@ int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config)
 {
-	const struct pse_controller_ops *ops;
-	int err;
+	int err = 0;
 
-	ops = psec->pcdev->ops;
-
-	if (!ops->ethtool_set_config) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not configuration");
-		return -EOPNOTSUPP;
+	if (pse_has_c33(psec)) {
+		err = pse_ethtool_c33_set_config(psec, config);
+		if (err)
+			return err;
 	}
 
-	mutex_lock(&psec->pcdev->lock);
-	err = ops->ethtool_set_config(psec->pcdev, psec->id, extack, config);
-	mutex_unlock(&psec->pcdev->lock);
+	if (pse_has_podl(psec))
+		err = pse_ethtool_podl_set_config(psec, config);
 
 	return err;
 }
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
index caa2e9bce3a3..c7072c48559b 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -48,17 +48,20 @@ struct pse_control_status {
  * struct pse_controller_ops - PSE controller driver callbacks
  *
  * @ethtool_get_status: get PSE control status for ethtool interface
- * @ethtool_set_config: set PSE control configuration over ethtool interface
  * @setup_pi_matrix: setup PI matrix of the PSE controller
+ * @pi_is_enabled: Return 1 if the PSE PI is enabled, 0 if not.
+ *		   May also return negative errno.
+ * @pi_enabled: Configure the PSE PI as enabled.
+ * @pi_disable: Configure the PSE PI as disabled.
  */
 struct pse_controller_ops {
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
@@ -90,10 +93,14 @@ struct pse_pi_pairset {
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
+	bool admin_state_enabled;
 };
 
 /**
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


