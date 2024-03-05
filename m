Return-Path: <linux-kernel+bounces-92214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DB871CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4925A1C21C17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1375A7A5;
	Tue,  5 Mar 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flNMWQrv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE15A7BF;
	Tue,  5 Mar 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636687; cv=none; b=KoAyjNgP7oPn713yimMBe0Wugdo4+Lb9Os2URmgd9kMuICXKRX9mlufBOQEAhV3cWmjyCWb7or+1sG3hBciQJy02j8Ae0vNt6KR9Ghj6LzQMnKMmB1I3oCPGhx0SRRo7dv/Kvjs+1SvPDUJfOxz6n1/GJjSGD/1lcKZj2iW40qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636687; c=relaxed/simple;
	bh=bgIk6inGq4FyMlpZMs4Z8bMwM0OVrGjbDRx+RQWEfuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVCtmmNgUZKTh5NCZPxHw7hw/VyPx3a3qTMHQZF8wU7x4Vx3/3TDUa5E4itAn/ocsfwANN03IIwKMGoOuRiX5wcsc3YfYFUB3STcJYXqJUGIYouIpMHwH9YS1vf/M06J5sQ2WPqsdMj1Ts4UTD6NMjznLXVFpGMFCnltD0W+NcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flNMWQrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAADC433C7;
	Tue,  5 Mar 2024 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636686;
	bh=bgIk6inGq4FyMlpZMs4Z8bMwM0OVrGjbDRx+RQWEfuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=flNMWQrvl9jaNNEJg+U/xijyeTQ1ReqamdY5cDvr4zPpTKNH/NCcxDLs5CfMH/VK9
	 Af/ipwSSRICt3xbwYX2VF6HodOyP1w6cjW3qcf23k7xyMWqum2JOobv/xMV4XNgje7
	 1n6wpVojYwUFwPtmNX7OZAp9vlrUruEt2f8kfY3FszBu/5EVO5GskwJMhltt8DgfEd
	 wM4UpRF2fD4hXEqacNgOp5oiJmcQwWHsnmn4305NnURooGOAhDnrVPSQx7I3+yVwvJ
	 WldKb5+aEcj+tzH31GGLc/DXnW0Pt/hxI0czzt3kGL4oXl4TVEW8T69QyaXhH2f15b
	 TQXdhFf9u5R7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 12:04:31 +0100
Subject: [PATCH net-next 2/4] mptcp: update set_flags interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-2-c436ba5e569b@kernel.org>
References: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8079; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zcfL+hVSRVcd3We9+/Z0qTngvpzqVTGLYq75WGmtTDk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vxD9RxHH517NGulcJm4QVv2TFVc5OipQULtS
 zM2Oo0FPlCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb8QwAKCRD2t4JPQmmg
 c45zEADKvbkg3/8LhNjs1638j70/Sym6rXj0RlLaH/hbGVRajsRsuO2jGIuUSofg0vlzpL2X/Ql
 2GCqohRYkMZJgq70vgRvv+nn37vcEh2X7k1dCXRPrT0NLvDs2iJXepVAnIZJfSOH7WaPbm6MmNf
 LKjJJ8ovqLs6GR5MKdpct7cRZiz2Jyh36F2v2fNY1Oy7C17V3P1xhkg/bQWp+nRjrvLeE6BJPHA
 4YKL57qVhDw0WIadWzyVuHZrmwem1sUkmfV0c0VL+brG7+LaTZ3WCEm3BNJxC9EeCG7D7Y4VfZ/
 q9+0HGzmTXVWnRnGu/JEoPW4LRcAmIw7bwXsAq0hBRPp7440vrVqcMarnRiQwW0xiiJ4mF4F9UR
 Uh1FFagYzb8jnbTPb+3/riZJCnl/nChp3MYhRu0uyIDR+rkkOBztK5TOj1PStHCHTkGEBUT4u1R
 toUGdPo+fM2EyqMUIdW7r/PtG7HO2H5AVZlPhImsjOkf++aT+nI2H5oticSBZo9hABlHSt0uQgv
 TYi/0Tak92/cm266MYr/YYFfp2M866oPAqi7O6ODdQFIWRfI4iuQwt+ya7NC9Y+56ZHtgdPK6Hg
 k3cbv5NlG2LWtlsPP9pmM643bLxId54/+AGcOgfZ7b4y95v9eZv60XMbsjRzqvzw+mDpKdtcOm5
 MnN92LlRaWj2VyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates set_flags interfaces, make it more similar to the
interfaces of dump_addr and get_addr:

 mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 10 +++---
 net/mptcp/pm_netlink.c   | 80 ++++++++++++++++++++++--------------------------
 net/mptcp/pm_userspace.c | 32 +++++++++++++++----
 net/mptcp/protocol.h     | 10 ++----
 4 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 28e5d514bf20..55406720c607 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -456,13 +456,11 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
-		       struct mptcp_pm_addr_entry *loc,
-		       struct mptcp_pm_addr_entry *rem, u8 bkup)
+int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	if (token)
-		return mptcp_userspace_pm_set_flags(net, token, loc, rem, bkup);
-	return mptcp_pm_nl_set_flags(net, loc, bkup);
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(skb, info);
+	return mptcp_pm_nl_set_flags(skb, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a900df9f173d..c799fe84dfd3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1887,66 +1887,58 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup)
+int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
-	struct mptcp_pm_addr_entry *entry;
-	u8 lookup_by_id = 0;
-
-	if (addr->addr.family == AF_UNSPEC) {
-		lookup_by_id = 1;
-		if (!addr->addr.id)
-			return -EOPNOTSUPP;
-	}
-
-	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
-	if (!entry) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
-	if ((addr->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
-
-	changed = (addr->flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr->flags & mask);
-	*addr = *entry;
-	spin_unlock_bh(&pernet->lock);
-
-	mptcp_nl_set_flags(net, &addr->addr, bkup, changed);
-	return 0;
-}
-
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct net *net = sock_net(skb->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	u8 lookup_by_id = 0;
 	u8 bkup = 0;
 	int ret;
 
+	pernet = pm_nl_get_pernet(net);
+
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
-		if (ret < 0)
-			return ret;
+	if (addr.addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!addr.addr.id)
+			return -EOPNOTSUPP;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
-	return mptcp_pm_set_flags(net, token, &addr, &remote, bkup);
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+
+	changed = (addr.flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
+	addr = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	return 0;
+}
+
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(skb, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b9809d988693..7ef3b69852f0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -546,14 +546,19 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
-				 struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_pm_addr_entry *rem, u8 bkup)
+int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
+	u8 bkup = 0;
 
 	token_val = nla_get_u32(token);
 
@@ -566,12 +571,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
-	if (loc->addr.family == AF_UNSPEC ||
-	    rem->addr.family == AF_UNSPEC)
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
 		goto set_flags_err;
 
+	if (attr_rem) {
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		if (ret < 0)
+			goto set_flags_err;
+	}
+
+	if (loc.addr.family == AF_UNSPEC ||
+	    rem.addr.family == AF_UNSPEC) {
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
+	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
+
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
 set_flags_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de9f0ff6dd30..f16edef6026a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -970,13 +970,9 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
-		       struct mptcp_pm_addr_entry *loc,
-		       struct mptcp_pm_addr_entry *rem, u8 bkup);
-int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup);
-int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
-				 struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_pm_addr_entry *rem, u8 bkup);
+int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);

-- 
2.43.0


