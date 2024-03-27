Return-Path: <linux-kernel+bounces-120312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28B88D596
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AC1C234C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0028DCA;
	Wed, 27 Mar 2024 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CjqznVHU"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4063B3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515058; cv=none; b=VA0waLZXC5mDWRt+WzusppGbsZUomczkqGpkArSzwGULAleFGeYEi1ACZOKBecmH0ABKizQfKZS3/c2Nn3DtuvPJipJ0zLkqw0WAm/NdaNcIyv98CivNME7BR3WJyNtRsynom5Gs6vArtqTZ1hY1dTg3c5JQzXc7y1mjEq30WsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515058; c=relaxed/simple;
	bh=h6ENFi8wwoz/1RsosVsupi85G/Ck90qRb4MFtlbEcLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0gZ2yHkJxcte5syc9rYvb+uJWH4Ho493j5IX9EiFja6hDpJWA55BdaFBw8oJdqinjR66SA1wiXNHVBTzzJo9BS/tq5RM83wgRAY+JYcoBpQfqdetHW0580rsGwDEG3TVJ4ijPrsnPWYxNb1IgrEzeW24ZIHYaE8znfwFzvNI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CjqznVHU; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a58009fe88so511981eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515056; x=1712119856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OOp6ZEyIwMU5OnG6xTEWcirae/pY2nPqfU9WqSousc=;
        b=CjqznVHUKLdFJUT+AwhDsONLhja7y0P0+BDwOtNIs1xPyrDfT23/l6GTKBsD1Dj2pr
         VibCA9hZWDThdIbnx/63M9eMII4NBaD0WDRBPXdNVtGZTp6xyxKFInLKPVasxW7+XxqO
         +ZaEyqWi5yc2IirGZt80XbcJRQvXovpEtmDVMwD0Pt/M17zxsOx1MAwOUwoTxeqniy6+
         Rq46gw7oF5oVSFo8vmOrvWRbeeuYDerNSbPW6sZiFuTBoCkfh2NST6P6+DkDhjIiBp8P
         vw1YYcIhjIBGpAKTAe7bjgwBLrIyGsOA9o8fP3yghkcNLQYIZu9wIinrQxKAfqLxb5K8
         e1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515056; x=1712119856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OOp6ZEyIwMU5OnG6xTEWcirae/pY2nPqfU9WqSousc=;
        b=HAFTE2DxBqwe3YifbsLAwTPI4autudNkQWCcszVCir/QzRoZoDb6Z5coY82lz1qJ51
         cv2wG+kUuxb7FHYtKSYf05v6Fv7UfU/9/b0RDvn5iltJ6bobqe2sYGlZCCyLB8midT4e
         TLxzJEtAv3LeHgZF5JEFsq+/3Iu0w+xKh0XXZBjlLSjv3PrdNkDO6QTxpGjZ9+2WtjCC
         dE4sClLV99hn4/hS5ofrTzadhCKzQxKc8dIBtCPQzTlywCntjH9GMEA68fo3STUN7ZJQ
         X3iSPXoLYyZomn7NN8nsN7re5s/lwIzgFoF/eQq3d/purDO/jeLi6pX+J08LqH1IIvHc
         mSkg==
X-Gm-Message-State: AOJu0YzxvpbWL9H/U3E4Mq6UYsxd8X6XsKGbCzvhmhZScVlPppTIZr4y
	AO6bwXvl02kHqVTTNKGh6rJzJrLWKwjQkcAvwxvxA6CZNnBJohMVAjcGLdZWyp8i1Muk76IDtCT
	s
X-Google-Smtp-Source: AGHT+IH2eQoyDSJi6zqBjW5QAslrBjHf9N1FFSb9F+mmhA++Fk/xLCVtnw/qNQbwZOYB8ND1BkvynQ==
X-Received: by 2002:a05:6358:7584:b0:17c:1e6c:14c0 with SMTP id x4-20020a056358758400b0017c1e6c14c0mr311341rwf.16.1711515055737;
        Tue, 26 Mar 2024 21:50:55 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:54 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 09/13] riscv: mm: Introduce cntx2asid/cntx2version helper macros
Date: Tue, 26 Mar 2024 21:49:50 -0700
Message-ID: <20240327045035.368512-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
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
index 18af7b5053af..35266dd9a9a2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -110,7 +110,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
 {
 	return static_branch_unlikely(&use_asid_allocator) ?
-			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+			cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.43.1


