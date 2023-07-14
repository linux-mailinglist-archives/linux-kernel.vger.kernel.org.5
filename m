Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1675456C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGNXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGNXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:35:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074CA12E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689377715; x=1720913715;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PsnfcAi00CmyOQ4zOWY7RzNc3RqYgCQ5wfN+k3Nx+tA=;
  b=gdufMpTU0hldNAcxNMaHq73YP9n67z2V5Pkal1noZDfW0YqjhE9AOLD7
   05TpWGvTcDCbd+fuh4wLe2uImhP1YJreh+Z8qc9XcdkTvPVemW5geR72O
   z7stwP1VqFl3seh3+9UDe1LrH2f7yIPrXAFqoMJJ9lfu0sBw+v0pOcPUj
   eiJFc/c7bgU+BVdbkG4o+T9H/naMvCkF374ECd/qG+VOHLy10mv9ccgPI
   CpUAwpXmmJGAWUIoKdwhPaybG0YUUeoeTny9i50Qg4tCyVAYP7wGd1GRi
   rHlgLx17Qck0hvEHyhqwxSHkf5zmAeH/IqbGG01bBR2fk6LE9u6UE7aIk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="363067118"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="363067118"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:35:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812616513"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="812616513"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:35:13 -0700
Message-ID: <1fa026a44ed4d31254396e5ed6cfda1dc68c837d.camel@linux.intel.com>
Subject: Re: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Tobias Huschle <huschle@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Date:   Fri, 14 Jul 2023 16:35:12 -0700
In-Reply-To: <b119d88384584e603056cec942c47e14@linux.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
         <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
         <b119d88384584e603056cec942c47e14@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 16:22 +0200, Tobias Huschle wrote:
>=20
> >=20
> > Could this work for case where number of CPU/cores would differ
> > between two sched groups in a sched domain? Such as problem pointed
> > by tobias on S390. It would be nice if this patch can work for that=20
> > case
> > as well. Ran numbers for a few cases. It looks to work.
> > https://lore.kernel.org/lkml/20230704134024.GV4253@hirez.programming.ki=
cks-ass.net/T/#rb0a7dcd28532cafc24101e1d0aed79e6342e3901
> >=20
>=20
>=20
> Just stumbled upon this patch series as well. In this version it looks
> similar to the prototypes I played around with, but more complete.
> So I'm happy that my understanding of the load balancer was kinda=20
> correct :)
>=20
>  From a functional perspective this appears to address the issues we saw=
=20
> on s390.

Glad that this patch addresses this common issue across architectures.
I did aim to address the asymmetric groups balancing in general.
Peter pointed out this problem that's inherent when he reviewed the first
version of my patchset.=20

Tim

>=20
> >=20
> >=20
> > > +	/* Take advantage of resource in an empty sched group */
> > > +	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > > +	    busiest->sum_nr_running > 1)
> > > +		imbalance =3D 2;
> > > +
> >=20
> > I don't see how this case would be true. When there are unequal number
> > of cores and local->sum_nr_ruuning
> > is 0, and busiest->sum_nr_running is atleast 2, imbalance will be=20
> > atleast 1.
> >=20
> >=20
> > Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> >=20
> > > +	return imbalance;
> > > +}
> > > +
> > >  static inline bool
> > >  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> > >  {
> > > @@ -10230,14 +10265,12 @@ static inline void=20
> > > calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >  		}
> > >=20
> > >  		if (busiest->group_weight =3D=3D 1 || sds->prefer_sibling) {
> > > -			unsigned int nr_diff =3D busiest->sum_nr_running;
> > >  			/*
> > >  			 * When prefer sibling, evenly spread running tasks on
> > >  			 * groups.
> > >  			 */
> > >  			env->migration_type =3D migrate_task;
> > > -			lsub_positive(&nr_diff, local->sum_nr_running);
> > > -			env->imbalance =3D nr_diff;
> > > +			env->imbalance =3D sibling_imbalance(env, sds, busiest, local);
> > >  		} else {
> > >=20
> > >  			/*
> > > @@ -10424,7 +10457,7 @@ static struct sched_group=20
> > > *find_busiest_group(struct lb_env *env)
> > >  	 * group's child domain.
> > >  	 */
> > >  	if (sds.prefer_sibling && local->group_type =3D=3D group_has_spare =
&&
> > > -	    busiest->sum_nr_running > local->sum_nr_running + 1)
> > > +	    sibling_imbalance(env, &sds, busiest, local) > 1)
> > >  		goto force_balance;
> > >=20
> > >  	if (busiest->group_type !=3D group_overloaded) {

