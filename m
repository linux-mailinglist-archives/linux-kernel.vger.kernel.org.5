Return-Path: <linux-kernel+bounces-153680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4988AD196
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DD2281934
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411515359D;
	Mon, 22 Apr 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X70YJ8xX"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6615357B;
	Mon, 22 Apr 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802290; cv=none; b=Bm/fk85GGthtwlkL15mrKG9bbrdfUbJzlXN5XzNCPdsRSKrux9WG3POScgojUTSDF5Stp/oSxGhS8IjW+YOahRTHIsCVNI0k81kEIuYPQctRU7tp8dE+IZ5Sf+eAyyHdi2WnM4GPKBWcit4ZxReiDHkv636OKMSzSQpXKXfX7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802290; c=relaxed/simple;
	bh=3le542UJeSfYGDRoP90qKz4Zy3WYFGW+CJlvN5OAxOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW6T4F9TONOm1JuiWOacM+82iYuiPal65NZh6Q7E6VLjtWhXisR3q9djQOjl2B6FO9dmFSzd6/dvntPkulZ4/e8LfTjBG4GhthwhQHtuMyzIUDZ5aqce8Uv8UK8NquoutCbHHMjD3N+eVYRThIo8AKxlKrfQ+RaDhFHxjZKtUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X70YJ8xX; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713802290; x=1745338290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUemsqeaBxTFXlHFc7wvr33AU2ZxcVwt25g4PMBCnzc=;
  b=X70YJ8xXV4QYubRaYN1EHQwuqbjwFacIOCMtQ2K9EtsQjhbyiufYQO8P
   jegQRKXlbkirrKkpt75duLH23D2xhrFbnnH3GEA3p88KLr4bZ8N0/QF8F
   96hkXlZAbVIxZIm3FGcWy/7PvDW6GNsbju8lQm7CxzLz1Xr07Zur4YPkq
   k=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="340362836"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:11:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:54137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.31:2525] with esmtp (Farcaster)
 id b5dd08d2-1c1d-4c47-bb35-ab706d63a8fa; Mon, 22 Apr 2024 16:11:20 +0000 (UTC)
X-Farcaster-Flow-ID: b5dd08d2-1c1d-4c47-bb35-ab706d63a8fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 16:11:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 22 Apr 2024 16:11:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<fw@strlen.de>, <horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
Date: Mon, 22 Apr 2024 09:11:08 -0700
Message-ID: <20240422161108.83595-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000007aa28106168b76c9@google.com>
References: <0000000000007aa28106168b76c9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
Date: Sat, 20 Apr 2024 11:35:04 -0700
> syzbot has bisected this issue to:
> 
> commit 219eee9c0d16f1b754a8b85275854ab17df0850a
> Author: Florian Westphal <fw@strlen.de>
> Date:   Fri Feb 16 11:36:57 2024 +0000
> 
>     net: skbuff: add overflow debug check to pull/push helpers
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167a954f180000
> start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=157a954f180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=117a954f180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a94f00980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bce6ab180000
> 
> Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
> Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

Testing same patch for this

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 219eee9c0d16

diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index f4a38bd6a7e0..1344653916c4 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -77,13 +77,15 @@ EXPORT_SYMBOL_GPL(nsh_pop);
 static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
 {
+	unsigned int tnl_hlen, mac_len, nsh_len;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	u16 mac_offset = skb->mac_header;
-	unsigned int nsh_len, mac_len;
-	__be16 proto;
+	__be16 tnl_proto, proto;
 
 	skb_reset_network_header(skb);
 
+	tnl_proto = skb->protocol;
+	tnl_hlen = skb->network_header - skb->mac_header;
 	mac_len = skb->mac_len;
 
 	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
@@ -113,11 +115,11 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	}
 
 	for (skb = segs; skb; skb = skb->next) {
-		skb->protocol = htons(ETH_P_NSH);
-		__skb_push(skb, nsh_len);
-		skb->mac_header = mac_offset;
-		skb->network_header = skb->mac_header + mac_len;
+		__skb_push(skb, nsh_len + tnl_hlen);
+		skb_reset_mac_header(skb);
+		skb->network_header = skb->mac_header + tnl_hlen;
 		skb->mac_len = mac_len;
+		skb->protocol = tnl_proto;
 	}
 
 out:

