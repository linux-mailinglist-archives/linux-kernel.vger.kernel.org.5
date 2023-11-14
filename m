Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919C7EAF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjKNLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjKNL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:31 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8540D7E;
        Tue, 14 Nov 2023 03:29:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52A9C60010;
        Tue, 14 Nov 2023 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=invxvvsNyaslfuOag5qFd3lmUeCZ/b8fEn5ZKD3SNsQ=;
        b=KF3uhHI04EgHeIFumKURo2Mh4ZsZxpJDOPlYdSbMDfvX8wKewcbFZbBopAEGIc65x5Wiwp
        vusDb7PQAmayXfyZdwnUnin9/ETXXHXo8S9vNfmfcGSO3Ku+93SJBdtfaSirsTHmUHN9wx
        PRzww4Q9ip7exz+U4bvS/nD5CQJAbQmWrLB49Xd1RHn+zSDqcVAWrWDIBTnh3E60hGBAhc
        kB8VP55ozBKb/kxG3YVODxdFSRAk1J0GKHDrCyf3sVLyG4qhX+tn+UMCDOZMQopE4a4dol
        FIfa883xSmvCOdFZsA8A5us5F4etxfxq4C0DVXP1pZcQv0GzvWq3bEwriGyucA==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:36 +0100
Subject: [PATCH net-next v7 08/16] net: ethtool: Add a command to expose
 current time stamping layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time stamping on network packets may happen either in the MAC or in
the PHY, but not both.  In preparation for making the choice
selectable, expose both the current layers via ethtool.

In accordance with the kernel implementation as it stands, the current
layer will always read as "phy" when a PHY time stamping device is
present. Future patches will allow changing the current layer
administratively.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

---
Changes in v2:
- Move the introduction of selected_timestamping_layer variable in next
  patch.

Changes in v3:
- Move on to ethtool instead of syfs

Changes in v4:
- Move on to netlink ethtool instead of ioctl. I am not familiar with
  netlink so there might be some code that does not follow the good code
  practice.

Changes in v5:
- Rename timestamping layers.
- Set a default value of ts_layer in __ethtool_get_ts_info function.
- Separate TS_GET and TS_LIST_GET ethtool command in two separate patches.
- Update documentation.

Changes in v6:
- Moved back to a timestamping_layer simple enum.
- Moved back to MAC/PHY_TIMESTAMING namings.
- Add SOFTWARE timestamping description.
---
 Documentation/networking/ethtool-netlink.rst | 23 ++++++++
 include/uapi/linux/ethtool_netlink.h         | 14 +++++
 include/uapi/linux/net_tstamp.h              | 10 ++++
 net/ethtool/Makefile                         |  2 +-
 net/ethtool/common.h                         |  1 +
 net/ethtool/netlink.c                        | 10 ++++
 net/ethtool/netlink.h                        |  2 +
 net/ethtool/ts.c                             | 88 ++++++++++++++++++++++++++++
 8 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..644b3b764044 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -225,6 +225,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_GET``               get RSS settings
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_TS_GET``                get current timestamping
   ===================================== =================================
 
 Kernel to userspace:
@@ -268,6 +269,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_TS_GET_REPLY``             current timestamping
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -1994,6 +1996,26 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+TS_GET
+======
+
+Gets current timestamping.
+
+Request contents:
+
+  =================================  ======  ====================
+  ``ETHTOOL_A_TS_HEADER``            nested  request header
+  =================================  ======  ====================
+
+Kernel response contents:
+
+  =======================  ======  ==============================
+  ``ETHTOOL_A_TS_HEADER``  nested  reply header
+  ``ETHTOOL_A_TS_LAYER``   u32     current timestamping
+  =======================  ======  ==============================
+
+This command get the current timestamp layer.
+
 Request translation
 ===================
 
@@ -2100,4 +2122,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_TS_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..cb51136328cf 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_TS_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_TS_GET_REPLY,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -975,6 +977,18 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+/* TS LAYER */
+
+enum {
+	ETHTOOL_A_TS_UNSPEC,
+	ETHTOOL_A_TS_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_TS_LAYER,			/* u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TS_CNT,
+	ETHTOOL_A_TS_MAX = (__ETHTOOL_A_TS_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index df8091998c8d..4551fb3d7720 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,6 +13,16 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/* Layer of the TIMESTAMPING provider */
+enum timestamping_layer {
+	NO_TIMESTAMPING,
+	SOFTWARE_TIMESTAMPING,
+	MAC_TIMESTAMPING,
+	PHY_TIMESTAMPING,
+
+	__TIMESTAMPING_COUNT,
+};
+
 /* SO_TIMESTAMPING flags */
 enum {
 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 504f954a1b28..4ea64c080639 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o pse-pd.o plca.o mm.o
+		   module.o pse-pd.o plca.o mm.o ts.o
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9bcb..a264b635f7d3 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -35,6 +35,7 @@ extern const char wol_mode_names[][ETH_GSTRING_LEN];
 extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
 extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
+extern const char ts_layer_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..561c0931d055 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -306,6 +306,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TS_GET]		= &ethnl_ts_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1128,6 +1129,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TS_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_ts_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_ts_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..1e6085198acc 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -395,6 +395,7 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
+extern const struct ethnl_request_ops ethnl_ts_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -441,6 +442,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_ts_get_policy[ETHTOOL_A_TS_HEADER + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
new file mode 100644
index 000000000000..066cb06f4d0b
--- /dev/null
+++ b/net/ethtool/ts.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/net_tstamp.h>
+#include <linux/phy.h>
+
+#include "netlink.h"
+#include "common.h"
+#include "bitset.h"
+
+struct ts_req_info {
+	struct ethnl_req_info		base;
+};
+
+struct ts_reply_data {
+	struct ethnl_reply_data		base;
+	enum timestamping_layer		ts_layer;
+};
+
+#define TS_REPDATA(__reply_base) \
+	container_of(__reply_base, struct ts_reply_data, base)
+
+/* TS_GET */
+const struct nla_policy ethnl_ts_get_policy[] = {
+	[ETHTOOL_A_TS_HEADER]		=
+		NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+static int ts_prepare_data(const struct ethnl_req_info *req_base,
+			   struct ethnl_reply_data *reply_base,
+			   const struct genl_info *info)
+{
+	struct ts_reply_data *data = TS_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	if (phy_has_tsinfo(dev->phydev)) {
+		data->ts_layer = PHY_TIMESTAMPING;
+	} else if (ops->get_ts_info) {
+		struct ethtool_ts_info ts_info = {0};
+
+		ops->get_ts_info(dev, &ts_info);
+		if (ts_info.so_timestamping &
+		    SOF_TIMESTAMPING_HARDWARE_MASK)
+			data->ts_layer = MAC_TIMESTAMPING;
+
+		if (ts_info.so_timestamping &
+		    SOF_TIMESTAMPING_SOFTWARE_MASK)
+			data->ts_layer = SOFTWARE_TIMESTAMPING;
+	} else {
+		data->ts_layer = NO_TIMESTAMPING;
+	}
+
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int ts_reply_size(const struct ethnl_req_info *req_base,
+			 const struct ethnl_reply_data *reply_base)
+{
+	return nla_total_size(sizeof(u32));
+}
+
+static int ts_fill_reply(struct sk_buff *skb,
+			 const struct ethnl_req_info *req_base,
+			 const struct ethnl_reply_data *reply_base)
+{
+	struct ts_reply_data *data = TS_REPDATA(reply_base);
+
+	return nla_put_u32(skb, ETHTOOL_A_TS_LAYER, data->ts_layer);
+}
+
+const struct ethnl_request_ops ethnl_ts_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_TS_GET,
+	.reply_cmd		= ETHTOOL_MSG_TS_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_TS_HEADER,
+	.req_info_size		= sizeof(struct ts_req_info),
+	.reply_data_size	= sizeof(struct ts_reply_data),
+
+	.prepare_data		= ts_prepare_data,
+	.reply_size		= ts_reply_size,
+	.fill_reply		= ts_fill_reply,
+};

-- 
2.25.1

