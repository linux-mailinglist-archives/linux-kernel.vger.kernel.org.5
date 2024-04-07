Return-Path: <linux-kernel+bounces-134449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAAC89B1A2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC13B22030
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A53D0C2;
	Sun,  7 Apr 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjqNj0Yj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7481727;
	Sun,  7 Apr 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495575; cv=none; b=ieFH3Xl86yUO7zv1th1g0RPRnDMkIgs20yRBcwzp/wC5Z1jSlWYCL2OlbRbTpU+aChWezBC3Ndx36Evh8PMZb4VlSGAP8D+oUEqMbWbH9ko0kBc4HwUaDQE4DCg9OxZlrBrsQL/GGqanH0ygakupSjAplnyc3lZ766jyCUraVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495575; c=relaxed/simple;
	bh=pEWqdY8Nz6RV4vNCPbkG+ZlYIpRQMXl4nyJkcDaaYb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJw6FQ9ZHJhvEwLWfJjTZkztLtyYxq7LAWctoBRNxE5gkb6hAlbXukxXaTCZC22+XG1M1kOkG6jI9awbWgUaX0uVSR/DLTHKYYctyFgzkM3h20Q829HELlcrrurVY7nrObeact1zAFJO4yU69e943pZ8rH4jhEuGX+fzqHvrNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjqNj0Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B44C433C7;
	Sun,  7 Apr 2024 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495575;
	bh=pEWqdY8Nz6RV4vNCPbkG+ZlYIpRQMXl4nyJkcDaaYb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjqNj0YjRWuCCq7aJ7rAiluVdmPf0fjuT6hdsTW9mroS7nGgs2tIAc85meJnbQUhR
	 pu6evz0OFaBh6NMnK4ZZHl7KqSLHYlfW+4LkbCSX///Nz6IijU/3a3wqYRneHdYWw6
	 cj7U7N+iNZKinVTELHF7W8kQeCgG80NO8W9MewJEZ/st19vnW5BkLsCtCxlqNvamOL
	 pmdBmFsa/exc73ze1G95wrzJajL88D0+hjre1gDnXk/F8QL37qu/k+mIac24hMWunw
	 v8nH59sM9kGpBpzEsbkbI/w6QG8ashyrWxF/R/M5UgqwtzhzAheRvhBnRskjv4bxHW
	 ZJpCRUtX5flEg==
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
Subject: [PATCH AUTOSEL 6.6 14/22] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:12:13 -0400
Message-ID: <20240407131231.1051652-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index 383e30fe79f41..790e847d86ec3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -485,7 +485,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -555,7 +555,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


