Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4675B7D78F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJYXwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjJYXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:51:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D328110E4;
        Wed, 25 Oct 2023 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698277855; x=1729813855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJNPjfBkpOrsDLWbkVxuMpn1IMLnek67+59Y0vzWlQs=;
  b=VMZxkU0QBegIv+dSofxLmUZlVtRw3Rq67aUOBXGDW6myIK480/4B0AmV
   bmAPdUGxR0/mEZDMlG6YYsRvJgVh2TjVqr7NH+o30OLppf2iVFtOVBslM
   Nr0Au+76mbV1NLNgHzufaGIWmetiAWLz7yn74t68r/i/g51y4K03nHHSh
   MS+Bi0+Ej3FnyI2pd7gyq4MdpNPQ8Ada/zbWAiJi+dPM0vGPF237ZMB2/
   pkJFwXnMS1Qmestrr4qKc1W4MuWn81MF1vOGFgrzy4ayFecHkLzitUCau
   gOjbu0/jiK9UE8+S5ohpwdPjk+ynXgmaWal0hOSgTstuiMARUhUKTSoua
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386301694"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="386301694"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 16:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090395752"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="1090395752"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 16:50:54 -0700
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
Subject: [PATCH v2] x86/resctrl: mba_MBps: Fall back to total b/w if local b/w unavailable
Date:   Wed, 25 Oct 2023 16:50:46 -0700
Message-ID: <20231025235046.12940-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024181600.8270-1-tony.luck@intel.com>
References: <20231024181600.8270-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel the various resource director technology (RDT) features are all
orthogonal and independently enumerated. Thus it is possible to have
a system that  provides "total" memory bandwidth measurements without
providing "local" bandwidth measurements.

If local bandwidth measurement is not available, do not give up on
providing the "mba_MBps" feedback option completely, make the code fall
back to using total bandwidth.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Changes since v1:

+ Both Peter and Babu didn't like my get_mbm_data() function. Peter
  thought it just needed a more descriptive name. But Babu explained
  how to get rid of it completley. I went with a modified version of
  Babu's suggestion (saving the event to use for mba_MBps during
  initialization, instead of checking every time).

 arch/x86/kernel/cpu/resctrl/monitor.c  | 41 ++++++++++++++++----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..6c3536af024e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -73,6 +73,13 @@ unsigned int resctrl_rmid_realloc_threshold;
  */
 unsigned int resctrl_rmid_realloc_limit;
 
+/*
+ * MBM monitor event to use for the mba_MBps mount option.
+ * Preference is QOS_L3_MBM_LOCAL_EVENT_ID, but fall
+ * back to QOS_L3_MBM_TOTAL_EVENT_ID.
+ */
+static enum resctrl_event_id mba_mbps_evt_id;
+
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 /*
@@ -431,7 +438,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct mbm_state *m = &rr->d->mbm_local[rmid];
+	struct mbm_state *m = get_mbm_state(rr->d, rmid, mba_mbps_evt_id);
 	u64 cur_bw, bytes, cur_bytes;
 
 	cur_bytes = rr->val;
@@ -526,14 +533,14 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
-	if (!is_mbm_local_enabled())
+	if (!is_mbm_enabled())
 		return;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	pmbm_data = get_mbm_state(dom_mbm, rmid, mba_mbps_evt_id);
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -553,7 +560,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, mba_mbps_evt_id);
 		cur_bw += cmbm_data->prev_bw;
 		delta_bw += cmbm_data->delta_bw;
 	}
@@ -595,7 +602,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	 */
 	pmbm_data->delta_comp = true;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, mba_mbps_evt_id);
 		cmbm_data->delta_comp = true;
 	}
 }
@@ -621,15 +628,15 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
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
-			mbm_bw_count(rmid, &rr);
 	}
+
+	/*
+	 * Call the MBA software controller only for the
+	 * control groups and when user has enabled
+	 * the software controller explicitly.
+	 */
+	if (is_mba_sc(NULL))
+		mbm_bw_count(rmid, &rr);
 }
 
 /*
@@ -769,10 +776,14 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 	if (is_llc_occupancy_enabled())
 		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (is_mbm_total_enabled())
+	if (is_mbm_total_enabled()) {
 		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (is_mbm_local_enabled())
+		mba_mbps_evt_id = QOS_L3_MBM_TOTAL_EVENT_ID;
+	}
+	if (is_mbm_local_enabled()) {
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
+		mba_mbps_evt_id = QOS_L3_MBM_LOCAL_EVENT_ID;
+	}
 }
 
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..0c4f8a1b8df0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	return (is_mbm_local_enabled() &&
+	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear());
 }
 
-- 
2.41.0

