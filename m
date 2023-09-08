Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B1798D36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjIHSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjIHSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619C1FF9;
        Fri,  8 Sep 2023 11:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9A9C4AF1E;
        Fri,  8 Sep 2023 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197019;
        bh=XT9xMyns9QnhkeTCUOBggElN3V8FvnfkTRYjXDmY+Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNHo7CKAR2zb4MBgW8pYX7NK/sIqj71HmdG8m3NKlPme9+h1D06J17ccF8VlbGo1m
         8W26OU96CEY39dkqlwl47KwErjv2BJt0epdagyjRYpc06Qq4vZi5UnKN5S2x1ugnAh
         M9L798FwjpABRXRYZm/NTyZrcSmT6sngaOeOQbdgAKUIT/np6sUz4mIJ1NpQmWfr7t
         E/iRWVtiJ6vtYSdSL3MvE5gotQZSYjvf9CQachm4u1fKF7RE1ql81q8uk1e9DCzgWm
         cYVQHmjQ0gT4SZnbaJneki8FLxLWOCDdmAlZeoJE0bH1LFQE7O0AGWmphii1WgAYNt
         K/r1mPwmxPIOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Simon Horman <horms@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, keescook@chromium.org,
        anjali.k.kulkarni@oracle.com, fw@strlen.de,
        chentao.kernel@linux.alibaba.com, kuniyu@amazon.com,
        Liam.Howlett@oracle.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 24/41] netlink: convert nlk->flags to atomic flags
Date:   Fri,  8 Sep 2023 14:15:38 -0400
Message-Id: <20230908181555.3459640-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8fe08d70a2b61b35a0a1235c78cf321e7528351f ]

sk_diag_put_flags(), netlink_setsockopt(), netlink_getsockopt()
and others use nlk->flags without correct locking.

Use set_bit(), clear_bit(), test_bit(), assign_bit() to remove
data-races.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 90 ++++++++++++++--------------------------
 net/netlink/af_netlink.h | 22 ++++++----
 net/netlink/diag.c       | 10 ++---
 3 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 5968b6450d828..4cbe6df6ac36f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -84,7 +84,7 @@ struct listeners {
 
 static inline int netlink_is_kernel(struct sock *sk)
 {
-	return nlk_sk(sk)->flags & NETLINK_F_KERNEL_SOCKET;
+	return nlk_test_bit(KERNEL_SOCKET, sk);
 }
 
 struct netlink_table *nl_table __read_mostly;
@@ -349,9 +349,7 @@ static void netlink_deliver_tap_kernel(struct sock *dst, struct sock *src,
 
 static void netlink_overrun(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
+	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
 			sk->sk_err = ENOBUFS;
@@ -1402,9 +1400,7 @@ EXPORT_SYMBOL_GPL(netlink_has_listeners);
 
 bool netlink_strict_get_check(struct sk_buff *skb)
 {
-	const struct netlink_sock *nlk = nlk_sk(NETLINK_CB(skb).sk);
-
-	return nlk->flags & NETLINK_F_STRICT_CHK;
+	return nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 }
 EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 
@@ -1448,7 +1444,7 @@ static void do_one_broadcast(struct sock *sk,
 		return;
 
 	if (!net_eq(sock_net(sk), p->net)) {
-		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
+		if (!nlk_test_bit(LISTEN_ALL_NSID, sk))
 			return;
 
 		if (!peernet_has_id(sock_net(sk), p->net))
@@ -1481,7 +1477,7 @@ static void do_one_broadcast(struct sock *sk,
 		netlink_overrun(sk);
 		/* Clone failed. Notify ALL listeners. */
 		p->failure = 1;
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 		goto out;
 	}
@@ -1496,7 +1492,7 @@ static void do_one_broadcast(struct sock *sk,
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-		if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+		if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 			p->delivery_failure = 1;
 	} else {
 		p->congested |= val;
@@ -1576,7 +1572,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 	    !test_bit(p->group - 1, nlk->groups))
 		goto out;
 
-	if (p->code == ENOBUFS && nlk->flags & NETLINK_F_RECV_NO_ENOBUFS) {
+	if (p->code == ENOBUFS && nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		ret = 1;
 		goto out;
 	}
@@ -1643,7 +1639,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int val = 0;
-	int err;
+	int nr = -1;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1654,14 +1650,12 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (val)
-			nlk->flags |= NETLINK_F_RECV_PKTINFO;
-		else
-			nlk->flags &= ~NETLINK_F_RECV_PKTINFO;
-		err = 0;
+		nr = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
+		int err;
+
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
 			return -EPERM;
 		err = netlink_realloc_groups(sk);
@@ -1681,61 +1675,38 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
 			nlk->netlink_unbind(sock_net(sk), val);
 
-		err = 0;
 		break;
 	}
 	case NETLINK_BROADCAST_ERROR:
-		if (val)
-			nlk->flags |= NETLINK_F_BROADCAST_SEND_ERROR;
-		else
-			nlk->flags &= ~NETLINK_F_BROADCAST_SEND_ERROR;
-		err = 0;
+		nr = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
+		assign_bit(NETLINK_F_RECV_NO_ENOBUFS, &nlk->flags, val);
 		if (val) {
-			nlk->flags |= NETLINK_F_RECV_NO_ENOBUFS;
 			clear_bit(NETLINK_S_CONGESTED, &nlk->state);
 			wake_up_interruptible(&nlk->wait);
-		} else {
-			nlk->flags &= ~NETLINK_F_RECV_NO_ENOBUFS;
 		}
-		err = 0;
 		break;
 	case NETLINK_LISTEN_ALL_NSID:
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_BROADCAST))
 			return -EPERM;
-
-		if (val)
-			nlk->flags |= NETLINK_F_LISTEN_ALL_NSID;
-		else
-			nlk->flags &= ~NETLINK_F_LISTEN_ALL_NSID;
-		err = 0;
+		nr = NETLINK_F_LISTEN_ALL_NSID;
 		break;
 	case NETLINK_CAP_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_CAP_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_CAP_ACK;
-		err = 0;
+		nr = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (val)
-			nlk->flags |= NETLINK_F_EXT_ACK;
-		else
-			nlk->flags &= ~NETLINK_F_EXT_ACK;
-		err = 0;
+		nr = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (val)
-			nlk->flags |= NETLINK_F_STRICT_CHK;
-		else
-			nlk->flags &= ~NETLINK_F_STRICT_CHK;
-		err = 0;
+		nr = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+	if (nr >= 0)
+		assign_bit(nr, &nlk->flags, val);
+	return 0;
 }
 
 static int netlink_getsockopt(struct socket *sock, int level, int optname,
@@ -1802,7 +1773,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		return -EINVAL;
 
 	len = sizeof(int);
-	val = nlk->flags & flag ? 1 : 0;
+	val = test_bit(flag, &nlk->flags);
 
 	if (put_user(len, optlen) ||
 	    copy_to_user(optval, &val, len))
@@ -1979,9 +1950,9 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		msg->msg_namelen = sizeof(*addr);
 	}
 
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		netlink_cmsg_recv_pktinfo(msg, skb);
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		netlink_cmsg_listen_all_nsid(sk, msg, skb);
 
 	memset(&scm, 0, sizeof(scm));
@@ -2058,7 +2029,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		goto out_sock_release;
 
 	nlk = nlk_sk(sk);
-	nlk->flags |= NETLINK_F_KERNEL_SOCKET;
+	set_bit(NETLINK_F_KERNEL_SOCKET, &nlk->flags);
 
 	netlink_table_grab();
 	if (!nl_table[unit].registered) {
@@ -2192,7 +2163,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	nl_dump_check_consistent(cb, nlh);
 	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno, sizeof(nlk->dump_done_errno));
 
-	if (extack->_msg && nlk->flags & NETLINK_F_EXT_ACK) {
+	if (extack->_msg && test_bit(NETLINK_F_EXT_ACK, &nlk->flags)) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
 			nlmsg_end(skb, nlh);
@@ -2321,8 +2292,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			 const struct nlmsghdr *nlh,
 			 struct netlink_dump_control *control)
 {
-	struct netlink_sock *nlk, *nlk2;
 	struct netlink_callback *cb;
+	struct netlink_sock *nlk;
 	struct sock *sk;
 	int ret;
 
@@ -2357,8 +2328,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	cb->min_dump_alloc = control->min_dump_alloc;
 	cb->skb = skb;
 
-	nlk2 = nlk_sk(NETLINK_CB(skb).sk);
-	cb->strict_check = !!(nlk2->flags & NETLINK_F_STRICT_CHK);
+	cb->strict_check = nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
 
 	if (control->start) {
 		ret = control->start(cb);
@@ -2400,7 +2370,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 {
 	size_t tlvlen;
 
-	if (!extack || !(nlk->flags & NETLINK_F_EXT_ACK))
+	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
 		return 0;
 
 	tlvlen = 0;
@@ -2472,7 +2442,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-	if (err && !(nlk->flags & NETLINK_F_CAP_ACK))
+	if (err && !test_bit(NETLINK_F_CAP_ACK, &nlk->flags))
 		payload += nlmsg_len(nlh);
 	else
 		flags |= NLM_F_CAPPED;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 90a3198a9b7f7..3dbd38aef50a4 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -8,14 +8,16 @@
 #include <net/sock.h>
 
 /* flags */
-#define NETLINK_F_KERNEL_SOCKET		0x1
-#define NETLINK_F_RECV_PKTINFO		0x2
-#define NETLINK_F_BROADCAST_SEND_ERROR	0x4
-#define NETLINK_F_RECV_NO_ENOBUFS	0x8
-#define NETLINK_F_LISTEN_ALL_NSID	0x10
-#define NETLINK_F_CAP_ACK		0x20
-#define NETLINK_F_EXT_ACK		0x40
-#define NETLINK_F_STRICT_CHK		0x80
+enum {
+	NETLINK_F_KERNEL_SOCKET,
+	NETLINK_F_RECV_PKTINFO,
+	NETLINK_F_BROADCAST_SEND_ERROR,
+	NETLINK_F_RECV_NO_ENOBUFS,
+	NETLINK_F_LISTEN_ALL_NSID,
+	NETLINK_F_CAP_ACK,
+	NETLINK_F_EXT_ACK,
+	NETLINK_F_STRICT_CHK,
+};
 
 #define NLGRPSZ(x)	(ALIGN(x, sizeof(unsigned long) * 8) / 8)
 #define NLGRPLONGS(x)	(NLGRPSZ(x)/sizeof(unsigned long))
@@ -23,10 +25,10 @@
 struct netlink_sock {
 	/* struct sock has to be the first member of netlink_sock */
 	struct sock		sk;
+	unsigned long		flags;
 	u32			portid;
 	u32			dst_portid;
 	u32			dst_group;
-	u32			flags;
 	u32			subscriptions;
 	u32			ngroups;
 	unsigned long		*groups;
@@ -54,6 +56,8 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
 	return container_of(sk, struct netlink_sock, sk);
 }
 
+#define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
+
 struct netlink_table {
 	struct rhashtable	hash;
 	struct hlist_head	mc_list;
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e4f21b1067bcc..9c4f231be2757 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -27,15 +27,15 @@ static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
 
 	if (nlk->cb_running)
 		flags |= NDIAG_FLAG_CB_RUNNING;
-	if (nlk->flags & NETLINK_F_RECV_PKTINFO)
+	if (nlk_test_bit(RECV_PKTINFO, sk))
 		flags |= NDIAG_FLAG_PKTINFO;
-	if (nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR)
+	if (nlk_test_bit(BROADCAST_SEND_ERROR, sk))
 		flags |= NDIAG_FLAG_BROADCAST_ERROR;
-	if (nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)
+	if (nlk_test_bit(RECV_NO_ENOBUFS, sk))
 		flags |= NDIAG_FLAG_NO_ENOBUFS;
-	if (nlk->flags & NETLINK_F_LISTEN_ALL_NSID)
+	if (nlk_test_bit(LISTEN_ALL_NSID, sk))
 		flags |= NDIAG_FLAG_LISTEN_ALL_NSID;
-	if (nlk->flags & NETLINK_F_CAP_ACK)
+	if (nlk_test_bit(CAP_ACK, sk))
 		flags |= NDIAG_FLAG_CAP_ACK;
 
 	return nla_put_u32(skb, NETLINK_DIAG_FLAGS, flags);
-- 
2.40.1

