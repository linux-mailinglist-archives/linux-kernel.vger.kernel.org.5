Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B617D18D2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJTWFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjJTWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:05:31 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A2D5A;
        Fri, 20 Oct 2023 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697839530; x=1729375530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrG7wAJTNfPv/EmdWc9yPkjGkJXDdRrLhNkNloKxEks=;
  b=KY+TWkPwLvC74ni7NxYw+22trriSyMToT82yQojM4/7BbbjluElCN6tk
   mERzXTx9L74Td6tj+eSbzqLNWpuNNP4nV+bns7RLyRxP4cMOYZ65FBlzQ
   boiVWjkAsiOD7FMCy83rNKhCqvO8denCg9Qp9Ywmq54xqm9bFnhFGxmdI
   g=;
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="247031581"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 22:05:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 0409083EBB;
        Fri, 20 Oct 2023 22:05:22 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:28453]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.182:2525] with esmtp (Farcaster)
 id f2e074f0-09d5-4b31-bdff-5b7c3ef7aa84; Fri, 20 Oct 2023 22:05:21 +0000 (UTC)
X-Farcaster-Flow-ID: f2e074f0-09d5-4b31-bdff-5b7c3ef7aa84
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 22:05:21 +0000
Received: from 88665a182662.ant.amazon.com (10.142.223.91) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Fri, 20 Oct 2023 22:05:19 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <ivan@cloudflare.com>
CC:     <edumazet@google.com>, <kernel-team@cloudflare.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date:   Fri, 20 Oct 2023 15:05:11 -0700
Message-ID: <20231020220511.45854-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
References: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.223.91]
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 19 Oct 2023 15:35:01 -0700
> Hello,
> 
> We have observed this issue twice (2019 and 2023): a well behaved
> service that doesn't pass any file descriptors around starts to spend
> a ton of CPU time in wait_for_unix_gc.
> 
> The cause of this is that the unix send path unconditionally calls
> wait_for_unix_gc, which is a global garbage collection. If any
> misbehaved program exists on a system, it can force extra work for
> well behaved programs.
> 
> This behavior is not new: 9915672d4127 ("af_unix: limit
> unix_tot_inflight") is from 2010.
> 
> I managed to come up with a repro for this behavior:
> 
> * https://gist.github.com/bobrik/82e5722261920c9f23d9402b88a0bb27
> 
> It also includes a flamegraph illustrating the issue. It's all in one
> program for convenience, but in reality the offender not picking up
> SCM_RIGHTS messages and the suffering program just minding its own
> business are separate.
> 
> It is also non-trivial to find the offender when this happens as it
> can be completely idle while wrecking havoc for the rest of the
> system.
> 
> I don't think it's fair to penalize every unix_stream_sendmsg like
> this. The 16k threshold also doesn't feel very flexible, surely
> computers are bigger these days and can handle more.

Probably we could do the gc async and enforce the penalty only on
the offender by checking user->unix_inflight.

compile test only:

---8<---
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 824c258143a3..a119f37953cc 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -12,8 +12,9 @@ void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
-void unix_gc(void);
 void wait_for_unix_gc(void);
+void unix_gc_start(void);
+void unix_gc_stop(void);
 struct sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..56db096b13f1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -681,7 +681,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 */
 
 	if (READ_ONCE(unix_tot_inflight))
-		unix_gc();		/* Garbage collect fds */
+		unix_gc_start(); /* Garbage collect fds */
 }
 
 static void init_peercred(struct sock *sk)
@@ -3683,6 +3683,7 @@ static int __init af_unix_init(void)
 
 static void __exit af_unix_exit(void)
 {
+	unix_gc_stop();
 	sock_unregister(PF_UNIX);
 	proto_unregister(&unix_dgram_proto);
 	proto_unregister(&unix_stream_proto);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31..fb24d62fe34a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -185,24 +185,26 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 		list_move_tail(&u->link, &gc_candidates);
 }
 
-static bool gc_in_progress;
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
 
+static void unix_gc(struct work_struct *work);
+static DECLARE_WORK(unix_gc_work, unix_gc);
+
 void wait_for_unix_gc(void)
 {
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	struct user_struct *user = get_uid(current_user());
+
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
+		schedule_work(&unix_gc_work);
+
+	if (!READ_ONCE(user->unix_inflight))
+		return;
+
+	flush_work(&unix_gc_work);
 }
 
 /* The external entry point: unix_gc() */
-void unix_gc(void)
+static void unix_gc(struct work_struct *work)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -213,13 +215,6 @@ void unix_gc(void)
 
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -325,11 +320,15 @@ void unix_gc(void)
 	/* All candidates should have been detached by now. */
 	BUG_ON(!list_empty(&gc_candidates));
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, false);
+	spin_unlock(&unix_gc_lock);
+}
 
-	wake_up(&unix_gc_wait);
+void unix_gc_start(void)
+{
+	schedule_work(&unix_gc_work);
+}
 
- out:
-	spin_unlock(&unix_gc_lock);
+void __exit unix_gc_stop(void)
+{
+	flush_work(&unix_gc_work);
 }
---8<---
