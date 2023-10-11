Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E27C4DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbjJKJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjJKJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E59D;
        Wed, 11 Oct 2023 02:01:02 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697014860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rjdXP+1HAXDxpbcP8DPB8hg329kETi52ebn7TfU4V0=;
        b=zCCyfGXkOkd+FiAWokwYpG+zuEbOUy2874+0RW3/0bPNPWzBipn9eZsmF9Tw3DTc99AOdw
        kKE9uhzFheLUBW2yDYACqLrJMnE94HafdboKZv+EBE9b722AgebywLW6BWRNDRVF6+xcXV
        u7R8IsAyCBRyruWGWuhm7FjlpSpaTLRTtAsnHsfdNQRZQBKBxmFHpuG9/nKhvvJc9lhjzI
        17Vy0ZgyHty878I/VlETY8Vxdd3OAdfAWgkJee3zxcRBrFCSV1VZmKBCj7llk/T9V6TvyC
        H/elK+J35cHyh5l98P8qMcmkrvgl0V8RYIExBnaLK9vfXfGTg6Ol43Iwqyef8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697014860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rjdXP+1HAXDxpbcP8DPB8hg329kETi52ebn7TfU4V0=;
        b=RUhOpUo6wKyTtA3siQixgvsN7cRWoM68UhylA4554vm583YJV7gYSe7LJ1tthma0dq2C07
        WPbpNB4t2gle2rBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Mop up early loading leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.662293885@linutronix.de>
References: <20231010150702.662293885@linutronix.de>
MIME-Version: 1.0
Message-ID: <169701485968.3135.5134345024612355238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7edf8316660ee2966b8aed03a63d44496731f505
Gitweb:        https://git.kernel.org/tip/7edf8316660ee2966b8aed03a63d44496731f505
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:46 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Oct 2023 21:17:58 +02:00

x86/microcode: Mop up early loading leftovers

Get rid of the initrd_gone hack which was required to keep
find_microcode_in_initrd() functional after init.

As find_microcode_in_initrd() is now only used during init, mark it
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.662293885@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     | 17 +----------------
 arch/x86/kernel/cpu/microcode/internal.h |  2 --
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 57dde24..18e0cdd 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -49,8 +49,6 @@ static bool dis_ucode_ldr = true;
 bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
 module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
 
-bool initrd_gone;
-
 /*
  * Synchronization.
  *
@@ -185,15 +183,7 @@ void load_ucode_ap(void)
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
@@ -224,12 +214,7 @@ struct cpio_data find_microcode_in_initrd(const char *path)
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
index 9930788..fc03a7b 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -90,8 +90,6 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
-extern bool initrd_gone;
-
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
