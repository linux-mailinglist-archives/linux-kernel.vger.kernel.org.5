Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DD7CDAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbjJRLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjJRLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:39:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B0116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:39:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qt4tP-0002JS-KA; Wed, 18 Oct 2023 13:39:15 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qt4tO-002Xiw-Ka; Wed, 18 Oct 2023 13:39:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qt4tO-00FE8n-1i;
        Wed, 18 Oct 2023 13:39:14 +0200
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
Subject: [PATCH net-next v5 9/9] net: dsa: microchip: Ensure Stable PME Pin State for Wake-on-LAN
Date:   Wed, 18 Oct 2023 13:39:13 +0200
Message-Id: <20231018113913.3629151-10-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018113913.3629151-1-o.rempel@pengutronix.de>
References: <20231018113913.3629151-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensures a stable PME (Power Management Event) pin state by disabling PME
on system start and enabling it on shutdown only if WoL (Wake-on-LAN) is
configured. This is needed to avoid issues with some PMICs (Power
Management ICs).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c    | 46 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  1 +
 drivers/net/dsa/microchip/ksz_common.c |  8 ++++-
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index acc5d845363f..0e2ace0f8001 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -196,6 +196,46 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	return 0;
 }
 
+/**
+ * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while
+ *                            considering Wake-on-LAN (WoL) settings.
+ * @dev: The switch device structure.
+ * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
+ *               enabled on any port.
+ *
+ * This function prepares the switch device for a safe shutdown while taking
+ * into account the Wake-on-LAN (WoL) settings on the user ports. It updates
+ * the wol_enabled flag accordingly to reflect whether WoL is active on any
+ * port.
+ */
+void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+{
+	struct dsa_port *dp;
+	int ret;
+
+	*wol_enabled = false;
+
+	if (!dev->wakeup_source)
+		return;
+
+	dsa_switch_for_each_user_port(dp, dev->ds) {
+		u8 pme_ctrl = 0;
+
+		ret = ksz_pread8(dev, dp->index, REG_PORT_PME_CTRL, &pme_ctrl);
+		if (!ret && pme_ctrl)
+			*wol_enabled = true;
+
+		/* make sure there are no pending wake events which would
+		 * prevent the device from going to sleep/shutdown.
+		 */
+		ksz9477_handle_wake_reason(dev, dp->index);
+	}
+
+	/* Now we are save to enable PME pin. */
+	if (*wol_enabled)
+		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
+}
+
 static int ksz9477_wait_vlan_ctrl_ready(struct ksz_device *dev)
 {
 	unsigned int val;
@@ -1276,6 +1316,12 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* enable global MIB counter freeze function */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
 
+	/* Make sure PME (WoL) is not enabled. If requested, it will be
+	 * enabled by ksz9477_wol_pre_shutdown(). Otherwise, some PMICs do not
+	 * like PME events changes before shutdown.
+	 */
+	ksz_write8(dev, REG_SW_PME_CTRL, 0);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index fa8d0318b437..9e6f1e4b57b7 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -62,6 +62,7 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 		     struct ethtool_wolinfo *wol);
 int ksz9477_set_wol(struct ksz_device *dev, int port,
 		    struct ethtool_wolinfo *wol);
+void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_is_on);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index fe2cf1de5a5c..17eca902d48c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -321,6 +321,7 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.phylink_mac_link_up = ksz9477_phylink_mac_link_up,
 	.get_wol = ksz9477_get_wol,
 	.set_wol = ksz9477_set_wol,
+	.wol_pre_shutdown = ksz9477_wol_pre_shutdown,
 	.config_cpu_port = ksz9477_config_cpu_port,
 	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -3822,7 +3823,12 @@ EXPORT_SYMBOL(ksz_switch_alloc);
  */
 void ksz_switch_shutdown(struct ksz_device *dev)
 {
-	if (dev->dev_ops->reset)
+	bool wol_enabled = false;
+
+	if (dev->dev_ops->wol_pre_shutdown)
+		dev->dev_ops->wol_pre_shutdown(dev, &wol_enabled);
+
+	if (dev->dev_ops->reset && !wol_enabled)
 		dev->dev_ops->reset(dev);
 
 	dsa_switch_shutdown(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 34a8e9784cca..41917de15ba3 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -378,6 +378,7 @@ struct ksz_dev_ops {
 			struct ethtool_wolinfo *wol);
 	int (*set_wol)(struct ksz_device *dev, int port,
 		       struct ethtool_wolinfo *wol);
+	void (*wol_pre_shutdown)(struct ksz_device *dev, bool *wol_enabled);
 	void (*config_cpu_port)(struct dsa_switch *ds);
 	int (*enable_stp_addr)(struct ksz_device *dev);
 	int (*reset)(struct ksz_device *dev);
-- 
2.39.2

