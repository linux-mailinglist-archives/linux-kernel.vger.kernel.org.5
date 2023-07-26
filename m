Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924C7634E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjGZL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjGZL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:27:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F592D44
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370798; x=1721906798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40KByLMTp8k6sZHhPJUX6bhaKm4AmHda05x8GBfUCUk=;
  b=GlTxVDd+AWojUUIwXU7MIMwMhc+3lGJ0Hcp8fQKllvGeaps3ZgYaOV/S
   srJKGpSnaDQ7QDeSX99D7IPSoxGkKrRdcLiBnvUeyr0970r7sPZChcJBt
   Z2Qmhz1BE/lmYMoyI44CL3CGVr+uPSYxL1hH5FNxImc6jdXKzPnCR0NmS
   VyruiKwTxmP9sF5ZToRK8NjpDHsYuqtEpftGl5w1YUdbugBZNqs68KLrg
   pWVHCxetkfgQfJaND2CYkQLVd9gCsKS8LjhlMe4IbDvuZ0PKBK9nLPE7n
   8BZ1LekNGH2dXFPwMOK5Fb910d0c4yNNO1Z4YEvzO630bNeN7JJ5j2Xy+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370664202"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370664202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791811179"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791811179"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:19 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Date:   Wed, 26 Jul 2023 23:25:12 +1200
Message-ID: <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690369495.git.kai.huang@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---

v2 -> v3:
 - Added __seamcall_saved_ret() back for TDH.VP.ENTER, given the new
   patch to adjust 'struct tdx_module_args' layout.

v1 -> v2:
 - Removed __seamcall_saved_ret() and leave it to KVM TDX patches.

---
 arch/x86/Kconfig                 | 12 +++++++
 arch/x86/Makefile                |  2 ++
 arch/x86/include/asm/tdx.h       |  7 ++++
 arch/x86/virt/Makefile           |  2 ++
 arch/x86/virt/vmx/Makefile       |  2 ++
 arch/x86/virt/vmx/tdx/Makefile   |  2 ++
 arch/x86/virt/vmx/tdx/seamcall.S | 61 ++++++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+)
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
index 603e6d1e9d4a..a69bb7d3061b 100644
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
index 000000000000..5b1f2286aea9
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
-- 
2.41.0

