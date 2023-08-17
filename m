Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7077F418
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbjHQKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349031AbjHQKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:10:33 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D92D58;
        Thu, 17 Aug 2023 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fHge1MDAzC5zTpqU8Rssb1kPRKTo6BvNhCF4Ef5vXXs=; b=iRydAK01BvEMp6M7r8YDdK2KdJ
        cyEJoMzvLJgx+1Mp3jFhCfT+LoIjYthudiuL0WpTD2BCw9+3Yu8vRiNOEUn+o00XCSzS9d5V+4k7L
        4O+rJOCKFKb2NF8CZcsnM7sAkV5Ho+ukhgCFzivNedSPShgZMZJsN6Kfs4e2lvxcKpRJyqH1HFQMB
        y27qcokVSUwLB8aNN8V94C7APi+Oj3NfOQdFNoSAlpeSL6bg7JE0DfUNYBL0AutIAG1IC35M88lb5
        +dBo5eW5wwove+vHxv5li+DmmRt+yi752ny3/TKQEzuq7tYpXrNAcZKt7AN+FHrjBWroKG1pO2OG7
        Dum8xoRw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qWZxV-0009wj-Bi; Thu, 17 Aug 2023 12:10:29 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qWZxU-000TfR-S9; Thu, 17 Aug 2023 12:10:28 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] can: netlink: support setting hardware filters
Date:   Thu, 17 Aug 2023 12:10:13 +0200
Message-ID: <20230817101014.3484715-2-martin@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817101014.3484715-1-martin@geanix.com>
References: <20230817101014.3484715-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a netlink flag to pass per-device hardware filter configurations
similar to the per-socket software filters. Since different devices
supports different numbers and forms of filters (e.g. standard and
extended message IDs), a driver callback is added to validate the passed
filters.

Each filter consist of an ID value and a mask. The latter controls which
bit(s) in the message ID to filter against, and the former controls what
values the matched bits must have to accept the message.

For example, setting id=3f0 and mask=7f0 will accept messages with IDs
ranging from 0x3f0 to 0x3ff.

Each driver needs to implement first the validate_hw_filter() function,
and then configure the filters found in can->hw_filter when upping the
interface.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c        |  3 +++
 drivers/net/can/dev/netlink.c    | 33 ++++++++++++++++++++++++++++++++
 include/linux/can/dev.h          |  5 +++++
 include/uapi/linux/can/netlink.h |  1 +
 4 files changed, 42 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 7f9334a8af50..c62d2af49e74 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -280,6 +280,9 @@ EXPORT_SYMBOL_GPL(alloc_candev_mqs);
 /* Free space of the CAN network device */
 void free_candev(struct net_device *dev)
 {
+	struct can_priv *priv = netdev_priv(dev);
+
+	kfree(priv->hw_filter);
 	free_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(free_candev);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 036d85ef07f5..72cec9212bb8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -22,6 +22,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
+	[IFLA_CAN_HW_FILTER]    = { .type = NLA_UNSPEC },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
@@ -386,6 +387,38 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->termination = termval;
 	}
 
+	if (data[IFLA_CAN_HW_FILTER]) {
+		int len = nla_len(data[IFLA_CAN_HW_FILTER]);
+		int num_filter = len / sizeof(struct can_filter);
+		struct can_filter *filter = nla_data(data[IFLA_CAN_HW_FILTER]);
+
+		if (!priv->validate_hw_filter)
+			return -EOPNOTSUPP;
+
+		/* Do not allow changing HW filters while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		if (len % sizeof(struct can_filter))
+			return -EINVAL;
+
+		/* let the CAN driver validate the given hw filters */
+		err = priv->validate_hw_filter(dev, filter, num_filter);
+		if (err)
+			return err;
+
+		kfree(priv->hw_filter);
+		priv->hw_filter = NULL;
+		priv->hw_filter_cnt = 0;
+
+		if (len) {
+			priv->hw_filter = kmemdup(filter, len, GFP_KERNEL);
+			if (!priv->hw_filter)
+				return -ENOMEM;
+			priv->hw_filter_cnt = num_filter;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 982ba245eb41..a6b27c75c4ac 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -56,6 +56,8 @@ struct can_priv {
 	const u32 *data_bitrate_const;
 	unsigned int data_bitrate_const_cnt;
 	u32 bitrate_max;
+	struct can_filter *hw_filter;
+	unsigned int hw_filter_cnt;
 	struct can_clock clock;
 
 	unsigned int termination_const_cnt;
@@ -80,6 +82,9 @@ struct can_priv {
 	int (*do_set_data_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
 	int (*do_set_termination)(struct net_device *dev, u16 term);
+	int (*validate_hw_filter)(struct net_device *dev,
+				  struct can_filter *hwf,
+				  unsigned int hwf_cnt);
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..2dfa09153bc4 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -138,6 +138,7 @@ enum {
 	IFLA_CAN_BITRATE_MAX,
 	IFLA_CAN_TDC,
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_HW_FILTER,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
-- 
2.41.0

