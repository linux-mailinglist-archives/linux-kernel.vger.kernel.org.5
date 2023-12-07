Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFB8091FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjLGT41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjLGT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:56:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9E10F7;
        Thu,  7 Dec 2023 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701978985; x=1733514985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rzvL5k6M1nGqaS/TBlqP4ZQ+wAzLxV/e2Y2+OAMN5qA=;
  b=U0c69NoCTRmb07TMKW9YKtyYz6WF5lFrAYUv+G/JPZZ+V+L+DlB6ybTG
   Dca+XL+ca3Ws/LVJVP5IGuvRXL6EV2t8sTYFip1s/qQlkx55JbeAn42Mo
   TTZ/aAJQ+LtIsx5vx+msRX3fA1elQEp7RGitW0r/oiS8BwRi3HqyDW8s0
   HxUGJ3EH22Luc4AJZgnOC5w0u3q9SRAtcYZSmXplibyfbblJaq0QKXWkC
   zyh/wblcBuFCtv1x/f+tMkouvUYTT+EZGfOHPAz5YrhBh+IF9qB5fOFPF
   S/YLuNmeDpsj6znkoNZSTeERstAaAWunY5YJnabbqc+KkEe8M75lyIgmo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="15848949"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="15848949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889858590"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889858590"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:56:23 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Date:   Thu,  7 Dec 2023 11:56:11 -0800
Message-ID: <20231207195613.153980-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207195613.153980-1-tony.luck@intel.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MBA Software Controller(mba_sc) is a feedback loop that uses
measurements of local memory bandwidth to adjust MBA throttling levels
to keep workloads in a resctrl group within a target bandwidth set in
the schemata file.

Users may want to use total memory bandwidth instead of local to handle
workloads that have poor NUMA localization.

Add a new mount option "mba_MBps_event={event_name}" where event_name
is one of "mbm_Local_bytes" or "mbm_total_bytes" that allows a user to
specify which monitoring event to use.

Update the once-per-second polling code to use the chosen event (local
or total memory bandwidth).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  2 +
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++-----
 4 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..1feb3b2e64fa 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -129,6 +129,7 @@ enum membw_throttle_mode {
  * @throttle_mode:	Bandwidth throttling mode when threads request
  *			different memory bandwidths
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
+ * @mba_mbps_event:	Event (local or total) for mba_sc
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct resctrl_membw {
@@ -138,6 +139,7 @@ struct resctrl_membw {
 	bool				arch_needs_linear;
 	enum membw_throttle_mode	throttle_mode;
 	bool				mba_sc;
+	enum resctrl_event_id		mba_mbps_event;
 	u32				*mb_map;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..8b9b8f664324 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -58,7 +58,8 @@ struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
-	bool				enable_mba_mbps;
+	bool				enable_mba_mbps_local;
+	bool				enable_mba_mbps_total;
 	bool				enable_debug;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..d9e590f1cbc3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -431,9 +431,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct mbm_state *m = &rr->d->mbm_local[rmid];
 	u64 cur_bw, bytes, cur_bytes;
+	struct mbm_state *m;
 
+	m = get_mbm_state(rr->d, rmid, rr->evtid);
 	cur_bytes = rr->val;
 	bytes = cur_bytes - m->prev_bw_bytes;
 	m->prev_bw_bytes = cur_bytes;
@@ -521,19 +522,21 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	u32 cur_bw, delta_bw, user_bw;
+	enum resctrl_event_id evt_id;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
 	struct rdtgroup *entry;
 
-	if (!is_mbm_local_enabled())
+	if (!is_mbm_enabled())
 		return;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	evt_id = r_mba->membw.mba_mbps_event;
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	pmbm_data = get_mbm_state(dom_mbm, rmid, evt_id);
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -553,7 +556,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, evt_id);
 		cur_bw += cmbm_data->prev_bw;
 		delta_bw += cmbm_data->delta_bw;
 	}
@@ -616,18 +619,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
 		__mon_event_count(rmid, &rr);
+		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
+			mbm_bw_count(rmid, &rr);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
 		rr.val = 0;
 		__mon_event_count(rmid, &rr);
-
-		/*
-		 * Call the MBA software controller only for the
-		 * control groups and when user has enabled
-		 * the software controller explicitly.
-		 */
-		if (is_mba_sc(NULL))
+		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
 			mbm_bw_count(rmid, &rr);
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..5f64a0b2597c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	return (is_mbm_local_enabled() &&
+	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear());
 }
 
@@ -2302,7 +2302,7 @@ static bool supports_mba_mbps(void)
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.
  */
-static int set_mba_sc(bool mba_sc)
+static int set_mba_sc(bool mba_sc, enum resctrl_event_id mba_mbps_event)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	u32 num_closid = resctrl_arch_get_num_closid(r);
@@ -2313,6 +2313,7 @@ static int set_mba_sc(bool mba_sc)
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
+	r->membw.mba_mbps_event = mba_mbps_event;
 
 	list_for_each_entry(d, &r->domains, list) {
 		for (i = 0; i < num_closid; i++)
@@ -2445,13 +2446,14 @@ static void rdt_disable_ctx(void)
 {
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-	set_mba_sc(false);
+	set_mba_sc(false, QOS_L3_MBM_LOCAL_EVENT_ID);
 
 	resctrl_debug = false;
 }
 
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 {
+	enum resctrl_event_id mba_mbps_event;
 	int ret = 0;
 
 	if (ctx->enable_cdpl2) {
@@ -2466,8 +2468,12 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 			goto out_cdpl2;
 	}
 
-	if (ctx->enable_mba_mbps) {
-		ret = set_mba_sc(true);
+	if (ctx->enable_mba_mbps_local || ctx->enable_mba_mbps_total) {
+		if (ctx->enable_mba_mbps_total)
+			mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+		else
+			mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+		ret = set_mba_sc(true, mba_mbps_event);
 		if (ret)
 			goto out_cdpl3;
 	}
@@ -2683,15 +2689,17 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_mba_mbps_event,
 	Opt_debug,
 	nr__rdt_params
 };
 
 static const struct fs_parameter_spec rdt_fs_parameters[] = {
-	fsparam_flag("cdp",		Opt_cdp),
-	fsparam_flag("cdpl2",		Opt_cdpl2),
-	fsparam_flag("mba_MBps",	Opt_mba_mbps),
-	fsparam_flag("debug",		Opt_debug),
+	fsparam_flag("cdp",			Opt_cdp),
+	fsparam_flag("cdpl2",			Opt_cdpl2),
+	fsparam_flag("mba_MBps",		Opt_mba_mbps),
+	fsparam_string("mba_MBps_event",	Opt_mba_mbps_event),
+	fsparam_flag("debug",			Opt_debug),
 	{}
 };
 
@@ -2715,7 +2723,25 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_mba_mbps:
 		if (!supports_mba_mbps())
 			return -EINVAL;
-		ctx->enable_mba_mbps = true;
+		if (is_mbm_local_enabled())
+			ctx->enable_mba_mbps_local = true;
+		else
+			return -EINVAL;
+		return 0;
+	case Opt_mba_mbps_event:
+		if (!supports_mba_mbps())
+			return -EINVAL;
+		if (!strcmp("mbm_local_bytes", param->string)) {
+			if (!is_mbm_local_enabled())
+				return -EINVAL;
+			ctx->enable_mba_mbps_local = true;
+		} else if (!strcmp("mbm_total_bytes", param->string)) {
+			if (!is_mbm_total_enabled())
+				return -EINVAL;
+			ctx->enable_mba_mbps_total = true;
+		} else {
+			return -EINVAL;
+		}
 		return 0;
 	case Opt_debug:
 		ctx->enable_debug = true;
@@ -3780,16 +3806,27 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 	return ret;
 }
 
+static char *mba_sc_event_opt_name(struct rdt_resource *r)
+{
+	if (r->membw.mba_mbps_event == QOS_L3_MBM_LOCAL_EVENT_ID)
+		return ",mba_MBps_event=mbm_local_bytes";
+	else if (r->membw.mba_mbps_event == QOS_L3_MBM_TOTAL_EVENT_ID)
+		return ",mba_MBps_event=mbm_total_bytes";
+	return "";
+}
+
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
+	struct rdt_resource *r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
 		seq_puts(seq, ",cdp");
 
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
-		seq_puts(seq, ",mba_MBps");
+	if (is_mba_sc(r_mba))
+		seq_puts(seq, mba_sc_event_opt_name(r_mba));
 
 	if (resctrl_debug)
 		seq_puts(seq, ",debug");
-- 
2.41.0

