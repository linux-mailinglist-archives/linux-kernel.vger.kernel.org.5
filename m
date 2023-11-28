Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD87FCA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbjK1XOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1XOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:14:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5918E;
        Tue, 28 Nov 2023 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701213286; x=1732749286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wC9bPYbbCelZT4Vxsu7enasvU8lzd+Wr5nV9hwS3+PE=;
  b=lIwV+ziQE89gY+qJT/I3Pi99ZE9AHwTUHzsr4Ir2NueU6U1Rtu5ofBIo
   4gBlxvh5icDtXfNMKM4gvfrxfHH9h5OOtFWD4DyBxk1dnyfO2kTkO1T83
   7kg0PWBCN6XkajbCUVv8WNBqSvPX1aRL9uDgExIaZ9qo62OSrjBC0DIbb
   tXrZFryNtO5v6xkJU5vbihm5Mt53ANzwPiQ4+ajj7ZFcVz/gYfPfd1/4f
   bVnguLQG0vwW51WdBv23r92Vv3t1mP/noMeFmHNGtG9QxLIfMVpsMXyWH
   cj0f9CCitReIkS69TiHA0IKm+TFnOamM2tzMxfu+T/A29lIIJa18V+oPK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479246467"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479246467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="886615851"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="886615851"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:14:45 -0800
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
Subject: [PATCH v4] x86/resctrl: Add mount option to pick total MBM event
Date:   Tue, 28 Nov 2023 15:14:39 -0800
Message-ID: <20231128231439.81691-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026200214.16017-1-tony.luck@intel.com>
References: <20231026200214.16017-1-tony.luck@intel.com>
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

Add a "total" mount option to be used in conjunction with "mba_MBps"
to request use of the total memory bandwidth event as the feedback
input to the control loop.

Also fall back to using the total event if the local event is not
supported by the CPU.

Update the once-per-second polling code to use the event (local
or total memory bandwidth).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Changes since v3:

Reinette suggested that users might like the option to use the total
memory bandwidth event. I tried out some code to make the event runtime
selectable via a r/w file in the resctrl/info directories. But that
got complicated because of the amount of state that needs to be updated
when switching events. Since there isn't a firm use case for user
selectable event, this latest version falls back to the far simpler
case of using a mount option.

 Documentation/arch/x86/resctrl.rst     |  3 +++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 20 +++++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++++++++++++++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..29c3e7137eb8 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -46,6 +46,9 @@ mount options are:
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
 	bandwidth in MBps
+"total":
+	Use total instead of local memory bandwidth to drive the
+	MBA Software Controller
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..f98fc9adc2da 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				use_mbm_total;
 	bool				enable_debug;
 };
 
@@ -428,6 +429,8 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+extern enum resctrl_event_id mba_mbps_evt_id;
+
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..230297603836 100644
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
@@ -518,6 +519,7 @@ void mon_event_count(void *info)
  */
 static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
+	enum resctrl_event_id evt_id = mba_mbps_evt_id;
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	u32 cur_bw, delta_bw, user_bw;
@@ -526,14 +528,14 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
-	if (!is_mbm_local_enabled())
+	if (!is_mbm_enabled())
 		return;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	pmbm_data = get_mbm_state(dom_mbm, rmid, evt_id);
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -553,7 +555,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, evt_id);
 		cur_bw += cmbm_data->prev_bw;
 		delta_bw += cmbm_data->delta_bw;
 	}
@@ -616,18 +618,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
 		__mon_event_count(rmid, &rr);
+		if (is_mba_sc(NULL) && rr.evtid == mba_mbps_evt_id)
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
+		if (is_mba_sc(NULL) && rr.evtid == mba_mbps_evt_id)
 			mbm_bw_count(rmid, &rr);
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..39a5b73af4ef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -57,6 +57,8 @@ static char last_cmd_status_buf[512];
 static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
 static void rdtgroup_destroy_root(void);
 
+enum resctrl_event_id mba_mbps_evt_id;
+
 struct dentry *debugfs_resctrl;
 
 static bool resctrl_debug;
@@ -2294,7 +2296,7 @@ static bool supports_mba_mbps(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	return (is_mbm_local_enabled() &&
+	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear());
 }
 
@@ -2470,6 +2472,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 		ret = set_mba_sc(true);
 		if (ret)
 			goto out_cdpl3;
+		if (ctx->use_mbm_total || !is_mbm_local_enabled())
+			mba_mbps_evt_id = QOS_L3_MBM_TOTAL_EVENT_ID;
+		else
+			mba_mbps_evt_id = QOS_L3_MBM_LOCAL_EVENT_ID;
 	}
 
 	if (ctx->enable_debug)
@@ -2683,6 +2689,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_mba_mbps_total,
 	Opt_debug,
 	nr__rdt_params
 };
@@ -2691,6 +2698,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("total",		Opt_mba_mbps_total),
 	fsparam_flag("debug",		Opt_debug),
 	{}
 };
@@ -2717,6 +2725,11 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_mba_mbps_total:
+		if (!is_mbm_total_enabled())
+			return -EINVAL;
+		ctx->use_mbm_total = true;
+		return 0;
 	case Opt_debug:
 		ctx->enable_debug = true;
 		return 0;
-- 
2.41.0

