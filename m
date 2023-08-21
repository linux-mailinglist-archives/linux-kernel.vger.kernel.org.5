Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7BF783153
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjHUTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHUTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:19:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B936CDF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692645580; x=1724181580;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=g6J+YlLs47gxFdtcECVNbnwj3L9gC579vbJHvHlKX/k=;
  b=BxlijJjr+HuTVkfRm22Yt5NZomBP7tpWt6WV82NNVJf7BX5oaHUNpQoW
   K4r5SozRU0nVdRBMm2Ab/ZZvoAYPyUmKiiabB/UmfGrpyU9af3ZtjlP/8
   UB81+fjDC6vyBLjnBDlwXPNvP8tjEJ6j3RPWfHQGj4s1xXf5feWF9ATa4
   uZ/Y9hRMgAAxnqo9iv0pJgkJaPfk8T5wfuJD6PE8rqHXWWr7i3R+XMFoZ
   z1RL4cHgf8jTzQyrxTzx0J4TW//sZo5wDHYGM9Yy6/dbnBogg2xjE6KKJ
   dHqm62a/qZQ825MI119ZiRb//JEFRQgVPoApgnT7FNKGm511RY8I0pvN1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377427397"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="377427397"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 12:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771072038"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="771072038"
Received: from fanl-mobl.amr.corp.intel.com (HELO [10.212.237.108]) ([10.212.237.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 12:19:40 -0700
Message-ID: <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Date:   Mon, 21 Aug 2023 12:19:40 -0700
In-Reply-To: <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
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

On Mon, 2023-08-07 at 15:06 +0530, Shrikanth Hegde wrote:
> >=20
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> > Date: Fri, 14 Jul 2023 16:09:30 -0700
> > Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
> >=20
> > For SMT4, any group with more than 2 tasks will be marked as
> > group_smt_balance. Retain the behaviour of group_has_spare by marking
> > the busiest group as the group which has the least number of idle_cpus.
> >=20
> > Also, handle rounding effect of adding (ncores_local + ncores_busy)
> > when the local is fully idle and busy group has more than 2 tasks.
> > Local group should try to pull at least 1 task in this case.
> >=20
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a87988327f88..566686c5f2bd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_en=
v *env,
> >  	imbalance /=3D ncores_local + ncores_busiest;
> > =20
> >  	/* Take advantage of resource in an empty sched group */
> > -	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > +	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
> >  	    busiest->sum_nr_running > 1)
> >  		imbalance =3D 2;
> > =20
> > @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> >  		break;
> > =20
> >  	case group_smt_balance:
> > +		/* no idle cpus on both groups handled by group_fully_busy below */
> > +		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
> > +			if (sgs->idle_cpus > busiest->idle_cpus)
> > +				return false;
> > +			if (sgs->idle_cpus < busiest->idle_cpus)
> > +				return true;
> > +			if (sgs->sum_nr_running <=3D busiest->sum_nr_running)
> > +				return false;
> > +			else
> > +				return true;
> > +		}
> > +		goto fully_busy;
> > +		break;
> > +
> >  	case group_fully_busy:
> >  		/*
> >  		 * Select the fully busy group with highest avg_load. In
> > @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env =
*env,
> >  		 * select the 1st one, except if @sg is composed of SMT
> >  		 * siblings.
> >  		 */
> > -
> > +fully_busy:
> >  		if (sgs->avg_load < busiest->avg_load)
> >  			return false;
> > =20
>=20
> Hi Tim, Peter.=20
>=20
> group_smt_balance(cluster scheduling), patches are in tip/sched/core. I d=
ont=20
> see this above patch there yet. Currently as is, this can cause function =
difference=20
> in SMT4 systems( such as Power10).=20
>=20
> Can we please have the above patch as well in tip/sched/core?
>=20
> Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Hi Peter,

Just back from my long vacation.  Wonder if you have any comments on the ab=
ove patch
for fixing the SMT4 case?

Tim

