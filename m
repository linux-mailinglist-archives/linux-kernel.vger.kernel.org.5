Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D207C5651
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJKODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJKOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD565103;
        Wed, 11 Oct 2023 07:03:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5813BC433C8;
        Wed, 11 Oct 2023 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697033000;
        bh=swFjHYRAcIq+7y7eoCfw/OikCf4A6aTlX7mu0sQjbyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WT7PE9Y7o+usoU/jopmxSwxzD0zuzQRSz749t5aYzXMhB9F7lR/Sw/H/Q88nb1gTw
         fiPHfrm7V4uVQ19XFpYD0srIVnQiUU6bnX3Bmwt08vR2KFcIrahZ1KAh89BwFIbYs0
         wlDTk9tm+RLKl6gAVbk69kJBEJJm9QBYsY1tg6ya/L5qXBvUDLXMdQ2+i37dSp+2bz
         RwW9xj4Es5qrwmSPzZ/74OiXkPqP2ilAFdZcFJzK/cBzoo8h64G1OuWM+g8BZ34nBY
         S3NyNTbxWoCRGgjn7AmCCBg1PZwMnmyR9Idv9v1y0+m+OL2P+45a9hCHZrE6PSRPWY
         x9fYPiz9KdpxQ==
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
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2 09/10] wifi: hostap: remove unused ioctl function
Date:   Wed, 11 Oct 2023 16:02:24 +0200
Message-Id: <20231011140225.253106-9-arnd@kernel.org>
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

The ioctl handler has no actual callers in the kernel and is useless.
All the functionality should be reachable through the regualar interfaces.

Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wireless/hostap/hostap.h      |   1 -
 .../staging/wireless/hostap/hostap_ioctl.c    | 228 ------------------
 drivers/staging/wireless/hostap/hostap_main.c |   3 -
 3 files changed, 232 deletions(-)

diff --git a/drivers/staging/wireless/hostap/hostap.h b/drivers/staging/wireless/hostap/hostap.h
index c17ab6dbbb538..552ae33d78751 100644
--- a/drivers/staging/wireless/hostap/hostap.h
+++ b/drivers/staging/wireless/hostap/hostap.h
@@ -92,7 +92,6 @@ void hostap_info_process(local_info_t *local, struct sk_buff *skb);
 extern const struct iw_handler_def hostap_iw_handler_def;
 extern const struct ethtool_ops prism2_ethtool_ops;
 
-int hostap_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 int hostap_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			  void __user *data, int cmd);
 
diff --git a/drivers/staging/wireless/hostap/hostap_ioctl.c b/drivers/staging/wireless/hostap/hostap_ioctl.c
index b4adfc190ae87..26162f92e3c3d 100644
--- a/drivers/staging/wireless/hostap/hostap_ioctl.c
+++ b/drivers/staging/wireless/hostap/hostap_ioctl.c
@@ -2316,21 +2316,6 @@ static const struct iw_priv_args prism2_priv[] = {
 };
 
 
-static int prism2_ioctl_priv_inquire(struct net_device *dev, int *i)
-{
-	struct hostap_interface *iface;
-	local_info_t *local;
-
-	iface = netdev_priv(dev);
-	local = iface->local;
-
-	if (local->func->cmd(dev, HFA384X_CMDCODE_INQUIRE, *i, NULL, NULL))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-
 static int prism2_ioctl_priv_prism2_param(struct net_device *dev,
 					  struct iw_request_info *info,
 					  union iwreq_data *uwrq, char *extra)
@@ -2910,146 +2895,6 @@ static int prism2_ioctl_priv_writemif(struct net_device *dev,
 }
 
 
-static int prism2_ioctl_priv_monitor(struct net_device *dev, int *i)
-{
-	struct hostap_interface *iface;
-	local_info_t *local;
-	int ret = 0;
-	union iwreq_data wrqu;
-
-	iface = netdev_priv(dev);
-	local = iface->local;
-
-	printk(KERN_DEBUG "%s: process %d (%s) used deprecated iwpriv monitor "
-	       "- update software to use iwconfig mode monitor\n",
-	       dev->name, task_pid_nr(current), current->comm);
-
-	/* Backward compatibility code - this can be removed at some point */
-
-	if (*i == 0) {
-		/* Disable monitor mode - old mode was not saved, so go to
-		 * Master mode */
-		wrqu.mode = IW_MODE_MASTER;
-		ret = prism2_ioctl_siwmode(dev, NULL, &wrqu, NULL);
-	} else if (*i == 1) {
-		/* netlink socket mode is not supported anymore since it did
-		 * not separate different devices from each other and was not
-		 * best method for delivering large amount of packets to
-		 * user space */
-		ret = -EOPNOTSUPP;
-	} else if (*i == 2 || *i == 3) {
-		switch (*i) {
-		case 2:
-			local->monitor_type = PRISM2_MONITOR_80211;
-			break;
-		case 3:
-			local->monitor_type = PRISM2_MONITOR_PRISM;
-			break;
-		}
-		wrqu.mode = IW_MODE_MONITOR;
-		ret = prism2_ioctl_siwmode(dev, NULL, &wrqu, NULL);
-		hostap_monitor_mode_enable(local);
-	} else
-		ret = -EINVAL;
-
-	return ret;
-}
-
-
-static int prism2_ioctl_priv_reset(struct net_device *dev, int *i)
-{
-	struct hostap_interface *iface;
-	local_info_t *local;
-
-	iface = netdev_priv(dev);
-	local = iface->local;
-
-	printk(KERN_DEBUG "%s: manual reset request(%d)\n", dev->name, *i);
-	switch (*i) {
-	case 0:
-		/* Disable and enable card */
-		local->func->hw_shutdown(dev, 1);
-		local->func->hw_config(dev, 0);
-		break;
-
-	case 1:
-		/* COR sreset */
-		local->func->hw_reset(dev);
-		break;
-
-	case 2:
-		/* Disable and enable port 0 */
-		local->func->reset_port(dev);
-		break;
-
-	case 3:
-		prism2_sta_deauth(local, WLAN_REASON_DEAUTH_LEAVING);
-		if (local->func->cmd(dev, HFA384X_CMDCODE_DISABLE, 0, NULL,
-				     NULL))
-			return -EINVAL;
-		break;
-
-	case 4:
-		if (local->func->cmd(dev, HFA384X_CMDCODE_ENABLE, 0, NULL,
-				     NULL))
-			return -EINVAL;
-		break;
-
-	default:
-		printk(KERN_DEBUG "Unknown reset request %d\n", *i);
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-
-static int prism2_ioctl_priv_set_rid_word(struct net_device *dev, int *i)
-{
-	int rid = *i;
-	int value = *(i + 1);
-
-	printk(KERN_DEBUG "%s: Set RID[0x%X] = %d\n", dev->name, rid, value);
-
-	if (hostap_set_word(dev, rid, value))
-		return -EINVAL;
-
-	return 0;
-}
-
-
-#ifndef PRISM2_NO_KERNEL_IEEE80211_MGMT
-static int ap_mac_cmd_ioctl(local_info_t *local, int *cmd)
-{
-	int ret = 0;
-
-	switch (*cmd) {
-	case AP_MAC_CMD_POLICY_OPEN:
-		local->ap->mac_restrictions.policy = MAC_POLICY_OPEN;
-		break;
-	case AP_MAC_CMD_POLICY_ALLOW:
-		local->ap->mac_restrictions.policy = MAC_POLICY_ALLOW;
-		break;
-	case AP_MAC_CMD_POLICY_DENY:
-		local->ap->mac_restrictions.policy = MAC_POLICY_DENY;
-		break;
-	case AP_MAC_CMD_FLUSH:
-		ap_control_flush_macs(&local->ap->mac_restrictions);
-		break;
-	case AP_MAC_CMD_KICKALL:
-		ap_control_kickall(local->ap);
-		hostap_deauth_all_stas(local->dev, local->ap, 0);
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	return ret;
-}
-#endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
-
-
 #ifdef PRISM2_DOWNLOAD_SUPPORT
 static int prism2_ioctl_priv_download(local_info_t *local, struct iw_point *p)
 {
@@ -3963,79 +3808,6 @@ const struct iw_handler_def hostap_iw_handler_def =
 	.get_wireless_stats = hostap_get_wireless_stats,
 };
 
-/* Private ioctls (iwpriv) that have not yet been converted
- * into new wireless extensions API */
-int hostap_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct iwreq *wrq = (struct iwreq *) ifr;
-	struct hostap_interface *iface;
-	local_info_t *local;
-	int ret = 0;
-
-	iface = netdev_priv(dev);
-	local = iface->local;
-
-	switch (cmd) {
-	case PRISM2_IOCTL_INQUIRE:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_ioctl_priv_inquire(dev, (int *) wrq->u.name);
-		break;
-
-	case PRISM2_IOCTL_MONITOR:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_ioctl_priv_monitor(dev, (int *) wrq->u.name);
-		break;
-
-	case PRISM2_IOCTL_RESET:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_ioctl_priv_reset(dev, (int *) wrq->u.name);
-		break;
-
-	case PRISM2_IOCTL_WDS_ADD:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_wds_add(local, wrq->u.ap_addr.sa_data, 1);
-		break;
-
-	case PRISM2_IOCTL_WDS_DEL:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_wds_del(local, wrq->u.ap_addr.sa_data, 1, 0);
-		break;
-
-	case PRISM2_IOCTL_SET_RID_WORD:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = prism2_ioctl_priv_set_rid_word(dev,
-							  (int *) wrq->u.name);
-		break;
-
-#ifndef PRISM2_NO_KERNEL_IEEE80211_MGMT
-	case PRISM2_IOCTL_MACCMD:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = ap_mac_cmd_ioctl(local, (int *) wrq->u.name);
-		break;
-
-	case PRISM2_IOCTL_ADDMAC:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = ap_control_add_mac(&local->ap->mac_restrictions,
-					      wrq->u.ap_addr.sa_data);
-		break;
-	case PRISM2_IOCTL_DELMAC:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = ap_control_del_mac(&local->ap->mac_restrictions,
-					      wrq->u.ap_addr.sa_data);
-		break;
-	case PRISM2_IOCTL_KICKMAC:
-		if (!capable(CAP_NET_ADMIN)) ret = -EPERM;
-		else ret = ap_control_kick_mac(local->ap, local->dev,
-					       wrq->u.ap_addr.sa_data);
-		break;
-#endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	return ret;
-}
 
 /* Private ioctls that are not used with iwpriv;
  * in SIOCDEVPRIVATE range */
diff --git a/drivers/staging/wireless/hostap/hostap_main.c b/drivers/staging/wireless/hostap/hostap_main.c
index 787f685e70b49..bf86ac26c2acc 100644
--- a/drivers/staging/wireless/hostap/hostap_main.c
+++ b/drivers/staging/wireless/hostap/hostap_main.c
@@ -796,7 +796,6 @@ static const struct net_device_ops hostap_netdev_ops = {
 
 	.ndo_open		= prism2_open,
 	.ndo_stop		= prism2_close,
-	.ndo_do_ioctl		= hostap_ioctl,
 	.ndo_siocdevprivate	= hostap_siocdevprivate,
 	.ndo_set_mac_address	= prism2_set_mac_address,
 	.ndo_set_rx_mode	= hostap_set_multicast_list,
@@ -809,7 +808,6 @@ static const struct net_device_ops hostap_mgmt_netdev_ops = {
 
 	.ndo_open		= prism2_open,
 	.ndo_stop		= prism2_close,
-	.ndo_do_ioctl		= hostap_ioctl,
 	.ndo_siocdevprivate	= hostap_siocdevprivate,
 	.ndo_set_mac_address	= prism2_set_mac_address,
 	.ndo_set_rx_mode	= hostap_set_multicast_list,
@@ -822,7 +820,6 @@ static const struct net_device_ops hostap_master_ops = {
 
 	.ndo_open		= prism2_open,
 	.ndo_stop		= prism2_close,
-	.ndo_do_ioctl		= hostap_ioctl,
 	.ndo_siocdevprivate	= hostap_siocdevprivate,
 	.ndo_set_mac_address	= prism2_set_mac_address,
 	.ndo_set_rx_mode	= hostap_set_multicast_list,
-- 
2.39.2

