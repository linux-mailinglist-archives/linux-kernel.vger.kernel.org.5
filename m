Return-Path: <linux-kernel+bounces-110426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66064885EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977E21C21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33F13A894;
	Thu, 21 Mar 2024 16:52:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0213A871
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039920; cv=none; b=seZhxzDuH8nL+LX+Gab7APED1q9ZdujY4tPrXvu88KNkWzM90ikbcfdYi9P7BDFBBqHrt/TsJSjtIzHDJsmAYngZRf0Wtvo5w/K5UT4cPnTdYxiL2H79br8l2cndeiftKGIJCdvloMM5UzWor2gnRi8eYKtK/W21wXpz2nTXSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039920; c=relaxed/simple;
	bh=o1zn+OQp7jij+/S14yaNK/v9gJcYPVyuhx5I/BBFRX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i43Vn8M2Zx7vxYkOX2jDhuzdgdBzvZMjzQJmRQ40kgCq+PAJVYNtwFDD07JKT4HElYbt+dZxWCFLXsj8nt+OvvNuSvICaV/DOVQXbAHlPAOtOKBh3c20WTbrD2eoKoXqgkCv0J6mI4fMC/hJ1vf4PEHHZto48CXo261WXgFDMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB50A1063;
	Thu, 21 Mar 2024 09:52:32 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7B03F67D;
	Thu, 21 Mar 2024 09:51:55 -0700 (PDT)
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
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 09/31] x86/resctrl: Add a resctrl helper to reset all the resources
Date: Thu, 21 Mar 2024 16:50:44 +0000
Message-Id: <20240321165106.31602-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On umount(), resctrl resets each resource back to its default
configuration. It only ever does this for all resources in one go.

reset_all_ctrls() is architecture specific as it works with struct
rdt_hw_resource.

Add an architecture helper to reset all resources.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index f61382258743..5f6a5375bb4a 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -15,6 +15,8 @@
  */
 #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
 
+void resctrl_arch_reset_resources(void);
+
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1a49c9918f8d..13c24cb18d76 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2859,6 +2859,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_arch_reset_resources(void)
+{
+	struct rdt_resource *r;
+
+	for_each_capable_rdt_resource(r)
+		reset_all_ctrls(r);
+}
+
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
@@ -2968,16 +2976,14 @@ static void rmdir_all_sub(void)
 
 static void rdt_kill_sb(struct super_block *sb)
 {
-	struct rdt_resource *r;
-
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	rdt_disable_ctx();
 
-	/*Put everything back to default values. */
-	for_each_alloc_capable_rdt_resource(r)
-		reset_all_ctrls(r);
+	/* Put everything back to default values. */
+	resctrl_arch_reset_resources();
+
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-- 
2.39.2


