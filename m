Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86ED772A53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHGQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHGQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:17:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E810CF;
        Mon,  7 Aug 2023 09:17:09 -0700 (PDT)
Date:   Mon, 07 Aug 2023 16:17:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691425027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1J6/XJHA6bwbRRigYF+K38WbO59nZ7IUa3YfUFyvtM=;
        b=3g5LqPra0pdThL+PNXAA4M+FT9DFKSGjDficXnuypV4czn9GytEIKs9lu83nWTJ4zm+LG5
        ycao8T9X4swT/+2qhqFKRPiKy2SzMtoLaTUesE7NU18z2FVzS/3pMjtCi6jR2pIppri1qn
        xIZF4zM5uX2o2p41H0C4Tt+RJkbRKA0c3qQS/Y0qNoqnpw3r0WvbGAC5wyvgUzfBYDo/vp
        uV+QqYvegMr4GvhjwfMXocqP53RIohELfhnfBy/Mvw4r1kwUSeG7Mh36SiyTFDje0g6AdO
        +Ay6xAP4l+LDf+GF8dc1ZxOv3tUkZMmWuMFZV+J9P6TdYy/wvrLMRIgbv4o2Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691425027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1J6/XJHA6bwbRRigYF+K38WbO59nZ7IUa3YfUFyvtM=;
        b=6ZqrdrHPAERu1N9ypC7FehYPYwIMptyGtZLlARNovd2NMAc5FBhzgx2AabxnnFO0bQvKPk
        I0UhbvApgULXdAAg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Do not try to parse for the CC blob on
 non-AMD hardware
Cc:     Tao Liu <ltao@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230601072043.24439-1-ltao@redhat.com>
References: <20230601072043.24439-1-ltao@redhat.com>
MIME-Version: 1.0
Message-ID: <169142502710.28540.13313883143989495944.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bee6cf1a80b54548a039e224c651bb15b644a480
Gitweb:        https://git.kernel.org/tip/bee6cf1a80b54548a039e224c651bb15b644a480
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 16 Jul 2023 20:22:20 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 18:05:13 +02:00

x86/sev: Do not try to parse for the CC blob on non-AMD hardware

Tao Liu reported a boot hang on an Intel Atom machine due to an unmapped
EFI config table. The reason being that the CC blob which contains the
CPUID page for AMD SNP guests is parsed for before even checking
whether the machine runs on AMD hardware.

Usually that's not a problem on !AMD hw - it simply won't find the CC
blob's GUID and return. However, if any parts of the config table
pointers array is not mapped, the kernel will #PF very early in the
decompressor stage without any opportunity to recover.

Therefore, do a superficial CPUID check before poking for the CC blob.
This will fix the current issue on real hardware. It would also work as
a guest on a non-lying hypervisor.

For the lying hypervisor, the check is done again, *after* parsing the
CC blob as the real CPUID page will be present then.

Clear the #VC handler in case SEV-{ES,SNP} hasn't been detected, as
a precaution.

Fixes: c01fce9cef84 ("x86/compressed: Add SEV-SNP feature detection/setup")
Reported-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tao Liu <ltao@redhat.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230601072043.24439-1-ltao@redhat.com
---
 arch/x86/boot/compressed/idt_64.c |  9 ++++++-
 arch/x86/boot/compressed/sev.c    | 37 ++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 6debb81..3cdf94b 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -63,7 +63,14 @@ void load_stage2_idt(void)
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	/*
+	 * Clear the second stage #VC handler in case guest types
+	 * needing #VC have not been detected.
+	 */
+	if (sev_status & BIT(1))
+		set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	else
+		set_idt_entry(X86_TRAP_VC, NULL);
 #endif
 
 	load_boot_idt(&boot_idt_desc);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c1..c3e343b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -405,12 +405,45 @@ void sev_enable(struct boot_params *bp)
 		bp->cc_blob_address = 0;
 
 	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
+	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
+	/* Now repeat the checks with the SNP CPUID table. */
+
+	/* Recheck the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -418,7 +451,7 @@ void sev_enable(struct boot_params *bp)
 		return;
 
 	/*
-	 * Check for the SME/SEV feature:
+	 * Recheck for the SME/SEV feature:
 	 *   CPUID Fn8000_001F[EAX]
 	 *   - Bit 0 - Secure Memory Encryption support
 	 *   - Bit 1 - Secure Encrypted Virtualization support
