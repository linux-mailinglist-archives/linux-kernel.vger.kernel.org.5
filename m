Return-Path: <linux-kernel+bounces-87681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2C86D7AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0670D1F22D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7197145654;
	Thu, 29 Feb 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nDD9n6Tf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD014375E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248944; cv=none; b=QExdE5RHg8Zg4i/1yZSK7Ad+/HuBpNTOJ7ioKYbDavJsYupVEHBPTzKtx9rgEr7PhpQvije6K+GXZAqV1cIxF0CkISQaYPq5zh/fTGzFzKvHCE2S+Stab7zTmwOBUv7qfoSK4mGeMOinxxwb4t7W0rpVPKmFULeedN44wssXYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248944; c=relaxed/simple;
	bh=efpj5keG/fa3VmpEzeoIkOhTduHo/5YrxpRo1zbxoZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idMUxC4E5AYA/Nlmhq8MuRK0aLkeBcFbP3u8lvvOP97OgRCm6bFsEvHEkG647ex9jX4J5jl+B5ipFWtvyRPGb+29iRWUI2WP1XLcyENPcMiUPnlHPMKY0V8MDQJbDodHU4vgc8qKnMuIU10v5r6DMW6bUgZ3ACmVoxVjNPDGXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nDD9n6Tf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so1324360b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248943; x=1709853743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lukLV3IzObY+fmX3TTuFURPx1t0s+LwQl+LTSkieoBQ=;
        b=nDD9n6TfJphnkUNaSmOrfdujaHPypiGX9aGZA6i6t64AlqbTkdAi6yucnNRRIHi4VY
         GnM5p/KerJQ1HyA0erX8qOslXOsO+qQAswlP14ztm07//zR15Gcv61PQ5OypDT51mQs8
         UBfvTEjHzOL+BdenBN4zeKwS5bCRL02tiYaffqbAj12jc650Sbtnuj61Dv5TvXVl3uYn
         uenS/EYm32EadfZZk/86XdeIqkHCGN+gDiA0O7ALZRTHElahTcSmKRbLqKqCyRIwjovt
         JRkIQ+i0zryWBWyRFMU6PeWmZQeIAA5+jhRQoF3513oh+mziVCNEOUgv0RsSKcYwjdpm
         DbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248943; x=1709853743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lukLV3IzObY+fmX3TTuFURPx1t0s+LwQl+LTSkieoBQ=;
        b=JX4ZTrTAQArnyeVJdfE+R63Nn+ftKNtb5WI3cLWM2mkiPj+90q0+NjM9SNCQRrq8K8
         eNJMFKDCQWdWBb9/BtCIWQRQWXx+NpZr7pzfM5nvMQamGvGXR5AqSHLGVO8Drex04eiC
         ZISWGkKHF1VGGObD06KaZfRYiT5ACzBksOCBD7S1vEqHMgmSPDizAEnKtx86Yn4RHLPV
         nuvQKyNyP43DU9JnCf/rMxgbNRLeNX4Lu2H9WslzCiXGkJ0VBDse7webw4Y5TRUCBNPF
         PsKz5PpXES4TIiRmvbb+dK+6AR4sCLTSEkeZcfx/RquqCRioBqjbzgpxytHv0qUkWnst
         dWjw==
X-Gm-Message-State: AOJu0YwWvl6S3gCeMXMKC3y7WQK1OtmNKmD/0HhdgAlM5kEv6g/wEA55
	8eQ6CLLBw8NVXd0LvCS37x1gkPds2ShNhy1CzeJW0u2Xri0r50r9tsOoKp1meZI=
X-Google-Smtp-Source: AGHT+IFn2rYTQCqOuHVpuGhcF7BC7asS4ROedWcgIAd4N2h6ux4X4gjzLV3woCw85UyqGNmjtKX//g==
X-Received: by 2002:a05:6a00:1955:b0:6e5:5116:2cb5 with SMTP id s21-20020a056a00195500b006e551162cb5mr172054pfk.15.1709248942678;
        Thu, 29 Feb 2024 15:22:22 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:22 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 09/13] riscv: mm: Introduce cntx2asid/cntx2version helper macros
Date: Thu, 29 Feb 2024 15:21:50 -0800
Message-ID: <20240229232211.161961-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the ASID allocator, the MM context ID contains two values:
the ASID in the lower bits, and the allocator version number in the
remaining bits. Use macros to make this separation more obvious.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h |  3 +++
 arch/riscv/mm/context.c      | 12 ++++++------
 arch/riscv/mm/tlbflush.c     |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 355504b37f8e..a550fbf770be 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,6 +26,9 @@ typedef struct {
 #endif
 } mm_context_t;
 
+#define cntx2asid(cntx)		((cntx) & asid_mask)
+#define cntx2version(cntx)	((cntx) & ~asid_mask)
+
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index ba8eb3944687..b562b3c44487 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -81,7 +81,7 @@ static void __flush_context(void)
 		if (cntx == 0)
 			cntx = per_cpu(reserved_context, i);
 
-		__set_bit(cntx & asid_mask, context_asid_map);
+		__set_bit(cntx2asid(cntx), context_asid_map);
 		per_cpu(reserved_context, i) = cntx;
 	}
 
@@ -102,7 +102,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 	lockdep_assert_held(&context_lock);
 
 	if (cntx != 0) {
-		unsigned long newcntx = ver | (cntx & asid_mask);
+		unsigned long newcntx = ver | cntx2asid(cntx);
 
 		/*
 		 * If our current CONTEXT was active during a rollover, we
@@ -115,7 +115,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		 * We had a valid CONTEXT in a previous life, so try to
 		 * re-use it if possible.
 		 */
-		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+		if (!__test_and_set_bit(cntx2asid(cntx), context_asid_map))
 			return newcntx;
 	}
 
@@ -168,7 +168,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	 */
 	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
 	if (old_active_cntx &&
-	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
+	    (cntx2version(cntx) == atomic_long_read(&current_version)) &&
 	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
 					old_active_cntx, cntx))
 		goto switch_mm_fast;
@@ -177,7 +177,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 	/* Check that our ASID belongs to the current_version. */
 	cntx = atomic_long_read(&mm->context.id);
-	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
+	if (cntx2version(cntx) != atomic_long_read(&current_version)) {
 		cntx = __new_context(mm);
 		atomic_long_set(&mm->context.id, cntx);
 	}
@@ -191,7 +191,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 switch_mm_fast:
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
-		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  (cntx2asid(cntx) << SATP_ASID_SHIFT) |
 		  satp_mode);
 
 	if (need_flush_tlb)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 22870f213188..e194e14e5b2b 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -109,7 +109,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
 {
 	return static_branch_unlikely(&use_asid_allocator) ?
-			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+			cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.43.1


