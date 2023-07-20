Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD775AE66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGTMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGTMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:30:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403626B6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856184; x=1721392184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHZ0FywoL6GHQSxStJeG6h3JzNebQDQCOCElqEWoHTE=;
  b=JETPl4yRonKglOpxQ8Q5kMuxN7dc1QvNwmMMWYMqpphkoH3QBiR0qdgF
   VAslkvvFVD9FrfqXYs1OSqr9GVpU0CHgtiRcwrh7L6dRgfO2TpXj4gjGH
   KMo0XGfN8oV2dh60h6bbaAOlvrdOxERzXpPvfgi3fuQPDfNyxYy+ij4XD
   Q2ANCF9JryCOfYIZTThGSFsN65u++avv4M7F7ne+ZcLIKxtjVrImiqaHH
   75mv+wjeCFperkKj1Xc+bebWlRAChzhyQkFuuLjpPaJMpFZxQC9ulEd7l
   Sdf4LgrMh9jfAWDEaQLHLNPesQSOsl7swSOpAk1kzRFGl5vl3Qoj53am0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356678149"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356678149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255985"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255985"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:24 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 10/11] x86/virt/tdx: Wire up basic SEAMCALL functions
Date:   Fri, 21 Jul 2023 00:28:13 +1200
Message-ID: <7fc21bf2cc330c5c3c88c99d12a69240a97db36c.1689855280.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689855280.git.kai.huang@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
the TDX module initialization, which is the first step of TDX support.

To start to support TDX, create a new arch/x86/virt/vmx/tdx/tdx.c for
TDX host kernel support.  Add a new Kconfig option CONFIG_INTEL_TDX_HOST
to opt-in TDX host kernel support (to distinguish with TDX guest kernel
support).  So far only KVM uses TDX.  Make the new config option depend
on KVM_INTEL.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - Removed __seamcall_saved_ret() and leave it to KVM TDX patches.

---
 arch/x86/Kconfig                 | 12 +++++++++
 arch/x86/Makefile                |  2 ++
 arch/x86/include/asm/tdx.h       |  6 +++++
 arch/x86/virt/Makefile           |  2 ++
 arch/x86/virt/vmx/Makefile       |  2 ++
 arch/x86/virt/vmx/tdx/Makefile   |  2 ++
 arch/x86/virt/vmx/tdx/seamcall.S | 42 ++++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7422db409770..0558dd98abd7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1949,6 +1949,18 @@ config X86_SGX
 
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
index fdc2e3abd615..5d8d1892aae9 100644
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
index 603e6d1e9d4a..942edc8e9ba8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,5 +72,11 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 	return -ENODEV;
 }
 #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
+
+#ifdef CONFIG_INTEL_TDX_HOST
+u64 __seamcall(u64 fn, struct tdx_module_args *args);
+u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
+#endif	/* CONFIG_INTEL_TDX_HOST */
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/virt/Makefile b/arch/x86/virt/Makefile
new file mode 100644
index 000000000000..1e36502cd738
--- /dev/null
+++ b/arch/x86/virt/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y	+= vmx/
diff --git a/arch/x86/virt/vmx/Makefile b/arch/x86/virt/vmx/Makefile
new file mode 100644
index 000000000000..feebda21d793
--- /dev/null
+++ b/arch/x86/virt/vmx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_INTEL_TDX_HOST)	+= tdx/
diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
new file mode 100644
index 000000000000..46ef8f73aebb
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += seamcall.o
diff --git a/arch/x86/virt/vmx/tdx/seamcall.S b/arch/x86/virt/vmx/tdx/seamcall.S
new file mode 100644
index 000000000000..b32934837f16
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamcall.S
@@ -0,0 +1,42 @@
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
+ * (the P-SEAMLDR or the TDX module), with saving RCX/RDX/R8-R11
+ * output registers to the 'struct tdx_module_args' used as input.
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
-- 
2.41.0

