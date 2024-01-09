Return-Path: <linux-kernel+bounces-21455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD32828F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B19EB236CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD43DB9B;
	Tue,  9 Jan 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7vGRN5F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670883DB86
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704837624; x=1736373624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QjgZpGFHA+FPBRTzqHWSHb+oBeT6/irOFJFEnoel6w=;
  b=I7vGRN5FnqIuYrH+pgmBpbmEoFllDHA3fGfbcqYV34bsiImwjkpQFj2P
   M4yuAZT7ozU9FenhMXVEyePwt5pnw9tYQEwRD2m9nxP16HfvJEO4iau7d
   WN2i3g0YZmvSUMuVBb61mSz61GBiy4WowdvDWaWlCd1dCSk+yPxi1gLH7
   Ek4km160xchcoHYV3yvq3gw2NFC5ABTmVzFb1UXH28z1yZH0S9GenILci
   5wvSoQPuSbwaH3+gULoC9PZGf0Oalc1E9eKb1LTJcLI4K4b4qUzPdMUFh
   aVq8jSg07s9ivIjoY/BaYz+LW6rpz8MRBKdZ3dHbu8ouhaTiniRerp9ML
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5704798"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5704798"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925418904"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925418904"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:00:16 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Xiaochen Shen <xiaochen.shen@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/resctrl: Implement new MBA_mbps throttling heuristic
Date: Tue,  9 Jan 2024 14:00:03 -0800
Message-ID: <20240109220003.29225-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201214737.104444-1-tony.luck@intel.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

This patch was previously posted in:

  https://lore.kernel.org/lkml/ZVU+L92LRBbJXgXn@agluck-desk3/#t

as part of a proposal to allow the mba_MBps mount option to base its
feedback loop input on total bandwidth instead of local bandwidth.
Sending it now as a standalone patch because Xiaochen reported that
real systems have experienced problems when delta_bw is incorrectly
calculated.

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

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.43.0


