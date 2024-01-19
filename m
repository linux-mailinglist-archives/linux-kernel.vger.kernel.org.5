Return-Path: <linux-kernel+bounces-31023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B28327AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CDE1C22C14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE641778;
	Fri, 19 Jan 2024 10:31:26 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139C4122E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660285; cv=none; b=GKsbzHGpQMmNX9LBi4achzO5O2gliAvIqDWb2VBQmUCCE33Zq6VJqjjo9AlCezUHAy3GgF4mVe4wY/MSc6W0EuLgsmTQ3MK6925MG2ryEq1wiroMfb8656/MnRa/U9JOnBmWN+NPQDN80ZnfYKnvLS0w6AyEErpYgkZP4rnQqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660285; c=relaxed/simple;
	bh=Tepn9KHKy/gyaf7phXHDeeBgC9xy6xaiEQdxthcuYFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR0mZ9k2Tdbntu3TjPA4PHjabx4pZgmO5VKaY9Jl6SkLyFndQPx/YvddU6XxEGZjMPPFNUzGbN41VNfgN7DtasMeoRY1nPJW1igk1hzRHpmlTqJHplSGFQF5ktIKaAW98ajGOBSvUj71jvJxR41vBQQiiRvo/6lO2QCg6q03ndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (172.16.235.25) with ESMTP
	id 65AA4F7200003A60; Fri, 19 Jan 2024 18:31:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 86315134210319
X-SMAIL-UIID: B220F29846F14F409B6FE94FF12BD50A-20240119-183116-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Fri, 19 Jan 2024 18:31:04 +0800
Message-Id: <20240119103104.1990-1-hdanton@sina.com>
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
--

