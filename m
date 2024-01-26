Return-Path: <linux-kernel+bounces-40502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CC83E1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6441C283F15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66322339;
	Fri, 26 Jan 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wrg7OrP5"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291B22319;
	Fri, 26 Jan 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294346; cv=none; b=aHm6EXmvEFq4o6CBRhTLqeG6pEyfznJXEG8zkxe2xeH3NKuMaCrJzT3cdZK69pFr+dg0Gy+sx1M3CLkXp+bIQZkCGMP2CnTKralUKxC+GpNzE4c4QbE5F2Yt4cO2AHUFHU2KhwjSmyj0fyDrfqgE1XNBFpRWcRW1zPttoTVKswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294346; c=relaxed/simple;
	bh=5p9vF8j6IkiwEFmvpbCH9gRJ4Hk0F798s8Azu9ENd3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMNohRgsM+BDQaPoFzjd0VgQ8VS0UHjvVuPEksAiYOLj+YyCVlMcb0kY1tyTW1+C5V72OUEt46OowCxZbF+CcN+xfkSHzeDgOw5P0IB/ZMDRpIfkA3tKD8UeJHPEwD2d0Sn+1XzK/JwwFSJZCzgX1r+UvTPlFxj/wIv3cLW/hWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wrg7OrP5; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E7DCFF80A;
	Fri, 26 Jan 2024 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5oyLmUgZyZDZY1lwf/jpwZNyLYnSZlmdjnrNIcBWvA=;
	b=Wrg7OrP5QrfXr45HL/0PJHrY9XEWy3o7HM9g0jRL639ZxEuX40Cwg74LinkZ3/9KPjTGAD
	liD2ug7GRJfOouCRz4beVvUEd3c7Ab3CKgpjAlNjwLm4id9YyUBqElYmpsomml/F7W0iLP
	3i7/9WcZ9uvUK4ez+z6bgPaUIOeFCege0pjd49bxKVUhtImA7mfHY56JrRP9PFz/RfqTW5
	jXUb1feNP1ydIx6u1/PPeTRENi003bEosLYR5HOvhH0bpvnDfVcHAqGEa6SfefpJBmc0Dv
	U0Jql5KotYpRedqI1HfijG5+jz3yv4ZfrluSXXmKcKoO/i/t2wqFLGyzLeHL1Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
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
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 05/13] net: ethtool: Allow passing a phy index for some commands
Date: Fri, 26 Jan 2024 19:38:42 +0100
Message-ID: <20240126183851.2081418-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some netlink commands are target towards ethernet PHYs, to control some
of their features. As there's several such commands, add the ability to
pass a PHY index in the ethnl request, which will populate the generic
ethnl_req_info with the relevant phydev when the command targets a PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V6: - Added dedicated policies when passing a PHY index
    - Dropped Andrew's R-b as there were changes
V5: - Added Andrew's R-b
    - Fix a typo reported by Simon
V4: - No Changes
V3: - Fixed the documentation
V2: - New patch

 Documentation/networking/ethtool-netlink.rst |  7 ++++
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/netlink.c                        | 44 +++++++++++++++++++-
 net/ethtool/netlink.h                        |  5 +++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9abf2f8..3ca6c21e74af 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -57,6 +57,7 @@ Structure of this header is
   ``ETHTOOL_A_HEADER_DEV_INDEX``  u32     device ifindex
   ``ETHTOOL_A_HEADER_DEV_NAME``   string  device name
   ``ETHTOOL_A_HEADER_FLAGS``      u32     flags common for all requests
+  ``ETHTOOL_A_HEADER_PHY_INDEX``  u32     phy device index
   ==============================  ======  =============================
 
 ``ETHTOOL_A_HEADER_DEV_INDEX`` and ``ETHTOOL_A_HEADER_DEV_NAME`` identify the
@@ -81,6 +82,12 @@ the behaviour is backward compatible, i.e. requests from old clients not aware
 of the flag should be interpreted the way the client expects. A client must
 not set flags it does not understand.
 
+``ETHTOOL_A_HEADER_PHY_INDEX`` identify the ethernet PHY the message relates to.
+As there are numerous commands that are related to PHY configuration, and because
+we can have more than one PHY on the link, the PHY index can be passed in the
+request for the commands that needs it. It is however not mandatory, and if it
+is not passed for commands that target a PHY, the net_device.phydev pointer
+is used, as a fallback that keeps the legacy behaviour.
 
 Bit sets
 ========
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..422e8cfdd98c 100644
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
index fe3553f60bf3..5a9beb09e5d4 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/pm_runtime.h>
 #include "netlink.h"
+#include <linux/phy_link_topology.h>
 
 static struct genl_family ethtool_genl_family;
 
@@ -30,6 +31,24 @@ const struct nla_policy ethnl_header_policy_stats[] = {
 							  ETHTOOL_FLAGS_STATS),
 };
 
+const struct nla_policy ethnl_header_policy_phy[] = {
+	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
+	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ALTIFNAMSIZ - 1 },
+	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
+							  ETHTOOL_FLAGS_BASIC),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+const struct nla_policy ethnl_header_policy_phy_stats[] = {
+	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
+	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ALTIFNAMSIZ - 1 },
+	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
+							  ETHTOOL_FLAGS_STATS),
+	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -89,8 +108,9 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *header, struct net *net,
 			       struct netlink_ext_ack *extack, bool require_dev)
 {
-	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy)];
+	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy_phy)];
 	const struct nlattr *devname_attr;
+	struct phy_device *phydev = NULL;
 	struct net_device *dev = NULL;
 	u32 flags = 0;
 	int ret;
@@ -104,7 +124,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 	/* No validation here, command policy should have a nested policy set
 	 * for the header, therefore validation should have already been done.
 	 */
-	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy) - 1, header,
+	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy_phy) - 1, header,
 			       NULL, extack);
 	if (ret < 0)
 		return ret;
@@ -145,6 +165,26 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 		return -EINVAL;
 	}
 
+	if (dev) {
+		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
+			u32 phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
+
+			phydev = phy_link_topo_get_phy(dev->link_topo,
+						       phy_index);
+			if (!phydev) {
+				NL_SET_ERR_MSG_ATTR(extack, header,
+						    "no phy matches phy index");
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
index 9a333a8d04c1..d57a890b5d9e 100644
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
@@ -395,9 +397,12 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
+extern const struct nla_policy ethnl_header_policy_phy[ETHTOOL_A_HEADER_PHY_INDEX + 1];
+extern const struct nla_policy ethnl_header_policy_phy_stats[ETHTOOL_A_HEADER_PHY_INDEX + 1];
 extern const struct nla_policy ethnl_strset_get_policy[ETHTOOL_A_STRSET_COUNTS_ONLY + 1];
 extern const struct nla_policy ethnl_linkinfo_get_policy[ETHTOOL_A_LINKINFO_HEADER + 1];
 extern const struct nla_policy ethnl_linkinfo_set_policy[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL + 1];
-- 
2.43.0


