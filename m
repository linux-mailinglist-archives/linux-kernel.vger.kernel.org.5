Return-Path: <linux-kernel+bounces-1443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F3814F18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346161F25884
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE641863;
	Fri, 15 Dec 2023 17:44:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29D4174B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA931650;
	Fri, 15 Dec 2023 09:45:00 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FFEE3F5A1;
	Fri, 15 Dec 2023 09:44:12 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8 04/24] x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
Date: Fri, 15 Dec 2023 17:43:23 +0000
Message-Id: <20231215174343.13872-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RMID are allocated for each monitor or control group directory, because
each of these needs its own RMID. For control groups,
rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.

MPAM's equivalent of RMID is not an independent number, so can't be
allocated until the CLOSID is known. An RMID allocation for one CLOSID
may fail, whereas another may succeed depending on how many monitor
groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been
allocated.

Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
after the mkdir_rdt_prepare() call. This allows the RMID allocator to
know the CLOSID.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v2:
 * Moved kernfs_activate() later to preserve atomicity of files being visible

Changes since v5:
 * Renamed out_id_free as out_closid_free.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 +++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1eb3a3075093..8fb0f56f64be 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3317,6 +3317,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
+static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
+{
+	if (rdt_mon_capable)
+		free_rmid(rgrp->mon.rmid);
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -3389,12 +3395,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
-	if (ret)
-		goto out_destroy;
-
-	kernfs_activate(kn);
-
 	/*
 	 * The caller unlocks the parent_kn upon success.
 	 */
@@ -3413,7 +3413,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
 {
 	kernfs_remove(rgrp->kn);
-	free_rmid(rgrp->mon.rmid);
 	rdtgroup_remove(rgrp);
 }
 
@@ -3435,12 +3434,21 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 	prgrp = rdtgrp->mon.parent;
 	rdtgrp->closid = prgrp->closid;
 
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret) {
+		mkdir_rdt_prepare_clean(rdtgrp);
+		goto out_unlock;
+	}
+
+	kernfs_activate(rdtgrp->kn);
+
 	/*
 	 * Add the rdtgrp to the list of rdtgrps the parent
 	 * ctrl_mon group has to track.
 	 */
 	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
 
+out_unlock:
 	rdtgroup_kn_unlock(parent_kn);
 	return ret;
 }
@@ -3471,9 +3479,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	ret = 0;
 
 	rdtgrp->closid = closid;
+
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_closid_free;
+
+	kernfs_activate(rdtgrp->kn);
+
 	ret = rdtgroup_init_alloc(rdtgrp);
 	if (ret < 0)
-		goto out_id_free;
+		goto out_rmid_free;
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
@@ -3493,7 +3508,9 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
-out_id_free:
+out_rmid_free:
+	mkdir_rdt_prepare_rmid_free(rdtgrp);
+out_closid_free:
 	closid_free(closid);
 out_common_fail:
 	mkdir_rdt_prepare_clean(rdtgrp);
-- 
2.20.1


