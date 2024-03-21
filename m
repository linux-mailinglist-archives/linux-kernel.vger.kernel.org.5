Return-Path: <linux-kernel+bounces-110446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE4885F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15451C2374F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5D143C47;
	Thu, 21 Mar 2024 16:53:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E73143C49
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039985; cv=none; b=OFazJh/Q5J3P4ZndwXuM//7QFsbjtj8GGovgT4RcGP90/+5OoWhKw6Y16C29QyhLFWymCANXaJb+a6XVvZ9AJDhbRtSu2xj9RH/f+5MuMhrVhZc751dcinNUODYdKwtdSv9KtWPbyfgkslt58sQfRStoYoaXFmkOl2Vh5QCjjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039985; c=relaxed/simple;
	bh=jCAO9dchJ71yAoq6atsFXJhEsuUU41WtQQOql/0I894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrex4a6qXuj6xW8c26XMDPyexWdzdP+IT3phhLfm7A4YH9N/jYgSTuSo5mT6ZCk77uPFbTXoeuYTR/J+Q/C5dVqmE+0B5CwtYvxlQ9O40LQ4RYQ5PoxW19ljnvaQcD0oeNt4+PorbId1stw/rN0DGKQ8aBF50rVz8azLultLBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CB01688;
	Thu, 21 Mar 2024 09:53:37 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 850C53F67D;
	Thu, 21 Mar 2024 09:53:00 -0700 (PDT)
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
Subject: [PATCH v1 29/31] fs/resctrl: Add boiler plate for external resctrl code
Date: Thu, 21 Mar 2024 16:51:04 +0000
Message-Id: <20240321165106.31602-30-james.morse@arm.com>
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

Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
for the common parts of the resctrl interface and make X86_CPU_RESCTRL
depend on this.

Signed-off-by: James Morse <james.morse@arm.com>
---
 MAINTAINERS              |  1 +
 arch/Kconfig             |  8 ++++++++
 arch/x86/Kconfig         | 10 +++-------
 fs/Kconfig               |  1 +
 fs/Makefile              |  1 +
 fs/resctrl/Kconfig       | 23 +++++++++++++++++++++++
 fs/resctrl/Makefile      |  3 +++
 fs/resctrl/ctrlmondata.c |  0
 fs/resctrl/internal.h    |  0
 fs/resctrl/monitor.c     |  0
 fs/resctrl/psuedo_lock.c |  0
 fs/resctrl/rdtgroup.c    |  0
 include/linux/resctrl.h  |  4 ++++
 13 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/psuedo_lock.c
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
index fd18b7db2c77..131d874d6738 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
 config ARCH_HAS_PHYS_TO_DMA
 	bool
 
+config ARCH_HAS_CPU_RESCTRL
+	bool
+	help
+	  The 'resctrl' filesystem allows CPU controls of shared resources
+	  such as caches and memory bandwidth to be configured. An architecture
+	  selects this if it provides the arch-specific hooks for the filesystem
+	  and needs the per-task CLOSID/RMID properties.
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
index 000000000000..36a1ddbe6c21
--- /dev/null
+++ b/fs/resctrl/Kconfig
@@ -0,0 +1,23 @@
+config RESCTRL_FS
+	bool "CPU Resource Control Filesystem (resctrl)"
+	depends on ARCH_HAS_CPU_RESCTRL
+	select KERNFS
+	select PROC_CPU_RESCTRL               if PROC_FS
+	help
+	  Resctrl is a filesystem interface
+	  to control allocation and
+	  monitoring of system resources
+	  used by the CPUs.
+
+config RESCTRL_FS_PSEUDO_LOCK
+	bool
+	help
+          Software mechanism to pin data in a cache portion using
+          micro-architecture specific knowledge.
+
+config RESCTRL_RMID_DEPENDS_ON_CLOSID
+	bool
+	help
+	  Enable by the architecture when the RMID values depend on the CLOSID.
+	  This causes the closid allocator to search for CLOSID with clean
+	  RMID.
diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
new file mode 100644
index 000000000000..10fcfb0fdb10
--- /dev/null
+++ b/fs/resctrl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= psuedo_lock.o
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/psuedo_lock.c b/fs/resctrl/psuedo_lock.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5da55e58f229..f786ffceeda3 100644
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
2.39.2


