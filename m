Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8017D72D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjJYSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjJYSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:04:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66034184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:04:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C5B1474;
        Wed, 25 Oct 2023 11:05:34 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496A63F738;
        Wed, 25 Oct 2023 11:04:50 -0700 (PDT)
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
Subject: [PATCH v7 04/24] x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
Date:   Wed, 25 Oct 2023 18:03:25 +0000
Message-Id: <20231025180345.28061-5-james.morse@arm.com>
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

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Moved kernfs_activate() later to preserve atomicity of files being visible

Changes since v5:
 * Renamed out_id_free as out_closid_free.

No changes since v6
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
2.39.2

