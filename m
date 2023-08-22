Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20760784967
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHVSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjHVSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D0CD0;
        Tue, 22 Aug 2023 11:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30E9646DD;
        Tue, 22 Aug 2023 18:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEBBC433C8;
        Tue, 22 Aug 2023 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692729017;
        bh=O7wboJXQXHTgxTj5Vyv4ZxnP622jiYddZgjexJIEbLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPVWLriipoXiBkhWEero7UIw2q5pNWrqfpGradtgkwv1aM9vnZmgqUB1GDUAvW+Uq
         2aIOmMPEvb1mHRN/IRsnio/57kWxPD5xxmc4W8HxSW9nvHwLEvZvFutRN080Oxtmc+
         Z6RArEE0mtCFGOAyIvHBNRmtEFONM5w+M+GCqnDhwe84GW/hpNNuS8ECuRYC5v82d1
         1Dcly+0uOHyLzL+uZjY4v4qSAl26PYGo9HN0beWKGYYCvfkGTqJMkSz9o6Lb3jR6Qe
         jM5xjvILCMsKzAUbFeSR5KAS0YAJopAMBhvbzI2wlLEVKuNpi4lCCITX4tqdWrA5Va
         BpLr/wKp2+f7A==
Date:   Tue, 22 Aug 2023 11:30:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] xfs: fix per-cpu CIL structure aggregation racing
 with dying cpus
Message-ID: <20230822183016.GC11263@frogsfrogsfrogs>
References: <20230804223854.GL11352@frogsfrogsfrogs>
 <ZOLzgBOuyWHapOyZ@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOLzgBOuyWHapOyZ@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:17:52PM +1000, Dave Chinner wrote:
> On Fri, Aug 04, 2023 at 03:38:54PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > In commit 7c8ade2121200 ("xfs: implement percpu cil space used
> > calculation"), the XFS committed (log) item list code was converted to
> > use per-cpu lists and space tracking to reduce cpu contention when
> > multiple threads are modifying different parts of the filesystem and
> > hence end up contending on the log structures during transaction commit.
> > Each CPU tracks its own commit items and space usage, and these do not
> > have to be merged into the main CIL until either someone wants to push
> > the CIL items, or we run over a soft threshold and switch to slower (but
> > more accurate) accounting with atomics.
> > 
> > Unfortunately, the for_each_cpu iteration suffers from the same race
> > with cpu dying problem that was identified in commit 8b57b11cca88f
> > ("pcpcntrs: fix dying cpu summation race") -- CPUs are removed from
> > cpu_online_mask before the CPUHP_XFS_DEAD callback gets called.  As a
> > result, both CIL percpu structure aggregation functions fail to collect
> > the items and accounted space usage at the correct point in time.
> > 
> > If we're lucky, the items that are collected from the online cpus exceed
> > the space given to those cpus, and the log immediately shuts down in
> > xlog_cil_insert_items due to the (apparent) log reservation overrun.
> > This happens periodically with generic/650, which exercises cpu hotplug
> > vs. the filesystem code.
> > 
> > Applying the same sort of fix from 8b57b11cca88f to the CIL code seems
> > to make the generic/650 problem go away, but I've been told that tglx
> > was not happy when he saw:
> > 
> > "...the only thing we actually need to care about is that
> > percpu_counter_sum() iterates dying CPUs. That's trivial to do, and when
> > there are no CPUs dying, it has no addition overhead except for a
> > cpumask_or() operation."
> > 
> > I have no idea what the /correct/ solution is, but I've been holding on
> > to this patch for 3 months.  In that time, 8b57b11cca88 hasn't been
> > reverted and cpu_dying_mask hasn't been removed, so I'm sending this and
> > we'll see what happens.
> > 
> > So, how /do/ we perform periodic aggregation of per-cpu data safely?
> > Move the xlog_cil_pcp_dead call to the dying section, where at least the
> > other cpus will all be stopped?  And have it dump its items into any
> > online cpu's data structure?
> 
> I suspect that we have to stop using for_each_*cpu() and hotplug
> notifiers altogether for this code.
> 
> That is, we simply create our own bitmap for nr_possible_cpus in the
> CIL checkpoint context we allocate for each checkpoint (i.e. the
> struct xfs_cil_ctx). When we store something on that CPU for that
> CIL context, we set the corresponding bit for that CPU. Then when we
> are aggregating the checkpoint, we simply walk all the cpus with the
> "has items" bit set and grab everything.
> 
> This gets rid of the need for hotplug notifiers completely - we just
> don't care if the CPU is online or offline when we sweep the CIL
> context for items at push time - if the bit is set then there's
> stuff to sweep...

Oooh, good idea.  Something like this, then?  Lightly tested via
generic/650 for five minutes...

--
From: Darrick J. Wong <djwong@kernel.org>
Subject: [PATCH] xfs: fix per-cpu CIL structure aggregation racing with dying cpus

In commit 7c8ade2121200 ("xfs: implement percpu cil space used
calculation"), the XFS committed (log) item list code was converted to
use per-cpu lists and space tracking to reduce cpu contention when
multiple threads are modifying different parts of the filesystem and
hence end up contending on the log structures during transaction commit.
Each CPU tracks its own commit items and space usage, and these do not
have to be merged into the main CIL until either someone wants to push
the CIL items, or we run over a soft threshold and switch to slower (but
more accurate) accounting with atomics.

Unfortunately, the for_each_cpu iteration suffers from the same race
with cpu dying problem that was identified in commit 8b57b11cca88f
("pcpcntrs: fix dying cpu summation race") -- CPUs are removed from
cpu_online_mask before the CPUHP_XFS_DEAD callback gets called.  As a
result, both CIL percpu structure aggregation functions fail to collect
the items and accounted space usage at the correct point in time.

If we're lucky, the items that are collected from the online cpus exceed
the space given to those cpus, and the log immediately shuts down in
xlog_cil_insert_items due to the (apparent) log reservation overrun.
This happens periodically with generic/650, which exercises cpu hotplug
vs. the filesystem code:

smpboot: CPU 3 is now offline
XFS (sda3): ctx ticket reservation ran out. Need to up reservation
XFS (sda3): ticket reservation summary:
XFS (sda3):   unit res    = 9268 bytes
XFS (sda3):   current res = -40 bytes
XFS (sda3):   original count  = 1
XFS (sda3):   remaining count = 1
XFS (sda3): Filesystem has been shut down due to log error (0x2).

Applying the same sort of fix from 8b57b11cca88f to the CIL code seems
to make the generic/650 problem go away, but I've been told that tglx
was not happy when he saw:

"...the only thing we actually need to care about is that
percpu_counter_sum() iterates dying CPUs. That's trivial to do, and when
there are no CPUs dying, it has no addition overhead except for a
cpumask_or() operation."

The CPU hotplug code is rather complex and difficult to understand and I
don't want to try to understand the cpu hotplug locking well enough to
use cpu_dying mask.  Furthermore, there's a performance improvement that
could be had here.  Attach a private cpu mask to the CIL structure so
that we can track exactly which cpus have accessed the percpu data at
all.  It doesn't matter if the cpu has since gone offline; log item
aggregation will still find the items.  Better yet, we skip cpus that
have not recently logged anything.

Link: https://lore.kernel.org/linux-xfs/ZOLzgBOuyWHapOyZ@dread.disaster.area/T/
Link: https://lore.kernel.org/lkml/877cuj1mt1.ffs@tglx/
Link: https://lore.kernel.org/lkml/20230414162755.281993820@linutronix.de/
Cc: tglx@linutronix.de
Cc: peterz@infradead.org
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log_cil.c  |   58 ++++++++++++++++++++-----------------------------
 fs/xfs/xfs_log_priv.h |   15 ++++++-------
 fs/xfs/xfs_super.c    |    1 -
 3 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eccbfb99e894..d91589a959ee 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -124,7 +124,7 @@ xlog_cil_push_pcp_aggregate(
 	struct xlog_cil_pcp	*cilpcp;
 	int			cpu;
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, &cil->xc_pcpmask) {
 		cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
 
 		ctx->ticket->t_curr_res += cilpcp->space_reserved;
@@ -165,7 +165,14 @@ xlog_cil_insert_pcp_aggregate(
 	if (!test_and_clear_bit(XLOG_CIL_PCP_SPACE, &cil->xc_flags))
 		return;
 
-	for_each_online_cpu(cpu) {
+	/*
+	 * We don't hold xc_push_lock here, so we can race with other cpus
+	 * setting xc_pcpmask.  However, we've atomically cleared PCP_SPACE
+	 * which forces other threads to add to the global space used count.
+	 * xc_pcpmask is a superset of cilpcp structures that could have a
+	 * nonzero space_used.
+	 */
+	for_each_cpu(cpu, &cil->xc_pcpmask) {
 		int	old, prev;
 
 		cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
@@ -186,6 +193,7 @@ xlog_cil_ctx_switch(
 	xlog_cil_set_iclog_hdr_count(cil);
 	set_bit(XLOG_CIL_EMPTY, &cil->xc_flags);
 	set_bit(XLOG_CIL_PCP_SPACE, &cil->xc_flags);
+	cpumask_clear(&cil->xc_pcpmask);
 	ctx->sequence = ++cil->xc_current_sequence;
 	ctx->cil = cil;
 	cil->xc_ctx = ctx;
@@ -554,6 +562,7 @@ xlog_cil_insert_items(
 	int			iovhdr_res = 0, split_res = 0, ctx_res = 0;
 	int			space_used;
 	int			order;
+	unsigned int		cpu_nr;
 	struct xlog_cil_pcp	*cilpcp;
 
 	ASSERT(tp);
@@ -579,6 +588,18 @@ xlog_cil_insert_items(
 	 */
 	cilpcp = get_cpu_ptr(cil->xc_pcp);
 
+	/*
+	 * Add this cpu to the mask of cpus that could have touched xc_pcp.
+	 * The push aggregation function is called with the push lock held,
+	 * so take it here if we have to update the mask.
+	 */
+	cpu_nr = current_cpu();
+	if (!cpumask_test_cpu(cpu_nr, &cil->xc_pcpmask)) {
+		spin_lock(&cil->xc_push_lock);
+		cpumask_set_cpu(cpu_nr, &cil->xc_pcpmask);
+		spin_unlock(&cil->xc_push_lock);
+	}
+
 	/*
 	 * We need to take the CIL checkpoint unit reservation on the first
 	 * commit into the CIL. Test the XLOG_CIL_EMPTY bit first so we don't
@@ -1790,38 +1811,6 @@ xlog_cil_force_seq(
 	return 0;
 }
 
-/*
- * Move dead percpu state to the relevant CIL context structures.
- *
- * We have to lock the CIL context here to ensure that nothing is modifying
- * the percpu state, either addition or removal. Both of these are done under
- * the CIL context lock, so grabbing that exclusively here will ensure we can
- * safely drain the cilpcp for the CPU that is dying.
- */
-void
-xlog_cil_pcp_dead(
-	struct xlog		*log,
-	unsigned int		cpu)
-{
-	struct xfs_cil		*cil = log->l_cilp;
-	struct xlog_cil_pcp	*cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
-	struct xfs_cil_ctx	*ctx;
-
-	down_write(&cil->xc_ctx_lock);
-	ctx = cil->xc_ctx;
-	if (ctx->ticket)
-		ctx->ticket->t_curr_res += cilpcp->space_reserved;
-	cilpcp->space_reserved = 0;
-
-	if (!list_empty(&cilpcp->log_items))
-		list_splice_init(&cilpcp->log_items, &ctx->log_items);
-	if (!list_empty(&cilpcp->busy_extents))
-		list_splice_init(&cilpcp->busy_extents, &ctx->busy_extents);
-	atomic_add(cilpcp->space_used, &ctx->space_used);
-	cilpcp->space_used = 0;
-	up_write(&cil->xc_ctx_lock);
-}
-
 /*
  * Perform initial CIL structure initialisation.
  */
@@ -1857,6 +1846,7 @@ xlog_cil_init(
 		INIT_LIST_HEAD(&cilpcp->busy_extents);
 		INIT_LIST_HEAD(&cilpcp->log_items);
 	}
+	cpumask_clear(&cil->xc_pcpmask);
 
 	INIT_LIST_HEAD(&cil->xc_committing);
 	spin_lock_init(&cil->xc_push_lock);
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 1bd2963e8fbd..68912205aa24 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -278,9 +278,13 @@ struct xfs_cil {
 	wait_queue_head_t	xc_push_wait;	/* background push throttle */
 
 	void __percpu		*xc_pcp;	/* percpu CIL structures */
-#ifdef CONFIG_HOTPLUG_CPU
-	struct list_head	xc_pcp_list;
-#endif
+
+	/*
+	 * Cpus that have could have written xc_pcp.  Accesss to the mask is
+	 * (mostly) synchronized via xc_push_lock, which is held when CIL
+	 * contexts are aggregated and switched.
+	 */
+	struct cpumask		xc_pcpmask;
 } ____cacheline_aligned_in_smp;
 
 /* xc_flags bit values */
@@ -705,9 +709,4 @@ xlog_kvmalloc(
 	return p;
 }
 
-/*
- * CIL CPU dead notifier
- */
-void xlog_cil_pcp_dead(struct xlog *log, unsigned int cpu);
-
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 09638e8fb4ee..ef7775657ce3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2313,7 +2313,6 @@ xfs_cpu_dead(
 	list_for_each_entry_safe(mp, n, &xfs_mount_list, m_mount_list) {
 		spin_unlock(&xfs_mount_list_lock);
 		xfs_inodegc_cpu_dead(mp, cpu);
-		xlog_cil_pcp_dead(mp->m_log, cpu);
 		spin_lock(&xfs_mount_list_lock);
 	}
 	spin_unlock(&xfs_mount_list_lock);
