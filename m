Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0837D3B96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjJWQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:24 -0400
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B810C0;
        Mon, 23 Oct 2023 09:00:20 -0700 (PDT)
Received: janet.servers.dxld.at; Mon, 23 Oct 2023 18:00:15 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [PATCH] wireguard: Add netlink attrs for binding to address and netdev
Date:   Mon, 23 Oct 2023 18:00:06 +0200
Message-Id: <20231023160006.85992-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multihomed hosts may want to run distinct wg tunnels across all their
uplinks for redundant connectivity. Currently this entails picking
different ports for each wg tunnel since we allow only binding to the
wildcard address. Sharing a single port-number for all uplink
connections (but bound to a particular IP/netdev) simplifies managment
considerably.

A closely related use-case that also touches the socket binding code is
having a wg socket be part of a VRF. This mirrors how we support socket and
wg device in distinct namespaces. To make using VRFs with wg easy we want
to be able to bind to a particular device as this will cause the kernel to
automatically route all outgoing packets with the VRF's routing table
and (in the default udp_l3mdev_accept=0 config) only accept packets from
interfaces in the VRF without the need for netfilter rules.

While users can currently use VRFs for wg tunnel traffic by configuring
fwmark ip-rules and setting sysctl udp_l3mdev_accept=1 (with or without
additional nft filtering) this is at best a cludge. When VRF membership
changes it becomes a major hassle to keep ip-rules up to date.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 drivers/net/wireguard/device.c  |  4 +--
 drivers/net/wireguard/device.h  |  3 +-
 drivers/net/wireguard/netlink.c | 51 ++++++++++++++++++++++++++++-----
 drivers/net/wireguard/socket.c  | 41 +++++++++++++++++---------
 drivers/net/wireguard/socket.h  |  3 +-
 include/uapi/linux/wireguard.h  |  6 ++++
 6 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 258dcc103921..fdaaf0238a49 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -48,7 +48,7 @@ static int wg_open(struct net_device *dev)
 		dev_v6->cnf.addr_gen_mode = IN6_ADDR_GEN_MODE_NONE;
 
 	mutex_lock(&wg->device_update_lock);
-	ret = wg_socket_init(wg, wg->incoming_port);
+	ret = wg_socket_init(wg, wg->port_cfg);
 	if (ret < 0)
 		goto out;
 	list_for_each_entry(peer, &wg->peer_list, peer_list) {
@@ -249,7 +249,7 @@ static void wg_destruct(struct net_device *dev)
 	rtnl_unlock();
 	mutex_lock(&wg->device_update_lock);
 	rcu_assign_pointer(wg->creating_net, NULL);
-	wg->incoming_port = 0;
+	memzero_explicit(&wg->port_cfg, sizeof(wg->port_cfg));
 	wg_socket_reinit(wg, NULL, NULL);
 	/* The final references are cleared in the below calls to destroy_workqueue. */
 	wg_peer_remove_all(wg);
diff --git a/drivers/net/wireguard/device.h b/drivers/net/wireguard/device.h
index 43c7cebbf50b..ac4092d8c9d0 100644
--- a/drivers/net/wireguard/device.h
+++ b/drivers/net/wireguard/device.h
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/net.h>
 #include <linux/ptr_ring.h>
+#include <net/udp_tunnel.h>
 
 struct wg_device;
 
@@ -53,7 +54,7 @@ struct wg_device {
 	atomic_t handshake_queue_len;
 	unsigned int num_peers, device_update_gen;
 	u32 fwmark;
-	u16 incoming_port;
+	struct udp_port_cfg port_cfg;
 };
 
 int wg_device_init(void);
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index dc09b75a3248..28e5b8668e72 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -26,6 +26,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
+	[WGDEVICE_A_LISTEN_ADDR]	= NLA_POLICY_MIN_LEN(sizeof(struct in_addr)),
+	[WGDEVICE_A_LISTEN_IFINDEX]	= { .type = NLA_U32 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
 	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
 };
@@ -230,11 +232,20 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 	if (!ctx->next_peer) {
 		if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
-				wg->incoming_port) ||
+				ntohs(wg->port_cfg.local_udp_port)) ||
+		    nla_put_u32(skb, WGDEVICE_A_LISTEN_IFINDEX, wg->port_cfg.bind_ifindex) ||
 		    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
 		    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
 		    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
 			goto out;
+	        if (wg->port_cfg.family == AF_INET &&
+		    nla_put_in_addr(skb, WGDEVICE_A_LISTEN_ADDR,
+				    wg->port_cfg.local_ip.s_addr))
+				goto out;
+	        if (wg->port_cfg.family == AF_INET6 &&
+		    nla_put_in6_addr(skb, WGDEVICE_A_LISTEN_ADDR,
+				     &wg->port_cfg.local_ip6))
+				goto out;
 
 		down_read(&wg->static_identity.lock);
 		if (wg->static_identity.has_identity) {
@@ -311,19 +322,46 @@ static int wg_get_device_done(struct netlink_callback *cb)
 	return 0;
 }
 
-static int set_port(struct wg_device *wg, u16 port)
+static int set_port_cfg(struct wg_device *wg, struct nlattr **attrs)
 {
 	struct wg_peer *peer;
+	struct udp_port_cfg port_cfg = {
+		.family = AF_UNSPEC,
+	};
+
+	if (attrs[WGDEVICE_A_LISTEN_PORT])
+		port_cfg.local_udp_port =
+			htons(nla_get_u16(attrs[WGDEVICE_A_LISTEN_PORT]));
+	if (attrs[WGDEVICE_A_LISTEN_ADDR]) {
+		union {
+			struct in_addr addr4;
+			struct in6_addr addr6;
+		} *u_addr = nla_data(attrs[WGDEVICE_A_LISTEN_ADDR]);
+		size_t len = nla_len(attrs[WGDEVICE_A_LISTEN_ADDR]);
+		if (len == sizeof(struct in_addr)) {
+			port_cfg.family = AF_INET;
+			port_cfg.local_ip = u_addr->addr4;
+		} else if (len == sizeof(struct in6_addr)) {
+			if (!IS_ENABLED(CONFIG_IPV6))
+				return -EAFNOSUPPORT;
+			port_cfg.family = AF_INET6;
+			port_cfg.local_ip6 = u_addr->addr6;
+		}
+	}
+	if (attrs[WGDEVICE_A_LISTEN_IFINDEX]) {
+		port_cfg.bind_ifindex =
+			nla_get_u32(attrs[WGDEVICE_A_LISTEN_IFINDEX]);
+	}
 
-	if (wg->incoming_port == port)
+	if (memcmp(&port_cfg, &wg->port_cfg, sizeof(port_cfg)) == 0)
 		return 0;
 	list_for_each_entry(peer, &wg->peer_list, peer_list)
 		wg_socket_clear_peer_endpoint_src(peer);
 	if (!netif_running(wg->dev)) {
-		wg->incoming_port = port;
+		wg->port_cfg = port_cfg;
 		return 0;
 	}
-	return wg_socket_init(wg, port);
+	return wg_socket_init(wg, port_cfg);
 }
 
 static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
@@ -531,8 +569,7 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[WGDEVICE_A_LISTEN_PORT]) {
-		ret = set_port(wg,
-			nla_get_u16(info->attrs[WGDEVICE_A_LISTEN_PORT]));
+		ret = set_port_cfg(wg, info->attrs);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index c35163f503e7..cbd3958af890 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -346,7 +346,7 @@ static void set_sock_opts(struct socket *sock)
 	sk_set_memalloc(sock->sk);
 }
 
-int wg_socket_init(struct wg_device *wg, u16 port)
+int wg_socket_init(struct wg_device *wg, struct udp_port_cfg port_cfg)
 {
 	struct net *net;
 	int ret;
@@ -356,12 +356,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		.encap_rcv = wg_receive
 	};
 	struct socket *new4 = NULL, *new6 = NULL;
-	struct udp_port_cfg port4 = {
-		.family = AF_INET,
-		.local_ip.s_addr = htonl(INADDR_ANY),
-		.local_udp_port = htons(port),
-		.use_udp_checksums = true
-	};
+	struct udp_port_cfg port4;
 #if IS_ENABLED(CONFIG_IPV6)
 	int retries = 0;
 	struct udp_port_cfg port6 = {
@@ -373,6 +368,23 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	};
 #endif
 
+	if (port_cfg.family == AF_UNSPEC) {
+		port4 = (struct udp_port_cfg) {
+			.family = AF_INET,
+			.local_ip.s_addr = htonl(INADDR_ANY),
+			.local_udp_port = port_cfg.local_udp_port,
+			.use_udp_checksums = true
+		};
+	} else {
+		port4 = port_cfg;
+		port4.use_udp_checksums = true;
+		if (IS_ENABLED(CONFIG_IPV6) && port_cfg.family == AF_INET6) {
+			port4.use_udp6_tx_checksums = true;
+			port4.use_udp6_rx_checksums = true;
+			port4.ipv6_v6only = true;
+		}
+	}
+
 	rcu_read_lock();
 	net = rcu_dereference(wg->creating_net);
 	net = net ? maybe_get_net(net) : NULL;
@@ -380,10 +392,6 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	if (unlikely(!net))
 		return -ENONET;
 
-#if IS_ENABLED(CONFIG_IPV6)
-retry:
-#endif
-
 	ret = udp_sock_create(net, &port4, &new4);
 	if (ret < 0) {
 		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
@@ -392,13 +400,18 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	set_sock_opts(new4);
 	setup_udp_tunnel_sock(net, new4, &cfg);
 
+	if (port_cfg.family != AF_UNSPEC)
+		goto reinit;
+
 #if IS_ENABLED(CONFIG_IPV6)
+retry:
 	if (ipv6_mod_enabled()) {
 		port6.local_udp_port = inet_sk(new4->sk)->inet_sport;
 		ret = udp_sock_create(net, &port6, &new6);
 		if (ret < 0) {
 			udp_tunnel_sock_release(new4);
-			if (ret == -EADDRINUSE && !port && retries++ < 100)
+			if (ret == -EADDRINUSE && !port_cfg.local_udp_port &&
+			    retries++ < 100)
 				goto retry;
 			pr_err("%s: Could not create IPv6 socket\n",
 			       wg->dev->name);
@@ -409,6 +422,8 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	}
 #endif
 
+reinit:
+	wg->port_cfg = port_cfg;
 	wg_socket_reinit(wg, new4->sk, new6 ? new6->sk : NULL);
 	ret = 0;
 out:
@@ -433,8 +448,6 @@ void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
 				lockdep_is_held(&wg->socket_update_lock));
 	rcu_assign_pointer(wg->sock4, new4);
 	rcu_assign_pointer(wg->sock6, new6);
-	if (new4)
-		wg->incoming_port = ntohs(inet_sk(new4)->inet_sport);
 	mutex_unlock(&wg->socket_update_lock);
 	synchronize_net();
 	sock_free(old4);
diff --git a/drivers/net/wireguard/socket.h b/drivers/net/wireguard/socket.h
index bab5848efbcd..1532a263c518 100644
--- a/drivers/net/wireguard/socket.h
+++ b/drivers/net/wireguard/socket.h
@@ -10,8 +10,9 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 #include <linux/if_ether.h>
+#include <net/udp_tunnel.h>
 
-int wg_socket_init(struct wg_device *wg, u16 port);
+int wg_socket_init(struct wg_device *wg, struct udp_port_cfg port);
 void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
 		      struct sock *new6);
 int wg_socket_send_buffer_to_peer(struct wg_peer *peer, void *data,
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index ae88be14c947..240d1c850dfd 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -28,6 +28,8 @@
  *    WGDEVICE_A_PRIVATE_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
  *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
  *    WGDEVICE_A_LISTEN_PORT: NLA_U16
+ *    WGDEVICE_A_LISTEN_ADDR : NLA_MIN_LEN(struct sockaddr), struct sockaddr_in or struct sockaddr_in6
+ *    WGDEVICE_A_LISTEN_IFINDEX : NLA_U32
  *    WGDEVICE_A_FWMARK: NLA_U32
  *    WGDEVICE_A_PEERS: NLA_NESTED
  *        0: NLA_NESTED
@@ -82,6 +84,8 @@
  *                      peers should be removed prior to adding the list below.
  *    WGDEVICE_A_PRIVATE_KEY: len WG_KEY_LEN, all zeros to remove
  *    WGDEVICE_A_LISTEN_PORT: NLA_U16, 0 to choose randomly
+ *    WGDEVICE_A_LISTEN_ADDR : struct sockaddr_in or struct sockaddr_in6.
+ *    WGDEVICE_A_LISTEN_IFINDEX : NLA_U32
  *    WGDEVICE_A_FWMARK: NLA_U32, 0 to disable
  *    WGDEVICE_A_PEERS: NLA_NESTED
  *        0: NLA_NESTED
@@ -157,6 +161,8 @@ enum wgdevice_attribute {
 	WGDEVICE_A_LISTEN_PORT,
 	WGDEVICE_A_FWMARK,
 	WGDEVICE_A_PEERS,
+	WGDEVICE_A_LISTEN_ADDR,
+	WGDEVICE_A_LISTEN_IFINDEX,
 	__WGDEVICE_A_LAST
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
-- 
2.39.2

