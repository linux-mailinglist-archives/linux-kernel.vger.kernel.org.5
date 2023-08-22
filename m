Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB0784099
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjHVMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjHVMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:20:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72C19A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:20:16 -0700 (PDT)
Message-ID: <20230822121954.036339203@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692706809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4iWy4H04gKoxDxbBdcXl1DLzwa8M24xJYhbSoNX0o4=;
        b=0PLmTFpl5mNlR+D+WEZqBxy+nKX4toSsnpowKmf3PUddAXtOyLWnig1FiP2C7iVxLnLzuw
        wU2VA/PlpQ5VyaTOLv3Sle6HaMOp13FZheL0OlHci3+zXBfhlmk3ej/V2BxyJfWV+hQDuB
        ThzQlTFOfTIyo6GDsnvUjJXieA5md1BGMnWoGvR+eV5ws3/oLexegYVZfu/M8KkWf8Pi7y
        5tqhrSPpyo38c8Ijf3P04Fohu96uyHugVf9nGKFVmB9wNVnmy1raP1xIDxXlZS/7xKZfoe
        kxNkgNTEbSMzZCRXRgE7lf/v5W+p23kOShVowGZ/RLAvMV0ccSKZOR/KcclT6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692706809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4iWy4H04gKoxDxbBdcXl1DLzwa8M24xJYhbSoNX0o4=;
        b=ldL+lTQHsfkGVs5zKLb8WLq4V9p+tFiLl5N17Z9lSBgINto9Ol4MOPxQjQEcjre+k2h2HD
        7FOyEJsrkOkSN4AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: [patch 2/2] x86/boot/32: Disable stackprotector and tracing for
 mk_early_pgtbl_32()
References: <20230822121936.476984181@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:20:09 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stackprotector cannot work before paging is enabled. The read from the per
CPU variable __stack_chk_guard is always accessing the virtual address
either directly on UP or via FS on SMP. In physical address mode this
results in an access to memory above 3GB.

So this works by chance as the hardware returns the same value when there
is no RAM at this physical address. When there is RAM populated above 3G
then the read is by chance the same as nothing changes that memory during
the very early boot stage.

Stop relying on pure luck and disable the stack protector for the only C
function which is called during early boot before paging is enabled.

Remove function tracing from the whole source file as there is no way to
trace this at all, but in case of CONFIG_DYNAMIC_FTRACE=n
mk_early_pgtbl_32() would access global function tracer variables in
physcial address mode which again might work by chance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/Makefile |    1 +
 arch/x86/kernel/head32.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -16,6 +16,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_head32.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -73,7 +73,8 @@ asmlinkage __visible void __init __noret
  * always zero at this stage.
  */
 void __init mk_early_pgtbl_32(void);
-void __init mk_early_pgtbl_32(void)
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 #ifdef __pa
 #undef __pa

