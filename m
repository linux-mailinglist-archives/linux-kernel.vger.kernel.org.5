Return-Path: <linux-kernel+bounces-124616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704D891A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BCB1F24862
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585E15B554;
	Fri, 29 Mar 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t501l0iB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641B13E6C9;
	Fri, 29 Mar 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715555; cv=none; b=T6hwH2xc2ouV6dlC+UDCL1s/UFwWbBtUYvaT1a6XqqxLpEJ84V61MIKlh85d0U46jesZPRN8WpPMtVvEYQaM/HtfjitE+ijvPof6xdxIL7FyQUXPgYH781yQrRBnAP5YqPHrC/AkMHgwacROW77giZnpvHTaGi8Kf4p/egsuuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715555; c=relaxed/simple;
	bh=xH8KpkIXqQbXhb1kdifqcgbOGysiADXSFWZSo2OSrsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGERZsTBzsWme0rE9tlpXvOGNSSlaTchysEiAEBEgEo21kotOvBx/o8S03SJPzP+XzU8OgwFabpFBY89WcQylyQTT0JHcqJNnmGVaaK4YT7kUIBMt2NtLrszeagb1nibwyacX/Lt+dEwdziXjiXlDomqA6krUe7Gky7IVcAeEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t501l0iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32962C433F1;
	Fri, 29 Mar 2024 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715555;
	bh=xH8KpkIXqQbXhb1kdifqcgbOGysiADXSFWZSo2OSrsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t501l0iBCouubgiog/7casfmI5lWHtUwJn7HEqv/+qFmBBdtei3frEMl3cJhkhlS+
	 VG7y8kAoolERbSB/HpCKDurQMeqKfpfB/J6N+n5r2hsf/VQJ8I09H+Z+TaPWzIarfi
	 W3+7sA9kNjUQD9+eEfr0jjKvSMphpaT3LINb6nWjsEHPI/cxBr7VkDO9POC8YZ5PMN
	 br+y5OcyKvZE2t5iiD7uApKRHqncYEr8A9bo20NSTkwobLaqFV3qBgmHa/GfVrolgB
	 n7/+iQPutQODPSE0M8WzDcpeXGj1mOfNYq4hOrfBkYS0TSEefVUKUEOB3ZtAFk/tdY
	 Em25o6ECOKbGg==
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
Subject: [PATCH AUTOSEL 6.1 13/31] net: skbuff: add overflow debug check to pull/push helpers
Date: Fri, 29 Mar 2024 08:31:32 -0400
Message-ID: <20240329123207.3085013-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index c30d419ebf545..d61b718ab730c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2608,6 +2608,8 @@ static inline void skb_put_u8(struct sk_buff *skb, u8 val)
 void *skb_push(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->data -= len;
 	skb->len  += len;
 	return skb->data;
@@ -2616,6 +2618,8 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 void *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->len -= len;
 	if (unlikely(skb->len < skb->data_len)) {
 #if defined(CONFIG_DEBUG_NET)
@@ -2639,6 +2643,8 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
 static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	if (likely(len <= skb_headlen(skb)))
 		return true;
 	if (unlikely(len > skb->len))
-- 
2.43.0


