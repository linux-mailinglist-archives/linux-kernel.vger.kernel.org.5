Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069FC7D72D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJYSEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJYSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:04:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D33EA3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83758C15;
        Wed, 25 Oct 2023 11:05:28 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D013F738;
        Wed, 25 Oct 2023 11:04:43 -0700 (PDT)
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
Subject: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from rdtgroup_exit()
Date:   Wed, 25 Oct 2023 18:03:23 +0000
Message-Id: <20231025180345.28061-3-james.morse@arm.com>
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

rmid_ptrs[] is allocated from dom_data_init() but never free()d.

While the exit text ends up in the linker script's DISCARD section,
the direction of travel is for resctrl to be/have loadable modules.

Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
by rdt_get_mon_l3_config().

There is no reason to backport this to a stable kernel.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v5:
 * This patch is new

Changes since v6:
 * Removed struct rdt_resource argument, added __exit markers to match the
   only caller.
 * Adedd a whole stack of functions to maintain symmetry.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..0056c9962a44 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
 
 static void __exit resctrl_exit(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	cpuhp_remove_state(rdt_online);
+
+	if (r->mon_capable)
+		rdt_put_mon_l3_config(r);
+
 	rdtgroup_exit();
 }
 
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
2.39.2

