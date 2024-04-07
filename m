Return-Path: <linux-kernel+bounces-134493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F104B89B229
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0955D1C20BD5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5413A27D;
	Sun,  7 Apr 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Weg4CN19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F113A254;
	Sun,  7 Apr 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495663; cv=none; b=UL/tGzQ8T7bXxtdlNBcSS6lUPExUyZx1p7FEOL//fhbUxiLH3naMZTv23XB8+8RbAAD2nN/p9Q2dWuz/o4f3y6PtF0i9RLWBSKTo8kNKDxxY/fLKbQUlRCRgJEVf7R7iKTd/NC+tJWLAaUHX9QYkoAGkhp5YcgmSNN4V6k03QI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495663; c=relaxed/simple;
	bh=epT7Kmq/2yLTGhfFtDS4b2fXc/1yb8F+ExvuFkDp7kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seDbLRSRtQEN1scq95GlAbsWpo0DCBMTSe4F3wbhARf7yED9agmcm7G5nKWMPy/ye+sYYrcpBfvORVjUNWyV28Zy10S5Tg6tRdA7GVeJsef4AcXWq0bbdWGdCN1460j4GIPFRiPNdryfrE7N3wDIoIg+sd2rdRcvdjbgNq7ElXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Weg4CN19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B712C43390;
	Sun,  7 Apr 2024 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495662;
	bh=epT7Kmq/2yLTGhfFtDS4b2fXc/1yb8F+ExvuFkDp7kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Weg4CN19D7jNTxO2gEPIE9z6w8ROn4BpwEAxEQAaPWyF+jVgnc3wuba2/FUhHyHvc
	 jLXVU6qZwNmQTWJHpuKs9JlRyYKQOK85+ZEQf8hd3avwZ2Lb8R/5NDpJtlIprhgoyw
	 MZrF9OyZerFlQm9EWCPsZhJWRP0EOqtFCfZJUgao49GjBm6bFHEBLYpN3MiH5Dd/FQ
	 J7F0/AKubINIKjDceo3kch4pdKOutgvy4EZw7zlOMLs3orGxsPdosBzljfCAOVkzZ5
	 YbqPOeaA+VEkSkRetlC+bX2DcGJ3ELnuKL2xayXY6dnweJpSNwX626t7S4ki5Nqg9w
	 Z9S6iLlexcl3w==
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
Subject: [PATCH AUTOSEL 5.4 5/6] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:14:11 -0400
Message-ID: <20240407131414.1053600-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131414.1053600-1-sashal@kernel.org>
References: <20240407131414.1053600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index daeb0e69c71b4..2b68a93adfa8d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -453,7 +453,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -505,7 +505,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


