Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981CE7A7AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjITLoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjITLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:44:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86EB4;
        Wed, 20 Sep 2023 04:44:02 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A5874869F1;
        Wed, 20 Sep 2023 13:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695210240;
        bh=67vlHukZaFGjkHApichur8eRgNYS3gbJziOHuaNO/YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILE+QNy1z7nlWsP9fcKmKIH1/4m/o0TLGjFEXNLzhFARZhBr05mt32hdsxTfFreJC
         l4gtud0F7pHyvkZU5g6YPXJBwjtIHQUFCXPbyXPqIt9fsZogr8ZVSzs1v73BSkeHLT
         4Ny2eZV/nWlmDdBiNbz1BAZz4qmigcH0pYZ1rHYmqeYgkduhM3IYZAdQyUMaidJ/7e
         SOeUyQhnosoxUnvWe6DgSTZItSlLxMVLaw6Bfv+GzvAbOla8XYsJRH+8RToIYUV5vb
         I5e5opyXWf9Q+fDTU7zp8ILIMjjDWKhKknf1o/cgP7LaBXrMvhjTjJ6+j3akeA5ogA
         W9IT99I4JK9pQ==
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
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 net-next 2/5] net: dsa: notify drivers of MAC address changes on user ports
Date:   Wed, 20 Sep 2023 13:43:40 +0200
Message-Id: <20230920114343.1979843-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920114343.1979843-1-lukma@denx.de>
References: <20230920114343.1979843-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

---
Changes for v5:
- New patch
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

