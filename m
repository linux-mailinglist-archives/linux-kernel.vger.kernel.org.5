Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E37D72DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJYSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjJYSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:05:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC91E1A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:05:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99D3E14BF;
        Wed, 25 Oct 2023 11:05:56 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D447D3F738;
        Wed, 25 Oct 2023 11:05:11 -0700 (PDT)
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v7 10/24] x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid
Date:   Wed, 25 Oct 2023 18:03:31 +0000
Message-Id: <20231025180345.28061-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
References: <20231025180345.28061-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Instead of allocating the first free CLOSID, on architectures where
CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
closid_num_dirty_rmid[] to find the cleanest CLOSID.

The CLOSID found is returned to closid_alloc() for the free list
to be updated.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Dropped stale section from comment

Changes since v5:
 * Renamed some variables.

No changes since v6
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++---
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2f1d4f141dab..521afa016b05 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -568,5 +568,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+bool closid_allocated(unsigned int closid);
+int resctrl_find_cleanest_closid(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9a07707d3eb4..cf512d4d383e 100644
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
index f6051a3e7262..0b9bd5f0f60d 100644
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

