Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BC7543E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjGNUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:44:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB510FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689367445; x=1720903445;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=clQsCV4tvYkzrZbleTNLdcK50zMknAn/qPCgL+cyYGA=;
  b=Gu6Ac5odcIiaENaZqOeV4UPM8Q8T+xipI0YAz797xqAUGHuapFkdHD0D
   9HsfaTjP6RgsV5lSzSgGqqNRGA3jLUOoFoxWWNZp7drUGEYDGRHjgbHSN
   YmLPeym/PNHSrlV1eAwO5DmVwT/8G6lPK4wtkjoc+/kF3HzGtTyzQYyEk
   UvbRzKVFi6Qpa6Odx5VsmXLEcwhG7+TdMB/VGBBZyw0/rUt24qBxWzCgv
   A80CJHCANOofM1Yj/bBDSSHtx2Ajg1v+MU6jv0NGJIvotrKoekwQLo7/2
   GvV+4rGmsdL+Ql/gKHAz993mnUI5ioqBqvItdq73sUzqUgyYABoqm+gfG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355511109"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="355511109"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="725829802"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="725829802"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:44:03 -0700
Message-ID: <f9a51b01bdddd739faedb196156e69fbad41f9f5.camel@linux.intel.com>
Subject: Re: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        Tobias Huschle <huschle@linux.ibm.com>
Date:   Fri, 14 Jul 2023 13:44:02 -0700
In-Reply-To: <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
         <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 18:44 +0530, Shrikanth Hegde wrote:
>=20
> On 7/8/23 4:27 AM, Tim Chen wrote:
> > From: Tim C Chen <tim.c.chen@linux.intel.com>
> >=20
> > In the current prefer sibling load balancing code, there is an implicit
> > assumption that the busiest sched group and local sched group are
> > equivalent, hence the tasks to be moved is simply the difference in
> > number of tasks between the two groups (i.e. imbalance) divided by two.
> >=20
> > However, we may have different number of cores between the cluster grou=
ps,
> > say when we take CPU offline or we have hybrid groups.  In that case,
> > we should balance between the two groups such that #tasks/#cores ratio
> > is the same between the same between both groups.  Hence the imbalance
>=20
> nit: type here. the same between is repeated.

Thanks for catching.

>=20
> > computed will need to reflect this.
> >=20
> > Adjust the sibling imbalance computation to take into account of the
> > above considerations.
> >=20
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 37 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f636d6c09dc6..f491b94908bf 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9372,6 +9372,41 @@ static inline bool smt_balance(struct lb_env *en=
v, struct sg_lb_stats *sgs,
> >  	return false;
> >  }
> >=20
> > +static inline long sibling_imbalance(struct lb_env *env,
> > +				    struct sd_lb_stats *sds,
> > +				    struct sg_lb_stats *busiest,
> > +				    struct sg_lb_stats *local)
> > +{
> > +	int ncores_busiest, ncores_local;
> > +	long imbalance;
>=20
> can imbalance be unsigned int or unsigned long? as sum_nr_running is unsi=
gned int.

It could be made unsigned long.=20

>=20
> > +
> > +	if (env->idle =3D=3D CPU_NOT_IDLE || !busiest->sum_nr_running)
> > +		return 0;
> > +
> > +	ncores_busiest =3D sds->busiest->cores;
> > +	ncores_local =3D sds->local->cores;
> > +
> > +	if (ncores_busiest =3D=3D ncores_local) {
> > +		imbalance =3D busiest->sum_nr_running;
> > +		lsub_positive(&imbalance, local->sum_nr_running);
> > +		return imbalance;
> > +	}
> > +
> > +	/* Balance such that nr_running/ncores ratio are same on both groups =
*/
> > +	imbalance =3D ncores_local * busiest->sum_nr_running;
> > +	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
> > +	/* Normalize imbalance and do rounding on normalization */
> > +	imbalance =3D 2 * imbalance + ncores_local + ncores_busiest;
> > +	imbalance /=3D ncores_local + ncores_busiest;
> > +
>=20
> Could this work for case where number of CPU/cores would differ
> between two sched groups in a sched domain?=C2=A0
>=20

Yes.  That's the problem I was targeting.=20

> Such as problem pointed
> by tobias on S390. It would be nice if this patch can work for that case=
=20
> as well. Ran numbers for a few cases. It looks to work.
> https://lore.kernel.org/lkml/20230704134024.GV4253@hirez.programming.kick=
s-ass.net/T/#rb0a7dcd28532cafc24101e1d0aed79e6342e3901
>=20
>=20
>=20
> > +	/* Take advantage of resource in an empty sched group */
> > +	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > +	    busiest->sum_nr_running > 1)
> > +		imbalance =3D 2;
> > +
>=20
> I don't see how this case would be true. When there are unequal number of=
 cores and local->sum_nr_ruuning=20
> is 0, and busiest->sum_nr_running is atleast 2, imbalance will be atleast=
 1.=20
>=20
>=20
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Thanks for the review.

>=20
> > +	return imbalance;
> > +}
> > +
> >  static inline bool
> >  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> >  {
> > @@ -10230,14 +10265,12 @@ static inline void calculate_imbalance(struct=
 lb_env *env, struct sd_lb_stats *s
> >  		}
> >=20
> >  		if (busiest->group_weight =3D=3D 1 || sds->prefer_sibling) {
> > -			unsigned int nr_diff =3D busiest->sum_nr_running;
> >  			/*
> >  			 * When prefer sibling, evenly spread running tasks on
> >  			 * groups.
> >  			 */
> >  			env->migration_type =3D migrate_task;
> > -			lsub_positive(&nr_diff, local->sum_nr_running);
> > -			env->imbalance =3D nr_diff;
> > +			env->imbalance =3D sibling_imbalance(env, sds, busiest, local);
> >  		} else {
> >=20
> >  			/*
> > @@ -10424,7 +10457,7 @@ static struct sched_group *find_busiest_group(s=
truct lb_env *env)
> >  	 * group's child domain.
> >  	 */
> >  	if (sds.prefer_sibling && local->group_type =3D=3D group_has_spare &&
> > -	    busiest->sum_nr_running > local->sum_nr_running + 1)
> > +	    sibling_imbalance(env, &sds, busiest, local) > 1)
> >  		goto force_balance;
> >=20
> >  	if (busiest->group_type !=3D group_overloaded) {
>=20

