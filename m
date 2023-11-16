Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39337EE22B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbjKPOC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbjKPOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:11 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB311F;
        Thu, 16 Nov 2023 06:02:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A50220019;
        Thu, 16 Nov 2023 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700143323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyeQf/hMdeNrgNbInTbgqIPOK4zZkUbata15BYtMqPU=;
        b=Uj2FCSh1tH3U4/2uXwmasIeZi2YQYUPUC6sAYyaE001XnkSvwCRjkmmUFyfX37PVUJZNBl
        1pzrbuVAUT6pwv9agu3HFBnG6sSRKvkf6HrokmJ7zcK7li+IE+BaWs9Fp6jCppn3u1KpG9
        rPu1awDPSPZAsc6nZVrfrtwc5Yl02CROWf5y2DVWdPKXtOn/agOumR4qU2RlQvG1LmjnIt
        QpDf5YuWWg+O+AMJA9V8tRoGyuD5/k+ykS8dUSHqwi4jIbk+PTVq9kH35bGlGtqLCNsNDN
        M5265tx2Cl16h9PKGQ2EIrKvCKXSlrO11e1PsaC2raKdICn7LL6ne+kLskEtZQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Thu, 16 Nov 2023 15:01:41 +0100
Subject: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
This driver only support i2c communication for now.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS                  |    1 +
 drivers/net/pse-pd/Kconfig   |   11 +
 drivers/net/pse-pd/Makefile  |    1 +
 drivers/net/pse-pd/pd692x0.c | 1049 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1062 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e154dacef67..34cf007965a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14253,6 +14253,7 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml
+F:	drivers/net/pse-pd/pd69200.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 687dec49c1e1..e3a6ba669f20 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -20,4 +20,15 @@ config PSE_REGULATOR
 	  Sourcing Equipment without automatic classification support. For
 	  example for basic implementation of PoDL (802.3bu) specification.
 
+config PSE_PD692X0
+	tristate "PD692X0 PSE controller"
+	depends on I2C
+	select FW_UPLOAD
+	help
+	  This module provides support for PD692x0 regulator based Ethernet
+	  Power Sourcing Equipment.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pd692x0.
+
 endif
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index 1b8aa4c70f0b..9c12c4a65730 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -4,3 +4,4 @@
 obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
 
 obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
+obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
new file mode 100644
index 000000000000..f6b8f89a3afe
--- /dev/null
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -0,0 +1,1049 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Microchip PD692X0 PoE PSE Controller driver (I2C bus)
+ *
+ * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+
+#define PD692X0_PSE_NAME "pd692x0_pse"
+
+#define PD692X0_MAX_LOGICAL_PORTS	48
+#define PD692X0_MAX_HW_PORTS	96
+
+#define PD69200_BT_PROD_VER	24
+#define PD69210_BT_PROD_VER	26
+#define PD69220_BT_PROD_VER	29
+
+#define PD692X0_FW_MAJ_VER	3
+#define PD692X0_FW_MIN_VER	5
+#define PD692X0_FW_PATCH_VER	5
+
+enum pd692x0_fw_state {
+	PD692X0_FW_UNKNOWN,
+	PD692X0_FW_OK,
+	PD692X0_FW_BROKEN,
+	PD692X0_FW_NEED_UPDATE,
+	PD692X0_FW_PREPARE,
+	PD692X0_FW_WRITE,
+	PD692X0_FW_COMPLETE,
+};
+
+struct pd692x0_msg_content {
+	u8 key;
+	u8 echo;
+	u8 sub[3];
+	u8 data[8];
+	__be16 chksum;
+} __packed;
+
+struct pd692x0_msg_ver {
+	u8 prod;
+	u8 maj_sw_ver;
+	u8 min_sw_ver;
+	u8 pa_sw_ver;
+	u8 param;
+	u8 build;
+};
+
+enum {
+	PD692X0_KEY_CMD,
+	PD692X0_KEY_PRG,
+	PD692X0_KEY_REQ,
+	PD692X0_KEY_TLM,
+	PD692X0_KEY_TEST,
+	PD692X0_KEY_REPORT = 0x52
+};
+
+enum {
+	PD692X0_MSG_RESET,
+	PD692X0_MSG_GET_SW_VER,
+	PD692X0_MSG_SET_TMP_PORT_MATRIX,
+	PD692X0_MSG_PRG_PORT_MATRIX,
+	PD692X0_MSG_SET_PORT_PARAM,
+	PD692X0_MSG_GET_PORT_STATUS,
+	PD692X0_MSG_DOWNLOAD_CMD,
+
+	/* add new message above here */
+	PD692X0_MSG_CNT
+};
+
+struct pd692x0_msg {
+	struct pd692x0_msg_content content;
+	u16 delay_recv;
+};
+
+struct pd692x0_priv {
+	struct i2c_client *client;
+	struct pse_controller_dev pcdev;
+
+	enum pd692x0_fw_state fw_state;
+	struct fw_upload *fwl;
+	bool cancel_request:1;
+
+	u8 msg_id;
+	bool last_cmd_key:1;
+	unsigned long last_cmd_key_time;
+
+	enum ethtool_pse_admin_state admin_state[PD692X0_MAX_LOGICAL_PORTS];
+};
+
+/* Template list of the fixed bytes of the communication messages */
+static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
+	[PD692X0_MSG_RESET] = {
+		.content = {
+			.key = PD692X0_KEY_CMD,
+			.sub = {0x07, 0x55, 0x00},
+			.data = {0x55, 0x00, 0x55, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_GET_SW_VER] = {
+		.content = {
+			.key = PD692X0_KEY_REQ,
+			.sub = {0x07, 0x1e, 0x21},
+			.data = {0x4e, 0x4e, 0x4e, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_SET_TMP_PORT_MATRIX] = {
+		.content = {
+			.key = PD692X0_KEY_CMD,
+			.sub	 = {0x05, 0x43},
+			.data = {   0, 0x4e, 0x4e, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_PRG_PORT_MATRIX] = {
+		.content = {
+			.key = PD692X0_KEY_CMD,
+			.sub = {0x07, 0x43, 0x4e},
+			.data = {0x4e, 0x4e, 0x4e, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_SET_PORT_PARAM] = {
+		.content = {
+			.key = PD692X0_KEY_CMD,
+			.sub = {0x05, 0xc0},
+			.data = {   0, 0xff, 0xff, 0xff,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_GET_PORT_STATUS] = {
+		.content = {
+			.key = PD692X0_KEY_REQ,
+			.sub = {0x05, 0xc1},
+			.data = {0x4e, 0x4e, 0x4e, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+	[PD692X0_MSG_DOWNLOAD_CMD] = {
+		.content = {
+			.key = PD692X0_KEY_PRG,
+			.sub = {0xff, 0x99, 0x15},
+			.data = {0x16, 0x16, 0x99, 0x4e,
+				 0x4e, 0x4e, 0x4e, 0x4e},
+		},
+	},
+};
+
+static u8 pd692x0_build_msg(struct pd692x0_msg_content *msg, u8 echo)
+{
+	u8 *data = (u8 *)msg;
+	u16 chksum = 0;
+	int i;
+
+	msg->echo = echo++;
+	if (echo == 0xff)
+		echo = 0;
+
+	for (i = 0; i < sizeof(*msg) - sizeof(msg->chksum); i++)
+		chksum += data[i];
+
+	msg->chksum = cpu_to_be16(chksum);
+
+	return echo;
+}
+
+static int pd692x0_send_msg(struct pd692x0_priv *priv, struct pd692x0_msg *msg)
+{
+	const struct i2c_client *client = priv->client;
+	int ret;
+
+	if (msg->content.key == PD692X0_KEY_CMD && priv->last_cmd_key) {
+		while (time_is_after_jiffies(msecs_to_jiffies(30) + priv->last_cmd_key_time))
+			usleep_range(1000, 2000);
+	}
+
+	/* Add echo and checksum bytes to the message */
+	priv->msg_id = pd692x0_build_msg(&msg->content, priv->msg_id);
+
+	ret = i2c_master_send(client, (u8 *)&msg->content,
+			      sizeof(msg->content));
+	if (ret != sizeof(msg->content))
+		return -EIO;
+
+	return 0;
+}
+
+static int pd692x0_reset(struct pd692x0_priv *priv)
+{
+	struct pd692x0_msg msg = pd692x0_msg_template_list[PD692X0_MSG_RESET];
+	const struct i2c_client *client = priv->client;
+	struct pd692x0_msg_content buf = {0};
+	int ret;
+
+	ret = pd692x0_send_msg(priv, &msg);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to reset the controller (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	msleep(30);
+
+	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		return ret < 0 ? ret : -EIO;
+
+	/* Is the reply a successful report message */
+	if (buf.key != PD692X0_KEY_REPORT || buf.sub[0] || buf.sub[1])
+		return -EIO;
+
+	msleep(300);
+
+	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		return ret < 0 ? ret : -EIO;
+
+	/* Is the boot status without error */
+	if (buf.key != 0x03 || buf.echo != 0xff || buf.sub[0] & 0x1) {
+		dev_err(&client->dev, "PSE controller error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Implementation of the i2c communication in particular when there is
+ * a communication loss. See the "Synchronization During Communication Loss"
+ * paragraph of the Communication Protocol document.
+ */
+static int pd692x0_recv_msg(struct pd692x0_priv *priv,
+			    struct pd692x0_msg *msg,
+			    struct pd692x0_msg_content *buf)
+{
+	const struct i2c_client *client = priv->client;
+	int ret;
+
+	memset(buf, 0, sizeof(*buf));
+	if (msg->delay_recv)
+		msleep(msg->delay_recv);
+	else
+		msleep(30);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	msleep(100);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	ret = pd692x0_send_msg(priv, msg);
+	if (ret)
+		return ret;
+
+	if (msg->delay_recv)
+		msleep(msg->delay_recv);
+	else
+		msleep(30);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	msleep(100);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	msleep(10000);
+
+	ret = pd692x0_send_msg(priv, msg);
+	if (ret)
+		return ret;
+
+	if (msg->delay_recv)
+		msleep(msg->delay_recv);
+	else
+		msleep(30);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	msleep(100);
+
+	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
+	if (buf->key)
+		goto out;
+
+	return pd692x0_reset(priv);
+
+out:
+	if (msg->content.key == PD692X0_KEY_CMD) {
+		priv->last_cmd_key = true;
+		priv->last_cmd_key_time = jiffies;
+	} else {
+		priv->last_cmd_key = false;
+	}
+
+	return 0;
+}
+
+static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
+				struct pd692x0_msg *msg,
+				struct pd692x0_msg_content *buf)
+{
+	struct device *dev = &priv->client->dev;
+	int ret;
+
+	ret = pd692x0_send_msg(priv, msg);
+	if (ret)
+		return ret;
+
+	ret = pd692x0_recv_msg(priv, msg, buf);
+	if (ret)
+		return ret;
+
+	if (msg->content.echo != buf->echo) {
+		dev_err(dev, "Wrong match in message ID\n");
+		return -EIO;
+	}
+
+	/* If the reply is a report message is it successful */
+	if (buf->key == PD692X0_KEY_REPORT &&
+	    (buf->sub[0] || buf->sub[1])) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static struct pd692x0_priv *to_pd692x0_priv(struct pse_controller_dev *pcdev)
+{
+	return container_of(pcdev, struct pd692x0_priv, pcdev);
+}
+
+static int pd692x0_fw_unavailable(struct pd692x0_priv *priv)
+{
+	switch (priv->fw_state) {
+	case PD692X0_FW_OK:
+		return 0;
+	case PD692X0_FW_PREPARE:
+	case PD692X0_FW_WRITE:
+	case PD692X0_FW_COMPLETE:
+		dev_err(&priv->client->dev, "Firmware update in progress!\n");
+		return -EBUSY;
+	case PD692X0_FW_BROKEN:
+	case PD692X0_FW_NEED_UPDATE:
+	default:
+		dev_err(&priv->client->dev,
+			"Firmware issue. Please update it!\n");
+		return -EOPNOTSUPP;
+	}
+}
+
+static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
+				      unsigned long id,
+				      struct netlink_ext_ack *extack,
+				      const struct pse_control_config *config)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg_content buf = {0};
+	struct pd692x0_msg msg;
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	if (priv->admin_state[id] == config->admin_control)
+		return 0;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	switch (config->admin_control) {
+	case ETHTOOL_PSE_ADMIN_STATE_ENABLED:
+		msg.content.data[0] = 0x1;
+		break;
+	case ETHTOOL_PSE_ADMIN_STATE_DISABLED:
+		msg.content.data[0] = 0x0;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msg.content.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	priv->admin_state[id] = config->admin_control;
+
+	return 0;
+}
+
+static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
+				      unsigned long id,
+				      struct netlink_ext_ack *extack,
+				      struct pse_control_status *status)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg_content buf = {0};
+	struct pd692x0_msg msg;
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
+	msg.content.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	/* Compare Port Status (Communication Protocol Document par. 7.1) */
+	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
+		status->pw_status = ETHTOOL_PSE_PW_D_STATUS_DELIVERING;
+	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
+		status->pw_status = ETHTOOL_PSE_PW_D_STATUS_SEARCHING;
+	else if (buf.sub[0] == 0x12)
+		status->pw_status = ETHTOOL_PSE_PW_D_STATUS_FAULT;
+	else
+		status->pw_status = ETHTOOL_PSE_PW_D_STATUS_DISABLED;
+
+	if (buf.sub[1])
+		status->admin_state = ETHTOOL_PSE_ADMIN_STATE_ENABLED;
+	else
+		status->admin_state = ETHTOOL_PSE_ADMIN_STATE_DISABLED;
+
+	priv->admin_state[id] = status->admin_state;
+
+	return 0;
+}
+
+static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
+{
+	struct pd692x0_msg msg = pd692x0_msg_template_list[PD692X0_MSG_GET_SW_VER];
+	struct device *dev = &priv->client->dev;
+	struct pd692x0_msg_content buf = {0};
+	struct pd692x0_msg_ver ver = {0};
+	int ret;
+
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get PSE version (%pe)\n", ERR_PTR(ret));
+		return ver;
+	}
+
+	/* Extract version from the message */
+	ver.prod = buf.sub[2];
+	ver.maj_sw_ver = (buf.data[0] << 8 | buf.data[1]) / 100;
+	ver.min_sw_ver = ((buf.data[0] << 8 | buf.data[1]) / 10) % 10;
+	ver.pa_sw_ver = (buf.data[0] << 8 | buf.data[1]) % 10;
+	ver.param = buf.data[2];
+	ver.build = buf.data[3];
+
+	return ver;
+}
+
+static const struct pse_controller_ops pd692x0_ops = {
+	.ethtool_get_status = pd692x0_ethtool_get_status,
+	.ethtool_set_config = pd692x0_ethtool_set_config,
+};
+
+struct matrix {
+	u8 hw_port_a;
+	u8 hw_port_b;
+};
+
+static int
+pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
+			 const struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
+{
+	struct pd692x0_msg_content buf;
+	struct pd692x0_msg msg;
+	int ret, i;
+
+	/* Write temporary Matrix */
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_TMP_PORT_MATRIX];
+	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
+		msg.content.sub[2] = i;
+		msg.content.data[0] = port_matrix[i].hw_port_a;
+		msg.content.data[1] = port_matrix[i].hw_port_b;
+
+		ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Program Matrix */
+	msg = pd692x0_msg_template_list[PD692X0_MSG_PRG_PORT_MATRIX];
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int
+pd692x0_get_of_matrix(struct device *dev,
+		      struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
+{
+	int ret, i, ports_matrix_size;
+	u32 val[PD692X0_MAX_LOGICAL_PORTS * 3];
+
+	ports_matrix_size = device_property_count_u32(dev, "ports-matrix");
+	if (ports_matrix_size <= 0)
+		return -EINVAL;
+	if (ports_matrix_size % 3 ||
+	    ports_matrix_size > PD692X0_MAX_LOGICAL_PORTS * 3) {
+		dev_err(dev, "Not valid ports-matrix property size: %d\n",
+			ports_matrix_size);
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32_array(dev, "ports-matrix", val,
+					     ports_matrix_size);
+	if (ret < 0)
+		return ret;
+
+	/* Init Matrix */
+	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
+		port_matrix[i].hw_port_a = 0xff;
+		port_matrix[i].hw_port_b = 0xff;
+	}
+
+	/* Update with values from DT */
+	for (i = 0; i < ports_matrix_size; i += 3) {
+		unsigned int logical_port;
+
+		if (val[i] >= PD692X0_MAX_LOGICAL_PORTS) {
+			dev_err(dev, "Not valid ports-matrix property\n");
+			return -EINVAL;
+		}
+		logical_port = val[i];
+
+		if (val[i + 1] < PD692X0_MAX_HW_PORTS)
+			port_matrix[logical_port].hw_port_a = val[i + 1];
+
+		if (val[i + 2] < PD692X0_MAX_HW_PORTS)
+			port_matrix[logical_port].hw_port_b = val[i + 2];
+	}
+
+	return 0;
+}
+
+static int pd692x0_update_matrix(struct pd692x0_priv *priv)
+{
+	struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS];
+	struct device *dev = &priv->client->dev;
+	int ret;
+
+	ret = pd692x0_get_of_matrix(dev, port_matrix);
+	if (ret < 0) {
+		dev_warn(dev,
+			 "Unable to parse port-matrix, saved matrix will be used\n");
+		return 0;
+	}
+
+	ret = pd692x0_set_ports_matrix(priv, port_matrix);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#define PD692X0_FW_LINE_MAX_SZ 128
+static int pd692x0_fw_get_next_line(const u8 *data,
+				    char *line, size_t size)
+{
+	size_t line_size;
+	int i;
+
+	line_size = min_t(size_t, size, (size_t)PD692X0_FW_LINE_MAX_SZ);
+
+	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
+	for (i = 0; i < line_size - 1; i++) {
+		if (*data == '\r' && *(data + 1) == '\n') {
+			line[i] = '\r';
+			line[i + 1] = '\n';
+			return i + 2;
+		}
+		line[i] = *data;
+		data++;
+	}
+
+	return 0;
+}
+
+static enum fw_upload_err
+pd692x0_fw_recv_resp(const struct i2c_client *client, unsigned long ms_timeout,
+		     const char *msg_ok, unsigned int msg_size)
+{
+	/* Maximum controller response size */
+	char fw_msg_buf[5] = {0};
+	unsigned long timeout;
+	int ret;
+
+	if (msg_size > sizeof(fw_msg_buf))
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	/* Read until we get something */
+	timeout = msecs_to_jiffies(ms_timeout) + jiffies;
+	while (true) {
+		if (time_is_before_jiffies(timeout))
+			return FW_UPLOAD_ERR_TIMEOUT;
+
+		ret = i2c_master_recv(client, fw_msg_buf, 1);
+		if (ret < 0 || *fw_msg_buf == 0) {
+			usleep_range(1000, 2000);
+			continue;
+		} else {
+			break;
+		}
+	}
+
+	/* Read remaining characters */
+	ret = i2c_master_recv(client, fw_msg_buf + 1, msg_size - 1);
+	if (!strncmp(fw_msg_buf, msg_ok, msg_size)) {
+		return FW_UPLOAD_ERR_NONE;
+	} else {
+		dev_err(&client->dev,
+			"Wrong FW download process answer (%*pE)\n",
+			msg_size, fw_msg_buf);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+}
+
+static int pd692x0_fw_write_line(const struct i2c_client *client,
+				 const char line[PD692X0_FW_LINE_MAX_SZ],
+				 const bool last_line)
+{
+	int ret;
+
+	while (*line != 0) {
+		ret = i2c_master_send(client, line, 1);
+		if (ret < 0)
+			return FW_UPLOAD_ERR_RW_ERROR;
+		line++;
+	}
+
+	if (last_line) {
+		ret = pd692x0_fw_recv_resp(client, 100, "TP\r\n",
+					   sizeof("TP\r\n") - 1);
+		if (ret)
+			return ret;
+	} else {
+		ret = pd692x0_fw_recv_resp(client, 100, "T*\r\n",
+					   sizeof("T*\r\n") - 1);
+		if (ret)
+			return ret;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err pd692x0_fw_reset(const struct i2c_client *client)
+{
+	const struct pd692x0_msg_content zero = {0};
+	struct pd692x0_msg_content buf = {0};
+	unsigned long timeout;
+	char cmd[] = "RST";
+	int ret;
+
+	ret = i2c_master_send(client, cmd, strlen(cmd));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to reset the controller (%pe)\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	timeout = msecs_to_jiffies(10000) + jiffies;
+	while (true) {
+		if (time_is_before_jiffies(timeout))
+			return FW_UPLOAD_ERR_TIMEOUT;
+
+		ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
+		if (ret < 0 ||
+		    !memcmp(&buf, &zero, sizeof(buf)))
+			usleep_range(1000, 2000);
+		else
+			break;
+	}
+
+	/* Is the reply a successful report message */
+	if (buf.key != PD692X0_KEY_TLM || buf.echo != 0xff ||
+	    buf.sub[0] & 0x01) {
+		dev_err(&client->dev, "PSE controller error\n");
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	/* Is the firmware operational */
+	if (buf.sub[0] & 0x02) {
+		dev_err(&client->dev,
+			"PSE firmware error. Please update it.\n");
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err pd692x0_fw_prepare(struct fw_upload *fwl,
+					     const u8 *data, u32 size)
+{
+	struct pd692x0_priv *priv = fwl->dd_handle;
+	const struct i2c_client *client = priv->client;
+	enum pd692x0_fw_state last_fw_state;
+	int ret;
+
+	priv->cancel_request = false;
+	last_fw_state = priv->fw_state;
+
+	priv->fw_state = PD692X0_FW_PREPARE;
+
+	/* Enter program mode */
+	if (last_fw_state == PD692X0_FW_BROKEN) {
+		const char *msg = "ENTR";
+		const char *c;
+
+		c = msg;
+		do {
+			ret = i2c_master_send(client, c, 1);
+			if (ret < 0)
+				return FW_UPLOAD_ERR_RW_ERROR;
+			if (*(c + 1))
+				usleep_range(10000, 20000);
+		} while (*(++c));
+	} else {
+		struct pd692x0_msg_content buf;
+		struct pd692x0_msg msg;
+
+		msg = pd692x0_msg_template_list[PD692X0_MSG_DOWNLOAD_CMD];
+		ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Failed to enter programming mode (%pe)\n",
+				ERR_PTR(ret));
+			return FW_UPLOAD_ERR_RW_ERROR;
+		}
+	}
+
+	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
+	if (ret)
+		goto err_out;
+
+	if (priv->cancel_request) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_out;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+
+err_out:
+	pd692x0_fw_reset(priv->client);
+	priv->fw_state = last_fw_state;
+	return ret;
+}
+
+static enum fw_upload_err pd692x0_fw_write(struct fw_upload *fwl,
+					   const u8 *data, u32 offset,
+					   u32 size, u32 *written)
+{
+	struct pd692x0_priv *priv = fwl->dd_handle;
+	char line[PD692X0_FW_LINE_MAX_SZ];
+	const struct i2c_client *client;
+	int ret, i;
+	char cmd;
+
+	client = priv->client;
+	priv->fw_state = PD692X0_FW_WRITE;
+
+	/* Erase */
+	cmd = 'E';
+	ret = i2c_master_send(client, &cmd, 1);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to boot programming mode (%pe)\n",
+			ERR_PTR(ret));
+		return FW_UPLOAD_ERR_RW_ERROR;
+	}
+
+	ret = pd692x0_fw_recv_resp(client, 100, "TOE\r\n", sizeof("TOE\r\n") - 1);
+	if (ret)
+		return ret;
+
+	ret = pd692x0_fw_recv_resp(client, 5000, "TE\r\n", sizeof("TE\r\n") - 1);
+	if (ret)
+		dev_warn(&client->dev,
+			 "Failed to erase internal memory, however still try to write Firmware\n");
+
+	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
+	if (ret)
+		dev_warn(&client->dev,
+			 "Failed to erase internal memory, however still try to write Firmware\n");
+
+	if (priv->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	/* Program */
+	cmd = 'P';
+	ret = i2c_master_send(client, &cmd, sizeof(char));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to boot programming mode (%pe)\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = pd692x0_fw_recv_resp(client, 100, "TOP\r\n", sizeof("TOP\r\n") - 1);
+	if (ret)
+		return ret;
+
+	i = 0;
+	while (i < size) {
+		ret = pd692x0_fw_get_next_line(data, line, size - i);
+		if (!ret) {
+			ret = FW_UPLOAD_ERR_FW_INVALID;
+			goto err;
+		}
+
+		i += ret;
+		data += ret;
+		if (line[0] == 'S' && line[1] == '0') {
+			continue;
+		} else if (line[0] == 'S' && line[1] == '7') {
+			ret = pd692x0_fw_write_line(client, line, true);
+			if (ret)
+				goto err;
+		} else {
+			ret = pd692x0_fw_write_line(client, line, false);
+			if (ret)
+				goto err;
+		}
+
+		if (priv->cancel_request) {
+			ret = FW_UPLOAD_ERR_CANCELED;
+			goto err;
+		}
+	}
+	*written = i;
+
+	msleep(400);
+
+	return FW_UPLOAD_ERR_NONE;
+
+err:
+	pd692x0_fw_write_line(client, "S7\r\n", true);
+	return ret;
+}
+
+static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *fwl)
+{
+	struct pd692x0_priv *priv = fwl->dd_handle;
+	const struct i2c_client *client = priv->client;
+	struct pd692x0_msg_ver ver;
+	int ret;
+
+	priv->fw_state = PD692X0_FW_COMPLETE;
+
+	ret = pd692x0_fw_reset(client);
+	if (ret)
+		return ret;
+
+	ver = pd692x0_get_sw_version(priv);
+	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {
+		dev_err(&client->dev,
+			"Too old firmware version. Please update it\n");
+		priv->fw_state = PD692X0_FW_NEED_UPDATE;
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+
+	ret = pd692x0_update_matrix(priv);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error configuring ports matrix (%pe)\n",
+			ERR_PTR(ret));
+		priv->fw_state = PD692X0_FW_NEED_UPDATE;
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	priv->fw_state = PD692X0_FW_OK;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void pd692x0_fw_cancel(struct fw_upload *fwl)
+{
+	struct pd692x0_priv *priv = fwl->dd_handle;
+
+	priv->cancel_request = true;
+}
+
+static void pd692x0_fw_cleanup(struct fw_upload *fwl)
+{
+	struct pd692x0_priv *priv = fwl->dd_handle;
+
+	switch (priv->fw_state) {
+	case PD692X0_FW_WRITE:
+		pd692x0_fw_reset(priv->client);
+		fallthrough;
+	case PD692X0_FW_COMPLETE:
+		priv->fw_state = PD692X0_FW_BROKEN;
+		break;
+	default:
+		break;
+	}
+}
+
+static const struct fw_upload_ops pd692x0_fw_ops = {
+	.prepare = pd692x0_fw_prepare,
+	.write = pd692x0_fw_write,
+	.poll_complete = pd692x0_fw_poll_complete,
+	.cancel = pd692x0_fw_cancel,
+	.cleanup = pd692x0_fw_cleanup,
+};
+
+static int pd692x0_i2c_probe(struct i2c_client *client)
+{
+	struct pd692x0_msg_content buf = {0};
+	struct device *dev = &client->dev;
+	struct pd692x0_msg_ver ver;
+	struct pd692x0_priv *priv;
+	struct fw_upload *fwl;
+	int ret;
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
+	priv->client = client;
+	i2c_set_clientdata(client, priv);
+
+	priv->pcdev.owner = THIS_MODULE;
+	priv->pcdev.ops = &pd692x0_ops;
+	priv->pcdev.dev = dev;
+	priv->pcdev.types = PSE_POE;
+	priv->pcdev.of_pse_n_cells = 1;
+	priv->pcdev.nr_lines = PD692X0_MAX_LOGICAL_PORTS;
+	ret = devm_pse_controller_register(dev, &priv->pcdev);
+	if (ret) {
+		return dev_err_probe(dev, ret,
+				     "failed to register PSE controller\n");
+	}
+
+	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
+				       &pd692x0_fw_ops, priv);
+	if (IS_ERR(fwl)) {
+		dev_err(dev, "Failed to register to the Firmware Upload API\n");
+		ret = PTR_ERR(fwl);
+		return ret;
+	}
+	priv->fwl = fwl;
+
+	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		dev_err(dev, "Failed to get device status\n");
+		ret = -EIO;
+		goto err_fw_unregister;
+	}
+
+	if (buf.key != 0x03 || buf.echo != 0xff || buf.sub[0] & 0x01) {
+		dev_err(dev, "PSE controller error\n");
+		ret = -EIO;
+		goto err_fw_unregister;
+	}
+
+	if (buf.sub[0] & 0x02) {
+		dev_err(dev, "PSE firmware error. Please update it.\n");
+		priv->fw_state = PD692X0_FW_BROKEN;
+		return 0;
+	}
+
+	ver = pd692x0_get_sw_version(priv);
+	dev_info(&client->dev, "Software version %d.%02d.%d.%d\n", ver.prod,
+		 ver.maj_sw_ver, ver.min_sw_ver, ver.pa_sw_ver);
+
+	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {
+		dev_err(dev, "Too old firmware version. Please update it\n");
+		priv->fw_state = PD692X0_FW_NEED_UPDATE;
+		return 0;
+	}
+
+	ret = pd692x0_update_matrix(priv);
+	if (ret < 0) {
+		dev_err(dev, "Error configuring ports matrix (%pe)\n",
+			ERR_PTR(ret));
+		goto err_fw_unregister;
+	}
+
+	priv->fw_state = PD692X0_FW_OK;
+	return 0;
+
+err_fw_unregister:
+	firmware_upload_unregister(priv->fwl);
+	return ret;
+}
+
+static void pd692x0_i2c_remove(struct i2c_client *client)
+{
+	struct pd692x0_priv *priv = i2c_get_clientdata(client);
+
+	firmware_upload_unregister(priv->fwl);
+}
+
+static const struct i2c_device_id pd692x0_id[] = {
+	{ PD692X0_PSE_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, pd692x0_id);
+
+static const struct of_device_id pd692x0_of_match[] = {
+	{ .compatible = "microchip,pd69200", },
+	{ .compatible = "microchip,pd69210", },
+	{ .compatible = "microchip,pd69220", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pd692x0_of_match);
+
+static struct i2c_driver pd692x0_driver = {
+	.probe		= pd692x0_i2c_probe,
+	.remove		= pd692x0_i2c_remove,
+	.id_table	= pd692x0_id,
+	.driver		= {
+		.name		= PD692X0_PSE_NAME,
+		.of_match_table = of_match_ptr(pd692x0_of_match),
+	},
+};
+module_i2c_driver(pd692x0_driver);
+
+MODULE_AUTHOR("Kory Maincent <kory.maincent@bootlin.com>");
+MODULE_DESCRIPTION("Microchip PD692x0 PoE PSE Controller driver");
+MODULE_LICENSE("GPL");

-- 
2.25.1

