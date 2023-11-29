Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E47FD838
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjK2NeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjK2Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:33:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143210E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:33:58 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 745AE2199D;
        Wed, 29 Nov 2023 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701264836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/U01NKkH0Q6ynzeZVm3tL1DK0kUFRugRcHG4oW3NAZw=;
        b=KX9+JpGrZ9D4ndtfbyxf0RwdBNNLM9bms0zmScw60SBtZ+TssUSp9qtHT5RvzLvpO8itX6
        GHdq4TsZzGayTfpo6GjqYS6iwXMWDMbSukMjDp7IMPMpXAHEk4FtSjZOq7qcqXK2FOhqW6
        Zs4kz2e6Luh6NoWk9MvHS6c2EjJX3ls=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 233E81376F;
        Wed, 29 Nov 2023 13:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 2g9oB8Q9Z2WEHwAAn2gu4w
        (envelope-from <jgross@suse.com>); Wed, 29 Nov 2023 13:33:56 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux.dev
Cc:     Juergen Gross <jgross@suse.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 1/5] x86/paravirt: introduce ALT_NOT_XEN
Date:   Wed, 29 Nov 2023 14:33:28 +0100
Message-Id: <20231129133332.31043-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129133332.31043-1-jgross@suse.com>
References: <20231129133332.31043-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.21 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.11)[-0.536];
         RCPT_COUNT_TWELVE(0.00)[13];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.21
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the macro ALT_NOT_XEN as a short form of
ALT_NOT(X86_FEATURE_XENPV).

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- split off from next patch
V5:
- move patch to the start of the series (Boris Petkov)
---
 arch/x86/include/asm/paravirt.h       | 42 ++++++++++++---------------
 arch/x86/include/asm/paravirt_types.h |  3 ++
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 693c61dbdd9c..aa76ac7c806c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -142,8 +142,7 @@ static inline void write_cr0(unsigned long x)
 static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
-				"mov %%cr2, %%rax;",
-				ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%cr2, %%rax;", ALT_NOT_XEN);
 }
 
 static __always_inline void write_cr2(unsigned long x)
@@ -154,13 +153,12 @@ static __always_inline void write_cr2(unsigned long x)
 static inline unsigned long __read_cr3(void)
 {
 	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
-			      "mov %%cr3, %%rax;", ALT_NOT(X86_FEATURE_XENPV));
+			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_ALT_VCALL1(mmu.write_cr3, x,
-			"mov %%rdi, %%cr3", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALL1(mmu.write_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
 }
 
 static inline void __write_cr4(unsigned long x)
@@ -182,7 +180,7 @@ extern noinstr void pv_native_wbinvd(void);
 
 static __always_inline void wbinvd(void)
 {
-	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
 }
 
 static inline u64 paravirt_read_msr(unsigned msr)
@@ -390,27 +388,25 @@ static inline void paravirt_release_p4d(unsigned long pfn)
 static inline pte_t __pte(pteval_t val)
 {
 	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pteval_t pte_val(pte_t pte)
 {
 	return PVOP_ALT_CALLEE1(pteval_t, mmu.pte_val, pte.pte,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline pgd_t __pgd(pgdval_t val)
 {
 	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, mmu.make_pgd, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pgdval_t pgd_val(pgd_t pgd)
 {
 	return PVOP_ALT_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
@@ -444,14 +440,13 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 static inline pmd_t __pmd(pmdval_t val)
 {
 	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, mmu.make_pmd, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pmdval_t pmd_val(pmd_t pmd)
 {
 	return PVOP_ALT_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
@@ -464,7 +459,7 @@ static inline pud_t __pud(pudval_t val)
 	pudval_t ret;
 
 	ret = PVOP_ALT_CALLEE1(pudval_t, mmu.make_pud, val,
-			       "mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+			       "mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (pud_t) { ret };
 }
@@ -472,7 +467,7 @@ static inline pud_t __pud(pudval_t val)
 static inline pudval_t pud_val(pud_t pud)
 {
 	return PVOP_ALT_CALLEE1(pudval_t, mmu.pud_val, pud.pud,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -492,8 +487,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 static inline p4d_t __p4d(p4dval_t val)
 {
 	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
-					"mov %%rdi, %%rax",
-					ALT_NOT(X86_FEATURE_XENPV));
+					"mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (p4d_t) { ret };
 }
@@ -501,7 +495,7 @@ static inline p4d_t __p4d(p4dval_t val)
 static inline p4dval_t p4d_val(p4d_t p4d)
 {
 	return PVOP_ALT_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
@@ -687,17 +681,17 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
-				ALT_NOT(X86_FEATURE_XENPV));
+				ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT_XEN);
 }
 
 static __always_inline unsigned long arch_local_irq_save(void)
@@ -769,7 +763,7 @@ void native_pv_lock_init(void) __init;
 .endm
 
 #define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
-				    ALT_NOT(X86_FEATURE_XENPV)
+				    ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f4fb2e3ec7b8..483e19e5ca7a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -557,5 +557,8 @@ extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
 #endif	/* __ASSEMBLY__ */
+
+#define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
+
 #endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
-- 
2.35.3

