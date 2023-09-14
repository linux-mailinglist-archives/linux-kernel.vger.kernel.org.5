Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F77A0B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjINRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjINRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:23:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F672D79
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF1511FB;
        Thu, 14 Sep 2023 10:23:34 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 592203F5A1;
        Thu, 14 Sep 2023 10:22:54 -0700 (PDT)
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v6 20/24] x86/resctrl: Add CPU online callback for resctrl work
Date:   Thu, 14 Sep 2023 17:21:34 +0000
Message-Id: <20230914172138.11977-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
References: <20230914172138.11977-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl architecture specific code may need to create a domain when
a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
The resctrl filesystem code needs to update the rdtgroup_default CPU
mask when CPUs are brought online.

Currently this is all done in one function, resctrl_online_cpu().
This will need to be split into architecture and filesystem parts
before resctrl can be moved to /fs/.

Pull the rdtgroup_default update work out as a filesystem specific
cpu_online helper. resctrl_online_cpu() is the obvious name for this,
which means the version in core.c needs renaming.

resctrl_online_cpu() is called by the arch code once it has done the
work to add the new CPU to any domains.

In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
itself.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-By: Peter Newman <peternewman@google.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Renamed err to ret

Changes since v4:
 * Changes in capitalisation.

Changes since v5:
 * More changes in capitalisation.
 * Made resctrl_online_cpu() return void.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++++
 include/linux/resctrl.h                | 1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index eaadf6f20900..5b4c719ac129 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -604,16 +604,16 @@ static void clear_closid_rmid(int cpu)
 	      RESCTRL_RESERVED_CLOSID);
 }
 
-static int resctrl_online_cpu(unsigned int cpu)
+static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
-	/* The cpu is set in default rdtgroup after online. */
-	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 	clear_closid_rmid(cpu);
+
+	resctrl_online_cpu(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
 	return 0;
@@ -966,7 +966,7 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dfaef047dead..0c609cdfe7e5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3868,6 +3868,14 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+void resctrl_online_cpu(unsigned int cpu)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* The CPU is set in default rdtgroup after online. */
+	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5e4b4df9610b..9d5f75a4e192 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -223,6 +223,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_online_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
-- 
2.39.2

