Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767C7B8481
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbjJDQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjJDQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056CBF;
        Wed,  4 Oct 2023 09:07:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A20EC433C8;
        Wed,  4 Oct 2023 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696435658;
        bh=DG5kmJPMAG7FTCxpW1gx9gwEc3eV4IdxNWEhFO4azLc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jf0zSMAVb0zYBr9+wMaUcuPwbdv7CNpucXw/Ya6PaPovfy1JkLC1seuaSyHRSuAtw
         6Sg5STEqvFfn9RE8s3mkznMFOCm36dheY2SLyX5mZ8vqBw+cXRqnyQCWUMRjiG3rdQ
         9tprsPJ2lJ1C4aSpPJUooYfm0waY7xuIn3bnc+E36IXSAKJ62XK3r98EfPKW2dmshC
         hiG03QBbNF8TX4uvvXK0WrXN+O8h3+a4MaCbPh+Q6ZrFhCcpdrG8nO6CU8G1JFfZcL
         KpRlQDA7yOpm/PZ3DK7RzOtDjeOFKvZ4tJyJaxmSeDbYWs3WRABKTmj4/UQ5Mnfxcz
         fWzuTSx5OsNSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9C90CE04F2; Wed,  4 Oct 2023 09:07:37 -0700 (PDT)
Date:   Wed, 4 Oct 2023 09:07:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/1] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <387528a7-42b3-4576-a03a-448c1a90f9df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231003180403.58576-1-urezki@gmail.com>
 <c22dfd1e-a0e5-4b86-8eac-e5a3d74d714e@paulmck-laptop>
 <ZR2EPBHgidvTFjuU@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR2EPBHgidvTFjuU@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:26:52PM +0200, Uladzislau Rezki wrote:
> On Wed, Oct 04, 2023 at 08:24:35AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 03, 2023 at 08:04:03PM +0200, Uladzislau Rezki (Sony) wrote:
> > > A call to a synchronize_rcu() can be optimized from time point of
> > > view. Different workloads can be affected by this especially the
> > > ones which use this API in its time critical sections.
> > > 
> > > For example if CONFIG_RCU_NOCB_CPU is set, the wakeme_after_rcu()
> > > callback can be delayed and such delay depends on where in a nocb
> > > list it is located.
> > > 
> > > 1. On our Android devices i can easily trigger the scenario when
> > > it is a last in the list out of ~3600 callbacks:
> > > 
> > > <snip>
> > >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> > > ...
> > >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> > >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> > > <snip>
> > > 
> > > 2. On our Android devices we use cpuset/cgroup to classify tasks
> > > and assign them into different cgroups. For example "backgrond"
> > > group which binds tasks only to little CPUs or "foreground" that
> > > binds to all CPUs, i.e. tasks can be migrated between groups.
> > > 
> > > See below an example of how "surfaceflinger" task is migrated.
> > > Initially it is located in the "system-background" cgroup which
> > > allows to run only on little cores. In order to speedup it up
> > > it can be temporary moved into "foreground" cgroup which allows
> > > to use big CPUs:
> > > 
> > > cgroup_attach_task():
> > >  -> cgroup_migrate_execute()
> > >    -> cpuset_can_attach()
> > >      -> percpu_down_write()
> > >        -> rcu_sync_enter()
> > >          -> synchronize_rcu()
> > >    -> now move tasks to the new cgroup.
> > >  -> cgroup_migrate_finish()
> > > 
> > > <snip>
> > >          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
> > >     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
> > >     PERFD-SERVER-1855    [000] d..1.  7030.530383: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
> > >    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> > > <snip>
> > > 
> > > from this example it is clear that "a moving time" also depends
> > > on how fast synchronize_rcu() completes.
> > > 
> > > 3. This patch improves the synchronize_rcu() approximately by 30%-50%
> > > on synthetic tests. Apart of that i have tested app launch of camera
> > > app where i also see better perf. figures:
> > > 
> > > 542 vs 489 diff: 9%
> > > 540 vs 466 diff: 13%
> > > 518 vs 468 diff: 9%
> > > 531 vs 457 diff: 13%
> > > 548 vs 475 diff: 13%
> > > 509 vs 484 diff: 4%
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/tree.c     | 151 +++++++++++++++++++++++++++++++++++++++++-
> > >  kernel/rcu/tree_exp.h |   2 +-
> > >  2 files changed, 151 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 78554e7181dd..a347c1f98f11 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1384,6 +1384,122 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  }
> > >  
> > > +/*
> > > + * There are three lists for handling synchronize_rcu() users.
> > > + * A first list corresponds to new coming users, second for users
> > > + * which wait for a grace period and third is for which a grace
> > > + * period is passed.
> > > + */
> > > +static struct sr_normal_state {
> > > +	struct llist_head curr;	/* request a GP users. */
> > > +	struct llist_head wait;	/* wait for GP users. */
> > > +	struct llist_head done;	/* ready for GP users. */
> > > +	struct llist_node *curr_tail;
> > > +	struct llist_node *wait_tail;
> > > +	atomic_t active;
> > > +} sr;
> > > +
> > > +/* Enable it by default. */
> > > +static int rcu_normal_wake_from_gp = 1;
> > > +module_param(rcu_normal_wake_from_gp, int, 0644);
> > 
> > Nice!
> > 
> > But could you please make this default to zero in order to avoid
> > surprising people for whom the old way works better?
> > 
> Yep, that i can do. If people prefer a slower version of it :)

Keeping in mind that "slower" often means more updates to spread the
grace-period overhead across, thus lower per-update RCU overhead.  ;-)

							Thanx, Paul
