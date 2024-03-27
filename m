Return-Path: <linux-kernel+bounces-120313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B188D597
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DD61C25623
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE9B64B;
	Wed, 27 Mar 2024 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GqPplVQL"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB202868D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515059; cv=none; b=QUnaRwUZ56XeQp63hxZM2L4EuEsbj+8KAYoTxtZU/ajmZZngrpyn9dCPeF2Og1nmTJ80DCoKyzIea6fIzEwrh85Zku4ClylfVpvXwDpoQ0K7zng1mQlnReRrI6q34TItSWevymhZhZ2UN3mgOZ7KgToZc7kAY9+Hy/m4cm+CLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515059; c=relaxed/simple;
	bh=ftmlZUm13WxGdRUTJnLym9NaWym8BpVy8g2b1tMP78U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1gg9iqvLZyRGRpwMa7pDCxaT66rtl2ta9bezM+K93TE+AaYfm6eu6X1MuZlxG06b47jgsVi18LUqnYR4BO5jB3BComeWltCo6yj1/Ka4tE2HbMLZ7CgB44Xg4cR+6dDF+1AKKQ12mvgelAwNzyLC4nF5f9X+SlSII7ziLwZ67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GqPplVQL; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a56710cdccso790123eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515057; x=1712119857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Ju3+5NsQ7zqLi78mVdBh82QtKzTZZzrfFOA+rFDFs=;
        b=GqPplVQLAFBRhF6X3RmN4Cn19Ru6zRkrkkJb+Vr0EchPxzvuYVzG71t8eLMqkN7ykw
         NL01Ccv4tYgzle7oZ5JEFCu4kHa2OOHhKmLUfz1EnLftqFqN0eVSAC4LfujuYCbteDux
         GtV0zaX3rRsSm0VIJ0VkDPfdQjmWCNNB/GRSzuTvbWUISNKXsJ4HLzhZGSetqvcAxzNB
         BiJF0LbuHkyEpjarGyaxB5z6SZxVr3iDck8jo4vL64j8DbSmgVmQAEIdTbo5DdksYIRq
         GMnx6oWQYQoHWbrZqCA4Sg5K2Ii8+gqnd9hdFUYDwhQ12LfTGWoT8xxlv2hRHbtK5UAt
         Wtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515057; x=1712119857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Ju3+5NsQ7zqLi78mVdBh82QtKzTZZzrfFOA+rFDFs=;
        b=xGKW1LxB52GgKsX7/imWYm4k9faHXpoQ+1D6h0chvYWv+SoIXXO0bh0SZy0+dzlLr3
         7YmeSfTYS8JS3SLb7Fwol4eyeR2MXp4zZwRav813vUEdzysdV7asJUrG4USjKfM3w17Q
         XYd2S+gc0UlwA3arJc4GXsWMPqqM9beAwxRkudgDZ8iaGLdLcFWNoTbWLmwUG7PQxG5a
         lDWFVPshT6LwftTcPm3bVihAmAxfEKSlBIfxphfhaDmBmtaBe2Os6Fhiju3FvUQb90GQ
         JriuvrQ/4CRNxTI0fXvBMiOy0SvRpGx3nSCabdvR0H8RNoi7oN3r0NYka8l2jDg6XShu
         Wfcw==
X-Gm-Message-State: AOJu0Yxr6+x2pD14AhnjFr2ncpd7yPaMq6tLXpPYj070Zr8jeW3Q2oig
	XU/BSF7TrVwqWmYYq1HWLpICCjarRVs8D45RMPn822AQIHF3VGAqxOuTWV8DPPI=
X-Google-Smtp-Source: AGHT+IE4clbeICIX6LaCSNcjSNKRNzkyOLoTskHKcKR+t8ek8fOhgjRruwacqNmtd1HR0FedGGJk+g==
X-Received: by 2002:a05:6358:6397:b0:17e:c8d9:328 with SMTP id k23-20020a056358639700b0017ec8d90328mr5244771rwh.11.1711515057489;
        Tue, 26 Mar 2024 21:50:57 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:56 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 10/13] riscv: mm: Use a fixed layout for the MM context ID
Date: Tue, 26 Mar 2024 21:49:51 -0700
Message-ID: <20240327045035.368512-11-samuel.holland@sifive.com>
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

Currently, the size of the ASID field in the MM context ID dynamically
depends on the number of hardware-supported ASID bits. This requires
reading a global variable to extract either field from the context ID.
Instead, allocate the maximum possible number of bits to the ASID field,
so the layout of the context ID is known at compile-time.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h      | 4 ++--
 arch/riscv/include/asm/tlbflush.h | 2 --
 arch/riscv/mm/context.c           | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index a550fbf770be..dc0273f7905f 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,8 +26,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
-#define cntx2asid(cntx)		((cntx) & asid_mask)
-#define cntx2version(cntx)	((cntx) & ~asid_mask)
+#define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
+#define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 8e329721375b..72e559934952 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -15,8 +15,6 @@
 #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
 
 #ifdef CONFIG_MMU
-extern unsigned long asid_mask;
-
 static inline void local_flush_tlb_all(void)
 {
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index b562b3c44487..5315af06cd4d 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -22,7 +22,6 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
 static unsigned long asid_bits;
 static unsigned long num_asids;
-unsigned long asid_mask;
 
 static atomic_long_t current_version;
 
@@ -128,7 +127,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment current_version */
-	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
+	ver = atomic_long_add_return_relaxed(BIT(SATP_ASID_BITS), &current_version);
 
 	/* Flush everything  */
 	__flush_context();
@@ -247,7 +246,6 @@ static int __init asids_init(void)
 	/* Pre-compute ASID details */
 	if (asid_bits) {
 		num_asids = 1 << asid_bits;
-		asid_mask = num_asids - 1;
 	}
 
 	/*
@@ -255,7 +253,7 @@ static int __init asids_init(void)
 	 * at-least twice more than CPUs
 	 */
 	if (num_asids > (2 * num_possible_cpus())) {
-		atomic_long_set(&current_version, num_asids);
+		atomic_long_set(&current_version, BIT(SATP_ASID_BITS));
 
 		context_asid_map = bitmap_zalloc(num_asids, GFP_KERNEL);
 		if (!context_asid_map)
-- 
2.43.1


