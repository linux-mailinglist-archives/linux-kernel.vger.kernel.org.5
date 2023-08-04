Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C86770BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHDWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D694EDD;
        Fri,  4 Aug 2023 15:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB4862159;
        Fri,  4 Aug 2023 22:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B86CC433C8;
        Fri,  4 Aug 2023 22:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188735;
        bh=4ZHUpAEsPHLIZuavcCFPyzt3vciVGgDCLfCh4b1DlrI=;
        h=Date:From:To:Cc:Subject:From;
        b=B75Owh8yBQ9FC2zY2RMF4UB1IPUzVgHbg/9nWepfU/JwRF7fpu+xjatD0vigtoO5K
         7rcOk0wpr3Cbc4Z2zcvqr+RA9jYmyBYcJROzHrQQk8bZsUVmGgqCDRprgLpqIVmVp0
         fPoICOSerN5a8/b62AbvJrtbAW2OfRcECIdl9OtxBIilNgxKqha3ZVuqQui/AgFs68
         3ZcpenDZaEHM+9TbgXHI7q5D9z5P7QS58Lp5rrAF2JBpreyC4z1nUu/nRAx0T55/On
         VPQnUyVNSK+xIjM6NVLAQ7UjK7mDEDCL0EmJty64nq+N7zZLroxB7mu/jWr7O8zoVp
         PdmaRmbTHHAtA==
Date:   Fri, 4 Aug 2023 15:38:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] xfs: fix per-cpu CIL structure aggregation racing with
 dying cpus
Message-ID: <20230804223854.GL11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

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
vs. the filesystem code.

Applying the same sort of fix from 8b57b11cca88f to the CIL code seems
to make the generic/650 problem go away, but I've been told that tglx
was not happy when he saw:

"...the only thing we actually need to care about is that
percpu_counter_sum() iterates dying CPUs. That's trivial to do, and when
there are no CPUs dying, it has no addition overhead except for a
cpumask_or() operation."

I have no idea what the /correct/ solution is, but I've been holding on
to this patch for 3 months.  In that time, 8b57b11cca88 hasn't been
reverted and cpu_dying_mask hasn't been removed, so I'm sending this and
we'll see what happens.

So, how /do/ we perform periodic aggregation of per-cpu data safely?
Move the xlog_cil_pcp_dead call to the dying section, where at least the
other cpus will all be stopped?  And have it dump its items into any
online cpu's data structure?

Link: https://lore.kernel.org/lkml/877cuj1mt1.ffs@tglx/
Link: https://lore.kernel.org/lkml/20230414162755.281993820@linutronix.de/
Cc: tglx@linutronix.de
Cc: peterz@infradead.org
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log_cil.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eccbfb99e8948..5c909ffcb25b7 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -124,7 +124,7 @@ xlog_cil_push_pcp_aggregate(
 	struct xlog_cil_pcp	*cilpcp;
 	int			cpu;
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
 		cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
 
 		ctx->ticket->t_curr_res += cilpcp->space_reserved;
@@ -165,7 +165,7 @@ xlog_cil_insert_pcp_aggregate(
 	if (!test_and_clear_bit(XLOG_CIL_PCP_SPACE, &cil->xc_flags))
 		return;
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
 		int	old, prev;
 
 		cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
