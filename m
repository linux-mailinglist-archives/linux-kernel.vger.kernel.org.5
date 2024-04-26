Return-Path: <linux-kernel+bounces-160247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3048B3AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EA11C21E67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C5172795;
	Fri, 26 Apr 2024 15:10:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A1172BA4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144245; cv=none; b=q5dLBU7mmV1pxDjY6Bu3u+4umZkpYtlYQ8xlaIVjQrn6Gl0PnldcZAqmAeFNPLuGXfbcqIy5iSljw5c+Vynz7NAPqyRcVF5/j857P28X9lmNhb5pspbiTWBwZEtToj2SFyDbxx56nnJmF77Tb/VD14XliFyxNHwg+5/aXox2spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144245; c=relaxed/simple;
	bh=BGWeY7JMLFjQFIgVkyGj6dZ8aGDMdUiZ0RGZ5oa3prk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fI0GHMdSC6XZScZelNtfWj1yJeGAJz7JZFxQWbRC/jKSfhp1KwpfEPtNTfWY2HkOqwUX1KZOLiBc5DrKSgVfc92hM7fxc0WypkFFSjaG8ytJ/lTmoanQLOk6TsVh/nKgbkzPJa/J9zu0JhkYS1saCH2Qb1FAIE0GSYF5Mcn/W8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237C715DB;
	Fri, 26 Apr 2024 08:11:11 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FCAD3F73F;
	Fri, 26 Apr 2024 08:10:40 -0700 (PDT)
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
Subject: [PATCH v2 29/35] fs/resctrl: Add boiler plate for external resctrl code
Date: Fri, 26 Apr 2024 16:08:58 +0100
Message-Id: <20240426150904.8854-29-Dave.Martin@arm.com>
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

Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
for the common parts of the resctrl interface and make X86_CPU_RESCTRL
depend on this.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: Dave Martin, James Morse (et al.):

 * Review the new Kconfig RESCTRL_FS help text.

 * Because RESCTRL_FS combines a userspace interface and a kernel
   library providing services to its own backends, there is a circular
   dependency between this option and the arch-specific options
   (CONFIG_X86_RESCTRL and eventually CONFIG_ARM64_MPAM) that
   nastifies the presentation of these options in Kconfig.

   Can this be improved?

   The current situation works, but is not very user-friendly for
   menuconfig users.

Changes in v2:

 * Rename new file psuedo_lock.c to pseudo_lock.c, to match the name
   of the original file (and to be less surprising).

 * [Whitespace only] Under RESCTRL_FS in fs/resctrl/Kconfig, delete
   alignment space in orphaned select ... if (which has nothing to line
   up with any more).

 * [Whitespace only] Reflow and re-tab Kconfig additions.
---
 MAINTAINERS              |  1 +
 arch/Kconfig             |  8 ++++++++
 arch/x86/Kconfig         | 10 +++-------
 fs/Kconfig               |  1 +
 fs/Makefile              |  1 +
 fs/resctrl/Kconfig       | 36 ++++++++++++++++++++++++++++++++++++
 fs/resctrl/Makefile      |  3 +++
 fs/resctrl/ctrlmondata.c |  0
 fs/resctrl/internal.h    |  0
 fs/resctrl/monitor.c     |  0
 fs/resctrl/pseudo_lock.c |  0
 fs/resctrl/rdtgroup.c    |  0
 include/linux/resctrl.h  |  4 ++++
 13 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5621dd823e79..c49090e9c777 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18543,6 +18543,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	fs/resctrl/
 F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index fd18b7db2c77..f163964e6915 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
 config ARCH_HAS_PHYS_TO_DMA
 	bool
 
+config ARCH_HAS_CPU_RESCTRL
+	bool
+	help
+	  An architecture selects this option to indicate that the necessary
+	  hooks are provided to support the common memory system usage
+	  monitoring and control interfaces provided by the 'resctrl'
+	  filesystem (see RESCTRL_FS).
+
 config HAVE_ARCH_COMPILER_H
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e071e564452e..cb043543f088 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -479,8 +479,10 @@ config GOLDFISH
 config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
+	depends on MISC_FILESYSTEMS
 	select KERNFS
-	select PROC_CPU_RESCTRL		if PROC_FS
+	select ARCH_HAS_CPU_RESCTRL
+	select RESCTRL_FS
 	select RESCTRL_FS_PSEUDO_LOCK
 	help
 	  Enable x86 CPU resource control support.
@@ -507,12 +509,6 @@ config X86_FRED
 	  ring transitions and exception/interrupt handling if the
 	  system supports.
 
-config RESCTRL_FS_PSEUDO_LOCK
-	bool
-	help
-	  Software mechanism to pin data in a cache portion using
-	  micro-architecture specific knowledge.
-
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..d8a36383b6dc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
 source "fs/hpfs/Kconfig"
 source "fs/qnx4/Kconfig"
 source "fs/qnx6/Kconfig"
+source "fs/resctrl/Kconfig"
 source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..da6e2d028722 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
new file mode 100644
index 000000000000..a5fbda54d32f
--- /dev/null
+++ b/fs/resctrl/Kconfig
@@ -0,0 +1,36 @@
+config RESCTRL_FS
+	bool "CPU Resource Control Filesystem (resctrl)"
+	depends on ARCH_HAS_CPU_RESCTRL
+	select KERNFS
+	select PROC_CPU_RESCTRL if PROC_FS
+	help
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
+
+config RESCTRL_FS_PSEUDO_LOCK
+	bool
+	help
+	  Software mechanism to pin data in a cache portion using
+	  micro-architecture specific knowledge.
+
+config RESCTRL_RMID_DEPENDS_ON_CLOSID
+	bool
+	help
+	  Enable by the architecture when the RMID values depend on the CLOSID.
+	  This causes the closid allocator to search for CLOSID with clean
+	  RMID.
diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
new file mode 100644
index 000000000000..ee8c4463317a
--- /dev/null
+++ b/fs/resctrl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 189e6dbce33c..819007e74ad3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -8,6 +8,10 @@
 #include <linux/pid.h>
 #include <linux/resctrl_types.h>
 
+#ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
+#include <asm/resctrl.h>
+#endif
+
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
 #define RESCTRL_RESERVED_RMID		0
-- 
2.34.1


