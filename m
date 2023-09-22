Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92C7AB2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjIVNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjIVNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670618F;
        Fri, 22 Sep 2023 06:31:30 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 97D7E86199;
        Fri, 22 Sep 2023 15:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695389489;
        bh=R5H5pwFQF0fsWQf2aZE1BSfKXRJEkCye58IvcZZU6FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIleYrcf8MA5hRBolfx8Y/e98kXj/Rveeewh/vrJNZ68G8sOxqANL7wlr57jnn6Kh
         rXOioPizuz4f72l6BdiwV2pm2CClp04P/EYSjJYXRIzRuZYs839gV7rx9bsx/fmt2o
         j+BWajHDIrzEq+7ZgYk7kYoQHHQKUOB4LZcYdhYNNo3u0r5RcI/dRpJnUzqu07sFZU
         gIhA1gb0IVcIYSfm+SW73G7rtJmil/9c3Ks5kXWFwt1lIjrktIqOmC2oWXNEDj4FTr
         6fXrX3oNMSisypEE2eWOdM4LlKHdl2KI1iYlXGTgB4ZiWlDDKBArVq0LGUS5bd0yxt
         eHmRFWL9o1NGw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v6 net-next 1/5] net: dsa: propagate extack to ds->ops->port_hsr_join()
Date:   Fri, 22 Sep 2023 15:31:04 +0200
Message-Id: <20230922133108.2090612-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922133108.2090612-1-lukma@denx.de>
References: <20230922133108.2090612-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Drivers can provide meaningful error messages which state a reason why
they can't perform an offload, and dsa_slave_changeupper() already has
the infrastructure to propagate these over netlink rather than printing
to the kernel log. So pass the extack argument and modify the xrs700x
driver's port_hsr_join() prototype.

Also take the opportunity and use the extack for the 2 -EOPNOTSUPP cases
from xrs700x_hsr_join().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes for v5:
- New patch
Changes for v6:
- None
---
 drivers/net/dsa/xrs700x/xrs700x.c | 18 ++++++++++++------
 include/net/dsa.h                 |  3 ++-
 net/dsa/port.c                    |  5 +++--
 net/dsa/port.h                    |  3 ++-
 net/dsa/slave.c                   |  2 +-
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 753fef757f11..5b02e9e426fd 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -548,7 +548,8 @@ static void xrs700x_bridge_leave(struct dsa_switch *ds, int port,
 }
 
 static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
-			    struct net_device *hsr)
+			    struct net_device *hsr,
+			    struct netlink_ext_ack *extack)
 {
 	unsigned int val = XRS_HSR_CFG_HSR_PRP;
 	struct dsa_port *partner = NULL, *dp;
@@ -562,16 +563,21 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 	if (ret)
 		return ret;
 
-	/* Only ports 1 and 2 can be HSR/PRP redundant ports. */
-	if (port != 1 && port != 2)
+	if (port != 1 && port != 2) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only ports 1 and 2 can offload HSR/PRP");
 		return -EOPNOTSUPP;
+	}
 
-	if (ver == HSR_V1)
+	if (ver == HSR_V1) {
 		val |= XRS_HSR_CFG_HSR;
-	else if (ver == PRP_V1)
+	} else if (ver == PRP_V1) {
 		val |= XRS_HSR_CFG_PRP;
-	else
+	} else {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only HSR v1 and PRP v1 can be offloaded");
 		return -EOPNOTSUPP;
+	}
 
 	dsa_hsr_foreach_port(dp, ds, hsr) {
 		if (dp->index != port) {
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 0b9c6aa27047..426724808e76 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1198,7 +1198,8 @@ struct dsa_switch_ops {
 	 * HSR integration
 	 */
 	int	(*port_hsr_join)(struct dsa_switch *ds, int port,
-				 struct net_device *hsr);
+				 struct net_device *hsr,
+				 struct netlink_ext_ack *extack);
 	int	(*port_hsr_leave)(struct dsa_switch *ds, int port,
 				  struct net_device *hsr);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 37ab238e8304..5f01bd4f9dec 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -2024,7 +2024,8 @@ void dsa_shared_port_link_unregister_of(struct dsa_port *dp)
 		dsa_shared_port_setup_phy_of(dp, false);
 }
 
-int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
+int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
+		      struct netlink_ext_ack *extack)
 {
 	struct dsa_switch *ds = dp->ds;
 	int err;
@@ -2034,7 +2035,7 @@ int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
 
 	dp->hsr_dev = hsr;
 
-	err = ds->ops->port_hsr_join(ds, dp->index, hsr);
+	err = ds->ops->port_hsr_join(ds, dp->index, hsr, extack);
 	if (err)
 		dp->hsr_dev = NULL;
 
diff --git a/net/dsa/port.h b/net/dsa/port.h
index dc812512fd0e..334879964e2c 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -103,7 +103,8 @@ int dsa_port_phylink_create(struct dsa_port *dp);
 void dsa_port_phylink_destroy(struct dsa_port *dp);
 int dsa_shared_port_link_register_of(struct dsa_port *dp);
 void dsa_shared_port_link_unregister_of(struct dsa_port *dp);
-int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr);
+int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
+		      struct netlink_ext_ack *extack);
 void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr);
 int dsa_port_tag_8021q_vlan_add(struct dsa_port *dp, u16 vid, bool broadcast);
 void dsa_port_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid, bool broadcast);
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 48db91b33390..2b3d89b77121 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2862,7 +2862,7 @@ static int dsa_slave_changeupper(struct net_device *dev,
 		}
 	} else if (is_hsr_master(info->upper_dev)) {
 		if (info->linking) {
-			err = dsa_port_hsr_join(dp, info->upper_dev);
+			err = dsa_port_hsr_join(dp, info->upper_dev, extack);
 			if (err == -EOPNOTSUPP) {
 				NL_SET_ERR_MSG_WEAK_MOD(extack,
 							"Offloading not supported");
-- 
2.20.1

