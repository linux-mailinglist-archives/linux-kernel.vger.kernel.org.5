Return-Path: <linux-kernel+bounces-64094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F6853A18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC251C22FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A26088B;
	Tue, 13 Feb 2024 18:45:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93C60881
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849914; cv=none; b=i+kyYcLScuE5xclZK28AYW0lmYje+C3JBL5JxGBMQzB7cZt+efSsJmOmhj5G0mht7m5MBFT9YMWjbGXaeBdDFdesCa42OGhrfJGQSNSdavdhbZbZYRja1uERBDnCiiKFQO7YH6uXRqEwoX5siruBIC3qzGEJMWmnch6ADRaVZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849914; c=relaxed/simple;
	bh=e9JWYiCmeFsWinCmEWYZOTDNfITJiLE8EatsPyrLEfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e21cLK1Uef0QuLrhhti6QXmCdrlXaco+v6R5BI0p2zZw7Q15L1p/B+rEh5psyCpQ7nDX95HshEp08xA8GI3wsb5FMpNIGhhVYIcXfPQ9oxg6bpQuyo25GSwN0RXSHPKb+7EmyeioJudr9OM0dQSk1UEB0gkLAFqhwo/TNc7Y0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE2F1042;
	Tue, 13 Feb 2024 10:45:53 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1CB3F766;
	Tue, 13 Feb 2024 10:45:08 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 03/24] x86/resctrl: Create helper for RMID allocation and mondata dir creation
Date: Tue, 13 Feb 2024 18:44:17 +0000
Message-Id: <20240213184438.16675-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When monitoring is supported, each monitor and control group is allocated
an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
allocate the CLOSID.

MPAM's equivalent of RMID are not an independent number, so can't be
allocated until the CLOSID is known. An RMID allocation for one CLOSID
may fail, whereas another may succeed depending on how many monitor
groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been
allocated.

Move the RMID allocation and mondata dir creation to a helper.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>

---
Changes since v4:
 * Fixed typo in commit message, moved some words around.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++++++---------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aa24343f1d23..4ea5a871be49 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3288,6 +3288,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	return ret;
 }
 
+static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (!rdt_mon_capable)
+		return 0;
+
+	ret = alloc_rmid();
+	if (ret < 0) {
+		rdt_last_cmd_puts("Out of RMIDs\n");
+		return ret;
+	}
+	rdtgrp->mon.rmid = ret;
+
+	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs subdir error\n");
+		free_rmid(rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -3360,20 +3384,10 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rdt_mon_capable) {
-		ret = alloc_rmid();
-		if (ret < 0) {
-			rdt_last_cmd_puts("Out of RMIDs\n");
-			goto out_destroy;
-		}
-		rdtgrp->mon.rmid = ret;
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_destroy;
 
-		ret = mkdir_mondata_all(kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
-		if (ret) {
-			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_idfree;
-		}
-	}
 	kernfs_activate(kn);
 
 	/*
@@ -3381,8 +3395,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	 */
 	return 0;
 
-out_idfree:
-	free_rmid(rdtgrp->mon.rmid);
 out_destroy:
 	kernfs_put(rdtgrp->kn);
 	kernfs_remove(rdtgrp->kn);
-- 
2.39.2


