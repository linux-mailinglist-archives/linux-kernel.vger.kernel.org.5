Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E507179D4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjILPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjILPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9810DE;
        Tue, 12 Sep 2023 08:32:03 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w9ujJ/ECpmT/cspIEF/l4cVXzkbUhh6BqfP7tnfCMgQ=;
        b=19B8nFdhiOZcS/k3DMwffQ3EoaYj3FTekhLOOJvcWD/CrNe6VoHmcKzjmq6NwqWlDyJy4a
        zIlaqHHl9zYooQYr2CyMAVN0QbaUVP/r2zCDBpxixh+Xa+NMUXGgnyUCHjA9m3J4k13D4H
        FZd05fwHeVYMbD7zd8fAy6nt9s3sCHNh1OINqX9j6bTl/Mxs6qNyIXdayuqWwWm4zdq4dW
        YkjsnDWomFT+nuSGd4nh9JKwUaXiY6znNftm3dTduWzUBTUl1xFHzFNFF0NkeSP4QlCa/j
        ex3JDYoylJkSM+AStpgOkrw14MNB6wLkHPdVQ4pQhtD8dEFyZzhZZyjJT5IqnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w9ujJ/ECpmT/cspIEF/l4cVXzkbUhh6BqfP7tnfCMgQ=;
        b=q0ixVKLJK/bvJrYQbXTnO2AdvW/pdN6WLmmL4BQYYpCDqHUoE3dCke+0482478ElIbLDIU
        /jPgyVVX0eJ8wZCg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Wire up basic SEAMCALL functions
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272074.27769.5159004500508606691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     7aeb2aca7ace02d6f4f9f8cd44bf26dc44b2feb0
Gitweb:        https://git.kernel.org/tip/7aeb2aca7ace02d6f4f9f8cd44bf26dc44b2feb0
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:04 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:34:54 -07:00

x86/virt/tdx: Wire up basic SEAMCALL functions

Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
host and certain physical attacks.  A CPU-attested software module
called 'the TDX module' runs inside a new isolated memory range as a
trusted hypervisor to manage and run protected VMs.

TDX introduces a new CPU mode: Secure Arbitration Mode (SEAM).  This
mode runs only the TDX module itself or other code to load the TDX
module.

The host kernel communicates with SEAM software via a new SEAMCALL
instruction.  This is conceptually similar to a guest->host hypercall,
except it is made from the host to SEAM software instead.  The TDX
module establishes a new SEAMCALL ABI which allows the host to
initialize the module and to manage VMs.

The SEAMCALL ABI is very similar to the TDCALL ABI and leverages much
TDCALL infrastructure.  Wire up basic functions to make SEAMCALLs for
the basic support of running TDX guests: __seamcall(), __seamcall_ret(),
and __seamcall_saved_ret() for TDH.VP.ENTER.  All SEAMCALLs involved in
the basic TDX support don't use "callee-saved" registers as input and
output, except the TDH.VP.ENTER.

To start to support TDX, create a new arch/x86/virt/vmx/tdx/tdx.c for
TDX host kernel support.  Add a new Kconfig option CONFIG_INTEL_TDX_HOST
to opt-in TDX host kernel support (to distinguish with TDX guest kernel
support).  So far only KVM uses TDX.  Make the new config option depend
on KVM_INTEL.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Link: https://lore.kernel.org/all/4db7c3fc085e6af12acc2932294254ddb3d320b3.1692096753.git.kai.huang%40intel.com
---
 arch/x86/Kconfig                 | 12 ++++++-
 arch/x86/Makefile                |  2 +-
 arch/x86/include/asm/tdx.h       |  7 ++++-
 arch/x86/virt/Makefile           |  2 +-
 arch/x86/virt/vmx/Makefile       |  2 +-
 arch/x86/virt/vmx/tdx/Makefile   |  2 +-
 arch/x86/virt/vmx/tdx/seamcall.S | 61 +++++++++++++++++++++++++++++++-
 7 files changed, 88 insertions(+)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777..3b3594f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1939,6 +1939,18 @@ config X86_USER_SHADOW_STACK
 
 	  If unsure, say N.
 
+config INTEL_TDX_HOST
+	bool "Intel Trust Domain Extensions (TDX) host support"
+	depends on CPU_SUP_INTEL
+	depends on X86_64
+	depends on KVM_INTEL
+	help
+	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
+	  host and certain physical attacks.  This option enables necessary TDX
+	  support in the host kernel to run confidential VMs.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5bfe5ca..d43981a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -252,6 +252,8 @@ archheaders:
 
 libs-y  += arch/x86/lib/
 
+core-y += arch/x86/virt/
+
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
 drivers-$(CONFIG_PCI)            += arch/x86/pci/
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 603e6d1..a69bb7d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,5 +72,12 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 	return -ENODEV;
 }
 #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
+
+#ifdef CONFIG_INTEL_TDX_HOST
+u64 __seamcall(u64 fn, struct tdx_module_args *args);
+u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
+u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
+#endif	/* CONFIG_INTEL_TDX_HOST */
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/virt/Makefile b/arch/x86/virt/Makefile
new file mode 100644
index 0000000..1e36502
--- /dev/null
+++ b/arch/x86/virt/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y	+= vmx/
diff --git a/arch/x86/virt/vmx/Makefile b/arch/x86/virt/vmx/Makefile
new file mode 100644
index 0000000..feebda2
--- /dev/null
+++ b/arch/x86/virt/vmx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_INTEL_TDX_HOST)	+= tdx/
diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
new file mode 100644
index 0000000..46ef8f7
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += seamcall.o
diff --git a/arch/x86/virt/vmx/tdx/seamcall.S b/arch/x86/virt/vmx/tdx/seamcall.S
new file mode 100644
index 0000000..5b1f228
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamcall.S
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+#include "tdxcall.S"
+
+/*
+ * __seamcall() - Host-side interface functions to SEAM software
+ * (the P-SEAMLDR or the TDX module).
+ *
+ * __seamcall() function ABI:
+ *
+ * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
+ * @args (RSI)  - struct tdx_module_args for input
+ *
+ * Only RCX/RDX/R8-R11 are used as input registers.
+ *
+ * Return (via RAX) TDX_SEAMCALL_VMFAILINVALID if the SEAMCALL itself
+ * fails, or the completion status of the SEAMCALL leaf function.
+ */
+SYM_FUNC_START(__seamcall)
+	TDX_MODULE_CALL host=1
+SYM_FUNC_END(__seamcall)
+
+/*
+ * __seamcall_ret() - Host-side interface functions to SEAM software
+ * (the P-SEAMLDR or the TDX module), with saving output registers to
+ * the 'struct tdx_module_args' used as input.
+ *
+ * __seamcall_ret() function ABI:
+ *
+ * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
+ * @args (RSI)  - struct tdx_module_args for input and output
+ *
+ * Only RCX/RDX/R8-R11 are used as input/output registers.
+ *
+ * Return (via RAX) TDX_SEAMCALL_VMFAILINVALID if the SEAMCALL itself
+ * fails, or the completion status of the SEAMCALL leaf function.
+ */
+SYM_FUNC_START(__seamcall_ret)
+	TDX_MODULE_CALL host=1 ret=1
+SYM_FUNC_END(__seamcall_ret)
+
+/*
+ * __seamcall_saved_ret() - Host-side interface functions to SEAM software
+ * (the P-SEAMLDR or the TDX module), with saving output registers to the
+ * 'struct tdx_module_args' used as input.
+ *
+ * __seamcall_saved_ret() function ABI:
+ *
+ * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
+ * @args (RSI)  - struct tdx_module_args for input and output
+ *
+ * All registers in @args are used as input/output registers.
+ *
+ * Return (via RAX) TDX_SEAMCALL_VMFAILINVALID if the SEAMCALL itself
+ * fails, or the completion status of the SEAMCALL leaf function.
+ */
+SYM_FUNC_START(__seamcall_saved_ret)
+	TDX_MODULE_CALL host=1 ret=1 saved=1
+SYM_FUNC_END(__seamcall_saved_ret)
