Return-Path: <linux-kernel+bounces-1370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E759814E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8FD1C23F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3241877;
	Fri, 15 Dec 2023 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nhI3f6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUEfwgSH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1845BFE;
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
	bh=Toc2vtgvKbxP7JJIcFsW6oVPRLsytfDxSXD/Hk+NeWo=;
	b=0nhI3f6gcBk6fYaPddmLQmpdI1cFuUqcxpgyaiwIbfgYEivTAKDISE/brK9x8nJdgFmqSL
	48GKYejHZoXx3++ZtokQT9V86HUYHKla4xynN49GIm15PEOfTlP79N1yveGkcKFDwu7qS/
	NsOiMbcdTNU5VEElELKd4MfkNYlt8dy58bM60OFufIEr9I/eygVklupILkhlVeQXFSaGrK
	SfQl6Z4zBeLK3kq5G0N703Xk1ad+FBMR0isHw6FDVkHt8XZebe5QdgWPtJ6nbIuj0eSKW+
	1iJ/NrCX8CLDT52p239zJLAAR3i+ovLtoFwAfEAE3sNtE3sO3gO7bJjlycs5WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Toc2vtgvKbxP7JJIcFsW6oVPRLsytfDxSXD/Hk+NeWo=;
	b=qUEfwgSHsHKNeeTb/p5aBGB0X6bF2Jdfh2GyXwf+Dm+LsQnvt4fu/ceTpV4b99wQNVCSMS
	h+WORWax33Z78OCQ==
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
Subject: [PATCH net-next 09/24] dev: Use the RPS lock for softnet_data::input_pkt_queue on PREEMPT_RT.
Date: Fri, 15 Dec 2023 18:07:28 +0100
Message-ID: <20231215171020.687342-10-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no additional locking in rps_lock_*() on PREEMPT_RT in the
!CONFIG_RPS case. The reasoning is that local_bh_disable() provides the
required synchronization (everywhere).
All interrupts are threaded and so the required CPU local
synchronization is provided by the per-CPU lock in local_bh_disable()
which is always performed for the forced-threaded interrupts.
Needless to say that the softirq users (NAPI) have BH disabled while
being invoked as a softirq callback.

Without locking in local_bh_disable() on PREEMPT_RT the
softnet_data::input_pkt_queue data structure requires explicit locking
in the !CONFIG_RPS case.

Disabling interrupts for CPU-local locking is undesired because it will
impose restrictions within the locked sections like not allowing to free
a skb.

Utilise the locking which is present in the CONFIG_RPS case for
serialisation on PREEMPT_RT even without CONFIG_RPS enabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c879246be48d8..09232080843ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -220,34 +220,34 @@ static inline struct hlist_head *dev_index_hash(struc=
t net *net, int ifindex)
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || IS_ENABLED(CONFIG_PREEMPT_RT))
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_save(*flags);
 }
=20
 static inline void rps_lock_irq_disable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || IS_ENABLED(CONFIG_PREEMPT_RT))
 		spin_lock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_disable();
 }
=20
 static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 					  unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || IS_ENABLED(CONFIG_PREEMPT_RT))
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_restore(*flags);
 }
=20
 static inline void rps_unlock_irq_enable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || IS_ENABLED(CONFIG_PREEMPT_RT))
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_enable();
 }
=20
--=20
2.43.0


