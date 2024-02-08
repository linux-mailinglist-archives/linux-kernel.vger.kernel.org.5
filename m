Return-Path: <linux-kernel+bounces-58122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9084E1A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90931F21CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267D823AB;
	Thu,  8 Feb 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Em0oXcBn"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F77992F;
	Thu,  8 Feb 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397810; cv=none; b=TGJhj5qOopmyM3i+tfiHZVZZep5vyqf+ZE9LziR+STzXVP7aUI49qf81FYk2X6rvu0wVWkiTmcjJjTKHjDqtnknyjbZEyXTLgMHwkG4NCLKq0fIQdR3wtejZc55aMBsLRlBHG86hN4h8rYM7WoavoPxYaVYmgwKKs7l5mgiwVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397810; c=relaxed/simple;
	bh=BC6gi2IkQZ5l76qwAZz+DHYLyT2pX/JSWEhVoV8ff3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDFO94gtniz610F7wyCmq1pHbQypW/EajJP/qCOkYveyqAQQ6DChphSSE0P/flt/kz/uGGCkuvtuEtucVGFXBo97RkT162HgrgKBMLVmt5VjUK7/1JaD4pxxEspHNHjcNQpND3MrJsc8I5BOkEEzh17HloRidTJS63ENaHRo+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Em0oXcBn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56B851BF21A;
	Thu,  8 Feb 2024 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjDPxZf+b7w3pXygnjzVmOENCGWGt4amAK9z7SN0lVM=;
	b=Em0oXcBny/YiOFlLVG59IOomJJeON5P7xtZcm96CR/ufYcb6mw7TWI6OMsONnY94pAnGOy
	qPZt1Ppbzg3rCwX2U3FCbgf9CbnJkSwBOG2flvHbLU4PwXq4HSWth4odhEOktS1WYuB4uv
	JflgU+Ty8jXTsKcQgnLvmh56n04Hxmb1x8xPu2tMubxfA0NMKdeXDqDOVZEFVq8wcPp406
	HJ0gCV6NsbMFEsfbssXXnItzALgEb+H3xX704JfvHyDiLFkrBkyZ+tr731BOqRTD84Ua01
	EVxq4X/Itd7n++3wP6OsIgU2lN6JjOFoXA1x9TqrebobgXTMleXzS8T48+oS3Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:48 +0100
Subject: [PATCH net-next v3 11/17] net: pse-pd: Add support for PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-11-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
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

Add support for getting the PSE controller node through PSE PI device
subnode.
This supports adds a way to get the PSE PI id from the pse_pi devicetree
subnode of a PSE controller node simply by reading the reg property.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 223 ++++++++++++++++++++++++++++++++++--------
 include/linux/pse-pd/pse.h    |  38 ++++++-
 2 files changed, 217 insertions(+), 44 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 090e04c32f9e..e03d36793d18 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -27,38 +27,137 @@ struct pse_control {
 	struct kref refcnt;
 };
 
-/**
- * of_pse_zero_xlate - dummy function for controllers with one only control
- * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with #pse-cells = <0>.
- */
-static int of_pse_zero_xlate(struct pse_controller_dev *pcdev,
-			     const struct of_phandle_args *pse_spec)
+static int of_load_pse_pi_pairsets(struct device_node *node,
+				   struct pse_pi *pi,
+				   int npairsets)
 {
-	return 0;
+	struct device_node *pairset_np;
+	const char *name;
+	int i, ret;
+
+	for (i = 0; i < npairsets; i++) {
+		ret = of_property_read_string_index(node,
+						    "pairset-names",
+						     i, &name);
+		if (ret)
+			break;
+
+		if (strcmp(name, "alternative-a")) {
+			pi->pairset[i].pinout = ALTERNATIVE_A;
+		} else if (strcmp(name, "alternative-b")) {
+			pi->pairset[i].pinout = ALTERNATIVE_B;
+		} else {
+			pr_err("pse: wrong pairset-names value %s\n", name);
+			ret = -EINVAL;
+			break;
+		}
+
+		pairset_np = of_parse_phandle(node, "pairsets", i);
+		if (!pairset_np) {
+			ret = -ENODEV;
+			break;
+		}
+
+		pi->pairset[i].np = pairset_np;
+	}
+
+	if (i == 2 && pi->pairset[0].pinout == pi->pairset[1].pinout) {
+		pr_err("pse: two PI pairsets can not have identical pinout");
+		ret = -EINVAL;
+	}
+
+	/* If an error appears on the second pairset load, release the first
+	 * pairset device node kref
+	 */
+	if (ret) {
+		of_node_put(pi->pairset[0].np);
+		pi->pairset[0].np = NULL;
+		of_node_put(pi->pairset[1].np);
+		pi->pairset[1].np = NULL;
+	}
+
+	return ret;
 }
 
-/**
- * of_pse_simple_xlate - translate pse_spec to the PSE line number
- * @pcdev: a pointer to the PSE controller device
- * @pse_spec: PSE line specifier as found in the device tree
- *
- * This static translation function is used by default if of_xlate in
- * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
- * controllers with 1:1 mapping, where PSE lines can be indexed by number
- * without gaps.
- */
-static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
-			       const struct of_phandle_args *pse_spec)
+static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 {
-	if (pse_spec->args[0] >= pcdev->nr_lines)
-		return -EINVAL;
+	struct device_node *np = pcdev->dev->of_node;
+	struct device_node *node, *pis;
+	int ret, i;
 
-	return pse_spec->args[0];
+	if (!np)
+		return -ENODEV;
+
+	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
+	if (!pcdev->pi)
+		return -ENOMEM;
+
+	pis = of_get_child_by_name(np, "pse_pis");
+	if (!pis) {
+		/* Legacy OF description of PSE PIs */
+		pcdev->of_legacy = true;
+		return 0;
+	}
+
+	for_each_child_of_node(pis, node) {
+		struct pse_pi pi = {0};
+		int npairsets;
+		u32 id;
+
+		if (!of_node_name_eq(node, "pse_pi"))
+			continue;
+
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret)
+			goto out;
+
+		if (id >= pcdev->nr_lines || pcdev->pi[id].np) {
+			dev_err(pcdev->dev, "wrong id of pse pi: %u\n",
+				id);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = of_property_count_strings(node, "pairset-names");
+		if (ret <= 0)
+			goto out;
+		npairsets = ret;
+
+		ret = of_count_phandle_with_args(node, "pairsets", NULL);
+		if (ret <= 0)
+			goto out;
+
+		/* npairsets is limited to value one or two */
+		if (ret != npairsets || ret > 2) {
+			dev_err(pcdev->dev,
+				"wrong number of pairsets or pairset-names for pse pi %d\n",
+				id);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = of_load_pse_pi_pairsets(node, &pi, npairsets);
+		if (ret)
+			goto out;
+
+		of_node_get(node);
+		pi.np = node;
+		memcpy(&pcdev->pi[id], &pi, sizeof(pi));
+	}
+
+	of_node_put(pis);
+	return 0;
+
+out:
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		of_node_put(pcdev->pi[i].pairset[0].np);
+		of_node_put(pcdev->pi[i].pairset[1].np);
+		of_node_put(pcdev->pi[i].np);
+	}
+	of_node_put(node);
+	of_node_put(pis);
+	kfree(pcdev->pi);
+	return ret;
 }
 
 /**
@@ -67,16 +166,18 @@ static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
-	if (!pcdev->of_xlate) {
-		if (pcdev->of_pse_n_cells == 0)
-			pcdev->of_xlate = of_pse_zero_xlate;
-		else if (pcdev->of_pse_n_cells == 1)
-			pcdev->of_xlate = of_pse_simple_xlate;
-	}
+	int ret;
 
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
 
+	if (!pcdev->nr_lines)
+		pcdev->nr_lines = 1;
+
+	ret = of_load_pse_pis(pcdev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
@@ -91,6 +192,14 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	int i;
+
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		of_node_put(pcdev->pi[i].pairset[0].np);
+		of_node_put(pcdev->pi[i].pairset[1].np);
+		of_node_put(pcdev->pi[i].np);
+	}
+	kfree(pcdev->pi);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
@@ -203,8 +312,33 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	return psec;
 }
 
-struct pse_control *
-of_pse_control_get(struct device_node *node)
+static int of_pse_match_pi(struct pse_controller_dev *pcdev,
+			   struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i <= pcdev->nr_lines; i++) {
+		if (pcdev->pi[i].np == np)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int psec_id_legacy_xlate(struct pse_controller_dev *pcdev,
+				const struct of_phandle_args *pse_spec)
+{
+	if (!pcdev->of_pse_n_cells)
+		return 0;
+
+	if (pcdev->of_pse_n_cells > 1 ||
+	    pse_spec->args[0] >= pcdev->nr_lines)
+		return -EINVAL;
+
+	return pse_spec->args[0];
+}
+
+struct pse_control *of_pse_control_get(struct device_node *node)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -222,7 +356,14 @@ of_pse_control_get(struct device_node *node)
 	mutex_lock(&pse_list_mutex);
 	pcdev = NULL;
 	list_for_each_entry(r, &pse_controller_list, list) {
-		if (args.np == r->dev->of_node) {
+		if (!r->of_legacy) {
+			ret = of_pse_match_pi(r, args.np);
+			if (ret >= 0) {
+				pcdev = r;
+				psec_id = ret;
+				break;
+			}
+		} else if (args.np == r->dev->of_node) {
 			pcdev = r;
 			break;
 		}
@@ -238,10 +379,12 @@ of_pse_control_get(struct device_node *node)
 		goto out;
 	}
 
-	psec_id = pcdev->of_xlate(pcdev, &args);
-	if (psec_id < 0) {
-		psec = ERR_PTR(psec_id);
-		goto out;
+	if (pcdev->of_legacy) {
+		psec_id = psec_id_legacy_xlate(pcdev, &args);
+		if (psec_id < 0) {
+			psec = ERR_PTR(psec_id);
+			goto out;
+		}
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index f006cbdf8b3b..6c48668cebe3 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -65,6 +65,36 @@ struct device_node;
 struct of_phandle_args;
 struct pse_control;
 
+/* PSE PI pairset pinout can either be Alternative A or Alternative B */
+enum pse_pi_pairset_pinout {
+	ALTERNATIVE_A,
+	ALTERNATIVE_B,
+};
+
+/**
+ * struct pse_pi_pairset - PSE PI pairset entity describing the pinout
+ *			   alternative ant its phandle
+ *
+ * @pinout: description of the pinout alternative
+ * @np: device node pointer describing the pairset phandle
+ */
+struct pse_pi_pairset {
+	enum pse_pi_pairset_pinout pinout;
+	struct device_node *np;
+};
+
+/**
+ * struct pse_pi - PSE PI (Power Interface) entity as described in
+ *		   IEEE 802.3-2022 145.2.4
+ *
+ * @pairset: table of the PSE PI pinout alternative for the two pairset
+ * @np: device node pointer of the PSE PI node
+ */
+struct pse_pi {
+	struct pse_pi_pairset pairset[2];
+	struct device_node *np;
+};
+
 /**
  * struct pse_controller_dev - PSE controller entity that might
  *                             provide multiple PSE controls
@@ -74,11 +104,11 @@ struct pse_control;
  * @pse_control_head: head of internal list of requested PSE controls
  * @dev: corresponding driver model device struct
  * @of_pse_n_cells: number of cells in PSE line specifiers
- * @of_xlate: translation function to translate from specifier as found in the
- *            device tree to id as given to the PSE control ops
  * @nr_lines: number of PSE controls in this controller device
  * @lock: Mutex for serialization access to the PSE controller
  * @types: types of the PSE controller
+ * @pi: table of PSE PIs described in this controller device
+ * @of_legacy: flag set if the pse_pis devicetree node is not used
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -87,11 +117,11 @@ struct pse_controller_dev {
 	struct list_head pse_control_head;
 	struct device *dev;
 	int of_pse_n_cells;
-	int (*of_xlate)(struct pse_controller_dev *pcdev,
-			const struct of_phandle_args *pse_spec);
 	unsigned int nr_lines;
 	struct mutex lock;
 	u32 types;
+	struct pse_pi *pi;
+	bool of_legacy;
 };
 
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

-- 
2.25.1


