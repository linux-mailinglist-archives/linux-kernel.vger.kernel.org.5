Return-Path: <linux-kernel+bounces-64093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD3853A17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1B028D3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31104605BE;
	Tue, 13 Feb 2024 18:45:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095355812E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849910; cv=none; b=rs9R3C9D1RHwGouYsOY88kK9KtE1EvM2ug6CXE8MG/Aje2jXssesgNiwtBryyfT4FTAqh64/IyiDdUfcSQKPfaNrhPXwXQn95ukqhz5NXjdyAQODajg5Y3wMLXwct4Ce0boZ6TQeODL6olLI6pguqpYtZ7SWpkyqIrKvk/C8UUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849910; c=relaxed/simple;
	bh=cnu/fw90MUyfw/nm4T5u6mCM9ebJAuqXfvQQKR65YCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/Jv+atH02zO82X6ucNsWuV+ERpv37M8Pb3CxqRPTPRyNBfIX5e0uiy+Uik1T4orz5sLossukihLe36rd3mTVId14k5ul+35M9qYCr4ZylrjNhD1vCa2n7FDknkZjN9rwmtTFCdywp0BFTG/uYRGstW2WY6TWd8kHnQmEvRBYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8358FEC;
	Tue, 13 Feb 2024 10:45:49 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 532FC3F766;
	Tue, 13 Feb 2024 10:45:05 -0800 (PST)
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
Subject: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
Date: Tue, 13 Feb 2024 18:44:16 +0000
Message-Id: <20240213184438.16675-3-james.morse@arm.com>
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

rmid_ptrs[] is allocated from dom_data_init() but never free()d.

While the exit text ends up in the linker script's DISCARD section,
the direction of travel is for resctrl to be/have loadable modules.

Add resctrl_put_mon_l3_config() to cleanup any memory allocated
by rdt_get_mon_l3_config().

There is no reason to backport this to a stable kernel.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
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

Changes since v8:
 * Removed an unused parameter from some unused code.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index aa9810a64258..9641c42d0f85 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -990,8 +990,14 @@ late_initcall(resctrl_late_init);
 
 static void __exit resctrl_exit(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	cpuhp_remove_state(rdt_online);
+
 	rdtgroup_exit();
+
+	if (r->mon_capable)
+		rdt_put_mon_l3_config();
 }
 
 __exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 52e7e7deee10..61c763604fc9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -544,6 +544,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3a6c069614eb..3a73db0579d8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -719,6 +719,16 @@ static int dom_data_init(struct rdt_resource *r)
 	return 0;
 }
 
+static void __exit dom_data_exit(void)
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
@@ -814,6 +824,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void __exit rdt_put_mon_l3_config(void)
+{
+	dom_data_exit();
+}
+
 void __init intel_rdt_mbm_apply_quirk(void)
 {
 	int cf_index;
-- 
2.39.2


