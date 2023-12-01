Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9680110C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378716AbjLAQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjLAQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:37:26 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD6D67;
        Fri,  1 Dec 2023 08:37:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA40DC0002;
        Fri,  1 Dec 2023 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701448637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnWFoctM5dCxNvjtj1tJfSyq/yYsvd8LiNxVjJtV4vs=;
        b=J3nU3bNV/U2kNgKoQVPDOWfAyiUyvqq4iDU2uz0Bpn4VGKvdYp6Qwy716VIlYrn00ISkET
        RYKDieuOekMZ99yTIBXr6gz2YY2ckiGXGkqklqC8VGAtZyVs57yQrJdoUVah5N/9FL8b0Z
        nPGgv8XPyglMhQ0bMNL2o/ZBFnQz7ZdtPienj5paD5sZnPPE1ng+Ars/LERcHuE0pLZPNp
        u7u9pDJMrvD5bgqvhBcDU56xE4659zQSJaWdk8gagpgLwMSV0mOJ9pOJRczDSvhTllUgYK
        W9QkCCX06tG1b9DgKSqKtaKNm6z9IKaGPJRDzQp+HSD84SqYtXRutGGwtC3XLA==
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [RFC PATCH net-next v3 07/13] net: ethtool: Introduce a command to list PHYs on an interface
Date:   Fri,  1 Dec 2023 17:36:57 +0100
Message-ID: <20231201163704.1306431-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have the ability to track the PHYs connected to a net_device
through the link_topology, we can expose this list to userspace. This
allows userspace to use these identifiers for phy-specific commands and
take the decision of which PHY to target by knowing the link topology.

Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
devices on only one interface.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: - Fixed the documentation
    - Fixed the DUMP implementation
V2: New patch

 Documentation/networking/ethtool-netlink.rst |  44 +++
 include/uapi/linux/ethtool_netlink.h         |  29 ++
 net/ethtool/Makefile                         |   2 +-
 net/ethtool/netlink.c                        |   9 +
 net/ethtool/netlink.h                        |   5 +
 net/ethtool/phy.c                            | 292 +++++++++++++++++++
 6 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/phy.c

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 8f6390a85895..d9b8cc256e71 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2001,6 +2001,49 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+PHY_GET
+=======
+
+Retrieve information about a given Ethernet PHY sitting on the link. As there
+can be more than one PHY, the DUMP operation can be used to list the PHYs
+present on a given interface, by passing an interface index or name in
+the dump request
+
+Request contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_PHY_HEADER``              nested  request header
+  ====================================  ======  ==========================
+
+Kernel response contents:
+
+  ===================================== ======  ==========================
+  ``ETHTOOL_A_PHY_HEADER``              nested  request header
+  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, that can
+                                                be used for phy-specific requests
+  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
+  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
+  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this phy is
+                                                connected to
+  ``ETHTOOL_A_PHY_UPSTREAM_PHY``        nested  if the phy is connected to another
+                                                phy, this nest contains info on
+                                                that connection
+  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
+                                                the name of the sfp bus
+  ``ETHTOOL_A_PHY_ID``                  u32     the phy id if the phy is C22
+  ===================================== ======  ==========================
+
+When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's parent is
+another PHY. Information on the parent PHY will be set in the
+``ETHTOOL_A_PHY_UPSTREAM_PHY`` nest, which has the following structure :
+
+  =================================== ======  ==========================
+  ``ETHTOOL_A_PHY_UPSTREAM_INDEX``    u32     the PHY index of the upstream PHY
+  ``ETHTOOL_A_PHY_UPSTREAM_SFP_NAME`` string  if this PHY is connected to it's
+                                                parent PHY through an SFP bus, the
+                                                name of this sfp bus
+  =================================== ======  ==========================
+
 Request translation
 ===================
 
@@ -2107,4 +2150,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_PHY_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index e557cf35250e..7d621963698a 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_PHY_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,8 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_PHY_GET_REPLY,
+	ETHTOOL_MSG_PHY_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -976,6 +979,32 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PHY_UPSTREAM_UNSPEC,
+	ETHTOOL_A_PHY_UPSTREAM_INDEX,			/* u32 */
+	ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,		/* string */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHY_UPSTREAM_CNT,
+	ETHTOOL_A_PHY_UPSTREAM_MAX = (__ETHTOOL_A_PHY_UPSTREAM_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_PHY_UNSPEC,
+	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHY_INDEX,			/* u32 */
+	ETHTOOL_A_PHY_DRVNAME,			/* string */
+	ETHTOOL_A_PHY_NAME,			/* string */
+	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u8 */
+	ETHTOOL_A_PHY_UPSTREAM,			/* nest - _A_PHY_UPSTREAM_* */
+	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
+	ETHTOOL_A_PHY_ID,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_PHY_CNT,
+	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 504f954a1b28..0ccd0e9afd3f 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o pse-pd.o plca.o mm.o
+		   module.o pse-pd.o plca.o mm.o phy.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b8faab3a92e8..ebc481f2cf39 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1152,6 +1152,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_GET,
+		.doit	= ethnl_phy_doit,
+		.start	= ethnl_phy_start,
+		.dumpit	= ethnl_phy_dumpit,
+		.done	= ethnl_phy_done,
+		.policy = ethnl_phy_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index def84e2def9e..5e6a43e35a09 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -444,6 +444,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -451,6 +452,10 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_phy_start(struct netlink_callback *cb);
+int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info);
+int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_phy_done(struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
new file mode 100644
index 000000000000..e25ac405e46c
--- /dev/null
+++ b/net/ethtool/phy.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Bootlin
+ *
+ */
+#include "common.h"
+#include "netlink.h"
+
+#include <linux/phy.h>
+#include <linux/phy_link_topology.h>
+#include <linux/sfp.h>
+
+struct phy_req_info {
+	struct ethnl_req_info		base;
+	struct phy_device_node		pdn;
+};
+
+#define PHY_REQINFO(__req_base) \
+	container_of(__req_base, struct phy_req_info, base)
+
+const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1] = {
+	[ETHTOOL_A_PHY_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+/* Caller holds rtnl */
+static ssize_t
+ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
+		     struct netlink_ext_ack *extack)
+{
+	struct phy_link_topology *topo;
+	struct phy_device_node *pdn;
+	struct phy_device *phydev;
+	unsigned long index;
+	size_t size;
+
+	ASSERT_RTNL();
+
+	topo = &req_base->dev->link_topo;
+
+	size = nla_total_size(0);
+
+	xa_for_each(&topo->phys, index, pdn) {
+		phydev = pdn->phy;
+
+		/* ETHTOOL_A_PHY_INDEX */
+		size += nla_total_size(sizeof(u32));
+
+		/* ETHTOOL_A_DRVNAME */
+		size += nla_total_size(strlen(phydev->drv->name));
+
+		/* ETHTOOL_A_NAME */
+		size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)));
+
+		/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
+		size += nla_total_size(sizeof(u8));
+
+		/* ETHTOOL_A_PHY_ID */
+		size += nla_total_size(sizeof(u32));
+
+		if (phy_on_sfp(phydev)) {
+			/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
+			if (sfp_get_name(pdn->parent_sfp_bus))
+				size += nla_total_size(strlen(sfp_get_name(pdn->parent_sfp_bus)));
+
+			/* ETHTOOL_A_PHY_UPSTREAM_INDEX */
+			size += nla_total_size(sizeof(u32));
+		}
+
+		/* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
+		if (phydev->sfp_bus)
+			size += nla_total_size(strlen(sfp_get_name(phydev->sfp_bus)));
+	}
+
+	return size;
+}
+
+static int
+ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
+{
+	struct phy_req_info *req_info = PHY_REQINFO(req_base);
+	struct phy_device_node *pdn = &req_info->pdn;
+	struct phy_device *phydev = pdn->phy;
+	enum phy_upstream ptype;
+	struct nlattr *nest;
+
+	ptype = pdn->upstream_type;
+
+	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
+	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name) ||
+	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdio.dev)) ||
+	    nla_put_u8(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_ID, phydev->phy_id))
+		return -EMSGSIZE;
+
+	if (ptype == PHY_UPSTREAM_PHY) {
+		struct phy_device *upstream = pdn->upstream.phydev;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_PHY_UPSTREAM);
+		if (!nest)
+			return -EMSGSIZE;
+
+		/* Parent index */
+		if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstream->phyindex))
+			return -EMSGSIZE;
+
+		if (pdn->parent_sfp_bus && sfp_get_name(pdn->parent_sfp_bus) &&
+		    nla_put_string(skb, ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
+				   sfp_get_name(pdn->parent_sfp_bus)))
+			return -EMSGSIZE;
+
+		nla_nest_end(skb, nest);
+	}
+
+	if (phydev->sfp_bus &&
+	    nla_put_string(skb, ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,
+			   sfp_get_name(phydev->sfp_bus)))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
+				   struct nlattr **tb)
+{
+	struct phy_req_info *req_info = PHY_REQINFO(req_base);
+	struct phy_link_topology *topo = &req_base->dev->link_topo;
+	struct phy_device_node *pdn;
+
+	if (!req_base->phydev)
+		return 0;
+
+	pdn = xa_load(&topo->phys, req_base->phydev->phyindex);
+	memcpy(&req_info->pdn, pdn, sizeof(*pdn));
+
+	return 0;
+}
+
+int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct phy_req_info req_info = {};
+	struct nlattr **tb = info->attrs;
+	struct sk_buff *rskb;
+	void *reply_payload;
+	int reply_len;
+	int ret;
+
+	ret = ethnl_parse_header_dev_get(&req_info.base,
+					 tb[ETHTOOL_A_PHY_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		return ret;
+
+	rtnl_lock();
+
+	ret = ethnl_phy_parse_request(&req_info.base, tb);
+	if (ret < 0)
+		goto err_unlock_rtnl;
+
+	/* No PHY, return early */
+	if (!req_info.pdn.phy)
+		goto err_unlock_rtnl;
+
+	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
+	if (ret < 0)
+		goto err_unlock_rtnl;
+	reply_len = ret + ethnl_reply_header_size();
+
+	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
+				ETHTOOL_MSG_PHY_GET_REPLY,
+				ETHTOOL_A_PHY_HEADER,
+				info, &reply_payload);
+	if (!rskb) {
+		ret = -ENOMEM;
+		goto err_unlock_rtnl;
+	}
+
+	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
+	if (ret)
+		goto err_free_msg;
+
+	rtnl_unlock();
+	ethnl_parse_header_dev_put(&req_info.base);
+	genlmsg_end(rskb, reply_payload);
+
+	return genlmsg_reply(rskb, info);
+
+err_free_msg:
+	nlmsg_free(rskb);
+err_unlock_rtnl:
+	rtnl_unlock();
+	ethnl_parse_header_dev_put(&req_info.base);
+	return ret;
+}
+
+struct ethnl_phy_dump_ctx {
+	struct phy_req_info	*phy_req_info;
+};
+
+int ethnl_phy_start(struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
+	struct nlattr **tb = info->info.attrs;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
+	if (!ctx->phy_req_info)
+		return -ENOMEM;
+
+	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
+					 tb[ETHTOOL_A_PHY_HEADER],
+					 sock_net(cb->skb->sk), cb->extack,
+					 false);
+	return ret;
+}
+
+int ethnl_phy_done(struct netlink_callback *cb)
+{
+	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
+
+	kfree(ctx->phy_req_info);
+
+	return 0;
+}
+
+static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				  struct netlink_callback *cb)
+{
+	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
+	struct phy_req_info *pri = ctx->phy_req_info;
+	struct phy_device_node *pdn;
+	unsigned long index = 1;
+	void *ehdr;
+	int ret;
+
+	pri->base.dev = dev;
+
+	xa_for_each(&dev->link_topo.phys, index, pdn) {
+		ehdr = ethnl_dump_put(skb, cb,
+				      ETHTOOL_MSG_PHY_GET_REPLY);
+		if (!ehdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = ethnl_fill_reply_header(skb, dev,
+					      ETHTOOL_A_PHY_HEADER);
+		if (ret < 0) {
+			genlmsg_cancel(skb, ehdr);
+			break;
+		}
+
+		memcpy(&pri->pdn, pdn, sizeof(*pdn));
+		ret = ethnl_phy_fill_reply(&pri->base, skb);
+
+		genlmsg_end(skb, ehdr);
+	}
+
+	return ret;
+}
+
+int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
+	struct net *net = sock_net(skb->sk);
+	unsigned long ifindex = 1;
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+
+	if (ctx->phy_req_info->base.dev) {
+		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
+		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
+		ctx->phy_req_info->base.dev = NULL;
+	} else {
+		for_each_netdev_dump(net, dev, ifindex) {
+			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
+			if (ret)
+				break;
+		}
+	}
+	rtnl_unlock();
+
+	if (ret == -EMSGSIZE && skb->len)
+		return skb->len;
+	return ret;
+}
+
-- 
2.42.0

