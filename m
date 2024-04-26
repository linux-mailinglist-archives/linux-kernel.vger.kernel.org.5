Return-Path: <linux-kernel+bounces-160223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36398B3AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E875286335
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3F1534FC;
	Fri, 26 Apr 2024 15:09:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797A152DF3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144175; cv=none; b=sX/DeK2cURMQY65ldUnWBCphhA3fluKcqv72ZN/1DZ9YANJ7kSWq499vrMHo0CMicvBXAav//yOu36QL8qcZQwGB9XcHEoSstPRelrX+W+6+lMRJGcQ3VYZf4DEusTGLSfKr3V3uFdxmwrdtma2UDTpHNVeOH58OKJElGnKV+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144175; c=relaxed/simple;
	bh=5BrsYzdUzu10GNBLNxylkE2dtQizAArTkZnlXLkB6rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBS0q47/TSI6PTA0xOiX8YN22KsELxn4O9AMk1TDEimHkTOqwp2FFusxeuq8zgAcSCtFiVvGA+LmyrBsJ/NCUFD0jWtp0UL+qt0zcO/3g0hpnltqBxruf+ZdFx8WM+O+dM1ApPJOcAXszTMBU+KQtgq+2hbiHZn0IQHn0QIHSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D1615DB;
	Fri, 26 Apr 2024 08:10:01 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A81083F73F;
	Fri, 26 Apr 2024 08:09:30 -0700 (PDT)
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
Subject: [PATCH v2 07/35] x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
Date: Fri, 26 Apr 2024 16:08:36 +0100
Message-Id: <20240426150904.8854-7-Dave.Martin@arm.com>
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

rdt_find_domain() finds a domain given a resource and a cache-id.
It's not quite right for the resctrl arch API as it also returns the
position to insert a new domain, which is needed when bringing a
domain online in the arch code.

Wrap rdt_find_domain() in another function resctrl_arch_find_domain()
in order to avoid the unnecessary argument outside the arch code.

Signed-off-by: James Morse <james.morse@arm.com>

---

Changes in v2:

 * [Commit message only] Minor rewording to avoid "impersonating code".

 * [Commit message only] Typo fix:
   s/in a another/in another/ in commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 9 +++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 --
 include/linux/resctrl.h                   | 2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b4e7d655e242..06dc12b08afc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -405,8 +405,8 @@ void rdt_ctrl_update(void *arg)
  * caller, return the first domain whose id is bigger than the input id.
  * The domain list is sorted by id in ascending order.
  */
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos)
+static struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
+					  struct list_head **pos)
 {
 	struct rdt_domain *d;
 	struct list_head *l;
@@ -430,6 +430,11 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
+struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id)
+{
+	return rdt_find_domain(r, id, NULL);
+}
+
 static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 72a651671c68..3603ade95f1d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -618,7 +618,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = resctrl_arch_get_resource(resid);
-	d = rdt_find_domain(r, domid, NULL);
+	d = resctrl_arch_find_domain(r, domid);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7c073298aabf..32ade929ea1b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -533,8 +533,6 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index de0297f6167a..1495e03d1f1b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -244,6 +244,8 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info);
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
+struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*
-- 
2.34.1


