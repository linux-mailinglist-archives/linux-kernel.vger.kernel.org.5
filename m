Return-Path: <linux-kernel+bounces-43285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F48411BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C111A1C24B02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4115B2F6;
	Mon, 29 Jan 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuBUM7eM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C415B2EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551575; cv=none; b=ARFHUuvkpMCGrtINIJAbf97McxWRqXxxZMY6INHRixqCYP/8K7j5CrYyc7+LmpllRVNmL9s97sEMw1kyqlxtq5fsYxRwGZHM6pAwO5f7wDCR0iE6GN6cCVGp9Br4ZN1CoK8Roz54yBgKLwU/zdZ0WGgrzY8mvcquPZEr0EVnnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551575; c=relaxed/simple;
	bh=+rYahPmzXDYe/IO3FyUv8LMIVG+yTpD3LpxEPcnxKUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVsM7QmjPGaA5OUPo1UwA/R78LciFRoPunB9Hav/5YZsNKpIghwzmWe5sRi7UYrYbLokJm6Ni18SvvkM4+ZtFCoAGup7aLjxdDFlzS5eI2eqLxahj/HMuYrgFLB9TKEDLIXPnF67FQUKxqr9aRIYkG0DjZpecen07RIQEtaMXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuBUM7eM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e8810b5f3so25162785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551572; x=1707156372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1we6nPeM2Zvq3sHnH1EZ2vSDoW7zEMVGBC8FJkE9Ugc=;
        b=NuBUM7eMy9VUEvE4klzVPO8suOqnNBJKEIlUbOR4EOJ0cy9n0cLWVhi9uqmckaOKV3
         vKCTVzkhDdfk1NqdoZ1EO3WswEnzzSG3C5Lusb1koMY1n0V03xptgRjGSfgK6+zOV8nP
         xn44PGDrMEbzWx/eI9VTIzVXwmqerB5y++LD66/VpV95ZZ8iW2mBcjDt6CMKcoAGKw+/
         tE+MyU0lNWRqCgE6Nri8xjSxn0luthIgwbSrKlMfS6o0bck+JUnM/CM67R2+kE51vSI+
         lyRoB+Aqm8Qck5I4MsrUspl30qMTrlVvDmpb0EurAuHynhxfqGOgCVAfpbZpJ4iGn7Lx
         sAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551572; x=1707156372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1we6nPeM2Zvq3sHnH1EZ2vSDoW7zEMVGBC8FJkE9Ugc=;
        b=DjsOIELl6T3L7r1n2sAeSv06ZwGg51JHOWhMs0VHDJosisV7swOm7teLjt0f6GdUPU
         tGR2Klhh/e2sNnfL5nidQGUG7J/vNeSTxXLRMQe46AoZVQQUSlKk8qGCRSaS7A7sePzW
         8XIQNA15VmvTNxkQZv+3eB3m5Xakz2cEHvZGgC5/eszX4rq8BwTIZ4ZeuRNRQjuugETd
         t1tyExU0wtAJ0yuRFE0sF2iTPGfWi20Fk31jBhjuzynm2MsfwnAXayk2yfSF1ukj79nQ
         ZpAQHlEcwOFfEeyW7EU4oATbdlaZBCZQvdtK890RXatqsCIeJg6wzRkvPjNqOM5kpFDX
         FtrQ==
X-Gm-Message-State: AOJu0YzjAeqagg/viD3IYF+SaYIjKaCO1Ae/i8Cet5alATXPQYAcYzHf
	2FflBWmO8CB+B508OampJze8B5RgAU0RoNP54aCvK3Shau+Rhdyuvj0W39P9F21CWmhXfw4iqzR
	O0gh1vJjB4Esr5q//xFr5Z1f2g67Yq0opk7CBaRtpr0CJzy8B6BEbnADMaHt5drRrnbxw7Vtnxf
	kYSd45DY/a3E8UQrbmy6Yqnl1NBu5DcQ==
X-Google-Smtp-Source: AGHT+IHZlPWQchy0J38KpxwD5TmOBCD6HsGG1BLHK/s1BgvvkdecR9aOkvWWPLTFP29XujBFiYmoqpYE
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:6012:b0:40e:fa6b:cda8 with SMTP id
 az18-20020a05600c601200b0040efa6bcda8mr10582wmb.7.1706551571814; Mon, 29 Jan
 2024 10:06:11 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:21 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=ardb@kernel.org;
 h=from:subject; bh=b16vPiy6Nf2YAluruWpP640zmYr0MIrigfShg9HjlpU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i0evc6pO7Ltxi++Y3aTSOvsf+18vOOEd7XDs37FJk
 kwxfyOaO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBENp1nZHho+2iy3+ZYHdd9
 a8y1g98YMW3T67f1jI++f8Ps+2uORbmMDB2/ps69muN/7KifQ8rL5Sl2RxY49nk1iJ1N+VQpkCn mzAsA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-39-ardb+git@google.com>
Subject: [PATCH v3 18/19] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The SEV code that may run early is now built with -fPIC and so there is
no longer a need for explicit RIP-relative references in inline asm,
given that is what the compiler will emit as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev-shared.c       | 14 +-------------
 arch/x86/mm/mem_encrypt_identity.c | 11 +----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 481dbd009ce9..1cfbc6d0df89 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -325,21 +325,9 @@ static int __pitext sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		    : __sev_cpuid_hv_msr(leaf);
 }
 
-/*
- * This may be called early while still running on the initial identity
- * mapping. Use RIP-relative addressing to obtain the correct address
- * while running with the initial identity mapping as well as the
- * switch-over to kernel virtual addresses later.
- */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &cpuid_table_copy;
 }
 
 /*
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index bc39e04de980..d01e6b1256c6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -85,7 +85,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-
 static void __pitext sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -329,14 +328,6 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
 	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
@@ -346,7 +337,7 @@ void __pitext sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)sme_workarea;
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
-- 
2.43.0.429.g432eaa2c6b-goog


