Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2720767EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjG2Lzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjG2Lzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:55:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928303C12;
        Sat, 29 Jul 2023 04:55:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3110ab7110aso3071365f8f.3;
        Sat, 29 Jul 2023 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631721; x=1691236521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctqBlXAMiyfYnaRkeShVlw6aAtoUNpe2VhMc2FK4fLQ=;
        b=ruhCYpM0VA1adzFUHQmltvoyU40eNELLez5iSNCCpniZ1z6uyTUWWgrQZspRlAyRrk
         4VYAW+WP4wZ+hacbtMXfrmyqoH302qatnH84OeRB0kMLiyMo9OsVhoBfV2QaiVPR7Hub
         K2/FK6vJwQ6J5392snlv69yWGWVNEMfqlUfn/zCeCYnPm1mcmbs/FHx7iHK5Tnc8kYTJ
         a8SL/BsaDPz1XjKwwOYNRnzW7kMWhg9r7KbSXXZduOEDDTN/vV5RV0cdbRd2Bh5hfJCO
         wFp1uRU0KZFg/piFydPmmW6ahqAaY8G2wyU6SotcznKnPtuFq4ar4iaHIgm9Qp9rmPBc
         oG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631721; x=1691236521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctqBlXAMiyfYnaRkeShVlw6aAtoUNpe2VhMc2FK4fLQ=;
        b=dlpLIn37p3kHvXWT3L9U9GlvYQWNta2osWp5G01rRQclJlc0D3wHe+8mAcdWcTaTcJ
         23tz3PuJd11m+0DPpxiQL4G7PZj1zg3tMgj6ulGAHZuJfhnBRQRTfbRCtxQxKR2FlHRY
         aKDdXdSnToYiSQe5/GcPh+AVOCkgFdEQYurb3ZjD+SFaNMcPXHmn3erpj2UJKmUBx9zd
         66NNHEh+cXaAdRsZJUUotfjxv3vzuCpG/qmuzh5C9ASJUQ5ZyuFu3mq04qt3h2xiH515
         /vi8kcgLVFRCJvLZ0Bw4ZmlDh8SH5k6aSHL74+lHtZ2fyRYbvq6qdeV7vttTGCLRz1bj
         UFow==
X-Gm-Message-State: ABy/qLY8pFF58ruJywZjBla7c2rFmZbHoqsYzH2La/mzYDxMhSxbcIun
        xre8mz1gWerUqYsloat0noT6rHOXkqolDA==
X-Google-Smtp-Source: APBJJlHmnihIDJ7769UPuQuL0FXm73J6sDhflrN0BsfHw406RpVVYskUk2miSpPCmE7cU1WuE8Xw8A==
X-Received: by 2002:a5d:5305:0:b0:313:f0d7:a43 with SMTP id e5-20020a5d5305000000b00313f0d70a43mr4025556wrv.23.1690631720861;
        Sat, 29 Jul 2023 04:55:20 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm7295289wrv.71.2023.07.29.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:55:20 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 5/5] net: dsa: qca8k: use dsa_for_each macro instead of for loop
Date:   Sat, 29 Jul 2023 13:55:09 +0200
Message-Id: <20230729115509.32601-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230729115509.32601-1-ansuelsmth@gmail.com>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert for loop to dsa_for_each macro to save some redundant write on
unconnected/unused port and tidy things up.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 109 ++++++++++++++++---------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 81c6fab0a01b..1434f145aa9c 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1800,7 +1800,8 @@ static int
 qca8k_setup(struct dsa_switch *ds)
 {
 	struct qca8k_priv *priv = ds->priv;
-	int cpu_port, ret, i;
+	int cpu_port, ret, port;
+	struct dsa_port *dp;
 	u32 mask;
 
 	cpu_port = qca8k_find_cpu_port(ds);
@@ -1855,27 +1856,31 @@ qca8k_setup(struct dsa_switch *ds)
 		dev_warn(priv->dev, "mib init failed");
 
 	/* Initial setup of all ports */
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+	dsa_switch_for_each_port(dp, ds) {
+		port = dp->index;
+
 		/* Disable forwarding by default on all ports */
-		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 				QCA8K_PORT_LOOKUP_MEMBER, 0);
 		if (ret)
 			return ret;
 
-		/* Enable QCA header mode on all cpu ports */
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(i),
-					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
-					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
-			if (ret) {
-				dev_err(priv->dev, "failed enabling QCA header mode");
-				return ret;
-			}
-		}
-
 		/* Disable MAC by default on all user ports */
 		if (dsa_is_user_port(ds, i))
-			qca8k_port_set_status(priv, i, 0);
+			qca8k_port_set_status(priv, port, 0);
+	}
+
+	/* Enable QCA header mode on all cpu ports */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		port = dp->index;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(port),
+				  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
+				  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
+		if (ret) {
+			dev_err(priv->dev, "failed enabling QCA header mode on port %d", port);
+			return ret;
+		}
 	}
 
 	/* Forward all unknown frames to CPU port for Linux processing
@@ -1897,48 +1902,48 @@ qca8k_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Setup connection between CPU port & user ports
-	 * Configure specific switch configuration for ports
+	 * Individual user ports get connected to CPU port only
 	 */
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		/* Individual user ports get connected to CPU port only */
-		if (dsa_is_user_port(ds, i)) {
-			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-					QCA8K_PORT_LOOKUP_MEMBER,
-					BIT(cpu_port));
-			if (ret)
-				return ret;
-
-			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-						QCA8K_PORT_LOOKUP_LEARN);
-			if (ret)
-				return ret;
-
-			/* For port based vlans to work we need to set the
-			 * default egress vid
-			 */
-			ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(i),
-					QCA8K_EGREES_VLAN_PORT_MASK(i),
-					QCA8K_EGREES_VLAN_PORT(i, QCA8K_PORT_VID_DEF));
-			if (ret)
-				return ret;
-
-			ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(i),
-					  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
-					  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
-			if (ret)
-				return ret;
-		}
+	dsa_switch_for_each_user_port(dp, ds) {
+		port = dp->index;
 
-		/* The port 5 of the qca8337 have some problem in flood condition. The
-		 * original legacy driver had some specific buffer and priority settings
-		 * for the different port suggested by the QCA switch team. Add this
-		 * missing settings to improve switch stability under load condition.
-		 * This problem is limited to qca8337 and other qca8k switch are not affected.
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
+				QCA8K_PORT_LOOKUP_MEMBER,
+				BIT(cpu_port));
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port),
+					QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
+
+		/* For port based vlans to work we need to set the
+		 * default egress vid
 		 */
-		if (priv->switch_id == QCA8K_ID_QCA8337)
-			qca8k_setup_hol_fixup(priv, i);
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port),
+				QCA8K_EGREES_VLAN_PORT_MASK(port),
+				QCA8K_EGREES_VLAN_PORT(port, QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port),
+				  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
+				  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
 	}
 
+	/* The port 5 of the qca8337 have some problem in flood condition. The
+	 * original legacy driver had some specific buffer and priority settings
+	 * for the different port suggested by the QCA switch team. Add this
+	 * missing settings to improve switch stability under load condition.
+	 * This problem is limited to qca8337 and other qca8k switch are not affected.
+	 */
+	if (priv->switch_id == QCA8K_ID_QCA8337)
+		dsa_switch_for_each_available_port(dp, ds)
+			qca8k_setup_hol_fixup(priv, dp->index);
+
 	/* Special GLOBAL_FC_THRESH value are needed for ar8327 switch */
 	if (priv->switch_id == QCA8K_ID_QCA8327) {
 		mask = QCA8K_GLOBAL_FC_GOL_XON_THRES(288) |
-- 
2.40.1

