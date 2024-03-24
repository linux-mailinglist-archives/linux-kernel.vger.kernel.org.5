Return-Path: <linux-kernel+bounces-113991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A98887CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E51288271
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399322288C;
	Sun, 24 Mar 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbKNqUXn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102E1F30BF;
	Sun, 24 Mar 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321123; cv=none; b=oLcwBa7c6Its9CJ5qUWuzgj0K5E+5spNwDN/LneeT9zHBn3kfnNa1R0e7u6PMXRfy+TJKUvU/U7uHiObLBklCVm85lR/q5WwfBTPxr4Z47W8taGos8gfkUYzf6wneabf4Q6a/xgG3buBSUJElN3ka7UXYoigIOEAH3EOtCbvohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321123; c=relaxed/simple;
	bh=nuvNN4ZvtBd/GUiziz/K8W0DyuJfnso9yH/WmpRvifE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn2rGVYFNH6weVF+oGEM1/6GWZsoKxrl5JuAJMUswclqV5GAHrkmN6RIuJpbBW232OsIuLmtkdvpvzdKzV4EexkA7d0DaecebRE9L39cqdVk2ZIMJEbqzZe+h76FfdjBczH+qrJwh5A/coi0UMshYioJkfonXNcmh6e82YELOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbKNqUXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825FAC433C7;
	Sun, 24 Mar 2024 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321122;
	bh=nuvNN4ZvtBd/GUiziz/K8W0DyuJfnso9yH/WmpRvifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbKNqUXnKKVhhuCQfNXQ0kWKdixP6oEEggC5l5M4aRUdD+zMSEj3dITpDHnrVP4xp
	 fGj6dICQmXLiyxtXhEJOz9PrJ6GR3nTIkeAkTRwZGsjlGSAI4u5hoEiUcPD3HP2vA9
	 DbUhIcmsGKV7b1OBf5mt/2cU64Pza/xyUqaeXKBRFEzrhwlCwMOKhbiUq2mFL0Cdu9
	 sHx0YKzpL5/MPqyHApmOn0kCboqSJGRikAZohGzq/3fQ8ffcUBG1UuovPe0OaNTIex
	 BzuyVW21vE9m6vL2cPb5+F3mSnuZb+TlVzpimcgFTGkqDSpzNP4EvLCQbnu5dhy4nH
	 kFAWq+0/Pet9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Brunner <tobias@strongswan.org>,
	David Ahern <dsahern@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 683/713] ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels
Date: Sun, 24 Mar 2024 18:46:49 -0400
Message-ID: <20240324224720.1345309-684-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index aea89326c6979..288f1846b3518 100644
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


