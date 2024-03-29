Return-Path: <linux-kernel+bounces-124519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A389193E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E2B1C24435
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9C145350;
	Fri, 29 Mar 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op1eBtoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993114533C;
	Fri, 29 Mar 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715288; cv=none; b=HCmELVMbml5zFXrB7e3qiwlBf6ftkq3giLN6rmbPNjuBUEi7sEOD7lpzfOtEH3A9rPq5QYof+YB1yeKJ86OAYk6/+PqQuzFhevOcsTf2uXoo5bPv2fwaST/8wKbtJch1QAIa6FgKUufjcKhfcEw04nU9lhpcFDuzyB6MQqRuKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715288; c=relaxed/simple;
	bh=ky+gsxc5QdHdpGdLpqgXyT53m5u9rjRLRmzsqSEwCPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM/cpZJSKH1As0wwixGcgKbi/YOQPCmYV2J6MCNXgEzHNbdKuf3EcuitxIi3/t26licTh+oegmbNBnUi9g16EOugE1orTWy4SffaiOzfZzPKpUQ7tX/83md2iHOVIM0huaOvw35aItaHyckfd7IueajOXQGKSuqC1BKd9CHcuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op1eBtoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F4CC43390;
	Fri, 29 Mar 2024 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715287;
	bh=ky+gsxc5QdHdpGdLpqgXyT53m5u9rjRLRmzsqSEwCPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=op1eBtoUlIbau4KgDl5zSGrdTLG4wEPAMjXdji/GJgtfNaYBuzvl4h0Z7Aac3Limk
	 lzsYswjSi836J2dj5cOeL02ntiTPjhOx+7M9agyLuTkgcNr2teoFyQB3Yp0bTLHNZY
	 SQS5HN6C1j6GFZun0q+4S3aAikUYc69ORBr5Ldr7XQY+qX0J+j9OB8bbWCwuyCCgJM
	 e6McpfgU+ZYGqEb4Z82P80DGjChWd87L2toqerkXufielxdyTUmwWYzk83tWPO11Nb
	 VGQkba91ZSkMQfHX4QFLDqt8EiPxcSD+N5ntUg+eylCDhRRNM208t1xB6YeyBa7PkO
	 SxA9dOREXyeCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	almasrymina@google.com
Subject: [PATCH AUTOSEL 6.8 38/68] net: skbuff: add overflow debug check to pull/push helpers
Date: Fri, 29 Mar 2024 08:25:34 -0400
Message-ID: <20240329122652.3082296-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 219eee9c0d16f1b754a8b85275854ab17df0850a ]

syzbot managed to trigger following splat:
BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
Read of size 1 at addr ffff888208a4000e by task a.out/2313
[..]
  __skb_flow_dissect+0x4a3b/0x5e50
  __skb_get_hash+0xb4/0x400
  ip_tunnel_xmit+0x77e/0x26f0
  ipip_tunnel_xmit+0x298/0x410
  ..

Analysis shows that the skb has a valid ->head, but bogus ->data
pointer.

skb->data gets its bogus value via the neigh layer, which does:

1556    __skb_pull(skb, skb_network_offset(skb));

.. and the skb was already dodgy at this point:

skb_network_offset(skb) returns a negative value due to an
earlier overflow of skb->network_header (u16).  __skb_pull thus
"adjusts" skb->data by a huge offset, pointing outside skb->head
area.

Allow debug builds to splat when we try to pull/push more than
INT_MAX bytes.

After this, the syzkaller reproducer yields a more precise splat
before the flow dissector attempts to read off skb->data memory:

WARNING: CPU: 5 PID: 2313 at include/linux/skbuff.h:2653 neigh_connected_output+0x28e/0x400
  ip_finish_output2+0xb25/0xed0
  iptunnel_xmit+0x4ff/0x870
  ipgre_xmit+0x78e/0xbb0

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240216113700.23013-1-fw@strlen.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203b..fd9198fcc3c30 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2642,6 +2642,8 @@ static inline void skb_put_u8(struct sk_buff *skb, u8 val)
 void *skb_push(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->data -= len;
 	skb->len  += len;
 	return skb->data;
@@ -2650,6 +2652,8 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 void *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->len -= len;
 	if (unlikely(skb->len < skb->data_len)) {
 #if defined(CONFIG_DEBUG_NET)
@@ -2674,6 +2678,8 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	if (likely(len <= skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
 
-- 
2.43.0


