Return-Path: <linux-kernel+bounces-144208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D518A432B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C527B210C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16046EB52;
	Sun, 14 Apr 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GuvSpKUm"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828F5C614;
	Sun, 14 Apr 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104682; cv=none; b=q5ufxiinGip8a1hcKNJcZQ6xfKKuH2wyWN+ArSNepu0dOIbVB4ZfmVRqcxstsso+QFDvYTgJU3EU35vWAFk2A3SpI2RMySZyYT0GVyeCtGVTc/O9H0cJ/K+Xk47tnoEsWJkF2LThEZ9DJZCW2FxLQNoK+gZQ+QcSyJ0iPnGBxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104682; c=relaxed/simple;
	bh=p420LPQ6KNjjB5J7zbiDgqLaUPO0eqRJYdW5zaYUUq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhqN6o1M62YcbBd77M+oUL9Hs55hslsGgkfZTzpf+wt1rh5z+hSRPbuqJUSRCzBcvYOU4UtzXv/pIAnVlEnnnil/pAo7NotK/P+/Oc1BB1+FX4PHsUhD2GEug0GUTXkM1MtrU55KOF9C0EOj/42lXWmgyahcOlY5lmOwnsO17jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GuvSpKUm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9053C0006;
	Sun, 14 Apr 2024 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVOuql8dKHHZkQjfmEVGEzF8aGPcGCYemOcJitXcJn8=;
	b=GuvSpKUmkSW3EQvrNkaHA3s7tqAEfVvnGuel3N8Kkh8MKO3pEEeiPT7GkTamN3uu+bFJMC
	aBWEeMfYCxLsS9jvd+3hFhoFyuYMYCt1kFVNayWKRnULW9BFsPxSF9ex4OcdnVGUzZf8vX
	06BwhNQnLRvDZ5V8RJnxdjFMcvrf2MXxqYOsu/iTY74vjA1mKyad5Pvie+DcCfgB8y6IO0
	jbunJui2i8vcSGspIqejekvhXe/pa8254i5lu26PY+OQmkJhO5PsUOAiDZ/+jvNqaDi+Br
	a1mmGKOYEjaXnvpAnofg4t0xD+s5YG4IQWpV74ynQGMtiCvtpYJa9Di0XzCQlg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:22:06 +0200
Subject: [PATCH net-next v8 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-17-e4bf1e860da5@bootlin.com>
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

Add a new driver for the TI TPS23881 I2C Power Sourcing Equipment
controller.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

---
Change in v3:
- New patch.

Change in v6:
- Fix firmware management, release_firmware was missing.

Change in v7:
- Few nit spotted by Andrew.
- Rename *flash_fw* functions to *flash_sram_fw*.
---
 drivers/net/pse-pd/Kconfig    |   9 +
 drivers/net/pse-pd/Makefile   |   1 +
 drivers/net/pse-pd/tps23881.c | 820 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 830 insertions(+)

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index e3a6ba669f20..80cf373a5a0e 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -31,4 +31,13 @@ config PSE_PD692X0
 	  To compile this driver as a module, choose M here: the
 	  module will be called pd692x0.
 
+config PSE_TPS23881
+	tristate "TPS23881 PSE controller"
+	depends on I2C
+	help
+	  This module provides support for TPS23881 regulator based Ethernet
+	  Power Sourcing Equipment.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tps23881.
 endif
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index 9c12c4a65730..9d2898b36737 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
 
 obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
+obj-$(CONFIG_PSE_TPS23881) += tps23881.o
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
new file mode 100644
index 000000000000..98ffbb1bbf13
--- /dev/null
+++ b/drivers/net/pse-pd/tps23881.c
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the TI TPS23881 PoE PSE Controller driver (I2C bus)
+ *
+ * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pse-pd/pse.h>
+
+#define TPS23881_MAX_CHANS 8
+
+#define TPS23881_REG_PW_STATUS	0x10
+#define TPS23881_REG_OP_MODE	0x12
+#define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
+#define TPS23881_REG_DIS_EN	0x13
+#define TPS23881_REG_DET_CLA_EN	0x14
+#define TPS23881_REG_GEN_MASK	0x17
+#define TPS23881_REG_NBITACC	BIT(5)
+#define TPS23881_REG_PW_EN	0x19
+#define TPS23881_REG_PORT_MAP	0x26
+#define TPS23881_REG_PORT_POWER	0x29
+#define TPS23881_REG_POEPLUS	0x40
+#define TPS23881_REG_TPON	BIT(0)
+#define TPS23881_REG_FWREV	0x41
+#define TPS23881_REG_DEVID	0x43
+#define TPS23881_REG_SRAM_CTRL	0x60
+#define TPS23881_REG_SRAM_DATA	0x61
+
+struct tps23881_port_desc {
+	u8 chan[2];
+	bool is_4p;
+};
+
+struct tps23881_priv {
+	struct i2c_client *client;
+	struct pse_controller_dev pcdev;
+	struct device_node *np;
+	struct tps23881_port_desc port[TPS23881_MAX_CHANS];
+};
+
+static struct tps23881_priv *to_tps23881_priv(struct pse_controller_dev *pcdev)
+{
+	return container_of(pcdev, struct tps23881_priv, pcdev);
+}
+
+static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	u8 chan;
+	u16 val;
+	int ret;
+
+	if (id >= TPS23881_MAX_CHANS)
+		return -ERANGE;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		val = (u16)(ret | BIT(chan));
+	else
+		val = (u16)(ret | BIT(chan + 4));
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4)
+			val |= BIT(chan);
+		else
+			val |= BIT(chan + 4);
+	}
+
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	u8 chan;
+	u16 val;
+	int ret;
+
+	if (id >= TPS23881_MAX_CHANS)
+		return -ERANGE;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		val = (u16)(ret | BIT(chan + 4));
+	else
+		val = (u16)(ret | BIT(chan + 8));
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4)
+			val |= BIT(chan + 4);
+		else
+			val |= BIT(chan + 8);
+	}
+
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	bool enabled;
+	u8 chan;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		enabled = ret & BIT(chan);
+	else
+		enabled = ret & BIT(chan + 4);
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4)
+			enabled &= !!(ret & BIT(chan));
+		else
+			enabled &= !!(ret & BIT(chan + 4));
+	}
+
+	/* Return enabled status only if both channel are on this state */
+	return enabled;
+}
+
+static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
+				       unsigned long id,
+				       struct netlink_ext_ack *extack,
+				       struct pse_control_status *status)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	bool enabled, delivering;
+	u8 chan;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4) {
+		enabled = ret & BIT(chan);
+		delivering = ret & BIT(chan + 4);
+	} else {
+		enabled = ret & BIT(chan + 4);
+		delivering = ret & BIT(chan + 8);
+	}
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4) {
+			enabled &= !!(ret & BIT(chan));
+			delivering &= !!(ret & BIT(chan + 4));
+		} else {
+			enabled &= !!(ret & BIT(chan + 4));
+			delivering &= !!(ret & BIT(chan + 8));
+		}
+	}
+
+	/* Return delivering status only if both channel are on this state */
+	if (delivering)
+		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+	else
+		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
+
+	/* Return enabled status only if both channel are on this state */
+	if (enabled)
+		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+	else
+		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+
+	return 0;
+}
+
+/* Parse managers subnode into a array of device node */
+static int
+tps23881_get_of_channels(struct tps23881_priv *priv,
+			 struct device_node *chan_node[TPS23881_MAX_CHANS])
+{
+	struct device_node *channels_node, *node;
+	int i, ret;
+
+	if (!priv->np)
+		return -EINVAL;
+
+	channels_node = of_find_node_by_name(priv->np, "channels");
+	if (!channels_node)
+		return -EINVAL;
+
+	for_each_child_of_node(channels_node, node) {
+		u32 chan_id;
+
+		if (!of_node_name_eq(node, "channel"))
+			continue;
+
+		ret = of_property_read_u32(node, "reg", &chan_id);
+		if (ret) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (chan_id >= TPS23881_MAX_CHANS || chan_node[chan_id]) {
+			dev_err(&priv->client->dev,
+				"wrong number of port (%d)\n", chan_id);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		of_node_get(node);
+		chan_node[chan_id] = node;
+	}
+
+	of_node_put(channels_node);
+	return 0;
+
+out:
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		of_node_put(chan_node[i]);
+		chan_node[i] = NULL;
+	}
+
+	of_node_put(node);
+	of_node_put(channels_node);
+	return ret;
+}
+
+struct tps23881_port_matrix {
+	u8 pi_id;
+	u8 lgcl_chan[2];
+	u8 hw_chan[2];
+	bool is_4p;
+	bool exist;
+};
+
+static int
+tps23881_match_channel(const struct pse_pi_pairset *pairset,
+		       struct device_node *chan_node[TPS23881_MAX_CHANS])
+{
+	int i;
+
+	/* Look on every channels */
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		if (pairset->np == chan_node[i])
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static bool
+tps23881_is_chan_free(struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS],
+		      int chan)
+{
+	int i;
+
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		if (port_matrix[i].exist &&
+		    (port_matrix[i].hw_chan[0] == chan ||
+		    port_matrix[i].hw_chan[1] == chan))
+			return false;
+	}
+
+	return true;
+}
+
+/* Fill port matrix with the matching channels */
+static int
+tps23881_match_port_matrix(struct pse_pi *pi, int pi_id,
+			   struct device_node *chan_node[TPS23881_MAX_CHANS],
+			   struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS])
+{
+	int ret;
+
+	if (!pi->pairset[0].np)
+		return 0;
+
+	ret = tps23881_match_channel(&pi->pairset[0], chan_node);
+	if (ret < 0)
+		return ret;
+
+	if (!tps23881_is_chan_free(port_matrix, ret)) {
+		pr_err("tps23881: channel %d already used\n", ret);
+		return -ENODEV;
+	}
+
+	port_matrix[pi_id].hw_chan[0] = ret;
+	port_matrix[pi_id].exist = true;
+
+	if (!pi->pairset[1].np)
+		return 0;
+
+	ret = tps23881_match_channel(&pi->pairset[1], chan_node);
+	if (ret < 0)
+		return ret;
+
+	if (!tps23881_is_chan_free(port_matrix, ret)) {
+		pr_err("tps23881: channel %d already used\n", ret);
+		return -ENODEV;
+	}
+
+	if (port_matrix[pi_id].hw_chan[0] / 4 != ret / 4) {
+		pr_err("tps23881: 4-pair PSE can only be set within the same 4 ports group");
+		return -ENODEV;
+	}
+
+	port_matrix[pi_id].hw_chan[1] = ret;
+	port_matrix[pi_id].is_4p = true;
+
+	return 0;
+}
+
+static int
+tps23881_get_unused_chan(struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS],
+			 int port_cnt)
+{
+	bool used;
+	int i, j;
+
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		used = false;
+
+		for (j = 0; j < port_cnt; j++) {
+			if (port_matrix[j].hw_chan[0] == i) {
+				used = true;
+				break;
+			}
+
+			if (port_matrix[j].is_4p &&
+			    port_matrix[j].hw_chan[1] == i) {
+				used = true;
+				break;
+			}
+		}
+
+		if (!used)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+/* Sort the port matrix to following particular hardware ports matrix
+ * specification of the tps23881. The device has two 4-ports groups and
+ * each 4-pair powered device has to be configured to use two consecutive
+ * logical channel in each 4 ports group (1 and 2 or 3 and 4). Also the
+ * hardware matrix has to be fully configured even with unused chan to be
+ * valid.
+ */
+static int
+tps23881_sort_port_matrix(struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS])
+{
+	struct tps23881_port_matrix tmp_port_matrix[TPS23881_MAX_CHANS] = {0};
+	int i, ret, port_cnt = 0, cnt_4ch_grp1 = 0, cnt_4ch_grp2 = 4;
+
+	/* Configure 4p port matrix */
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		int *cnt;
+
+		if (!port_matrix[i].exist || !port_matrix[i].is_4p)
+			continue;
+
+		if (port_matrix[i].hw_chan[0] < 4)
+			cnt = &cnt_4ch_grp1;
+		else
+			cnt = &cnt_4ch_grp2;
+
+		tmp_port_matrix[port_cnt].exist = true;
+		tmp_port_matrix[port_cnt].is_4p = true;
+		tmp_port_matrix[port_cnt].pi_id = i;
+		tmp_port_matrix[port_cnt].hw_chan[0] = port_matrix[i].hw_chan[0];
+		tmp_port_matrix[port_cnt].hw_chan[1] = port_matrix[i].hw_chan[1];
+
+		/* 4-pair ports have to be configured with consecutive
+		 * logical channels 0 and 1, 2 and 3.
+		 */
+		tmp_port_matrix[port_cnt].lgcl_chan[0] = (*cnt)++;
+		tmp_port_matrix[port_cnt].lgcl_chan[1] = (*cnt)++;
+
+		port_cnt++;
+	}
+
+	/* Configure 2p port matrix */
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		int *cnt;
+
+		if (!port_matrix[i].exist || port_matrix[i].is_4p)
+			continue;
+
+		if (port_matrix[i].hw_chan[0] < 4)
+			cnt = &cnt_4ch_grp1;
+		else
+			cnt = &cnt_4ch_grp2;
+
+		tmp_port_matrix[port_cnt].exist = true;
+		tmp_port_matrix[port_cnt].pi_id = i;
+		tmp_port_matrix[port_cnt].lgcl_chan[0] = (*cnt)++;
+		tmp_port_matrix[port_cnt].hw_chan[0] = port_matrix[i].hw_chan[0];
+
+		port_cnt++;
+	}
+
+	/* Complete the rest of the first 4 port group matrix even if
+	 * channels are unused
+	 */
+	while (cnt_4ch_grp1 < 4) {
+		ret = tps23881_get_unused_chan(tmp_port_matrix, port_cnt);
+		if (ret < 0) {
+			pr_err("tps23881: port matrix issue, no chan available\n");
+			return ret;
+		}
+
+		if (port_cnt >= TPS23881_MAX_CHANS) {
+			pr_err("tps23881: wrong number of channels\n");
+			return -ENODEV;
+		}
+		tmp_port_matrix[port_cnt].lgcl_chan[0] = cnt_4ch_grp1;
+		tmp_port_matrix[port_cnt].hw_chan[0] = ret;
+		cnt_4ch_grp1++;
+		port_cnt++;
+	}
+
+	/* Complete the rest of the second 4 port group matrix even if
+	 * channels are unused
+	 */
+	while (cnt_4ch_grp2 < 8) {
+		ret = tps23881_get_unused_chan(tmp_port_matrix, port_cnt);
+		if (ret < 0) {
+			pr_err("tps23881: port matrix issue, no chan available\n");
+			return -ENODEV;
+		}
+
+		if (port_cnt >= TPS23881_MAX_CHANS) {
+			pr_err("tps23881: wrong number of channels\n");
+			return -ENODEV;
+		}
+		tmp_port_matrix[port_cnt].lgcl_chan[0] = cnt_4ch_grp2;
+		tmp_port_matrix[port_cnt].hw_chan[0] = ret;
+		cnt_4ch_grp2++;
+		port_cnt++;
+	}
+
+	memcpy(port_matrix, tmp_port_matrix, sizeof(tmp_port_matrix));
+
+	return port_cnt;
+}
+
+/* Write port matrix to the hardware port matrix and the software port
+ * matrix.
+ */
+static int
+tps23881_write_port_matrix(struct tps23881_priv *priv,
+			   struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS],
+			   int port_cnt)
+{
+	struct i2c_client *client = priv->client;
+	u8 pi_id, lgcl_chan, hw_chan;
+	u16 val = 0;
+	int i, ret;
+
+	for (i = 0; i < port_cnt; i++) {
+		pi_id = port_matrix[i].pi_id;
+		lgcl_chan = port_matrix[i].lgcl_chan[0];
+		hw_chan = port_matrix[i].hw_chan[0] % 4;
+
+		/* Set software port matrix for existing ports */
+		if (port_matrix[i].exist)
+			priv->port[pi_id].chan[0] = lgcl_chan;
+
+		/* Set hardware port matrix for all ports */
+		val |= hw_chan << (lgcl_chan * 2);
+
+		if (!port_matrix[i].is_4p)
+			continue;
+
+		lgcl_chan = port_matrix[i].lgcl_chan[1];
+		hw_chan = port_matrix[i].hw_chan[1] % 4;
+
+		/* Set software port matrix for existing ports */
+		if (port_matrix[i].exist) {
+			priv->port[pi_id].is_4p = true;
+			priv->port[pi_id].chan[1] = lgcl_chan;
+		}
+
+		/* Set hardware port matrix for all ports */
+		val |= hw_chan << (lgcl_chan * 2);
+	}
+
+	/* Write hardware ports matrix */
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PORT_MAP, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+tps23881_set_ports_conf(struct tps23881_priv *priv,
+			struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS])
+{
+	struct i2c_client *client = priv->client;
+	int i, ret;
+	u16 val;
+
+	/* Set operating mode */
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_OP_MODE,
+					TPS23881_OP_MODE_SEMIAUTO);
+	if (ret)
+		return ret;
+
+	/* Disable DC disconnect */
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DIS_EN, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set port power allocation */
+	val = 0;
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		if (!port_matrix[i].exist)
+			continue;
+
+		if (port_matrix[i].is_4p)
+			val |= 0xf << ((port_matrix[i].lgcl_chan[0] / 2) * 4);
+		else
+			val |= 0x3 << ((port_matrix[i].lgcl_chan[0] / 2) * 4);
+	}
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PORT_POWER, val);
+	if (ret)
+		return ret;
+
+	/* Enable detection and classification */
+	val = 0;
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		if (!port_matrix[i].exist)
+			continue;
+
+		val |= BIT(port_matrix[i].lgcl_chan[0]) |
+		       BIT(port_matrix[i].lgcl_chan[0] + 4);
+		if (port_matrix[i].is_4p)
+			val |= BIT(port_matrix[i].lgcl_chan[1]) |
+			       BIT(port_matrix[i].lgcl_chan[1] + 4);
+	}
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+tps23881_set_ports_matrix(struct tps23881_priv *priv,
+			  struct device_node *chan_node[TPS23881_MAX_CHANS])
+{
+	struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS] = {0};
+	int i, ret;
+
+	/* Update with values for every PSE PIs */
+	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
+		ret = tps23881_match_port_matrix(&priv->pcdev.pi[i], i,
+						 chan_node, port_matrix);
+		if (ret)
+			return ret;
+	}
+
+	ret = tps23881_sort_port_matrix(port_matrix);
+	if (ret < 0)
+		return ret;
+
+	ret = tps23881_write_port_matrix(priv, port_matrix, ret);
+	if (ret)
+		return ret;
+
+	ret = tps23881_set_ports_conf(priv, port_matrix);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)
+{
+	struct device_node *chan_node[TPS23881_MAX_CHANS] = {NULL};
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	int ret, i;
+
+	ret = tps23881_get_of_channels(priv, chan_node);
+	if (ret < 0) {
+		dev_warn(&priv->client->dev,
+			 "Unable to parse port-matrix, default matrix will be used\n");
+		return 0;
+	}
+
+	ret = tps23881_set_ports_matrix(priv, chan_node);
+
+	for (i = 0; i < TPS23881_MAX_CHANS; i++)
+		of_node_put(chan_node[i]);
+
+	return ret;
+}
+
+static const struct pse_controller_ops tps23881_ops = {
+	.setup_pi_matrix = tps23881_setup_pi_matrix,
+	.pi_enable = tps23881_pi_enable,
+	.pi_disable = tps23881_pi_disable,
+	.pi_is_enabled = tps23881_pi_is_enabled,
+	.ethtool_get_status = tps23881_ethtool_get_status,
+};
+
+static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
+static const char fw_sram_name[] = "ti/tps23881/tps23881-sram-14.bin";
+
+struct tps23881_fw_conf {
+	u8 reg;
+	u8 val;
+};
+
+static const struct tps23881_fw_conf tps23881_fw_parity_conf[] = {
+	{.reg = 0x60, .val = 0x01},
+	{.reg = 0x62, .val = 0x00},
+	{.reg = 0x63, .val = 0x80},
+	{.reg = 0x60, .val = 0xC4},
+	{.reg = 0x1D, .val = 0xBC},
+	{.reg = 0xD7, .val = 0x02},
+	{.reg = 0x91, .val = 0x00},
+	{.reg = 0x90, .val = 0x00},
+	{.reg = 0xD7, .val = 0x00},
+	{.reg = 0x1D, .val = 0x00},
+	{ /* sentinel */ }
+};
+
+static const struct tps23881_fw_conf tps23881_fw_sram_conf[] = {
+	{.reg = 0x60, .val = 0xC5},
+	{.reg = 0x62, .val = 0x00},
+	{.reg = 0x63, .val = 0x80},
+	{.reg = 0x60, .val = 0xC0},
+	{.reg = 0x1D, .val = 0xBC},
+	{.reg = 0xD7, .val = 0x02},
+	{.reg = 0x91, .val = 0x00},
+	{.reg = 0x90, .val = 0x00},
+	{.reg = 0xD7, .val = 0x00},
+	{.reg = 0x1D, .val = 0x00},
+	{ /* sentinel */ }
+};
+
+static int tps23881_flash_sram_fw_part(struct i2c_client *client,
+				       const char *fw_name,
+				       const struct tps23881_fw_conf *fw_conf)
+{
+	const struct firmware *fw = NULL;
+	int i, ret;
+
+	ret = request_firmware(&fw, fw_name, &client->dev);
+	if (ret)
+		return ret;
+
+	dev_dbg(&client->dev, "Flashing %s\n", fw_name);
+
+	/* Prepare device for RAM download */
+	while (fw_conf->reg) {
+		ret = i2c_smbus_write_byte_data(client, fw_conf->reg,
+						fw_conf->val);
+		if (ret)
+			goto out;
+
+		fw_conf++;
+	}
+
+	/* Flash the firmware file */
+	for (i = 0; i < fw->size; i++) {
+		ret = i2c_smbus_write_byte_data(client,
+						TPS23881_REG_SRAM_DATA,
+						fw->data[i]);
+		if (ret)
+			goto out;
+	}
+
+out:
+	release_firmware(fw);
+	return ret;
+}
+
+static int tps23881_flash_sram_fw(struct i2c_client *client)
+{
+	int ret;
+
+	ret = tps23881_flash_sram_fw_part(client, fw_parity_name,
+					  tps23881_fw_parity_conf);
+	if (ret)
+		return ret;
+
+	ret = tps23881_flash_sram_fw_part(client, fw_sram_name,
+					  tps23881_fw_sram_conf);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, TPS23881_REG_SRAM_CTRL, 0x18);
+	if (ret)
+		return ret;
+
+	mdelay(12);
+
+	return 0;
+}
+
+static int tps23881_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tps23881_priv *priv;
+	int ret;
+	u8 val;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "i2c check functionality failed\n");
+		return -ENXIO;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
+	if (ret < 0)
+		return ret;
+
+	if (ret != 0x22) {
+		dev_err(dev, "Wrong device ID\n");
+		return -ENXIO;
+	}
+
+	ret = tps23881_flash_sram_fw(client);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_FWREV);
+	if (ret < 0)
+		return ret;
+
+	dev_info(&client->dev, "Firmware revision 0x%x\n", ret);
+
+	/* Set configuration B, 16 bit access on a single device address */
+	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_GEN_MASK);
+	if (ret < 0)
+		return ret;
+
+	val = ret | TPS23881_REG_NBITACC;
+	ret = i2c_smbus_write_byte_data(client, TPS23881_REG_GEN_MASK, val);
+	if (ret)
+		return ret;
+
+	priv->client = client;
+	i2c_set_clientdata(client, priv);
+	priv->np = dev->of_node;
+
+	priv->pcdev.owner = THIS_MODULE;
+	priv->pcdev.ops = &tps23881_ops;
+	priv->pcdev.dev = dev;
+	priv->pcdev.types = ETHTOOL_PSE_C33;
+	priv->pcdev.nr_lines = TPS23881_MAX_CHANS;
+	ret = devm_pse_controller_register(dev, &priv->pcdev);
+	if (ret) {
+		return dev_err_probe(dev, ret,
+				     "failed to register PSE controller\n");
+	}
+
+	return ret;
+}
+
+static const struct i2c_device_id tps23881_id[] = {
+	{ "tps23881", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tps23881_id);
+
+static const struct of_device_id tps23881_of_match[] = {
+	{ .compatible = "ti,tps23881", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tps23881_of_match);
+
+static struct i2c_driver tps23881_driver = {
+	.probe		= tps23881_i2c_probe,
+	.id_table	= tps23881_id,
+	.driver		= {
+		.name		= "tps23881",
+		.of_match_table = tps23881_of_match,
+	},
+};
+module_i2c_driver(tps23881_driver);
+
+MODULE_AUTHOR("Kory Maincent <kory.maincent@bootlin.com>");
+MODULE_DESCRIPTION("TI TPS23881 PoE PSE Controller driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


