Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0C77C37F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjHNWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjHNWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513251719;
        Mon, 14 Aug 2023 15:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EA56186D;
        Mon, 14 Aug 2023 22:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D29C433CA;
        Mon, 14 Aug 2023 22:31:11 +0000 (UTC)
Date:   Tue, 15 Aug 2023 00:31:09 +0200
From:   Helge Deller <deller@gmx.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] lockdep: Fix static memory detection even more
Message-ID: <ZNqrLRaOi/3wPAdp@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the parisc architecture, lockdep reports for all static objects which
are in the __initdata section (e.g. "setup_done" in devtmpfs,
"kthreadd_done" in init/main.c) this warning:

	INFO: trying to register non-static key.

The warning itself is wrong, because those objects are in the __initdata
section, but the section itself is on parisc outside of range from
_stext to _end, which is why the static_obj() functions returns a wrong
answer.

While fixing this issue, I noticed that the whole existing check can
be simplified a lot.
Instead of checking against the _stext and _end symbols (which include
code areas too) just check for the .data and .bss segments (since we check a
data object). This can be done with the existing is_kernel_core_data()
macro.

In addition objects in the __initdata section can be checked with
init_section_contains(), and is_kernel_rodata() allows keys to be in the
_ro_after_init section.

This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
memory detection").

Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
Signed-off-by: Helge Deller <deller@gmx.de>

---
v2:
- check is_kernel_rodata() as well, since keys are allowed in the
  __ro_after_init section. Reported by kernel test robot.

---

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index a6e8373a5170..3fa87e5e11ab 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H
 
-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
@@ -18,20 +16,4 @@ extern char __end_of_kernel_reserve[];
 
 extern unsigned long _brk_start, _brk_end;
 
-static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	/*
-	 * If _brk_start has not been cleared, brk allocation is incomplete,
-	 * and we can not make assumptions about its use.
-	 */
-	if (_brk_start)
-		return 0;
-
-	/*
-	 * After brk allocation is complete, space between _brk_end and _end
-	 * is available for allocation.
-	 */
-	return addr >= _brk_end && addr < (unsigned long)&_end;
-}
-
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 111607d91489..e85b5ad3e206 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -819,34 +819,26 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-/*
- * Check if an address is part of freed initmem. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (system_state < SYSTEM_FREEING_INITMEM)
-		return 0;
-
-	return init_section_contains((void *)addr, 1);
-}
-#endif
-
 static int static_obj(const void *obj)
 {
-	unsigned long start = (unsigned long) &_stext,
-		      end   = (unsigned long) &_end,
-		      addr  = (unsigned long) obj;
+	unsigned long addr = (unsigned long) obj;
 
-	if (arch_is_kernel_initmem_freed(addr))
-		return 0;
+	if (is_kernel_core_data(addr))
+		return 1;
+
+	/*
+	 * keys are allowed in the __ro_after_init section.
+	 */
+	if (is_kernel_rodata(addr))
+		return 1;
 
 	/*
-	 * static variable?
+	 * in initdata section and used during bootup only?
+	 * NOTE: On some platforms the initdata section is
+	 * outside of the _stext ... _end range.
 	 */
-	if ((addr >= start) && (addr < end))
+	if (system_state < SYSTEM_FREEING_INITMEM &&
+		init_section_contains((void *)addr, 1))
 		return 1;
 
 	/*
