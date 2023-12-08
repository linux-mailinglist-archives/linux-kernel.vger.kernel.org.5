Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02280ABE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjLHSSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:18:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A196590
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:18:09 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qcXcYZ78xdrELxs09VB+XM+fkJMkkTc/dXg5CeMfwc=;
        b=zuUccWji8Yvvt6S2JoRAkpCU22iQ/oG073f7BGW8OALPeQFyRsSLoweMFQcJtHMZm9Xvdp
        fjs0b7uym9xVfUMEtTTTsm6JkHjwFQ8Ui8hDe7GSwWkKFBzHpWn8zehHbZNk3WZYSCotCi
        pWYpzNoNDblvYUN4mJieR9D2SpdNHSVHR+pEvGElJhjThbd8GX45s3Gf8F5UvGb2E8vltO
        copfWNE+qF8vOS+x9LRSZw+HXZihvZ3FmRxhSdJZKbOU4I7B9DmrcK7wt5qGvytFSpJoJf
        CTqUyL7+zNNVyqyPZN5yGx24sPaURhp93Qq1+Cv8Hn6BuycwxdWGo6pDWqTj1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qcXcYZ78xdrELxs09VB+XM+fkJMkkTc/dXg5CeMfwc=;
        b=ZAc3EytwEBi27PBPeiZ+KWkDDfOW9c+isJ6HhVsEL9b5QWuJ4/4aPwdF7Jo16Qmf2oXbp3
        P7gEEcvUhsbtoABg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
Message-ID: <20231208181805.BbFDsoJe@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-31-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..05cd8f1bc45d
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1636 @@
=E2=80=A6
> + * Required event and timerqueue update after a remote expiry:
> + * -----------------------------------------------------------
> + *
> + * After a remote expiry of a CPU, a walk through the hierarchy updating=
 the
> + * events and timerqueues has to be done when there is a 'new' global ti=
mer of
> + * the remote CPU (which is obvious) but also if there is no new global =
timer,
> + * but the remote CPU is still idle:

After expiring timers of a remote CPU, a walk through the hierarchy and
updating events timerqueues is required. It is obviously needed if there
is a 'new' global timer but also if there no new global timer but the
remote CPU is still idle.

> + * 1. CPU2 is the migrator and does the remote expiry in GRP1:0; expiry =
of
> + *    evt-CPU0 and evt-CPU1 are equal:

       CPU0 and CPU1 have both a timer expiring at the same time so both
       have an event enqueued in the timerqueue. CPU2 and CPU3 have no
       global timer pending and CPU2 is the only active CPU and also the
       migrator.

> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:1
> + *                 --> timerqueue =3D evt-GRP0:0
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D TMIGR_NONE     migrator =3D CPU2
> + *           active   =3D                active   =3D CPU2
> + *           groupevt.ignore =3D false   groupevt.ignore =3D true
> + *           groupevt.cpu =3D CPU0       groupevt.cpu =3D
> + *           timerqueue =3D evt-CPU0,    timerqueue =3D
> + *                        evt-CPU1
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        idle           active      idle
> + *
> + * 2. Remove the first event of the timerqueue in GRP1:0 and expire the =
timers
> + *    of CPU0 (see evt-GRP0:0->cpu value):

      CPU2 begins to expire remote timers. It starts with own group
      GRP0:1. GRP0:1 has nothing in ts timerqueue and continues with its
      parent, GRP1:0. In GRP1:0 it dequeues the first event. It looks at
      CPU member expires the pending timer of CPU0.

> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:1
> + *                 --> timerqueue =3D
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D TMIGR_NONE     migrator =3D CPU2
> + *           active   =3D                active   =3D CPU2
> + *           groupevt.ignore =3D false   groupevt.ignore =3D true
> + *       --> groupevt.cpu =3D CPU0       groupevt.cpu =3D
> + *           timerqueue =3D evt-CPU0,    timerqueue =3D
> + *                        evt-CPU1
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        idle           active      idle
> + *
> + * 3. After the remote expiry CPU0 has no global timer that needs to be
> + *    enqueued. When skipping the walk, the global timer of CPU1 is not =
handled,
> + *    as the group event of GRP0:0 is not updated and not enqueued into =
GRP1:0. The
> + *    walk has to be done to update the group events and timerqueues:

     The work isn't over after expiring timers of CPU0. If we stop
     here, then CPU1's timer have not been expired and the timerqueue of
     GRP0:0 has still an event for CPU0 enqueued which has just been
     processed. So it is required to walk the hierarchy from CPU0's
     point of view and update it accordingly.
     CPU0 will be removed from the timerqueue because it has no pending
     timer. If CPU0 would have a timer pending then it has to expire
     after CPU1's first timer because all timer from this period have
     just been expired.
     Either way CPU1 will be first in GRP0:0's timerqueue and therefore
     set in the CPU field of the group event which is enqueued in
     GRP1:0's timerqueue.

> + *    LVL 1            [GRP1:0]
> + *                     migrator =3D GRP0:1
> + *                     active   =3D GRP0:1
> + *                 --> timerqueue =3D evt-GRP0:0
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D TMIGR_NONE     migrator =3D CPU2
> + *           active   =3D                active   =3D CPU2
> + *           groupevt.ignore =3D false   groupevt.ignore =3D true
> + *       --> groupevt.cpu =3D CPU1       groupevt.cpu =3D
> + *       --> timerqueue =3D evt-CPU1     timerqueue =3D
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        idle           active      idle
> + *
> + * Now CPU2 (migrator) is able to handle the timer of CPU1 as CPU2 only =
scans
> + * the timerqueues of GRP0:1 and GRP1:0.

    Now CPU2 continues step 2 at GRP1:0 and will expire the timer of
    CPU1.

> + * The update of step 3 is valid to be skipped, when the remote CPU went=
 offline
> + * in the meantime because an update was already done during inactive pa=
th. When
> + * CPU became active in the meantime, update isn't required as well, bec=
ause
> + * GRP0:0 is now longer idle.

   The hierarchy walk in step 3 can be skipped if the migrator notices
   that a CPU of GRP0:0 is active. The CPU will mark GRP0:0 active and
   take care of the group and any needed updates within the hierarchy.

I skipped the "offline" part because it is not needed. Before the CPU
can go offline it has first to come out of idle. While going offline it
won't (probably) participate here and the remaining timer will be
migrated to another CPU.

> + */
=E2=80=A6
> +
> +typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
> +
> +static void __walk_groups(up_f up, void *data,
> +			  struct tmigr_cpu *tmc)
> +{
> +	struct tmigr_group *child =3D NULL, *group =3D tmc->tmgroup;
> +
> +	do {
> +		WARN_ON_ONCE(group->level >=3D tmigr_hierarchy_levels);
> +
> +		if (up(group, child, data))
> +			break;
> +
> +		child =3D group;
> +		group =3D group->parent;
> +	} while (group);
> +}
> +
> +static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
> +{
> +	lockdep_assert_held(&tmc->lock);
> +
> +	__walk_groups(up, data, tmc);
> +}

So these two. walk_groups() uses all have tmigr_cpu::lock acquired and
__walk_groups() don't. Also the `up' function passed walk_groups() has
always the same data type while the data argument passed to
__walk_groups() has also the same type but different compared to the
former.

Given the locking situation and the type of the data argument looks like
walk_groups() is used for thing#1 and __walk_groups() for thing#2.
Therefore it could make sense have two separate functions (instead of
walk_groups() and __walk_groups()) to distinguish this.
Now it is too late but maybe later I figure out why the one type
requires locking and the other doesn't.

=E2=80=A6
> +/*
> + * Return the next event which is already expired of the group timerqueue
> + *
> + * Event, which is returned, is also removed from the queue.
> + */
> +static struct tmigr_event *tmigr_next_expired_groupevt(struct tmigr_grou=
p *group,
> +						     u64 now)
> +{
> +	struct tmigr_event *evt =3D tmigr_next_groupevt(group);
> +
> +	if (!evt || now < evt->nextevt.expires)
> +		return NULL;
> +
> +	/*
> +	 * The event is already expired. Remove it. If it's not the last event,
> +	 * then update all group event related information.
> +	 */

  The event expired, remove it. Update group's next expire time.

> +	if (timerqueue_del(&group->events, &evt->nextevt))
> +		tmigr_next_groupevt(group);
> +	else
> +		WRITE_ONCE(group->next_expiry, KTIME_MAX);

And then you can invoke tmigr_next_groupevt() unconditionally.

> +	return evt;
> +}
> +

Sebastian
