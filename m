Return-Path: <linux-kernel+bounces-121529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F188E93D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B11C2E0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19F149C48;
	Wed, 27 Mar 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae729x8m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523561304A7;
	Wed, 27 Mar 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553134; cv=none; b=WAuXQ0Um0uhz56UOaDa1KJxwyz9WXRPXkkPkg4D/H/c5shd9YVJ4ntWkVKNKhmv3bt5LXWwMTLjU5hvGbdJkD1laxidveMMPK8/IoJmWgP7My0afkriAulkGDSHY7Yb9bsDK/rt63cu318AXZTraOu/au17Xs4HfVRE+f018AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553134; c=relaxed/simple;
	bh=SM/Y4i2PvzK59BicbBlf0+j7v97Q3/Neb7MphCaY43s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+ocB5N6c2lRWaN3Ik4KiCnYXSRcvJY5otNE4o2FCZf9a/LEL5cOs2TpxM5BoXsqIUMgHbNesCTN98or+DuiPjuyPkSazJ/m/A+tXKI/j9raSjoffTX+g+D0CNV26iAawa4u9X9p5K4+Sydc32lEqLHWoAlJ6dZWudEYcRBmaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae729x8m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553132; x=1743089132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SM/Y4i2PvzK59BicbBlf0+j7v97Q3/Neb7MphCaY43s=;
  b=ae729x8m7kcDGmGXTqYryDUs/WgfmxPo/emTUGP7FC2Zg+b7U4LRXPuz
   ZUkDocYgDK/SPnmeXTDuKlUhL9EU238aiTQJFV+rEhzjcmRCx/U+drdbE
   84dI5Fbe78Cb5V7OwCeKjESd4BTdJY98uuS+dqTJQ7HuQNvlVnBR9WLWm
   zcG6W989NlhY+8hIrHx+uccOde5Cc2+woCpqg7YJowCuQ2WMS7c3rUyh7
   9zqIQt6rNUaaWFc4G4lVb7Pc1YmpI7lD7HTbvNY1ucke7s7GYn9I3r3BV
   nydtceLx7Z9BKj/dTfPlDznj6seXuMDwPPrS7fADtPYE5NObZR918swjS
   Q==;
X-CSE-ConnectionGUID: 6MimCK4BQnmJLMkQa4FpnA==
X-CSE-MsgGUID: 8ddXyaymQrKYOSWfpk9EbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518277"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518277"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414395"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:28 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 18/21] pfcp: add PFCP module
Date: Wed, 27 Mar 2024 16:23:55 +0100
Message-ID: <20240327152358.2368467-19-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

Packet Forwarding Control Protocol (PFCP) is a 3GPP Protocol
used between the control plane and the user plane function.
It is specified in TS 29.244[1].

Note that this module is not designed to support this Protocol
in the kernel space. There is no support for parsing any PFCP messages.
There is no API that could be used by any userspace daemon.
Basically it does not support PFCP. This protocol is sophisticated
and there is no need for implementing it in the kernel. The purpose
of this module is to allow users to setup software and hardware offload
of PFCP packets using tc tool.

When user requests to create a PFCP device, a new socket is created.
The socket is set up with port number 8805 which is specific for
PFCP [29.244 4.2.2]. This allow to receive PFCP request messages,
response messages use other ports.

Note that only one PFCP netdev can be created.

Only IPv4 is supported at this time.

[1] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/Kconfig  |  13 +++
 drivers/net/Makefile |   1 +
 include/net/pfcp.h   |  17 ++++
 drivers/net/pfcp.c   | 223 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 include/net/pfcp.h
 create mode 100644 drivers/net/pfcp.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ca0bc223b30..172d84e39129 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -290,6 +290,19 @@ config GTP
 	  To compile this drivers as a module, choose M here: the module
 	  will be called gtp.
 
+config PFCP
+	tristate "Packet Forwarding Control Protocol (PFCP)"
+	depends on INET
+	select NET_UDP_TUNNEL
+	help
+	  This allows one to create PFCP virtual interfaces that allows to
+	  set up software and hardware offload of PFCP packets.
+	  Note that this module does not support PFCP protocol in the kernel space.
+	  There is no support for parsing any PFCP messages.
+
+	  To compile this drivers as a module, choose M here: the module
+	  will be called pfcp.
+
 config AMT
 	tristate "Automatic Multicast Tunneling (AMT)"
 	depends on INET && IP_MULTICAST
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 7cab36f94782..9c053673d6b2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
 obj-$(CONFIG_GTP) += gtp.o
 obj-$(CONFIG_NLMON) += nlmon.o
+obj-$(CONFIG_PFCP) += pfcp.o
 obj-$(CONFIG_NET_VRF) += vrf.o
 obj-$(CONFIG_VSOCKMON) += vsockmon.o
 obj-$(CONFIG_MHI_NET) += mhi_net.o
diff --git a/include/net/pfcp.h b/include/net/pfcp.h
new file mode 100644
index 000000000000..3f9ebf27a8ff
--- /dev/null
+++ b/include/net/pfcp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PFCP_H_
+#define _PFCP_H_
+
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define PFCP_PORT 8805
+
+static inline bool netif_is_pfcp(const struct net_device *dev)
+{
+	return dev->rtnl_link_ops &&
+	       !strcmp(dev->rtnl_link_ops->kind, "pfcp");
+}
+
+#endif
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
new file mode 100644
index 000000000000..3f1ee0ae7111
--- /dev/null
+++ b/drivers/net/pfcp.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PFCP according to 3GPP TS 29.244
+ *
+ * Copyright (C) 2022, Intel Corporation.
+ */
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rculist.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include <net/udp.h>
+#include <net/udp_tunnel.h>
+#include <net/pfcp.h>
+
+struct pfcp_dev {
+	struct list_head	list;
+
+	struct socket		*sock;
+	struct net_device	*dev;
+	struct net		*net;
+};
+
+static unsigned int pfcp_net_id __read_mostly;
+
+struct pfcp_net {
+	struct list_head	pfcp_dev_list;
+};
+
+static void pfcp_del_sock(struct pfcp_dev *pfcp)
+{
+	udp_tunnel_sock_release(pfcp->sock);
+	pfcp->sock = NULL;
+}
+
+static void pfcp_dev_uninit(struct net_device *dev)
+{
+	struct pfcp_dev *pfcp = netdev_priv(dev);
+
+	pfcp_del_sock(pfcp);
+}
+
+static int pfcp_dev_init(struct net_device *dev)
+{
+	struct pfcp_dev *pfcp = netdev_priv(dev);
+
+	pfcp->dev = dev;
+
+	return 0;
+}
+
+static const struct net_device_ops pfcp_netdev_ops = {
+	.ndo_init		= pfcp_dev_init,
+	.ndo_uninit		= pfcp_dev_uninit,
+	.ndo_get_stats64	= dev_get_tstats64,
+};
+
+static const struct device_type pfcp_type = {
+	.name = "pfcp",
+};
+
+static void pfcp_link_setup(struct net_device *dev)
+{
+	dev->netdev_ops = &pfcp_netdev_ops;
+	dev->needs_free_netdev = true;
+	SET_NETDEV_DEVTYPE(dev, &pfcp_type);
+
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	netif_keep_dst(dev);
+}
+
+static struct socket *pfcp_create_sock(struct pfcp_dev *pfcp)
+{
+	struct udp_tunnel_sock_cfg tuncfg = {};
+	struct udp_port_cfg udp_conf = {
+		.local_ip.s_addr	= htonl(INADDR_ANY),
+		.family			= AF_INET,
+	};
+	struct net *net = pfcp->net;
+	struct socket *sock;
+	int err;
+
+	udp_conf.local_udp_port = htons(PFCP_PORT);
+
+	err = udp_sock_create(net, &udp_conf, &sock);
+	if (err)
+		return ERR_PTR(err);
+
+	setup_udp_tunnel_sock(net, sock, &tuncfg);
+
+	return sock;
+}
+
+static int pfcp_add_sock(struct pfcp_dev *pfcp)
+{
+	pfcp->sock = pfcp_create_sock(pfcp);
+
+	return PTR_ERR_OR_ZERO(pfcp->sock);
+}
+
+static int pfcp_newlink(struct net *net, struct net_device *dev,
+			struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	struct pfcp_dev *pfcp = netdev_priv(dev);
+	struct pfcp_net *pn;
+	int err;
+
+	pfcp->net = net;
+
+	err = pfcp_add_sock(pfcp);
+	if (err) {
+		netdev_dbg(dev, "failed to add pfcp socket %d\n", err);
+		goto exit_err;
+	}
+
+	err = register_netdevice(dev);
+	if (err) {
+		netdev_dbg(dev, "failed to register pfcp netdev %d\n", err);
+		goto exit_del_pfcp_sock;
+	}
+
+	pn = net_generic(dev_net(dev), pfcp_net_id);
+	list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
+
+	netdev_dbg(dev, "registered new PFCP interface\n");
+
+	return 0;
+
+exit_del_pfcp_sock:
+	pfcp_del_sock(pfcp);
+exit_err:
+	pfcp->net = NULL;
+	return err;
+}
+
+static void pfcp_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct pfcp_dev *pfcp = netdev_priv(dev);
+
+	list_del_rcu(&pfcp->list);
+	unregister_netdevice_queue(dev, head);
+}
+
+static struct rtnl_link_ops pfcp_link_ops __read_mostly = {
+	.kind		= "pfcp",
+	.priv_size	= sizeof(struct pfcp_dev),
+	.setup		= pfcp_link_setup,
+	.newlink	= pfcp_newlink,
+	.dellink	= pfcp_dellink,
+};
+
+static int __net_init pfcp_net_init(struct net *net)
+{
+	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
+
+	INIT_LIST_HEAD(&pn->pfcp_dev_list);
+	return 0;
+}
+
+static void __net_exit pfcp_net_exit(struct net *net)
+{
+	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
+	struct pfcp_dev *pfcp;
+	LIST_HEAD(list);
+
+	rtnl_lock();
+	list_for_each_entry(pfcp, &pn->pfcp_dev_list, list)
+		pfcp_dellink(pfcp->dev, &list);
+
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+}
+
+static struct pernet_operations pfcp_net_ops = {
+	.init	= pfcp_net_init,
+	.exit	= pfcp_net_exit,
+	.id	= &pfcp_net_id,
+	.size	= sizeof(struct pfcp_net),
+};
+
+static int __init pfcp_init(void)
+{
+	int err;
+
+	err = register_pernet_subsys(&pfcp_net_ops);
+	if (err)
+		goto exit_err;
+
+	err = rtnl_link_register(&pfcp_link_ops);
+	if (err)
+		goto exit_unregister_subsys;
+	return 0;
+
+exit_unregister_subsys:
+	unregister_pernet_subsys(&pfcp_net_ops);
+exit_err:
+	pr_err("loading PFCP module failed: err %d\n", err);
+	return err;
+}
+late_initcall(pfcp_init);
+
+static void __exit pfcp_exit(void)
+{
+	rtnl_link_unregister(&pfcp_link_ops);
+	unregister_pernet_subsys(&pfcp_net_ops);
+
+	pr_info("PFCP module unloaded\n");
+}
+module_exit(pfcp_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wojciech Drewek <wojciech.drewek@intel.com>");
+MODULE_DESCRIPTION("Interface driver for PFCP encapsulated traffic");
+MODULE_ALIAS_RTNL_LINK("pfcp");
-- 
2.44.0


