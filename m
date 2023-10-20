Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C307D0EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377471AbjJTLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377380AbjJTLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:40:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03987273A;
        Fri, 20 Oct 2023 04:38:25 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BczCm80yMNtYYLLs9V0TgO64ubwxRuMBhSfMGrRZCi4=;
        b=0t3GzrdWL1hWbIU7wxHCWl3JgSKiCnaWZ05q8UmMODwR0vazmj6aspIJz2zJdcdke6x5Xe
        cejTJoIX8mYas1GozMfLAQ4xogweqE5Alune40D6ryQZRXFYwDYW5aWH0+pfX2MSDPZeeo
        wY6ebXntMqyEE3LuWAPXeCTzFSayLTSIcDVscYhT0rKuNSQ4TMeuhCGvmBKj3daWaIogVo
        dCQq/CK/meTStF/oyWSJl/tufcqqcLCV+aOHpUrmD8PRml0xSo5Eqkswh9u8DBS3f0shFy
        JvqHoY5Vp7UN6c1ZyVERZ9ryedHatsvO3ElWDGlHWHB0gzz0fU8DdJ0ZUUpcOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BczCm80yMNtYYLLs9V0TgO64ubwxRuMBhSfMGrRZCi4=;
        b=o3ouRRH24jimf9OJzt/DAmDUDBYpGL5IJswImQ6UAhO8yqVDfh2uNw4FbDOEpR1WrkKFR3
        GbI2HRzWC0oSymAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Mop up early loading leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211723.298854846@linutronix.de>
References: <20231017211723.298854846@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187358.3135.10296901941195056547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7800dda414725c9c8c266ae9b0be811563714e14
Gitweb:        https://git.kernel.org/tip/7800dda414725c9c8c266ae9b0be811563714e14
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:56 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:49:50 +02:00

x86/microcode: Mop up early loading leftovers

Get rid of the initrd_gone hack which was required to keep
find_microcode_in_initrd() functional after init.

As find_microcode_in_initrd() is now only used during init, mark it
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211723.298854846@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     | 17 +----------------
 arch/x86/kernel/cpu/microcode/internal.h |  1 -
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 15c5042..37145cf 100644
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
@@ -216,12 +206,7 @@ struct cpio_data find_microcode_in_initrd(const char *path)
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
 
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 89fbf74..4bef216 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -86,7 +86,6 @@ static inline unsigned int x86_cpuid_family(void)
 }
 
 extern bool dis_ucode_ldr;
-extern bool initrd_gone;
 
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
