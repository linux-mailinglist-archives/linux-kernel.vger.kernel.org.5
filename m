Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB07FC265
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbjK1RjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbjK1RjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:39:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293A710CA;
        Tue, 28 Nov 2023 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193161; x=1732729161;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=E+As1VEvubpOiVH0Ou+RDAjr7+3D05qZrxWeULMmbqU=;
  b=mXwS6BiVP+OwkSGUrmBEub3KNYwyDBKAJlzrzrdbd6FKUKAhacOdLIYV
   1i9v3uDEq+KKqpzU+vEDp2wTq3DHVMjwWtgcCgyMH2DW1uY2V4hDO+4A6
   UnF8RxoHrPOQudHge2XP9HxPjjIOi1v50FAqCJrRazvEZ+sjvrgbaxG3h
   3wjDIFHlNKQbxDXAeZbQmwFhSr8UUVdLQWL/H4CZQIqOcn5CTf0OCsGZW
   LL0rPf48m7tPgB3Iusw/En0M1tHJfNqGHVMWGeaIoA2IrdVN7KhP+Buoh
   IKClQ0kW2pGA9zVzywnzciLpTl4+/tk4UD3uHh7T1pFiw6GFdtojF3fUe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="378001818"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="378001818"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859514426"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859514426"
Received: from bmnolan-mobl.amr.corp.intel.com (HELO [10.209.106.201]) ([10.209.106.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:33:25 -0800
Message-ID: <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramses VdP <ramses@well-founded.dev>,
        Yu Chen <yu.c.chen@intel.com>
Date:   Tue, 28 Nov 2023 09:33:24 -0800
In-Reply-To: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 20:22 +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I come across an interesting bug report on Bugzilla [1]. The reporter
> wrote:
>=20
> > I am running an intel alder lake system (Core i7-1260P), with a mix of =
P and E cores.
> >=20
> > Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems to=
 have a strong preference for the E cores, and single threaded workloads ar=
e consistently scheduled on one of the E cores.
> >=20
> > With Linux 6.4 and before, when I ran a single threaded CPU-bound proce=
ss, it was scheduled on a P core. With 6.5, it seems that the choice of P o=
r E seemed rather random.
> >=20
> > I tested these by running "stress" with different amounts of threads. W=
ith a single thread on Linux 6.6 and 6.7, I always have an E core at 100% a=
nd no load on the P cores. Starting from 3 threads I get some load on the P=
 cores as well, but the E cores stay more heavily loaded.
> > With "taskset" I can force a process to run on a P core, but clearly it=
's not very practical to have to do CPU scheduling manually.
> >=20
> > This severely affects single-threaded performance of my CPU since the E=
 cores are considerably slower. Several of my workflows are now a lot slowe=
r due to them being single-threaded and heavily CPU-bound and being schedul=
ed on E cores whereas they would run on P cores before.
> >=20
> > I am not sure what the exact desired behaviour is here, to balance powe=
r consumption and performance, but currently my P cores are barely used for=
 single-threaded workloads.
> >=20
> > Is this intended behaviour or is this indeed a regression? Or is there =
perhaps any configuration that I should have done from my side? Is there an=
y further info that I can provide to help you figure out what's going on?
>=20
> PM and scheduler people, is this a regression or works as intended?
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218195
>=20

I have noticed that the current code sometimes is quite trigger happy
moving tasks off P-core, whenever there are more than 2 tasks on a core.
Sometimes, Short running house keeping tasks
could disturb the running task on P-core as a result.

Can you try the following patch?  On my Alder Lake system, I see as I add s=
ingle
threaded tasks, they first run on P-cores, then followed by E-cores with th=
is
patch on 6.6.

Tim

From 68a15ef01803c252261ebb47d86dfc1f2c68ae1e Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 6 Oct 2023 15:58:56 -0700
Subject: [PATCH] sched/fair: Don't force smt balancing when CPU has spare
 capacity

Currently group_smt_balance is picked whenever there are more
than two tasks on a core with two SMT.  However, the utilization
of those tasks may be low and do not warrant a task
migration to a CPU of lower priority.

Adjust sched group clssification and sibling_imbalance()
to reflect this consideration.  Use sibling_imbalance() to
compute imbalance in calculate_imbalance() for the group_smt_balance
case.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

---
 kernel/sched/fair.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef7490c4b8b4..7dd7c2d2367a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9460,14 +9460,15 @@ group_type group_classify(unsigned int imbalance_pc=
t,
 	if (sgs->group_asym_packing)
 		return group_asym_packing;
=20
-	if (sgs->group_smt_balance)
-		return group_smt_balance;
-
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
=20
-	if (!group_has_capacity(imbalance_pct, sgs))
-		return group_fully_busy;
+	if (!group_has_capacity(imbalance_pct, sgs)) {
+		if (sgs->group_smt_balance)
+			return group_smt_balance;
+		else
+			return group_fully_busy;
+	}
=20
 	return group_has_spare;
 }
@@ -9573,6 +9574,11 @@ static inline long sibling_imbalance(struct lb_env *=
env,
 	if (env->idle =3D=3D CPU_NOT_IDLE || !busiest->sum_nr_running)
 		return 0;
=20
+	/* Do not pull tasks off preferred group with spare capacity */
+	if (busiest->group_type =3D=3D group_has_spare &&
+	    sched_asym_prefer(sds->busiest->asym_prefer_cpu, env->dst_cpu))
+		return 0;
+
 	ncores_busiest =3D sds->busiest->cores;
 	ncores_local =3D sds->local->cores;
=20
@@ -10411,13 +10417,6 @@ static inline void calculate_imbalance(struct lb_e=
nv *env, struct sd_lb_stats *s
 		return;
 	}
=20
-	if (busiest->group_type =3D=3D group_smt_balance) {
-		/* Reduce number of tasks sharing CPU capacity */
-		env->migration_type =3D migrate_task;
-		env->imbalance =3D 1;
-		return;
-	}
-
 	if (busiest->group_type =3D=3D group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
--=20
2.32.0


