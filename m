Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E187792AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjIEQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354572AbjIEMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:44:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2A1AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:44:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qdVPD-0000Dg-Rh; Tue, 05 Sep 2023 14:43:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qdVPB-004CML-Sv; Tue, 05 Sep 2023 14:43:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qdVPB-00HGwM-1Z;
        Tue, 05 Sep 2023 14:43:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [RFC net-next v1 2/2] net: dsa: microchip: ksz9477: Add drive strength configuration
Date:   Tue,  5 Sep 2023 14:43:40 +0200
Message-Id: <20230905124340.4116542-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905124340.4116542-1-o.rempel@pengutronix.de>
References: <20230905124340.4116542-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree based drive strength configuration support. It is needed to
pass EMI validation on our hardware.

Configuration values are based on the vendor's reference driver.

Tested on KSZ9563R.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 120 ++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 83b7f2d5c1ea6..04582d3fcbe14 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -19,6 +19,30 @@
 #include "ksz_common.h"
 #include "ksz9477.h"
 
+/**
+ * struct ksz9477_drive_strength - drive strength mapping
+ * @reg_val:	register value
+ * @milliamp:	milliamp value
+ */
+struct ksz9477_drive_strength {
+	u32 reg_val;
+	u32 milliamp;
+};
+
+/* Drive strength mapping.
+ * This values are not documented and taken from vendor's reference driver.
+ */
+static const struct ksz9477_drive_strength ksz9477_drive_strengths[] = {
+	{ SW_DRIVE_STRENGTH_2MA,  2000 },
+	{ SW_DRIVE_STRENGTH_4MA,  4000 },
+	{ SW_DRIVE_STRENGTH_8MA,  8000 },
+	{ SW_DRIVE_STRENGTH_12MA, 12000 },
+	{ SW_DRIVE_STRENGTH_16MA, 16000 },
+	{ SW_DRIVE_STRENGTH_20MA, 20000 },
+	{ SW_DRIVE_STRENGTH_24MA, 24000 },
+	{ SW_DRIVE_STRENGTH_28MA, 28000 },
+};
+
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
 	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
@@ -1097,11 +1121,107 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 	return 0;
 }
 
+/**
+ * ksz9477_drive_strength_to_reg() - convert milliamp value to register value
+ * @milliamp:	milliamp value
+ *
+ * Return: register value
+ */
+static u32 ksz9477_drive_strength_to_reg(u32 milliamp)
+{
+	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
+	int i;
+
+	for (i = 0; i < array_size; i++) {
+		if (ksz9477_drive_strengths[i].milliamp >= milliamp)
+			return ksz9477_drive_strengths[i].reg_val;
+	}
+
+	/* return the highest value if the requested value is too high */
+	return ksz9477_drive_strengths[array_size - 1].reg_val;
+}
+
+/**
+ * ksz9477_parse_drive_strength() - parse drive strength from device tree
+ * @dev:	ksz device
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int ksz9477_parse_drive_strength(struct ksz_device *dev)
+{
+	struct of_prop {
+		const char *name;
+		int offset;
+		int value;
+	} of_props[] = {
+		{
+			"microchip,hi-drive-strength-microamp",
+			SW_HI_SPEED_DRIVE_STRENGTH_S,
+			-1
+		},
+		{
+			"microchip,lo-drive-strength-microamp",
+			SW_LO_SPEED_DRIVE_STRENGTH_S,
+			-1
+		},
+	};
+	struct device_node *np = dev->dev->of_node;
+	bool found = false;
+	int ret;
+	u8 val;
+
+	if (!np)
+		return 0;
+
+	for (int i = 0; i < ARRAY_SIZE(of_props); i++) {
+		ret = of_property_read_u32(np, of_props[i].name,
+					   &of_props[i].value);
+		if (ret && ret != -EINVAL)
+			dev_warn(dev->dev, "Failed to read %s\n",
+				 of_props[i].name);
+		if (ret)
+			continue;
+
+		if (of_props[i].value > 28000 || of_props[i].value < 2000) {
+			dev_warn(dev->dev, "Drive strength value is out of range: %d. Supported values are (2000 - 28000)\n",
+				 of_props[i].value);
+			continue;
+		}
+
+		found = true;
+	}
+
+	if (!found)
+		return 0;
+
+	ret = ksz_read8(dev, REG_SW_IO_STRENGTH__1, &val);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(of_props); i++) {
+		int strength_val;
+
+		if (of_props[i].value == -1)
+			continue;
+
+		strength_val = ksz9477_drive_strength_to_reg(of_props[i].value);
+
+		val &= ~(SW_DRIVE_STRENGTH_M << of_props[i].offset);
+		val |= strength_val << of_props[i].offset;
+	}
+
+	return ksz_write8(dev, REG_SW_IO_STRENGTH__1, val);
+}
+
 int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret = 0;
 
+	ret = ksz9477_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
 	ds->mtu_enforcement_ingress = true;
 
 	/* Required for port partitioning. */
-- 
2.39.2

