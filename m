Return-Path: <linux-kernel+bounces-1441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008D814F16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6560B22CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7243013F;
	Fri, 15 Dec 2023 17:44:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81930130
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E040115DB;
	Fri, 15 Dec 2023 09:44:53 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32A63F5A1;
	Fri, 15 Dec 2023 09:44:05 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8 02/24] x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
Date: Fri, 15 Dec 2023 17:43:21 +0000
Message-Id: <20231215174343.13872-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmid_ptrs[] is allocated from dom_data_init() but never free()d.

While the exit text ends up in the linker script's DISCARD section,
the direction of travel is for resctrl to be/have loadable modules.

Add resctrl_put_mon_l3_config() to cleanup any memory allocated
by rdt_get_mon_l3_config().

There is no reason to backport this to a stable kernel.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v5:
 * This patch is new

Changes since v6:
 * Removed struct rdt_resource argument, added __exit markers to match the
   only caller.
 * Adedd a whole stack of functions to maintain symmetry.

Changes since v7:
 * Moved the eventual kfree() call to be after rdtgroup_exit()
---
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..b5d4b76f97c5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -992,8 +992,14 @@ late_initcall(resctrl_late_init);
 
 static void __exit resctrl_exit(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	cpuhp_remove_state(rdt_online);
+
 	rdtgroup_exit();
+
+	if (r->mon_capable)
+		rdt_put_mon_l3_config(r);
 }
 
 __exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..f68c6aecfa66 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -546,6 +546,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..5d9864919f1c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
 	return 0;
 }
 
+static void __exit dom_data_exit(struct rdt_resource *r)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	kfree(rmid_ptrs);
+	rmid_ptrs = NULL;
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
 static struct mon_evt llc_occupancy_event = {
 	.name		= "llc_occupancy",
 	.evtid		= QOS_L3_OCCUP_EVENT_ID,
@@ -830,6 +840,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
+{
+	dom_data_exit(r);
+}
+
 void __init intel_rdt_mbm_apply_quirk(void)
 {
 	int cf_index;
-- 
2.20.1


