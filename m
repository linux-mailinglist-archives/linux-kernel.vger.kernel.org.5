Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9AB7E947A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjKMCYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjKMCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:24:05 -0500
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40992199E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:24:02 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4STCsp5jGkzMpvS5;
        Mon, 13 Nov 2023 02:23:58 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4STCsn4w8yz3W;
        Mon, 13 Nov 2023 03:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1699842238;
        bh=tY8hlJfPopuy154H09Cr6nqcw/h0DUTJ1/nUw09u9eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bV4lvDvQTCac2IMzSmZNNLVBOtTqAuS2XLzxMp+OAzsv+rke/FG2TXyxhi8G9+60p
         uVBBHLsVIDwfgY2jYAyUCw2LIYtSt/u33MBaH9fX9Ljjyq03aPdOVNbFjYzptoLzUl
         mUsHCWJz6tf9YxVBhc8meVQg8fYV2sX1kdkepvvo=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alexander Graf <graf@amazon.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: [RFC PATCH v2 01/19] virt: Introduce Hypervisor Enforced Kernel Integrity (Heki)
Date:   Sun, 12 Nov 2023 21:23:08 -0500
Message-ID: <20231113022326.24388-2-mic@digikod.net>
In-Reply-To: <20231113022326.24388-1-mic@digikod.net>
References: <20231113022326.24388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes since v1:
* Shrinked this patch to only contain the minimal common parts.
* Moved heki_early_init() to start_kernel().
---
 Kconfig              |  2 ++
 arch/x86/Kconfig     |  1 +
 include/linux/heki.h | 31 +++++++++++++++++++++++++++++++
 init/main.c          |  2 ++
 mm/mm_init.c         |  1 +
 virt/Makefile        |  1 +
 virt/heki/Kconfig    | 19 +++++++++++++++++++
 virt/heki/Makefile   |  3 +++
 virt/heki/common.h   | 16 ++++++++++++++++
 virt/heki/main.c     | 32 ++++++++++++++++++++++++++++++++
 10 files changed, 108 insertions(+)
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
index 66bfabae8814..424f949442bd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -35,6 +35,7 @@ config X86_64
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
index 436d73261810..0d28301c5402 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/heki.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1047,6 +1048,7 @@ void start_kernel(void)
 	uts_ns_init();
 	key_init();
 	security_init();
+	heki_early_init();
 	dbg_late_init();
 	net_ns_init();
 	vfs_caches_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..896977383cc3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/heki.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
diff --git a/virt/Makefile b/virt/Makefile
index 1cfea9436af9..4550dc624466 100644
--- a/virt/Makefile
+++ b/virt/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	+= lib/
+obj-$(CONFIG_HEKI) += heki/
diff --git a/virt/heki/Kconfig b/virt/heki/Kconfig
new file mode 100644
index 000000000000..49695fff6d21
--- /dev/null
+++ b/virt/heki/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Hypervisor Enforced Kernel Integrity (Heki)
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
+config ARCH_SUPPORTS_HEKI
+	bool "Architecture support for Heki"
+	help
+	  An architecture should select this when it can successfully build
+	  and run with CONFIG_HEKI. That is, it should provide all of the
+	  architecture support required for the HEKI feature.
diff --git a/virt/heki/Makefile b/virt/heki/Makefile
new file mode 100644
index 000000000000..354e567df71c
--- /dev/null
+++ b/virt/heki/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += main.o
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
index 000000000000..f005dd74d586
--- /dev/null
+++ b/virt/heki/main.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hypervisor Enforced Kernel Integrity (Heki) - Common code
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#include <linux/heki.h>
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
+	if (strtobool(str, &heki_enabled))
+		pr_warn("Invalid option string for heki: '%s'\n", str);
+	return 1;
+}
+__setup("heki=", heki_parse_config);
-- 
2.42.1

