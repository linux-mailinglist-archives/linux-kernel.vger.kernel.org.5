Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC97774BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHJJga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHJJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:36:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515391AB;
        Thu, 10 Aug 2023 02:36:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25260C000E;
        Thu, 10 Aug 2023 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691660178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zYws8EkytDB0LtOcES6newbruv8x27HW3nbGAgp9TQ=;
        b=LRmmnpZSxE6Vsrol9JvPFksSLm2Wwrhae5P5oM7TU0ilCC2zpwh4MRR775CH5S0ZjDvg1R
        zOWPg2LQhIR60S8wNkyi+yJeqVTNfCVJxqh/N3+Wu2QN+61dT7Q5napSUQiiXuigpdVu8g
        0INCaYjIhlJVvF9cXdbgA5LcG36GMPdk7xyW7r5E+Dl8FyOGT8YHepqpaQc4SUbUUY9c2R
        dWDOkZtBFSzc/7FJQaKRkyxPZwO0s4N6U24KMSCAFnwymOP9V4zdvcb/4myvvB8YPBJHBk
        NraQl89VnsdGmmm3o3sftGEU4sRI8Y97ciiyC9UM/qO1msv0tGdRCycZs/2Ndg==
From:   alexis.lothore@bootlin.com
To:     =?UTF-8?q?Cl=C3=A9ment=20Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v5 2/3] net: dsa: rzn1-a5psw: add support for .port_bridge_flags
Date:   Thu, 10 Aug 2023 11:36:50 +0200
Message-ID: <20230810093651.102509-3-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810093651.102509-1-alexis.lothore@bootlin.com>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Léger <clement.leger@bootlin.com>

When running vlan test (bridge_vlan_aware/unaware.sh), there were some
failure due to the lack .port_bridge_flag function to disable port
flooding. Implement this operation for BR_LEARNING, BR_FLOOD,
BR_MCAST_FLOOD and BR_BCAST_FLOOD.

Since .port_bridge_flags affects the bits disabling learning for a port,
ensure that any other modification on the same register done by
a5psw_port_stp_state_set is in sync by using the port learning state to
enable/disable learning on the port.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes since v4:
- ensure that learning and flooding masks are not updated if port does not
  belong to bridge
- remove reviewed-by since patch is modified
---
 drivers/net/dsa/rzn1_a5psw.c | 60 ++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 302529edb4e0..e4a93dad1d58 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -380,9 +380,63 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 		a5psw->br_dev = NULL;
 }
 
+static int a5psw_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				       struct switchdev_brport_flags flags,
+				       struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
+			   BR_BCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+a5psw_port_bridge_flags(struct dsa_switch *ds, int port,
+			struct switchdev_brport_flags flags,
+			struct netlink_ext_ack *extack)
+{
+	struct a5psw *a5psw = ds->priv;
+	u32 val;
+
+	/* If a port is set as standalone, we do not want to be able to
+	 * configure flooding nor learning which would result in joining the
+	 * unique bridge. This can happen when a port leaves the bridge, in
+	 * which case the DSA core will try to "clear" all flags for the
+	 * standalone port (ie enable flooding, disable learning). In that case
+	 * do not fail but do not apply the flags.
+	 */
+	if (!(a5psw->bridged_ports & BIT(port)))
+		return 0;
+
+	if (flags.mask & BR_LEARNING) {
+		val = flags.val & BR_LEARNING ? 0 : A5PSW_INPUT_LEARN_DIS(port);
+		a5psw_reg_rmw(a5psw, A5PSW_INPUT_LEARN,
+			      A5PSW_INPUT_LEARN_DIS(port), val);
+	}
+
+	if (flags.mask & BR_FLOOD) {
+		val = flags.val & BR_FLOOD ? BIT(port) : 0;
+		a5psw_reg_rmw(a5psw, A5PSW_UCAST_DEF_MASK, BIT(port), val);
+	}
+
+	if (flags.mask & BR_MCAST_FLOOD) {
+		val = flags.val & BR_MCAST_FLOOD ? BIT(port) : 0;
+		a5psw_reg_rmw(a5psw, A5PSW_MCAST_DEF_MASK, BIT(port), val);
+	}
+
+	if (flags.mask & BR_BCAST_FLOOD) {
+		val = flags.val & BR_BCAST_FLOOD ? BIT(port) : 0;
+		a5psw_reg_rmw(a5psw, A5PSW_BCAST_DEF_MASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static void a5psw_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
 	bool learning_enabled, rx_enabled, tx_enabled;
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct a5psw *a5psw = ds->priv;
 
 	switch (state) {
@@ -396,12 +450,12 @@ static void a5psw_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	case BR_STATE_LEARNING:
 		rx_enabled = false;
 		tx_enabled = false;
-		learning_enabled = true;
+		learning_enabled = dp->learning;
 		break;
 	case BR_STATE_FORWARDING:
 		rx_enabled = true;
 		tx_enabled = true;
-		learning_enabled = true;
+		learning_enabled = dp->learning;
 		break;
 	default:
 		dev_err(ds->dev, "invalid STP state: %d\n", state);
@@ -801,6 +855,8 @@ static const struct dsa_switch_ops a5psw_switch_ops = {
 	.set_ageing_time = a5psw_set_ageing_time,
 	.port_bridge_join = a5psw_port_bridge_join,
 	.port_bridge_leave = a5psw_port_bridge_leave,
+	.port_pre_bridge_flags = a5psw_port_pre_bridge_flags,
+	.port_bridge_flags = a5psw_port_bridge_flags,
 	.port_stp_state_set = a5psw_port_stp_state_set,
 	.port_fast_age = a5psw_port_fast_age,
 	.port_fdb_add = a5psw_port_fdb_add,
-- 
2.41.0

