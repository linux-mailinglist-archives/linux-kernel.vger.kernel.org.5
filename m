Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6287ED657
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbjKOVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:55:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E808198;
        Wed, 15 Nov 2023 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700085297; x=1731621297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a+fVXrNLk5DqXN5Kg+eKdHJGKVcaXV9V46K/2MKh2j4=;
  b=GCWU722CzVn2JnmDNM07RSZXC46XXuIzSTsMgavQ1Lr2qN0jU/JMtsut
   3w8BUKZM+M6PYCdKdQjJVRMdBF1Qi/+XaYf5EBEBlOQwnwCZOw9DOx2oq
   pXouNJT6bsQq8K50N8y5phs0F44uoxsTbiAEXzcbTlmV3lafYcXpk1k5V
   QQO1OuUx15hSxkpMFHaV+ujWOPRBaaGWS1cbf/xAv6tyMX2zAHcKBA4hm
   hCm6PYWqJd1V+Z6zwWogsoV+iw6+erlmAsFRD89fvspvY/EukLIQXUgcS
   1TEcb8DZKH5cTQsXmPWEMa5khz6ZLJPEeVGTuY/MJgevwtJWMn6i383Z2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390756495"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="390756495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012395807"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="1012395807"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:54:56 -0800
Date:   Wed, 15 Nov 2023 13:54:55 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if
 local b/w unavailable
Message-ID: <ZVU+L92LRBbJXgXn@agluck-desk3>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
 <ZUqo+MsEQi2Xc/pO@agluck-desk3>
 <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
 <SJ1PR11MB6083F3355446B7879177A1FBFCAFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b6a6409e-5f13-4f7e-835a-c9e3653a7ad5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a6409e-5f13-4f7e-835a-c9e3653a7ad5@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:09:13AM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 11/9/2023 1:27 PM, Luck, Tony wrote:
> >>> Maybe additional an mount option "mba_MBps_total" so the user can pick
> >>> total instead of local?
> >>
> >> Is this something for which a remount is required? Can it not perhaps be
> >> changed at runtime?
> > 
> > In theory, yes. But I've been playing with a patch that adds a writable info/
> > file to allow runtime switch:
> > 
> > # ls -l /sys/fs/resctrl/info/MB/mba_MBps_control
> > -rw-r--r--. 1 root root 0 Nov  9 10:57 /sys/fs/resctrl/info/MB/mba_MBps_control
> > ]# cat /sys/fs/resctrl/info/MB/mba_MBps_control
> > total
> > 
> > and found that it's a bit tricky to switch out the MBM event from the
> > state machine driving the feedback loop. I think the problem is in the
> > code that tries to stop the control loop from switching between two
> > throttling levels every second:
> > 
> >         if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
> >                 new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
> >         } else if (cur_msr_val < MAX_MBA_BW &&
> >                    (user_bw > (cur_bw + delta_bw))) {
> >                 new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
> >         } else {
> >                 return;
> >         }
> > 
> > The code drops down one percentage step if current bandwidth is above
> > the desired target. But stepping back up checks to see if "cur_bw + delta_bw"
> > is below the target.
> > 
> > Where does "delta_bw" come from? Code uses the Boolean flag "pmbm_data->delta_comp"
> > to request the once-per-second polling compute the change in bandwidth on the
> > next poll after adjusting throttling MSRs.
> > 
> > All of these values are in the "struct mbm_state" which is a per-event-id structure.
> > 
> > Picking an event at boot time works fine. Likely also fine at mount time. But
> > switching at run-time seems to frequently end up with a very large value in
> > "delta_bw" (as it compares current & previous for this event ... and it looks
> > like things changed from zero).  Net effect is that throttling is increased when
> > processes go over their target for the resctrl group, but throttling is never decreased.
> 
> This is not clear to me. Would the state not also start from zero at boot and mount
> time? From what I understand the state is also reset to zero on monitor group creation.

Yes. All of boot, mount, mkdir start a group in a well defined state
with no throttling applied (schemata shows bandwitdh limit as 2^32
MBytes/sec). If the user sets some realistic limit, and the group
MBM measurement exceeds that limit, then the MBA MSR for the group
is dropped from 100% to 90% and the delta_comp flag set to record
the delta_bw on the next 1-second poll.

The value of delta_bw is only used when looking to reduce throttling.
To be in that state this group must have been in a state where
throttling was increased ... which would result in delta_bw being
set up.

Now look at what happens when switching from local to total for the
first time. delta_bw is zero in the structures recording total bandwidth
information. But more importanly so is prev_bw. If the code above
changes throttling value and requests an updated calulation of delta_bw,
that will be done using a value of prev_bw==0. I.e. delta_bw will be
set to the current bandwidth. That high value will likely block attempts
to reduce throttling.

Maybe when switching MBM source events the prev_bw value should be
copied from old source structures to new source structures as a rough
guide to avoid crazy actions. But that could also be wrong when
switching from total to local for a group that has poor NUMA
localization and total bandwidth is far higher than local.

> > The whole heuristic seems a bit fragile. It works well for test processes that have
> > constant memory bandwidth. But I could see it failing in scenarios like this:
> > 
> > 1) Process is over MB limit
> > 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
> > 3) Process blocks on some event and uses no bandwidth in next one second
> > 4) Next poll. Linux computes delta_bw as abs(cur_bw - m->prev_bw). cur_bw is zero,
> >     so delta_bw is set to full value of bandwidth that process used when over budget
> > 5) Process resumes running
> > 6) Linux sees process using less than target, but cur_bw + delta_bw is above target,
> >    so Linux doesn't adjust throttling
> > 
> > I think the goal was to avoid relaxing throttling and letting a resctrl group go back over
> > target bandwidth. But that doesn't work either for groups with highly variable bandwidth
> > requirements.
> > 
> > 1) Group is over budget
> > 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
> > 3) Group forks additional processes. New bandwidth from those offsets the reduction due to throttling
> > 4) Next poll. Linux sees bandwidth is unchanged. Sets delta_bw = 0.
> > 5) Next poll. Groups aggregate bandwidth is fractionally below target. Because delta_bw=0, Linux
> >    reduces throttling.
> > 6) Group goes over target.
> > 
> 
> I'll defer to you for the history about this algorithm. I am not familiar with how
> broadly this feature is used but I have not heard about issues with it. It does
> seem as though there is some opportunity for investigation here.

I sure I could construct an artificial test case to force this scenario.
But maybe:
1) It never happens in real life
2) It happens, but nobody noticed
3) People figured out the workaround (set schemata to a really big
   MBytes/sec value for a second, and then back to desired value).
4) Few people use this option

I dug again into the lore.kernel.org archives. Thomas complained
that is wasn't "calibration" (as Vikas had descibed in in V1) but
seems to have otherwise been OK with it as a heuristic.

https://lore.kernel.org/all/alpine.DEB.2.21.1804041037090.2056@nanos.tec.linutronix.de/


I coded up and tested the below patch as a possible replacement heuristic.
But I also wonder whether just letting the feedback loop flip throttling
up and down between throttling values above/below the target bandwidth
would really be so bad. It's just one MSR write that can be done from
the current CPU and would result in average bandwidth closer to the
user requested target.

-Tony


From 2d6d08c8ebeb62830b6d8dea36f5a8d5a53b75eb Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Mon, 13 Nov 2023 13:29:29 -0800
Subject: [PATCH] x86/resctrl: Implement new MBA_mbps throttling heuristic

The MBA_mbps feedback loop increases throttling when a group is using
more bandwidth than the target set by the user in the schemata file, and
decreases throttling when below target.

To avoid possibly stepping throttling up and down on every poll a
flag "delta_comp" is set whenever throttling is changed to indicate
that the actual change in bandwidth should be recorded on the next
poll in "delta_bw". Throttling is only reduced if the current bandwidth
plus delta_bw is below the user target.

This algorithm works well if the workload has steady bandwidth needs.
But it can go badly wrong if the workload moves to a different phase
just as the throttling level changed. E.g. if the workload becomes
essentially idle right as throttling level is increased, the value
calculated for delta_bw will be more or less the old bandwidth level.
If the workload then resumes, Linux may never reduce throttling because
current bandwidth plu delta_bw is above the target set by the user.

Implement a simpler heuristic by assuming that in the worst case the
currently measured bandwidth is being controlled by the current level of
throttling. Compute how much it may increase if throttling is relaxed to
the next higher level. If that is still below the user target, then it
is ok to reduce the amount of throttling.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++--------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..71bbd2245cc7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -296,14 +296,10 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
- * @delta_bw:	Difference between the current and previous bandwidth
- * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	prev_bw_bytes;
 	u32	prev_bw;
-	u32	delta_bw;
-	bool	delta_comp;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..1961823b555b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -440,9 +440,6 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	cur_bw = bytes / SZ_1M;
 
-	if (m->delta_comp)
-		m->delta_bw = abs(cur_bw - m->prev_bw);
-	m->delta_comp = false;
 	m->prev_bw = cur_bw;
 }
 
@@ -520,7 +517,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
+	u32 cur_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
@@ -543,7 +540,6 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	cur_bw = pmbm_data->prev_bw;
 	user_bw = dom_mba->mbps_val[closid];
-	delta_bw = pmbm_data->delta_bw;
 
 	/* MBA resource doesn't support CDP */
 	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
@@ -555,49 +551,31 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
 		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
 		cur_bw += cmbm_data->prev_bw;
-		delta_bw += cmbm_data->delta_bw;
 	}
 
 	/*
 	 * Scale up/down the bandwidth linearly for the ctrl group.  The
 	 * bandwidth step is the bandwidth granularity specified by the
 	 * hardware.
-	 *
-	 * The delta_bw is used when increasing the bandwidth so that we
-	 * dont alternately increase and decrease the control values
-	 * continuously.
-	 *
-	 * For ex: consider cur_bw = 90MBps, user_bw = 100MBps and if
-	 * bandwidth step is 20MBps(> user_bw - cur_bw), we would keep
-	 * switching between 90 and 110 continuously if we only check
-	 * cur_bw < user_bw.
+	 * Always increase throttling if current bandwidth is above the
+	 * target set by user.
+	 * But avoid thrashing up and down on every poll by checking
+	 * whether a decrease in throttling is likely to push the group
+	 * back over target. E.g. if currently throttling to 30% of bandwidth
+	 * on a system with 10% granularity steps, check whether moving to
+	 * 40% would go past the limit by multiplying current bandwidth by
+	 * "(30 + 10) / 30".
 	 */
 	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
 		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
 	} else if (cur_msr_val < MAX_MBA_BW &&
-		   (user_bw > (cur_bw + delta_bw))) {
+		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val))) {
 		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
 	} else {
 		return;
 	}
 
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
-
-	/*
-	 * Delta values are updated dynamically package wise for each
-	 * rdtgrp every time the throttle MSR changes value.
-	 *
-	 * This is because (1)the increase in bandwidth is not perfectly
-	 * linear and only "approximately" linear even when the hardware
-	 * says it is linear.(2)Also since MBA is a core specific
-	 * mechanism, the delta values vary based on number of cores used
-	 * by the rdtgrp.
-	 */
-	pmbm_data->delta_comp = true;
-	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
-		cmbm_data->delta_comp = true;
-	}
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
-- 
2.41.0

