Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA097A1E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIOMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjIOMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:12:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197CB1FE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694779946; x=1726315946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbLu9YReunGR8j0xB5Ol2fNWbNXS0dFnH+Gp5Nd2CtE=;
  b=bzE1hD3zl7mDk4ajbv5bhqZ3D9k5DrM8TKhdmIORaobe8zqw3wey04+T
   3TjItjP2bn7+DRuhvUnQyTG7yFv9LoLj3E2o5XWTrtUKzdec3D7+Ulgl+
   Q3ye6oPD2Uw2F3GFLjvos8GGaEeiPTmJlyREATr13YkueaxEdLb5MeboP
   7TPNqEz+om8ttSdosQGcGpKOxArVLsmy1pdRg60Tme/3sNAOuDRcz1wl0
   UYb8ZtBGC6NYnwCDWkNeUlIoAmfMXDN7+m1mvt2ukOS68VyjA6XUtsNBu
   PtwswqoLI7aMJSVOrmxzwH5avbpcHvbDWXy5Zcp4KOf5PasoOQ+cLJXV1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359490514"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="359490514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="835190196"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="835190196"
Received: from siyenga2-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.44.31])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:12:22 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@intel.com, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, jpoimboe@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com
Subject: [PATCH] x86/tdx: Fix __noreturn build warning around __tdx_hypercall_failed()
Date:   Sat, 16 Sep 2023 00:12:08 +1200
Message-ID: <20230915121208.307807-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reported below build warning:

  vmlinux.o: warning: objtool: __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn annotation

Turns out the __noreturn must be annotated to the function declaration
but not the function body.

Quoted from PeterZ:

---
FWIW, the reason being that...

The point of noreturn is that the caller should know to stop generating
code. For that the declaration needs the attribute, because call sites
typically do not have access to the function definition in C.
---

Fix by moving __noreturn annotation from the __tdx_hypercall_failed()
body to its declaration, which is in <asm/shared/tdx.h>.

Note <asm/shared/tdx.h> is also included by TDX related assembly files.
Include <linux/compiler_attributes.h> only in case of !__ASSEMBLY__
otherwise compiling assembly file would trigger build error.

Also, following the objtool documentation, add __tdx_hypercall_failed()
to "tools/objtool/noreturns.h".

Fixes: c641cfb5c157 ("x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309140828.9RdmlH2Z-lkp@intel.com/
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 2 +-
 arch/x86/include/asm/shared/tdx.h | 4 +++-
 tools/objtool/noreturns.h         | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2199cf..4710d8dd700b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,7 +38,7 @@
 #define TDREPORT_SUBTYPE_0	0
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
-noinstr void __noreturn __tdx_hypercall_failed(void)
+noinstr void __tdx_hypercall_failed(void)
 {
 	instrumentation_begin();
 	panic("TDVMCALL failed. TDX module bug?");
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index b69886ee1c63..f74695dea217 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -56,6 +56,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler_attributes.h>
+
 /*
  * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
@@ -108,7 +110,7 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
-void __tdx_hypercall_failed(void);
+void __noreturn __tdx_hypercall_failed(void);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index e45c7cb1d5bc..875f8827aa33 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -11,6 +11,7 @@ NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
+NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)

base-commit: 7b804135d4d1f0a2b9dda69c6303d3f2dcbe9d37
-- 
2.41.0

