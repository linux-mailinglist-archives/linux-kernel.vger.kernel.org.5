Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70A7916C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbjIDMCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352891AbjIDMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:02:38 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C7197;
        Mon,  4 Sep 2023 05:02:35 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4E6D8868D7;
        Mon,  4 Sep 2023 14:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693828953;
        bh=TB1orKzZPdYd/W9FJV9+IgTkxq4vRghKmc6XDm5R0nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lK1damqToKmf1FvbFopm4J3LgBkIupYVLozlF3wvkYwgHmv4w9zbSzARJKeVohE1V
         8SFdA69UmQHvp61eIKB24A67qvzt5cftnD61WVgOpl5/W0QA6K/zDHUEfl9dqBRuI1
         pljhHsXP6YKh9KXOc1N3Een1S3UIRqoG8JQn+LhPTtRi0l8OJ7nhaRf0rieElyJfPN
         ZXsaLkDfxzSoCuBofg+7I+AOEFhRMjWkanmwkKz5SwexMKpPUBJTq8IMj+0AJscSae
         1wNd4x2jwrbddbIahTO9WK6iGwSXKyStxxMbgprC6g4NL892zR5Oh4Was0Xy0NfbKk
         lku+olBaEUSfA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions
Date:   Mon,  4 Sep 2023 14:02:09 +0200
Message-Id: <20230904120209.741207-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904120209.741207-1-lukma@denx.de>
References: <20230904120209.741207-1-lukma@denx.de>
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

This patch provides the common KSZ (i.e. Microchip) DSA code with support
for HSR aware devices.

To be more specific - generic ksz_hsr_{join|leave} functions are provided,
now only supporting KSZ9477 IC.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- None

Changes for v3:
- Do not return -EOPNOTSUPP for only PRP_V1 (as v2 will not be caught)
---
 drivers/net/dsa/microchip/ksz_common.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 579fde54d1e1..91d1acaf4494 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -16,6 +16,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_mdio.h>
@@ -3433,6 +3434,72 @@ u16 ksz_hsr_get_ports(struct dsa_switch *ds)
 	return 0;
 }
 
+static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct dsa_port *partner = NULL, *dp;
+	struct ksz_device *dev = ds->priv;
+	enum hsr_version ver;
+	int ret;
+
+	ret = hsr_get_version(hsr, &ver);
+	if (ret)
+		return ret;
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		if (!(ver == HSR_V0 || ver == HSR_V1))
+			return -EOPNOTSUPP;
+	}
+
+	/* We can't enable redundancy on the switch until both
+	 * redundant ports have signed up.
+	 */
+	dsa_hsr_foreach_port(dp, ds, hsr) {
+		if (dp->index != port) {
+			partner = dp;
+			break;
+		}
+	}
+
+	if (!partner)
+		return 0;
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		return ksz9477_hsr_join(ds, port, hsr, partner);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int ksz_hsr_leave(struct dsa_switch *ds, int port,
+			 struct net_device *hsr)
+{
+	struct dsa_port *partner = NULL, *dp;
+	struct ksz_device *dev = ds->priv;
+
+	dsa_hsr_foreach_port(dp, ds, hsr) {
+		if (dp->index != port) {
+			partner = dp;
+			break;
+		}
+	}
+
+	if (!partner)
+		return 0;
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		return ksz9477_hsr_leave(ds, port, hsr, partner);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -3452,6 +3519,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-- 
2.20.1

