Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15F78C3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjH2MMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjH2MMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:21 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA681E42;
        Tue, 29 Aug 2023 05:12:07 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 56144864EE;
        Tue, 29 Aug 2023 14:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693311121;
        bh=kOS1yFTtJZ4KdCkpNLc5hb6wx4bgwB9PJ9YXkJlIZZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7NJWjrIJhzETXU8Ka35Ht2EugSYZOKJoDVpH+cm/BnAL0OcHB+qni9kmZvF3NciF
         qSITpH4BJ0zayTw0I5duuC5lJYxmdpzXniCrKMBLy/t1b0nRdd2BQrTITjqbg8uWD7
         IgjQ6QnmD/3CadRZtpR9nJ2xAuiUJ2dhThrglnhSJEMX/eRnR0XlTEJoG9La+oreh4
         Kvz247WbppEvgluK1oYYQuKR6Bqth6cIaKZzk2iLdQMIvNd3WokUjQzPVVgQvo8AY6
         hxlTKBKcaGTPIqTbK4QOJbCsTfeWtzyYYSyUySgTLFCRBcj3aOpMddbRpnmyMuoTxt
         xmUKg1TkEe0qQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 4/4] net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions
Date:   Tue, 29 Aug 2023 14:11:32 +0200
Message-Id: <20230829121132.414335-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829121132.414335-1-lukma@denx.de>
References: <20230829121132.414335-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/dsa/microchip/ksz_common.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6c0623f88654..d53ca28583cb 100644
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
@@ -3407,6 +3408,72 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
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
+		if (ver == PRP_V1)
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
@@ -3426,6 +3493,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
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

