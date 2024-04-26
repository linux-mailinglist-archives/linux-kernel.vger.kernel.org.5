Return-Path: <linux-kernel+bounces-160225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6198B3ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8441C2313E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8CB15686F;
	Fri, 26 Apr 2024 15:09:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE90149018
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144181; cv=none; b=LxW889FiK+x8G+l/0dbEABzE5skmKmk5GYCf7t2eBYM+ypYrk2HZjyYARMxiV1qoD6iwn2lwGg0IEZnZ/FxhFUKEQPBoKmp44Z7qwZ82+gVjDiuojJsgXFzpZy3HqqifATXljdDvf06PIcz/29zKh95THGoFbIddkxHmdedw6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144181; c=relaxed/simple;
	bh=zaVKIYlWlH67MVBzRdaf2KncAzvORLUtj1iMETwI+EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2OA2gC+foUxQ9MtqvdqtxCh0qIz10vjKXEXmH0CbeAKImpDGSLkUZkTdb5kBSrdoo+tZLGoK81vLS1i3V9IPnm19sXvTtuZTB/lvAtOslU+9SJiAXLjqTWFFYm4crws8cYK0SFN0aDXXPM2O/iOnWvapBHPGKEsUrYmx41oPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7AAB1692;
	Fri, 26 Apr 2024 08:10:07 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3E7A3F73F;
	Fri, 26 Apr 2024 08:09:36 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 09/35] x86/resctrl: Add a resctrl helper to reset all the resources
Date: Fri, 26 Apr 2024 16:08:38 +0100
Message-Id: <20240426150904.8854-9-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

On umount(), resctrl resets each resource back to its default
configuration. It only ever does this for all resources in one go.

reset_all_ctrls() is architecture specific as it works with struct
rdt_hw_resource.

Add an architecture helper to reset all resources.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: James Morse:

 * Review the v2 change detailed below.  If the original change in v1
   was intentional, the rationale needs to be spelled out.

Changes in v2:

 * Rename the for_each_capable_rdt_resource() introduced in the new
   function resctrl_arch_reset_resources(), back to
   for_each_alloc_capable_rdt_resource() as it was in the original code.

   The change looked unintentional; and presumably a resource that does
   not support resource allocation doesn't have any properties to
   reset...
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
index 997f31ee5de4..2684a863c727 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2858,6 +2858,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_arch_reset_resources(void)
+{
+	struct rdt_resource *r;
+
+	for_each_alloc_capable_rdt_resource(r)
+		reset_all_ctrls(r);
+}
+
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
@@ -2967,16 +2975,14 @@ static void rmdir_all_sub(void)
 
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
2.34.1


