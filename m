Return-Path: <linux-kernel+bounces-101463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD987A771
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633C2848B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09CB405DF;
	Wed, 13 Mar 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM6KlLQB"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8F3FB31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332158; cv=none; b=auenEH56gdWgZtynN+bDL2hvyxjWt+trzhb9U7Mq7ds2fIU3gu+Up0J0hVUOF2Ir+7d+8YNohcAuAA+qiTwwP/64Svp6E1F4XsDjZJrJKFy/7nphJwvldEV3pgkMBVH+FINi6/xhqZmG5YpIt1xMPCnNYAUGb9VQn7iM9VO2zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332158; c=relaxed/simple;
	bh=dkUB9wnT+ROTIlGEq5my5F8pptxmnWUfovVOsAzGCIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQcL9w21h2Ygxg4BkhDaupBl+35bd7LZt/qCz1SKbnL1I1EBJ9VaI1YHDnOU/xezmUu9CXOqmDjpqpZdV0tfu5+ee1poDoWLNS2fIGJdBdSYHcBkQEuQyH5G2KOGlMN4PRhStmAj+jL2eYDvJXw45BAfttkCRuBCi8isFwT1jRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM6KlLQB; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so97345739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710332156; x=1710936956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IVXv5XWRW4Js6IrV9c99U7XX1V10SaT+q2mn4wq5sY=;
        b=kM6KlLQBymxbtfp/E9n4x53uM3pPraBSmAKJba7Lg90EEH1DpR3SGeFXSp33f+4+cu
         BWgjCQqkhpCbIZc4LP6j+NDAuX5SbbJRW/S75MQVFPwIrlDQL4qYyzxmdR5DAECYapcK
         5tFvb+5iQAFPmksID4tszfvEoDeRxH94zh43qhWp7uoyQQaT5jR3gvzHeZZmeKdIO4og
         7HjPg7BogUc/D89ytV48ecZT0yRnSzcfoJeLj/jwpUi4XEgwVexhNrbfia/9VvkC4aoi
         FUD873WELS3wyWvwQOvh5ohh6mCXvvRlP+4fK0OK/W3RuwC37Llhc67QKIL9nU4RzuBX
         2kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332156; x=1710936956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IVXv5XWRW4Js6IrV9c99U7XX1V10SaT+q2mn4wq5sY=;
        b=MPfeyvC0JFvFQln0PDlvp9LFP8hVfFyOd2B3qHztDxsZpoms3M5utJ3z0u0ghKzqVf
         Bj7iDjHuE3Zbzw+PRvdSyWdIDyden+VQHk6fxYNAdbbCFmrfyfZNxbyzRSPObjWo8ig+
         RtPDEy+cag32nvYiCD4/IRibrI1381cDYAU6pcNLv5XoMf5Y2dx9k+7H45Z+tJ/loxDs
         9rPCC9LYiRti3gKc4IdPG/uL77KwQGzJIlsMa+tfU8s3BKZVT5lDKMURWutc797sz0ny
         5CNE/tPukBSdweGahfyCsd+L9w4b+Bfye3sgVBeeSRwXPx7s/45aNskqqnKgn776L3zl
         cpOA==
X-Forwarded-Encrypted: i=1; AJvYcCWUXmAe2NUR/AgwplanIo3Ru/monz+Wz3D1iWQgJ8sydCOFsYXvJfq8Qvg/RyZF1uMrmwzHLhmGdFP/6xgNTxZkU7ll65rvnTvepuWr
X-Gm-Message-State: AOJu0YyFS8FXpz7NO8X/dOMDzJTIZZiIY0hg9bvjADbK94E21CHvaXhN
	kwVzzduol9fcLvxCxzErtz6+E61kKaJubB6j/xAbs/uiKXaxELQEFwU+kLX5rgNq+lrXJgQXJv2
	ptVhOkn7PP2lMyg9YTV3xHm2pgJgwcQ==
X-Google-Smtp-Source: AGHT+IHwtBy2AW51j7Z58lhJL/kwqUa9f9do7EDyECN2aYLniN3wjW63gSbP1dV41wxXcF2rcJ36bZGwGv/M6qghivYs
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6602:3401:b0:7c8:c6d3:27dd with
 SMTP id n1-20020a056602340100b007c8c6d327ddmr259660ioz.1.1710332155749; Wed,
 13 Mar 2024 05:15:55 -0700 (PDT)
Date: Wed, 13 Mar 2024 12:15:46 +0000
In-Reply-To: <CAMj1kXGisJjijwo5JOknWtUTECC9pzkd9qpRhsGCSoGT8Jic6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMj1kXGisJjijwo5JOknWtUTECC9pzkd9qpRhsGCSoGT8Jic6g@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240313121546.2964854-1-kevinloughlin@google.com>
Subject: [PATCH v3] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
From: Kevin Loughlin <kevinloughlin@google.com>
To: ardb@kernel.org
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, bhe@redhat.com, bp@alien8.de, brijesh.singh@amd.com, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	kevinloughlin@google.com, linux-kernel@vger.kernel.org, michael.roth@amd.com, 
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
However, this behavior is neither sufficient nor necessary for the
following reasons.

With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
falls in the ROM range) prior to validation. For example, Project Oak
Stage 0 provides a minimal guest firmware that currently meets these
configuration conditions, meaning guests booting atop Oak Stage 0
firmware encounter a problematic call chain during dmi_setup() ->
dmi_scan_machine() that results in a crash during boot if SEV-SNP is
enabled.

With regards to necessity, SEV-SNP guests generally read garbage (which
changes across boots) from the ROM range, meaning these scans are
unnecessary. The guest reads garbage because the legacy ROM range
is unencrypted data but is accessed via an encrypted PMD during early
boot (where the PMD is marked as encrypted due to potentially mapping
actually-encrypted data in other PMD-contained ranges).

In one exceptional case, EISA probing treats the ROM range as
unencrypted data, which is inconsistent with other probing.

Continuing to allow SEV-SNP guests to use garbage and to inconsistently
classify ROM range encryption status can trigger undesirable behavior.
For instance, if garbage bytes appear to be a valid signature, memory
may be unnecessarily reserved for the ROM range. Future code or other
use cases may result in more problematic (arbitrary) behavior that
should be avoided.

While one solution would be to overhaul the early PMD mapping to always
treat the ROM region of the PMD as unencrypted, SEV-SNP guests do not
currently rely on data from the ROM region during early boot (and even
if they did, they would be mostly relying on garbage data anyways).

As a simpler solution, skip the ROM range scans (and the otherwise-
necessary range validation) during SEV-SNP guest early boot. The
potential SEV-SNP guest crash due to lack of ROM range validation is
thus avoided by simply not accessing the ROM range.

In most cases, skip the scans by overriding problematic x86_init
functions during sme_early_init() to SNP-safe variants, which can be
likened to x86_init overrides done for other platforms (ex: Xen); such
overrides also avoid the spread of cc_platform_has() checks throughout
the tree. In the exceptional EISA case, still use cc_platform_has() for
the simplest change, given (1) checks for guest type (ex: Xen domain
status) are already performed here, and (2) these checks occur in a
subsys initcall instead of an x86_init function.

Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/sev.h      |  4 ++--
 arch/x86/include/asm/x86_init.h |  3 ++-
 arch/x86/kernel/eisa.c          |  3 ++-
 arch/x86/kernel/probe_roms.c    | 10 ----------
 arch/x86/kernel/setup.c         |  3 +--
 arch/x86/kernel/sev.c           | 27 ++++++++++++---------------
 arch/x86/kernel/x86_init.c      |  2 ++
 arch/x86/mm/mem_encrypt_amd.c   | 17 +++++++++++++++++
 8 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9477b4053bce..07e125f32528 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -218,12 +218,12 @@ void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 				 unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -244,12 +244,12 @@ static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
-static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b89b40f250e6..6149eabe200f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -30,12 +30,13 @@ struct x86_init_mpparse {
  * @reserve_resources:		reserve the standard resources for the
  *				platform
  * @memory_setup:		platform specific memory setup
- *
+ * @dmi_setup:			platform specific DMI setup
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
+	void (*dmi_setup)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index e963344b0449..53935b4d62e3 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -2,6 +2,7 @@
 /*
  * EISA specific code
  */
+#include <linux/cc_platform.h>
 #include <linux/ioport.h>
 #include <linux/eisa.h>
 #include <linux/io.h>
@@ -12,7 +13,7 @@ static __init int eisa_bus_probe(void)
 {
 	void __iomem *p;
 
-	if (xen_pv_domain() && !xen_initial_domain())
+	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
 	p = ioremap(0x0FFFD9, 4);
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..cc2c34ba7228 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -203,16 +203,6 @@ void __init probe_roms(void)
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
index 46d5a8c520ad..6064dffe590c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -9,7 +9,6 @@
 #include <linux/console.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
@@ -902,7 +901,7 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 
 	reserve_ibft_region();
-	dmi_setup();
+	x86_init.resources.dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b59b09c2f284..7e1e63cc48e6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/init.h>
@@ -795,21 +796,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
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
@@ -2136,6 +2122,17 @@ void __head __noreturn snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+/*
+ * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
+ * enabled, as the alternative (fallback) logic for DMI probing in the legacy
+ * ROM region can cause a crash since this region is not pre-validated.
+ */
+void __init snp_dmi_setup(void)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		dmi_setup();
+}
+
 static void dump_cpuid_table(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a42830dc151b..d5dc5a92635a 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -3,6 +3,7 @@
  *
  *  For licencing details see kernel-base/COPYING
  */
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
@@ -66,6 +67,7 @@ struct x86_init_ops x86_init __initdata = {
 		.probe_roms		= probe_roms,
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
+		.dmi_setup		= dmi_setup,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de2e053..01e7feda6ed7 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -492,6 +492,23 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Override init functions that scan the ROM region in SEV-SNP guests,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		x86_init.mpparse.find_mptable = x86_init_noop;
+		x86_init.pci.init_irq = x86_init_noop;
+		x86_init.resources.probe_roms = x86_init_noop;
+
+		/*
+		 * DMI setup behavior for SEV-SNP guests depends on
+		 * efi_enabled(EFI_CONFIG_TABLES), which we haven't parsed yet.
+		 * snp_dmi_setup() will run after we have this information.
+		 */
+		x86_init.resources.dmi_setup = snp_dmi_setup;
+	}
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.44.0.278.ge034bb2e1d-goog


