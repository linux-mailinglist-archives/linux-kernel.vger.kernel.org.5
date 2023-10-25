Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934A7D72E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjJYSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:05:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C1EAD64
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:05:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05411C15;
        Wed, 25 Oct 2023 11:06:18 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDF03F738;
        Wed, 25 Oct 2023 11:05:32 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v7 15/24] x86/resctrl: Allow arch to allocate memory needed in resctrl_arch_rmid_read()
Date:   Wed, 25 Oct 2023 18:03:36 +0000
Message-Id: <20231025180345.28061-16-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
References: <20231025180345.28061-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the number of monitors available, Arm's MPAM may need to
allocate a monitor prior to reading the counter value. Allocating a
contended resource may involve sleeping.

add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
the allocation should be valid for all domains.

__check_limbo() and mon_event_count() each make multiple calls to
resctrl_arch_rmid_read(), to avoid extra work on contended systems,
the allocation should be valid for multiple invocations of
resctrl_arch_rmid_read().

Add arch hooks for this allocation, which need calling before
resctrl_arch_rmid_read(). The allocated monitor is passed to
resctrl_arch_rmid_read(), then freed again afterwards. The helper
can be called on any CPU, and can sleep.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Expanded comment.
 * Removed stray header include.
 * Reworded commit message.
 * Made ctx a void * instead of an int.

Changes since v4:
 * Used IS_ERR() in more places.

Changes since v5:
 * Pass the error back from mon_event_read() as -EINVAL/Unavailable.
 * Add some ratelimited warnings when failing to allocate a mon context

Changes since v6:
 * Added a newline.
---
 arch/x86/include/asm/resctrl.h            | 11 +++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 +++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c     | 35 +++++++++++++++++++++--
 include/linux/resctrl.h                   |  5 +++-
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 1d274dbabc44..29c4cc343787 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
 	return rmid;
 }
 
+/* x86 can always read an rmid, nothing needs allocating */
+struct rdt_resource;
+static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
+{
+	might_sleep();
+	return NULL;
+};
+
+static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
+					     void *ctx) { };
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index d07f99245851..a033e8e32108 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -546,6 +546,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->d = d;
 	rr->val = 0;
 	rr->first = first;
+	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
+	if (IS_ERR(rr->arch_mon_ctx)) {
+		rr->err = -EINVAL;
+		return;
+	}
 
 	cpu = cpumask_any_housekeeping(&d->cpu_mask);
 
@@ -559,6 +564,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
+
+	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 33e24fcc8dd0..bb07b9b01e36 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -138,6 +138,7 @@ struct rmid_read {
 	bool			first;
 	int			err;
 	u64			val;
+	void			*arch_mon_ctx;
 };
 
 extern bool rdt_alloc_capable;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 409817b0ae2c..1ca8db8c82cc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -269,7 +269,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val)
+			   u64 *val, void *ignored)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
@@ -324,9 +324,17 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
+	void *arch_mon_ctx;
 	bool rmid_dirty;
 	u64 val = 0;
 
+	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
+	if (IS_ERR(arch_mon_ctx)) {
+		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+				    PTR_ERR(arch_mon_ctx));
+		return;
+	}
+
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
 	 * are marked as busy for occupancy < threshold. If the occupancy
@@ -340,7 +348,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 
 		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val)) {
+					   QOS_L3_OCCUP_EVENT_ID, &val,
+					   arch_mon_ctx)) {
 			rmid_dirty = true;
 		} else {
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
@@ -353,6 +362,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		}
 		cur_idx = idx + 1;
 	}
+
+	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
 }
 
 bool has_busy_rmid(struct rdt_domain *d)
@@ -533,7 +544,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	}
 
 	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
-					 &tval);
+					 &tval, rr->arch_mon_ctx);
 	if (rr->err)
 		return rr->err;
 
@@ -744,11 +755,27 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 	if (is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (IS_ERR(rr.arch_mon_ctx)) {
+			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+					    PTR_ERR(rr.arch_mon_ctx));
+			return;
+		}
+
 		__mon_event_count(closid, rmid, &rr);
+
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
 		rr.val = 0;
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (IS_ERR(rr.arch_mon_ctx)) {
+			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+					    PTR_ERR(rr.arch_mon_ctx));
+			return;
+		}
+
 		__mon_event_count(closid, rmid, &rr);
 
 		/*
@@ -758,6 +785,8 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 		 */
 		if (is_mba_sc(NULL))
 			mbm_bw_count(closid, rmid, &rr);
+
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8649fc84aac2..bf460c912bf5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -235,6 +235,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
  * @val:		result of the counter read in bytes.
+ * @arch_mon_ctx:	An architecture specific value from
+ *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
+ *			the hardware monitor allocated for this read request.
  *
  * Some architectures need to sleep when first programming some of the counters.
  * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
@@ -248,7 +251,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  */
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val);
+			   u64 *val, void *arch_mon_ctx);
 
 /**
  * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
-- 
2.39.2

