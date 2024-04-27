Return-Path: <linux-kernel+bounces-161126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC28B476D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73062282A75
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65894145B1B;
	Sat, 27 Apr 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jvBjRyX6"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205A14389A;
	Sat, 27 Apr 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242271; cv=none; b=AQyljcAym94BTaOPeev+1aBOzJomspYJz/u8qzzhJog3yrf/q8fdDeN+dt/sOmVHONTULFCPKJ8G78wngF+BJoKc+i5MW1CzQ6OKn9bfVMKvNACK1mehYQG22SiO1dT6Q796EfFeCfNnc62R4kiMG5WUsvj0WQzYrXp5nv4QWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242271; c=relaxed/simple;
	bh=G4qbu3HbZE/UnM3R1/lR8f8xJ+TyR3rhnFyLhZ55ENA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4MmaQ9ZZijfyPnMwoNh4p4+jJw2WYt6BalesF16UJ96Fa/LyWism3PfurT9Dcdw5uQg+z8irJeexj+Pc9i2ZyWXIdHiEUdTiMJsx8zsi468Yrr0rzAdLQ7fWXWWTOb79VCE7Fduum0GJPC+XXNsN3wbSp9fNLf1g8mHTaFk33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jvBjRyX6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mryOBMGyDjVCgxkOiJi6/7hI2yMziEkko+lbmm71JJA=; b=jvBjRyX6OALj+dpn3PoWl4Br3/
	Ffm2f3e6sg5NlbhTriNJShgQBBaI4fcj/aq1GIcDNVNA0Kg4O3tZ0Esc5etXN8WSjPT52inVLQ38b
	4QF00njGxHgFB5mKqickjtmKFZY8jnAIz92XRMOWr1+MB1PzEtXEFYMrfQ9D9cjM3jBY=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0mik-008hL3-26;
	Sat, 27 Apr 2024 20:24:22 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with fraglist GSO
Date: Sat, 27 Apr 2024 20:24:18 +0200
Message-ID: <20240427182420.24673-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
an invalid linearized skb. This code only needs to change the ethernet
header, so pskb_copy is the right function to call here.

Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/bridge/br_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 7431f89e897b..d7c35f55bd69 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 	if (skb->dev == p->dev && ether_addr_equal(src, addr))
 		return;
 
-	skb = skb_copy(skb, GFP_ATOMIC);
+	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
 		DEV_STATS_INC(dev, tx_dropped);
 		return;
-- 
2.44.0


