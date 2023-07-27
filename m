Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50EF765572
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjG0N6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjG0N6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:58:32 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C74E30D8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690466310; x=1722002310;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XN0HL492BWwqQUJmRY6mFdf1jif2qQBvqZI3+P1xBvo=;
  b=UNPdmmIMMZiE70aa6oon5YVgmyp+xFPIE71m9kIXndHMnbCteCO0vh3A
   DUNg/5lFHH+ESaL3ieWaoskaUoFzIptF+UyGGB1GIYYb/nXTMdHPS6m1R
   +d36qu4dI3nm19kI6zwVx4Zw0A1JodB81wiCQljgKmdt4jzZHoXy60yod
   8UXIWD7PFGfMG8APSGdMxloKiFgwsiNMHxHFvF33jYO5GgF1BjSVfuUw8
   Q4FXr8gHulHGH3+oYmY8xgQff6EFu0WRWbtDagsPxtMOfneTf8DlC2+dw
   /zqhKkfKgKaTOlS+nqfgrYEUgpY5wTyiW3J51dIk29QXnK/OTj2Y2D2Lb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371005770"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="371005770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900884138"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="900884138"
Received: from akhaw1-mobl2.gar.corp.intel.com (HELO [10.213.157.76]) ([10.213.157.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:32:48 -0700
Message-ID: <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
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
Date:   Thu, 27 Jul 2023 06:32:44 -0700
In-Reply-To: <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-26 at 20:11 -0700, Tim Chen wrote:
> On Mon, 2023-07-17 at 20:28 +0530, Shrikanth Hegde wrote:
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> >=20
> > For SMT4, any group with more than 2 tasks will be marked as
> > group_smt_balance. Retain the behaviour of group_has_spare by marking
> > the busiest group as the group which has the least number of idle_cpus.
> >=20
> > Also, handle rounding effect of adding (ncores_local + ncores_busy)
> > when the local is fully idle and busy group has more than 2 tasks.
> > Local group should try to pull at least 1 task in this case.
> >=20
> > Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 932e7b78894a..9502013abe33 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_en=
v *env,
> >  	imbalance /=3D ncores_local + ncores_busiest;
> >=20
> >  	/* Take advantage of resource in an empty sched group */
> > -	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > +	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
> >  	    busiest->sum_nr_running > 1)
> >  		imbalance =3D 2;
> >=20
> > @@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> >  		break;
> >=20
> >  	case group_smt_balance:
> > +		/* no idle cpus on both groups handled by group_fully_busy below */
> > +		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
> > +			if (sgs->idle_cpus > busiest->idle_cpus)
> > +				return false;
> > +			if (sgs->idle_cpus < busiest->idle_cpus)
> > +				return true;
> > +			if (sgs->sum_nr_running <=3D busiest->sum_nr_running)
> > +				return false;
> > +		}
> > +		break;

Shrikanth and Peter,

Sorry, I acked Shrikanth's fixup patch too quickly without seeing that Shri=
kanth added
a "break" in the patch above.  My original code did not have that break sta=
tement as
I did intend the code to fall through to the "group_fully_busy" code path w=
hen
there are no idle cpus in both groups.  To make the compiler happy and putt=
ing
in the correct logic, I refresh the patch as below.

Thanks.

Tim

From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 14 Jul 2023 16:09:30 -0700
Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling

For SMT4, any group with more than 2 tasks will be marked as
group_smt_balance. Retain the behaviour of group_has_spare by marking
the busiest group as the group which has the least number of idle_cpus.

Also, handle rounding effect of adding (ncores_local + ncores_busy)
when the local is fully idle and busy group has more than 2 tasks.
Local group should try to pull at least 1 task in this case.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a87988327f88..566686c5f2bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_env *e=
nv,
 	imbalance /=3D ncores_local + ncores_busiest;
=20
 	/* Take advantage of resource in an empty sched group */
-	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
+	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance =3D 2;
=20
@@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env *en=
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
+		break;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env *env=
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


