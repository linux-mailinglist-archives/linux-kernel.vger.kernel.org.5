Return-Path: <linux-kernel+bounces-71275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98885A2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B234285CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD32E40D;
	Mon, 19 Feb 2024 12:02:23 +0000 (UTC)
Received: from mail.servers.dxld.at (mail.servers.dxld.at [5.9.225.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66632D047;
	Mon, 19 Feb 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.225.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344142; cv=none; b=u80nzP/CRNt3ZdK2pYyrwNyneRO6CpFwwN1oecqO6HlCCDAQJrbu7V/UXDD3D4QIxVNnFLowljuI0fPoLdclSQrWtFGHeQDk/rN5GrsfIN7Wf94AEwFOPUuOxUf4Q8+reWzgBE94X7K4RafZSWgx1drYm3yY7/o3CXNbrZgs2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344142; c=relaxed/simple;
	bh=v6MrV2ST97ZIp+7YLPgttBw6eVt0TC+BjBco4DIeNfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KGNScCkuPJ38mMhfKrEf2/0QKvGGoa5JiEC7DZTMDfLXB1f9bVDA4a1zPeohSM69JiPZzPaNv5wU2myDL4nbTSHnO91HYoDrGZonimGsV5zy8XyC9vWMjkR+68zYf269FJD7n1u+Mih0YL6jGgCtH0VzB1Z7Fq16OZywazsNCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org; spf=pass smtp.mailfrom=darkboxed.org; arc=none smtp.client-ip=5.9.225.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkboxed.org
Received: from dxld by mail.servers.dxld.at with local (Exim 4.96)
	(envelope-from <dxld@darkboxed.org>)
	id 1rc23t-00CpJs-17;
	Mon, 19 Feb 2024 12:43:53 +0100
From: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [PATCH net-next v3] wireguard: Add netlink attrs for binding to address and netdev
Date: Mon, 19 Feb 2024 12:43:34 +0100
Message-Id: <20240219114334.3057169-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently wg sockets are always bound to the wildcard address, this has two
major downsides we care about:

1) It prevents re-using listen one port numbers on different ifaces/IPs.

 Our use case lies in dynamically routed wg mesh networks. Here running one
 wg tunnel with AllowedIPs=::/0[1] per node *pair* is not unusual, but
 needing unique ports across the whole network actually represents a
 tangible scalability concern because as few as n=363 nodes will cause port
 exhaustion since n*(n-1)/2 > 2^16-1.

 [1]: The need to do that comes from the lack of routing daemon support for
   dynamically managing AllowedIPs which in turn is due to poor scalability
   of the current netlink interface.

2) It has been demonstrated that having tunnel underlay and overlay routes
 mixed into one routing table is fraught with peril[2] so it is desirable
 to allow wireguard sockets to bind to a VRF l3mdev to separate the
 two.

 Technically ip-rules hacks could be applied to make this happen but since
 routing table separation is a serious security concern we should make
 doing it right easy.

 [2]: Xue et. al. Bypassing Tunnels: Leaking VPN Client Traffic by Abusing
   Routing Tables.
   https://www.usenix.org/conference/usenixsecurity23/presentation/xue

The implementation is intentionally backwards compatible. Older
wireguard-tools userspace will only show WGDEVICE_A_LISTEN_PORT even when
we're listening on an IP or netdev and omitting the new listen attrs during
set results in a wildcard bound socket as ever.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
Changes in v3:
 - Rewrite commit message

Userspace wireguard-tools patches are here:
  https://lists.zx2c4.com/pipermail/wireguard/2023-October/thread.html#8222
  wg: Support binding to specific addr and iface for multihomed hosts

 drivers/net/wireguard/device.c  |  4 +--
 drivers/net/wireguard/device.h  |  3 +-
 drivers/net/wireguard/netlink.c | 56 ++++++++++++++++++++++++++++-----
 drivers/net/wireguard/socket.c  | 41 +++++++++++++++---------
 drivers/net/wireguard/socket.h  |  3 +-
 include/uapi/linux/wireguard.h  |  6 ++++
 6 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index deb9636b0ecf..ec28f5021791 100644
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
index e220d761b1f2..b0a4bf78982e 100644
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
@@ -230,11 +232,22 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 	if (!ctx->next_peer) {
 		if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
-				wg->incoming_port) ||
+				ntohs(wg->port_cfg.local_udp_port)) ||
+		    nla_put_u32(skb, WGDEVICE_A_LISTEN_IFINDEX, wg->port_cfg.bind_ifindex) ||
 		    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
 		    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
 		    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
 			goto out;
+		if (wg->port_cfg.family == AF_INET &&
+		    nla_put_in_addr(skb, WGDEVICE_A_LISTEN_ADDR,
+				    wg->port_cfg.local_ip.s_addr))
+				goto out;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (wg->port_cfg.family == AF_INET6 &&
+		    nla_put_in6_addr(skb, WGDEVICE_A_LISTEN_ADDR,
+				     &wg->port_cfg.local_ip6))
+				goto out;
+#endif
 
 		down_read(&wg->static_identity.lock);
 		if (wg->static_identity.has_identity) {
@@ -311,19 +324,49 @@ static int wg_get_device_done(struct netlink_callback *cb)
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
+
+		if (len == sizeof(struct in_addr)) {
+			port_cfg.family = AF_INET;
+			port_cfg.local_ip = u_addr->addr4;
+		} else if (len == sizeof(struct in6_addr)) {
+#if IS_ENABLED(CONFIG_IPV6)
+			port_cfg.family = AF_INET6;
+			port_cfg.local_ip6 = u_addr->addr6;
+#else
+			return -EAFNOSUPPORT;
+#endif
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
@@ -531,8 +574,7 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[WGDEVICE_A_LISTEN_PORT]) {
-		ret = set_port(wg,
-			nla_get_u16(info->attrs[WGDEVICE_A_LISTEN_PORT]));
+		ret = set_port_cfg(wg, info->attrs);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..47bb46e0cdd9 100644
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
@@ -428,8 +443,6 @@ void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
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


