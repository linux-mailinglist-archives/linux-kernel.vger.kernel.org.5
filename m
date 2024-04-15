Return-Path: <linux-kernel+bounces-144994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BDA8A4DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391501F23091
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D46A031;
	Mon, 15 Apr 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/V7tALp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0B67A0A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180909; cv=none; b=kGd04pISLJ096+fv3I5uBIXxqgBhDV3PFp2gggWuXLroLslA4eicD6i8jy+GCD/eVzeRLA2RKXAcCA4/Z+7JriibMESCVMWNGjTkvHt72LqtTlIM1HVyYRrtL9apHnbhqwjx+C/k2Q5QrBTfviadejvUBxn7/qHSoc82LdZI+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180909; c=relaxed/simple;
	bh=st9rueJJE/E+kECJZK5RAvKXy5xFFjU4dzJnO6U1R/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfXNlzvzKi6+NTuIYUpW207F0k/LPFy79EeOcQ1eNyKzYFgWsHKNk7oNwEfuqXkA5WpVwhs9hwQB/BE3HrgU6qaL9i1+JgsGGoiB4vKDG2EzmRq47ogLnIT6SGRxT53YoMl/NlzLgw12VWASlYjAhN52L6MOwDjg9cC2BSkJinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/V7tALp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713180906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqhmKrYfV//Q+UEBRlZmTN84xreN6GieAMgq8Wr615k=;
	b=a/V7tALpQPGDVm7dg7G/O+zY1RfhYcDTg5D17Hv7Ex5WWIuNJ8drElUanGrwTctaFCKeJc
	EjnihBmw1qjNUc0w+J7KV71L/akWTPDfscbqqsH93+M2tl8qKEWPs6TnrS43rvOjKpvIUj
	cjAvHuMZkwvb9n4IwF4S6rjE3NAfNzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-aqh76rrpN5WZWRiKHjz2GQ-1; Mon, 15 Apr 2024 07:35:03 -0400
X-MC-Unique: aqh76rrpN5WZWRiKHjz2GQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FAE68007BA;
	Mon, 15 Apr 2024 11:35:02 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B81E1C06701;
	Mon, 15 Apr 2024 11:34:59 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: dccp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	mleitner@redhat.com,
	David Ahern <dsahern@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 2/2] tcp/dcpp: Un-pin tw_timer
Date: Mon, 15 Apr 2024 13:34:36 +0200
Message-ID: <20240415113436.3261042-3-vschneid@redhat.com>
In-Reply-To: <20240415113436.3261042-1-vschneid@redhat.com>
References: <20240415113436.3261042-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Context
=======

The TCP timewait timer is proving to be problematic for setups where scheduler
CPU isolation is achieved at runtime via cpusets (as opposed to statically via
isolcpus=domains).

What happens there is a CPU goes through tcp_time_wait(), arming the time_wait
timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causing
interference for the now-isolated CPU. This is conceptually similar to the issue
described in
  e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()")

Changes
=======

Move inet_twsk_schedule() to within inet_twsk_hashdance(), with the ehash
lock held. Expand the lock's critical section from inet_twsk_kill() to
inet_twsk_deschedule_put(), serializing the scheduling vs descheduling of
the timer. IOW, this prevents the following race:

			     tcp_time_wait()
			       inet_twsk_hashdance()
  inet_twsk_deschedule_put()
    del_timer_sync()
			       inet_twsk_schedule()

Lastly, to prevent the ehash lock from being taken both in timer context
and in timer deletion context (which leads to deadlocks), move the
inet_twsk_kill() from timer expiry context to workqueue context by changing
the tw_timer to a delayed_work.

Thanks to Paolo for suggesting to leverage the ehash lock.

Note on partial reverts
=======================

This partially reverts
  ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")

This also reinstores a comment from
  ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
as inet_twsk_hashdance() had a "Step 1" and "Step 3" comment, but the "Step
2" had gone missing.

Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/net/inet_timewait_sock.h |  6 ++--
 net/dccp/minisocks.c             |  9 +++--
 net/ipv4/inet_timewait_sock.c    | 59 +++++++++++++++++++++++---------
 net/ipv4/tcp_minisocks.c         |  9 +++--
 4 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index c4d64f1f8d415..93a50eed41872 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 					   struct inet_timewait_death_row *dr,
 					   const int state);
 
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			 struct inet_hashinfo *hashinfo);
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo);
 
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27adde..dd0b09553f142 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -58,11 +58,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
-		 */
-		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		 /* Linkage updates. */
+		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
+		 /* Access to tw after this point is illegal. */
+		inet_twsk_put(tw);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 7a2dcbaa1a61e..165b9cdf27e1a 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -44,14 +44,14 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	__sock_put((struct sock *)tw);
 }
 
-/* Must be called with locally disabled BHs. */
-static void inet_twsk_kill(struct inet_timewait_sock *tw)
+static void __inet_twsk_kill(struct inet_timewait_sock *tw, spinlock_t *lock)
+__releases(lock)
 {
 	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
-	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	spin_lock(lock);
+	lockdep_assert_held(lock);
+
 	sk_nulls_del_node_init_rcu((struct sock *)tw);
 	spin_unlock(lock);
 
@@ -71,6 +71,16 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 	inet_twsk_put(tw);
 }
 
+/* Must be called with locally disabled BHs. */
+static void inet_twsk_kill(struct inet_timewait_sock *tw)
+{
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	spin_lock(lock);
+	__inet_twsk_kill(tw, lock);
+}
+
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
 	struct module *owner = tw->tw_prot->owner;
@@ -97,8 +107,10 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
  * Essentially we whip up a timewait bucket, copy the relevant info into it
  * from the SK, and mess with hash chains and list linkage.
  */
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			   struct inet_hashinfo *hashinfo)
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
@@ -129,26 +141,33 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
+	/* Step 2: Hash TW into tcp ehash chain */
 	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 
-	spin_unlock(lock);
 
-	/* tw_refcnt is set to 3 because we have :
+	/* Ensure above writes are committed into memory before updating the
+	 * refcount.
+	 * Provides ordering vs later refcount_inc().
+	 */
+	smp_wmb();
+	/* tw_refcnt is set to 4 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
-	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
-	 * committed into memory all tw fields.
-	 * Also note that after this point, we lost our implicit reference
-	 * so we are not allowed to use tw anymore.
+	 * - one reference for ourself (our caller will release it).
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set(&tw->tw_refcnt, 4);
+
+	inet_twsk_schedule(tw, timeo);
+
+	spin_unlock(lock);
+
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
+EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
 static void tw_expiry_workfn(struct work_struct *work)
 {
@@ -219,8 +238,16 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (cancel_delayed_work_sync(&tw->tw_expiry_work))
-		inet_twsk_kill(tw);
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	spin_lock(lock);
+	if (cancel_delayed_work_sync(&tw->tw_expiry_work)) {
+		/* releases @lock */
+		__inet_twsk_kill(tw, lock);
+	} else {
+		spin_unlock(lock);
+	}
 	inet_twsk_put(tw);
 }
 EXPORT_SYMBOL(inet_twsk_deschedule_put);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f0761f060a837..77e2515409e40 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -343,11 +343,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
-		 */
-		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		/* Linkage updates. */
+		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, timeo);
+		 /* Access to tw after this point is illegal. */
+		inet_twsk_put(tw);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
-- 
2.43.0


