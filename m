Return-Path: <linux-kernel+bounces-134498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BAF89B238
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83566287087
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA7013B28A;
	Sun,  7 Apr 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9o4XVmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E113AD30;
	Sun,  7 Apr 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495674; cv=none; b=fg2e+rrBLNN7NHNkkAJjCNRR8HBUx1K/4acWbU5kv2B/a1gxlwXxfKpK94mw+e/JVZNkCE/Rtb/9pe2U12K4HRYre2SzLKwX6m/zV4yyGP7YivxcejfxWPErgYvHeUFjPffy85Mqnx4W2NJ9GQH36GFqPlKla1XNoPQdlheKp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495674; c=relaxed/simple;
	bh=Y1SZ2ijBW5TH0lgerbHNx/oxlDKk8wXv5m5mQBVO9pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AafTaMTAgqLxpOfQezHD4RxLPVgJ/Ntbkl9EtVRbOuipyJFgzb+YvO/GciG3G+cqvPp+193BuR9AOHwIM11tvWkik7qxk584zcWSsllUH6K//+EvHW/Wjz95aF9JVFiTwsQsaTnKUTLYjfArB+CenE0/QFp55YIyoDun7WDO4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9o4XVmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A94C433F1;
	Sun,  7 Apr 2024 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495673;
	bh=Y1SZ2ijBW5TH0lgerbHNx/oxlDKk8wXv5m5mQBVO9pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9o4XVmAKEmDh4rD3cJLWCZWiMDHYmQMRAQxl45GTiEGIkIHoxL9tfR5jOOvApkdo
	 Ig0GbLwHCdBOqxJyOszCwa4/5Wo+aAP21i8gRv3JdjuMurV/IT6KGVYZRcUgq+En3C
	 rK9dEHxSTcG+0v90EBO6ckK2i+oqOnLip/8uQoweUIQkquh1Q9VAlpHe46gN8P6/uR
	 rVle6id2gyVXJUWB9utvTqKYNcAp7zwLm/npfy27SsFHPo+X0qrTbmMixXmGk0aEBK
	 nsCaEfTJmxsWFooNPBP4Gh2uCN0XQjch8BTD6OKcya5usfqQjjpqYiIvtaU0uMfd2u
	 G5365wSqx/4ug==
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
	willemb@google.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/5] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:14:24 -0400
Message-ID: <20240407131426.1053736-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131426.1053736-1-sashal@kernel.org>
References: <20240407131426.1053736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 62d169bcfcfa1..dd7cee54b66cc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -404,7 +404,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -456,7 +456,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


