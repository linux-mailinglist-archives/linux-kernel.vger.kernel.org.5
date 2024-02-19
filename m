Return-Path: <linux-kernel+bounces-71078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642C85A064
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDB1C213FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266B286A7;
	Mon, 19 Feb 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM15YK7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30625576
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336675; cv=none; b=NnpJrCimwv1BDvOywqgS5ThaRoypGuzurzcHjOUPE/t5vUKWRehDtooeBdQqJ66bh+j7Q0KGJJ0DCvCemsKTf0qYJZwhBsZLdud9qJAENNpYif/lL5RYNj+R3Fak3Q4lDUVM4hNInGRdvUOrKTZG5911MnUOkO3SqeTgjNA0U4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336675; c=relaxed/simple;
	bh=YWtKx2O3pBA0lGfRBWwjDhDm98pJPR+USEQvuRijvOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlzBALBfzCm5JPh9kCFkfOxLsbMjccu+pE+Crhs5y21pEPwlGmLcp1HZndLHZQhIjeAs9p+w854JaOwYHx3Pxdv8+OV/tbcH/bEXUzEvFpU8FRdK/4Jg9cpSx3bik8XwVT75qBnx4v1KFQUIF75WkXSApvuc3g85oOrPV0/uiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM15YK7M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708336673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wH9/zcY66PkeYIPPKbdhw73LeuGYuR8q0E4eIgIykU=;
	b=fM15YK7MIekMPTnXlL5KCEcSyLwqGKyp9gRBHw2O1uzLkvnvd3j8CnxAr+surCCNxSBe89
	SlmUMc2OJGQOlogi4vMSDzjrXQzp2DdwlcqiisKPl5sEQ3m7FfkrKNw9z+qlzh3i7JSD18
	yuJQV9w2kdXH5pI6faaLJrh0tQ6zYQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-XYExWCGFMB6QReqxOIpI3A-1; Mon, 19 Feb 2024 04:57:49 -0500
X-MC-Unique: XYExWCGFMB6QReqxOIpI3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C9B185A782;
	Mon, 19 Feb 2024 09:57:49 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 979418077;
	Mon, 19 Feb 2024 09:57:46 +0000 (UTC)
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
Subject: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
Date: Mon, 19 Feb 2024 10:57:29 +0100
Message-ID: <20240219095729.2339914-2-vschneid@redhat.com>
In-Reply-To: <20240219095729.2339914-1-vschneid@redhat.com>
References: <20240219095729.2339914-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The TCP timewait timer is proving to be problematic for setups where scheduler
CPU isolation is achieved at runtime via cpusets (as opposed to statically via
isolcpus=domains).

What happens there is a CPU goes through tcp_time_wait(), arming the time_wait
timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causing
interference for the now-isolated CPU. This is conceptually similar to the issue
described in
  e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()")

Keep softirqs disabled, but make the timer un-pinned and arm it *after* the
hashdance.

This introduces the following (non-fatal) race:

  CPU0                        CPU1
    allocates a tw
    insert it in hash table
				finds the TW and removes it
				(timer cancel does nothing)
    arms a TW timer, lasting

This partially reverts
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
and
  ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")

This also reinstores a comment from
  ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
as inet_twsk_hashdance() had a "Step 1" and "Step 3" comment, but the "Step
2" had gone missing.

Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 net/dccp/minisocks.c          | 16 +++++++---------
 net/ipv4/inet_timewait_sock.c | 20 +++++++++++++++-----
 net/ipv4/tcp_minisocks.c      | 16 +++++++---------
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27adde..2f0fad4255e36 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == DCCP_TIME_WAIT)
 			timeo = DCCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
-		 */
+	       local_bh_disable();
+
+		// Linkage updates
 		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		inet_twsk_schedule(tw, timeo);
+		// Access to tw after this point is illegal.
+		inet_twsk_put(tw);
+
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b241..61a053fbd329c 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -129,6 +129,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
+	/* Step 2: Hash TW into tcp ehash chain */
 	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
@@ -137,16 +138,15 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_unlock(lock);
 
-	/* tw_refcnt is set to 3 because we have :
+	/* tw_refcnt is set to 4 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
+	 * - one reference for ourself (our caller will release it).
 	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
 	 * committed into memory all tw fields.
-	 * Also note that after this point, we lost our implicit reference
-	 * so we are not allowed to use tw anymore.
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set(&tw->tw_refcnt, 4);
 }
 EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
 
@@ -192,7 +192,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -217,6 +217,16 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
+	/* This can race with tcp_time_wait() and dccp_time_wait(), as the timer
+	 * is armed /after/ adding it to the hashtables.
+	 *
+	 * If this is interleaved between inet_twsk_hashdance() and inet_twsk_put(),
+	 * then this is a no-op: the timer will still end up armed.
+	 *
+	 * Conversely, if this successfully deletes the timer, then we know we
+	 * have already gone through {tcp,dcpp}_time_wait(), and we can safely
+	 * call inet_twsk_kill().
+	 */
 	if (del_timer_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd4..54e025ba9b015 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -338,16 +338,14 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		if (state == TCP_TIME_WAIT)
 			timeo = TCP_TIMEWAIT_LEN;
 
-		/* tw_timer is pinned, so we need to make sure BH are disabled
-		 * in following section, otherwise timer handler could run before
-		 * we complete the initialization.
-		 */
-		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
-		/* Linkage updates.
-		 * Note that access to tw after this point is illegal.
-		 */
+	       local_bh_disable();
+
+		// Linkage updates.
 		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_schedule(tw, timeo);
+		// Access to tw after this point is illegal.
+		inet_twsk_put(tw);
+
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
-- 
2.43.0


