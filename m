Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C507B669F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjJCKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjJCKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C204CC;
        Tue,  3 Oct 2023 03:42:41 -0700 (PDT)
Date:   Tue, 03 Oct 2023 10:42:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grakLp/zKCRntxJXoxdacCz+WQGAMempoTpcbELkjtw=;
        b=h//JyklV+UfhJok2GoSaCoO3WIMDa8IIF6CS8yWIOUbBAqrwjr2Cc6egxisXHBH2dFcSEj
        GMamkX4q0HlO674s7b92e2720F2z+hkKaUfKGyQo9XYDxBMe8k4f2HnxlBltzmAgv/hUMw
        TsL/kUl52clwytEUSmHGw5J09qp2OpSl/E3qjGak9Lrl+6AVAC0a/lv0CHblDWEguLX6qT
        hJZQDggLGNg1x/DoW/j/vhcw7yXrIF79u0B4Idiwx80pGcAzHBd54L/LbDx9O/plXRDWKM
        Yy1TRoxWM4VhwPbKnOH36E1OfvGTq0fQ2ng1paxxgh4KSJa/VUQjIdUViNacwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grakLp/zKCRntxJXoxdacCz+WQGAMempoTpcbELkjtw=;
        b=Ce6BAYVZuFfPMDWwD1kc69Gglnpwqjyh/9TD+crnlC/58YTnTnbFV/qhI0+ImAainhPaiX
        JjR2reDWW3wCdXAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Also update slice on placement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915124822.847197830@noisy.programming.kicks-ass.net>
References: <20230915124822.847197830@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169632975832.3135.8276089037477460761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2f2fc17bab0011430ceb6f2dc1959e7d1f981444
Gitweb:        https://git.kernel.org/tip/2f2fc17bab0011430ceb6f2dc1959e7d1f981444
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 15 Sep 2023 00:48:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Oct 2023 12:32:29 +02:00

sched/eevdf: Also update slice on placement

Tasks that never consume their full slice would not update their slice value.
This means that tasks that are spawned before the sysctl scaling keep their
original (UP) slice length.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230915124822.847197830@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb22592..7d73652 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4919,10 +4919,12 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
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
