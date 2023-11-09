Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20E17E69C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjKILgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjKILg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:36:29 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6352D69;
        Thu,  9 Nov 2023 03:36:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so817542b3a.2;
        Thu, 09 Nov 2023 03:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699529787; x=1700134587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FqbWiyXG216kDW0jojJTcyqxwv5dDcG06yvulcVnls=;
        b=IOkW+JzBO1bcPMWDpK+g+2YXnAvTwb4i9ToiAmkTwQiBt9Cke0ShYby1y2qBQnOwfR
         GCuz6ZojYSJ4wpt1miZtEVSqICAlCX1OD7lO3kLVtbjKy5/K4wkMYGGnx6jeojX8JCBE
         +wQbqNREAjysDyYv2wejsvYqnJQitsgBCj5ozZLtduB7zGV9w9ILWsRdNG0Xr2j8Udgk
         WCcyotrTJQNoR315nAyWiP0c/+6h/xT/IKB6NtCBaa3Y4hUwuqHCKz0MFIWbly2oJi9c
         p+NHqA1vc31eKsO1cAaHseI5H5VSveFJ7cLpf2yhuLkCnuwlpeltIdQevpAnWtSRkg44
         PLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529787; x=1700134587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FqbWiyXG216kDW0jojJTcyqxwv5dDcG06yvulcVnls=;
        b=It6LL1WkTYCattLhCe/an97RmLrYpLK4aM3WavsOX+zd3UR8W/RmpVH2qFa7bjQlGY
         v/25fSXaLUTEkQbi8aYBPyO+AOjQNlkN1V7RtgZb7o8hs/39qXN2BMqxrGBX5r/9RFTs
         Hqc5U8U+3C7OsB1xYyhujcAf1/FEbBxWrqxRNYMaHyMZvMVX2MTh3LhjflHw4F3A8tQ8
         UgDvnpK6kQdQYfU/7GPgwAxGJil6T7TzA7+1B3qx2YDWZ7L/lEC4DY0uuBtfZ3xDrVIO
         WU5NwR25GGQ3hw4ccWpSYE3yEDBZO0Lp+CHqRqQ4l/DJB5zLFXCc21ECVpZlC1HOS2dw
         xKJA==
X-Gm-Message-State: AOJu0Yxre8VE3A0UxMprOu9V8/N1EeX98faWE6D4le69hLoMWQGqE8uh
        KYj5yRs9KvVGa+ERHZu7LrNeMYWgHQctHyYAtAA=
X-Google-Smtp-Source: AGHT+IGzAkDLHqLHNP6zHSk3pjn7ICaNTT1Xf1zlINxTX5LTqrxADqS6H6WuG7u8GqaCAoIrCfS3coH4XpPV3VYr4dc=
X-Received: by 2002:a05:6a20:8e10:b0:183:c7ea:bb52 with SMTP id
 y16-20020a056a208e1000b00183c7eabb52mr5467691pzj.30.1699529786970; Thu, 09
 Nov 2023 03:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20231030131254.488186-1-urezki@gmail.com> <20231030131254.488186-2-urezki@gmail.com>
In-Reply-To: <20231030131254.488186-2-urezki@gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 9 Nov 2023 19:36:14 +0800
Message-ID: <CALm+0cWOV+7t2JOa29YgLb1vbg9W34Zf5jyi3DVXKGv0V2MC=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rcu: Reduce synchronize_rcu() latency
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> A call to a synchronize_rcu() can be optimized from a latency
> point of view. Workloads which depend on this can benefit of it.
>
> The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> depends on several factors:
>
> - how fast a process of offloading is started. Combination of:
>     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
>     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
>     - other.
> - when started, invoking path is interrupted due to:
>     - time limit;
>     - need_resched();
>     - if limit is reached.
> - where in a nocb list it is located;
> - how fast previous callbacks completed;
>
> Example:
>
> 1. On our embedded devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
>
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> <snip>
>
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
>
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
>
> cgroup_attach_task():
>  -> cgroup_migrate_execute()
>    -> cpuset_can_attach()
>      -> percpu_down_write()
>        -> rcu_sync_enter()
>          -> synchronize_rcu()
>    -> now move tasks to the new cgroup.
>  -> cgroup_migrate_finish()
>
> <snip>
>          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
>     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
>    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> <snip>
>
> "Boosting a task" depends on synchronize_rcu() latency:
>
> - first trace shows a completion of synchronize_rcu();
> - second shows attaching a task to a new group;
> - last shows a final step when migration occurs.
>
> 3. To address this drawback, maintain a separate track that consists
> of synchronize_rcu() callers only. After completion of a grace period
> users are awaken directly, it is limited by allowed threshold, others
> are deferred(if still exist) to a worker to complete the rest.
>
> 4. This patch reduces the latency of synchronize_rcu() approximately
> by ~30-40% on synthetic tests. The real test case, camera launch time,
> shows(time is in milliseconds):
>
> 1-run 542 vs 489 improvement 9%
> 2-run 540 vs 466 improvement 13%
> 3-run 518 vs 468 improvement 9%
> 4-run 531 vs 457 improvement 13%
> 5-run 548 vs 475 improvement 13%
> 6-run 509 vs 484 improvement 4%
>
> Synthetic test:
>
> Hardware: x86_64 64 CPUs, 64GB of memory
>
> - 60K tasks(simultaneous);
> - each task does(1000 loops)
>      synchronize_rcu();
>      kfree(p);
>
> default: CONFIG_RCU_NOCB_CPU: takes 323 seconds to complete all users;
> patch: CONFIG_RCU_NOCB_CPU: takes 240 seconds to complete all users.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c     | 154 +++++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_exp.h |   2 +-
>  2 files changed, 154 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 78554e7181dd..f04846b543de 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1384,6 +1384,125 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>                 raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>
> +/*
> + * There are three lists for handling synchronize_rcu() users.
> + * A first list corresponds to new coming users, second for users
> + * which wait for a grace period and third is for which a grace
> + * period is passed.
> + */
> +static struct sr_normal_state {
> +       struct llist_head srs_next;     /* request a GP users. */
> +       struct llist_head srs_wait;     /* wait for GP users. */
> +       struct llist_head srs_done;     /* ready for GP users. */
> +
> +       /*
> +        * In order to add a batch of nodes to already
> +        * existing srs-done-list, a tail of srs-wait-list
> +        * is maintained.
> +        */
> +       struct llist_node *srs_wait_tail;
> +} sr;
> +
> +/* Disabled by default. */
> +static int rcu_normal_wake_from_gp;
> +module_param(rcu_normal_wake_from_gp, int, 0644);
> +
> +static void rcu_sr_normal_complete(struct llist_node *node)
> +{
> +       struct rcu_synchronize *rs = container_of(
> +               (struct rcu_head *) node, struct rcu_synchronize, head);
> +       unsigned long oldstate = (unsigned long) rs->head.func;
> +
> +       WARN_ONCE(!poll_state_synchronize_rcu(oldstate),
> +               "A full grace period is not passed yet: %lu",
> +               rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> +
> +       /* Finally. */
> +       complete(&rs->completion);
> +}
> +
> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> +{
> +       struct llist_node *done, *rcu, *next;
> +
> +       done = llist_del_all(&sr.srs_done);
> +       if (!done)
> +               return;
> +
> +       llist_for_each_safe(rcu, next, done)
> +               rcu_sr_normal_complete(rcu);
> +}
> +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> +
> +/*
> + * This is hard-coded and it is a maximum number of
> + * synchronize_rcu() users(might be +1 extra), which
> + * are awaken directly by the rcu_gp_kthread(). The
> + * reset is deferred to a dedicated worker.
> + */
> +#define MAX_SR_WAKE_FROM_GP 5
> +
> +/*
> + * Helper function for rcu_gp_cleanup().
> + */
> +static void rcu_sr_normal_gp_cleanup(void)
> +{
> +       struct llist_node *head, *tail, *pos;
> +       int i = 0;
> +
> +       if (llist_empty(&sr.srs_wait))
> +               return;
> +
> +       tail = READ_ONCE(sr.srs_wait_tail);
> +       head = __llist_del_all(&sr.srs_wait);
> +
> +       llist_for_each_safe(pos, head, head) {
> +               rcu_sr_normal_complete(pos);
> +
> +               if (++i == MAX_SR_WAKE_FROM_GP) {
> +                       /* If last, process it also. */
> +                       if (head && !head->next)
> +                               continue;
> +                       break;
> +               }
> +       }
> +
> +       if (head) {
> +               /* Can be not empty. */
> +               llist_add_batch(head, tail, &sr.srs_done);
> +               queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> +       }
> +}
> +
> +/*
> + * Helper function for rcu_gp_init().
> + */
> +static void rcu_sr_normal_gp_init(void)
> +{
> +       struct llist_node *head, *tail;
> +
> +       if (llist_empty(&sr.srs_next))
> +               return;
> +
> +       tail = llist_del_all(&sr.srs_next);
> +       head = llist_reverse_order(tail);
> +
> +       /*
> +        * A waiting list of GP should be empty on this step,
> +        * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> +        * rolls it over. If not, it is a BUG, warn a user.
> +        */
> +       WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> +
> +       WRITE_ONCE(sr.srs_wait_tail, tail);
> +       __llist_add_batch(head, tail, &sr.srs_wait);
> +}
> +
> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> +{
> +       llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> +}
> +
>  /*
>   * Initialize a new grace period.  Return false if no grace period required.
>   */
> @@ -1418,6 +1537,7 @@ static noinline_for_stack bool rcu_gp_init(void)
>         /* Record GP times before starting GP, hence rcu_seq_start(). */
>         rcu_seq_start(&rcu_state.gp_seq);
>         ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> +       rcu_sr_normal_gp_init();
>         trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>         rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>         raw_spin_unlock_irq_rcu_node(rnp);
> @@ -1787,6 +1907,9 @@ static noinline void rcu_gp_cleanup(void)
>         }
>         raw_spin_unlock_irq_rcu_node(rnp);
>
> +       // Make synchronize_rcu() users aware of the end of old grace period.
> +       rcu_sr_normal_gp_cleanup();
> +
>         // If strict, make all CPUs aware of the end of the old grace period.
>         if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>                 on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> @@ -3500,6 +3623,35 @@ static int rcu_blocking_is_gp(void)
>         return true;
>  }
>
> +/*
> + * Helper function for the synchronize_rcu() API.
> + */
> +static void synchronize_rcu_normal(void)
> +{
> +       struct rcu_synchronize rs;
> +
> +       if (READ_ONCE(rcu_normal_wake_from_gp)) {
> +               init_rcu_head_on_stack(&rs.head);
> +               init_completion(&rs.completion);
> +
> +               /*
> +                * This code might be preempted, therefore take a GP
> +                * snapshot before adding a request.
> +                */
> +               rs.head.func = (void *) get_state_synchronize_rcu();
> +               rcu_sr_normal_add_req(&rs);
> +
> +               /* Kick a GP and start waiting. */
> +               (void) start_poll_synchronize_rcu();
> +

Before invoking rcu_sr_normal_add_req(), can we add the following judgment?

  if (poll_state_synchronize_rcu((unsigned long)rs.head.func)) {
                   complete(&rs->completion);
   } else {
                 rcu_sr_normal_add_req(&rs);
                 (void) start_poll_synchronize_rcu();
   }

Thanks
Zqiang


> +               /* Now we can wait. */
> +               wait_for_completion(&rs.completion);
> +               destroy_rcu_head_on_stack(&rs.head);
> +       } else {
> +               wait_rcu_gp(call_rcu_hurry);
> +       }
> +}
> +
>  /**
>   * synchronize_rcu - wait until a grace period has elapsed.
>   *
> @@ -3551,7 +3703,7 @@ void synchronize_rcu(void)
>                 if (rcu_gp_is_expedited())
>                         synchronize_rcu_expedited();
>                 else
> -                       wait_rcu_gp(call_rcu_hurry);
> +                       synchronize_rcu_normal();
>                 return;
>         }
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..279a37beb05a 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -987,7 +987,7 @@ void synchronize_rcu_expedited(void)
>
>         /* If expedited grace periods are prohibited, fall back to normal. */
>         if (rcu_gp_is_normal()) {
> -               wait_rcu_gp(call_rcu_hurry);
> +               synchronize_rcu_normal();
>                 return;
>         }
>
> --
> 2.30.2
>
