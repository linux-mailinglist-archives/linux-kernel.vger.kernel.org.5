Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425CD797B66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbjIGSQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjIGSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:16:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3A199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694110560; x=1725646560;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=87vHIboGfb/xcRF81uFJzzuwFQhSnV6hkKGfpT8v0MU=;
  b=iPRmKfOF0b5qd1P0be3VSIbF4WfTTT3VW07q3JU2qNSmWQbrusfHP9bC
   EtpGyr22ilL5MxUpkYsj4V+2esi76Pk+M9DsqB/UQsPe3rCLTrBf4mf9B
   ET1SyB/AA9SCS2N1OOsQZ/599CQTb7TBKyFmdb0xAl7hMvuj6YYHvhbRo
   ML3N+2aH6gNcCKzKRwTrhWxC4rlwUi+Qy0tSsFk4aWK1cPPHpTWDaYQjg
   YE4yeYwwkKEHD+TEpaLS3xUlS03izkAFJqSKZk/IrkxHv7FpfUuy/9viw
   TgU4BNlpYIjutiPtSlt+GA6C0/rZRvLPi6oNohMUcP6O9lxXj2ePSzOgV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="374817265"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="374817265"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807631223"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="807631223"
Received: from ayushgup-mobl.amr.corp.intel.com (HELO [10.209.118.125]) ([10.209.118.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:42:22 -0700
Message-ID: <6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Date:   Thu, 07 Sep 2023 10:42:21 -0700
In-Reply-To: <882ed331-4345-014b-d06f-9b3a3a6f688f@linux.vnet.ibm.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
         <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
         <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
         <dee7575cc9d3c42c9705348151a1453ff084d4f3.camel@linux.intel.com>
         <882ed331-4345-014b-d06f-9b3a3a6f688f@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 14:28 +0530, Shrikanth Hegde wrote:
> >=20
> > You mean simplify the patch as below?  I think that should be fine.  Ca=
n you
> > make sure it works for SMT4?  And I can update the patch once you confi=
rm it
> > works properly.
> >=20
> > Tim
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e7ee2efc1ba..48e9ab7f8a87 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9764,16 +9764,9 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> > =20
> >         case group_smt_balance:
> >                 /* no idle cpus on both groups handled by group_fully_b=
usy below */
> > -               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)=
 {
> > -                       if (sgs->idle_cpus > busiest->idle_cpus)
> > -                               return false;
> > -                       if (sgs->idle_cpus < busiest->idle_cpus)
> > -                               return true;
> > -                       if (sgs->sum_nr_running <=3D busiest->sum_nr_ru=
nning)
> > -                               return false;
> > -                       else
> > -                               return true;
> > -               }
> > +               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)
> > +                       goto has_spare;
> > +
> >                 goto fully_busy;
> > =20
> >         case group_fully_busy:
> > @@ -9809,6 +9802,7 @@ static bool update_sd_pick_busiest(struct lb_env =
*env,
> >                  * as we do not want to pull task off SMT core with one=
 task
> >                  * and make the core idle.
> >                  */
> > +has_spare:
> >                 if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> >                         if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->su=
m_h_nr_running <=3D 1)
> >                                 return false;
> >=20
> >=20
> >=20
>=20
> Hi Tim,
>=20
> In case you were waiting for my reply as inferred from other email.=20
> The above change looks fine as well. This would avoid duplication of
> code for group_smt_balance.=20
>=20
> Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Peter,

Here's the updated patch.  Please consider it for inclusion.

Thanks.

Tim

From 979e261fed6e3765316a4de794f595f93c02cef0 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH] sched/fair: Fix SMT4 group_smt_balance handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@li=
naro.org>, Ricardo Neri <ricardo.neri@intel.com>, Ravi V. Shankar <ravi.v.s=
hankar@intel.com>, Ben Segall
<bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Diet=
mar Eggemann <dietmar.eggemann@arm.com>, Len Brown <len.brown@intel.com>, M=
el Gorman <mgorman@suse.de>, Rafael J. Wysocki
<rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linu=
x.intel.com>, Steven Rostedt <rostedt@goodmis.org>, Tim Chen <tim.c.chen@li=
nux.intel.com>, Valentin Schneider
<vschneid@redhat.com>, Ionela Voinescu <ionela.voinescu@arm.com>, x86@kerne=
l.org, linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.vnet.ib=
m.com>, Srikar Dronamraju
<srikar@linux.vnet.ibm.com>, naveen.n.rao@linux.vnet.ibm.com, Yicong Yang <=
yangyicong@hisilicon.com>, Barry Song <v-songbaohua@oppo.com>, Chen Yu <yu.=
c.chen@intel.com>, Hillf Danton <hdanton@sina.com>

For SMT4, any group with more than 2 tasks will be marked as
group_smt_balance. Retain the behaviour of group_has_spare by marking
the busiest group as the group which has the least number of idle_cpus.

Also, handle rounding effect of adding (ncores_local + ncores_busy) when
the local is fully idle and busy group imbalance is less than 2 tasks.
Local group should try to pull at least 1 task in this case so imbalance
should be set to 2 instead.

Fixes: fee1759e4f04 ("sched/fair: Determine active load balance for SMT sch=
ed groups")
Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..fd9e594b5623 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9575,7 +9575,7 @@ static inline long sibling_imbalance(struct lb_env *e=
nv,
 	imbalance /=3D ncores_local + ncores_busiest;
=20
 	/* Take advantage of resource in an empty sched group */
-	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
+	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance =3D 2;
=20
@@ -9763,6 +9763,15 @@ static bool update_sd_pick_busiest(struct lb_env *en=
v,
 		break;
=20
 	case group_smt_balance:
+		/*
+		 * Check if we have spare CPUs on either SMT group to
+		 * choose has spare or fully busy handling.
+		 */
+		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)
+			goto has_spare;
+
+		fallthrough;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9802,6 +9811,7 @@ static bool update_sd_pick_busiest(struct lb_env *env=
,
 			else
 				return true;
 		}
+has_spare:
=20
 		/*
 		 * Select not overloaded group with lowest number of idle cpus
--=20
2.32.0


