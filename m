Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C79767251
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjG1QqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjG1Qpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:45:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5524B4EEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:44:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3F2015DB;
        Fri, 28 Jul 2023 09:44:36 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9DD3F67D;
        Fri, 28 Jul 2023 09:43:50 -0700 (PDT)
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry when it is interrupted
Date:   Fri, 28 Jul 2023 16:42:42 +0000
Message-Id: <20230728164254.27562-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
References: <20230728164254.27562-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl_arch_rmid_read() could be called by resctrl in process context,
and then called by the PMU driver from irq context on the same CPU.
This could cause struct arch_mbm_state's prev_msr value to go backwards,
leading to the chunks value being incremented multiple times.

The struct arch_mbm_state holds both the previous msr value, and a count
of the number of chunks. These two fields need to be updated atomically.
Similarly __rmid_read() must write to one MSR and read from another,
this must be proteted from re-entrance.

Read the prev_msr before accessing the hardware, and cmpxchg() the value
back. If the value has changed, the whole thing is re-attempted. To protect
the MSR, __rmid_read() will retry reads for QM_CTR if QM_EVTSEL has changed
from the selected value.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v4:
 * Added retry loop in __rmid_read() to protect the CPU MSRs.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a32d307292a1..7012f42a82ee 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_INTERNAL_H
 #define _ASM_X86_RESCTRL_INTERNAL_H
 
+#include <linux/atomic.h>
 #include <linux/resctrl.h>
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -338,8 +339,8 @@ struct mbm_state {
  *		find this struct.
  */
 struct arch_mbm_state {
-	u64	chunks;
-	u64	prev_msr;
+	atomic64_t	chunks;
+	atomic64_t	prev_msr;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f0670795b446..62350bbd23e0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/percpu.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
@@ -24,6 +25,9 @@
 
 #include "internal.h"
 
+/* Sequence number for writes to IA32 QM_EVTSEL */
+static DEFINE_PER_CPU(u64, qm_evtsel_seq);
+
 struct rmid_entry {
 	/*
 	 * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
@@ -178,7 +182,7 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
 
 static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
-	u64 msr_val;
+	u64 msr_val, seq;
 
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -187,9 +191,16 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
+	 * A per-cpu sequence counter is incremented each time QM_EVTSEL is
+	 * written. This is used to detect if this function was interrupted by
+	 * another call without re-reading the MSRs. Retry the MSR read when
+	 * this happens as the QM_CTR value may belong to a different event.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+	do {
+		seq = this_cpu_inc_return(qm_evtsel_seq);
+		wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+		rdmsrl(MSR_IA32_QM_CTR, msr_val);
+	} while (seq != this_cpu_read(qm_evtsel_seq));
 
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
@@ -225,13 +236,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
+	u64 msr_val;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		memset(am, 0, sizeof(*am));
 
 		/* Record any initial, non-zero count value. */
-		__rmid_read(rmid, eventid, &am->prev_msr);
+		__rmid_read(rmid, eventid, &msr_val);
+		atomic64_set(&am->prev_msr, msr_val);
 	}
 }
 
@@ -266,23 +279,35 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u64 start_msr_val, old_msr_val, msr_val, chunks;
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	int ret;
+	int ret = 0;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
+interrupted:
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am)
+		start_msr_val = atomic64_read(&am->prev_msr);
+
 	ret = __rmid_read(rmid, eventid, &msr_val);
 	if (ret)
 		return ret;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
-		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
-						 hw_res->mbm_width);
-		chunks = get_corrected_mbm_count(rmid, am->chunks);
-		am->prev_msr = msr_val;
+		old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
+					       msr_val);
+		if (old_msr_val != start_msr_val)
+			goto interrupted;
+
+		chunks = mbm_overflow_count(start_msr_val, msr_val,
+					    hw_res->mbm_width);
+		atomic64_add(chunks, &am->chunks);
+
+		chunks = get_corrected_mbm_count(rmid,
+						 atomic64_read(&am->chunks));
 	} else {
 		chunks = msr_val;
 	}
-- 
2.39.2

