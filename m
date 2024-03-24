Return-Path: <linux-kernel+bounces-114089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B91888F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B5D28EE86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CA15EFB1;
	Sun, 24 Mar 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLcvOCZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4A20012C;
	Sun, 24 Mar 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321383; cv=none; b=q4SxKcTrTgT96pP0u4V6EMQy/fp2tpdWwMHeR3h+6ZN6RD+APl2SmUgnQ29pZtrBpahlqQLCw+GNxdb5zqUNzbuo/5DT9KykRAWOFdhh1W9p6ZHX0/V66sBaTtCZivmAX4Ccf/aFWHxdJiKj5CGiZ3M9sb4Wc0EN9c7MfYb8ri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321383; c=relaxed/simple;
	bh=cgkhm4UNYG9J5WH09YoX845iQMMEDlx7LxlKEATqzDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHQEJVB5yklxXRwDHIF8O0r52Ca+8vzvDOPr8cvHUSi9BipH2VE2ac0YjIGI+WZkQNsNcr2+xsjlrbhFcyv93qU3b64+ZpROl+Nqs3R3zricp+G6ZPUEiDpLPTNlaOevYxI7uVBdlK0b6xZcfG4fxdvbZ1fhV7ZXTJbQZnpkBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLcvOCZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CD0C433C7;
	Sun, 24 Mar 2024 23:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321382;
	bh=cgkhm4UNYG9J5WH09YoX845iQMMEDlx7LxlKEATqzDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLcvOCZlAdIBeKIa3Tz/luf/ChdXjEYsAk1lnEIb25g5xN9uoIjYNSdxNqCaFqPhM
	 gCv5JJ8qccOTze9OvdKseQNJuNWZc4av3ngpcdpDfhxSJiu7kUMFDKldvbQNaAln3z
	 IWys16INHB0090wB9j7UiHdvhM5wq7OTyjZbKs0Bnr3Wr7VWpPhR/i7wH9KwMD+9Uv
	 h2pR62PsDdtCQ5t9mi/ElGI0WMSTH7PAoZGD8iv5pSpRNBmSsYhQnqzNMHNY6r6ME8
	 lf/WT5NLxL8Sll6wfcn6fGKP/EUYcvAv6S/PMERx1sQS9uurNuRpneMkuxRa9WZ5yv
	 vFAEI9u9LmeXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Xiaochen Shen <xiaochen.shen@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 106/638] x86/resctrl: Implement new mba_MBps throttling heuristic
Date: Sun, 24 Mar 2024 18:52:23 -0400
Message-ID: <20240324230116.1348576-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit c2427e70c1630d98966375fffc2b713ab9768a94 ]

The mba_MBps feedback loop increases throttling when a group is using
more bandwidth than the target set by the user in the schemata file, and
decreases throttling when below target.

To avoid possibly stepping throttling up and down on every poll a flag
"delta_comp" is set whenever throttling is changed to indicate that the
actual change in bandwidth should be recorded on the next poll in
"delta_bw". Throttling is only reduced if the current bandwidth plus
delta_bw is below the user target.

This algorithm works well if the workload has steady bandwidth needs.
But it can go badly wrong if the workload moves to a different phase
just as the throttling level changed. E.g. if the workload becomes
essentially idle right as throttling level is increased, the value
calculated for delta_bw will be more or less the old bandwidth level.
If the workload then resumes, Linux may never reduce throttling because
current bandwidth plus delta_bw is above the target set by the user.

Implement a simpler heuristic by assuming that in the worst case the
currently measured bandwidth is being controlled by the current level of
throttling. Compute how much it may increase if throttling is relaxed to
the next higher level. If that is still below the user target, then it
is ok to reduce the amount of throttling.

Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xiaochen Shen <xiaochen.shen@intel.com>
Link: https://lore.kernel.org/r/20240122180807.70518-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++--------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 40b69b3fc8728..566386abb877f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -295,14 +295,10 @@ struct rftype {
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
index acca577e2b066..3a6c069614eb8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -440,9 +440,6 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	cur_bw = bytes / SZ_1M;
 
-	if (m->delta_comp)
-		m->delta_bw = abs(cur_bw - m->prev_bw);
-	m->delta_comp = false;
 	m->prev_bw = cur_bw;
 }
 
@@ -520,11 +517,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
 	struct rdtgroup *entry;
+	u32 cur_bw, user_bw;
 
 	if (!is_mbm_local_enabled())
 		return;
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
2.43.0


