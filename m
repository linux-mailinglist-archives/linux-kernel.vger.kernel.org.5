Return-Path: <linux-kernel+bounces-158504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08888B2157
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B251AB26FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623712CD89;
	Thu, 25 Apr 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1mOv42N"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230312C53B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046681; cv=none; b=OTmfvTQTbyK5Bv18Rt+zDZdOXhlAq+EZS/Lgw0Mz5tHJJr3k1uPiLU5XTVmE90z0oPytnxM2oX0COy0/TT36amK4qZYcxLGLatlb9v9jnBhR+vejbtYk+GkE6pUG8Z5UJNs2JDK8qDoUEtuV+QpXkGGuNBGLGVmcqHcMLM04IhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046681; c=relaxed/simple;
	bh=W4wjfte6q+UQQZ4ExLZkrQ1Z7tdGL2ravbfBcdus9Ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pzGpWh7vQcOt4I6GXJKX4RFIvNqAk2havFbWTes2KFkdJRDYa6yQPeZTmBg7WpqKWI4kwblTD0Zpy1+s4qLvDREBr24+c1saOwH7xS0kBk2t9m9MhZhRg3/BcUpWUdhJYz3uYHJerB2JB8ucTNFeB9DzGTGj6IRyNj6el04kDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1mOv42N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2abd30f9so15645317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714046679; x=1714651479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK36PSSfYCXKu8TOIykY9gFPtCmNGRC9sq2O5M5gVtQ=;
        b=l1mOv42NIFffTmLLXa255MwOWwJHHcHVsVyD6mi8Oioe1kxEHP4BMHTzeV7qBdGucB
         skE3E6cTa7g4SvlCDEhCYakl68uZ8fh4t52q/wbu0BZnZ0+0C7qBlM3rIRrWRyHfoDTU
         9f9JtpMW3XYhNw2nQTB8BYw/MZUgUt4XrDYfkBxRwTqS9VHRamY4vCc+q5j2XZNGqrCI
         6FDwOg0bGPsFW5N80x4CfK+0VoUdSDCzjlQItMtP8/bJ7aOKwYJ0Vs79fFbFvTtESS6t
         euqkuwBKqHNSYmwoLqfL+ST1bpaQHzf+R47Bi5HjTtcYs+vmjE8dlhWbfJ0rTciYisrN
         Vvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046679; x=1714651479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK36PSSfYCXKu8TOIykY9gFPtCmNGRC9sq2O5M5gVtQ=;
        b=Kw7PIVX6W1KgXwoW5BF7qtiKrG1jaK4jGh1UTux8uPordKML9WjCc+y2fHEoeG1Mbq
         /YM63FBsYCg87DleFJpR4JXj++n7Gl91Lm61fUsxajLpKNEPc5h21Dk7CzQzrQD/kLRg
         3YPywgig7aktvJ/tfYnN82dXgFyf67TQpHiiaZpW/gGAQDpqoZM22oz8Ggt+OBE2XXgc
         rYqfKY+t33Jp4nttK9QLaKmc0urqEZFpNjmN2F3KhnEvp7a/SCynkOx7aHHJ8H80yjpZ
         KhN+rU/pQGJqWa1u4vxS55TL6FhBjzbeEkxdOjLpRcqENcmi1XxCYPI3ut+WnSmaqzBn
         YL5w==
X-Gm-Message-State: AOJu0YxPkRkR8WFCWeHQpD1x7ZgBxBTeg5fpHRHZi1spcccfkT9RoleM
	fQyM/fn5JtC/QjZZ+XzexQ9/+gSgvlfyvBuMC8a0y9UJvFonNLvRV/Cm3RmbKcGqP2EFYv0JhFl
	BR/d7eMVy8+oMSlFROmfkU/LSfjc2yepay8xPpVE8QRvvxMBE2P6oH03tOXh49SnL3yHewJFJdC
	mVBIbHp5tnBsMNwHv5tgPVhxtMh3x2CQ==
X-Google-Smtp-Source: AGHT+IGRWod11kLpYz3T4MmXDFR70IVTM5N25vUtFyQWpGp3FkGnomsrf6u59LfQVqwoOJQwBIfY6xig
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:e948:0:b0:611:2c40:e8d0 with SMTP id
 e8-20020a81e948000000b006112c40e8d0mr1160202ywm.3.1714046678904; Thu, 25 Apr
 2024 05:04:38 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:04:21 +0200
In-Reply-To: <20240425120416.2041037-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425120416.2041037-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=ardb@kernel.org;
 h=from:subject; bh=J0FkvPdq5mOGe6TzUIHU039KAtL9TmcrdWLzNqSNIaY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3L7eheyUtGy23VMuMFt5w8kcIZVvrs8sNc5pUOCfazo
 194KiR0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk8/8Xw332X3vmvuzqmXvCZ
 cHpr3BH3XuG9n09vjGoUmadTcTboRg3DP2Nf/ocqyg/XMngGVO1oOe7LLR0W1TZ35WO1tK/BYvU RHAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425120416.2041037-10-ardb+git@google.com>
Subject: [PATCH v2 4/4] x86/boot/64: Avoid intentional absolute symbol
 references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The code in .head.text executes from a 1:1 mapping and cannot generally
refer to global variables using their kernel virtual addresses. However,
there are some occurrences of such references that are valid: the kernel
virtual addresses of _text and _end are needed to populate the page
tables correctly, and some other section markers are used in a similar
way.

To avoid the need for making exceptions to the rule that .head.text must
not contain any absolute symbol references, derive these addresses from
the RIP-relative 1:1 mapped physical addresses, which can be safely
determined using RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 81696a4967e6..c0f20962f9b1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -91,9 +91,11 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long p2v_offset)
 {
-	unsigned long vaddr, vaddr_end;
+	unsigned long paddr, paddr_end;
 	int i;
 
 	/* Encrypt the kernel and related (if SME is active) */
@@ -106,10 +108,10 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
+		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
 
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
 			/*
 			 * On SNP, transition the page to shared in the RMP table so that
 			 * it is consistent with the page table attribute change.
@@ -118,11 +120,11 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			 * mapping (kernel .text). PVALIDATE, by way of
 			 * early_snp_set_memory_shared(), requires a valid virtual
 			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 * mapping so use the PA to get a *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
 
-			i = pmd_index(vaddr);
+			i = pmd_index(paddr - p2v_offset);
 			pmd[i] -= sme_get_me_mask();
 		}
 	}
@@ -146,6 +148,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
+	unsigned long va_text, va_end;
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -172,6 +175,9 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	if (load_delta & ~PMD_MASK)
 		for (;;);
 
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
+
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
@@ -232,7 +238,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
 		int idx = i + (physaddr >> PMD_SHIFT);
 
 		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
@@ -257,11 +263,11 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(va_text); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(va_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -269,7 +275,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	return sme_postprocess_startup(bp, pmd);
+	return sme_postprocess_startup(bp, pmd, p2v_offset);
 }
 
 /* Wipe all early page tables except for the kernel symbol map */
-- 
2.44.0.769.g3c40516874-goog


