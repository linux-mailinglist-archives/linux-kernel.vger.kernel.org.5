Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2C7A400A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbjIRETW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbjIRETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:19:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E6594
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695010749; x=1726546749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1t5Op4Y25SCXDzrsl8r7++ESuI8wEM2tXr6DZwd1tR8=;
  b=FDOik23hMYUcF0F8+wJm5s1MRKiOuUYFQtUg8e3C68a9RNbxVMxMTM+r
   GaLALuHzxN5cb/YO7hkztBF8VSjtlB2C3Lq08S8hnqr0t1aBdabXwBYBG
   Qc2Bq5r5ERitMhjdzzYvKcwny9m3qyLkxpea2CnkIDH0M2692LI8o9cQN
   1yCleZ0FrMiTfKS8wenCLzJGnE5q8maY7CeFn7MhnhpmOcvuWBpKM4N45
   ivydhAMKBpntjvZguxKK71UczmeMmM4Isq6bDfTunCFMcghjULi0VqHTR
   B4Uox8vnlwzq+5pjR76EXH6qASLaNz1FdGH03J7xfTuIIbT4F7rq2pm29
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="443637900"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="443637900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 21:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="745666268"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="745666268"
Received: from ameskel-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.13.217])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 21:19:06 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@intel.com, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, jpoimboe@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com
Subject: [PATCH v2] x86/tdx: Fix __noreturn build warning around __tdx_hypercall_failed()
Date:   Mon, 18 Sep 2023 16:18:58 +1200
Message-ID: <20230918041858.331234-1-kai.huang@intel.com>
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

The __tdx_hypercall_failed() function definition already has __noreturn
annotation, but it turns out the __noreturn must be annotated to the
function declaration.

Quoted from PeterZ:

---
FWIW, the reason being that...

The point of noreturn is that the caller should know to stop generating
code. For that the declaration needs the attribute, because call sites
typically do not have access to the function definition in C.
---

Add __noreturn annotation to the declaration of __tdx_hypercall_failed()
to fix.  It's not a bad idea to document the __noreturn nature at the
definition site either, so keep the annotation at the definition.

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

v1 -> v2:
  - Keep __noreturn annotation in the __tdx_hypercall_failed()
    definition. -Ingo
  - Update changelog to reflect this change.

---
 arch/x86/include/asm/shared/tdx.h | 4 +++-
 tools/objtool/noreturns.h         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

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

