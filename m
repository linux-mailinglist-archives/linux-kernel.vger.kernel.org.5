Return-Path: <linux-kernel+bounces-55915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF584C354
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E991F23F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051ED10A0C;
	Wed,  7 Feb 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyihPSvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827B10949
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278157; cv=none; b=V4y5TAodyMmdjOXmxUo1PEHeHhawR/U098DKD0JS3P93vZEbNraI0FyrmM1aaIvqcNSEvSFvdshj4G5f8nKjUcExENU20LigTx6N2XNK5+aMomFKf7glpvzyXuIsH21BiKKtjM/GGe8iflJ8KwAwHBEkwYDcVHO/b3cTE7Jb3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278157; c=relaxed/simple;
	bh=7kZpcTwOpBJsZVknIp6pf/jE4tv4HkKG1MtDV4vzq10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no67eEfO1wSky65zG5Uvg8XdbTo7WllFv4R1hcXh09DpisFO2X2cIo/kJZBT29mhdF4c/NIimi2vdM+f+u1ihHUbCgXjqcJotD6PkKKj/iBru2U5OOjPKtO+1rWjFr+o5ovjbeqz7lEh2XY+tJ7UrQDnIKXT+igKK4BRhK1zpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyihPSvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078A0C433C7;
	Wed,  7 Feb 2024 03:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707278156;
	bh=7kZpcTwOpBJsZVknIp6pf/jE4tv4HkKG1MtDV4vzq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyihPSvJY40VJwOTUJApVjde6sK5XNv/PxqZjQFRv32KGiU1FzOkZ1L3EKjmZrceU
	 HXkENg39rGH6GGHyQ1lQ6QJGIRR6z1tilyqBeuQtlYLqKeK8U3ST26aph+PwuMYk3A
	 o1+YL5Gj7nzAT3lKCKJDjeLFrMuMGnRg138EdPpDZN565PLrqY1JaPl0UrgusMF5Rs
	 3Vu+IcbIap3B0nu2re4bR/efqn8J22rHIEUUckmGMdEQujnhkNjKYmVNolLycv0gim
	 piiWsZNLD2HIDw5pgGauo2NeAF0BHUrWWlAeZwCBYuaBhp4GZW/UykHB5g73OJhLNh
	 vU6qG5r5zAaHA==
From: alexs@kernel.org
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v4 5/5] sched: rename SD_SHARE_PKG_RESOURCES to SD_SHARE_LLC
Date: Wed,  7 Feb 2024 11:58:40 +0800
Message-ID: <20240207035840.936676-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207034704.935774-4-alexs@kernel.org>
References: <20240207034704.935774-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

SD_CLUSTER shares the CPU resources like llc tags or l2 cache, that's
easy confuse with SD_SHARE_PKG_RESOURCES. So let's specifical point
what the latter shares: LLC. That would reduce some confusing.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
To: Miaohe Lin <linmiaohe@huawei.com>
To: Barry Song <song.bao.hua@hisilicon.com>
To: Mark Rutland <mark.rutland@arm.com>
To: Frederic Weisbecker <frederic@kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Ben Segall <bsegall@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
To: Ingo Molnar <mingo@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/smp.c      |  6 +++---
 include/linux/sched/sd_flags.h |  4 ++--
 include/linux/sched/topology.h |  6 +++---
 kernel/sched/fair.c            |  2 +-
 kernel/sched/topology.c        | 16 ++++++++--------
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 693334c20d07..a60e4139214b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -984,7 +984,7 @@ static bool shared_caches __ro_after_init;
 /* cpumask of CPUs with asymmetric SMT dependency */
 static int powerpc_smt_flags(void)
 {
-	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 
 	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
@@ -1010,9 +1010,9 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(splpar_asym_pack);
 static int powerpc_shared_cache_flags(void)
 {
 	if (static_branch_unlikely(&splpar_asym_pack))
-		return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
+		return SD_SHARE_LLC | SD_ASYM_PACKING;
 
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_LLC;
 }
 
 static int powerpc_shared_proc_flags(void)
diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index a8b28647aafc..b04a5d04dee9 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -117,13 +117,13 @@ SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
 
 /*
- * Domain members share CPU package resources (i.e. caches)
+ * Domain members share CPU Last Level Caches
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
  *               the same cache(s).
  * NEEDS_GROUPS: Caches are shared between groups.
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
+SD_FLAG(SD_SHARE_LLC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Only a single load balancing instance
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4a21d7..191b122158fb 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -38,21 +38,21 @@ extern const struct sd_flag_debug sd_flag_debug[];
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
-	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 }
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
 static inline int cpu_cluster_flags(void)
 {
-	return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
+	return SD_CLUSTER | SD_SHARE_LLC;
 }
 #endif
 
 #ifdef CONFIG_SCHED_MC
 static inline int cpu_core_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_LLC;
 }
 #endif
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 10ae28e1c088..188597640b1f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10695,7 +10695,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (local->group_type == group_has_spare) {
 		if ((busiest->group_type > group_fully_busy) &&
-		    !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
+		    !(env->sd->flags & SD_SHARE_LLC)) {
 			/*
 			 * If busiest is overloaded, try to fill spare
 			 * capacity. This might end up creating spare capacity
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0b33f7b05d21..e877730219d3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -684,7 +684,7 @@ static void update_top_cache_domain(int cpu)
 	int id = cpu;
 	int size = 1;
 
-	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
+	sd = highest_flag_domain(cpu, SD_SHARE_LLC);
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
@@ -1554,7 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
  * function. For details, see include/linux/sched/sd_flags.h.
  *
  *   SD_SHARE_CPUCAPACITY
- *   SD_SHARE_PKG_RESOURCES
+ *   SD_SHARE_LLC
  *   SD_CLUSTER
  *   SD_NUMA
  *
@@ -1566,7 +1566,7 @@ static struct cpumask		***sched_domains_numa_masks;
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_CLUSTER		|	\
-	 SD_SHARE_PKG_RESOURCES |	\
+	 SD_SHARE_LLC		|	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
 
@@ -1609,7 +1609,7 @@ sd_init(struct sched_domain_topology_level *tl,
 					| 0*SD_BALANCE_WAKE
 					| 1*SD_WAKE_AFFINE
 					| 0*SD_SHARE_CPUCAPACITY
-					| 0*SD_SHARE_PKG_RESOURCES
+					| 0*SD_SHARE_LLC
 					| 0*SD_SERIALIZE
 					| 1*SD_PREFER_SIBLING
 					| 0*SD_NUMA
@@ -1646,7 +1646,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->imbalance_pct = 110;
 
-	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+	} else if (sd->flags & SD_SHARE_LLC) {
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
 
@@ -1671,7 +1671,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	 * For all levels sharing cache; connect a sched_domain_shared
 	 * instance.
 	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+	if (sd->flags & SD_SHARE_LLC) {
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
@@ -2446,8 +2446,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
 			struct sched_domain *child = sd->child;
 
-			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
-			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+			if (!(sd->flags & SD_SHARE_LLC) && child &&
+			    (child->flags & SD_SHARE_LLC)) {
 				struct sched_domain __rcu *top_p;
 				unsigned int nr_llcs;
 
-- 
2.43.0


