Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750A7BFFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjJJPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJJPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0424993
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:51 -0700 (PDT)
Message-ID: <20231010150702.662293885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IhNNCBkZDu722mghkA1YDoOAV6ExbYvs7YIlqtUCfyk=;
        b=zaJ0NwORFtKCxUHt5o1b0JpRAPX6MwX3ZtWXdl623+w4GTIkYBD748069YKSx65upHVmid
        pyuZO9de3oYgj1KWaDRFCNuHFGKdVwlk2rlibB0D8oI7zUYSTXxtGdy7Rvq8o2MuxW9vvV
        Yk7ybfCRKSJpY6mPW6zkcIdzutFi6FRujyctmb+UpEojZd+nwr8YCfpmRS160zBWFRMXuR
        dkGSADxOEAh1E5VbSGqZP3AE7D/2KltmP4HeUjTlYBkHdw1zDNMHy6DqU7VlWnsGSjZS9L
        L/Ciq7BcpmSlxqHadMgDrjMKU8STpDF7lZdKW/SnqsWZKMMDU69Bsy8LahYOXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IhNNCBkZDu722mghkA1YDoOAV6ExbYvs7YIlqtUCfyk=;
        b=puecydyczdwg+Ys1hOCfWLBsA4EvL5lna9tjhjl5OfmCwNvjyGnouT60LL8OpuwT85CR3z
        hBvj7RoEALTbxuCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 5/5] x86/microcode: Mop up early loading leftovers
References: <20231010145130.987300357@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Oct 2023 17:08:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the initrd_gone hack which was required to keep
find_microcode_in_initrd() functional after init.

As find_microcode_in_initrd() is now only used during init, mark it
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c     |   17 +----------------
 arch/x86/kernel/cpu/microcode/internal.h |    2 --
 2 files changed, 1 insertion(+), 18 deletions(-)

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
@@ -224,12 +214,7 @@ struct cpio_data find_microcode_in_initr
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
@@ -90,8 +90,6 @@ static inline unsigned int x86_cpuid_fam
 	return x86_family(eax);
 }
 
-extern bool initrd_gone;
-
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
 void load_ucode_amd_ap(unsigned int family);

