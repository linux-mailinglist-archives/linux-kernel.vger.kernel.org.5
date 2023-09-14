Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2107A0B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjINRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbjINRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:22:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48FA31BFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BFD312FC;
        Thu, 14 Sep 2023 10:22:39 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36FDD3F5A1;
        Thu, 14 Sep 2023 10:21:59 -0700 (PDT)
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
Subject: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from rdtgroup_exit()
Date:   Thu, 14 Sep 2023 17:21:16 +0000
Message-Id: <20230914172138.11977-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
References: <20230914172138.11977-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 10 ++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..57cf1e6a57bd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -537,6 +537,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+void resctrl_exit_mon_l3_config(struct rdt_resource *r);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7cb7cb..cfb3f632a4b2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_exit_mon_l3_config(struct rdt_resource *r)
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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..a2158c266e41 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3867,6 +3867,11 @@ int __init rdtgroup_init(void)
 
 void __exit rdtgroup_exit(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (r->mon_capable)
+		resctrl_exit_mon_l3_config(r);
+
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-- 
2.39.2

