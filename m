Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AB7D0EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377121AbjJTLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377335AbjJTLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:40:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321E1737;
        Fri, 20 Oct 2023 04:38:39 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sE1yXp9sD9shIhHQnmqJhUlScFe7VM9zewmCWWNFc+E=;
        b=jaEx1Nnpwa77Nx/RQnuL0Px0Qp8+s6wn+if4fzrKDcMQK/tZS1XWpZF0uJ2RGnUSHcA6Sc
        jsa54qaHAL/is2GBWv9F0EQSRPTK2h/FHi2GCtbLJd/v5Vh8s6qScJYUydQejrH+9w+QSY
        C4mvlRDlOULDvYtgk+/7NubvVY/Cdm6mGBkcXkHhLtG7UTWgJLcp3UwRMfggD0Fm2lyrpJ
        EmtMXCHTadMJ/0XQhr8zn/EgkmuZrxIPWzA5afISU7ZtFM4ZwHHeUhhkUwTbhI0+ix2RZT
        VswvopoXJKIdHgjrYx3LhN55kw0rNnMSGnPaXoVR8fgt3pP/dsgiqCv5DaDT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sE1yXp9sD9shIhHQnmqJhUlScFe7VM9zewmCWWNFc+E=;
        b=Zv9HdNN6eWXBVqAWOQgdVuYijAQpS4+cN1W40MOAkr3oZ8hPNZS2zJH92I/YjKLulI/04l
        7UY27JcbXWl8AMAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/boot/32: Temporarily map initrd for
 microcode loading
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.292291436@linutronix.de>
References: <20231017211722.292291436@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188328.3135.2756882878941011371.tip-bot2@tip-bot2>
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

Commit-ID:     4c585af7180c147062c636a927a2fc2b6a7072f5
Gitweb:        https://git.kernel.org/tip/4c585af7180c147062c636a927a2fc2b6a7072f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 18:28:41 +02:00

x86/boot/32: Temporarily map initrd for microcode loading

Early microcode loading on 32-bit runs in physical address mode because
the initrd is not covered by the initial page tables. That results in
a horrible mess all over the microcode loader code.

Provide a temporary mapping for the initrd in the initial page tables by
appending it to the actual initial mapping starting with a new PGD or
PMD depending on the configured page table levels ([non-]PAE).

The page table entries are located after _brk_end so they are not
permanently using memory space. The mapping is invalidated right away in
i386_start_kernel() after the early microcode loader has run.

This prepares for removing the physical address mode oddities from all
over the microcode loader code, which in turn allows further cleanups.

Provide the map and unmap code and document the place where the
microcode loader needs to be invoked with a comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.292291436@linutronix.de
---
 arch/x86/include/asm/microcode.h |  2 +-
 arch/x86/kernel/head32.c         | 54 +++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index bbbe9d7..5216bf1 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -23,6 +23,8 @@ static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
 #endif
 
+extern unsigned long initrd_start_early;
+
 #ifdef CONFIG_CPU_SUP_INTEL
 /* Intel specific microcode defines. Public for IFS */
 struct microcode_header_intel {
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index bdce632..abdbfd3 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -29,11 +29,33 @@ static void __init i386_default_early_setup(void)
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
+#ifdef CONFIG_MICROCODE_INITRD32
+unsigned long __initdata initrd_start_early;
+static pte_t __initdata *initrd_pl2p_start, *initrd_pl2p_end;
+
+static void zap_early_initrd_mapping(void)
+{
+	pte_t *pl2p = initrd_pl2p_start;
+
+	for (; pl2p < initrd_pl2p_end; pl2p++) {
+		*pl2p = (pte_t){ .pte = 0 };
+
+		if (!IS_ENABLED(CONFIG_X86_PAE))
+			*(pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = (pte_t) {.pte = 0};
+	}
+}
+#else
+static inline void zap_early_initrd_mapping(void) { }
+#endif
+
 asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
 
+	/* load_ucode_bsp() */
+	zap_early_initrd_mapping();
+
 	cr4_init_shadow();
 
 	sanitize_boot_params(&boot_params);
@@ -105,9 +127,9 @@ static __init __no_stack_protector pte_t init_map(pte_t pte, pte_t **ptep, pl2_t
 void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa_nodebug(_end) +
-		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
+	unsigned long limit = __pa_nodebug(_end) + (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
 	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	struct boot_params __maybe_unused *params;
 	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
 	unsigned long *ptr;
 
@@ -120,4 +142,32 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)
 
 	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
+
+#ifdef CONFIG_MICROCODE_INITRD32
+	/* Running on a hypervisor? */
+	if (native_cpuid_ecx(1) & BIT(31))
+		return;
+
+	params = (struct boot_params *)__pa_nodebug(&boot_params);
+	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
+		return;
+
+	/* Save the virtual start address */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_start_early);
+	*ptr = (pte.pte & PTE_PFN_MASK) + PAGE_OFFSET;
+	*ptr += ((unsigned long)params->hdr.ramdisk_image) & ~PAGE_MASK;
+
+	/* Save PLP2 for cleanup */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_start);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+
+	limit = (unsigned long)params->hdr.ramdisk_image;
+	pte.pte = PTE_IDENT_ATTR | PFN_ALIGN(limit);
+	limit = (unsigned long)params->hdr.ramdisk_image + params->hdr.ramdisk_size;
+
+	init_map(pte, &ptep, &pl2p, limit);
+
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_end);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+#endif
 }
