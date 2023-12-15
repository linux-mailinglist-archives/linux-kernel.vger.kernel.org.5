Return-Path: <linux-kernel+bounces-1376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B8814E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB873283AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6663DF8;
	Fri, 15 Dec 2023 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1v8qLCV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/c5A367j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3045BFF;
	Fri, 15 Dec 2023 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YY938P41v7tgAkEsD/QoBSvsRcX+2kJhvYsQnrL6Aw=;
	b=Z1v8qLCV+RLJiu/rblvMSN7tDD7HRrKGxcYCmF6KGyzzTfhi6Q3gCjZ2PZbm0ZRBM/spAv
	ndtFcpvAwtAlsxq8x5U6GZitY00Ew6iA944vQ8aHBvXItZiqelQzXMTSwrjDPBOKuj8nkH
	2iH46n9ufTFdXcQW8jctOXi+eYFnf0iYV5jmePGS2f2zJpj3RbKec60JnNyyiKiw6LeE+M
	RhEhBWk6qdox8FeyxSq+zREuIVlDQr0ndyST6W3yM0MMWWuDEub7tpHAKxhlVJSANoSltD
	axHeE592+spSZ/XKkMJkCk7lg4hnarGZb/7qz6bZV8m2T2NJ2VF00LLIcEw2/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YY938P41v7tgAkEsD/QoBSvsRcX+2kJhvYsQnrL6Aw=;
	b=/c5A367jYpvBJ4WRTOzeEQIOJO45jcSIQ5G1gX8QMVs1c5Ii4wETrzynloABIM3EJhrHB8
	+pkzwyAzbFNjYMAQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 10/24] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Fri, 15 Dec 2023 18:07:29 +0100
Message-ID: <20231215171020.687342-11-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

softnet_data::process_queue is a per-CPU variable and relies on disabled
BH for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Add a local_lock_t to softnet_data and use local_lock_nested_bh() for locki=
ng
of process_queue. This change adds only lockdep coverage and does not
alter the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 06436695c3679..88e27d3c39da2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3238,6 +3238,7 @@ static inline bool dev_has_header(const struct net_de=
vice *dev)
 struct softnet_data {
 	struct list_head	poll_list;
 	struct sk_buff_head	process_queue;
+	local_lock_t		process_queue_bh_lock;
=20
 	/* stats */
 	unsigned int		processed;
diff --git a/net/core/dev.c b/net/core/dev.c
index 09232080843ee..5a0f6da7b3ae5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -440,7 +440,9 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
  *	queue in the local softnet handler.
  */
=20
-DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data) =3D {
+	.process_queue_bh_lock =3D INIT_LOCAL_LOCK(process_queue_bh_lock),
+};
 EXPORT_PER_CPU_SYMBOL(softnet_data);
=20
 #ifdef CONFIG_LOCKDEP
@@ -5838,6 +5840,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	rps_unlock_irq_enable(sd);
=20
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5845,6 +5848,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
=20
@@ -5966,15 +5970,22 @@ static int process_backlog(struct napi_struct *napi=
, int quota)
 	while (again) {
 		struct sk_buff *skb;
=20
+		local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		while ((skb =3D __skb_dequeue(&sd->process_queue))) {
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
+
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 			input_queue_head_incr(sd);
-			if (++work >=3D quota)
+			if (++work >=3D quota) {
+				local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 				return work;
+			}
=20
 		}
+		local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
=20
 		rps_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
@@ -5989,8 +6000,10 @@ static int process_backlog(struct napi_struct *napi,=
 int quota)
 			napi->state =3D 0;
 			again =3D false;
 		} else {
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
 		rps_unlock_irq_enable(sd);
 	}
--=20
2.43.0


