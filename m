Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36443754545
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGNXF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGNXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:05:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1273589
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689375955; x=1720911955;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Sfr+Y06Lo5KTpSlm7oZOnyPZY7c25zfMbKUVVadPshs=;
  b=H8W1wO5ovljyKIQqEZoSfHBkRl8Vb5ejq9HtSoPNiAlr8tooENFC+zZq
   hID2mim4w4PCT4bDGDwZw9LTGHeg0zO6/y3d594w4kanaQjlihx83u31Y
   4RROQ6MLeYqkzq+sikFGoOsbxIdsVtFXUCSFcHO3kACusF7Ci/MwRSY60
   aonhJV+ICcprtHBQf+4Mav0uKI132kUOoMRdGZdPgK+mvlgFHuLXLjJiB
   Jw+hZ226hHD7YNcn9wErHs93WUFpY0QIRWUFykc9Sojq5ZKMU9N4TnYl5
   tfVOb/aHPbd4tX+AANENZ7KZyv7X+rjTcLIEXaXDFqXxfqGvXXvnRVxx3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="350467871"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="350467871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="1053235674"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="1053235674"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:05:53 -0700
Message-ID: <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for
 SMT sched groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 14 Jul 2023 16:05:53 -0700
In-Reply-To: <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
         <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 18:36 +0530, Shrikanth Hegde wrote:

>=20
>=20
> If we consider symmetric platforms which have SMT4 such as power10.=20
> we have a topology like below. multiple such MC will form DIE(PKG)
>=20
>=20
> [0 2 4 6][1 3 5 7][8 10 12 14][9 11 13 15]
> [--SMT--][--SMT--][----SMT---][---SMT----]
> [--sg1--][--sg1--][---sg1----][---sg1----]
> [--------------MC------------------------]
>=20
> In case of SMT4, if there is any group which has 2 or more tasks, that=
=20
> group will be marked as group_smt_balance. previously, if that group had =
2
> or 3 tasks, it would have been marked as group_has_spare. Since all the g=
roups have=20
> SMT that means behavior would be same fully busy right? That can cause so=
me=20
> corner cases. No?

You raised a good point. I was looking from SMT2
perspective so group_smt_balance implies group_fully_busy.
That is no longer true for SMT4.

I am thinking of the following fix on the current patch
to take care of SMT4. Do you think this addresses
concerns from you and Tobias?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 294a662c9410..3fc8d3a3bd22 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct lb_env *en=
v,
                break;
=20
        case group_smt_balance:
+               /* no idle cpus on both groups handled by group_fully_busy =
below */
+               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
+                       if (sgs->idle_cpus > busiest->idle_cpus)
+                               return false;
+                       if (sgs->idle_cpus < busiest->idle_cpus)
+                               return true;
+                       if (sgs->sum_nr_running <=3D busiest_sum_nr_running=
)
+                               return false;
+                       else
+                               return true;
+               }


I will be on vacation next three weeks so my response will be slow.

Tim

>=20
> One example is Lets say sg1 has 4 tasks. and sg2 has 0 tasks and is tryin=
g to do=20
> load balance. Previously imbalance would have been 2, instead now imbalan=
ce would be 1.
> But in subsequent lb it would be balanced.
>=20
>=20
>=20
> > +	return false;
> > +}
> > +
> >  static inline bool
> >  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> >  {
> > @@ -9425,6 +9464,10 @@ static inline void update_sg_lb_stats(struct lb_=
env *env,
> >  		sgs->group_asym_packing =3D 1;
> >  	}
> >=20
> > +	/* Check for loaded SMT group to be balanced to dst CPU */
> > +	if (!local_group && smt_balance(env, sgs, group))
> > +		sgs->group_smt_balance =3D 1;
> > +
> >  	sgs->group_type =3D group_classify(env->sd->imbalance_pct, group, sgs=
);
> >=20
> >  	/* Computing avg_load makes sense only when group is overloaded */
> > @@ -9509,6 +9552,7 @@ static bool update_sd_pick_busiest(struct lb_env =
*env,
> >  			return false;
> >  		break;
> >=20
> > +	case group_smt_balance:
> >  	case group_fully_busy:
> >  		/*
> >  		 * Select the fully busy group with highest avg_load. In
> > @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> >  		break;
> >=20
> >  	case group_has_spare:
> > +		/*
> > +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> > +		 * as we do not want to pull task off SMT core with one task
> > +		 * and make the core idle.
> > +		 */
> > +		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> > +			if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <=3D =
1)
> > +				return false;
> > +			else
> > +				return true;> +		}
> > +
> >  		/*
> >  		 * Select not overloaded group with lowest number of idle cpus
> >  		 * and highest number of running tasks. We could also compare
> > @@ -9733,6 +9789,7 @@ static bool update_pick_idlest(struct sched_group=
 *idlest,
> >=20
> >  	case group_imbalanced:
> >  	case group_asym_packing:
> > +	case group_smt_balance:
> >  		/* Those types are not used in the slow wakeup path */
> >  		return false;
> >=20
> > @@ -9864,6 +9921,7 @@ find_idlest_group(struct sched_domain *sd, struct=
 task_struct *p, int this_cpu)
> >=20
> >  	case group_imbalanced:
> >  	case group_asym_packing:
> > +	case group_smt_balance:
> >  		/* Those type are not used in the slow wakeup path */
> >  		return NULL;
> >=20
> > @@ -10118,6 +10176,13 @@ static inline void calculate_imbalance(struct =
lb_env *env, struct sd_lb_stats *s
> >  		return;
> >  	}
> >=20
> > +	if (busiest->group_type =3D=3D group_smt_balance) {
> > +		/* Reduce number of tasks sharing CPU capacity */
> > +		env->migration_type =3D migrate_task;
> > +		env->imbalance =3D 1;
> > +		return;
> > +	}
> > +
> >  	if (busiest->group_type =3D=3D group_imbalanced) {
> >  		/*
> >  		 * In the group_imb case we cannot rely on group-wide averages
> > @@ -10363,16 +10428,23 @@ static struct sched_group *find_busiest_group=
(struct lb_env *env)
> >  		goto force_balance;
> >=20
> >  	if (busiest->group_type !=3D group_overloaded) {
> > -		if (env->idle =3D=3D CPU_NOT_IDLE)
> > +		if (env->idle =3D=3D CPU_NOT_IDLE) {
> >  			/*
> >  			 * If the busiest group is not overloaded (and as a
> >  			 * result the local one too) but this CPU is already
> >  			 * busy, let another idle CPU try to pull task.
> >  			 */
> >  			goto out_balanced;
> > +		}
> > +
> > +		if (busiest->group_type =3D=3D group_smt_balance &&
> > +		    smt_vs_nonsmt_groups(sds.local, sds.busiest)) {
> > +			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
> > +			goto force_balance;
> > +		}
> >=20
> >  		if (busiest->group_weight > 1 &&
> > -		    local->idle_cpus <=3D (busiest->idle_cpus + 1))
> > +		    local->idle_cpus <=3D (busiest->idle_cpus + 1)) {
> >  			/*
> >  			 * If the busiest group is not overloaded
> >  			 * and there is no imbalance between this and busiest
> > @@ -10383,12 +10455,14 @@ static struct sched_group *find_busiest_group=
(struct lb_env *env)
> >  			 * there is more than 1 CPU per group.
> >  			 */
> >  			goto out_balanced;
> > +		}
> >=20
> > -		if (busiest->sum_h_nr_running =3D=3D 1)
> > +		if (busiest->sum_h_nr_running =3D=3D 1) {
> >  			/*
> >  			 * busiest doesn't have any tasks waiting to run
> >  			 */
> >  			goto out_balanced;
> > +		}
> >  	}
> >=20
> >  force_balance:

