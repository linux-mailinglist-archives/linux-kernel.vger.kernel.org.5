Return-Path: <linux-kernel+bounces-160204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DB8B3A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7231C2345F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1314148858;
	Fri, 26 Apr 2024 15:05:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91201E869
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143953; cv=none; b=jryvCoBWjk+abmAs3ByShi9LjQs6wqNtIkAR03ovWl3qfSu5nW3uJZaCvypuhmi9p2RwBa2ySvPdImAQl5BEuyzc2VL0io17VVJ3A4FTJt5WoRtUBMwLFli6d/VStdQpbv1qVfKg8M8lG8M+ef3U0DHuguAt+lgMkafq1Uvs2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143953; c=relaxed/simple;
	bh=1ITIrCFVuBUIXr8STYx9u8mMklV6Ej7cNQjXgb2F3zc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KjUB4yci7+CwXqp/EfrJP57dypkO0wi35uslWRtRRjPyaxfFp8S0J+2TrCW6/5FJduiDvpytPtxAiuWutu9txwFghtdzk29F2jmCDYWRarysP/k0mYVzUul9+DbG/WutaLGBp3krhlLmIWzGGJ6pn3PLZO/JzVIWHi0E818ySI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DD962F4;
	Fri, 26 Apr 2024 08:06:12 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31DA53F73F;
	Fri, 26 Apr 2024 08:05:41 -0700 (PDT)
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
Subject: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Fri, 26 Apr 2024 16:05:37 +0100
Message-Id: <20240426150537.8094-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is a respin of the resctrl refactoring series described below,
addressing review feedback.  Many thanks to those to responded with
feedback on the v1 series [2].

See Notes and FYIs in the individual patches for details on the changes
and outstanding issues.


This series has not been rebased since the v1 posting, and remains
based on the following upstream commit:

commit 23956900041d968f9ad0f30db6dede4daccd7aa9
Merge tag 'v6.9-rc-smb3-server-fixes' of git://git.samba.org/ksmbd

The actual code changes against v1 are few in number and rather spread
around.  For reviewer convenience, a diff against v1 is appended to
this cover letter.

Due to the limited code changes, this series has *not* received any
additional runtime testing over than done for v1 (other than build
bisect testing).

Cheers
---Dave


[2] v1 series:
[PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
https://lore.kernel.org/all/20240321165106.31602-1-james.morse@arm.com/

--8<-- Original blurb

This is the final series that allows other architectures to implement resctrl.
The last patch just moves the code, and its a bit of a monster. I don't expect
that to get merged as part of this series - we should wait for it to make
less impact on other series. It's included here to show what gets moved, and
that structures/function-prototypes have the right visibility.

Otherwise this series renames functions and moves code around. With the
exception of invalid configurations for the configurable-events, there should
be no changes in behaviour caused by this series.

The driving pattern is to make things like struct rdtgroup private to resctrl.
Features like pseudo-lock aren't going to work on arm64, the ability to disable
it at compile time is added.

After this, I can start posting the MPAM driver to make use of resctrl on arm64.
(What's MPAM? See the cover letter of the first series. [1])

This series is based on Linus' commit 23956900041d and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
mpam/move_to_fs/v1

Sorry for the mid-merge window base, I'm away for a few weeks - this should
rebase trivially onto rc1.

As ever - bugs welcome,
Thanks,

James

[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

-->8--


Dave Martin (4):
  x86/resctrl: Squelch whitespace anomalies in resctrl core code
  x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
  x86/resctrl: Relax some asm #includes
  [SQUASHME] x86/resctrl: Move the resctrl filesystem code to
    /fs/resctrl

James Morse (31):
  x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
    monitors
  x86/resctrl: Add a helper to avoid reaching into the arch code
    resource list
  x86/resctrl: Move ctrlval string parsing policy away from the arch
    code
  x86/resctrl: Add helper for setting CPU default properties
  x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
  x86/resctrl: Export resctrl fs's init function
  x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
  x86/resctrl: Move resctrl types to a separate header
  x86/resctrl: Add a resctrl helper to reset all the resources
  x86/resctrl: Move monitor init work to a resctrl init call
  x86/resctrl: Move monitor exit work to a resctrl exit call
  x86/resctrl: Move max_{name,data}_width into resctrl code
  x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
  x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
  x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
  x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
  x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
  x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an
    error
  x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
  x86/resctrl: Allow an architecture to disable pseudo lock
  x86/resctrl: Make prefetch_disable_bits belong to the arch code
  x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
  x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
  x86/resctrl: Move get_config_index() to a header
  x86/resctrl: Claim get_domain_from_cpu() for resctrl
  x86/resctrl: Describe resctrl's bitmap size assumptions
  x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
  x86/resctrl: Drop __init/__exit on assorted symbols
  fs/resctrl: Add boiler plate for external resctrl code
  x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
  x86/resctrl: Move the resctrl filesystem code to /fs/resctrl

 MAINTAINERS                               |    2 +
 arch/Kconfig                              |    8 +
 arch/x86/Kconfig                          |    5 +-
 arch/x86/include/asm/resctrl.h            |   45 +-
 arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
 arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  436 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1130 +-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4205 +--------------------
 arch/x86/kernel/process_32.c              |    2 +-
 arch/x86/kernel/process_64.c              |    2 +-
 fs/Kconfig                                |    1 +
 fs/Makefile                               |    1 +
 fs/resctrl/Kconfig                        |   36 +
 fs/resctrl/Makefile                       |    3 +
 fs/resctrl/ctrlmondata.c                  |  527 +++
 fs/resctrl/internal.h                     |  338 ++
 fs/resctrl/monitor.c                      |  843 +++++
 fs/resctrl/pseudo_lock.c                  | 1122 ++++++
 fs/resctrl/rdtgroup.c                     | 4013 ++++++++++++++++++++
 include/linux/resctrl.h                   |  157 +-
 include/linux/resctrl_types.h             |   98 +
 24 files changed, 7402 insertions(+), 7015 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 include/linux/resctrl_types.h

Interdiff:
diff --git a/arch/Kconfig b/arch/Kconfig
index 131d874d6738..f163964e6915 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1409,10 +1409,10 @@ config ARCH_HAS_PHYS_TO_DMA
 config ARCH_HAS_CPU_RESCTRL
 	bool
 	help
-	  The 'resctrl' filesystem allows CPU controls of shared resources
-	  such as caches and memory bandwidth to be configured. An architecture
-	  selects this if it provides the arch-specific hooks for the filesystem
-	  and needs the per-task CLOSID/RMID properties.
+	  An architecture selects this option to indicate that the necessary
+	  hooks are provided to support the common memory system usage
+	  monitoring and control interfaces provided by the 'resctrl'
+	  filesystem (see RESCTRL_FS).
 
 config HAVE_ARCH_COMPILER_H
 	bool
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 746431c66fc4..506ecd04788b 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -6,8 +6,8 @@
 
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
-#include <linux/sched.h>
 #include <linux/resctrl_types.h>
+#include <linux/sched.h>
 
 /*
  * This value can never be a valid CLOSID, and is used when mapping a
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bf3538992667..8c20bd04b840 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,10 +7,9 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <linux/resctrl.h>
 #include <linux/tick.h>
 
-#include <asm/resctrl.h>
-
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index ba1596afee10..1488d1728f1f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -19,12 +20,11 @@
 #include <linux/mman.h>
 #include <linux/perf_event.h>
 #include <linux/pm_qos.h>
+#include <linux/resctrl.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index fe3952514add..061501e9fc98 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -13,9 +13,9 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/cpu.h>
+#include <linux/resctrl.h>
 #include <linux/slab.h>
 
-#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
@@ -28,9 +28,9 @@ DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
  */
-void resctrl_arch_sync_cpu_defaults(void *info)
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
 {
-	struct resctrl_cpu_sync *r = info;
+	struct resctrl_cpu_defaults *r = info;
 
 	if (r) {
 		this_cpu_write(pqr_state.default_closid, r->closid);
@@ -255,6 +255,6 @@ void resctrl_arch_reset_resources(void)
 {
 	struct rdt_resource *r;
 
-	for_each_capable_rdt_resource(r)
+	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 }
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
index 36a1ddbe6c21..a5fbda54d32f 100644
--- a/fs/resctrl/Kconfig
+++ b/fs/resctrl/Kconfig
@@ -2,18 +2,31 @@ config RESCTRL_FS
 	bool "CPU Resource Control Filesystem (resctrl)"
 	depends on ARCH_HAS_CPU_RESCTRL
 	select KERNFS
-	select PROC_CPU_RESCTRL               if PROC_FS
+	select PROC_CPU_RESCTRL if PROC_FS
 	help
-	  Resctrl is a filesystem interface
-	  to control allocation and
-	  monitoring of system resources
-	  used by the CPUs.
+	  Some architectures provide hardware facilities to group tasks and
+	  monitor and control their usage of memory system resources such as
+	  caches and memory bandwidth.  Examples of such facilities include
+	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
+	  Platform Quality of Service (AMD QoS).
+
+	  If your system has the necessary support and you want to be able to
+	  assign tasks to groups and manipulate the associated resource
+	  monitors and controls from userspace, say Y here to get a mountable
+	  'resctrl' filesystem that lets you do just that.
+
+	  If nothing mounts or prods the 'resctrl' filesystem, resource
+	  controls and monitors are left in a quiescent, permissive state.
+
+	  If unsure, it is safe to say N.
+
+	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
 
 config RESCTRL_FS_PSEUDO_LOCK
 	bool
 	help
-          Software mechanism to pin data in a cache portion using
-          micro-architecture specific knowledge.
+	  Software mechanism to pin data in a cache portion using
+	  micro-architecture specific knowledge.
 
 config RESCTRL_RMID_DEPENDS_ON_CLOSID
 	bool
diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
index 10fcfb0fdb10..ee8c4463317a 100644
--- a/fs/resctrl/Makefile
+++ b/fs/resctrl/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
-obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= psuedo_lock.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index f73267762a87..0e0c70d62c40 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -9,8 +9,6 @@
 #include <linux/jump_label.h>
 #include <linux/tick.h>
 
-#include <asm/resctrl.h>
-
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 06f660dfd929..14a9f18efe45 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -745,7 +745,7 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in rdtgroup_init().
+	 * control group, which will be setup later in resctrl_init().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
diff --git a/fs/resctrl/psuedo_lock.c b/fs/resctrl/pseudo_lock.c
similarity index 99%
rename from fs/resctrl/psuedo_lock.c
rename to fs/resctrl/pseudo_lock.c
index 077c2abb6edd..2a36a2efbd49 100644
--- a/fs/resctrl/psuedo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -19,11 +20,10 @@
 #include <linux/mman.h>
 #include <linux/perf_event.h>
 #include <linux/pm_qos.h>
+#include <linux/resctrl.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include <asm/cacheflush.h>
-#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "internal.h"
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 936fc6e47386..09f120772c48 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -19,6 +19,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
+#include <linux/resctrl.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
@@ -29,7 +30,6 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl.h>
 #include "internal.h"
 
 /* Mutex to protect rdtgroup access. */
@@ -363,17 +363,15 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	struct resctrl_cpu_sync defaults;
-	struct resctrl_cpu_sync *defaults_p = NULL;
+	struct resctrl_cpu_defaults defaults, *p = NULL;
 
 	if (r) {
 		defaults.closid = r->closid;
 		defaults.rmid = r->mon.rmid;
-		defaults_p = &defaults;
+		p = &defaults;
 	}
 
-	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
-			 1);
+	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
@@ -966,7 +964,7 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 }
 
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -976,7 +974,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1092,7 +1090,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 }
 
 static int rdt_min_bw_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			   struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1127,7 +1125,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 }
 
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+			    struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1137,7 +1135,7 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 }
 
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
-			     struct seq_file *seq, void *v)
+				 struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
@@ -1935,7 +1933,6 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_closid_show,
 		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
 	},
-
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
@@ -2161,7 +2158,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 		if (!r->mon_capable)
 			continue;
 
-		fflags =  r->fflags | RFTYPE_MON_INFO;
+		fflags = r->fflags | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
@@ -2449,7 +2446,7 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 	/*
 	 * Choose a width for the resource data based on the resource that has
-	 * widest name and cbm.
+	 * widest name and CBM.
 	 */
 	max_data_width = max(max_data_width, r->data_width);
 
@@ -2499,10 +2496,10 @@ static void schemata_list_destroy(void)
 
 static int rdt_get_tree(struct fs_context *fc)
 {
-	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
+	struct rdt_resource *r;
 	int ret;
 
 	cpus_read_lock();
@@ -2575,7 +2572,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (resctrl_is_mbm_enabled()) {
-		list_for_each_entry(dom, &l3->domains, list)
+		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
 	}
@@ -2669,7 +2667,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx;
 
-	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -3180,7 +3178,6 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			goto out;
 		}
-
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;
@@ -3466,8 +3463,11 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
-	/* Update per cpu rmid of the moved CPUs first */
-	closid = rdtgrp->closid;
+	/*
+	 * Update per cpu closid/rmid of the moved CPUs first.
+	 * Note: the closid will not change, but the arch code still needs it.
+	 */
+	closid = prdtgrp->closid;
 	rmid = prdtgrp->mon.rmid;
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
 		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 00cc0457af50..819007e74ad3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -41,9 +41,6 @@ int proc_resctrl_show(struct seq_file *m,
  */
 #define RESCTRL_MAX_CBM			32
 
-extern unsigned int resctrl_rmid_realloc_limit;
-extern unsigned int resctrl_rmid_realloc_threshold;
-
 /**
  * struct pseudo_lock_region - pseudo-lock region information
  * @s:			Resctrl schema for the resource to which this
@@ -248,24 +245,35 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
-struct resctrl_cpu_sync {
+struct resctrl_cpu_defaults {
 	u32 closid;
 	u32 rmid;
 };
 
 struct resctrl_mon_config_info {
-	struct rdt_resource *r;
-	struct rdt_domain   *d;
-	u32                  evtid;
-	u32                  mon_config;
-	int                  err;
+	struct rdt_resource	*r;
+	struct rdt_domain	*d;
+	u32			evtid;
+	u32			mon_config;
+	int			err;
 };
 
-/*
- * Update and re-load this CPUs defaults. Called via IPI, takes a pointer to
- * struct resctrl_cpu_sync, or NULL.
+/**
+ * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
+ *					 Call via IPI.
+ * @info:	If non-NULL, a pointer to a struct resctrl_cpu_defaults
+ *		specifying the new CLOSID and RMID for tasks in the default
+ *		resctrl ctrl and mon group when running on this CPU.  If NULL,
+ *		this CPU is not re-assigned to a different default group.
+ *
+ * Propagates reassignment of CPUs and/or tasks to different resctrl groups
+ * when requested by the resctrl core code.
+ *
+ * This function records the per-cpu defaults specified by @info (if any),
+ * and then reconfigures the CPU's hardware CLOSID and RMID for subsequent
+ * execution based on @current, in the same way as during a task switch.
  */
-void resctrl_arch_sync_cpu_defaults(void *info);
+void resctrl_arch_sync_cpu_closid_rmid(void *info);
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
@@ -286,9 +294,9 @@ static inline u32 resctrl_get_config_index(u32 closid,
 	case CDP_NONE:
 		return closid;
 	case CDP_CODE:
-			return (closid * 2) + 1;
+		return closid * 2 + 1;
 	case CDP_DATA:
-			return (closid * 2);
+		return closid * 2;
 	}
 }
 
-- 
2.34.1


