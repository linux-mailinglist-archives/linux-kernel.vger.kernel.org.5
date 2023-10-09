Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6AC7BE25E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376937AbjJIOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:19:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776A8E;
        Mon,  9 Oct 2023 07:19:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE53C433C7;
        Mon,  9 Oct 2023 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696861165;
        bh=FuIQJadP9OG6oQv5hRHn7DaK4+yQYHcylPGcT3nyG9s=;
        h=From:To:Cc:Subject:Date:From;
        b=X4aAdXDtS1sOYR/ZLyyg1dFbsjs0fE7IexCu+7+YnkAljZr5XrUr7H9InNHWP6z7s
         BS/gvEnHpaYjDYpiZKy1s8LmNGnaOMoyivMb2j39RF5mShmXs/wUlF9UzWZF1hpXy6
         S7N7KDJY7Zp6H9jn5hCxN2lLK7GkTPiffMqzaZ0+rwZbiB//+3ZssFdnyEP3yrqsmr
         SLVR4T/a8DJGDA6JVxfXQh3WBP/Y4RZpCalU4Bp+N412WJQcxR9xC98zG/FOBsb6xp
         IfHRcl+R/I4syM4HLZiZh/U9AjsAjsZRpIKIUTXXUn+xGaDhxWHQ1trhGhyulXZesV
         MD8ZuaHp1Bb/g==
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
Subject: [PATCH 01/10] appletalk: remove localtalk and ppp support
Date:   Mon,  9 Oct 2023 16:18:59 +0200
Message-Id: <20231009141908.1767241-1-arnd@kernel.org>
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

The last localtalk driver is gone now, and ppp support was never fully
merged, so clean up the appletalk code by removing the obvious dead
code paths.

Notably, this removes one of the two callers of the old .ndo_do_ioctl()
callback that was abused for getting device addresses and is now
only used in the ieee802154 subsystem, which still uses the same trick.

The include/uapi/linux/if_ltalk.h header might still be required
for building userspace programs, but I made sure that debian code
search and the netatalk upstream have no references it it, so it
should be fine to remove.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/tun.c             |   3 -
 include/linux/atalk.h         |   1 -
 include/linux/if_ltalk.h      |   8 ---
 include/uapi/linux/if_ltalk.h |  10 ----
 net/appletalk/Makefile        |   2 +-
 net/appletalk/aarp.c          | 108 +++-------------------------------
 net/appletalk/ddp.c           |  97 +-----------------------------
 net/appletalk/dev.c           |  46 ---------------
 8 files changed, 11 insertions(+), 264 deletions(-)
 delete mode 100644 include/linux/if_ltalk.h
 delete mode 100644 include/uapi/linux/if_ltalk.h
 delete mode 100644 net/appletalk/dev.c

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 89ab9efe522c3..e11476296e253 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -70,7 +70,6 @@
 #include <linux/bpf_trace.h>
 #include <linux/mutex.h>
 #include <linux/ieee802154.h>
-#include <linux/if_ltalk.h>
 #include <uapi/linux/if_fddi.h>
 #include <uapi/linux/if_hippi.h>
 #include <uapi/linux/if_fc.h>
@@ -3059,8 +3058,6 @@ static unsigned char tun_get_addr_len(unsigned short type)
 		return ROSE_ADDR_LEN;
 	case ARPHRD_NETROM:
 		return AX25_ADDR_LEN;
-	case ARPHRD_LOCALTLK:
-		return LTALK_ALEN;
 	default:
 		return 0;
 	}
diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index a55bfc6567d01..2896f2ac9568e 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -121,7 +121,6 @@ static inline struct atalk_iface *atalk_find_dev(struct net_device *dev)
 #endif
 
 extern struct atalk_addr *atalk_find_dev_addr(struct net_device *dev);
-extern struct net_device *atrtr_get_dev(struct atalk_addr *sa);
 extern int		 aarp_send_ddp(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct atalk_addr *sa, void *hwaddr);
diff --git a/include/linux/if_ltalk.h b/include/linux/if_ltalk.h
deleted file mode 100644
index 4cc1c0b778700..0000000000000
--- a/include/linux/if_ltalk.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_LTALK_H
-#define __LINUX_LTALK_H
-
-#include <uapi/linux/if_ltalk.h>
-
-extern struct net_device *alloc_ltalkdev(int sizeof_priv);
-#endif
diff --git a/include/uapi/linux/if_ltalk.h b/include/uapi/linux/if_ltalk.h
deleted file mode 100644
index fa61e776f598d..0000000000000
--- a/include/uapi/linux/if_ltalk.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__LINUX_LTALK_H
-#define _UAPI__LINUX_LTALK_H
-
-#define LTALK_HLEN		1
-#define LTALK_MTU		600
-#define LTALK_ALEN		1
-
-
-#endif /* _UAPI__LINUX_LTALK_H */
diff --git a/net/appletalk/Makefile b/net/appletalk/Makefile
index 33164d972d379..152312a151800 100644
--- a/net/appletalk/Makefile
+++ b/net/appletalk/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_ATALK) += appletalk.o
 
-appletalk-y			:= aarp.o ddp.o dev.o
+appletalk-y			:= aarp.o ddp.o
 appletalk-$(CONFIG_PROC_FS)	+= atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9fa0b246902be..dfcd9f46cb3a6 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -432,49 +432,18 @@ static struct atalk_addr *__aarp_proxy_find(struct net_device *dev,
 	return a ? sa : NULL;
 }
 
-/*
- * Probe a Phase 1 device or a device that requires its Net:Node to
- * be set via an ioctl.
- */
-static void aarp_send_probe_phase1(struct atalk_iface *iface)
-{
-	struct ifreq atreq;
-	struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
-	const struct net_device_ops *ops = iface->dev->netdev_ops;
-
-	sa->sat_addr.s_node = iface->address.s_node;
-	sa->sat_addr.s_net = ntohs(iface->address.s_net);
-
-	/* We pass the Net:Node to the drivers/cards by a Device ioctl. */
-	if (!(ops->ndo_do_ioctl(iface->dev, &atreq, SIOCSIFADDR))) {
-		ops->ndo_do_ioctl(iface->dev, &atreq, SIOCGIFADDR);
-		if (iface->address.s_net != htons(sa->sat_addr.s_net) ||
-		    iface->address.s_node != sa->sat_addr.s_node)
-			iface->status |= ATIF_PROBE_FAIL;
-
-		iface->address.s_net  = htons(sa->sat_addr.s_net);
-		iface->address.s_node = sa->sat_addr.s_node;
-	}
-}
-
-
 void aarp_probe_network(struct atalk_iface *atif)
 {
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
-		aarp_send_probe_phase1(atif);
-	else {
-		unsigned int count;
+	unsigned int count;
 
-		for (count = 0; count < AARP_RETRANSMIT_LIMIT; count++) {
-			aarp_send_probe(atif->dev, &atif->address);
+	for (count = 0; count < AARP_RETRANSMIT_LIMIT; count++) {
+		aarp_send_probe(atif->dev, &atif->address);
 
-			/* Defer 1/10th */
-			msleep(100);
+		/* Defer 1/10th */
+		msleep(100);
 
-			if (atif->status & ATIF_PROBE_FAIL)
-				break;
-		}
+		if (atif->status & ATIF_PROBE_FAIL)
+			break;
 	}
 }
 
@@ -484,14 +453,6 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	struct aarp_entry *entry;
 	unsigned int count;
 
-	/*
-	 * we don't currently support LocalTalk or PPP for proxy AARP;
-	 * if someone wants to try and add it, have fun
-	 */
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
-		goto out;
-
 	/*
 	 * create a new AARP entry with the flags set to be published --
 	 * we need this one to hang around even if it's in use
@@ -549,51 +510,6 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
-	/* Check for LocalTalk first */
-	if (dev->type == ARPHRD_LOCALTLK) {
-		struct atalk_addr *at = atalk_find_dev_addr(dev);
-		struct ddpehdr *ddp = (struct ddpehdr *)skb->data;
-		int ft = 2;
-
-		/*
-		 * Compressible ?
-		 *
-		 * IFF: src_net == dest_net == device_net
-		 * (zero matches anything)
-		 */
-
-		if ((!ddp->deh_snet || at->s_net == ddp->deh_snet) &&
-		    (!ddp->deh_dnet || at->s_net == ddp->deh_dnet)) {
-			skb_pull(skb, sizeof(*ddp) - 4);
-
-			/*
-			 *	The upper two remaining bytes are the port
-			 *	numbers	we just happen to need. Now put the
-			 *	length in the lower two.
-			 */
-			*((__be16 *)skb->data) = htons(skb->len);
-			ft = 1;
-		}
-		/*
-		 * Nice and easy. No AARP type protocols occur here so we can
-		 * just shovel it out with a 3 byte LLAP header
-		 */
-
-		skb_push(skb, 3);
-		skb->data[0] = sa->s_node;
-		skb->data[1] = at->s_node;
-		skb->data[2] = ft;
-		skb->dev     = dev;
-		goto sendit;
-	}
-
-	/* On a PPP link we neither compress nor aarp.  */
-	if (dev->type == ARPHRD_PPP) {
-		skb->protocol = htons(ETH_P_PPPTALK);
-		skb->dev = dev;
-		goto sendit;
-	}
-
 	/* Non ELAP we cannot do. */
 	if (dev->type != ARPHRD_ETHER)
 		goto free_it;
@@ -659,22 +575,12 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 out_unlock:
 	write_unlock_bh(&aarp_lock);
 
-	/* Tell the ddp layer we have taken over for this frame. */
-	goto sent;
-
-sendit:
-	if (skb->sk)
-		skb->priority = READ_ONCE(skb->sk->sk_priority);
-	if (dev_queue_xmit(skb))
-		goto drop;
 sent:
 	return NET_XMIT_SUCCESS;
 free_it:
 	kfree_skb(skb);
-drop:
 	return NET_XMIT_DROP;
 }
-EXPORT_SYMBOL(aarp_send_ddp);
 
 /*
  *	An entry in the aarp unresolved queue has become resolved. Send
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 8978fb6212ffb..9fe344b08dc8b 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -473,7 +473,7 @@ static struct atalk_route *atrtr_find(struct atalk_addr *target)
  * Given an AppleTalk network, find the device to use. This can be
  * a simple lookup.
  */
-struct net_device *atrtr_get_dev(struct atalk_addr *sa)
+static struct net_device *atrtr_get_dev(struct atalk_addr *sa)
 {
 	struct atalk_route *atr = atrtr_find(sa);
 	return atr ? atr->dev : NULL;
@@ -683,9 +683,7 @@ static int atif_ioctl(int cmd, void __user *arg)
 		if (sa->sat_family != AF_APPLETALK)
 			return -EINVAL;
 		if (dev->type != ARPHRD_ETHER &&
-		    dev->type != ARPHRD_LOOPBACK &&
-		    dev->type != ARPHRD_LOCALTLK &&
-		    dev->type != ARPHRD_PPP)
+		    dev->type != ARPHRD_LOOPBACK)
 			return -EPROTONOSUPPORT;
 
 		nr = (struct atalk_netrange *)&sa->sat_zero[0];
@@ -1327,18 +1325,8 @@ static int atalk_route_packet(struct sk_buff *skb, struct net_device *dev,
 	 * Don't route multicast, etc., packets, or packets sent to "this
 	 * network"
 	 */
-	if (skb->pkt_type != PACKET_HOST || !ddp->deh_dnet) {
-		/*
-		 * FIXME:
-		 *
-		 * Can it ever happen that a packet is from a PPP iface and
-		 * needs to be broadcast onto the default network?
-		 */
-		if (dev->type == ARPHRD_PPP)
-			printk(KERN_DEBUG "AppleTalk: didn't forward broadcast "
-					  "packet received from PPP iface\n");
+	if (skb->pkt_type != PACKET_HOST || !ddp->deh_dnet)
 		goto free_it;
-	}
 
 	ta.s_net  = ddp->deh_dnet;
 	ta.s_node = ddp->deh_dnode;
@@ -1508,64 +1496,6 @@ static int atalk_rcv(struct sk_buff *skb, struct net_device *dev,
 
 }
 
-/*
- * Receive a LocalTalk frame. We make some demands on the caller here.
- * Caller must provide enough headroom on the packet to pull the short
- * header and append a long one.
- */
-static int ltalk_rcv(struct sk_buff *skb, struct net_device *dev,
-		     struct packet_type *pt, struct net_device *orig_dev)
-{
-	if (!net_eq(dev_net(dev), &init_net))
-		goto freeit;
-
-	/* Expand any short form frames */
-	if (skb_mac_header(skb)[2] == 1) {
-		struct ddpehdr *ddp;
-		/* Find our address */
-		struct atalk_addr *ap = atalk_find_dev_addr(dev);
-
-		if (!ap || skb->len < sizeof(__be16) || skb->len > 1023)
-			goto freeit;
-
-		/* Don't mangle buffer if shared */
-		if (!(skb = skb_share_check(skb, GFP_ATOMIC)))
-			return 0;
-
-		/*
-		 * The push leaves us with a ddephdr not an shdr, and
-		 * handily the port bytes in the right place preset.
-		 */
-		ddp = skb_push(skb, sizeof(*ddp) - 4);
-
-		/* Now fill in the long header */
-
-		/*
-		 * These two first. The mac overlays the new source/dest
-		 * network information so we MUST copy these before
-		 * we write the network numbers !
-		 */
-
-		ddp->deh_dnode = skb_mac_header(skb)[0];     /* From physical header */
-		ddp->deh_snode = skb_mac_header(skb)[1];     /* From physical header */
-
-		ddp->deh_dnet  = ap->s_net;	/* Network number */
-		ddp->deh_snet  = ap->s_net;
-		ddp->deh_sum   = 0;		/* No checksum */
-		/*
-		 * Not sure about this bit...
-		 */
-		/* Non routable, so force a drop if we slip up later */
-		ddp->deh_len_hops = htons(skb->len + (DDP_MAXHOPS << 10));
-	}
-	skb_reset_transport_header(skb);
-
-	return atalk_rcv(skb, dev, pt, orig_dev);
-freeit:
-	kfree_skb(skb);
-	return 0;
-}
-
 static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
@@ -1935,22 +1865,8 @@ static struct notifier_block ddp_notifier = {
 	.notifier_call	= ddp_device_event,
 };
 
-static struct packet_type ltalk_packet_type __read_mostly = {
-	.type		= cpu_to_be16(ETH_P_LOCALTALK),
-	.func		= ltalk_rcv,
-};
-
-static struct packet_type ppptalk_packet_type __read_mostly = {
-	.type		= cpu_to_be16(ETH_P_PPPTALK),
-	.func		= atalk_rcv,
-};
-
 static unsigned char ddp_snap_id[] = { 0x08, 0x00, 0x07, 0x80, 0x9B };
 
-/* Export symbols for use by drivers when AppleTalk is a module */
-EXPORT_SYMBOL(atrtr_get_dev);
-EXPORT_SYMBOL(atalk_find_dev_addr);
-
 /* Called by proto.c on kernel start up */
 static int __init atalk_init(void)
 {
@@ -1971,9 +1887,6 @@ static int __init atalk_init(void)
 		goto out_sock;
 	}
 
-	dev_add_pack(&ltalk_packet_type);
-	dev_add_pack(&ppptalk_packet_type);
-
 	rc = register_netdevice_notifier(&ddp_notifier);
 	if (rc)
 		goto out_snap;
@@ -1998,8 +1911,6 @@ static int __init atalk_init(void)
 out_dev:
 	unregister_netdevice_notifier(&ddp_notifier);
 out_snap:
-	dev_remove_pack(&ppptalk_packet_type);
-	dev_remove_pack(&ltalk_packet_type);
 	unregister_snap_client(ddp_dl);
 out_sock:
 	sock_unregister(PF_APPLETALK);
@@ -2026,8 +1937,6 @@ static void __exit atalk_exit(void)
 	atalk_proc_exit();
 	aarp_cleanup_module();	/* General aarp clean-up. */
 	unregister_netdevice_notifier(&ddp_notifier);
-	dev_remove_pack(&ltalk_packet_type);
-	dev_remove_pack(&ppptalk_packet_type);
 	unregister_snap_client(ddp_dl);
 	sock_unregister(PF_APPLETALK);
 	proto_unregister(&ddp_proto);
diff --git a/net/appletalk/dev.c b/net/appletalk/dev.c
deleted file mode 100644
index 284c8e585533a..0000000000000
--- a/net/appletalk/dev.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Moved here from drivers/net/net_init.c, which is:
- *	Written 1993,1994,1995 by Donald Becker.
- */
-
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/if_ltalk.h>
-
-static void ltalk_setup(struct net_device *dev)
-{
-	/* Fill in the fields of the device structure with localtalk-generic values. */
-
-	dev->type		= ARPHRD_LOCALTLK;
-	dev->hard_header_len 	= LTALK_HLEN;
-	dev->mtu		= LTALK_MTU;
-	dev->addr_len		= LTALK_ALEN;
-	dev->tx_queue_len	= 10;
-
-	dev->broadcast[0]	= 0xFF;
-
-	dev->flags		= IFF_BROADCAST|IFF_MULTICAST|IFF_NOARP;
-}
-
-/**
- * alloc_ltalkdev - Allocates and sets up an localtalk device
- * @sizeof_priv: Size of additional driver-private structure to be allocated
- *	for this localtalk device
- *
- * Fill in the fields of the device structure with localtalk-generic
- * values. Basically does everything except registering the device.
- *
- * Constructs a new net device, complete with a private data area of
- * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
- * this private data area.
- */
-
-struct net_device *alloc_ltalkdev(int sizeof_priv)
-{
-	return alloc_netdev(sizeof_priv, "lt%d", NET_NAME_UNKNOWN,
-			    ltalk_setup);
-}
-EXPORT_SYMBOL(alloc_ltalkdev);
-- 
2.39.2

