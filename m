Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D77792F73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbjIEUFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjIEUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:05:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09DD1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693944313; x=1725480313;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gE8wq2pMZ6pgS5VFP4+klcnhCOfTrYcfQ1UPEs8ziog=;
  b=TY2hhD9SOz1O2yHByqc6+edEwxzKHI/ywMvHyMWz5SESlsDcwJVs1hH7
   +LT29+ay8ISvPmfDdw25Wh0s2mScE//pO5AvivuQf1J0fcFJtGjRP7toR
   bH/fXvpjyFJPgv+7ZtCeNcQecxe4Ryv+6MMLGf/Esbx83+jkFhoKHVPSB
   zs6qjqQs5xMQVo42yuIymisUeb4HHExLXsffjH5JUST+45LBek9TTW740
   OufibMHPKE9d8kWuvmokYJcP1TbcE4o11b7Ph9MSiHBOdNwoHp1iIpdub
   wUc/jSRBgWuHYKnrDLA9Rt/CrLVW5fx96fMTu+t4Qn1ECSyOOj5P169bz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380672890"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380672890"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741191744"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="741191744"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:54:09 -0700
Message-ID: <0410f8756bbcb2f893622de4e146c13e9565248e.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com, hdanton@sina.com,
        ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Date:   Tue, 05 Sep 2023 10:54:09 -0700
In-Reply-To: <20230905104136.GC28319@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <20230905104136.GC28319@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 12:41 +0200, Peter Zijlstra wrote:
> On Thu, Jul 27, 2023 at 06:32:44AM -0700, Tim Chen wrote:
>=20
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
>=20
> This is really daft; why can't this simply be: fallthrough; ? At the
> very least that break must go.
>=20
>=20

Yes, the break should go.  I was adding the goto to prevent compiler
from complaining about fall through code.  The break no longer is needed.

Tim

From 81971a0b1eb64059756f00d8497b1865af2c0792 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 14 Jul 2023 16:09:30 -0700
Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling

For SMT4, any group with more than 2 tasks will be marked as
group_smt_balance. Retain the behaviour of group_has_spare by marking
the busiest group as the group which has the least number of idle_cpus.

Also, handle rounding effect of adding (ncores_local + ncores_busy)
when the local is fully idle and busy group has more than 2 tasks.
Local group should try to pull at least 1 task in this case.

Fixes: fee1759e4f04 ("sched/fair: Determine active load balance for SMT sch=
ed groups")
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..6e7ee2efc1ba 100644
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
@@ -9763,6 +9763,19 @@ static bool update_sd_pick_busiest(struct lb_env *en=
v,
 		break;
=20
 	case group_smt_balance:
+		/* no idle cpus on both groups handled by group_fully_busy below */
+		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
+			if (sgs->idle_cpus > busiest->idle_cpus)
+				return false;
+			if (sgs->idle_cpus < busiest->idle_cpus)
+				return true;
+			if (sgs->sum_nr_running <=3D busiest->sum_nr_running)
+				return false;
+			else
+				return true;
+		}
+		goto fully_busy;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9775,7 +9788,7 @@ static bool update_sd_pick_busiest(struct lb_env *env=
,
 		 * select the 1st one, except if @sg is composed of SMT
 		 * siblings.
 		 */
-
+fully_busy:
 		if (sgs->avg_load < busiest->avg_load)
 			return false;
=20
--=20
2.32.0


