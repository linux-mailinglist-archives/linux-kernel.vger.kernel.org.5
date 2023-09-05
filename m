Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF1792D78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbjIESjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjIESjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:39:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960010F5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693939111; x=1725475111;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zeuh5oc+Xh+VeV4CeHgRU2oLCvBirD1c2BwS16rPdkM=;
  b=M7qT4wtkfKDWN9sBwTDnDAe1L7/szkt0ARMOoEdx6bkm4SA3E6uGnCqL
   W7p0VTEDVYvtzj1lfai48sLHUeimxziuDdmBkHGh5pYLbm0c+DCgEb+Wd
   yR+mnpmr/5gzuMWUnSd7MSJdyn56fWax68Oxj023i4XaVbFhozGK/bKKC
   UgRL2OMhAVCRCKVhI78O2o5RezpBn1s3b1/LqKJYxESsF121Ux2MBYYhE
   mYqDuFwGTSuotl64UdZ7kiTDxuOgLl4Adw40TJFVmU/k1mdO2HeGbBYSu
   2q4KaktmS5ndxnzSzXH/h/MHl/KrnJ9vi8els+H6Py74wIa7SD9471sGh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361905252"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="361905252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072072677"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="1072072677"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:37:15 -0700
Message-ID: <dee7575cc9d3c42c9705348151a1453ff084d4f3.camel@linux.intel.com>
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
Date:   Tue, 05 Sep 2023 11:37:15 -0700
In-Reply-To: <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
         <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
         <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 13:33 +0530, Shrikanth Hegde wrote:
>=20
> On 8/22/23 12:49 AM, Tim Chen wrote:
> > On Mon, 2023-08-07 at 15:06 +0530, Shrikanth Hegde wrote:
> > > >=20
> > > > From: Tim Chen <tim.c.chen@linux.intel.com>
> > > > Date: Fri, 14 Jul 2023 16:09:30 -0700
> > > > Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
> > > >=20
> > > > For SMT4, any group with more than 2 tasks will be marked as
> > > > group_smt_balance. Retain the behaviour of group_has_spare by marki=
ng
> > > > the busiest group as the group which has the least number of idle_c=
pus.
> > > >=20
> > > > Also, handle rounding effect of adding (ncores_local + ncores_busy)
> > > > when the local is fully idle and busy group has more than 2 tasks.
> > > > Local group should try to pull at least 1 task in this case.
> > > >=20
> > > > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > > ---
> > > >  kernel/sched/fair.c | 18 ++++++++++++++++--
> > > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index a87988327f88..566686c5f2bd 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct l=
b_env *env,
> > > >  	imbalance /=3D ncores_local + ncores_busiest;
> > > > =20
> > > >  	/* Take advantage of resource in an empty sched group */
> > > > -	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > > > +	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
> > > >  	    busiest->sum_nr_running > 1)
> > > >  		imbalance =3D 2;
> > > > =20
> > > > @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb=
_env *env,
> > > >  		break;
> > > > =20
> > > >  	case group_smt_balance:
> > > > +		/* no idle cpus on both groups handled by group_fully_busy below=
 */
> > > > +		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
> > > > +			if (sgs->idle_cpus > busiest->idle_cpus)
> > > > +				return false;
> > > > +			if (sgs->idle_cpus < busiest->idle_cpus)
> > > > +				return true;
> > > > +			if (sgs->sum_nr_running <=3D busiest->sum_nr_running)
> > > > +				return false;
> > > > +			else
> > > > +				return true;
> > > > +		}
> > > > +		goto fully_busy;
> > > > +		break;
> > > > +
> > > >  	case group_fully_busy:
> > > >  		/*
> > > >  		 * Select the fully busy group with highest avg_load. In
> > > > @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_=
env *env,
> > > >  		 * select the 1st one, except if @sg is composed of SMT
> > > >  		 * siblings.
> > > >  		 */
> > > > -
> > > > +fully_busy:
> > > >  		if (sgs->avg_load < busiest->avg_load)
> > > >  			return false;
> > > > =20
> > >=20
> > > Hi Tim, Peter.=20
> > >=20
> > > group_smt_balance(cluster scheduling), patches are in tip/sched/core.=
 I dont=20
> > > see this above patch there yet. Currently as is, this can cause funct=
ion difference=20
> > > in SMT4 systems( such as Power10).=20
> > >=20
> > > Can we please have the above patch as well in tip/sched/core?
> > >=20
> > > Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> >=20
> > Hi Peter,
> >=20
> > Just back from my long vacation.  Wonder if you have any comments on th=
e above patch
> > for fixing the SMT4 case?
> >=20
> > Tim
>=20
> Hi Tim, Peter.=20
>=20
> are there any concerns with the above patch for fixing the SMT4 case.=20
> Currently the behavior is group_smt_balance is set for having even 2 task=
s in=20
> SMT4, ideally it should be same as the group_has_spare.=20
>=20
> The above patch copies the same behavior to group_smt_balance.=20
> >=20

You mean simplify the patch as below?  I think that should be fine.  Can yo=
u
make sure it works for SMT4?  And I can update the patch once you confirm i=
t
works properly.

Tim

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e7ee2efc1ba..48e9ab7f8a87 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9764,16 +9764,9 @@ static bool update_sd_pick_busiest(struct lb_env *en=
v,
=20
        case group_smt_balance:
                /* no idle cpus on both groups handled by group_fully_busy =
below */
-               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
-                       if (sgs->idle_cpus > busiest->idle_cpus)
-                               return false;
-                       if (sgs->idle_cpus < busiest->idle_cpus)
-                               return true;
-                       if (sgs->sum_nr_running <=3D busiest->sum_nr_runnin=
g)
-                               return false;
-                       else
-                               return true;
-               }
+               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)
+                       goto has_spare;
+
                goto fully_busy;
=20
        case group_fully_busy:
@@ -9809,6 +9802,7 @@ static bool update_sd_pick_busiest(struct lb_env *env=
,
                 * as we do not want to pull task off SMT core with one tas=
k
                 * and make the core idle.
                 */
+has_spare:
                if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
                        if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_=
nr_running <=3D 1)
                                return false;



