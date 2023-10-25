Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824E7D72F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjJYSH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjJYSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:07:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C38268F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:06:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B291515;
        Wed, 25 Oct 2023 11:07:21 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD08B3F738;
        Wed, 25 Oct 2023 11:06:29 -0700 (PDT)
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
Subject: [PATCH v7 22/24] x86/resctrl: Add CPU offline callback for resctrl work
Date:   Wed, 25 Oct 2023 18:03:43 +0000
Message-Id: <20231025180345.28061-23-james.morse@arm.com>
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

The resctrl architecture specific code may need to free a domain when
a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
Amongst other things, the resctrl filesystem code needs to clear this
CPU from the cpu_mask of any control and monitor groups.

Currently this is all done in core.c and called from
resctrl_offline_cpu(), making the split between architecture and
filesystem code unclear.

Move the filesystem work to remove the CPU from the control and monitor
groups into a filesystem helper called resctrl_offline_cpu(), and rename
the one in core.c resctrl_arch_offline_cpu().

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v6

 arch/x86/kernel/cpu/resctrl/core.c     | 25 +++++--------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 ++++++++++++++++++++++++
 include/linux/resctrl.h                |  1 +
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7e44f2c40897..7d09b8d7c653 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -627,31 +627,15 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+static int resctrl_arch_offline_cpu(unsigned int cpu)
 {
-	struct rdtgroup *cr;
-
-	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask)) {
-			break;
-		}
-	}
-}
-
-static int resctrl_offline_cpu(unsigned int cpu)
-{
-	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
+	resctrl_offline_cpu(cpu);
+
 	for_each_capable_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
-			clear_childcpus(rdtgrp, cpu);
-			break;
-		}
-	}
 	clear_closid_rmid(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
@@ -973,7 +957,8 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_arch_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu,
+				  resctrl_arch_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e22e0f6adeb3..971a8397e243 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4022,6 +4022,30 @@ void resctrl_online_cpu(unsigned int cpu)
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 }
 
+static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+{
+	struct rdtgroup *cr;
+
+	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
+			break;
+	}
+}
+
+void resctrl_offline_cpu(unsigned int cpu)
+{
+	struct rdtgroup *rdtgrp;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
+			clear_childcpus(rdtgrp, cpu);
+			break;
+		}
+	}
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ccbbbe5d18d3..270ff1d5c051 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -226,6 +226,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_online_cpu(unsigned int cpu);
+void resctrl_offline_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
-- 
2.39.2

