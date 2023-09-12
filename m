Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8779C8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjILH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjILH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D808E7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:48 -0700 (PDT)
Message-ID: <20230912065500.886599632@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4iWy4H04gKoxDxbBdcXl1DLzwa8M24xJYhbSoNX0o4=;
        b=QVS7DXoHfiAtIMT7nPbf0KrP6V5vPE3x1jqj17hq83l58q7P0CiBSeqOYOSAgszoPRRM9J
        civFqb+6Pwy9vMgNKeOBngH+zSSwDoNC3ehWh2/r0E9Ek2LswhofmNnOanwBawgZN+WppN
        4z0EyFvWIDdcTtbAZr8VTNinktpYQTJ3+rkO0eyI5dIMcCcJTl6t1ZN7xeRxgSpL+AycIp
        wwDP4veUqz305eFXyzEeWoOs4gN4zU8yJZfYjqOX/+o1vMfhW1U1MMFpo5xv1Z6eLQXRG5
        SocWvTc/gCFwxStw5A7ApDzS5l6PNIva4RzMoR3CptQyOQbBDDBLrWY8k6UPgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4iWy4H04gKoxDxbBdcXl1DLzwa8M24xJYhbSoNX0o4=;
        b=fR4UnP7Rrd5eP0Du3qjVv8dtgpIH2R/xhVPFAjUnYJjXBL58MlfMA73V6Yj0AMk1m+0KcZ
        S9mGLs/V6hqSRBCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 02/30] x86/boot/32: Disable stackprotector and tracing for
 mk_early_pgtbl_32()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:57:46 +0200 (CEST)
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

