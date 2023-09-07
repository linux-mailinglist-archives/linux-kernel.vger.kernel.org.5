Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E47973E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjIGPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbjIGPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:00 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017031739;
        Thu,  7 Sep 2023 08:29:29 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C4FA1D67AE;
        Thu,  7 Sep 2023 09:24:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C392A40030;
        Thu,  7 Sep 2023 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694078662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaBZk7bZ3a0MTep+V5x+r8Tk/H8dUevKifh4/mfa3xg=;
        b=XNr0/jJpEiPbjfwSDKbDIAKNH5cSr8wsxFW5LNAogGeGXF1orubjCDYBKEKmcJjjVB3O5X
        sI02HI5EQ0NSMqNWHCV3DGg2ks6ittd37BRDy3Aa78jXSKWy5QavoRZ+c08Oru2PouPPlO
        ZPtVRjaxXre0x8B9uuPq04FCpP1snp9lFo1vwDvqL9kdk154WEM3LvoIufHfjZV/PxbeNm
        P81F3c681kx8Exxi+HyjBeLDs39qiLjnQp+wNXiX8fnBjuymBD4m7rVuAsvRt4fSKlFW+b
        tOrqqE/ZksTCSBH062DcVGJ93/iA83W9vsnJ3PBfnxkAVt3BnbjjpP4qGPi05g==
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
Subject: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to get PHY information
Date:   Thu,  7 Sep 2023 11:24:04 +0200
Message-ID: <20230907092407.647139-7-maxime.chevallier@bootlin.com>
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

Now that we can list PHYs belonging to a netdevice, add a command to get
PHY-specific information, that we can extend as needed to get more data
such as link info, offloading support, etc.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/uapi/linux/ethtool.h         |   7 ++
 include/uapi/linux/ethtool_netlink.h |  14 +++
 net/ethtool/Makefile                 |   2 +-
 net/ethtool/netlink.c                |  10 +++
 net/ethtool/netlink.h                |   2 +
 net/ethtool/phy.c                    | 124 +++++++++++++++++++++++++++
 6 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/phy.c

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..d74f839ad32c 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2205,4 +2205,11 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+enum phy_upstream_type {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_SFP,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_H */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b2a0d21fdd8e..ec96e816d564 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -58,6 +58,7 @@ enum {
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_PHY_LIST_GET,
+	ETHTOOL_MSG_PHY_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -111,6 +112,7 @@ enum {
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
 	ETHTOOL_MSG_PHY_LIST_GET_REPLY,
+	ETHTOOL_MSG_PHY_GET_REPLY,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -988,6 +990,18 @@ enum {
 	ETHTOOL_A_PHY_LIST_MAX = (__ETHTOOL_A_PHY_LIST_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PHY_UNSPEC,
+	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_PHY_INDEX,			/* u32 */
+	ETHTOOL_A_PHY_DRVNAME,			/* string */
+	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u8 */
+	ETHTOOL_A_PHY_ID,			/* u32 */
+
+	__ETHTOOL_A_PHY_CNT,
+	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index a182c0dbbb9d..e6ef280431d6 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o pse-pd.o plca.o mm.o phy_list.o
+		   module.o pse-pd.o plca.o mm.o phy_list.o phy.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 60b66b78055e..88a60fbb8806 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -307,6 +307,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_PHY_LIST_GET]	= &ethnl_phy_list_request_ops,
+	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1138,6 +1139,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_phy_list_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_phy_list_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_phy_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 76859d8fbce0..15f75fd211fc 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -396,6 +396,7 @@ extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_list_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -443,6 +444,7 @@ extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADE
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
 extern const struct nla_policy ethnl_phy_list_get_policy[ETHTOOL_A_PHY_LIST_HEADER + 1];
+extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_INDEX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
new file mode 100644
index 000000000000..0f646bec946b
--- /dev/null
+++ b/net/ethtool/phy.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Bootlin
+ *
+ */
+#include "common.h"
+#include "netlink.h"
+
+#include <linux/phy.h>
+#include <linux/phy_ns.h>
+
+struct phy_req_info {
+	struct ethnl_req_info		base;
+	u32				phyindex;
+};
+
+struct phy_reply_data {
+	struct ethnl_reply_data		base;
+	u32				phyindex;
+	const char			*drvname;
+	enum phy_upstream_type		upstream;
+	u32				id;
+};
+
+#define PHY_REQINFO(__req_base) \
+	container_of(__req_base, struct phy_req_info, base)
+#define PHY_REPDATA(__reply_base) \
+	container_of(__reply_base, struct phy_reply_data, base)
+
+const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_INDEX + 1] = {
+	[ETHTOOL_A_PHY_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PHY_INDEX] = NLA_POLICY_MAX(NLA_U32, 255),
+};
+
+static int phy_parse_request(struct ethnl_req_info *req_base,
+			     struct nlattr **tb,
+			     struct netlink_ext_ack *extack)
+{
+	struct phy_req_info *req_info = PHY_REQINFO(req_base);
+
+	if (!tb[ETHTOOL_A_PHY_INDEX])
+		return -EINVAL;
+
+	req_info->phyindex = nla_get_u32(tb[ETHTOOL_A_PHY_INDEX]);
+
+	return 0;
+}
+
+static int phy_prepare_data(const struct ethnl_req_info *req_base,
+			    struct ethnl_reply_data *reply_base,
+			    struct genl_info *info)
+{
+	struct phy_req_info *req_info = PHY_REQINFO(req_base);
+	struct phy_reply_data *data = PHY_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	struct phy_namespace *phy_ns = &dev->phy_ns;
+	struct phy_device *phydev;
+	int ret;
+
+	phydev = phy_ns_get_by_index(phy_ns, req_info->phyindex);
+	if (!phydev)
+		return -ENODEV;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	data->phyindex = req_info->phyindex;
+	data->drvname = phydev->drv->name;
+	if (phydev->is_on_sfp_module)
+		data->upstream = PHY_UPSTREAM_SFP;
+	else if (phydev->attached_dev)
+		data->upstream = PHY_UPSTREAM_MAC;
+	else
+		data->upstream = PHY_UPSTREAM_PHY;
+
+	data->id = phydev->phy_id;
+
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int phy_reply_size(const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct phy_reply_data *data = PHY_REPDATA(reply_base);
+	int len = 0;
+
+	len += nla_total_size(sizeof(u32));	/* ETHTOOL_A_PHY_INDEX */
+	len += ethnl_strz_size(data->drvname);	/* ETHTOOL_A_DRVNAME */
+	len += nla_total_size(sizeof(u8));	/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
+	len += nla_total_size(sizeof(u32));	/* ETHTOOL_A_PHY_ID */
+
+	return len;
+}
+
+static int phy_fill_reply(struct sk_buff *skb,
+			  const struct ethnl_req_info *req_base,
+			  const struct ethnl_reply_data *reply_base)
+{
+	const struct phy_reply_data *data = PHY_REPDATA(reply_base);
+
+	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, data->phyindex) ||
+	    ethnl_put_strz(skb, ETHTOOL_A_PHY_DRVNAME, data->drvname) ||
+	    nla_put_u8(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, data->upstream) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_ID, data->id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+const struct ethnl_request_ops ethnl_phy_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_PHY_GET,
+	.reply_cmd		= ETHTOOL_MSG_PHY_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_PHY_HEADER,
+	.req_info_size		= sizeof(struct phy_req_info),
+	.reply_data_size	= sizeof(struct phy_reply_data),
+
+	.parse_request		= phy_parse_request,
+	.prepare_data		= phy_prepare_data,
+	.reply_size		= phy_reply_size,
+	.fill_reply		= phy_fill_reply,
+};
-- 
2.41.0

