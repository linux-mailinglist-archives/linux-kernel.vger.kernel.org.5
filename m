Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADF7BE26C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377613AbjJIOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377606AbjJIOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:19:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B785C9C;
        Mon,  9 Oct 2023 07:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E1C433C7;
        Mon,  9 Oct 2023 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696861175;
        bh=jUk5LoSlCwvDMsCCVqlbEiQNZWoxEoj1k5W4FLtTq24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMr9tjF19Gof+Itm7+HtD6pBLABL6JnNKqDv0GqgFMTjiqCNuGIiuQg23LBzrRVLH
         Cd2EY9nB5S1g3bPuMinpngUa/BFGlaP2WEVLZDTFIXS4LoTeTapiHO4ikAFS7tYdRh
         SBnRgYH1UdVYG1QUx7zuRf5CVIJ31R7ujGavgu/JsaB3ToH+aYaW5vw1dZYckcmH/U
         8y47pQaVy+M/x574SqcgRbejdQ4qN0Xhhh9DkK5un3EU3XZbFM1K5b9MAlbMU0+HyF
         wDYZe6jrt97WhLnh561whuPL+XR7eGXLWKBpTMmHTrSkNOgiuyLh0B3E8f2cZVeelc
         ie/J7fECBH9sA==
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
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/10] staging: ks7010: remove unused ioctl handler
Date:   Mon,  9 Oct 2023 16:19:02 +0200
Message-Id: <20231009141908.1767241-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ndo_do_ioctl function has no actual callers, and doesn't do much here,
so just remove it entirely as preparation for removing the callback pointer
from net_device_ops.

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

