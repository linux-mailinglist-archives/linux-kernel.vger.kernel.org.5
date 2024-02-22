Return-Path: <linux-kernel+bounces-77314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B968603A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37471F271C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C56E600;
	Thu, 22 Feb 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I66Qvrs8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07A6AF9C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633522; cv=none; b=OGN+FnePvTIupIfPEZfQ95XJB6UcOwMdAPH93r+n8mItnnGmieb3N4P5xcHxnFlfJFBwQLJMsGL0SgxYHQscrqa00K8Tmyh8DuV8oA5t05kPgeU/fT5eh7LljEax+UlBXvcaBggPkEmSTJXGGA8KKx8UbJf5wyL0Y7+AmGsib7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633522; c=relaxed/simple;
	bh=GhX7pwbOYCqRMcp+weEXUYKxSzB6csO0jQ0zAcWnGtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0QXAhpNSTE9f2SdKAXlHFEMg/yuqhGS09zaQiOLmFxdB5HO3wD7fNr/ZR4RDrh/YI3o55BzFsX6UIsJDyvHp0JPY20WfflQ771HZVz8Nld8mrX57TvbVMPUV5kU0S1e/n7+MyesJeo1HarYRodddAPfHLXFlY6j43Ajo9ZXzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I66Qvrs8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so166565276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708633520; x=1709238320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqRllDY0UBnJw6Q9XItVV5VaAH263yN268uUTZZqAnE=;
        b=I66Qvrs8veBtt01lAwG1I4qVnKhWn+8UQtFRnx4UwrDX18qY+V0b1tD8VPLmDpiIDP
         PuMj4t+p/1B5S6vVvoEwecyZQRIAToerGJsC32S5XC/8dmvYa2jM6GRGp5ZtUCQks6i3
         8gUbCnAT63Xmc/AP6qBFjN06hpAWg+53jZx5ghAdQiB2XVECMCOyMbDftCt2lSgcuRas
         OEEjAMQg1HpVybPIJGls+zWAyQrf2kfuXLVrDpsSnbKzB9ybItAi0V7XV6hgcG/fvEcj
         QyBGs/CWrzkLk0Wm4T4oqRIHIzLibLCZiMC/kH3rSw6ju5CTR+opKJdOQvQR2minmsGb
         iM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633520; x=1709238320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqRllDY0UBnJw6Q9XItVV5VaAH263yN268uUTZZqAnE=;
        b=ZRWKnMqrVoeGCvJw2F20hYzlHzVmZUwWaAHpdmHbA4oguB2VgH1G4ybcj7PJk96lxO
         KybetJr11M5Sx+3RfpkO1Gq0Z9/WFqfExQLaWu+9+tyQBadw1RyA68XC0cPdzBOfHujz
         g4+B1NEIZm6hHsqTLhy20Fh1ObAnsByuqDIf8yoqMuxmk1/wyEAT6PclbHbjr1EXP8i7
         gwvnDcvqe5i/nLxSD0lxy4x4Rx1D/NiFwdxPwt5gAMMLCjDG+u4QjlWLdmBqsCjOxIQ8
         zjz8OLG1YslIK3oQkMKEHYRhRrNm1hqLfuKdu50ITk2AG0H9cv4ahmV+JU489ZcINf3f
         0QHA==
X-Forwarded-Encrypted: i=1; AJvYcCV65r6O29OdhDMaPs2Tz8sIYN/0wehTIGl0IzvZy6pYNDJdjiYzSTDJrOuAnSKYSoze8J5sKUf2mzl6x8q50CCOWoK+dLeSYX7cl00J
X-Gm-Message-State: AOJu0YzT/lXF8aZPqOY0qYL4LN5fgWLxWBGewGnZunLsbDjCBC258n78
	eg+/w1QnbdLZEZuhAqY+mQbEtEC8A4r0t4riAq1wTp5kOdiRXshWj+KaztTJlfZkbcHcSqSNbWG
	19/5PnWfk2WBHX2kyVftiSbOCjrvEQQ==
X-Google-Smtp-Source: AGHT+IHON1RHH6MHrwSblIMil50cfYUUFCs9KW6oxd28Y54Gkj+adfLKjreHglkh/QgcfXKsQH1Yc7m7SrKENmDzgOQH
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6902:2412:b0:dc2:3441:897f with
 SMTP id dr18-20020a056902241200b00dc23441897fmr50998ybb.6.1708633519792; Thu,
 22 Feb 2024 12:25:19 -0800 (PST)
Date: Thu, 22 Feb 2024 20:24:04 +0000
In-Reply-To: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222202404.36206-1-kevinloughlin@google.com>
Subject: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
From: Kevin Loughlin <kevinloughlin@google.com>
To: kevinloughlin@google.com
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, ardb@kernel.org, bhe@redhat.com, bp@alien8.de, 
	brijesh.singh@amd.com, dave.hansen@linux.intel.com, dionnaglaze@google.com, 
	grobler@google.com, hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, 
	kai.huang@intel.com, linux-kernel@vger.kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, peterz@infradead.org, pgonda@google.com, 
	ross.lagerwall@citrix.com, sidtelang@google.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"

SEV-SNP requires encrypted memory to be validated before access.
Because the ROM memory range is not part of the e820 table, it is not
pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
to access this range, the guest must first validate the range.

The current SEV-SNP code does indeed scan the ROM range during early
boot and thus attempts to validate the ROM range in probe_roms().
However, this behavior is neither necessary nor sufficient.

With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
falls in the ROM range) prior to validation. The specific problematic
call chain occurs during dmi_setup() -> dmi_scan_machine() and results
in a crash during boot if SEV-SNP is enabled under these conditions.

With regards to necessity, SEV-SNP guests currently read garbage (which
changes across boots) from the ROM range, meaning these scans are
unnecessary. The guest reads garbage because the legacy ROM range
is unencrypted data but is accessed via an encrypted PMD during early
boot (where the PMD is marked as encrypted due to potentially mapping
actually-encrypted data in other PMD-contained ranges).

While one solution would be to overhaul the early PMD mapping to treat
the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
data from the legacy ROM region during early boot (nor can they
currently, since the data would be garbage that changes across boots).
As such, this patch opts for the simpler approach of skipping the ROM
range scans (and the otherwise-necessary range validation) during
SEV-SNP guest early boot.

Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
validation is avoided by simply not accessing the ROM range.

Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/sev.h   |  2 --
 arch/x86/kernel/mpparse.c    |  7 +++++++
 arch/x86/kernel/probe_roms.c | 11 ++++-------
 arch/x86/kernel/sev.c        | 15 ---------------
 drivers/firmware/dmi_scan.c  |  7 ++++++-
 5 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..474c24ba0f6f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 					 unsigned long npages);
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
@@ -227,7 +226,6 @@ static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
-static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922248e9..39ea771e2d4c 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 		    base, base + length - 1);
 	BUILD_BUG_ON(sizeof(*mpf) != 16);
 
+	/*
+	 * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
+		return 0;
+
 	while (length > 0) {
 		bp = early_memremap(base, length);
 		mpf = (struct mpf_intel *)bp;
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..84ff4b052fc1 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -204,14 +204,11 @@ void __init probe_roms(void)
 	int i;
 
 	/*
-	 * The ROM memory range is not part of the e820 table and is therefore not
-	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
-	 * memory, and SNP requires encrypted memory to be validated before access.
-	 * Do that here.
+	 * These probes are skipped in SEV-SNP guests because the ROM range
+	 * is not pre-validated, meaning access would cause a crash.
 	 */
-	snp_prep_memory(video_rom_resource.start,
-			((system_rom_resource.end + 1) - video_rom_resource.start),
-			SNP_PAGE_STATE_PRIVATE);
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
 
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..d2362631da91 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
-{
-	unsigned long vaddr, npages;
-
-	vaddr = (unsigned long)__va(paddr);
-	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		early_snp_set_memory_private(vaddr, paddr, npages);
-	else if (op == SNP_PAGE_STATE_SHARED)
-		early_snp_set_memory_shared(vaddr, paddr, npages);
-	else
-		WARN(1, "invalid memory op %d\n", op);
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a825d3..22e27087eb5b 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
 			dmi_available = 1;
 			return;
 		}
-	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
+	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
+		!cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		/*
+		 * This scan is skipped in SEV-SNP guests because the ROM range
+		 * is not pre-validated, meaning access would cause a crash.
+		 */
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
 			goto error;
-- 
2.44.0.rc0.258.g7320e95886-goog


