Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F57C5630
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbjJKODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJKOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:02:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D694;
        Wed, 11 Oct 2023 07:02:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9E7C433C7;
        Wed, 11 Oct 2023 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032974;
        bh=6P2D1vI9Dnx/ifqCfwETYJ6jqhZEF5cp8roWi8kBEW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2s0677xncAvMOlfWNE3QyI4+yNHk6Y5IPKJc5pqm6RWeczS1+OvT9Hb1nMFm6lmE
         lDcFZrPBKY15gv1pVhSgeGAyXSR2MAUNeycjI5SFCL9tCWq7L2NVWG/FEM6FGi3yfd
         gxAwoZV0f4se1zHrcxxCx7KEmbnlqaTbvLJXhhCLbFHqqwhwXX88+aVXtWmfhjulGG
         7eLHUwSZCdOFtkGd2XQ/YbACzZAsH6CQFSaOREw/ESx7FcylrfZUVus43TBwOzzvlT
         nmrWXkCPMCKXpCFQR3OKWui9YtCoPZMTkOOV+D4L43gknaAB7wMAff/grwI/aMhKeM
         g7J5ZuA4y0OGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/10] ieee802154: avoid deprecated .ndo_do_ioctl callback
Date:   Wed, 11 Oct 2023 16:02:17 +0200
Message-Id: <20231011140225.253106-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ieee802154 socket implementation is the last remaining caller of the
netdevice ioctl callback. In order to completely remove this, add a custom
pointer to the existing wpan_dev specific operations structure. Since that
structure is currently only used to wrap the 'create' header operation,
adjust the naming slightly to make this more generic.

It would be a good idea to adjust the calling conventions and split the
get/set operations into separate functions, but that can be a follow-up
cleanup. For the moment, I kept the actual changes to a minimum to
avoid regressions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/cfg802154.h | 9 +++++----
 net/ieee802154/socket.c | 5 +++--
 net/mac802154/iface.c   | 8 ++++----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index f79ce133e51a7..e604df98e2ee9 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -433,15 +433,16 @@ struct ieee802154_llsec_device_key {
 	u32 frame_counter;
 };
 
-struct wpan_dev_header_ops {
+struct wpan_dev_ops {
 	/* TODO create callback currently assumes ieee802154_mac_cb inside
 	 * skb->cb. This should be changed to give these information as
 	 * parameter.
 	 */
-	int	(*create)(struct sk_buff *skb, struct net_device *dev,
+	int	(*header_create)(struct sk_buff *skb, struct net_device *dev,
 			  const struct ieee802154_addr *daddr,
 			  const struct ieee802154_addr *saddr,
 			  unsigned int len);
+	int	(*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
 };
 
 struct wpan_dev {
@@ -452,7 +453,7 @@ struct wpan_dev {
 	struct list_head list;
 	struct net_device *netdev;
 
-	const struct wpan_dev_header_ops *header_ops;
+	const struct wpan_dev_ops *ops;
 
 	/* lowpan interface, set when the wpan_dev belongs to one lowpan_dev */
 	struct net_device *lowpan_dev;
@@ -491,7 +492,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 {
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
 
-	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+	return wpan_dev->ops->header_create(skb, dev, daddr, saddr, len);
 }
 #endif
 
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 00302e8b9615b..27e58237091ca 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -139,8 +139,9 @@ static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->type == ARPHRD_IEEE802154 && dev->netdev_ops->ndo_do_ioctl)
-		ret = dev->netdev_ops->ndo_do_ioctl(dev, &ifr, cmd);
+	if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr &&
+	    dev->ieee802154_ptr->ops)
+		ret = dev->ieee802154_ptr->ops->ioctl(dev, &ifr, cmd);
 
 	if (!ret && put_user_ifreq(&ifr, arg))
 		ret = -EFAULT;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072bea..4937f8c2fb4cc 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -406,8 +406,9 @@ static int ieee802154_header_create(struct sk_buff *skb,
 	return hlen;
 }
 
-static const struct wpan_dev_header_ops ieee802154_header_ops = {
-	.create		= ieee802154_header_create,
+static const struct wpan_dev_ops ieee802154_ops = {
+	.header_create	= ieee802154_header_create,
+	.ioctl		= mac802154_wpan_ioctl,
 };
 
 /* This header create functionality assumes a 8 byte array for
@@ -495,7 +496,6 @@ static const struct net_device_ops mac802154_wpan_ops = {
 	.ndo_open		= mac802154_wpan_open,
 	.ndo_stop		= mac802154_slave_close,
 	.ndo_start_xmit		= ieee802154_subif_start_xmit,
-	.ndo_do_ioctl		= mac802154_wpan_ioctl,
 	.ndo_set_mac_address	= mac802154_wpan_mac_addr,
 };
 
@@ -581,7 +581,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
 		sdata->iface_default_filtering = IEEE802154_FILTERING_4_FRAME_FIELDS;
-		wpan_dev->header_ops = &ieee802154_header_ops;
+		wpan_dev->ops = &ieee802154_ops;
 
 		mutex_init(&sdata->sec_mtx);
 
-- 
2.39.2

