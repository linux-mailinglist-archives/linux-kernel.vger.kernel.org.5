Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCB7C56B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjJKOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjJKODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F792;
        Wed, 11 Oct 2023 07:03:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17310C433CC;
        Wed, 11 Oct 2023 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697033004;
        bh=zrhlLGL/7VohDIuN/EnFdfDCdV/hjo/fxSU8flcn0tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fv1HVdZCtl1nJlrYvL4pbAyBWkP5ONV8qajJUP3MxqjnmH7ue9v7qW5IY/d5p+JX0
         XzuLDOSvYdqyJqrMue4njz27bUrf3is+UQkG+0Q30EQsfZtTHlO3p+vWGTF9182BkG
         UUZPGRKBvYwBTr5nY88nGPXcup+2wbUzlxEAQvEMiapopqvV58MnfdZ/sW10zJPlYl
         E70dw4/UxSSM1nf7fdjyNjc8LI/n6v2crN/Rbnix/VMb6o8TlrAZtLo1t6rNB+Yq83
         wlti2jF0kEbgmTnPqjaS6F5CjSxANi7pncq0av/3EA5s/UOfO5+eMuDlCeAIB06ZzP
         aRvesvlAVww2Q==
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
Subject: [PATCH v2 10/10] net: remove ndo_do_ioctl handler
Date:   Wed, 11 Oct 2023 16:02:25 +0200
Message-Id: <20231011140225.253106-10-arnd@kernel.org>
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

All of the references to the callback pointer are gone, so remove the
pointer itself before we grow new references to it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/netdevices.rst | 8 --------
 include/linux/netdevice.h               | 7 -------
 2 files changed, 15 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 9e4cccb90b870..6f9b71c5d37b8 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -218,14 +218,6 @@ ndo_stop:
 	Context: process
 	Note: netif_running() is guaranteed false
 
-ndo_do_ioctl:
-	Synchronization: rtnl_lock() semaphore.
-	Context: process
-
-        This is only called by network subsystems internally,
-        not by user space calling ioctl as it was in before
-        linux-5.14.
-
 ndo_siocbond:
         Synchronization: rtnl_lock() semaphore.
         Context: process
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fbaf..8d1cc8f195cb6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1121,11 +1121,6 @@ struct netdev_net_notifier {
  * int (*ndo_validate_addr)(struct net_device *dev);
  *	Test if Media Access Control address is valid for the device.
  *
- * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
- *	Old-style ioctl entry point. This is used internally by the
- *	appletalk and ieee802154 subsystems but is no longer called by
- *	the device ioctl handler.
- *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
  *	SIOCBONDENSLAVE, SIOCBONDRELEASE, SIOCBONDSETHWADDR, SIOCBONDCHANGEACTIVE,
@@ -1429,8 +1424,6 @@ struct net_device_ops {
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
-	int			(*ndo_do_ioctl)(struct net_device *dev,
-					        struct ifreq *ifr, int cmd);
 	int			(*ndo_eth_ioctl)(struct net_device *dev,
 						 struct ifreq *ifr, int cmd);
 	int			(*ndo_siocbond)(struct net_device *dev,
-- 
2.39.2

