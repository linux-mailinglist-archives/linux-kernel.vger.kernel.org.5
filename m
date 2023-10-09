Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA57BE58C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377697AbjJIPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377834AbjJIPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:39 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A7100;
        Mon,  9 Oct 2023 08:52:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCE9A1C000A;
        Mon,  9 Oct 2023 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yV4hKBJdgMmXnstotwMwRXruLGjtxs7rLuaw1mB5g70=;
        b=c6W4bb+kMwa5ErL7BUWKWNTSsPV7LgXkozNDXMQRDJz+bEHViVF1wqyJ4AjJW22M3ZeJtB
        cpXJ+1oFvPbI9TMHzeEgLJk2YqW9c/7ciLxJQtHQSscghLDT1qdB9AqWWvPW8XSIZRIwbo
        aiD4xD04hOyrB3gmx6xdoKCyEQjoOn0qoJUY3CfAM82VTOkIRc1Trs49gH0ffOvWfW2wMh
        CCPMuihcN2a9myPRF1doghK6RBsJNQ/fUtS4bEdzRspPXlt1NEHDAryLQQDSNyOlI5Z1Ly
        9jX+MC97xenfXIDfhbwa+8h6F+KCYjJyVFPMj/eIc06iVIQ6D2x6JalCdVzu7w==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 10/16] net: ethtool: Add a command to list available time stamping layers
Date:   Mon,  9 Oct 2023 17:51:32 +0200
Message-Id: <20231009155138.86458-11-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Introduce a new netlink message that lists all available time stamping
layers on a given interface.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 23 +++++++
 include/uapi/linux/ethtool_netlink.h         | 14 ++++
 net/ethtool/netlink.c                        | 10 +++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/ts.c                             | 72 ++++++++++++++++++++
 5 files changed, 120 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 644b3b764044..963a5aacac8d 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -226,6 +226,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
   ``ETHTOOL_MSG_TS_GET``                get current timestamping
+  ``ETHTOOL_MSG_TS_LIST_GET``            list available timestampings
   ===================================== =================================
 
 Kernel to userspace:
@@ -270,6 +271,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
   ``ETHTOOL_MSG_TS_GET_REPLY``             current timestamping
+  ``ETHTOOL_MSG_TS_LIST_GET_REPLY``        available timestampings
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2016,6 +2018,26 @@ Kernel response contents:
 
 This command get the current timestamp layer.
 
+TS_LIST_GET
+==========
+
+Get the list of available timestampings.
+
+Request contents:
+
+  =================================  ======  ====================
+  ``ETHTOOL_A_TS_HEADER``            nested  request header
+  =================================  ======  ====================
+
+Kernel response contents:
+
+  ===========================  ======  ==============================
+  ``ETHTOOL_A_TS_HEADER``      nested  reply header
+  ``ETHTOOL_A_TS_LIST_LAYER``  binary  available timestampings
+  ===========================  ======  ==============================
+
+This command lists all the possible timestamp layer available.
+
 Request translation
 ===================
 
@@ -2122,5 +2144,6 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_TSLIST_GET``
   n/a                                 ``ETHTOOL_MSG_TS_GET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index cb51136328cf..62b885d44d06 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -58,6 +58,7 @@ enum {
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_TS_GET,
+	ETHTOOL_MSG_TS_LIST_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -111,6 +112,7 @@ enum {
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
 	ETHTOOL_MSG_TS_GET_REPLY,
+	ETHTOOL_MSG_TS_LIST_GET_REPLY,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -989,6 +991,18 @@ enum {
 	ETHTOOL_A_TS_MAX = (__ETHTOOL_A_TS_CNT - 1)
 };
 
+/* TS LIST LAYER */
+
+enum {
+	ETHTOOL_A_TS_LIST_UNSPEC,
+	ETHTOOL_A_TS_LIST_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_TS_LIST_LAYER,		/* array, u32 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TS_LIST_CNT,
+	ETHTOOL_A_TS_LIST_MAX = (__ETHTOOL_A_TS_LIST_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 561c0931d055..842c9db1531f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -307,6 +307,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_TS_GET]		= &ethnl_ts_request_ops,
+	[ETHTOOL_MSG_TS_LIST_GET]	= &ethnl_ts_list_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1138,6 +1139,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_ts_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_ts_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TS_LIST_GET,
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
index 1e6085198acc..ea8c312db3af 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -396,6 +396,7 @@ extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
 extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
 extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_ts_request_ops;
+extern const struct ethnl_request_ops ethnl_ts_list_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
index cd33f057ee48..d52b9800dc3b 100644
--- a/net/ethtool/ts.c
+++ b/net/ethtool/ts.c
@@ -76,3 +76,75 @@ const struct ethnl_request_ops ethnl_ts_request_ops = {
 	.reply_size		= ts_reply_size,
 	.fill_reply		= ts_fill_reply,
 };
+
+/* TS_LIST_GET */
+struct ts_list_reply_data {
+	struct ethnl_reply_data		base;
+	u32				ts_layer[__TIMESTAMPING_COUNT];
+	u8				num_ts;
+};
+
+#define TS_LIST_REPDATA(__reply_base) \
+	container_of(__reply_base, struct ts_list_reply_data, base)
+
+static int ts_list_prepare_data(const struct ethnl_req_info *req_base,
+				struct ethnl_reply_data *reply_base,
+				const struct genl_info *info)
+{
+	struct ts_list_reply_data *data = TS_LIST_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_ts_info ts_info = {0};
+	int ret, i = 0;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	if (phy_has_tsinfo(dev->phydev))
+		data->ts_layer[i++] = PHYLIB_TIMESTAMPING;
+	if (ops->get_ts_info) {
+		ops->get_ts_info(dev, &ts_info);
+		if (ts_info.so_timestamping &
+		    SOF_TIMESTAMPING_HARDWARE_MASK)
+			data->ts_layer[i++] = NETDEV_TIMESTAMPING;
+
+		if (ts_info.so_timestamping &
+		    SOF_TIMESTAMPING_SOFTWARE_MASK)
+			data->ts_layer[i++] = SOFTWARE_TIMESTAMPING;
+	}
+
+	data->num_ts = i;
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int ts_list_reply_size(const struct ethnl_req_info *req_base,
+			      const struct ethnl_reply_data *reply_base)
+{
+	struct ts_list_reply_data *data = TS_LIST_REPDATA(reply_base);
+
+	return nla_total_size(sizeof(u32)) * data->num_ts;
+}
+
+static int ts_list_fill_reply(struct sk_buff *skb,
+			      const struct ethnl_req_info *req_base,
+			 const struct ethnl_reply_data *reply_base)
+{
+	struct ts_list_reply_data *data = TS_LIST_REPDATA(reply_base);
+
+	return nla_put(skb, ETHTOOL_A_TS_LIST_LAYER, sizeof(u32) * data->num_ts, data->ts_layer);
+}
+
+const struct ethnl_request_ops ethnl_ts_list_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_TS_LIST_GET,
+	.reply_cmd		= ETHTOOL_MSG_TS_LIST_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_TS_HEADER,
+	.req_info_size		= sizeof(struct ts_req_info),
+	.reply_data_size	= sizeof(struct ts_list_reply_data),
+
+	.prepare_data		= ts_list_prepare_data,
+	.reply_size		= ts_list_reply_size,
+	.fill_reply		= ts_list_fill_reply,
+};
-- 
2.25.1

