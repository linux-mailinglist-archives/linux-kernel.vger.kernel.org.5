Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C487F1D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTT3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:29:32 -0500
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D9CA;
        Mon, 20 Nov 2023 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700508569; x=1732044569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGQNVVdVH5hv/vMR3DPCBR5uvBA6F0M+M9XSRzxNYYc=;
  b=rvvCGORnaC3wIqh3eLftorOrOl0w7RVAE7gzM0MH77HztY+v1eo0LgCC
   Sq3WcHS6QzB9gwHoV7LSL4LbGZrQ7VebxJ2v0NIMWH6fqAGflwPa3AA8p
   4EczDDAyzdiWj9cS3fsGjR7AEqBbb9IQGl6nHVqupw63vCZmfr8KcVRJl
   s=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="167294987"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 19:29:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 4287C47655;
        Mon, 20 Nov 2023 19:29:25 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:45993]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 8bd9dfb6-2746-497f-9055-ff4387331616; Mon, 20 Nov 2023 19:29:24 +0000 (UTC)
X-Farcaster-Flow-ID: 8bd9dfb6-2746-497f-9055-ff4387331616
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 19:29:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 19:29:21 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <ivan@cloudflare.com>
CC:     <edumazet@google.com>, <hdanton@sina.com>,
        <kernel-team@cloudflare.com>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date:   Mon, 20 Nov 2023 11:29:13 -0800
Message-ID: <20231120192913.28629-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABWYdi2JmfMBK43KrkAGsz+MN8KyFSjg0QZv5G_cuA1k1c0f7w@mail.gmail.com>
References: <CABWYdi2JmfMBK43KrkAGsz+MN8KyFSjg0QZv5G_cuA1k1c0f7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 17 Nov 2023 15:38:42 -0800
> On Mon, Oct 23, 2023 at 4:46 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Ivan Babrou <ivan@cloudflare.com>
> > Date: Mon, 23 Oct 2023 16:22:35 -0700
> > > On Fri, Oct 20, 2023 at 6:23 PM Hillf Danton <hdanton@sina.com> wrote:
> > > >
> > > > On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> > > > >
> > > > > This could solve wait_for_unix_gc spinning, but it wouldn't affect
> > > > > unix_gc itself, from what I understand. There would always be one
> > > > > socket writer or destroyer punished by running the gc still.
> > > >
> > > > See what you want. The innocents are rescued by kicking a worker off.
> > > > Only for thoughts.
> > > >
> > > > --- x/net/unix/garbage.c
> > > > +++ y/net/unix/garbage.c
> > > > @@ -86,7 +86,6 @@
> > > >  /* Internal data structures and random procedures: */
> > > >
> > > >  static LIST_HEAD(gc_candidates);
> > > > -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
> > > >
> > > >  static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
> > > >                           struct sk_buff_head *hitlist)
> > > > @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
> > > >                 list_move_tail(&u->link, &gc_candidates);
> > > >  }
> > > >
> > > > -static bool gc_in_progress;
> > > > +static void __unix_gc(struct work_struct *w);
> > > > +static DECLARE_WORK(unix_gc_work, __unix_gc);
> > > > +
> > > >  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> > > >
> > > >  void wait_for_unix_gc(void)
> > > >  {
> > > >         /* If number of inflight sockets is insane,
> > > > -        * force a garbage collect right now.
> > > > -        * Paired with the WRITE_ONCE() in unix_inflight(),
> > > > -        * unix_notinflight() and gc_in_progress().
> > > > -        */
> > > > -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
> > > > -           !READ_ONCE(gc_in_progress))
> > > > -               unix_gc();
> > > > -       wait_event(unix_gc_wait, gc_in_progress == false);
> > > > +        * kick a garbage collect right now.
> > > > +        *
> > > > +        * todo s/wait_for_unix_gc/kick_unix_gc/
> > > > +        */
> > > > +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /2)
> > > > +               queue_work(system_unbound_wq, &unix_gc_work);
> > > >  }
> > > >
> > > > -/* The external entry point: unix_gc() */
> > > > -void unix_gc(void)
> > > > +static DEFINE_MUTEX(unix_gc_mutex);
> > > > +
> > > > +static void __unix_gc(struct work_struct *w)
> > > >  {
> > > >         struct sk_buff *next_skb, *skb;
> > > >         struct unix_sock *u;
> > > > @@ -211,15 +211,10 @@ void unix_gc(void)
> > > >         struct list_head cursor;
> > > >         LIST_HEAD(not_cycle_list);
> > > >
> > > > +       if (!mutex_trylock(&unix_gc_mutex))
> > > > +               return;
> > > >         spin_lock(&unix_gc_lock);
> > > >
> > > > -       /* Avoid a recursive GC. */
> > > > -       if (gc_in_progress)
> > > > -               goto out;
> > > > -
> > > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > > -       WRITE_ONCE(gc_in_progress, true);
> > > > -
> > > >         /* First, select candidates for garbage collection.  Only
> > > >          * in-flight sockets are considered, and from those only ones
> > > >          * which don't have any external reference.
> > > > @@ -325,11 +320,12 @@ void unix_gc(void)
> > > >         /* All candidates should have been detached by now. */
> > > >         BUG_ON(!list_empty(&gc_candidates));
> > > >
> > > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > > -       WRITE_ONCE(gc_in_progress, false);
> > > > -
> > > > -       wake_up(&unix_gc_wait);
> > > > -
> > > > - out:
> > > >         spin_unlock(&unix_gc_lock);
> > > > +       mutex_unlock(&unix_gc_mutex);
> > > > +}
> > > > +
> > > > +/* The external entry point: unix_gc() */
> > > > +void unix_gc(void)
> > > > +{
> > > > +       __unix_gc(NULL);
> > > >  }
> > > > --
> > >
> > > This one results in less overall load than Kuniyuki's proposed patch
> > > with my repro:
> > >
> > > * https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amazon.com/
> > >
> > > My guess is that's because my repro is the one that is getting penalized there.
> >
> > Thanks for testing, and yes.
> >
> > It would be good to split the repro to one offender and one normal
> > process, run them on different users, and measure load on the normal
> > process.
> >
> >
> > > There's still a lot work done in unix_release_sock here, where GC runs
> > > as long as you have any fds inflight:
> > >
> > > * https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L670
> > >
> > > Perhaps it can be improved.
> >
> > Yes, it also can be done async by worker as done in my first patch.
> > I replaced schedule_work() with queue_work() to avoid using system_wq
> > as gc could take long.
> >
> > Could you try this ?
> 
> Apologies for the long wait, I was OOO.
> 
> A bit of a problem here is that unix_gc is called unconditionally in
> unix_release_sock.

unix_release_sock() calls gc only when there is a inflight socket.


> It's done asynchronously now and it can only
> consume a single CPU with your changes, which is a lot better than
> before. I am wondering if we can still do better to only trigger gc
> when it touches unix sockets that have inflight fds.
> 
> Commit 3c32da19a858 ("unix: Show number of pending scm files of
> receive queue in fdinfo") added "struct scm_stat" to "struct
> unix_sock", which can be used to check for the number of inflight fds
> in the unix socket. Can we use that to drive the GC?

I don't think the stat is useful to trigger gc.  Unless the receiver
is accessible via sendmsg(), it's not a gc candidate and we need not
care about its stats about valid FDs that are ready to be processed
and never cleaned up by gc until close().


> I think we can:
> 
> * Trigger unix_gc from unix_release_sock if there's a non-zero number
> of inflight fds in the socket being destroyed.

This is the case of now.


> * Trigger wait_for_unix_gc from the write path only if the write
> contains fds or if the socket contains inflight fds. Alternatively, we
> can run gc at the end of the write path and only check for inflight
> fds on the socket there, which is probably simpler.

I don't think it's better to call gc at the end of sendmsg() as there
would be small chance to consume memory compared to running gc in the
beginning of sendmsg().


> GC only applies to unix sockets inflight of other unix sockets, so GC
> can still affect sockets passing regular fds around, but it wouldn't
> affect non-fd-passing unix sockets, which are usually in the data
> path.

I think we can run gc only when scm contains AF_UNIX sockets by tweaking
a little bit scm processing.


> This way we don't have to check for per-user inflight fds, which means
> that services running as "nobody" wouldn't be punished for other
> services running as "nobody" screwing up.

If we do not check user, a user could send 16000 AF_UNIX fds and
other innocent users sending fds must wait gc.

I think isolating users would make more sense so you can sandbox
a suspicious process.

Probably we can move flush_work() in the preceding if.  Then, the
number of gc invocation in the "nobody" case is the same as before.

---8<---
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 51f30f89bacb..74fc208c8858 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,12 +198,13 @@ void wait_for_unix_gc(void)
 	 * Paired with the WRITE_ONCE() in unix_inflight(),
 	 * unix_notinflight().
 	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC) {
 		queue_work(system_unbound_wq, &unix_gc_work);
 
-	/* Penalise senders of not-yet-received-fd */
-	if (READ_ONCE(user->unix_inflight))
-		flush_work(&unix_gc_work);
+		/* Penalise senders of not-yet-received-fd */
+		if (READ_ONCE(user->unix_inflight))
+			flush_work(&unix_gc_work);
+	}
 }
 
 static void __unix_gc(struct work_struct *work)
---8<---


> 
> Does this sound like a reasonable approach?
> 
[...]
> > -static bool gc_in_progress;
> > -#define UNIX_INFLIGHT_TRIGGER_GC 16000
> > +#define UNIX_INFLIGHT_TRIGGER_GC 16
> 
> It's probably best to keep it at 16k.

Oops, this is just for testing on my local machine easily :p

Anyway, I'll post a formal patch this week.

Thanks!
