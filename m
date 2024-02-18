Return-Path: <linux-kernel+bounces-70285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442BF859595
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F5E2820AD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7114F6C;
	Sun, 18 Feb 2024 08:18:43 +0000 (UTC)
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5EF4EB;
	Sun, 18 Feb 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244323; cv=none; b=STg3jJUU3uQA9FNfYMnx8rti2k8OquUZ+utQH9k4X2JnaMVmQTeo2QmP9Ug7WDWW/gw953pVVjM4P297GEk7RnO7YZvFA/pOL0tUVYJMwkqMMM5aNde1UJ203LYjQEOp/drChIjKFi95tngQMs2fz4w+z81SW662dS4aijytwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244323; c=relaxed/simple;
	bh=N4ufLhqUZMGni7ljag9cL2yFnI4/1wwaxQxPHYTQSYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXDEDxV4XLamsp0HTUQax32SYrIgsRPi1bQBIe86igz43JMsZx9k50NrhLw2A//SLODTwxUXmnMOOQRy3zkZH+CHYBlpIAx5E4ajnpCi/F5tuXflu5pHJTfSSpW/QuAkOfWyqTyPfpiY8HwZz4fnhWD1l6qQ/yleWjw+rN0Yd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from basile.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id 28DD2C009A;
	Sun, 18 Feb 2024 10:12:15 +0200 (EET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] phonet/pep: fix racy skb_queue_empty() use
Date: Sun, 18 Feb 2024 10:12:14 +0200
Message-ID: <20240218081214.4806-2-remi@remlab.net>
X-Mailer: git-send-email 2.43.0
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

Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
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


