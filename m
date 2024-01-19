Return-Path: <linux-kernel+bounces-31112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC29832929
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71B62861E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EB4EB42;
	Fri, 19 Jan 2024 11:48:05 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A813C062
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664885; cv=none; b=uQegAXIaY9o1MlP5ria8XZdN8A4g9nOWomK6+kHNfAUznMcvUbz7RpVTEdHVm1DVTnv5eGAuH7HiH7ykktQ8DEgAI9I/5JPI/5ZfDoNaGV+o53BENKMabR+YQ3eEcjTxdWj3tSyLTomhHiM6s2CL+h8u77ZImI4qtjvebaFC35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664885; c=relaxed/simple;
	bh=mm97x0QybyDMy4TN2EzXDYK07oKLDhIsaf0ua7BrVUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nApMdecUds1Jtvt6mHkv2Wz7mXdAjNBT0xPxoPo8sOmWfXli5x7nn5wM8AFAnq9i3KpEVn941RX+SzG7niTp7IPt97SkH6dpFTHXkQ63nDbymdbXEYT+Y8POHZnpJwhLpvMfOSwnTTgrytdEs5NwR21RyIoKP95vBpUoXDpkkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (172.16.235.25) with ESMTP
	id 65AA616000000753; Fri, 19 Jan 2024 19:47:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 96478334210440
X-SMAIL-UIID: B9C268167C3D43FD95E3C62C449E5C58-20240119-194746-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Fri, 19 Jan 2024 19:47:35 +0800
Message-Id: <20240119114735.2106-1-hdanton@sina.com>
In-Reply-To: <000000000000498a02060de59162@google.com>
References: <000000000000498a02060de59162@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jan 2024 09:18:16 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122dfc65e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/core/filter.c
+++ y/net/core/filter.c
@@ -2161,6 +2161,10 @@ static int __bpf_redirect_no_mac(struct
 	}
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
+
+	if (skb->data[0] < 2)
+		flags = 0;
+
 	return flags & BPF_F_INGRESS ?
 	       __bpf_rx_skb_no_mac(dev, skb) : __bpf_tx_skb(dev, skb);
 }
--- x/net/ipv4/ipip.c
+++ y/net/ipv4/ipip.c
@@ -281,6 +281,9 @@ static netdev_tx_t ipip_tunnel_xmit(stru
 	if (!pskb_inet_may_pull(skb))
 		goto tx_error;
 
+	if (skb->data[0] < 2)
+		DEV_STATS_INC(dev, tx_errors);
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ipproto = IPPROTO_IPIP;
@@ -302,6 +305,9 @@ static netdev_tx_t ipip_tunnel_xmit(stru
 
 	skb_set_inner_ipproto(skb, ipproto);
 
+	if (skb->data[0] < 2)
+		DEV_STATS_INC(dev, tx_errors);
+
 	if (tunnel->collect_md)
 		ip_md_tunnel_xmit(skb, dev, ipproto, 0);
 	else
--- x/net/ipv4/ip_tunnel.c
+++ y/net/ipv4/ip_tunnel.c
@@ -745,6 +745,9 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 		}
 	}
 
+	if (skb->data[0] < 2)
+		DEV_STATS_INC(dev, tx_errors);
+
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, RT_TOS(tos),
 			    dev_net(dev), tunnel->parms.link,
@@ -828,6 +831,9 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 		return;
 	}
 
+	if (skb->data[0] < 2)
+		DEV_STATS_INC(dev, tx_errors);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
--- x/net/ipv4/ip_tunnel_core.c
+++ y/net/ipv4/ip_tunnel_core.c
@@ -57,6 +57,8 @@ void iptunnel_xmit(struct sock *sk, stru
 	struct iphdr *iph;
 	int err;
 
+	if (skb->data[0] < 2)
+		err = 0;
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
@@ -67,6 +69,8 @@ void iptunnel_xmit(struct sock *sk, stru
 	skb_push(skb, sizeof(struct iphdr));
 	skb_reset_network_header(skb);
 
+	if (skb->data[0] < 2)
+		err = 0;
 	iph = ip_hdr(skb);
 
 	iph->version	=	4;
@@ -79,6 +83,8 @@ void iptunnel_xmit(struct sock *sk, stru
 	iph->ttl	=	ttl;
 	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
 
+	if (skb->data[0] < 2)
+		err = 0;
 	err = ip_local_out(net, sk, skb);
 
 	if (dev) {
--

