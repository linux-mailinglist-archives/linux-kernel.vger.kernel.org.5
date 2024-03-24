Return-Path: <linux-kernel+bounces-114695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7D888BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7908C296C85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C12B92ED;
	Mon, 25 Mar 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpglrO1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94D15F419;
	Sun, 24 Mar 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322343; cv=none; b=XNPu+cc1GIpW0Sd78HdsrLmPOLmUR4yK2d6fo20gJnZ3mPpIN8KjZd317MCKgEOKGjjeulYs96snO6uj76maXkG5YQmofCVRZwQoVrsDZkHikw2xE4Nt4jYwMJztr/u2XoO88AXhxpv9Hv5oEz60Id1Gnid3IuSAx7/pS4yHZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322343; c=relaxed/simple;
	bh=1i31f10u/aBPlrtTCzD1Dyn80j1e4nsPA8POBUcaYVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+FqSldnGioSq+CB3X+kNkykWXJZCl3db5NNWb6Qe9GxFvYBAY0yz7hD7OsjV+Vn+CsIgj5ja46rZSrffheQAEuKk/9IjwCaR/NENZOOIeltLUJmzhMF3mxN0hHDw+vZB00cylIkHHJDCyLuD45nqxr5/J5+G6GKppLA54y8ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpglrO1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD497C43390;
	Sun, 24 Mar 2024 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322342;
	bh=1i31f10u/aBPlrtTCzD1Dyn80j1e4nsPA8POBUcaYVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpglrO1yUUZRPkyiP0JYz1sKs5de8YykjcLJy3Qu53oU6iTYLNlL1p+0qbfcarCMW
	 JRr4vNq5xq7S0fYXVZqW8VgEAeXnwcAbNu0u+a0/5VwaWV7KxvfDb20Qzq71XXI82/
	 mKpNGmxt7t6qgHBP+LppoR2XpIFUQhk/ZFo/FPvy3/nKS/0gXKPPhLMbrdHD2B8zpm
	 edlTa7QEgPOKtIgIjxBMjoictF145ZjocE49y+M33S0AZQjj9HevDVw7hBAePnzAES
	 +CLBl3yCtSowIeZsgjAA9eBhiFw7dxnmYvEwM7MOFlv3C2y+P8I2OgfJ8pBl9hRlzp
	 oexjEGUVGcisw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Brunner <tobias@strongswan.org>,
	David Ahern <dsahern@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 424/451] ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels
Date: Sun, 24 Mar 2024 19:11:40 -0400
Message-ID: <20240324231207.1351418-425-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 7c63b91edbf7a..ee0efd0efec40 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -348,6 +348,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto error;
 	skb_reserve(skb, hlen);
 
+	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-- 
2.43.0


