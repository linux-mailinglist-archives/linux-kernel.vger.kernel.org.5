Return-Path: <linux-kernel+bounces-105372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD287DCEB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97E5B20EF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0518E10;
	Sun, 17 Mar 2024 10:07:41 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588D1429E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710670060; cv=none; b=d5tGuwhsC5ejxF2skEeGBIOw+reUcoJJo+jxeH5xb1loN+DAT1x2KQeE5TPcuOkxPtpUgnXUxlrWCozj59NhuTNYMmW8WzX6Tj33YZCaXfIRkX/o/uK6ckTQt9RuaMS8JfmGuNAJZuE3hmOQf4M2OoVhKf/Y27cSCwokL3LZEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710670060; c=relaxed/simple;
	bh=Dd+txECsWPxDo8/UX9xOHTYg/YqF/JMxmfWhmQhjSdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6Jwt+OmRo+dFouI1wK4/MBNt9O2UNO/SpYT1TIGMn43lUsM+3DWfEYrM2FlabHozacIEzu7yPw/v7e6wPmk+3/75+lcKl6bGuQiIXerpnywNrktp1n2OOSoJ06v+OwqU+wFs4pYeEQQ1K/jnQ6oB1V0zEvLpvh92PplNyg24mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.14])
	by sina.com (172.16.235.24) with ESMTP
	id 65F6C04B00001617; Sun, 17 Mar 2024 18:05:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 20741545089403
X-SMAIL-UIID: B3FC33FDA7A341D68DA4CFD9E69C11CF-20240317-180502-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Sun, 17 Mar 2024 18:04:51 +0800
Message-Id: <20240317100451.2053-1-hdanton@sina.com>
In-Reply-To: <0000000000008b9c410612fbd266@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 02:57:18 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    805d849d7c3c Merge tag 'acpi-6.8-rc7' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025fa6a180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

--- x/drivers/net/ipvlan/ipvlan_core.c
+++ y/drivers/net/ipvlan/ipvlan_core.c
@@ -426,6 +426,7 @@ static noinline_for_stack int ipvlan_pro
 		.daddr = ip4h->daddr,
 		.saddr = ip4h->saddr,
 	};
+	struct sock *sk;
 
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
@@ -439,7 +440,12 @@ static noinline_for_stack int ipvlan_pro
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
+	sk = skb->sk;
+	if (!sk)
+		goto err;
+	refcount_inc(&sk->sk_wmem_alloc);
 	err = ip_local_out(net, skb->sk, skb);
+	sk_free(sk);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
--- x/kernel/rcu/tree.c
+++ y/kernel/rcu/tree.c
@@ -4025,6 +4025,7 @@ static void rcu_barrier_entrain(struct r
 	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
+		wake_nocb = true;
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
--

