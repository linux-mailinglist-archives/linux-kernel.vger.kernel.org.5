Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820CE7A1F31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjIOMtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjIOMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D4173A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+WwWDnoUiqbGQMNUOC/ZDSNUt5pEDK3ZmH2V16dcBZo=; b=qC5245E2acMXTSKfuWyWzMsP7O
        es34wu6noSN5Azve8F3y4O75lycVRk/lzMkNDk/NQb1HonvT6RqxD5J1jFLz9b2OIxOTavgG63XVj
        in4rdI+ZpVuqynqvBY1xOKguTvkC48sTC0khtwlXGh7CkPWZk7gWRY63PsbCxhiWYyQQeN0183Whj
        O1TkeWkA4IlBLs5+rnvq9MkEREeDGXOHn4uFd4A47xItoNX+Rg00zucEmE0iJEKzG9eG0aayOmkvN
        09a7wr+iDTdGrzRbbRQK4iC0UeO9wffAUNrRR53noxDzkAS1WUDpBj3XxSxc8dv3oUIg9INUv/Ipq
        gRMKSIvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh8Ft-009kyK-OT; Fri, 15 Sep 2023 12:49:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 659A63005FA; Fri, 15 Sep 2023 14:49:05 +0200 (CEST)
Message-Id: <20230915124822.847197830@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Fri, 15 Sep 2023 14:43:55 +0200
From:   peterz@infradead.org
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, daniel.m.jordan@oracle.com
Subject: [PATCH 1/2] sched/eevdf: Also update slice on placement
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sched-eevdf-slice-update.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks that never consume their full slice would not update their slice value.
This means that tasks that are spawned before the sysctl scaling keep their
original (UP) slice length.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/sched/fair.c
===================================================================
--- linux-2.6.orig/kernel/sched/fair.c
+++ linux-2.6/kernel/sched/fair.c
@@ -4919,10 +4919,12 @@ static inline void update_misfit_status(
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	u64 vslice = calc_delta_fair(se->slice, se);
-	u64 vruntime = avg_vruntime(cfs_rq);
+	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
+	se->slice = sysctl_sched_base_slice;
+	vslice = calc_delta_fair(se->slice, se);
+
 	/*
 	 * Due to how V is constructed as the weighted average of entities,
 	 * adding tasks with positive lag, or removing tasks with negative lag


