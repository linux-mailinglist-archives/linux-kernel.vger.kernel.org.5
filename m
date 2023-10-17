Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3077CCF32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjJQVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbjJQVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD91725
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:58 -0700 (PDT)
Message-ID: <20231017211723.298854846@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zoWn/zXSQdOkoPj//a7eVm5ZP4GBukZaN+6DN0KBVgk=;
        b=cBEr8e03WG+GmnA4WsTF6/8Jg2B8kH9VnkRTposOKhsNVYavR+/Ic0vkc4jLJgx7xioKm9
        Fee6wWk3ecipeDlxiwIRBx7r3otZclDL0mnHnU4LCXFC+AjYMHMn981Oqxteq2rIwCOsCl
        3tZvXym/PUrenB2z3hmEv3FKRyN5htq3HagnaHlGC9BRKeRl3AUYaMnV00jMK9f4T5HP8q
        Hz34E4iDqEIxgauP4ULDIK/58hdDlZm4q/mf9E4BQQmtvksJZJnVdjZDyeNvIaIpZqbIgI
        XNw3lLsqPHRPBwWxA+DP/Wfe4HAcgcO1oYyCBMNyfSqXDGRL9S+lpzmD920JRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zoWn/zXSQdOkoPj//a7eVm5ZP4GBukZaN+6DN0KBVgk=;
        b=xsTGKtKrEhmas/Bc8L/ESg/iBvi3XieGd1hwId9WzgeJGRGRaL/Jn8SNZnc+9G0m2CULa5
        2QlSmmIEe6HJQPAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 24/39] x86/microcode: Mop up early loading leftovers
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:56 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Get rid of the initrd_gone hack which was required to keep
find_microcode_in_initrd() functional after init.

As find_microcode_in_initrd() is now only used during init, mark it
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c     |   17 +----------------
 arch/x86/kernel/cpu/microcode/internal.h |    1 -
 2 files changed, 1 insertion(+), 17 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -44,8 +44,6 @@
 static struct microcode_ops	*microcode_ops;
 bool dis_ucode_ldr = true;
 
-bool initrd_gone;
-
 /*
  * Synchronization.
  *
@@ -180,15 +178,7 @@ void load_ucode_ap(void)
 	}
 }
 
-/* Temporary workaround until find_microcode_in_initrd() is __init */
-static int __init mark_initrd_gone(void)
-{
-	initrd_gone = true;
-	return 0;
-}
-fs_initcall(mark_initrd_gone);
-
-struct cpio_data find_microcode_in_initrd(const char *path)
+struct cpio_data __init find_microcode_in_initrd(const char *path)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long start = 0;
@@ -216,12 +206,7 @@ struct cpio_data find_microcode_in_initr
 	 * has the virtual address of the beginning of the initrd. It also
 	 * possibly relocates the ramdisk. In either case, initrd_start contains
 	 * the updated address so use that instead.
-	 *
-	 * initrd_gone is for the hotplug case where we've thrown out initrd
-	 * already.
 	 */
-	if (initrd_gone)
-		return (struct cpio_data){ NULL, 0, "" };
 	if (initrd_start)
 		start = initrd_start;
 
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -86,7 +86,6 @@ static inline unsigned int x86_cpuid_fam
 }
 
 extern bool dis_ucode_ldr;
-extern bool initrd_gone;
 
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);

