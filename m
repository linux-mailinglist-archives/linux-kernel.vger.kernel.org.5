Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F440767250
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjG1Qp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjG1Qpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:45:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DE74ED0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DEDDD75;
        Fri, 28 Jul 2023 09:44:39 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79493F67D;
        Fri, 28 Jul 2023 09:43:53 -0700 (PDT)
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
Subject: [PATCH v5 13/24] x86/resctrl: Queue mon_event_read() instead of sending an IPI
Date:   Fri, 28 Jul 2023 16:42:43 +0000
Message-Id: <20230728164254.27562-14-james.morse@arm.com>
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

Intel is blessed with an abundance of monitors, one per RMID, that can be
read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
the number implemented is up to the manufacturer. This means when there are
fewer monitors than needed, they need to be allocated and freed.

MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
CSU counter is allowed to return 'not ready' for a small number of
micro-seconds after programming. To allow one CSU hardware monitor to be
used for multiple control or monitor groups, the CPU accessing the
monitor needs to be able to block when configuring and reading the
counter.

Worse, the domain may be broken up into slices, and the MMIO accesses
for each slice may need performing from different CPUs.

These two details mean MPAMs monitor code needs to be able to sleep, and
IPI another CPU in the domain to read from a resource that has been sliced.

mon_event_read() already invokes mon_event_count() via IPI, which means
this isn't possible. On systems using nohz-full, some CPUs need to be
interrupted to run kernel work as they otherwise stay in user-space
running realtime workloads. Interrupting these CPUs should be avoided,
and scheduling work on them may never complete.

Change mon_event_read() to pick a housekeeping CPU, (one that is not using
nohz_full) and schedule mon_event_count() and wait. If all the CPUs
in a domain are using nohz-full, then an IPI is used as the fallback.

This function is only used in response to a user-space filesystem request
(not the timing sensitive overflow code).

This allows MPAM to hide the slice behaviour from resctrl, and to keep
the monitor-allocation in monitor.c. When the IPI fallback is used on
machines where MPAM needs to make an access on multiple CPUs, the counter
read will always fail.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Peter Newman <peternewman@google.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Use cpumask_any_housekeeping() and fallback to an IPI if needed.

Changes since v3:
 * Actually include the IPI fallback code.

Changes since v4:
 * Tinkered with existing capitalisation.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 +++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..bd263b9a0abd 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -19,6 +19,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
 #include "internal.h"
 
 /*
@@ -520,12 +521,24 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int smp_mon_event_count(void *arg)
+{
+	mon_event_count(arg);
+
+	return 0;
+}
+
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
+	int cpu;
+
+	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	/*
-	 * setup the parameters to send to the IPI to read the data.
+	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
@@ -534,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	cpu = cpumask_any_housekeeping(&d->cpu_mask);
+
+	/*
+	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
+	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
+	 * MPAM's resctrl_arch_rmid_read() is unable to read the
+	 * counters on some platforms if its called in irq context.
+	 */
+	if (tick_nohz_full_cpu(cpu))
+		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	else
+		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 62350bbd23e0..32569354c4f1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -597,7 +597,7 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 }
 
 /*
- * This is called via IPI to read the CQM/MBM counters
+ * This is scheduled by mon_event_read() to read the CQM/MBM counters
  * on a domain.
  */
 void mon_event_count(void *info)
-- 
2.39.2

