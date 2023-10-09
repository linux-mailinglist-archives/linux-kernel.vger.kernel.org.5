Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A870F7BE599
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbjJIPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377950AbjJIPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:57 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D170D6;
        Mon,  9 Oct 2023 08:52:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B72A51C0002;
        Mon,  9 Oct 2023 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgULFTUHlUTSGRTnQAcEagfNudUgdqfksLwVg++GkDw=;
        b=JBjcLgs/U/sLIEF9UEPx1eGtTQOo6IURWrlVKph8fDu0PibLKiZnlJeCLcG1C7roHxaYgN
        Y8JgSR0fq21bqCPB++gMRI+G6C9g4B/CPO35UsKA6ZM1BfmpOTyy/ovwluPLkX8Lf/eXNO
        8rSNz9K0S7Lkpg+K2oGnIWXIlbWEYUFkjSYzkPLc/RffoG4BuzOm0Ue2ugIWwa+M653QNa
        124HIdyHA761NfPE996VIk1Juq2s4ZEOGKa4DRchIkJVAXcrrw6diu+ieoXtosd479PsxH
        jK2ncr0J0cm65nwENR4rKDnVVJ6bp/yani9Ts+zxU4YxCrUh+7cQIVqs/x0j5g==
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
Subject: [PATCH net-next v5 15/16] net ethtool: net: Let the active time stamping layer be selectable
Date:   Mon,  9 Oct 2023 17:51:37 +0200
Message-Id: <20231009155138.86458-16-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Now that the current timestamp is saved in a variable lets add the
ETHTOOL_MSG_TS_SET ethtool netlink socket to make it selectable.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Move selected_timestamping_layer introduction in this patch.
- Replace strmcmp by sysfs_streq.
- Use the PHY timestamp only if available.

Changes in v3:
- Add a devicetree binding to select the preferred timestamp
- Replace the way to select timestamp through ethtool instead of sysfs
You can test it with the ethtool source on branch feature_ptp of:
https://github.com/kmaincent/ethtool

Changes in v4:
- Change the API to select MAC default time stamping instead of the PHY.
- Add a whitelist to no break the old timestamp PHY default preferences
  for current PHY.
- Replace the ethtool ioctl by netlink.
- Add a netdev notifier to allow network device to create trap on PTP
  packets. Not tested as it need to change the lan966x driver that
  implement packet traps. I will do after the hwtstamp management change
  to NDOs.

Changes in v5:
- Remove the netdev notifier added in v4.
- Extract the default timestamp API change in another patch.
---
 Documentation/networking/ethtool-netlink.rst | 17 +++++
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/netlink.c                        |  8 +++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/ts.c                             | 66 ++++++++++++++++++++
 5 files changed, 93 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 963a5aacac8d..eb7f8592986b 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -227,6 +227,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
   ``ETHTOOL_MSG_TS_GET``                get current timestamping
   ``ETHTOOL_MSG_TS_LIST_GET``            list available timestampings
+  ``ETHTOOL_MSG_TS_SET``                set current timestamping
   ===================================== =================================
 
 Kernel to userspace:
@@ -2038,6 +2039,21 @@ Kernel response contents:
 
 This command lists all the possible timestamp layer available.
 
+TS_SET
+======
+
+Modify the selected timestamping.
+
+Request contents:
+
+  =======================  ======  ===================
+  ``ETHTOOL_A_TS_HEADER``  nested  reply header
+  ``ETHTOOL_A_TS_LAYER``   u32     timestamping
+  =======================  ======  ===================
+
+This command set the timestamping with one that should be listed by the
+TSLIST_GET command.
+
 Request translation
 ===================
 
@@ -2146,4 +2162,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_MM_SET``
   n/a                                 ``ETHTOOL_MSG_TSLIST_GET``
   n/a                                 ``ETHTOOL_MSG_TS_GET``
+  n/a                                 ``ETHTOOL_MSG_TS_SET``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 62b885d44d06..df6c4fcc62c1 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -59,6 +59,7 @@ enum {
 	ETHTOOL_MSG_MM_SET,
 	ETHTOOL_MSG_TS_GET,
 	ETHTOOL_MSG_TS_LIST_GET,
+	ETHTOOL_MSG_TS_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 842c9db1531f..8322bf71f80d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -308,6 +308,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_TS_GET]		= &ethnl_ts_request_ops,
 	[ETHTOOL_MSG_TS_LIST_GET]	= &ethnl_ts_list_request_ops,
+	[ETHTOOL_MSG_TS_SET]		= &ethnl_ts_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1148,6 +1149,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_ts_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_ts_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TS_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_ts_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_ts_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ea8c312db3af..8fedf234b824 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -444,6 +444,7 @@ extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADE
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
 extern const struct nla_policy ethnl_ts_get_policy[ETHTOOL_A_TS_HEADER + 1];
+extern const struct nla_policy ethnl_ts_set_policy[ETHTOOL_A_TS_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
index 11041a16de5b..f77297965e03 100644
--- a/net/ethtool/ts.c
+++ b/net/ethtool/ts.c
@@ -59,6 +59,69 @@ static int ts_fill_reply(struct sk_buff *skb,
 	return nla_put_u32(skb, ETHTOOL_A_TS_LAYER, data->ts_layer);
 }
 
+/* TS_SET */
+const struct nla_policy ethnl_ts_set_policy[] = {
+	[ETHTOOL_A_TS_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_TS_LAYER]	= NLA_POLICY_RANGE(NLA_U32, 0,
+						   __TIMESTAMPING_COUNT - 1)
+};
+
+static int ethnl_set_ts_validate(struct ethnl_req_info *req_info,
+				 struct genl_info *info)
+{
+	struct nlattr **tb = info->attrs;
+	const struct net_device_ops *ops = req_info->dev->netdev_ops;
+
+	if (!tb[ETHTOOL_A_TS_LAYER])
+		return 0;
+
+	if (!ops->ndo_hwtstamp_set)
+		return -EOPNOTSUPP;
+
+	return 1;
+}
+
+static int ethnl_set_ts(struct ethnl_req_info *req_info, struct genl_info *info)
+{
+	struct net_device *dev = req_info->dev;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct kernel_hwtstamp_config config = {0};
+	struct nlattr **tb = info->attrs;
+	bool mod = false;
+	u32 ts_layer;
+	int ret;
+
+	ts_layer = dev->ts_layer;
+	ethnl_update_u32(&ts_layer, tb[ETHTOOL_A_TS_LAYER], &mod);
+
+	if (!mod)
+		return 0;
+
+	if (ts_layer & NETDEV_TIMESTAMPING && !ops->get_ts_info) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_TS_LAYER],
+				    "this device cannot support timestamping");
+		return -EINVAL;
+	}
+
+	if (ts_layer & PHYLIB_TIMESTAMPING && !phy_has_tsinfo(dev->phydev)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_TS_LAYER],
+				    "this device cannot support timestamping");
+		return -EINVAL;
+	}
+
+	/* Disable time stamping in the current layer. */
+	if (netif_device_present(dev) &&
+	    dev->ts_layer & (PHYLIB_TIMESTAMPING | NETDEV_TIMESTAMPING)) {
+		ret = dev_set_hwtstamp_phylib(dev, &config, info->extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev->ts_layer = ts_layer;
+
+	return 1;
+}
+
 const struct ethnl_request_ops ethnl_ts_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_TS_GET,
 	.reply_cmd		= ETHTOOL_MSG_TS_GET_REPLY,
@@ -69,6 +132,9 @@ const struct ethnl_request_ops ethnl_ts_request_ops = {
 	.prepare_data		= ts_prepare_data,
 	.reply_size		= ts_reply_size,
 	.fill_reply		= ts_fill_reply,
+
+	.set_validate		= ethnl_set_ts_validate,
+	.set			= ethnl_set_ts,
 };
 
 /* TS_LIST_GET */
-- 
2.25.1

