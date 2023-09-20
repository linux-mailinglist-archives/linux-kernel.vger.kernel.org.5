Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653637A8285
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjITNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjITNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB72D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:00:32 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695214831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZdoO2l4qhPbEU8tjxkk6zOdWcpP9/0yF9VsRLRNan8=;
        b=Ko3aXO7OjXZRYQAsGq3aAmYg0QUiXJ4k+a/mLdJX0xPoif3q15B5w1w6Af2/aHrTe0QsnM
        6/eiWJOexJ3HNCvdxnwOuLm0rad1wVoOOvaeZ6AxApv4qNBW59ELLUVi7wwn0F1lWJmtvt
        tXTrw9UauWxvgvB9lXouVUM9PQUvInyGex687WVvCia8wvsBd241BN0z4/wV1kSNklNFlM
        aijvOkHO1JnECb5WIyWuOQcnUjkuV5BTGwD6i/TPGm6cq/A86fG6oRZ+N0Tz26CLpMtO6h
        NE8cLnzOiChtGh3rptZEfWWZUBwk79rZGWCAxmQyeB2oa3pfEp+SFQWZjGI9iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695214831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZdoO2l4qhPbEU8tjxkk6zOdWcpP9/0yF9VsRLRNan8=;
        b=6ZZwY2pqDXziLukda0tMMK7ezRhpOU/bAGVwUfJY5RLf+zUBmOrtfP5M96rhcAkSvtJ6xk
        YMl42AAJGJpBO5Cg==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] sched: Remove sysctl sched_child_runs_first.
Date:   Wed, 20 Sep 2023 15:00:24 +0200
Message-Id: <20230920130025.412071-2-bigeasy@linutronix.de>
In-Reply-To: <20230920130025.412071-1-bigeasy@linutronix.de>
References: <20230920130025.412071-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_child_runs_first knob is no longer connected since commit
   5e963f2bd4654 ("sched/fair: Commit to EEVDF")

Remove sched_child_runs_first.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h |  2 --
 3 files changed, 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db63..132dfd1e6f475 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -864,7 +864,6 @@ static void sched_debug_header(struct seq_file *m)
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
 	PN(sysctl_sched_base_slice);
-	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
 #undef P
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcf0c5bc8b478..75720008fdd21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -78,12 +78,6 @@ unsigned int sysctl_sched_tunable_scaling =3D SCHED_TUNA=
BLESCALING_LOG;
 unsigned int sysctl_sched_base_slice			=3D 750000ULL;
 static unsigned int normalized_sysctl_sched_base_slice	=3D 750000ULL;
=20
-/*
- * After fork, child runs first. If set to 0 (default) then
- * parent will (try to) run first.
- */
-unsigned int sysctl_sched_child_runs_first __read_mostly;
-
 const_debug unsigned int sysctl_sched_migration_cost	=3D 500000UL;
=20
 int sched_thermal_decay_shift;
@@ -145,13 +139,6 @@ static unsigned int sysctl_numa_balancing_promote_rate=
_limit =3D 65536;
=20
 #ifdef CONFIG_SYSCTL
 static struct ctl_table sched_fair_sysctls[] =3D {
-	{
-		.procname       =3D "sched_child_runs_first",
-		.data           =3D &sysctl_sched_child_runs_first,
-		.maxlen         =3D sizeof(unsigned int),
-		.mode           =3D 0644,
-		.proc_handler   =3D proc_dointvec,
-	},
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.procname       =3D "sched_cfs_bandwidth_slice_us",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e070dcf70747..9260120ed2a5c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -100,8 +100,6 @@ extern __read_mostly int scheduler_running;
 extern unsigned long calc_load_update;
 extern atomic_long_t calc_load_tasks;
=20
-extern unsigned int sysctl_sched_child_runs_first;
-
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
=20
--=20
2.40.1

