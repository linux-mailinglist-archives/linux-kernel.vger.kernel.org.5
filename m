Return-Path: <linux-kernel+bounces-81626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15131867880
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940ED1F2D5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198A12BF04;
	Mon, 26 Feb 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoHW0QlT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8712AAFD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957814; cv=none; b=rndO+nmJsNVSKgLGiWhJvHGnjhKu/DZE5UyRjrEehcUeQpUs5N+zdVEo2J5oHfDBovxLNr0xdeMixUiKG6n5K761nWoNmFPRB3q1Ihn63kdPhPsG0looOqy7CqaaKmAhtCZRlcQsS1Ah5VOOSXzZHhgTpUeoyVUxmo/x+9FZzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957814; c=relaxed/simple;
	bh=Utd3yQPUC0h02QRLBQM2S7ZyErEnyX3W+vykofMJQFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q/gtesRNHsCZMLpcW7We0h2GIhi9GbXvYOb7anuI1ewQAjYAwk2Srbn6l5gWzC+BxgpFSJnWaFeKebk3kcOilMF1moiDcRKr7SanbzWx0bDThOIbQNw0eF8MtLHDdSH/X0rnHeV5uam2SAS/2nof7Bc999P47dqNqUsxAKZUyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoHW0QlT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso5512061276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957811; x=1709562611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsB2jfEOHuf9jjlesr7NzHbxyyk9Sr8XgRsNb8f+ZY8=;
        b=OoHW0QlTt+6ui2iCVYPBLT60E9F9CByU5XvLUZd5ublCIc8NAc28sOP39TW48T+bDE
         FSANlgvTTmtwUy/WW6mKWCCDX/x7bduQ6f+0f86+GaRoOONh6mNUoLYTfCP2jWLXCDrG
         gwYZcycXA+tSOen9u5hKa66iPPCHvQnjDciF96ep3n/6HSFFRfVAanmLBVrSHfTc89ZD
         C7j9gdVamb/hJu9VbuV2eno1/9UNkfJ0F2Yo0QL4v2C9MfVaCTNcXqr+s8DaG3C0XsSu
         /T6jNO+n8K506tnzad9UbvXsXoLcsew5NxQCf4gsp4EpziemDWJPBRq4xFABkUIsiUbD
         wTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957811; x=1709562611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsB2jfEOHuf9jjlesr7NzHbxyyk9Sr8XgRsNb8f+ZY8=;
        b=PlyywtjX+O8yqzh//nLALbH6WaH35UepzZNg0MZb92RIzrpeaAQ3sP7iVb8Pncqhbo
         d6/41EmAAfsN8gE19JUQ83n7GvZ8UcgrveswmrK8a/DeSo7dVZ6ZQYWBKtvNTqGDjKzj
         5SyTbEkulTg6gMi+dnbzOLTKoPWS0PVNlyIRc1I6XNplCBHQJ25eTVZqeLtt7aJS6PL9
         Udi1uRVJYSuOWKnXxZ0XqoyFpfO4aHEpI+XbiAHRvrJ5DyZHZaYkUym5odpB6ds1qUkC
         V6mvtpNaUKG4KJFERCH1wmVa/IGocw+Ft/HYvUe1796HJ8DVLzq2Yaj7ZFLRVTAi7BhN
         VVbg==
X-Gm-Message-State: AOJu0YwHyYOKkINmmOVsvxp2iXKy8bZNLTJ7aSF40Xx/r7qYpuQ6OLiS
	Fb97FOJmIE54JelsvWeo+8b8+0BQTH5RjHBQq+BRoSmZsfPJg6pWFSbbFraagja43qQgKG2ZDGC
	in/IHr9so79/tzWbZDVQG7oc/VRSo/4sXTA8SRkiVTMhcyN2WC4y+OHPWeNrBqCrruHHnbt3Na5
	o6Wqov0dB/mJ7deykSnYReH0gjbt3kEQ==
X-Google-Smtp-Source: AGHT+IFltmwWE+KHZ86ltSizPX/JX5VPOJZG/zt/0B9smCurYKfkFe7vkPzKoLEm9WuOD/stA7YTkGVS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1009:b0:dc7:5aad:8965 with SMTP id
 w9-20020a056902100900b00dc75aad8965mr2159556ybt.0.1708957811244; Mon, 26 Feb
 2024 06:30:11 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:58 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-17-ardb+git@google.com>
Subject: [PATCH v6 05/10] x86/sme: Avoid SME/SVE related checks on non-SME/SVE platforms
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Reorganize the early SME/SVE init code so that SME/SVE related calls are
deferred until it has been determined that the platform actually
supports this, and so those calls could actually make sense.

This removes logic from the early boot path that executes from the 1:1
mapping when booting a CONFIG_AMD_MEM_ENCRYPT=y kernel on a system that
does not implement that (i.e., 99% of distro kernels)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/mem_encrypt.h | 4 ++--
 arch/x86/kernel/head64.c           | 6 +++---
 arch/x86/mm/mem_encrypt_identity.c | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b31eb9fd5954..b1437ba0b3b8 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,7 +48,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 void __init sme_early_init(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -82,7 +82,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 static inline void __init sme_early_init(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index deaaea3280d9..f37278d1cf85 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -98,9 +98,6 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	unsigned long vaddr, vaddr_end;
 	int i;
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
 	/*
 	 * Clear the memory encryption mask from the .bss..decrypted section.
 	 * The bss section will be memset to zero later in the initialization so
@@ -108,6 +105,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
+		/* Encrypt the kernel and related */
+		sme_encrypt_kernel(bp);
+
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780cc..7ddcf960e92a 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,6 +45,7 @@
 #include <asm/sections.h>
 #include <asm/cmdline.h>
 #include <asm/coco.h>
+#include <asm/init.h>
 #include <asm/sev.h>
 
 #include "mm_internal.h"
@@ -502,18 +503,15 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __head sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
 	char buffer[16];
-	bool snp;
 	u64 msr;
 
-	snp = snp_init(bp);
-
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
@@ -546,7 +544,7 @@ void __init sme_enable(struct boot_params *bp)
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp_init(bp) && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
-- 
2.44.0.rc0.258.g7320e95886-goog


