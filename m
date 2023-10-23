Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B87D436C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjJWXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:46:12 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5233FB0;
        Mon, 23 Oct 2023 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698104770; x=1729640770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6IQbCX9fLlRDyC0fHaQZbYHSmJfFdJaV56SaAgHF2w=;
  b=oeQxOF+tIGirfnaBd0e8ZGpS+y5o+vbqur+PsKqQ7cstRiC7+X0EQUVF
   R8sZAvrIMySEWFra6EtbiR634Sjwi101hR5vKPOQXJ/mrrWbqlBLPnrjo
   jP4BDQ3JoRvxDNOT1vZrmAVg19bsEk6LN/XZo/WpNHrIrCCywUwoD4hOR
   0=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="161744735"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:46:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id EB75E40D4B;
        Mon, 23 Oct 2023 23:46:06 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:30230]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.136:2525] with esmtp (Farcaster)
 id cd19f492-e93a-4694-93f8-18b2437fbd73; Mon, 23 Oct 2023 23:46:06 +0000 (UTC)
X-Farcaster-Flow-ID: cd19f492-e93a-4694-93f8-18b2437fbd73
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 23:46:06 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 23:46:03 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <ivan@cloudflare.com>
CC:     <edumazet@google.com>, <hdanton@sina.com>,
        <kernel-team@cloudflare.com>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date:   Mon, 23 Oct 2023 16:45:55 -0700
Message-ID: <20231023234555.75053-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABWYdi0j4yXWV6-Pr=2q7S6SQSZR7O6F61BLRdU=gDxvuQ3e1w@mail.gmail.com>
References: <CABWYdi0j4yXWV6-Pr=2q7S6SQSZR7O6F61BLRdU=gDxvuQ3e1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 23 Oct 2023 16:22:35 -0700
> On Fri, Oct 20, 2023 at 6:23 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> > >
> > > This could solve wait_for_unix_gc spinning, but it wouldn't affect
> > > unix_gc itself, from what I understand. There would always be one
> > > socket writer or destroyer punished by running the gc still.
> >
> > See what you want. The innocents are rescued by kicking a worker off.
> > Only for thoughts.
> >
> > --- x/net/unix/garbage.c
> > +++ y/net/unix/garbage.c
> > @@ -86,7 +86,6 @@
> >  /* Internal data structures and random procedures: */
> >
> >  static LIST_HEAD(gc_candidates);
> > -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
> >
> >  static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
> >                           struct sk_buff_head *hitlist)
> > @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
> >                 list_move_tail(&u->link, &gc_candidates);
> >  }
> >
> > -static bool gc_in_progress;
> > +static void __unix_gc(struct work_struct *w);
> > +static DECLARE_WORK(unix_gc_work, __unix_gc);
> > +
> >  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> >
> >  void wait_for_unix_gc(void)
> >  {
> >         /* If number of inflight sockets is insane,
> > -        * force a garbage collect right now.
> > -        * Paired with the WRITE_ONCE() in unix_inflight(),
> > -        * unix_notinflight() and gc_in_progress().
> > -        */
> > -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
> > -           !READ_ONCE(gc_in_progress))
> > -               unix_gc();
> > -       wait_event(unix_gc_wait, gc_in_progress == false);
> > +        * kick a garbage collect right now.
> > +        *
> > +        * todo s/wait_for_unix_gc/kick_unix_gc/
> > +        */
> > +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /2)
> > +               queue_work(system_unbound_wq, &unix_gc_work);
> >  }
> >
> > -/* The external entry point: unix_gc() */
> > -void unix_gc(void)
> > +static DEFINE_MUTEX(unix_gc_mutex);
> > +
> > +static void __unix_gc(struct work_struct *w)
> >  {
> >         struct sk_buff *next_skb, *skb;
> >         struct unix_sock *u;
> > @@ -211,15 +211,10 @@ void unix_gc(void)
> >         struct list_head cursor;
> >         LIST_HEAD(not_cycle_list);
> >
> > +       if (!mutex_trylock(&unix_gc_mutex))
> > +               return;
> >         spin_lock(&unix_gc_lock);
> >
> > -       /* Avoid a recursive GC. */
> > -       if (gc_in_progress)
> > -               goto out;
> > -
> > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > -       WRITE_ONCE(gc_in_progress, true);
> > -
> >         /* First, select candidates for garbage collection.  Only
> >          * in-flight sockets are considered, and from those only ones
> >          * which don't have any external reference.
> > @@ -325,11 +320,12 @@ void unix_gc(void)
> >         /* All candidates should have been detached by now. */
> >         BUG_ON(!list_empty(&gc_candidates));
> >
> > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > -       WRITE_ONCE(gc_in_progress, false);
> > -
> > -       wake_up(&unix_gc_wait);
> > -
> > - out:
> >         spin_unlock(&unix_gc_lock);
> > +       mutex_unlock(&unix_gc_mutex);
> > +}
> > +
> > +/* The external entry point: unix_gc() */
> > +void unix_gc(void)
> > +{
> > +       __unix_gc(NULL);
> >  }
> > --
> 
> This one results in less overall load than Kuniyuki's proposed patch
> with my repro:
> 
> * https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amazon.com/
> 
> My guess is that's because my repro is the one that is getting penalized there.

Thanks for testing, and yes.

It would be good to split the repro to one offender and one normal
process, run them on different users, and measure load on the normal
process.


> There's still a lot work done in unix_release_sock here, where GC runs
> as long as you have any fds inflight:
> 
> * https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L670
> 
> Perhaps it can be improved.

Yes, it also can be done async by worker as done in my first patch.
I replaced schedule_work() with queue_work() to avoid using system_wq
as gc could take long.

Could you try this ?

---8<---
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 824c258143a3..3b38e21116f1 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -13,6 +13,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
+void unix_gc_flush(void);
 void wait_for_unix_gc(void);
 struct sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..ed3251753417 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3683,6 +3683,7 @@ static int __init af_unix_init(void)
 
 static void __exit af_unix_exit(void)
 {
+	unix_gc_flush();
 	sock_unregister(PF_UNIX);
 	proto_unregister(&unix_dgram_proto);
 	proto_unregister(&unix_stream_proto);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31..51f30f89bacb 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -86,7 +86,9 @@
 /* Internal data structures and random procedures: */
 
 static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
+
+static void __unix_gc(struct work_struct *work);
+static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
@@ -185,24 +187,26 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 		list_move_tail(&u->link, &gc_candidates);
 }
 
-static bool gc_in_progress;
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_TRIGGER_GC 16
 
 void wait_for_unix_gc(void)
 {
+	struct user_struct *user = get_uid(current_user());
+
 	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
+	 * kick a garbage collect right now.
 	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
+	 * unix_notinflight().
 	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
+		queue_work(system_unbound_wq, &unix_gc_work);
+
+	/* Penalise senders of not-yet-received-fd */
+	if (READ_ONCE(user->unix_inflight))
+		flush_work(&unix_gc_work);
 }
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -213,13 +217,6 @@ void unix_gc(void)
 
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
@@ -325,11 +322,15 @@ void unix_gc(void)
 	/* All candidates should have been detached by now. */
 	BUG_ON(!list_empty(&gc_candidates));
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, false);
+	spin_unlock(&unix_gc_lock);
+}
 
-	wake_up(&unix_gc_wait);
+void unix_gc(void)
+{
+	queue_work(system_unbound_wq, &unix_gc_work);
+}
 
- out:
-	spin_unlock(&unix_gc_lock);
+void __exit unix_gc_flush(void)
+{
+	cancel_work_sync(&unix_gc_work);
 }
---8<---
