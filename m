Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E827BE22E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbjJIOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbjJIOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:11:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500EAD6;
        Mon,  9 Oct 2023 07:11:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0912C433C7;
        Mon,  9 Oct 2023 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696860709;
        bh=OtVKoB3DWEoPJHBTislWSi6+eK7Q264isCSLwj4tTSo=;
        h=From:To:Cc:Subject:Date:From;
        b=lUv5SaQwl4Tl1jlVSXs1/c9zcr7ZaPNxZ6dPvUVH2KceyZHmUhdnAi3XhvV5nJPKY
         eHeMwrOO46WfJNtulTQOLp3nDe+cwWwWlxyxNjMQahx0l/on8Y79hSc5lIn2jTXvjJ
         OlHT6MdllugTMV8uvcbnRp6f0P93uoUDHU8wIYmzknTWRaCkNcjljs3716E0EuF5Dj
         gx2Oxg1/5c5BYcixHb4X9pfM5S2SSAc4oSq9W3K23ttueIlPo1N6YAC28/riqrRcRx
         2hMwEdebXxWvKOeNJx8YKA1v86HbtJWyakIfl33LBBXRYld7dZInbTJ8CIRva2l1B2
         +usbO7Oa4BmaQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] appletalk: remove ipddp driver
Date:   Mon,  9 Oct 2023 16:10:28 +0200
Message-Id: <20231009141139.1766345-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

After the cops driver is removed, ipddp is now the only
CONFIG_DEV_APPLETALK but as far as I can tell, this also has no users
and can be removed, making appletalk support purely based on ethertalk,
using ethernet hardware.

Link: https://lore.kernel.org/netdev/e490dd0c-a65d-4acf-89c6-c06cb48ec880@app.fastmail.com/
Link: https://lore.kernel.org/netdev/9cac4fbd-9557-b0b8-54fa-93f0290a6fb8@schmorgal.com/
Cc: Doug Brown <doug@schmorgal.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/ipddp.rst |  78 -------
 MAINTAINERS                        |   1 -
 drivers/net/Makefile               |   1 -
 drivers/net/appletalk/Kconfig      |  72 ------
 drivers/net/appletalk/Makefile     |   6 -
 drivers/net/appletalk/ipddp.c      | 345 -----------------------------
 drivers/net/appletalk/ipddp.h      |  28 ---
 net/Kconfig                        |   2 +-
 net/appletalk/Kconfig              |  30 +++
 9 files changed, 31 insertions(+), 532 deletions(-)
 delete mode 100644 Documentation/networking/ipddp.rst
 delete mode 100644 drivers/net/appletalk/Kconfig
 delete mode 100644 drivers/net/appletalk/Makefile
 delete mode 100644 drivers/net/appletalk/ipddp.c
 delete mode 100644 drivers/net/appletalk/ipddp.h
 create mode 100644 net/appletalk/Kconfig

diff --git a/Documentation/networking/ipddp.rst b/Documentation/networking/ipddp.rst
deleted file mode 100644
index be7091b779274..0000000000000
--- a/Documentation/networking/ipddp.rst
+++ /dev/null
@@ -1,78 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=========================================================
-AppleTalk-IP Decapsulation and AppleTalk-IP Encapsulation
-=========================================================
-
-Documentation ipddp.c
-
-This file is written by Jay Schulist <jschlst@samba.org>
-
-Introduction
-------------
-
-AppleTalk-IP (IPDDP) is the method computers connected to AppleTalk
-networks can use to communicate via IP. AppleTalk-IP is simply IP datagrams
-inside AppleTalk packets.
-
-Through this driver you can either allow your Linux box to communicate
-IP over an AppleTalk network or you can provide IP gatewaying functions
-for your AppleTalk users.
-
-You can currently encapsulate or decapsulate AppleTalk-IP on LocalTalk,
-EtherTalk and PPPTalk. The only limit on the protocol is that of what
-kernel AppleTalk layer and drivers are available.
-
-Each mode requires its own user space software.
-
-Compiling AppleTalk-IP Decapsulation/Encapsulation
-==================================================
-
-AppleTalk-IP decapsulation needs to be compiled into your kernel. You
-will need to turn on AppleTalk-IP driver support. Then you will need to
-select ONE of the two options; IP to AppleTalk-IP encapsulation support or
-AppleTalk-IP to IP decapsulation support. If you compile the driver
-statically you will only be able to use the driver for the function you have
-enabled in the kernel. If you compile the driver as a module you can
-select what mode you want it to run in via a module loading param.
-ipddp_mode=1 for AppleTalk-IP encapsulation and ipddp_mode=2 for
-AppleTalk-IP to IP decapsulation.
-
-Basic instructions for user space tools
-=======================================
-
-I will briefly describe the operation of the tools, but you will
-need to consult the supporting documentation for each set of tools.
-
-Decapsulation - You will need to download a software package called
-MacGate. In this distribution there will be a tool called MacRoute
-which enables you to add routes to the kernel for your Macs by hand.
-Also the tool MacRegGateWay is included to register the
-proper IP Gateway and IP addresses for your machine. Included in this
-distribution is a patch to netatalk-1.4b2+asun2.0a17.2 (available from
-ftp.u.washington.edu/pub/user-supported/asun/) this patch is optional
-but it allows automatic adding and deleting of routes for Macs. (Handy
-for locations with large Mac installations)
-
-Encapsulation - You will need to download a software daemon called ipddpd.
-This software expects there to be an AppleTalk-IP gateway on the network.
-You will also need to add the proper routes to route your Linux box's IP
-traffic out the ipddp interface.
-
-Common Uses of ipddp.c
-----------------------
-Of course AppleTalk-IP decapsulation and encapsulation, but specifically
-decapsulation is being used most for connecting LocalTalk networks to
-IP networks. Although it has been used on EtherTalk networks to allow
-Macs that are only able to tunnel IP over EtherTalk.
-
-Encapsulation has been used to allow a Linux box stuck on a LocalTalk
-network to use IP. It should work equally well if you are stuck on an
-EtherTalk only network.
-
-Further Assistance
--------------------
-You can contact me (Jay Schulist <jschlst@samba.org>) with any
-questions regarding decapsulation or encapsulation. Bradford W. Johnson
-<johns393@maroon.tc.umn.edu> originally wrote the ipddp.c driver for IP
-encapsulation in AppleTalk.
diff --git a/MAINTAINERS b/MAINTAINERS
index 92539465eef12..688183517f403 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1459,7 +1459,6 @@ F:	drivers/hwmon/applesmc.c
 APPLETALK NETWORK LAYER
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-F:	drivers/net/appletalk/
 F:	include/linux/atalk.h
 F:	include/uapi/linux/atalk.h
 F:	net/appletalk/
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index e26f98f897c55..8a83db32509dc 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 # Networking Drivers
 #
 obj-$(CONFIG_ARCNET) += arcnet/
-obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
 obj-$(CONFIG_NET_DSA) += dsa/
diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
deleted file mode 100644
index b94f731e45767..0000000000000
--- a/drivers/net/appletalk/Kconfig
+++ /dev/null
@@ -1,72 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Appletalk driver configuration
-#
-config ATALK
-	tristate "Appletalk protocol support"
-	select LLC
-	help
-	  AppleTalk is the protocol that Apple computers can use to communicate
-	  on a network.  If your Linux box is connected to such a network and you
-	  wish to connect to it, say Y.  You will need to use the netatalk package
-	  so that your Linux box can act as a print and file server for Macs as
-	  well as access AppleTalk printers.  Check out
-	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
-	  EtherTalk is the name used for AppleTalk over Ethernet and the
-	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
-	  network using serial links.  EtherTalk and LocalTalk are fully
-	  supported by Linux.
-
-	  General information about how to connect Linux, Windows machines and
-	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
-	  NET3-4-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, contains valuable
-	  information as well.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called appletalk. You almost certainly want to compile it as a
-	  module so you can restart your AppleTalk stack without rebooting
-	  your machine. I hear that the GNU boycott of Apple is over, so
-	  even politically correct people are allowed to say Y here.
-
-config DEV_APPLETALK
-	tristate "Appletalk interfaces support"
-	depends on ATALK
-	help
-	  AppleTalk is the protocol that Apple computers can use to communicate
-	  on a network.  If your Linux box is connected to such a network, and wish
-	  to do IP over it, or you have a LocalTalk card and wish to use it to
-	  connect to the AppleTalk network, say Y.
-
-config IPDDP
-	tristate "Appletalk-IP driver support"
-	depends on DEV_APPLETALK && ATALK
-	help
-	  This allows IP networking for users who only have AppleTalk
-	  networking available. This feature is experimental. With this
-	  driver, you can encapsulate IP inside AppleTalk (e.g. if your Linux
-	  box is stuck on an AppleTalk only network) or decapsulate (e.g. if
-	  you want your Linux box to act as an Internet gateway for a zoo of
-	  AppleTalk connected Macs). Please see the file
-	  <file:Documentation/networking/ipddp.rst> for more information.
-
-	  If you say Y here, the AppleTalk-IP support will be compiled into
-	  the kernel. In this case, you can either use encapsulation or
-	  decapsulation, but not both. With the following two questions, you
-	  decide which one you want.
-
-	  To compile the AppleTalk-IP support as a module, choose M here: the
-	  module will be called ipddp.
-	  In this case, you will be able to use both encapsulation and
-	  decapsulation simultaneously, by loading two copies of the module
-	  and specifying different values for the module option ipddp_mode.
-
-config IPDDP_ENCAP
-	bool "IP to Appletalk-IP Encapsulation support"
-	depends on IPDDP
-	help
-	  If you say Y here, the AppleTalk-IP code will be able to encapsulate
-	  IP packets inside AppleTalk frames; this is useful if your Linux box
-	  is stuck on an AppleTalk network (which hopefully contains a
-	  decapsulator somewhere). Please see
-	  <file:Documentation/networking/ipddp.rst> for more information.
diff --git a/drivers/net/appletalk/Makefile b/drivers/net/appletalk/Makefile
deleted file mode 100644
index d8c7b23ec7ffc..0000000000000
--- a/drivers/net/appletalk/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for drivers/net/appletalk
-#
-
-obj-$(CONFIG_IPDDP) += ipddp.o
diff --git a/drivers/net/appletalk/ipddp.c b/drivers/net/appletalk/ipddp.c
deleted file mode 100644
index d558535390f98..0000000000000
--- a/drivers/net/appletalk/ipddp.c
+++ /dev/null
@@ -1,345 +0,0 @@
-/*
- *	ipddp.c: IP to Appletalk-IP Encapsulation driver for Linux
- *		 Appletalk-IP to IP Decapsulation driver for Linux
- *
- *	Authors:
- *      - DDP-IP Encap by: Bradford W. Johnson <johns393@maroon.tc.umn.edu>
- *	- DDP-IP Decap by: Jay Schulist <jschlst@samba.org>
- *
- *	Derived from:
- *	- Almost all code already existed in net/appletalk/ddp.c I just
- *	  moved/reorginized it into a driver file. Original IP-over-DDP code
- *	  was done by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
- *      - skeleton.c: A network driver outline for linux.
- *        Written 1993-94 by Donald Becker.
- *	- dummy.c: A dummy net driver. By Nick Holloway.
- *	- MacGate: A user space Daemon for Appletalk-IP Decap for
- *	  Linux by Jay Schulist <jschlst@samba.org>
- *
- *      Copyright 1993 United States Government as represented by the
- *      Director, National Security Agency.
- *
- *      This software may be used and distributed according to the terms
- *      of the GNU General Public License, incorporated herein by reference.
- */
-
-#include <linux/compat.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/ip.h>
-#include <linux/atalk.h>
-#include <linux/if_arp.h>
-#include <linux/slab.h>
-#include <net/route.h>
-#include <linux/uaccess.h>
-
-#include "ipddp.h"		/* Our stuff */
-
-static const char version[] = KERN_INFO "ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>\n";
-
-static struct ipddp_route *ipddp_route_list;
-static DEFINE_SPINLOCK(ipddp_route_lock);
-
-#ifdef CONFIG_IPDDP_ENCAP
-static int ipddp_mode = IPDDP_ENCAP;
-#else
-static int ipddp_mode = IPDDP_DECAP;
-#endif
-
-/* Index to functions, as function prototypes. */
-static netdev_tx_t ipddp_xmit(struct sk_buff *skb,
-				    struct net_device *dev);
-static int ipddp_create(struct ipddp_route *new_rt);
-static int ipddp_delete(struct ipddp_route *rt);
-static struct ipddp_route* __ipddp_find_route(struct ipddp_route *rt);
-static int ipddp_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
-				void __user *data, int cmd);
-
-static const struct net_device_ops ipddp_netdev_ops = {
-	.ndo_start_xmit		= ipddp_xmit,
-	.ndo_siocdevprivate	= ipddp_siocdevprivate,
-	.ndo_set_mac_address 	= eth_mac_addr,
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-static struct net_device * __init ipddp_init(void)
-{
-	static unsigned version_printed;
-	struct net_device *dev;
-	int err;
-
-	dev = alloc_etherdev(0);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	netif_keep_dst(dev);
-	strcpy(dev->name, "ipddp%d");
-
-	if (version_printed++ == 0)
-                printk(version);
-
-	/* Initialize the device structure. */
-	dev->netdev_ops = &ipddp_netdev_ops;
-
-        dev->type = ARPHRD_IPDDP;       	/* IP over DDP tunnel */
-        dev->mtu = 585;
-        dev->flags |= IFF_NOARP;
-
-        /*
-         *      The worst case header we will need is currently a
-         *      ethernet header (14 bytes) and a ddp header (sizeof ddpehdr+1)
-         *      We send over SNAP so that takes another 8 bytes.
-         */
-        dev->hard_header_len = 14+8+sizeof(struct ddpehdr)+1;
-
-	err = register_netdev(dev);
-	if (err) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	/* Let the user now what mode we are in */
-	if(ipddp_mode == IPDDP_ENCAP)
-		printk("%s: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroon.tc.umn.edu>\n", 
-			dev->name);
-	if(ipddp_mode == IPDDP_DECAP)
-		printk("%s: Appletalk-IP Decap. mode by Jay Schulist <jschlst@samba.org>\n", 
-			dev->name);
-
-        return dev;
-}
-
-
-/*
- * Transmit LLAP/ELAP frame using aarp_send_ddp.
- */
-static netdev_tx_t ipddp_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-        struct rtable *rtable = skb_rtable(skb);
-        __be32 paddr = 0;
-        struct ddpehdr *ddp;
-        struct ipddp_route *rt;
-        struct atalk_addr *our_addr;
-
-	if (rtable->rt_gw_family == AF_INET)
-		paddr = rtable->rt_gw4;
-
-	spin_lock(&ipddp_route_lock);
-
-	/*
-         * Find appropriate route to use, based only on IP number.
-         */
-        for(rt = ipddp_route_list; rt != NULL; rt = rt->next)
-        {
-                if(rt->ip == paddr)
-                        break;
-        }
-        if(rt == NULL) {
-		spin_unlock(&ipddp_route_lock);
-                return NETDEV_TX_OK;
-	}
-
-        our_addr = atalk_find_dev_addr(rt->dev);
-
-	if(ipddp_mode == IPDDP_DECAP)
-		/* 
-		 * Pull off the excess room that should not be there.
-		 * This is due to a hard-header problem. This is the
-		 * quick fix for now though, till it breaks.
-		 */
-		skb_pull(skb, 35-(sizeof(struct ddpehdr)+1));
-
-	/* Create the Extended DDP header */
-	ddp = (struct ddpehdr *)skb->data;
-        ddp->deh_len_hops = htons(skb->len + (1<<10));
-        ddp->deh_sum = 0;
-
-	/*
-         * For Localtalk we need aarp_send_ddp to strip the
-         * long DDP header and place a shot DDP header on it.
-         */
-        if(rt->dev->type == ARPHRD_LOCALTLK)
-        {
-                ddp->deh_dnet  = 0;   /* FIXME more hops?? */
-                ddp->deh_snet  = 0;
-        }
-        else
-        {
-                ddp->deh_dnet  = rt->at.s_net;   /* FIXME more hops?? */
-                ddp->deh_snet  = our_addr->s_net;
-        }
-        ddp->deh_dnode = rt->at.s_node;
-        ddp->deh_snode = our_addr->s_node;
-        ddp->deh_dport = 72;
-        ddp->deh_sport = 72;
-
-        *((__u8 *)(ddp+1)) = 22;        	/* ddp type = IP */
-
-        skb->protocol = htons(ETH_P_ATALK);     /* Protocol has changed */
-
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
-	aarp_send_ddp(rt->dev, skb, &rt->at, NULL);
-
-	spin_unlock(&ipddp_route_lock);
-
-        return NETDEV_TX_OK;
-}
-
-/*
- * Create a routing entry. We first verify that the
- * record does not already exist. If it does we return -EEXIST
- */
-static int ipddp_create(struct ipddp_route *new_rt)
-{
-        struct ipddp_route *rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-
-        if (rt == NULL)
-                return -ENOMEM;
-
-        rt->ip = new_rt->ip;
-        rt->at = new_rt->at;
-        rt->next = NULL;
-        if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
-		kfree(rt);
-                return -ENETUNREACH;
-        }
-
-	spin_lock_bh(&ipddp_route_lock);
-	if (__ipddp_find_route(rt)) {
-		spin_unlock_bh(&ipddp_route_lock);
-		kfree(rt);
-		return -EEXIST;
-	}
-
-        rt->next = ipddp_route_list;
-        ipddp_route_list = rt;
-
-	spin_unlock_bh(&ipddp_route_lock);
-
-        return 0;
-}
-
-/*
- * Delete a route, we only delete a FULL match.
- * If route does not exist we return -ENOENT.
- */
-static int ipddp_delete(struct ipddp_route *rt)
-{
-        struct ipddp_route **r = &ipddp_route_list;
-        struct ipddp_route *tmp;
-
-	spin_lock_bh(&ipddp_route_lock);
-        while((tmp = *r) != NULL)
-        {
-                if(tmp->ip == rt->ip &&
-		   tmp->at.s_net == rt->at.s_net &&
-		   tmp->at.s_node == rt->at.s_node)
-                {
-                        *r = tmp->next;
-			spin_unlock_bh(&ipddp_route_lock);
-                        kfree(tmp);
-                        return 0;
-                }
-                r = &tmp->next;
-        }
-
-	spin_unlock_bh(&ipddp_route_lock);
-        return -ENOENT;
-}
-
-/*
- * Find a routing entry, we only return a FULL match
- */
-static struct ipddp_route* __ipddp_find_route(struct ipddp_route *rt)
-{
-        struct ipddp_route *f;
-
-        for(f = ipddp_route_list; f != NULL; f = f->next)
-        {
-                if(f->ip == rt->ip &&
-		   f->at.s_net == rt->at.s_net &&
-		   f->at.s_node == rt->at.s_node)
-                        return f;
-        }
-
-        return NULL;
-}
-
-static int ipddp_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
-				void __user *data, int cmd)
-{
-        struct ipddp_route rcp, rcp2, *rp;
-
-	if (in_compat_syscall())
-		return -EOPNOTSUPP;
-
-        if(!capable(CAP_NET_ADMIN))
-                return -EPERM;
-
-	if (copy_from_user(&rcp, data, sizeof(rcp)))
-		return -EFAULT;
-
-        switch(cmd)
-        {
-		case SIOCADDIPDDPRT:
-                        return ipddp_create(&rcp);
-
-                case SIOCFINDIPDDPRT:
-			spin_lock_bh(&ipddp_route_lock);
-			rp = __ipddp_find_route(&rcp);
-			if (rp) {
-				memset(&rcp2, 0, sizeof(rcp2));
-				rcp2.ip    = rp->ip;
-				rcp2.at    = rp->at;
-				rcp2.flags = rp->flags;
-			}
-			spin_unlock_bh(&ipddp_route_lock);
-
-			if (rp) {
-				if (copy_to_user(data, &rcp2,
-						 sizeof(struct ipddp_route)))
-					return -EFAULT;
-				return 0;
-			} else
-				return -ENOENT;
-
-                case SIOCDELIPDDPRT:
-                        return ipddp_delete(&rcp);
-
-                default:
-                        return -EINVAL;
-        }
-}
-
-static struct net_device *dev_ipddp;
-
-MODULE_LICENSE("GPL");
-module_param(ipddp_mode, int, 0);
-
-static int __init ipddp_init_module(void)
-{
-	dev_ipddp = ipddp_init();
-	return PTR_ERR_OR_ZERO(dev_ipddp);
-}
-
-static void __exit ipddp_cleanup_module(void)
-{
-        struct ipddp_route *p;
-
-	unregister_netdev(dev_ipddp);
-        free_netdev(dev_ipddp);
-
-        while (ipddp_route_list) {
-                p = ipddp_route_list->next;
-                kfree(ipddp_route_list);
-                ipddp_route_list = p;
-        }
-}
-
-module_init(ipddp_init_module);
-module_exit(ipddp_cleanup_module);
diff --git a/drivers/net/appletalk/ipddp.h b/drivers/net/appletalk/ipddp.h
deleted file mode 100644
index 9a8e45a469259..0000000000000
--- a/drivers/net/appletalk/ipddp.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	ipddp.h: Header for IP-over-DDP driver for Linux.
- */
-
-#ifndef __LINUX_IPDDP_H
-#define __LINUX_IPDDP_H
-
-#ifdef __KERNEL__
-
-#define SIOCADDIPDDPRT   (SIOCDEVPRIVATE)
-#define SIOCDELIPDDPRT   (SIOCDEVPRIVATE+1)
-#define SIOCFINDIPDDPRT  (SIOCDEVPRIVATE+2)
-
-struct ipddp_route
-{
-        struct net_device *dev;             /* Carrier device */
-        __be32 ip;                       /* IP address */
-        struct atalk_addr at;              /* Gateway appletalk address */
-        int flags;
-        struct ipddp_route *next;
-};
-
-#define IPDDP_ENCAP	1
-#define IPDDP_DECAP	2
-
-#endif	/* __KERNEL__ */
-#endif	/* __LINUX_IPDDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index d532ec33f1fed..e248236c29a73 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -246,7 +246,7 @@ source "net/bridge/Kconfig"
 source "net/dsa/Kconfig"
 source "net/8021q/Kconfig"
 source "net/llc/Kconfig"
-source "drivers/net/appletalk/Kconfig"
+source "net/appletalk/Kconfig"
 source "net/x25/Kconfig"
 source "net/lapb/Kconfig"
 source "net/phonet/Kconfig"
diff --git a/net/appletalk/Kconfig b/net/appletalk/Kconfig
new file mode 100644
index 0000000000000..041141abf925b
--- /dev/null
+++ b/net/appletalk/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Appletalk configuration
+#
+config ATALK
+	tristate "Appletalk protocol support"
+	select LLC
+	help
+	  AppleTalk is the protocol that Apple computers can use to communicate
+	  on a network.  If your Linux box is connected to such a network and you
+	  wish to connect to it, say Y.  You will need to use the netatalk package
+	  so that your Linux box can act as a print and file server for Macs as
+	  well as access AppleTalk printers.  Check out
+	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
+	  EtherTalk is the name used for AppleTalk over Ethernet and the
+	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
+	  network using serial links.  EtherTalk and LocalTalk are fully
+	  supported by Linux.
+
+	  General information about how to connect Linux, Windows machines and
+	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
+	  NET3-4-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>, contains valuable
+	  information as well.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called appletalk. You almost certainly want to compile it as a
+	  module so you can restart your AppleTalk stack without rebooting
+	  your machine. I hear that the GNU boycott of Apple is over, so
+	  even politically correct people are allowed to say Y here.
-- 
2.39.2

