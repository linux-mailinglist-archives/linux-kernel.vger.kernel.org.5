Return-Path: <linux-kernel+bounces-60404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C0850471
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891F02837AC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F045481DA;
	Sat, 10 Feb 2024 12:56:44 +0000 (UTC)
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332E47F42;
	Sat, 10 Feb 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569803; cv=none; b=t6SM8mmSo97pfDmtZYo25By1pRjV1ANsDgCq9QOJpbbO/fWYpcPcwVLczjVxxzFlM3ROxUoxCPdFIzvQzgdJpOHo8bUmRQUY+acOCp88ZAkpZZw5xoejKrUgMBAE8bNW1o2Pfw+mp1daNMPrAdQFR/E1BLX1oT1DbiIfRTrWUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569803; c=relaxed/simple;
	bh=jTamXYQSY1bQylvKzgcgdRQfmjJ8/TU+GEYdw1q4oMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4u2e4akCFqqBLax7i7QxT6EfOPqPydXM7MazLa6FKXlbSRB8frPKk3m2ogDYw9nho7dMs8eNo6vPzVQ2BoF6Ei1rxSx6wwKWlVNPwv35hTEU1R2XCTJTQ8Y3kS9qnGtMNf8FHf8/HPFNsV3MKzxInritAJCUStVSTCnaTPan0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from basile.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id C1E2AC022E;
	Sat, 10 Feb 2024 14:50:54 +0200 (EET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] phonet/pep: fix racy skb_queue_empty() use
Date: Sat, 10 Feb 2024 14:50:54 +0200
Message-ID: <20240210125054.71391-2-remi@remlab.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210125054.71391-1-remi@remlab.net>
References: <20240210125054.71391-1-remi@remlab.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rémi Denis-Courmont <courmisch@gmail.com>

The receive queues are protected by their respective spin-lock, not
the socket lock. This could lead to skb_peek() unexpectedly
returning NULL or a pointer to an already dequeued socket buffer.

Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
---
 net/phonet/pep.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index faba31f2eff2..3dd5f52bc1b5 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -917,6 +917,37 @@ static int pep_sock_enable(struct sock *sk, struct sockaddr *addr, int len)
 	return 0;
 }
 
+static unsigned int pep_first_packet_length(struct sock *sk)
+{
+	struct pep_sock *pn = pep_sk(sk);
+	struct sk_buff_head *q;
+	struct sk_buff *skb;
+	unsigned int len = 0;
+	bool found = false;
+
+	if (sock_flag(sk, SOCK_URGINLINE)) {
+		q = &pn->ctrlreq_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb) {
+			len = skb->len;
+			found = true;
+		}
+		spin_unlock_bh(&q->lock);
+	}
+
+	if (likely(!found)) {
+		q = &sk->sk_receive_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb)
+			len = skb->len;
+		spin_unlock_bh(&q->lock);
+	}
+
+	return len;
+}
+
 static int pep_ioctl(struct sock *sk, int cmd, int *karg)
 {
 	struct pep_sock *pn = pep_sk(sk);
@@ -929,15 +960,7 @@ static int pep_ioctl(struct sock *sk, int cmd, int *karg)
 			break;
 		}
 
-		lock_sock(sk);
-		if (sock_flag(sk, SOCK_URGINLINE) &&
-		    !skb_queue_empty(&pn->ctrlreq_queue))
-			*karg = skb_peek(&pn->ctrlreq_queue)->len;
-		else if (!skb_queue_empty(&sk->sk_receive_queue))
-			*karg = skb_peek(&sk->sk_receive_queue)->len;
-		else
-			*karg = 0;
-		release_sock(sk);
+		*karg = pep_first_packet_length(sk);
 		ret = 0;
 		break;
 
-- 
2.43.0


