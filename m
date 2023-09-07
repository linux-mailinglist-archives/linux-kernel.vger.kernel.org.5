Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7479743B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjIGPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbjIGPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:56 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEAF1BFA;
        Thu,  7 Sep 2023 08:32:38 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 32F5BD669E;
        Thu,  7 Sep 2023 09:24:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 495504002E;
        Thu,  7 Sep 2023 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694078658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwg8Q82/Dfui3G+s3HaJDAFCq+dngbenMf800j20jak=;
        b=mFjP3Joj5HVzyaKR4ON3GSwzwwcm2MKoKTz5SmtY/0bReNzaAF0leBWBkAJC3vtqka7n2F
        3rzUMtqMO4byuxu6yeBooQSordPKIbn2YvLiHorvIBoeM5787lbty+LpaztbKdDaNvRQO9
        rIA2kfEoYXwyNJdP/JX7Hc8LIIF4WkQJc8iW6sh/H9/UXR/eLSN8fWkTjYArJ+BtArd5fg
        0hbJ9sgFvsBa1mwbAltErYpttALhi6i72O9QAVMs8Z7QwhFBPQHdeZCB85G/M+2fHb9QPN
        URa9LNsMYv/AO9Dbdeyzc7EWe4sg9JgyFtyVKAFbZt3mbRe7n92FlcJ+R+Voaw==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to list PHYs
Date:   Thu,  7 Sep 2023 11:24:02 +0200
Message-ID: <20230907092407.647139-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new netlink message that lists all PHYs on a given interface
at a given time.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/uapi/linux/ethtool_netlink.h | 13 ++++
 net/ethtool/Makefile                 |  2 +-
 net/ethtool/netlink.c                | 10 +++
 net/ethtool/netlink.h                |  2 +
 net/ethtool/phy_list.c               | 99 ++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/phy_list.c

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..b2a0d21fdd8e 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_PHY_LIST_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_PHY_LIST_GET_REPLY,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -975,6 +977,17 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PHY_LIST_UNSPEC,
+	ETHTOOL_A_PHY_LIST_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHY_LIST_COUNT,			/* u8 */
+	ETHTOOL_A_PHY_LIST_INDEX,			/* array, u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHY_LIST_CNT,
+	ETHTOOL_A_PHY_LIST_MAX = (__ETHTOOL_A_PHY_LIST_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 504f954a1b28..a182c0dbbb9d 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o pse-pd.o plca.o mm.o
+		   module.o pse-pd.o plca.o mm.o phy_list.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..60b66b78055e 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -306,6 +306,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_PHY_LIST_GET]	= &ethnl_phy_list_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1128,6 +1129,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_LIST_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_phy_list_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_list_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..76859d8fbce0 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -395,6 +395,7 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_list_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -441,6 +442,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_phy_list_get_policy[ETHTOOL_A_PHY_LIST_HEADER + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/phy_list.c b/net/ethtool/phy_list.c
new file mode 100644
index 000000000000..689d08637391
--- /dev/null
+++ b/net/ethtool/phy_list.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Bootlin
+ *
+ * Ethtool netlink operations for Ethernet PHY specific operations
+ */
+#include "common.h"
+#include "netlink.h"
+
+#include <linux/phy.h>
+#include <linux/phy_ns.h>
+
+struct phy_list_req_info {
+	struct ethnl_req_info		base;
+};
+
+#define PHY_MAX_ENTRIES	16
+
+struct phy_list_reply_data {
+	struct ethnl_reply_data		base;
+	u8 n_phys;
+	u32 phy_indices[PHY_MAX_ENTRIES];
+};
+
+#define PHY_LIST_REPDATA(__reply_base) \
+	container_of(__reply_base, struct phy_list_reply_data, base)
+
+const struct nla_policy ethnl_phy_list_get_policy[ETHTOOL_A_PHY_LIST_HEADER + 1] = {
+	[ETHTOOL_A_PHY_LIST_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy_stats),
+};
+
+static int phy_list_prepare_data(const struct ethnl_req_info *req_base,
+				 struct ethnl_reply_data *reply_base,
+				 struct genl_info *info)
+{
+	struct phy_list_reply_data *data = PHY_LIST_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	struct phy_namespace *phy_ns = &dev->phy_ns;
+	struct phy_device *phydev;
+	int ret;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	data->n_phys = 0;
+
+	mutex_lock(&phy_ns->ns_lock);
+	list_for_each_entry(phydev, &phy_ns->phys, node)
+		data->phy_indices[data->n_phys++] = phydev->phyindex;
+	mutex_unlock(&phy_ns->ns_lock);
+
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int phy_list_reply_size(const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct phy_list_reply_data *data = PHY_LIST_REPDATA(reply_base);
+	int len = 0;
+
+	len += nla_total_size(sizeof(u8)); /* _PHY_LIST_COUNT */
+	len += nla_total_size(data->n_phys * sizeof(u32)); /* Array of _PHY_LIST_INDEX */
+
+	return len;
+}
+
+static int phy_list_fill_reply(struct sk_buff *skb,
+			       const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct phy_list_reply_data *data = PHY_LIST_REPDATA(reply_base);
+
+	if (nla_put_u8(skb, ETHTOOL_A_PHY_LIST_COUNT, data->n_phys))
+		return -EMSGSIZE;
+
+	if (!data->n_phys)
+		return 0;
+
+	if (nla_put(skb, ETHTOOL_A_PHY_LIST_INDEX, sizeof(u32) * data->n_phys,
+		    data->phy_indices))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+const struct ethnl_request_ops ethnl_phy_list_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_PHY_LIST_GET,
+	.reply_cmd		= ETHTOOL_MSG_PHY_LIST_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_PHY_LIST_HEADER,
+	.req_info_size		= sizeof(struct phy_list_req_info),
+	.reply_data_size	= sizeof(struct phy_list_reply_data),
+
+	.prepare_data		= phy_list_prepare_data,
+	.reply_size		= phy_list_reply_size,
+	.fill_reply		= phy_list_fill_reply,
+};
-- 
2.41.0

