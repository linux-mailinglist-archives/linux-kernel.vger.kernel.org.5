Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C177CE2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJRQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:28:43 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A08DB8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:28:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5FFF40E0196;
        Wed, 18 Oct 2023 16:28:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PLsE6ZBaTxvG; Wed, 18 Oct 2023 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697646517; bh=UUiIsufZNx2Skm3foRyePaxaxDvMuZzimTco0fIaIc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6mZPu/zSuWxFj1NloA7zaBpGr1NvlXIU/aYUsvBFrawnQfyA6NEiQ4NlV99fok9f
         hAjLn939p5/YkD4Eog0EczFE1nS9HxgrsK9LqzwnRACuddZzu1DVOP/N90YeANW2hS
         ++gQIdhmk/EJAfzMBD3uRYJsXabwXWENEMeI+luE8N2IFVipN5BvoLf7bSUJi2fcu7
         WBX1WVcLfwI57NFWeoeETWV4/I5IsYOsoRZuE/9848GNcNL7tsYplcEdnemL2Fs9ZC
         X8o3Y2QP+tuMi1+qD4DRNesg0TkR6N5GUnW5Pa4p1VGyvrCxRbKecjBifZ+c3aGlMV
         3PnN3WAvlgZkVgMR1pjhz7B/V16a9mDIE2g3e/8CMZXhgTFzbL5yGIIFkk/rU/Muzo
         S3Geqz29VKK2BTGF7gnR8p1oX7yvJoA+Sx2WJkQ8ohYN4IJzUvoxnhO4X4nNUOLD11
         J04AwZtSjbEsJAqo1V54gSqHFhWYa2FyVC3YkWugaurF/m215cq7/lpvuZQEad7ADz
         eZY2abhpd4E0t4HvUP1iYANxJnNOfoquWgxwDxmERvLWrAOb4rGiv/74PHkCBzrufV
         l27cIV24WieZK69qwde3+htCvYAhfDsP2fwIW2TCgHRxWQqzyiGaLcUAYQ2fJ15T+6
         aOEGInaH+l1EsbI2+paCtMik=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57F7040E0193;
        Wed, 18 Oct 2023 16:28:34 +0000 (UTC)
Date:   Wed, 18 Oct 2023 18:28:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch V5 03/39] x86/boot/32: De-uglify the 2/3 level paging
 difference in mk_early_pgtbl_32()
Message-ID: <20231018162827.GDZTAHq/Cid4gJJEiw@fat_crate.local>
References: <20231017200758.877560658@linutronix.de>
 <20231017211722.111059491@linutronix.de>
 <20231018100023.GAZS+st5ePdAQjnO4z@fat_crate.local>
 <87mswg3w51.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mswg3w51.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:20:10PM +0200, Thomas Gleixner wrote:
> Up to the point where the compiler complains about a missing prototype
> for a global visible function, which will bring it back faster than you
> think. :)

---
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Oct 2023 23:23:26 +0200
Subject: [PATCH] x86/boot/32: De-uglify the 2/3 level paging difference in
 mk_early_pgtbl_32()

Move the ifdeffery out of the function and use proper typedefs to make it
work for both 2 and 3 level paging.

No functional change.

  [ bp: Move mk_early_pgtbl_32() declaration into a header. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.111059491@linutronix.de
---
 arch/x86/include/asm/setup.h |  1 +
 arch/x86/kernel/head32.c     | 38 +++++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f3495623ac99..bf483fcb4e57 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -126,6 +126,7 @@ void clear_bss(void);
 #ifdef __i386__
 
 asmlinkage void __init __noreturn i386_start_kernel(void);
+void __init mk_early_pgtbl_32(void);
 
 #else
 asmlinkage void __init __noreturn x86_64_start_kernel(char *real_mode);
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 8fe0dd38fff0..2b6599807026 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -69,41 +69,43 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * to the first kernel PMD. Note the upper half of each PMD or PTE are
  * always zero at this stage.
  */
-void __init mk_early_pgtbl_32(void);
+#ifdef CONFIG_X86_PAE
+typedef pmd_t			pl2_t;
+#define pl2_base		initial_pg_pmd
+#define SET_PL2(val)		{ .pmd = (val), }
+#else
+typedef pgd_t			pl2_t;
+#define pl2_base		initial_page_table
+#define SET_PL2(val)		{ .pgd = (val), }
+#endif
 
 void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
-	pte_t pte, *ptep;
-	int i;
-	unsigned long *ptr;
 	/* Enough space to fit pagetables for the low memory linear map */
 	const unsigned long limit = __pa_nodebug(_end) +
 		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
-#ifdef CONFIG_X86_PAE
-	pmd_t pl2, *pl2p = (pmd_t *)__pa_nodebug(initial_pg_pmd);
-#define SET_PL2(pl2, val)    { (pl2).pmd = (val); }
-#else
-	pgd_t pl2, *pl2p = (pgd_t *)__pa_nodebug(initial_page_table);
-#define SET_PL2(pl2, val)   { (pl2).pgd = (val); }
-#endif
+	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
+	unsigned long *ptr;
+	int i;
 
-	ptep = (pte_t *)__pa_nodebug(__brk_base);
 	pte.pte = PTE_IDENT_ATTR;
 
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
+		pl2_t pl2 = SET_PL2((unsigned long)ptep | PDE_IDENT_ATTR);
 
-		SET_PL2(pl2, (unsigned long)ptep | PDE_IDENT_ATTR);
 		*pl2p = pl2;
-#ifndef CONFIG_X86_PAE
-		/* Kernel PDE entry */
-		*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
-#endif
+
+		if (!IS_ENABLED(CONFIG_X86_PAE)) {
+			/* Kernel PDE entry */
+			*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
+		}
+
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			*ptep = pte;
 			pte.pte += PAGE_SIZE;
 			ptep++;
 		}
-
 		pl2p++;
 	}
 
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
