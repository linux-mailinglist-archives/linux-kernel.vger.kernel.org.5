Return-Path: <linux-kernel+bounces-160230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F48B3AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F421F26AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936915B107;
	Fri, 26 Apr 2024 15:09:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24A15991F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144194; cv=none; b=fVO1Mad2lMdiMmcDh9Jq13SoLScdi9XVcuTH6nRtrabk4HiqtUJq7hjsY9lR13JI1T5kyJC4JB7rgU1Tvg55Px1D/7lv6bl0olXxzwfl90Kd3vqz0ogPW+1KLi1Bu4J+3WxBhAG/iIdoL2ybn7/gsox+TytQuZDdZO12/ks3cUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144194; c=relaxed/simple;
	bh=wRxClTnVPD3QbNe2PEaO09YErOJxIs3JJuygHgyrwmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nj97jZJmKQNt8QWapKXqwbFZMZMNc47leyhm0BsFxRiLsZ+3mklP1onbijADp/6Kw1IgshQx4S75TBlRJxhgQ2/U1VI0s2FKe8RvZRWwgmIPZf3O97ggBgiw3ZL1aHi3CJ3rL8Ra7otH6O3ZtUf6lb1jo3WlfLwjF5bM2HGq7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217841688;
	Fri, 26 Apr 2024 08:10:20 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384CA3F8A4;
	Fri, 26 Apr 2024 08:09:49 -0700 (PDT)
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
Subject: [PATCH v2 13/35] x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
Date: Fri, 26 Apr 2024 16:08:42 +0100
Message-Id: <20240426150904.8854-13-Dave.Martin@arm.com>
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

The for_each_*_rdt_resource() helpers walk the architecture's array
of structures, using the resctrl visible part as an iterator. These
became over-complex when the structures were split into a
filesystem and architecture-specific struct. This approach avoided
the need to touch every call site.

Once the filesystem parts of resctrl are moved to /fs/, both the
architecture's resource array, and the definition of those structures
is no longer accessible. To support resctrl, each architecture would
have to provide equally complex macros.

Change the resctrl code that uses these to walk through the resource_level
enum and check the mon/alloc capable flags instead. Instances in core.c,
and resctrl_arch_reset_resources() remain part of x86's architecture
specific code.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * [Whitespace only] Fix bogus whitespace introduced in
   rdtgroup_create_info_dir().

 * [Commit message only] Typo fix:
   s/architectures/architecture's/g
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 +++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 28 +++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e25141..f2315a50ea4f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -840,6 +840,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 {
 	cpumask_var_t cpu_with_psl;
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct rdt_domain *d_i;
 	bool ret = false;
@@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * First determine which cpus have pseudo-locked regions
 	 * associated with them.
 	 */
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		list_for_each_entry(d_i, &r->domains, list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9d4c8d641615..d678fe2a2142 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -98,12 +98,17 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 void rdt_staged_configs_clear(void)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct rdt_domain *dom;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		list_for_each_entry(dom, &r->domains, list)
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
@@ -2179,6 +2184,7 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	enum resctrl_res_level i;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
@@ -2203,7 +2209,11 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 			goto out_destroy;
 	}
 
-	for_each_mon_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->mon_capable)
+			continue;
+
 		fflags = r->fflags | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
@@ -2613,10 +2623,15 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 static int schemata_list_create(void)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	int ret = 0;
 
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		if (resctrl_arch_get_cdp_enabled(r->rid)) {
 			ret = schemata_list_add(r, CDP_CODE);
 			if (ret)
@@ -3165,6 +3180,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **dest_kn)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct kernfs_node *kn;
 	int ret;
@@ -3183,7 +3199,11 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	 * Create the subdirectories for each domain. Note that all events
 	 * in a domain like L3 are grouped into a resource whose domain is L3
 	 */
-	for_each_mon_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->mon_capable)
+			continue;
+
 		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
 		if (ret)
 			goto out_destroy;
-- 
2.34.1


