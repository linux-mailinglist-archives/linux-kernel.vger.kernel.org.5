Return-Path: <linux-kernel+bounces-46754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7728443A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC6728DD35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044C12A166;
	Wed, 31 Jan 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eIGL1Lud"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BEC12837F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717021; cv=none; b=HD6VmarQJ3kMIDerFvGpZACUqiET0vd0yoFYZcot7/ADTBvyxhdyi58skSjGbmq6DZt1m0xVmS4ghNeXTh2N5OI9/hD1+wQ0fh5/rL+n/kaVnLO7AFbZopbJbGegZbq7C8zJxPbM6Q3bTvUHPTyDTtgpnW/71S0l42qBikq736M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717021; c=relaxed/simple;
	bh=2mXgFzRq0Ox+M+gSvM+xy16HnlbLzrNafWWDZOAbpLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEu+y2d10wF/O/eCSqBUHKTF3RzG/qnpd++05fCo6HMwS3h/LVuzXL8GnZAdGszC5WKvd/KhTTX8NRDM3zsHm20ge12OiyWV/IK2Wzg7p4jHXrrO+afpSb98WpVmaYfeTquKxWVCjrZ812L7NOUrETgFLnh50mvgrzVT4CrO5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eIGL1Lud; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ae6dfa923so2567613f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706717018; x=1707321818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G7N9HKTptzFvdsSy7a/wMEV20988NdsE2TTuou7VW4=;
        b=eIGL1LudcuGFTrr5RG4FeVDTObnA0dOg7m/GNoTlUuCkYiHRu7v8zhC6/5eJ6QsqPo
         1yPpTNvOxhkbPJXiAf6CEPLOMPFJGSHCrRhML+7YOp6b0bB6s4LJ7l4e39giqjqckSQk
         YxZ8qzqFvIZS3nLvXSjk4wYNp1LRRLkW/UHlWbO3yOnPvJ9sl1bprx+oJG0c6+SdoQg7
         ipqVD078sl9wEH8hVE+anbSSc01j8iHXJln7HkWZXMCpAwizTAAJibKBosQ7GY1fn8eU
         TLhqrNN1AfyLHwYlehLbdv6xo0gAg8UiiqGum70keeNP7B56mEfyUBc4EbIrfY9n5EBi
         D9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717018; x=1707321818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G7N9HKTptzFvdsSy7a/wMEV20988NdsE2TTuou7VW4=;
        b=jL+/pezcE2wy4UOAc5ynCHMw15qYJ1ddMxs46qcWLOcxXNApoVHF+Vrc78Pu3uH4YS
         OiydEywWwMaRvh4r8KjPd8bumQXQm0yt9UvFA+C0spjcn4zdd8HTFtnuUlGK60WTm/Kv
         9py4zHa6yyKgtegwTayFPpBGga0qY9Gw8rzlyukBfGMHljkCINseFRyM224OSWCDHxJM
         OaQK674akrPAgtPdOs34gQYi1YXR6PXKIYVaR3H1t5FwIhPXsMSLf0iALoQIJ6dH3SNr
         ofdfKUBVQ6ncRuwJZlPJG+pOaNXwhBYrr8uKiAt4cqsQCYNSqURAqoaCDHo6aMtn7quk
         K3wg==
X-Gm-Message-State: AOJu0Yz/IM2iPlQEG3h34FtsbKC9OpYLZDwN8juAzjYiUCdYZbZX3AXP
	WkIIUzdJrTdVBxd4GRlzS07pH4yhRi70ABcD84Mi+FhBZBxqHcqThML/MAC9NE0=
X-Google-Smtp-Source: AGHT+IFv4RsKrg6kAntnJ/YCtPGAW1U1YNeeMXiuO/lnsK9Rn1OpwCBxYmcNw94F8PYwyQot8cihag==
X-Received: by 2002:a5d:4448:0:b0:33a:e6cf:f564 with SMTP id x8-20020a5d4448000000b0033ae6cff564mr1365333wrr.28.1706717018193;
        Wed, 31 Jan 2024 08:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVg1J2yUOavmT1BH4y5nxg3fStQ3N4AW690uC+KVjknvwF1ll2sBXJWTCViTvOYReZkrcvAcX1OMeyRFhnXqudjaBZl/gg5Slh2qMDSCgRbs+MYgkxfwyGouM0xHRs0tgxJCpxbNgoQm1h/C/3NBDpOmt8gVIsv7E96n1TY5vhD8PUSLr9R0dCCkfWeCCPx063FNEcg1j2K+XyPJxLVqJsMLPBwMAa2yiLVZ3yCyGFm+j7Fzm78VPLhSet9sBLkuF7EhUO0JSNmhAm08ItvQD/eyizM4UaWgLJ5IfIEvoIxGnSv1g+/L7u5k1OSXo4eUZCK3WtIs5nc2sntY+iTJ0XM7Sw1HGmFv+717YWEYjUgFkTaZDBVXQ8szzSSQSMga7N2cvCO6sZEEmIdJ3WrbxjU7MsY+3d8+XL7ukOMZvPAA8ULHgKtMBLME0qs6pvJjiy+Ahi0q6IN7XN+z8czcuyGvvHVD505pmNGMbMOVBEgXzcDvj6KG+dXMI7+j2KsumizhlmmeCeIGlGoXRxI8cSqcGpx+z3xdHoptsF2bc/C5MXJ+q72d+EHk9Pq97YjxLi0+gDc1EX/D+NmdurxTc5o3aAmGs8bweDvIDgr9lY+Cqq7S0y8tugvFuJReOmvvT386mI9I7qqIrf8NA==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033b0797cc14sm1358024wrb.51.2024.01.31.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:03:37 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	Dylan Jhong <dylan@andestech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RFC/RFT v2 4/4] riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc
Date: Wed, 31 Jan 2024 16:59:29 +0100
Message-Id: <20240131155929.169961-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131155929.169961-1-alexghiti@rivosinc.com>
References: <20240131155929.169961-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preventive sfence.vma were emitted because new mappings must be made
visible to the page table walker but Svvptc guarantees that xRET act as
a fence, so no need to sfence.vma for the uarchs that implement this
extension.

This allows to drastically reduce the number of sfence.vma emitted:

* Ubuntu boot to login:
Before: ~630k sfence.vma
After:  ~200k sfence.vma

* ltp - mmapstress01
Before: ~45k
After:  ~6.3k

* lmbench - lat_pagefault
Before: ~665k
After:   832 (!)

* lmbench - lat_mmap
Before: ~546k
After:   718 (!)

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 16 +++++++++++++++-
 arch/riscv/mm/pgtable.c          | 13 +++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..50986e4c4601 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -473,6 +473,9 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr)
 {
+	asm_volatile_goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
+			  : : : : svvptc);
+
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
 	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
@@ -482,12 +485,23 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	 */
 	while (nr--)
 		local_flush_tlb_page(address + nr * PAGE_SIZE);
+
+svvptc:
+	/*
+	 * Svvptc guarantees that xRET act as a fence, so when the uarch does
+	 * not cache invalid entries, we don't have to do anything.
+	 */
+	;
 }
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
-#define update_mmu_tlb update_mmu_cache
+static inline void update_mmu_tlb(struct vm_area_struct *vma,
+				  unsigned long address, pte_t *ptep)
+{
+	flush_tlb_range(vma, address, address + PAGE_SIZE);
+}
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index ef887efcb679..99ed389e4c8a 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,6 +9,9 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
+	asm_volatile_goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
+			  : : : : svvptc);
+
 	if (!pte_same(ptep_get(ptep), entry))
 		__set_pte_at(ptep, entry);
 	/*
@@ -16,6 +19,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	 * the case that the PTE changed and the spurious fault case.
 	 */
 	return true;
+
+svvptc:
+	if (!pte_same(ptep_get(ptep), entry)) {
+		__set_pte_at(ptep, entry);
+		/* Here only not svadu is impacted */
+		flush_tlb_page(vma, address);
+		return true;
+	}
+
+	return false;
 }
 
 int ptep_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.39.2


