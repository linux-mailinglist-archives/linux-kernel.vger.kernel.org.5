Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40887BE591
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbjJIPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377841AbjJIPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:42 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABD195;
        Mon,  9 Oct 2023 08:52:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63CAF1C0015;
        Mon,  9 Oct 2023 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPtxSHc5kpsl/meOkJ1+JSY5q157KHdOe13rw3OA8+0=;
        b=S9mkSIlotahwxWU9oQA5FxOoPRbeOFzGDpQ38dPwB/Kk4+rqUW7rqapQjM2qXwIYTW4BOO
        FQszwaQs0qNkOYVscGZqPrf3NUgInpbJZiNNvj+8OykOuSSezkjuBp2Owri6C0bj3iMqO+
        AWE194HSvw/YVU6A3Qu8D3Ll1dUiBUC1tZipz0/KVwjyJtGPZobnMXhikePrqH81wlJ9gj
        hPz8AruBd2izW/0D7IzEB3PfnAx8mKI9sczK84voEqoEv8uMiaxCeULSxFEFCehJhE9ZIs
        AGxYJF2c7zVn4mLzjrI1p59MHMwpTclEhgqbazwja9/jv7xbt6CT8czXUQb1IA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 12/16] net: Replace hwtstamp_source by timestamping layer
Date:   Mon,  9 Oct 2023 17:51:34 +0200
Message-Id: <20231009155138.86458-13-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Replace hwtstamp_source which is only used by the kernel_hwtstamp_config
structure by the more widely use timestamp_layer structure. This is done
to prepare the support of selectable timestamping source.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c |  6 +++---
 include/linux/net_tstamp.h                            | 11 +++--------
 net/core/dev_ioctl.c                                  |  2 +-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 8e4101628fbd..83c1177469e2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -470,15 +470,15 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 	struct lan966x_port *port = netdev_priv(dev);
 	int err;
 
-	if (cfg->source != HWTSTAMP_SOURCE_NETDEV &&
-	    cfg->source != HWTSTAMP_SOURCE_PHYLIB)
+	if (cfg->source != NETDEV_TIMESTAMPING &&
+	    cfg->source != PHYLIB_TIMESTAMPING)
 		return -EOPNOTSUPP;
 
 	err = lan966x_ptp_setup_traps(port, cfg);
 	if (err)
 		return err;
 
-	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
+	if (cfg->source == NETDEV_TIMESTAMPING) {
 		if (!port->lan966x->ptp)
 			return -EOPNOTSUPP;
 
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index eb01c37e71e0..2c1af19d5421 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -5,11 +5,6 @@
 
 #include <uapi/linux/net_tstamp.h>
 
-enum hwtstamp_source {
-	HWTSTAMP_SOURCE_NETDEV,
-	HWTSTAMP_SOURCE_PHYLIB,
-};
-
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
@@ -20,8 +15,8 @@ enum hwtstamp_source {
  *	a legacy implementation of a lower driver
  * @copied_to_user: request was passed to a legacy implementation which already
  *	copied the ioctl request back to user space
- * @source: indication whether timestamps should come from the netdev or from
- *	an attached phylib PHY
+ * @source: indication whether timestamps should come from software, the netdev
+ *	or from an attached phylib PHY
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -33,7 +28,7 @@ struct kernel_hwtstamp_config {
 	int rx_filter;
 	struct ifreq *ifr;
 	bool copied_to_user;
-	enum hwtstamp_source source;
+	u32 source;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 342a667858ac..45cc1ea9b195 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -332,7 +332,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	bool changed = false;
 	int err;
 
-	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
+	cfg->source = phy_ts ? PHYLIB_TIMESTAMPING : NETDEV_TIMESTAMPING;
 
 	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
-- 
2.25.1

