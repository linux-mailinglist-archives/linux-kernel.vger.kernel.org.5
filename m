Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A597C563A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346992AbjJKODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346849AbjJKODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B867D8;
        Wed, 11 Oct 2023 07:03:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42B9C433C8;
        Wed, 11 Oct 2023 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032981;
        bh=v2U61JipGRAw5yHfVClf2xeZ1vepHEnTwO9csgoF7y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioYLjO1HqpBapuo1S1iyxyyf0UcnmM6CGIlqx/8vb42Do3W/g40+2Uz6P9jaONP2W
         n8LYIQVU185JW1CaKn5XFRz43CM6jAi9odXt1R1fV9Q7sMtyL5g/WfZ8cIkO+MlUT1
         2BjnN+t2hWuuQCq+YScg6YL68GQ0CpyOXslq12lyp0MV90gVKkfblNZM5tJl+SvXV1
         7/Sx6ECMSLnfm1EnCySyzR6YwocgBIEK7SxlLgctU3m13uAte80LR3/Sxcf2TS6aFi
         h048r5MOVltjxnCJ7qTRzXwxyUpU0+AXNgXK7PoUyPSm5ppbgc5KMztdeuKfIAk9Y3
         Z9G6PQDpzlx+Q==
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
Subject: [PATCH v2 04/10] staging: ks7010: remove unused ioctl handler
Date:   Wed, 11 Oct 2023 16:02:19 +0200
Message-Id: <20231011140225.253106-4-arnd@kernel.org>
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

The ndo_do_ioctl function has no actual callers, and doesn't do much here,
so just remove it entirely as preparation for removing the callback pointer
from net_device_ops.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/ks7010/ks_wlan_net.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 0fb97a79ad0b3..ab7463bb25169 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -51,8 +51,6 @@ static int ks_wlan_close(struct net_device *dev);
 static void ks_wlan_set_rx_mode(struct net_device *dev);
 static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
-static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
-				int cmd);
 
 static atomic_t update_phyinfo;
 static struct timer_list update_phyinfo_timer;
@@ -2458,24 +2456,6 @@ static const struct iw_handler_def ks_wlan_handler_def = {
 	.get_wireless_stats = ks_get_wireless_stats,
 };
 
-static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
-				int cmd)
-{
-	int ret;
-	struct iwreq *wrq = (struct iwreq *)rq;
-
-	switch (cmd) {
-	case SIOCIWFIRSTPRIV + 20:	/* KS_WLAN_SET_STOP_REQ */
-		ret = ks_wlan_set_stop_request(dev, NULL, &wrq->u, NULL);
-		break;
-		// All other calls are currently unsupported
-	default:
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
 static
 struct net_device_stats *ks_wlan_get_stats(struct net_device *dev)
 {
@@ -2608,7 +2588,6 @@ static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_start_xmit = ks_wlan_start_xmit,
 	.ndo_open = ks_wlan_open,
 	.ndo_stop = ks_wlan_close,
-	.ndo_do_ioctl = ks_wlan_netdev_ioctl,
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
 	.ndo_get_stats = ks_wlan_get_stats,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-- 
2.39.2

