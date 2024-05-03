Return-Path: <linux-kernel+bounces-167695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B18BAD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FD1F22C04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8015444E;
	Fri,  3 May 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NvcPqXJF"
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AE153BEC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742365; cv=none; b=aTB9vQkLE5/kioBIo0x3ujHX9Q8xm2KFnfKHaQLFg3emtcKlwa/87YQUQSdaEKL/cp/MwPywgz/w/3pTbXN3pBmkx0yh4YH3SSZGD4kPMUJiCX5zImjOa+42UwQZavjo0U3gmS+VJ/usXXU40ef6l47NdC0RZ4sMAuf9aevtxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742365; c=relaxed/simple;
	bh=obtQipiNRMFv28P9TKvF5pV8leBuQgSBtBcEQW3pxVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBGCS9oH+qLnv/s7j/uai8CPlg3xX+BNLDYwfPR9gr7+cDu2Sw2FdQrruoqFebPtQm/BBKvt9fDAXmj4gC50+/EMbA95HEJUOLYEYc+ZG1lkSeqb7opRP1yn+vBVaXfCbCcP5kQiKLym+8ccNTnykD8N3jDZ6rOSeyIyi0V0KFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NvcPqXJF; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VWBGc2g3hzS10;
	Fri,  3 May 2024 15:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714742360;
	bh=obtQipiNRMFv28P9TKvF5pV8leBuQgSBtBcEQW3pxVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvcPqXJFBA2qsjuhqiLltCK88ANNHdMNpuz17Tcd63LbmHTm/KkiZOaiSif0w7f+4
	 cftpGAbztXjbX5M6Zeun4BIRd81twRoYYKlWzYdwI+wJzU1gYbqcjIInB4q/5H0LNP
	 PPfyGOD1eQbV3Tnb/7BmebaPzISSc/RgHtpbrUuw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VWBGb2zTRzbPY;
	Fri,  3 May 2024 15:19:19 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Alexander Graf <graf@amazon.com>,
	Angelina Vu <angelinavu@linux.microsoft.com>,
	Anna Trikalinou <atrikalinou@microsoft.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Forrest Yuan Yu <yuanyu@google.com>,
	James Gowans <jgowans@amazon.com>,
	James Morris <jamorris@linux.microsoft.com>,
	John Andersen <john.s.andersen@intel.com>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marian Rotariu <marian.c.rotariu@gmail.com>,
	=?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
	=?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	=?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>,
	dev@lists.cloudhypervisor.org,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC PATCH v3 1/5] virt: Introduce Hypervisor Enforced Kernel Integrity (Heki)
Date: Fri,  3 May 2024 15:19:06 +0200
Message-ID: <20240503131910.307630-2-mic@digikod.net>
In-Reply-To: <20240503131910.307630-1-mic@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>

Hypervisor Enforced Kernel Integrity (Heki) is a feature that will use
the hypervisor to enhance guest virtual machine security.

Implement minimal code to introduce Heki:

- Define the config variables.

- Define a kernel command line parameter "heki" to turn the feature
  on or off. By default, Heki is on.

- Define heki_early_init() and call it in start_kernel(). Currently,
  this function only prints the value of the "heki" command
  line parameter.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240503131910.307630-2-mic@digikod.net
---

Changes since v2:
* Move CONFIG_HEKI under a new CONFIG_HEKI_MENU to group it with the
  test configuration (see following patches).
* Hide CONFIG_ARCH_SUPPORS_HEKI from users.

Changes since v1:
* Shrinked this patch to only contain the minimal common parts.
* Moved heki_early_init() to start_kernel().
* Use kstrtobool().
---
 Kconfig              |  2 ++
 arch/x86/Kconfig     |  1 +
 include/linux/heki.h | 31 +++++++++++++++++++++++++++++++
 init/main.c          |  2 ++
 mm/mm_init.c         |  1 +
 virt/Makefile        |  1 +
 virt/heki/Kconfig    | 25 +++++++++++++++++++++++++
 virt/heki/Makefile   |  3 +++
 virt/heki/common.h   | 16 ++++++++++++++++
 virt/heki/main.c     | 33 +++++++++++++++++++++++++++++++++
 10 files changed, 115 insertions(+)
 create mode 100644 include/linux/heki.h
 create mode 100644 virt/heki/Kconfig
 create mode 100644 virt/heki/Makefile
 create mode 100644 virt/heki/common.h
 create mode 100644 virt/heki/main.c

diff --git a/Kconfig b/Kconfig
index 745bc773f567..0c844d9bcb03 100644
--- a/Kconfig
+++ b/Kconfig
@@ -29,4 +29,6 @@ source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
 
+source "virt/heki/Kconfig"
+
 source "Documentation/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 928820e61cb5..d2fba63c289b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select ARCH_SUPPORTS_HEKI
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/include/linux/heki.h b/include/linux/heki.h
new file mode 100644
index 000000000000..4c18d2283392
--- /dev/null
+++ b/include/linux/heki.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Hypervisor Enforced Kernel Integrity (Heki) - Definitions
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#ifndef __HEKI_H__
+#define __HEKI_H__
+
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+
+#ifdef CONFIG_HEKI
+
+extern bool heki_enabled;
+
+void heki_early_init(void);
+
+#else /* !CONFIG_HEKI */
+
+static inline void heki_early_init(void)
+{
+}
+
+#endif /* CONFIG_HEKI */
+
+#endif /* __HEKI_H__ */
diff --git a/init/main.c b/init/main.c
index 5dcf5274c09c..bec2c8d939aa 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,7 @@
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
+#include <linux/heki.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1059,6 +1060,7 @@ void start_kernel(void)
 	uts_ns_init();
 	key_init();
 	security_init();
+	heki_early_init();
 	dbg_late_init();
 	net_ns_init();
 	vfs_caches_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..89d9f97bd471 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
+#include <linux/heki.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
diff --git a/virt/Makefile b/virt/Makefile
index 1cfea9436af9..856b5ccedb5a 100644
--- a/virt/Makefile
+++ b/virt/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	+= lib/
+obj-$(CONFIG_HEKI_MENU) += heki/
diff --git a/virt/heki/Kconfig b/virt/heki/Kconfig
new file mode 100644
index 000000000000..66e73d212856
--- /dev/null
+++ b/virt/heki/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Hypervisor Enforced Kernel Integrity (Heki)
+
+config ARCH_SUPPORTS_HEKI
+	bool
+	# An architecture should select this when it can successfully build
+	# and run with CONFIG_HEKI. That is, it should provide all of the
+	# architecture support required for the HEKI feature.
+
+menuconfig HEKI_MENU
+	bool "Virtualization hardening"
+
+if HEKI_MENU
+
+config HEKI
+	bool "Hypervisor Enforced Kernel Integrity (Heki)"
+	depends on ARCH_SUPPORTS_HEKI
+	help
+	  This feature enhances guest virtual machine security by taking
+	  advantage of security features provided by the hypervisor for guests.
+	  This feature is helpful in maintaining guest virtual machine security
+	  even after the guest kernel has been compromised.
+
+endif
diff --git a/virt/heki/Makefile b/virt/heki/Makefile
new file mode 100644
index 000000000000..8b10e73a154b
--- /dev/null
+++ b/virt/heki/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_HEKI) += main.o
diff --git a/virt/heki/common.h b/virt/heki/common.h
new file mode 100644
index 000000000000..edd98fc650a8
--- /dev/null
+++ b/virt/heki/common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Hypervisor Enforced Kernel Integrity (Heki) - Common header
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#ifndef _HEKI_COMMON_H
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "heki-guest: " fmt
+
+#endif /* _HEKI_COMMON_H */
diff --git a/virt/heki/main.c b/virt/heki/main.c
new file mode 100644
index 000000000000..25c25f5700f7
--- /dev/null
+++ b/virt/heki/main.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hypervisor Enforced Kernel Integrity (Heki) - Common code
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#include <linux/heki.h>
+#include <linux/kstrtox.h>
+
+#include "common.h"
+
+bool heki_enabled __ro_after_init = true;
+
+/*
+ * Must be called after kmem_cache_init().
+ */
+__init void heki_early_init(void)
+{
+	if (!heki_enabled) {
+		pr_warn("Heki is not enabled\n");
+		return;
+	}
+	pr_warn("Heki is enabled\n");
+}
+
+static int __init heki_parse_config(char *str)
+{
+	if (kstrtobool(str, &heki_enabled))
+		pr_warn("Invalid option string for heki: '%s'\n", str);
+	return 1;
+}
+__setup("heki=", heki_parse_config);
-- 
2.45.0


