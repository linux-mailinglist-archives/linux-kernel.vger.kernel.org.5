Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF18015B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjLAVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:47:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD90D6C;
        Fri,  1 Dec 2023 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701467266; x=1733003266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qGZLOVX0lRzoXgrjU5Lf+xhYula8oqkMn+WAagOJ54=;
  b=YFMtEvsP46AnR8GSjubPz5LW3/lFM83NOfGgkeQLwb/NCLce2NAB5xcQ
   kHc870aRGaJpX4n3Wuaie0MTlr8YtIe1QZLY8IRAC4N7Vikq2jlCYj7gt
   tYDnHz4FVhwU3kcyLFwhj5ae6MZVkTRXSvik0LEaVFPHlxv0LpiI2TQOl
   rQozaPLQTHKkezVXtgIqsBt382PdUmCWkpKUvy+/DLi9u2sZ0woBzoRe5
   K0rAn556tUi55/lh6pvv/7zFqLqHgysr1p7yc+8f/Q4uu2+T/UjXo/n8L
   YOepodj9jhlCbhVn8yr5UuIeI7xTlFgaqToX/+X0DlMxSxZi2lUpsP5PJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="6843256"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="6843256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 13:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="17904739"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 13:47:45 -0800
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
Subject: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Date:   Fri,  1 Dec 2023 13:47:37 -0800
Message-ID: <20231201214737.104444-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128231439.81691-1-tony.luck@intel.com>
References: <20231128231439.81691-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MBA Software Controller(mba_sc) is a feedback loop that uses
measurements of local memory bandwidth to adjust MBA throttling levels to
keep workloads in a resctrl group within a target bandwidth set in the
schemata file.

But on Intel systems the memory bandwidth monitoring events are
independently enumerated. It is possible for a system to support
total memory bandwidth monitoring, but not support local bandwidth
monitoring. On such a system a user could not enable mba_sc mode.
Users will see this highly unhelpful error message from mount:

 # mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl
 mount: /sys/fs/resctrl: wrong fs type, bad option, bad superblock on
 resctrl, missing codepage or helper program, or other error.
 dmesg(1) may have more information after failed mount system call.

dmesg(1) does not provide any additional information.

Add a new mount option "mba_MBps_event=[local|total]" that allows
a user to specify which monitoring event to use. Also modify the
existing "mba_MBps" option to switch to total bandwidth monitoring
if local monitoring is not available.

Update the once-per-second polling code to use the chosen event (local
or total memory bandwidth).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst     |  7 +++-
 include/linux/resctrl.h                |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 21 ++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++++++++------
 5 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..f06cb189911a 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -45,7 +45,12 @@ mount options are:
 	Enable code/data prioritization in L2 cache allocations.
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MBps
+	bandwidth in MBps. Defaults to using MBM local bandwidth,
+	but will use total bandwidth on systems that do not support
+	local bandwidth monitoring.
+"mba_MBps_event=[local|total]":
+	Enable the MBA Software Controller(mba_sc) with a specific
+	MBM event as input to the feedback loop.
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
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
index 69a1de92384a..79141d33d5b4 100644
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
 
@@ -2715,7 +2723,27 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_mba_mbps:
 		if (!supports_mba_mbps())
 			return -EINVAL;
-		ctx->enable_mba_mbps = true;
+		if (is_mbm_local_enabled())
+			ctx->enable_mba_mbps_local = true;
+		else if (is_mbm_total_enabled())
+			ctx->enable_mba_mbps_total = true;
+		else
+			return -EINVAL;
+		return 0;
+	case Opt_mba_mbps_event:
+		if (!supports_mba_mbps())
+			return -EINVAL;
+		if (!strcmp("local", param->string)) {
+			if (!is_mbm_local_enabled())
+				return -EINVAL;
+			ctx->enable_mba_mbps_local = true;
+		} else if (!strcmp("total", param->string)) {
+			if (!is_mbm_total_enabled())
+				return -EINVAL;
+			ctx->enable_mba_mbps_total = true;
+		} else {
+			return -EINVAL;
+		}
 		return 0;
 	case Opt_debug:
 		ctx->enable_debug = true;
-- 
2.41.0

