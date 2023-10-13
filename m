Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543B7C87D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjJMOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjJMOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:25:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC5FBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:25:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso331529366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697207104; x=1697811904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hYPyNWfhlkAln59TS92vnWpVAX7i6/D2Sn4mNSBY2s=;
        b=GbHF6JNrrs+7Hgo5LCG7qLywJOKZodejfYJ7TVfWdC7Gv/zqLIoE9mJcmqxkeworHV
         nafGxLRUaZNFm0+4+z0F1aCoRjL/56s7I7n0wfM/ZFuHIZK+Z34MxEyRR9MOcorGVNKO
         wdTUpnVtiGNoNZIGtkcxueMQTYOaxG9rz0FHXPv3e0eN5cLfRCddcCqRFNq6H5iTg0TZ
         +6xxjuk2yS0LjqlWmCzAqacj/H42O6Ur2clrA34VZg2U7sZJ27po/s5Y6aldk3sROaw5
         vJwnOh8pp2aObG/Qfv+tl6JCN9zyadnwIVjYYM1RRLCy3fkZV/Epwb1KwU8SGuJzT+CN
         1rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697207104; x=1697811904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hYPyNWfhlkAln59TS92vnWpVAX7i6/D2Sn4mNSBY2s=;
        b=a6MpOYasjuDoprgDIEwC/hIxW1Hm21/gimvqBh78YR8npFQE7VLS35+rVupxOJsd2o
         pIiyNCxhSPt+/gbNyoWPYvDZINIcI3WZ+KY4MBrj/foZEz8mQtSjKnb2ox688AlM7sT/
         DNPYG1Ef7g4epYb1GlJHqQOQ5Poj1gKPj0qm2qzQdNZ91mqEieFdH7DXTGXIhOHMSDUV
         HHjcR+GTqk5L0QboON0FHE/69raKjR2oGWgh5ihYs3WcYoL6AiWqmQP9wKmlUKOvi2KP
         h6DPNCzVOHdU21BID8AN8d0rmlP3nW456MVdUHxKykN4kCPvJktyzZ/O1pWuPDfihRDU
         G4NQ==
X-Gm-Message-State: AOJu0Yz3XhnpGEELcAyJQQrmmc0qNZknkdrdkiBigxHFR6Fi46uuPD19
        sUaMtIRZL9ln1EtuJkS1IhUtMA==
X-Google-Smtp-Source: AGHT+IFvjntRCzlOTLOhrrn4X5qZIuJRrGLj/5bP4lIY8YzrZnkT5mj4tEcCIfgjQRcrlee/HFAFqg==
X-Received: by 2002:a17:906:55:b0:9ae:68bf:bec with SMTP id 21-20020a170906005500b009ae68bf0becmr25242910ejg.75.1697207104287;
        Fri, 13 Oct 2023 07:25:04 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ot21-20020a170906ccd500b0099df2ddfc37sm12412041ejb.165.2023.10.13.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:25:03 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 16:24:48 +0200
Subject: [PATCH 2/2] usb: typec: add support for PTN36502 redriver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-ptn36502-v1-2-98109a430efc@fairphone.com>
References: <20231013-ptn36502-v1-0-98109a430efc@fairphone.com>
In-Reply-To: <20231013-ptn36502-v1-0-98109a430efc@fairphone.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the NXP PTN36502 Type-C USB 3.1 Gen 1 and DisplayPort
v1.2 combo redriver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/usb/typec/mux/Kconfig    |  10 +
 drivers/usb/typec/mux/Makefile   |   1 +
 drivers/usb/typec/mux/ptn36502.c | 421 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 432 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 65da61150ba7..816b9bd08355 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -46,4 +46,14 @@ config TYPEC_MUX_NB7VPQ904M
 	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
 	  redriver chip found on some devices with a Type-C port.
 
+config TYPEC_MUX_PTN36502
+	tristate "NXP PTN36502 Type-C redriver driver"
+	depends on I2C
+	depends on DRM || DRM=n
+	select DRM_PANEL_BRIDGE if DRM
+	select REGMAP_I2C
+	help
+	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
+	  found on some devices with a Type-C port.
+
 endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index 76196096ef41..9d6a5557b0bd 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
 obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
+obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
new file mode 100644
index 000000000000..91684a856f3a
--- /dev/null
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP PTN36502 Type-C driver
+ *
+ * Copyright (C) 2023 Luca Weiss <luca.weiss@fairphone.com>
+ *
+ * Based on NB7VPQ904M driver:
+ * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#include <drm/drm_bridge.h>
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
+
+#define PTN36502_CHIP_ID_REG				0x00
+#define PTN36502_CHIP_ID				0x02
+
+#define PTN36502_CHIP_REVISION_REG			0x01
+#define PTN36502_CHIP_REVISION_BASE(val)		FIELD_GET(GENMASK(7, 4), (val))
+#define PTN36502_CHIP_REVISION_METAL(val)		FIELD_GET(GENMASK(3, 0), (val))
+
+#define PTN36502_DP_LINK_CTRL_REG			0x06
+#define PTN36502_DP_LINK_CTRL_LANES_2			(2 << 2)
+#define PTN36502_DP_LINK_CTRL_LANES_4			(3 << 2)
+#define PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS		(2 << 0)
+
+/* Registers for lane 0 (0x07) to lane 3 (0x0a) have the same layout */
+#define PTN36502_DP_LANE_CTRL_REG(n)			(0x07 + (n))
+#define PTN36502_DP_LANE_CTRL_RX_GAIN_3DB		(2<<4)
+#define PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD		(2<<2)
+#define PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB	(1<<0)
+
+#define PTN36502_MODE_CTRL1_REG				0x0b
+#define PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE		(1<<5)
+#define PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON		(1<<3)
+#define PTN36502_MODE_CTRL1_MODE_OFF			(0<<0)
+#define PTN36502_MODE_CTRL1_MODE_USB_ONLY		(1<<0)
+#define PTN36502_MODE_CTRL1_MODE_USB_DP			(2<<0)
+#define PTN36502_MODE_CTRL1_MODE_DP			(3<<0)
+
+#define PTN36502_DEVICE_CTRL_REG			0x0d
+#define PTN36502_DEVICE_CTRL_AUX_MONITORING_EN		(1<<7)
+
+struct ptn36502 {
+	struct i2c_client *client;
+	struct regulator *vdd18_supply;
+	struct regmap *regmap;
+	struct typec_switch_dev *sw;
+	struct typec_retimer *retimer;
+
+	struct typec_switch *typec_switch;
+
+	struct drm_bridge bridge;
+
+	struct mutex lock; /* protect non-concurrent retimer & switch */
+
+	enum typec_orientation orientation;
+	unsigned long mode;
+	unsigned int svid;
+};
+
+static int ptn36502_set(struct ptn36502 *ptn)
+{
+	bool reverse = (ptn->orientation == TYPEC_ORIENTATION_REVERSE);
+	unsigned int ctrl1_val = 0;
+	unsigned int lane_ctrl_val = 0;
+	unsigned int link_ctrl_val = 0;
+
+	switch (ptn->mode) {
+	case TYPEC_STATE_SAFE:
+		/* Deep power saving state */
+		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG,
+			     PTN36502_MODE_CTRL1_MODE_OFF);
+		return 0;
+
+	case TYPEC_STATE_USB:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> X
+		 * D -> X
+		 * Flipped Orientation (CC2)
+		 * A -> X
+		 * B -> X
+		 * C -> USB TX
+		 * D -> USB RX
+		 */
+
+		/* USB 3.1 Gen 1 only */
+		ctrl1_val = PTN36502_MODE_CTRL1_MODE_USB_ONLY;
+		if (reverse)
+			ctrl1_val |= PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE;
+
+		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
+		return 0;
+
+	default:
+		if (ptn->svid != USB_TYPEC_DP_SID)
+			return -EINVAL;
+
+		break;
+	}
+
+	/* DP Altmode Setup */
+
+	switch (ptn->mode) {
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> DP3
+		 * B -> DP2
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> DP2
+		 * D -> DP3
+		 */
+
+		/* 4-lane DP */
+		ctrl1_val |= PTN36502_MODE_CTRL1_MODE_DP;
+		link_ctrl_val |= PTN36502_DP_LINK_CTRL_LANES_4;
+		break;
+
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_F: /* State F is deprecated */
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> USB TX
+		 * D -> USB RX
+		 */
+
+		/* USB 3.1 Gen 1 and 2-lane DP */
+		ctrl1_val |= PTN36502_MODE_CTRL1_MODE_USB_DP;
+		link_ctrl_val |= PTN36502_DP_LINK_CTRL_LANES_2;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Enable AUX monitoring */
+	regmap_write(ptn->regmap, PTN36502_DEVICE_CTRL_REG,
+		     PTN36502_DEVICE_CTRL_AUX_MONITORING_EN);
+
+	/* Enable AUX switch path */
+	ctrl1_val |= PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON;
+	if (reverse)
+		ctrl1_val |= PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE;
+	regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
+
+	/* DP Link rate: 5.4 Gbps (HBR2) */
+	link_ctrl_val |= PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS;
+	regmap_write(ptn->regmap, PTN36502_DP_LINK_CTRL_REG, link_ctrl_val);
+
+	/*
+	 * For all lanes:
+	 * - Rx equivalization gain: 3 dB
+	 * - TX output swing control: 800 mVppd
+	 * - Pre-emphasis control: 3.5 dB
+	 */
+	lane_ctrl_val = PTN36502_DP_LANE_CTRL_RX_GAIN_3DB |
+			PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD |
+			PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB;
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(0), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(1), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(2), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(3), lane_ctrl_val);
+
+	return 0;
+}
+
+static int ptn36502_sw_set(struct typec_switch_dev *sw, enum typec_orientation orientation)
+{
+	struct ptn36502 *ptn = typec_switch_get_drvdata(sw);
+	int ret;
+
+	ret = typec_switch_set(ptn->typec_switch, orientation);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ptn->lock);
+
+	if (ptn->orientation != orientation) {
+		ptn->orientation = orientation;
+
+		ret = ptn36502_set(ptn);
+	}
+
+	mutex_unlock(&ptn->lock);
+
+	return ret;
+}
+
+static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
+{
+	struct ptn36502 *ptn = typec_retimer_get_drvdata(retimer);
+	int ret = 0;
+
+	mutex_lock(&ptn->lock);
+
+	if (ptn->mode != state->mode) {
+		ptn->mode = state->mode;
+
+		if (state->alt)
+			ptn->svid = state->alt->svid;
+		else
+			ptn->svid = 0; // No SVID
+
+		ret = ptn36502_set(ptn);
+	}
+
+	mutex_unlock(&ptn->lock);
+
+	return ret;
+}
+
+static int ptn36502_detect(struct ptn36502 *ptn)
+{
+	struct device *dev = &ptn->client->dev;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(ptn->regmap, PTN36502_CHIP_ID_REG,
+			  &reg_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
+
+	if (reg_val != PTN36502_CHIP_ID)
+		return dev_err_probe(dev, -ENODEV, "Unexpected chip ID: %x\n", reg_val);
+
+	ret = regmap_read(ptn->regmap, PTN36502_CHIP_REVISION_REG,
+			  &reg_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read chip revision\n");
+
+	dev_dbg(dev, "Chip revision: base layer version %lx, metal layer version %lx\n",
+		PTN36502_CHIP_REVISION_BASE(reg_val),
+		PTN36502_CHIP_REVISION_METAL(reg_val));
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
+static int ptn36502_bridge_attach(struct drm_bridge *bridge,
+				    enum drm_bridge_attach_flags flags)
+{
+	struct ptn36502 *ptn = container_of(bridge, struct ptn36502, bridge);
+	struct drm_bridge *next_bridge;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	next_bridge = devm_drm_of_get_bridge(&ptn->client->dev, ptn->client->dev.of_node, 0, 0);
+	if (IS_ERR(next_bridge)) {
+		dev_err(&ptn->client->dev, "failed to acquire drm_bridge: %pe\n", next_bridge);
+		return PTR_ERR(next_bridge);
+	}
+
+	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
+				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+
+static const struct drm_bridge_funcs ptn36502_bridge_funcs = {
+	.attach	= ptn36502_bridge_attach,
+};
+
+static int ptn36502_register_bridge(struct ptn36502 *ptn)
+{
+	ptn->bridge.funcs = &ptn36502_bridge_funcs;
+	ptn->bridge.of_node = ptn->client->dev.of_node;
+
+	return devm_drm_bridge_add(&ptn->client->dev, &ptn->bridge);
+}
+#else
+static int ptn36502_register_bridge(struct ptn36502 *ptn)
+{
+	return 0;
+}
+#endif
+
+static const struct regmap_config ptn36502_regmap = {
+	.max_register = 0x0d,
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ptn36502_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_retimer_desc retimer_desc = { };
+	struct ptn36502 *ptn;
+	int ret;
+
+	ptn = devm_kzalloc(dev, sizeof(*ptn), GFP_KERNEL);
+	if (!ptn)
+		return -ENOMEM;
+
+	ptn->client = client;
+
+	ptn->regmap = devm_regmap_init_i2c(client, &ptn36502_regmap);
+	if (IS_ERR(ptn->regmap)) {
+		dev_err(&client->dev, "Failed to allocate register map\n");
+		return PTR_ERR(ptn->regmap);
+	}
+
+	ptn->mode = TYPEC_STATE_SAFE;
+	ptn->orientation = TYPEC_ORIENTATION_NONE;
+
+	mutex_init(&ptn->lock);
+
+	ptn->vdd18_supply = devm_regulator_get_optional(dev, "vdd18");
+	if (IS_ERR(ptn->vdd18_supply))
+		return PTR_ERR(ptn->vdd18_supply);
+
+	ptn->typec_switch = fwnode_typec_switch_get(dev->fwnode);
+	if (IS_ERR(ptn->typec_switch))
+		return dev_err_probe(dev, PTR_ERR(ptn->typec_switch),
+				     "Failed to acquire orientation-switch\n");
+
+	ret = regulator_enable(ptn->vdd18_supply);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+
+	ret = ptn36502_detect(ptn);
+	if (ret)
+		goto err_disable_regulator;
+
+	ret = ptn36502_register_bridge(ptn);
+	if (ret)
+		goto err_disable_regulator;
+
+	sw_desc.drvdata = ptn;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = ptn36502_sw_set;
+
+	ptn->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(ptn->sw)) {
+		ret = dev_err_probe(dev, PTR_ERR(ptn->sw),
+				    "Failed to register typec switch\n");
+		goto err_disable_regulator;
+	}
+
+	retimer_desc.drvdata = ptn;
+	retimer_desc.fwnode = dev->fwnode;
+	retimer_desc.set = ptn36502_retimer_set;
+
+	ptn->retimer = typec_retimer_register(dev, &retimer_desc);
+	if (IS_ERR(ptn->retimer)) {
+		ret = dev_err_probe(dev, PTR_ERR(ptn->retimer),
+				    "Failed to register typec retimer\n");
+		goto err_switch_unregister;
+	}
+
+	return 0;
+
+err_switch_unregister:
+	typec_switch_unregister(ptn->sw);
+
+err_disable_regulator:
+	regulator_disable(ptn->vdd18_supply);
+
+	return ret;
+}
+
+static void ptn36502_remove(struct i2c_client *client)
+{
+	struct ptn36502 *ptn = i2c_get_clientdata(client);
+
+	typec_retimer_unregister(ptn->retimer);
+	typec_switch_unregister(ptn->sw);
+
+	regulator_disable(ptn->vdd18_supply);
+}
+
+static const struct i2c_device_id ptn36502_table[] = {
+	{ "ptn36502" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ptn36502_table);
+
+static const struct of_device_id ptn36502_of_table[] = {
+	{ .compatible = "nxp,ptn36502" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ptn36502_of_table);
+
+static struct i2c_driver ptn36502_driver = {
+	.driver = {
+		.name = "ptn36502",
+		.of_match_table = ptn36502_of_table,
+	},
+	.probe		= ptn36502_probe,
+	.remove		= ptn36502_remove,
+	.id_table	= ptn36502_table,
+};
+module_i2c_driver(ptn36502_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
+MODULE_DESCRIPTION("NXP PTN36502 Type-C driver");
+MODULE_LICENSE("GPL");

-- 
2.42.0

