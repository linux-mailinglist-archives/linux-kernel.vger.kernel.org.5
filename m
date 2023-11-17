Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D737EF590
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbjKQPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:28 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2642127;
        Fri, 17 Nov 2023 07:40:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 640381BF205;
        Fri, 17 Nov 2023 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BskneXKv4A8RQQX8Nlti47/gT0IX7yLKeJby+i812FU=;
        b=T5d8s7aShmgUfZH0jFvC2wMfI8IUjRrvEAN3w3H4j3r2GcDjFwEXy1PgfPpVXml9P1IHth
        Ey01a8r1xQTCHE9K3kAos6TzVimgSGdnklq1RMpaKgUkrSj185EPT57C8T/7a2h1wR0/SI
        jpZB9PMmvGUOh/1Afta8tgF5yg7Sc3OYFLQuhFO/D5UIGu4zoFQC74E88WIn4IbVmpZ5pO
        apriJIATGXq5DxaTexIWb9ibZ3j9W3H9g8DkmVMO8gJVN7eZVtfnGWNOQQPChWOOoD/YWv
        MxsfVBOBXDdLGMUty74azdqLEUU1iS3IJOa+t+hEwW9soz97ht6wu1F1IG+M4w==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 05/10] net: ethtool: Allow passing a phy index for some commands
Date:   Fri, 17 Nov 2023 17:23:16 +0100
Message-ID: <20231117162323.626979-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some netlink commands are target towards ethernet PHYs, to control some
of their features. As there's several such commands, add the ability to
pass a PHY index in the ethnl request, which will populate the generic
ethnl_req_info with the relevant phydev when the command targets a PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/uapi/linux/ethtool_netlink.h |  1 +
 net/ethtool/netlink.c                | 22 ++++++++++++++++++++++
 net/ethtool/netlink.h                |  8 ++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..e557cf35250e 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -133,6 +133,7 @@ enum {
 	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
 	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
 	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
+	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_HEADER_CNT,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..e83ee844b60f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/pm_runtime.h>
 #include "netlink.h"
+#include <linux/link_topology.h>
 
 static struct genl_family ethtool_genl_family;
 
@@ -20,6 +21,7 @@ const struct nla_policy ethnl_header_policy[] = {
 					    .len = ALTIFNAMSIZ - 1 },
 	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
 							  ETHTOOL_FLAGS_BASIC),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
 };
 
 const struct nla_policy ethnl_header_policy_stats[] = {
@@ -28,6 +30,7 @@ const struct nla_policy ethnl_header_policy_stats[] = {
 					    .len = ALTIFNAMSIZ - 1 },
 	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
 							  ETHTOOL_FLAGS_STATS),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
 };
 
 int ethnl_ops_begin(struct net_device *dev)
@@ -91,6 +94,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 {
 	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy)];
 	const struct nlattr *devname_attr;
+	struct phy_device *phydev = NULL;
 	struct net_device *dev = NULL;
 	u32 flags = 0;
 	int ret;
@@ -145,6 +149,24 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 		return -EINVAL;
 	}
 
+	if (dev) {
+		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
+			u32 phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
+
+			phydev = link_topo_get_phy(&dev->link_topo, phy_index);
+			if (!phydev) {
+				NL_SET_ERR_MSG_ATTR(extack, header, "no phy matches phy index");
+				return -EINVAL;
+			}
+		} else {
+			/* If we need a PHY but no phy index is specified, fallback
+			 * to dev->phydev
+			 */
+			phydev = dev->phydev;
+		}
+	}
+
+	req_info->phydev = phydev;
 	req_info->dev = dev;
 	req_info->flags = flags;
 	return 0;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..3f5eb60bdf0b 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -250,6 +250,7 @@ static inline unsigned int ethnl_reply_header_size(void)
  * @dev:   network device the request is for (may be null)
  * @dev_tracker: refcount tracker for @dev reference
  * @flags: request flags common for all request types
+ * @phydev: phy_device connected to @dev this request is for (may be null)
  *
  * This is a common base for request specific structures holding data from
  * parsed userspace request. These always embed struct ethnl_req_info at
@@ -259,6 +260,7 @@ struct ethnl_req_info {
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
 	u32			flags;
+	struct phy_device	*phydev;
 };
 
 static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
@@ -395,9 +397,10 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_request_ops;
 
-extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
-extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
+extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_PHY_INDEX + 1];
+extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_PHY_INDEX + 1];
 extern const struct nla_policy ethnl_strset_get_policy[ETHTOOL_A_STRSET_COUNTS_ONLY + 1];
 extern const struct nla_policy ethnl_linkinfo_get_policy[ETHTOOL_A_LINKINFO_HEADER + 1];
 extern const struct nla_policy ethnl_linkinfo_set_policy[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL + 1];
@@ -441,6 +444,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
-- 
2.41.0

