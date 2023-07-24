Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB275F406
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGXK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjGXK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:59:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79716FF;
        Mon, 24 Jul 2023 03:59:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso32764745e9.3;
        Mon, 24 Jul 2023 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196371; x=1690801171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oqH5/rE8ocNa3lVYSAWAjwDwYzH5wzVOgSmdaIdUr8=;
        b=Pi2ryTIPkS3v4zSBsFRnhvFrDEuLSFJ+6B6UJijM8XW9sUirMJ8blmDnAWzcvB5WWQ
         SfSTmD9SUqWjFECjv+j8N/C5vnA/oz+gW8dXcdvPoLFg9oFPuHtyLqAUOUAlUnWRInQi
         XmEkm+/qz6LVItRrWNSGQ9GdjqDcGnlxOB64E+hqIHW02WULuPJTIBgxEpCT0xRpOfFT
         BAKF7XD+KcAr+WtnbhQCfWcXHojvxBilxCaUl9Out9mJGrwXhZM0Yz1SL2N1CJ+uUS1m
         0MwZrFc7uqcz8DHQ9ZDgX3e5nhmfVP0i+PQKXBNM5Pfwoy1vuR/wYnGK5mtXudMKp2ey
         dfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196371; x=1690801171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oqH5/rE8ocNa3lVYSAWAjwDwYzH5wzVOgSmdaIdUr8=;
        b=XCEDR8y8y9F6dJEpf6aWKg42a6iB6W/xLk9d17G+Vqe/oNKLIeo6PbgFqb2rukZ9iH
         4NmNwAv879FjeRbr7gTu01viDsxV8ui232vcciMazprB8rjuqyq/XxyFrENBlXCCY5r9
         zfz7eSZeEC7GxOMjHSD2m9CNlCj51JAt3rG/uWklq2SHG+w5JFEsAe+d4ucfQlhq1sr1
         ZxrfHmYIvpalWfVXgB/MzvJZnZ0wzUS9hRAwTrgIwSHMpLA9xEkl9CIWbEQkG88bGnVw
         tq+l02rm/yfm7dPNC2+gcddffFIjQJ6yCJRZVHIjAnpTUPEuq2vV1+/J7Qz1h0ns02Iw
         N1jQ==
X-Gm-Message-State: ABy/qLYtmNvVZ58LMc+evXZ4SaP3Ptfoj9Vws9YQFaAYqypKyg8kELts
        pjz676AjCG7ZUPldYRJxb3Q=
X-Google-Smtp-Source: APBJJlHmc9FIcgTYT5rbzJdifFNu9mvDNw+oM6GiUFZ8Po1xFQTtqDvx5SKTl9oBrV9TRdexUtEk+g==
X-Received: by 2002:a1c:f713:0:b0:3fb:a6ee:4cec with SMTP id v19-20020a1cf713000000b003fba6ee4cecmr6050943wmh.33.1690196370722;
        Mon, 24 Jul 2023 03:59:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm10055353wmi.13.2023.07.24.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:59:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable and keep off if standalone
Date:   Mon, 24 Jul 2023 05:30:57 +0200
Message-Id: <20230724033058.16795-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724033058.16795-1-ansuelsmth@gmail.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address learning should initially be turned off by the driver for port
operation in standalone mode, then the DSA core handles changes to it
via ds->ops->port_bridge_flags().

Currently this is not the case for qca8k where learning is enabled
unconditionally in qca8k_setup for every user port.

Handle ports configured in standalone mode by making the learning
configurable and not enabling it by default.

Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
enable learning for bridge that request it and tweak
.port_stp_state_set to correctly disable learning when port is
configured in standalone mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  7 +++--
 drivers/net/dsa/qca/qca8k-common.c | 44 ++++++++++++++++++++++++++++++
 drivers/net/dsa/qca/qca8k.h        |  6 ++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ae088a4df794..31552853fdd4 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1870,9 +1870,8 @@ qca8k_setup(struct dsa_switch *ds)
 			if (ret)
 				return ret;
 
-			/* Enable ARP Auto-learning by default */
-			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-					      QCA8K_PORT_LOOKUP_LEARN);
+			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
+						QCA8K_PORT_LOOKUP_LEARN);
 			if (ret)
 				return ret;
 
@@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_change_mtu	= qca8k_port_change_mtu,
 	.port_max_mtu		= qca8k_port_max_mtu,
 	.port_stp_state_set	= qca8k_port_stp_state_set,
+	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
+	.port_bridge_flags	= qca8k_port_bridge_flags,
 	.port_bridge_join	= qca8k_port_bridge_join,
 	.port_bridge_leave	= qca8k_port_bridge_leave,
 	.port_fast_age		= qca8k_port_fast_age,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13b8452ce5b2..e53694d2852a 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -565,9 +565,26 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
+					 bool learning)
+{
+	struct qca8k_priv *priv = ds->priv;
+
+	if (learning)
+		return regmap_set_bits(priv->regmap,
+				       QCA8K_PORT_LOOKUP_CTRL(port),
+				       QCA8K_PORT_LOOKUP_LEARN);
+	else
+		return regmap_clear_bits(priv->regmap,
+					 QCA8K_PORT_LOOKUP_CTRL(port),
+					 QCA8K_PORT_LOOKUP_LEARN);
+}
+
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct qca8k_priv *priv = ds->priv;
+	bool learning = false;
 	u32 stp_state;
 
 	switch (state) {
@@ -582,8 +599,11 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		break;
 	case BR_STATE_LEARNING:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
+		learning = dp->learning;
 		break;
 	case BR_STATE_FORWARDING:
+		learning = dp->learning;
+		fallthrough;
 	default:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
 		break;
@@ -591,6 +611,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	qca8k_port_configure_learning(ds, port, learning);
+}
+
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = qca8k_port_configure_learning(ds, port,
+					    flags.val & BR_LEARNING);
+
+	return ret;
 }
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index c5cc8a172d65..8f88b7db384d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack);
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack);
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
 			   bool *tx_fwd_offload,
-- 
2.40.1

