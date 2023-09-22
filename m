Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA327AB2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjIVNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjIVNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A2CE;
        Fri, 22 Sep 2023 06:31:30 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2EA498641B;
        Fri, 22 Sep 2023 15:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695389489;
        bh=vmNuVlqmEFXjO6DC8o8YTxJvDDK3OrOeO1xwI+V/cgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxL5MQHqGuWEup0bG/OLgUuVLV2gnj/kwBJidjetD7K50dp15z6zxvsjP1T2u4LKt
         S6vBSEtxxt1M5ihjluf1gfJmWrAinKWkzxnz+ST2fSA9Qb9SfcuIUdbBgU0qZ8QrRi
         k5o5pXW2fZPnjgcRAYEaecQiZKnPPW18d5dRW2kZTrlXAtSXW717TZzafYlKG1PynQ
         aE95s7+k370mP0OKz+M1NK6hYZkYQWG6ZvIQPsYCABJ5uMS1KqKj5P4mBCpr7TTbak
         1DM71VvJEaMkv+WZe9Goi7ZVEEcdanchQty4aoKjp0+nMPaMOWwBZ1otXHQM+uUr3m
         N8ePwr0uivYcw==
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
Subject: [PATCH v6 net-next 2/5] net: dsa: notify drivers of MAC address changes on user ports
Date:   Fri, 22 Sep 2023 15:31:05 +0200
Message-Id: <20230922133108.2090612-3-lukma@denx.de>
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

In some cases, drivers may need to veto the changing of a MAC address on
a user port. Such is the case with KSZ9477 when it offloads a HSR device,
because it programs the MAC address of multiple ports to a shared
hardware register. Those ports need to have equal MAC addresses for the
lifetime of the HSR offload.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes for v5:
- New patch
Changes for v6:
- None
---
 include/net/dsa.h | 10 ++++++++++
 net/dsa/slave.c   |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 426724808e76..d98439ea6146 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -969,6 +969,16 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+
+	/*
+	 * Notification for MAC address changes on user ports. Drivers can
+	 * currently only veto operations. They should not use the method to
+	 * program the hardware, since the operation is not rolled back in case
+	 * of other errors.
+	 */
+	int	(*port_set_mac_address)(struct dsa_switch *ds, int port,
+					const unsigned char *addr);
+
 	/*
 	 * Compatibility between device trees defining multiple CPU ports and
 	 * drivers which are not OK to use by default the numerically smallest
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2b3d89b77121..4c3e502d7e16 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -457,6 +457,13 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	if (ds->ops->port_set_mac_address) {
+		err = ds->ops->port_set_mac_address(ds, dp->index,
+						    addr->sa_data);
+		if (err)
+			return err;
+	}
+
 	/* If the port is down, the address isn't synced yet to hardware or
 	 * to the DSA master, so there is nothing to change.
 	 */
-- 
2.20.1

