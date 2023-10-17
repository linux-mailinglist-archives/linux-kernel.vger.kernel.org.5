Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F77CCF19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJQVX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120BC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:25 -0700 (PDT)
Message-ID: <20231017211721.990580849@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n70P7VXoQvos+tvoARg8YdC357P9bzhzxWof3PMYpTE=;
        b=SMiNeiQ/s5oDUwUUum5Ddfk05cPTUzZ9hQ0/GGHgxHg7XNiRULFTZZLx/UV1T/mkXRg3+a
        l6Bt4nphPW74/KaLOmlzYQvOS7yxpwjCegmYO1qalPNi4z664GPqqWz8rTdRYrtsk3MxmE
        BYVpYCAiL0CSri49W/gtolPX/uCsPkpRL8uSFddlp9/rXjePhfv/g6cM0elfbIo3e1o9r2
        imh7keXzYplj9O7BUU8G+tr8FSc5afnMDi+EJ3o05IyVgqK1ScRHmzF5zYGFDXFqbTo8yP
        jdmY03p5K8VMRlgM7wwSo9zHjXpU1qo55yKI0nzmMSh/Sp8FiRAgthJwzqo+9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n70P7VXoQvos+tvoARg8YdC357P9bzhzxWof3PMYpTE=;
        b=DjuZ02UuiZWrwZnoPFeH+9FGXmbZYNkaFE2Sak5Pub59YwvW8sTdMA1ZK2Ij+vmtekXVo+
        2a45mX6csMbvd7AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 01/39] x86/boot/32: Disable stackprotector and tracing for
 mk_early_pgtbl_32()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:24 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
physical address mode which again might work by chance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/Makefile |    1 +
 arch/x86/kernel/head32.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
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
@@ -70,7 +70,8 @@ asmlinkage __visible void __init __noret
  * always zero at this stage.
  */
 void __init mk_early_pgtbl_32(void);
-void __init mk_early_pgtbl_32(void)
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 #ifdef __pa
 #undef __pa

