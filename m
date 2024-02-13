Return-Path: <linux-kernel+bounces-64114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E9853A32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B20D29061F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFA60B92;
	Tue, 13 Feb 2024 18:46:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9360893
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849980; cv=none; b=dA7g8jmASAluzF2MweLBCDzw+fpH5jNfYxU+naFWBz6LHAvp8/88L3oHDHFxpdfm9n0oDgg3Hy4PrFD8PJOQqEscNDvgUUw8zuM4rmX82r3qdj1GA2I6rgOgFsxn64MBhgu7md7OK3jH4eLm/ghfH4Jihza0lgLbRAG1OopAHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849980; c=relaxed/simple;
	bh=hHAjGEeRkRs4daqFFngb0LSIvNeLboUSwjB1bPyY14U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFM0AJNeVcjFtxdHPV1IxBd5PqhO3BieqnNXvfW8Z4mALn+OrpyZSxtn4Eqc7qnXkO4X/6pv/wJPwPc+tmGTNL0fduCVZ8gzFz2ZsFDqY9nIrdnGOuXLG1RqojqdiRAEXdTQ2prBa8vhZKZe8F3xUqkJAjN/FY+UmHO3zWBl1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB8B1576;
	Tue, 13 Feb 2024 10:47:00 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71123F766;
	Tue, 13 Feb 2024 10:46:15 -0800 (PST)
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
Subject: [PATCH v9 23/24] x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
Date: Tue, 13 Feb 2024 18:44:37 +0000
Message-Id: <20240213184438.16675-24-james.morse@arm.com>
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

When a CPU is taken offline the resctrl filesystem code needs to check
if it was the CPU nominated to perform the periodic overflow and limbo
work. If so, another CPU needs to be chosen to do this work.

This is currently done in core.c, mixed in with the code that removes
the CPU from the domain's mask, and potentially free()s the domain.

Move the migration of the overflow and limbo helpers into the filesystem
code, into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before
the architecture code has removed the CPU from the domain mask, the
callers need to be told which CPU is being removed, to avoid picking
it as the new CPU. This uses the exclude_cpu feature previously
added.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v5:
 * Changed fir tree order of variables.
 * Added mon-capable check for cpu offline.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 16 ----------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4aedefa22f61..b03a6c658ae5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -580,22 +580,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
-
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			/*
-			 * temporary: exclude_cpu=-1 as this CPU has already
-			 * been removed by cpumask_clear_cpu()d
-			 */
-			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-	}
 }
 
 static void clear_closid_rmid(int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5bd3d8fb3f67..777e9f680332 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4029,7 +4029,9 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdtgroup *rdtgrp;
+	struct rdt_domain *d;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -4039,6 +4041,22 @@ void resctrl_offline_cpu(unsigned int cpu)
 			break;
 		}
 	}
+
+	if (!l3->mon_capable)
+		return;
+
+	d = get_domain_from_cpu(cpu, l3);
+	if (d) {
+		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+			cancel_delayed_work(&d->mbm_over);
+			mbm_setup_overflow_handler(d, 0, cpu);
+		}
+		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
+		    has_busy_rmid(d)) {
+			cancel_delayed_work(&d->cqm_limbo);
+			cqm_setup_limbo_handler(d, 0, cpu);
+		}
+	}
 }
 
 /*
-- 
2.39.2


