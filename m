Return-Path: <linux-kernel+bounces-95737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35B8751E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25965287456
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F1412EBF0;
	Thu,  7 Mar 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPJ12QAR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938012EBC2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821848; cv=none; b=dOt0AhKxPoRhsoOkyX7EOS1kC7eVGJg8z1QYroXd9V5Knfi5DN088T0YNQ/8T+Egwv8Rz/96vuPRjMjBioCbTUH4dtoL3hJNO7HkmUgRxjw8kzSTglO8UzhQBGBoEcSyrjEHjb2e54ADW2kdEAw2ivNgM7MvOlv6agiN4HOUH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821848; c=relaxed/simple;
	bh=oaGQTO9luyA1dteSa+4qqlvHDFigMH5F3heVKjg7GMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0+Jhew6YZ5cL28/PPDXOtBucFzCLFOAgOVQe52ftNXBhBHPgQQ2UOT06mduZmcIZm342353ZRVUjV/GuoiOGSvWiABVafLwfaFbIELojG61Q/P8Nv2F7ATbvVNV48M19MZfVIBtmqLsYRnUoFt7Xz9IXBvU208mpUWf2Ai/jYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPJ12QAR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso5859255e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709821845; x=1710426645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwFvCKrt+d0oxGZrk5wgvuoGdNeo5P2mAmgnzHjy5R0=;
        b=BPJ12QARhtgGNTlUvuuEdM6DdfsxQxNAtrI34wZ1Fn+pLGFzIvH0gwEpOs1smAF8QG
         DjcQ+s6Na0Ci8VBpxwQD84tX7LLGMlf/cDCJWCrv6wZhvi6oR17ORB5XLVoPEWnhH0Cb
         QlJjnkgVmEoQrLDgdTuGUA5FdfMt/JOcFE5qq8VxLrc5dsYHpe2ZmnNuPVaIxii4AhH6
         ZL1Uvdia97OsqE408wsIBQLZ4mrcSk2vH5Ei9wJKQlB72g810LOwNciSUcjgGVZaNN6j
         SAXY1IbjfvkvONZL/vHqII5J8IC8l1DFw4x2sHQgB/MBMUux9UTQPfn9lfV54+QBenHn
         HwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821845; x=1710426645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwFvCKrt+d0oxGZrk5wgvuoGdNeo5P2mAmgnzHjy5R0=;
        b=dudZt7fZpngFVthLRkohUHIeBQBJ0x84yOZN1lcz5FW2v6IROXbXuxPq4iq1hfmCbA
         N2nZ4TBsECg1Z+ICMl7byLLwevtx3/wgK4YRuq9j3e15gT64Gtp61+EuKjgH1UtIV7dC
         V6x2bwgU63QHOwExn+2au/TKCWQsWhrFBR4OLl17tmKsERENHJoxg0+iTOqh8QRzDvur
         RAncLNMCu8xgkP2/0B5ouRMM8x+o4ZxRXxkXnivhEd7obFLD0VDmL4a7NqjrdHSdmMtr
         HjRxksSB3UeSKXxRllp+UxpsspJab55l+nQwlzHBMpEw74tZ0pbKb8uyl+M6Cg1EQspb
         NNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe+jBmwf6sz6hTnigUKvcF7hDNEMlc+V38YFmSuESJqfi4SMekbqXAebOLhf16TydtsiO74LTsX4dygh/J3sMwnlZR0UHK4Q2C5X42
X-Gm-Message-State: AOJu0YxAOiEFafdBL8Ri2ubstFvg2ZGKNFl7z7v4HbAdUU/ybxPS/qxj
	fGbAukc43FqjsM2fbkVqPGDxJbbZxueC+75MOviFn3no/7RhrHLUIVUKLHp2S6BwiT+hEQ==
X-Google-Smtp-Source: AGHT+IGQhfDaNFbUMdd/J/r3AXp5Xxg9XcGDMrTIR6//AlLTtBwGu9ztz7h/WTXNlIa4UTPzeHWhzIX2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d91:b0:413:12cf:34d0 with SMTP id
 p17-20020a05600c1d9100b0041312cf34d0mr14418wms.5.1709821844871; Thu, 07 Mar
 2024 06:30:44 -0800 (PST)
Date: Thu,  7 Mar 2024 15:30:31 +0100
In-Reply-To: <20240307143027.206179-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307143027.206179-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=ardb@kernel.org;
 h=from:subject; bh=77RbHvOJpbrg6l/+8dtejLv1WS4wYZ8tyTI8HvYUCr4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXl+fYXBy6y7e1da/bsxy7NlkpG7VNZ79r6yn1MVVMMy
 s+fMVzYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaySYORYenTS4fPV5l/nxPz
 weeB/IMEWfO3+3vvXBNI4Vp7j7GgeDIjw3Pu2a6LhPbf456gU3ygp4vTf/Kx9G05FdPjZ1k2njU TYQEA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307143027.206179-9-ardb+git@google.com>
Subject: [RFC PATCH v6.10 3/4] x86/boot/64: Determine VA/PA offset before
 entering C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@google.com
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

We will start using an explicit virtual-to-physical offset in the early
1:1 mapped C code to derive the kernel virtual addresses of _text and
_end without having to rely on absolute symbol references, which should
be avoided in such code.

Currently, phys_base is used for this purpose, which is derived from the
kernel virtual address of _text, and this would lead to a circular
dependency. So instead, derive virtual-to-physical offset in asm code,
using the kernel VA of common_startup_64, which we already keep in a
global variable for other reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h | 3 ++-
 arch/x86/kernel/head64.c     | 8 +++++---
 arch/x86/kernel/head_64.S    | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d71cba..cc1994516af2 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -47,7 +47,8 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp,
+				  unsigned long va_offset);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e06aeba..8fd80cf07691 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -131,10 +131,12 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF().
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting va_offset from the RIP-relative address.
  */
 unsigned long __head __startup_64(unsigned long physaddr,
-				  struct boot_params *bp)
+				  struct boot_params *bp,
+				  unsigned long va_offset)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long pgtable_flags;
@@ -156,7 +158,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = __START_KERNEL_map + va_offset;
 	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 79f7c342e3da..3622744349d1 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -107,6 +107,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 */
 	leaq	_text(%rip), %rdi
 	movq	%r15, %rsi
+	leaq	common_startup_64(%rip), %rdx
+	subq	0f(%rip), %rdx
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-- 
2.44.0.278.ge034bb2e1d-goog


