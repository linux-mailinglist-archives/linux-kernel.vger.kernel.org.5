Return-Path: <linux-kernel+bounces-114461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1821D888A99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492E21C28E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F22282A62;
	Sun, 24 Mar 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALvCAI7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FF142630;
	Sun, 24 Mar 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321884; cv=none; b=qF6RxfrtzAfYmJONEeJTiIr5rzarCnX+1/46Dviu25bUAlmxoniYVFg3zkLM1TgDdeB3RdJ9P0/Au4/uYcbOrxu9pUxdW0akaZZ6TrZOWSahviAG7P0TCtMjaDrjBf0tB78hdXyaRUdEJ6sWKzi2X8r3kyTlrqmYpn7ROQ1801o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321884; c=relaxed/simple;
	bh=S0PMReYb6l7p0sdA4GoWVHr8+NH+kZJ9hEbl4Q0itqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epP1CnUPQNMfIx7PT/2YhvwTupdvynJWa3dxKs7o+XUpAVvxVvL50WVFWDY2bd+wsqM1AJZiU5+CLlvu1wQR2yzyT5jbLewexWLnnkwj2waoehpyfMah84RqJSNnOUM/5Js8C7p1kMEfsNSYrwYWyPZX1SpxmLkqfDYnQHCNN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALvCAI7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B0C43390;
	Sun, 24 Mar 2024 23:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321884;
	bh=S0PMReYb6l7p0sdA4GoWVHr8+NH+kZJ9hEbl4Q0itqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALvCAI7d0c6BruBVtOHzYyf+RRTq+oBogaunwx3qIBzpluxPwO8h/UnFsYAE943pV
	 7SZhyIv8TfSyyUuY52ufTe6DhbC7SBxNkQc9urhj67nQX+W+mL+3G+AoGbFh3xaupK
	 J2IMwDrTT5oD+E/xPkkzkDbqyg6Xkyz/iOaJNYRW9PZN2logUirSQo0F6tG3OHHB9W
	 o3rOp5wR71EBEs8DTDEJideps1gDt3w/Jiu3XCqd/W6ZY8oh0k5M7Ch9Y2La8OWwOY
	 RUYWkGdn2MM7wNeOXDghrWe8/cIsWstnD4MmujewycIOgxrIcnr+W2Xqxzkn7m3kYx
	 +r2sHPxbxakOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Brunner <tobias@strongswan.org>,
	David Ahern <dsahern@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 612/638] ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels
Date: Sun, 24 Mar 2024 19:00:49 -0400
Message-ID: <20240324230116.1348576-613-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tobias Brunner <tobias@strongswan.org>

[ Upstream commit c9b3b81716c5b92132a6c1d4ac3c48a7b44082ab ]

Since the referenced commit, the xfrm_inner_extract_output() function
uses the protocol field to determine the address family.  So not setting
it for IPv4 raw sockets meant that such packets couldn't be tunneled via
IPsec anymore.

IPv6 raw sockets are not affected as they already set the protocol since
9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
genereated skbs").

Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://lore.kernel.org/r/c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/raw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index c0ef81f0bceeb..ee55d0cbe4e63 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -350,6 +350,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto error;
 	skb_reserve(skb, hlen);
 
+	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-- 
2.43.0


