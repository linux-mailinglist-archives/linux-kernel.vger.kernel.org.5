Return-Path: <linux-kernel+bounces-160226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D48B3ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E9B1C23A15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB615623B;
	Fri, 26 Apr 2024 15:09:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CD156C65
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144184; cv=none; b=fYjGTWK/TH454iOTe4XAQgu2WWdGnVcrxFVW9YZ6xrruokq4cw+EAnb+2ruLzBkyoiemM0m1ss/17hJmcc4euhAfW6l7/7QFNe3jCoeZ6nzM2PJ4O7xhQtzpbggSr9YjeNPoC4F89EmO9ZHu/zh56KA95Ub6ckNWSEL6FD0kBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144184; c=relaxed/simple;
	bh=cBPv2afoxU4qJ0Dot0LN5+22spBOLwVt7VFP6I0TsQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnQAHsb+hZ2p/RRwYfDKcQh7wOrt7RZqAZ+Qekozo+pEGp0hMuD1cZ/CeyYN/dNSXzkGcSMV+9zJqglxt1n8IYAbmCu/n1jH0y05J+COgUWRxDpnUQi2HlgCCLs/UZNoF/IFlwu/uun1xx20UGSELe20YCnzYw6U7BGYtchdwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC4B15A1;
	Fri, 26 Apr 2024 08:10:10 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9AE73F73F;
	Fri, 26 Apr 2024 08:09:39 -0700 (PDT)
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
Subject: [PATCH v2 10/35] x86/resctrl: Move monitor init work to a resctrl init call
Date: Fri, 26 Apr 2024 16:08:39 +0100
Message-Id: <20240426150904.8854-10-Dave.Martin@arm.com>
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

rdt_get_mon_l3_config() is called from the architecture's
resctrl_arch_late_init(), and initialises both architecture specific
fields, such as hw_res->mon_scale and resctrl filesystem fields
by calling dom_data_init().

To separate the filesystem and architecture parts of resctrl, this
function needs splitting up.

Add resctrl_mon_resource_init() to do the filesystem specific work,
and call it from resctrl_init(). This runs later, but is still before
the filesystem is mounted and the rmid_ptrs[] array can be used.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 031948322eab..7a0c74779c53 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -540,6 +540,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
+int resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9f2fafcf78f1..165bd16538e6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1003,12 +1003,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
+int resctrl_mon_resource_init(void)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	int ret;
+
+	if (!r->mon_capable)
+		return 0;
+
+	ret = dom_data_init(r);
+	if (ret)
+		return ret;
+
+	l3_mon_evt_init(r);
+
+	return 0;
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
-	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
@@ -1036,10 +1052,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1057,8 +1069,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
-	l3_mon_evt_init(r);
-
 	r->mon_capable = true;
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2684a863c727..8c793d2d7a68 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4140,6 +4140,10 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	ret = resctrl_mon_resource_init();
+	if (ret)
+		return ret;
+
 	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret)
 		return ret;
-- 
2.34.1


