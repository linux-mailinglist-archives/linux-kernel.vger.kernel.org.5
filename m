Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAE7E97C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjKMIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:33:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3810F8;
        Mon, 13 Nov 2023 00:32:56 -0800 (PST)
Date:   Mon, 13 Nov 2023 08:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699864374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngF/T3wdSOnmGRV9g85/BDDi0rFblcD0V9ypYKd5sdA=;
        b=VX+6aJjBnUq3/nFQEvaDtb6zUwnn6Fl/9QpGTqSEux7rf3YeJKcroIOBWcsq8Q1mRxvM6B
        ZFHpbvBhMQePTQ5FazcoJPCeguqL1GyEKHuxlsnw5s4sQQPgIpGMpObf2li3JYFYgad4gx
        az2w+5zIw4/6MDmdcIuOe4y5wEnlje4HcLA7wfW3bzgqzJGWFJUYdW9Pq7LXTJldavQgX1
        3hAV1aXUn0/hIadPD/EgcSQvNh+1Wglkibrs6i2GotVZkja+cE1bWqBIwjrh8b77oXzyiE
        rl4AHQFY7VGy8JSSffvTebvY0e8BBq/dTA8Uqd6Y+vci3yOXZkuHC5CsgW6daQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699864374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngF/T3wdSOnmGRV9g85/BDDi0rFblcD0V9ypYKd5sdA=;
        b=QfzRyNHJTvi1TPNSOcCIM8mJLJnHJSNOV7uVshiC+euHuvkC08h0VH/GH1R4EEZtUHaVvX
        wqRo8FIZvHZREJDg==
From:   "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Make relocated_ramdisk a local
 variable of relocate_initrd()
Cc:     Yuntao Wang <ytcoode@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231113034026.130679-1-ytcoode@gmail.com>
References: <20231113034026.130679-1-ytcoode@gmail.com>
MIME-Version: 1.0
Message-ID: <169986437391.3135.15393709834682156361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f7a25cf1d4707da39b80df96a3be8a8abd07c35b
Gitweb:        https://git.kernel.org/tip/f7a25cf1d4707da39b80df96a3be8a8abd07c35b
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Mon, 13 Nov 2023 11:40:26 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Nov 2023 09:09:37 +01:00

x86/setup: Make relocated_ramdisk a local variable of relocate_initrd()

After

  0b62f6cb0773 ("x86/microcode/32: Move early loading after paging enable"),

the global variable relocated_ramdisk is no longer used anywhere except
for the relocate_initrd() function. Make it a local variable of that
function.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Link: https://lore.kernel.org/r/20231113034026.130679-1-ytcoode@gmail.com
---
 arch/x86/include/asm/setup.h | 2 --
 arch/x86/kernel/setup.c      | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index bf483fc..5c83729 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -31,8 +31,6 @@
 #include <asm/bootparam.h>
 #include <asm/x86_init.h>
 
-extern u64 relocated_ramdisk;
-
 /* Interrupt control for vSMPowered x86_64 systems */
 #ifdef CONFIG_X86_64
 void vsmp_init(void);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1526747..ec2c21a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -226,8 +226,6 @@ static void __init reserve_brk(void)
 	_brk_start = 0;
 }
 
-u64 relocated_ramdisk;
-
 #ifdef CONFIG_BLK_DEV_INITRD
 
 static u64 __init get_ramdisk_image(void)
@@ -261,7 +259,7 @@ static void __init relocate_initrd(void)
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);
 
 	/* We need to move the initrd down into directly mapped mem */
-	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
+	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
 						      PFN_PHYS(max_pfn_mapped));
 	if (!relocated_ramdisk)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
