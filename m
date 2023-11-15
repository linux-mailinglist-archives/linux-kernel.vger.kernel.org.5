Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D337ED571
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbjKOVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjKOVFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D31FCF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700082324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZWbb/+eDgG0atuQ38aYev5bIE4pYcaQchWWHhx2Blc=;
        b=GTMOhZLexJWYx8id1bAeNBpyh1erf47gdBca5gi4ax9OGedtjyhrmP5GWqW742pk8nmUpp
        EtjwMYhW0oMoINTsuOfY9M3Mw8/sPIQp4/2AJLNO41tKvbAMTNmzWhAdr7YkWahNzLWiY2
        hai7/cuoEAGCNBI2eva9iQmAfBOceI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-XGvM-rMCNRyi4TK39J8Tmg-1; Wed,
 15 Nov 2023 16:05:20 -0500
X-MC-Unique: XGvM-rMCNRyi4TK39J8Tmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 574AE3C0E643;
        Wed, 15 Nov 2023 21:05:19 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.22.34.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A45D3D6;
        Wed, 15 Nov 2023 21:05:19 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
Date:   Wed, 15 Nov 2023 16:05:08 -0500
Message-ID: <20231115210509.481514-2-vschneid@redhat.com>
In-Reply-To: <20231115210509.481514-1-vschneid@redhat.com>
References: <20231115210509.481514-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index dd37a5bf68811..f9b2bbedf1cfc 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -144,6 +144,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
+	/* Step 2: Hash TW into tcp ehash chain */
 	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
@@ -152,16 +153,15 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
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
 
@@ -207,7 +207,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -232,6 +232,16 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
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
index a9807eeb311ca..48eb0310fe837 100644
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
2.41.0

