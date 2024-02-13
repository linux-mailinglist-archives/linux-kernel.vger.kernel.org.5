Return-Path: <linux-kernel+bounces-64104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D68853A26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91F51C20EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05DB612E6;
	Tue, 13 Feb 2024 18:45:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C6612D6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849947; cv=none; b=aSZzROPtIigeAp6weMkI1GIsEJ2NqvdbxRZkO+fuJKtuTVxIVzXRrpssRSferYekCF2gRtncXb1zmRLzfALxW43wisBTi3Wpc0o791ez7EqhOCawpfGFUiuoFCeIJuRE0O4aZkHMN+lkzQFxbMqsndDvDU5vYmZhSGoZ/IuV4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849947; c=relaxed/simple;
	bh=KFwlStvMlPXKUvkhpDhAxvJVdMWOp52J5AhonkDwfAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS0NFqwBEcxuktQ7obfYm5LopptCSaOZ/YCMrA1B9t4bVUyDp9sHqWgB5/5jJlErAM4dBSokuDtwTnggCDxIVtWuZwszcd2JUdIx+ChTmDOV5eoIV05l0j8ei24qy0NZgn6oM7qh0C3rwrAEV54nMMi3yKSi2No8lgPX1nFGTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3191570;
	Tue, 13 Feb 2024 10:46:26 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677783F766;
	Tue, 13 Feb 2024 10:45:42 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v9 13/24] x86/resctrl: Queue mon_event_read() instead of sending an IPI
Date: Tue, 13 Feb 2024 18:44:27 +0000
Message-Id: <20240213184438.16675-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v2:
 * Use cpumask_any_housekeeping() and fallback to an IPI if needed.

Changes since v3:
 * Actually include the IPI fallback code.

Changes since v4:
 * Tinkered with existing capitalisation.

Changes since v5:
 * Added a newline.

Changes since v6:
 * Moved lockdep annotations to a later patch.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 26 +++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index beccb0e87ba7..d07f99245851 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -19,6 +19,8 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
+
 #include "internal.h"
 
 /*
@@ -522,12 +524,21 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
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
 	/*
-	 * setup the parameters to send to the IPI to read the data.
+	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
@@ -536,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
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
index 38f85e53ca93..fd060ef86f38 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -585,7 +585,7 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 }
 
 /*
- * This is called via IPI to read the CQM/MBM counters
+ * This is scheduled by mon_event_read() to read the CQM/MBM counters
  * on a domain.
  */
 void mon_event_count(void *info)
-- 
2.39.2


