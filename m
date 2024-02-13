Return-Path: <linux-kernel+bounces-62926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C68527EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5091C22AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD1B65E;
	Tue, 13 Feb 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2vHDOoR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B86A93C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797300; cv=none; b=oIxBiISVNJjNQkoVR+yqR0e/Y3I/HEE8olDR/JhQb6wPCMKDRhg84msPPXkiuMwrRnPvpA0Jeqm5kN7R5qY0ZmXDh2pV5HJCA/7a0HEMZlfVhPYw6nI3nLdjyJrYTdIsWJeovv2C/XBLKy4ed/TU3mD53Tj1CZT2Kr3RzxPw6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797300; c=relaxed/simple;
	bh=XBoMbI6Uy0zLsI3tD3x3/UZWmHsrnqrbzy9wDgXaWQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dxX8DbplxwAWQXxVkW0r7uamFHAPJJcYdZjU2BBLPFMjmRh566A3MK8zdnxBj3CJedfw9YBd2pDnACUhvGhy+gx3aUOfcLbtK2I4AKGZECtCTQrS243PlvszGu+L6NomMSYLhgX1GBBI1Ke7FIgZR6Oo94MEX4yc2IvxtcpH7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2vHDOoR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso6121085276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707797298; x=1708402098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LSkrrIqOo2Ij+GmdViPgbZ5m7gk2v6++xUFUDFhlew=;
        b=O2vHDOoRLOZDWcnDlKeag0kcxDFvWNU1kwZvi5BzAlr907lDQET2BdTu9FavwpVV9y
         4FmIDxj+drNiKHHI9PGqKsHHso7d7d25YWsJZd4ARNImBbiUFsZAxtPWTJg/VFG/LwkO
         NzLUN2PnV6j3D/Jsjzsed2/VkAaGAZAZtrvccquglnGI+nfl0BUC2tcc4cRKccb//odC
         SKhN4Cq5KNvLvJt96bSMRfa1dLN16wACnWYKyeyDw6wgMymMD4MKzOYH44ghCbSRBavn
         +nNT7k2QAlEDbonR65Gy8L8u776xio9CEzSFIQEp3Ye9dMsH2ND/H8/zeiR2hh1SChOG
         d/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707797298; x=1708402098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LSkrrIqOo2Ij+GmdViPgbZ5m7gk2v6++xUFUDFhlew=;
        b=mZXHScTfTHGVMIcJ90+w53iQcrjJw1iJ7Kj7fFOU3BGF+3CIrVSRyJf2AKf8p6VuWg
         6fHXVsuQBnv45aSTPM1LQjS7bIaihPXybTqI8PyPsW/aa3HBp8pBeooQRkkxoDluDYDs
         Xin8nu8vxX1T3YQH/tqSj2jGBTp/MUCcVoZxKOkKl+ygghBQYszdwPUBYdLTSQUVF9Fw
         K7ijc2QLAPcf/uKMMERdtWHIZ4JJIAfYQgxsJtGukhizA9FGDdEySx1zkIL6odJ0efnp
         0Js91VxHytNtTMkmC2IYBJPaIu+dOIueO1onOyD/sYG6FT3NgSkq4GD0ZQGs3ugyb2Vb
         OFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb2irBBhJ+lShtiZJ/5QKiiCn2Ky4xtXiAMQMs0zgCPIqi26o0DWGrE1H6F4d7Of/4eKIGOH8txxW/awS6of787LQvz33dze8F/+RM
X-Gm-Message-State: AOJu0YxgtfomCgT2jDuZXLVHubTr09KWtSMgj9iq/y/3b1apdDsinPZc
	rKu/Su3ZN5Cm6z4qwwzHOhNJaCz1C5fVGFfVIRZ6eS3zvwpJpmw1BIgQzOqoQ8Wf3aF9V+sybg5
	iFrwvbCdSjPXlsXSglkMd3G6NXGQjVQ==
X-Google-Smtp-Source: AGHT+IEDb3dJef0Zkyy9bwxRS2SfFFJmcf+VIfq5dkYdqNR74zlPMeIAAPeD2HTdgHFD0CqG534KUp9VR3UCFcyBLj2W
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6902:1109:b0:dc6:207e:e8b1 with
 SMTP id o9-20020a056902110900b00dc6207ee8b1mr2320133ybu.2.1707797297966; Mon,
 12 Feb 2024 20:08:17 -0800 (PST)
Date: Tue, 13 Feb 2024 04:07:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213040747.1745939-1-kevinloughlin@google.com>
Subject: [PATCH] x86/kernel: Validate ROM before DMI scanning when SEV-SNP is active
From: Kevin Loughlin <kevinloughlin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dionna Glaze <dionnaglaze@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ross Lagerwall <ross.lagerwall@citrix.com>, Kai Huang <kai.huang@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>, 
	Conrad Grobler <grobler@google.com>, Andri Saar <andrisaar@google.com>
Content-Type: text/plain; charset="UTF-8"

SEV-SNP requires encrypted memory to be validated before access. The
kernel is responsible for validating the ROM memory range because the
range is not part of the e820 table and therefore not pre-validated by
the BIOS.

While the current SEV-SNP code attempts to validate the ROM range in
probe_roms(), this does not suffice for all existing use cases. In
particular, if EFI_CONFIG_TABLES are not enabled and
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
falls in the ROM range) prior to validation. The specific problematic
call chain occurs during dmi_setup() -> dmi_scan_machine() and results
in a crash during boot if SEV-SNP is enabled under these conditions.

This commit thus provides the simple solution of moving the ROM range
validation from probe_roms() to before dmi_setup(), such that a SEV-SNP
guest satisfying the above use case now successfully boots.

Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/setup.h |  6 ++++++
 arch/x86/kernel/probe_roms.c | 19 +++++++++----------
 arch/x86/kernel/setup.c      | 10 ++++++++++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c83729c8e71..5c8f5b0d0f9f 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -117,6 +117,12 @@ void *extend_brk(size_t size, size_t align);
 	__section(".bss..brk") __aligned(1) __used	\
 	static char __brk_##name[size]
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void snp_prep_rom_range(void);
+#else
+static inline void snp_prep_rom_range(void) { }
+#endif
+
 extern void probe_roms(void);
 
 void clear_bss(void);
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..83b192f5e3cc 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -196,6 +196,15 @@ static int __init romchecksum(const unsigned char *rom, unsigned long length)
 	return !length && !sum;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void __init snp_prep_rom_range(void)
+{
+	snp_prep_memory(video_rom_resource.start,
+			((system_rom_resource.end + 1) - video_rom_resource.start),
+			SNP_PAGE_STATE_PRIVATE);
+}
+#endif
+
 void __init probe_roms(void)
 {
 	unsigned long start, length, upper;
@@ -203,16 +212,6 @@ void __init probe_roms(void)
 	unsigned char c;
 	int i;
 
-	/*
-	 * The ROM memory range is not part of the e820 table and is therefore not
-	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
-	 * memory, and SNP requires encrypted memory to be validated before access.
-	 * Do that here.
-	 */
-	snp_prep_memory(video_rom_resource.start,
-			((system_rom_resource.end + 1) - video_rom_resource.start),
-			SNP_PAGE_STATE_PRIVATE);
-
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..19f870728486 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -902,6 +902,16 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 
 	reserve_ibft_region();
+
+	/*
+	 * The ROM memory range is not part of the e820 table and is therefore not
+	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
+	 * memory, and SNP requires encrypted memory to be validated before access.
+	 * This should be done before dmi_setup(), which may access the ROM region
+	 * even before probe_roms() is called.
+	 */
+	snp_prep_rom_range();
+
 	dmi_setup();
 
 	/*
-- 
2.43.0.687.g38aa6559b0-goog


