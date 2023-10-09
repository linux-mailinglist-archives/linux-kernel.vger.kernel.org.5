Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C777BE575
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377589AbjJIPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377697AbjJIPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:08 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A88D6;
        Mon,  9 Oct 2023 08:52:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFDBC1C0014;
        Mon,  9 Oct 2023 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwoe6lOlx1E2/77Mocwc9aHtLkZweaYfyFKWpCGQ1gQ=;
        b=i+wsxQ6m1upWCYyo7u+e+YHrmJciyPcLnTSLp3AXxC5O/qfjJvoyHivghNry0Hg5lsJGhn
        OeMCox2R+6ZYcD/SJe8U7ZUy4fsvchMdbFd2zkq5UDdVVvxEe9h2ZCyRAvEbAeFZDhARq+
        6RZAourwHRPBrrqPuVJeKFIfaaB8nlI0J5QxyT73jQ1ibb+3jlHkBvsqX8gTZxqNA/BsBx
        Kke6HnWtyeg63AcPh/XEHDYAevc/GQpiVGCh4PfY8n9vty4kdOmS/s6ERI3zPYvURANlw3
        VBCOx3+DKO7oGk9GDqhhCr4zkaUYsZaZtcir1+Jzd4E+Bbcv5JL19cy8OHPD8w==
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
Subject: [PATCH net-next v5 05/16] net: Make dev_set_hwtstamp_phylib accessible
Date:   Mon,  9 Oct 2023 17:51:27 +0200
Message-Id: <20231009155138.86458-6-kory.maincent@bootlin.com>
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

Make the dev_set_hwtstamp_phylib function accessible in prevision to use
it from ethtool to reset the tstamp current configuration.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/netdevice.h | 3 +++
 net/core/dev_ioctl.c      | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fba..b9d0411836db 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3922,6 +3922,9 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b46aedc36939..342a667858ac 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -322,9 +322,9 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
  * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
  * dev->priv_flags.
  */
-static int dev_set_hwtstamp_phylib(struct net_device *dev,
-				   struct kernel_hwtstamp_config *cfg,
-				   struct netlink_ext_ack *extack)
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	bool phy_ts = phy_has_hwtstamp(dev->phydev);
-- 
2.25.1

