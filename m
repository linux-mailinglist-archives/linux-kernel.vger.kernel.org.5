Return-Path: <linux-kernel+bounces-64101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1F853A23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2111F23442
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0260DF8;
	Tue, 13 Feb 2024 18:45:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85360DF1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849938; cv=none; b=Ul4JBOvLScMPCbyXCU8ZY5MuQcDtkG1CcIOt3VIrqR0NpHAwfsr4mSNZGPYuACi5nO2A6MDA7ekmVCTFy42ymiRcamuaRygum5BUsS6myGnU+bvKVvk9q1hyO5sOqNRmcHsCfsFZpFGtNuAV6V6S3VfV90ipioArRB2W7BTukQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849938; c=relaxed/simple;
	bh=yTn+5rNsttXSA8wv9R6eV/BdH3FviFAT3quk383HYUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peokL6DiyP0FtTuaMoHPuehamH8jIAVUFV0Lvu8r8kwQWlE4PXo7+MrbvwhBROik/DypoqCTJ4Q2EcaBMiTsAS5+3YWeFEVGKIcFMnMoBnh5T0O5lJvOl36aIvVhezqhLCDBKOQtTbQZwJoikbMMuVKmqZpKTWqpCeBGW7DnFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CB314BF;
	Tue, 13 Feb 2024 10:46:16 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64A323F766;
	Tue, 13 Feb 2024 10:45:32 -0800 (PST)
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
Subject: [PATCH v9 10/24] x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid
Date: Tue, 13 Feb 2024 18:44:24 +0000
Message-Id: <20240213184438.16675-11-james.morse@arm.com>
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

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Instead of allocating the first free CLOSID, on architectures where
CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
closid_num_dirty_rmid[] to find the cleanest CLOSID.

The CLOSID found is returned to closid_alloc() for the free list
to be updated.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v4:
 * Dropped stale section from comment

Changes since v5:
 * Renamed some variables.

Changes since v7:
 * Made comments over closid_num_dirty_rmid() not a kdoc comment.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++---
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 872ba1a34103..b7b9d9230bef 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -566,5 +566,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+bool closid_allocated(unsigned int closid);
+int resctrl_find_cleanest_closid(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 13b0c8d14f3d..101f1b112d17 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -386,6 +386,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
 	return ERR_PTR(-ENOSPC);
 }
 
+/**
+ * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
+ *                                  RMID are clean, or the CLOSID that has
+ *                                  the most clean RMID.
+ *
+ * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
+ * may not be able to allocate clean RMID. To avoid this the allocator will
+ * choose the CLOSID with the most clean RMID.
+ *
+ * When the CLOSID and RMID are independent numbers, the first free CLOSID will
+ * be returned.
+ */
+int resctrl_find_cleanest_closid(void)
+{
+	u32 cleanest_closid = ~0;
+	int i = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		return -EIO;
+
+	for (i = 0; i < closids_supported(); i++) {
+		int num_dirty;
+
+		if (closid_allocated(i))
+			continue;
+
+		num_dirty = closid_num_dirty_rmid[i];
+		if (num_dirty == 0)
+			return i;
+
+		if (cleanest_closid == ~0)
+			cleanest_closid = i;
+
+		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
+			cleanest_closid = i;
+	}
+
+	if (cleanest_closid == ~0)
+		return -ENOSPC;
+
+	return cleanest_closid;
+}
+
 /*
  * For MPAM the RMID value is not unique, and has to be considered with
  * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bc6e0f83c847..8fc46204a6cc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -137,13 +137,22 @@ static void closid_init(void)
 
 static int closid_alloc(void)
 {
-	u32 closid = ffs(closid_free_map);
+	int cleanest_closid;
+	u32 closid;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (closid == 0)
-		return -ENOSPC;
-	closid--;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		cleanest_closid = resctrl_find_cleanest_closid();
+		if (cleanest_closid < 0)
+			return cleanest_closid;
+		closid = cleanest_closid;
+	} else {
+		closid = ffs(closid_free_map);
+		if (closid == 0)
+			return -ENOSPC;
+		closid--;
+	}
 	__clear_bit(closid, &closid_free_map);
 
 	return closid;
@@ -163,7 +172,7 @@ void closid_free(int closid)
  * Return: true if @closid is currently associated with a resource group,
  * false if @closid is free
  */
-static bool closid_allocated(unsigned int closid)
+bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-- 
2.39.2


