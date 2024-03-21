Return-Path: <linux-kernel+bounces-110421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECF885EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8E1F22FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78F139567;
	Thu, 21 Mar 2024 16:51:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D671386A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039908; cv=none; b=q85yDLs/VaTj6t7/N5rTwpSzuITJhsf7jgLcfarpbPvj6agAnVMPfCu6qu0Uf5grKivuWdf/rly5Re+HkN8SF4PVcfGZXvINyPyMlhaI1MTgUZdoe/fDMvUP0bmIT5vwO9tUfa7OS//5r2sheA8gsnB1oU7NbDMWjNb8mzxPOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039908; c=relaxed/simple;
	bh=nF9OxzpVaMmpfdu101NLML1Z0+BoaHIcGUr2AukfMJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkY9xtA1MxLjiMBdn7NiSSayYIaXWgQGqgrXLSMoRJNtvgeoiXtdV3hgNKReez2kvUjofsPxwTgxduET1obcY9XSKNxRnvPhiGwc8+xOczHbzulKo3Eywcf9dPv46Uw7qfCgJfbdEu/fS92lbZ5vALctmOfTb/q70Ckxn9Nq9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F41168F;
	Thu, 21 Mar 2024 09:52:19 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4F783F67D;
	Thu, 21 Mar 2024 09:51:42 -0700 (PDT)
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
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
Date: Thu, 21 Mar 2024 16:50:40 +0000
Message-Id: <20240321165106.31602-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
it uses to update the local CPUs default pqr values. This is a problem
once the resctrl parts move out to /fs/, as the arch code cannot
poke around inside struct rdtgroup.

Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
to be used as the target of an IPI, and pass the effective CLOSID
and RMID in a new struct.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
 include/linux/resctrl.h                | 11 +++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5d2c1ce5b6b1..18f097fce51e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
  */
-static void update_cpu_closid_rmid(void *info)
+void resctrl_arch_sync_cpu_defaults(void *info)
 {
-	struct rdtgroup *r = info;
+	struct resctrl_cpu_sync *r = info;
 
 	if (r) {
 		this_cpu_write(pqr_state.default_closid, r->closid);
-		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
+		this_cpu_write(pqr_state.default_rmid, r->rmid);
 	}
 
 	/*
@@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
  * Per task closids/rmids must have been set up before calling this function.
+ * @r may be NULL.
  */
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
+	struct resctrl_cpu_sync defaults;
+	struct resctrl_cpu_sync *defaults_p = NULL;
+
+	if (r) {
+		defaults.closid = r->closid;
+		defaults.rmid = r->mon.rmid;
+		defaults_p = &defaults;
+	}
+
+	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
+			 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6e87bc95f5ea..2b79e4159507 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -220,6 +220,17 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+struct resctrl_cpu_sync {
+	u32 closid;
+	u32 rmid;
+};
+
+/*
+ * Update and re-load this CPUs defaults. Called via IPI, takes a pointer to
+ * struct resctrl_cpu_sync, or NULL.
+ */
+void resctrl_arch_sync_cpu_defaults(void *info);
+
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
-- 
2.39.2


