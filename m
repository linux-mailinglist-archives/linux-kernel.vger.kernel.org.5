Return-Path: <linux-kernel+bounces-134465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7389B1D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04F81F21244
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4EB12F585;
	Sun,  7 Apr 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5eKnzw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585112F391;
	Sun,  7 Apr 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495610; cv=none; b=TXXHgxOxo/YG25+vJhYj/fZYnx5zCuTaTTAIBmVVfMxI9h0ND6bJbsNhfefQt29z93SnCFpnhRpGjDTCHDY0o8EUx5GMY7eD2LHaN8sUYbvNwNBJZISjmUK14/2gexX1hmVEpOA9h79mNQKWvsPPEKTlNem/dyEULX/QEFle47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495610; c=relaxed/simple;
	bh=uAwUcj6IQHXf1JCTF5h5TA9h8OQ2IqkT3OMXLmx3Csk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAGpbhGd3sV+QUs2pwlqievx66Vfb8RJRytQYxNVlga41pvntW+gyBB4AhUkd8FKsQ3aiDCCBLhuS7pyT0ie5xSP2ZWpOoDJcJ/sIQPgfG2oNPZ9+V57ffmI60HMpPT9FbY0t4Yq1cl70HM78SVkFG0gqYJHyOIedgooOaq0Dmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5eKnzw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E81CC433F1;
	Sun,  7 Apr 2024 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495609;
	bh=uAwUcj6IQHXf1JCTF5h5TA9h8OQ2IqkT3OMXLmx3Csk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5eKnzw65bLqXoxRKM0qFyxDU1teAqji1fnJ1olPV8bfk0qk90E4morf4sGp2yD0T
	 7khQKkrHDW2Em3Mo84qhhgOqDrTjTGdolM2sxL+4irKYQUH+/LWcBnEMIu387Zatsj
	 DuWGXXmDw6Y8B6neHwaYXtdnFqGwbPfKJlaGHvohAxaJ10vG5DMCZMdt0CPoQqVqe1
	 aUGNOEL7a9SBiutjEUOmn6HLwtRzXAS+UyhtA6nY/pUOFRU7KPE8VqUGGKDekyvRkB
	 V3l+8zIK0Aags5UeovGpsbVztNUfAlh0DYSsvmQ6zRPN+Slb6nqnDgAArASZCJZUb9
	 wLkvh2cRtw9rw==
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
Subject: [PATCH AUTOSEL 6.1 08/13] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:13:07 -0400
Message-ID: <20240407131316.1052393-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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
index c8803b95ea0da..054fbace08e0a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -481,7 +481,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -551,7 +551,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


