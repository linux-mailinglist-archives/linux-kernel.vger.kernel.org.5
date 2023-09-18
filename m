Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7297A4289
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbjIRHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjIRHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:31:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9154195;
        Mon, 18 Sep 2023 00:31:01 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695022259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw/z5xmnc07wtu1+lFgx8dID9+9DKBbCaChZCJLWAWg=;
        b=T5sFB8sHB0u/f550qRxWRY3WIZz18SghodOITU1AP29laB9I9BstjCfBuHSK5qwvsU+qZB
        uIq/Nr0tUm+Xh61hIor49Juyw+IyH1FKkUlr8aNMzti1NEPDhTx+4lEKR4LEuLp2AVUvlO
        Ym6Jap++nGQ4Q2qiyOXA3Lhc/ikpdiTUI0WN21ELWrO+4N20IMaA+RsjgXhixrNluYmXtp
        ewBE2tz35Nm+pRl7WnMdWzTnc8dxN+SIoCAVje+shUq26Hq+TGAUtYfUpa8hPSjaFUF/d4
        91Xg7IME6myGH5PNqq5Oq4v9DIWGDQfpMCZ8sW6+xT6fF1Q1qQmrkiz3RvvmCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695022259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw/z5xmnc07wtu1+lFgx8dID9+9DKBbCaChZCJLWAWg=;
        b=uihGSowKdKWW4ahDZQ4bxKRwLNnzkHeuIzmYGTeTUtMqsu9Cp4WB+WCHzGkRV2HUFEC39H
        GQ/n3nDw/tnSHdDQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix __noreturn build warning around
 __tdx_hypercall_failed()
Cc:     kernel test robot <lkp@intel.com>, Kai Huang <kai.huang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918041858.331234-1-kai.huang@intel.com>
References: <20230918041858.331234-1-kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <169502225930.27769.2712335854456524871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     518755a7eeae77a399430eaf211a1e71f6b87d4a
Gitweb:        https://git.kernel.org/tip/518755a7eeae77a399430eaf211a1e71f6b87d4a
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 18 Sep 2023 16:18:58 +12:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 09:11:39 +02:00

x86/tdx: Fix __noreturn build warning around __tdx_hypercall_failed()

LKP reported below build warning:

  vmlinux.o: warning: objtool: __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn annotation

The __tdx_hypercall_failed() function definition already has __noreturn
annotation, but it turns out the __noreturn must be annotated to the
function declaration.

PeterZ explains:

  "FWIW, the reason being that...

   The point of noreturn is that the caller should know to stop generating
   code. For that the declaration needs the attribute, because call sites
   typically do not have access to the function definition in C."

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
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230918041858.331234-1-kai.huang@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202309140828.9RdmlH2Z-lkp@intel.com/
---
 arch/x86/include/asm/shared/tdx.h | 4 +++-
 tools/objtool/noreturns.h         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index b69886e..f74695d 100644
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
index e45c7cb..875f882 100644
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
