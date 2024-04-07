Return-Path: <linux-kernel+bounces-134477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD789B1F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B39D1F21064
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4E1327F3;
	Sun,  7 Apr 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjCMHeo3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC79132490;
	Sun,  7 Apr 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495633; cv=none; b=Nt9fw2mHXZ1I7gJkaud1FbwJ40u8RkvCSH/b66J4AgLDeX6Txc1qMFWIOFvjmkVzw1P4XVH13k7chfJaCw8sDrXn/ZEWZhIQL+RxoOzyrB8iCpOtvj8QQ5JlnBqkvvTsstIuipcFuxN4n7QtGnhIogf3XU3pQ07LnzMFtSRlwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495633; c=relaxed/simple;
	bh=0XaOm3MyhApjF12Qp+fFmbtZAF6ykXNEDxpLVAuc0OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7Uc8FoR0ShLeHErgooc9RamrqjEFxTiwwsQCYiLuY5N9bcW7E3Jhl9HjwxyJ7x9q8qV+WwRbTXai1kXCgAaZ1ivsmx5fdgqOHJ2nkHXCxgV0SaSm3QaNHeNW6xt7eFEedctMu6CjhH2kIL+0SkVeKC/aVVwBjzZXftRIY8IX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjCMHeo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB3C43390;
	Sun,  7 Apr 2024 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495633;
	bh=0XaOm3MyhApjF12Qp+fFmbtZAF6ykXNEDxpLVAuc0OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjCMHeo3YpsXBkHntqJi36KACEoDGz8RsTEc08VMc191QhzcAxqkGdlQ5gGyWg+Ts
	 sRQbKKUFzKPUshdXPne6c4DIFQMvvKYw4mDDXgRUp+soaVMt/6rVMFFCK5Xbka3CEo
	 EZAredTqHIWNs+9mP5uGdv6MPG7UfsUXgJBNLQb0Pj94ygmmskOJE0md60/doVbClh
	 j/nAi/qFXLAO6B1zJIG5vje+mkyTBYGFwVGWqje47XMpA7Pax59a2EbOTsSDw/mRBS
	 SLsQQ/585GuMiy52+36vjSSd5Qm+G9M/UqhSIHoyHmKfKG3xhhiTwUfJL86Eq/lZCK
	 NOHMfyHGDQIfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/10] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:13:37 -0400
Message-ID: <20240407131341.1052960-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131341.1052960-1-sashal@kernel.org>
References: <20240407131341.1052960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: linke li <lilinke99@qq.com>

[ Upstream commit c2deb2e971f5d9aca941ef13ee05566979e337a4 ]

sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
changed by other threads. Mark this as benign using READ_ONCE().

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 6f761f3c272aa..62e376f09f957 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -459,7 +459,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -511,7 +511,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


