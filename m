Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F4773ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHHQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjHHQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D214252;
        Tue,  8 Aug 2023 08:52:39 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhLoOH1vlpur8m0pcnb4dIj/5jh+8qUt0fIQH+l+3PE=;
        b=4Y8vBj30dWZXpBpkbXXG/LsgbnLQaskp0K7T2CgyG7u9sQ6qlxWtCkldmZj57Qf0DcaTqA
        YnimaZhO3f8BiOmzFG+oDDuerJDWbPt+9T44XeuK+Doxh2kxNi1T6Hre1WRocLMqKc97ph
        UE3Ea28uYQmulya7qaIv/SqBiJAC81I+hz47EwgN81Lxs/9Q1EA7iAP4nFdpy0N8Oha/HP
        lnJ09uBI4ya4aLuS1RdPF90ofgCz0XYMxH3gWsRah6dArIpKBwprcqAXwucXqcCGgKPnsi
        ynTJSWKRJD8k1gY+uobjhA18ErvF7LMKQVTumhvhs+Fvpu7iqXgaoYG7Eced8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhLoOH1vlpur8m0pcnb4dIj/5jh+8qUt0fIQH+l+3PE=;
        b=MiHnw00gWUJmXq42f3toB4CdQCWvgdlHypOdg3ovp3DHfcHTIuAqPaYset21+x4BBfGqzs
        muuHDmlL5LcZWEDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Assign paging related global
 variables earlier
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-9-ardb@kernel.org>
References: <20230807162720.545787-9-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424406.27769.1064202115749702744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     00c6b0978ec182f1a672095930872168b9d5b1e2
Gitweb:        https://git.kernel.org/tip/00c6b0978ec182f1a672095930872168b9d5b1e2
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:42:11 +02:00

x86/decompressor: Assign paging related global variables earlier

There is no need to defer the assignment of the paging related global
variables 'pgdir_shift' and 'ptrs_per_p4d' until after the trampoline is
cleaned up, so assign them as soon as it is clear that 5-level paging
will be enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-9-ardb@kernel.org
---
 arch/x86/boot/compressed/misc.h       |  2 --
 arch/x86/boot/compressed/pgtable_64.c | 14 +++++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 964fe90..cc70d3f 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -179,9 +179,7 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
 /* ident_map_64.c */
-#ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
-#endif
 extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2ac12ff..f8092d3 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -130,6 +130,11 @@ struct paging_config paging_prepare(void *rmode)
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		paging_config.l5_required = 1;
+
+		/* Initialize variables for 5-level paging */
+		__pgtable_l5_enabled = 1;
+		pgdir_shift = 48;
+		ptrs_per_p4d = 512;
 	}
 
 	paging_config.trampoline_start = find_trampoline_placement();
@@ -206,13 +211,4 @@ void cleanup_trampoline(void *pgtable)
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
-
-	/* Initialize variables for 5-level paging */
-#ifdef CONFIG_X86_5LEVEL
-	if (__read_cr4() & X86_CR4_LA57) {
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
-	}
-#endif
 }
