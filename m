Return-Path: <linux-kernel+bounces-160227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5E8B3ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F931F21971
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F21581F4;
	Fri, 26 Apr 2024 15:09:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F8157463
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144187; cv=none; b=AoJv668aVyJ90bOxevCAxN+pZSFQOENmdj7yWIM9CNsncIAfokW8WH5roI6hYHn/ub1jnjLR/rq4hTqS6ylBP4cOkOZRw1WR6y0gTvyO3dVrAdh3ttWvdl50jTrF8mKqHOZkBYbZLudHIAWN6rHBtSKZsNumaVivC+vRqltB0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144187; c=relaxed/simple;
	bh=yaBt+Qi9jB3ofGOAf7OZ1nlIHEsXuQZyyPPMtpJLcQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocrm6ojB/aoNmEO9bwznZHL9D1EJJMYKswuvR70Ubf4x27/h+6e0QxGvGR9eE6g6CqTAkjmwGrRVfvUnAk+LKlFRcCZG7q6HVHZjqMimdukds4IhNpN0t9QGg0LKhtpH59B1rgjL3DXleCAXFomA0j8tcWyOgFiFOMFFiWyT+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E34211596;
	Fri, 26 Apr 2024 08:10:13 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B09E3F73F;
	Fri, 26 Apr 2024 08:09:42 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 11/35] x86/resctrl: Move monitor exit work to a resctrl exit call
Date: Fri, 26 Apr 2024 16:08:40 +0100
Message-Id: <20240426150904.8854-11-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

rdt_put_mon_l3_config() is called via the architecture's
resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
and closid_num_dirty_rmid[] arrays. In reality this code is marked
__exit, and is removed by the linker as resctrl can't be built
as a module.

Since there is no immediate need to change them, leave the __exit
annotations as-is.  This will need to be revisited as and when there is
a need to call these functions other than at __exit time.

To separate the filesystem and architecture parts of resctrl,
this free()ing work needs to be triggered by the filesystem,
as these structures belong to the filesystem code.

Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
and call it from resctrl_exit(). The kfree() is currently
dependent on r->mon_capable. resctrl_mon_resource_init()
takes no arguments, so resctrl_mon_resource_exit() shouldn't
take any either. Add the check to dom_data_exit(), making it
take the resource as an argument. This makes it more symmetrical
with dom_data_init().

Signed-off-by: James Morse <james.morse@arm.com>

---

Changes in v2:

 * [Commit message only] Typo fixes:
   s/restrl/resctrl/g
   s/resctl/resctrl/g

 * [Commit message only] Reword second paragraph to remove reference to
   the MPAM error interrupt, which provides background rationale for a
   later patch rather than for this patch, and so it is not really
   relevant here.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  5 -----
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 ++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 06dc12b08afc..9a09a64bbb7f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -988,14 +988,9 @@ late_initcall(resctrl_arch_late_init);
 
 static void __exit resctrl_arch_exit(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	cpuhp_remove_state(rdt_online);
 
 	resctrl_exit();
-
-	if (r->mon_capable)
-		rdt_put_mon_l3_config();
 }
 
 __exitcall(resctrl_arch_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7a0c74779c53..01fcd4ef26ca 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -533,7 +533,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit rdt_put_mon_l3_config(void);
+void __exit resctrl_mon_resource_exit(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 165bd16538e6..c55d84d86013 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -954,10 +954,12 @@ static int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(void)
+static void __exit dom_data_exit(struct rdt_resource *r)
 {
-	mutex_lock(&rdtgroup_mutex);
+	if (!r->mon_capable)
+		return;
 
+	mutex_lock(&rdtgroup_mutex);
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 		kfree(closid_num_dirty_rmid);
 		closid_num_dirty_rmid = NULL;
@@ -1074,9 +1076,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit rdt_put_mon_l3_config(void)
+void __exit resctrl_mon_resource_exit(void)
 {
-	dom_data_exit();
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	dom_data_exit(r);
 }
 
 void __init intel_rdt_mbm_apply_quirk(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8c793d2d7a68..58b59b102986 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4188,4 +4188,6 @@ void __exit resctrl_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+
+	resctrl_mon_resource_exit();
 }
-- 
2.34.1


