Return-Path: <linux-kernel+bounces-87683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B152586D7AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D121F21897
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96714A0B1;
	Thu, 29 Feb 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L/K1eENv"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BA14564F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248947; cv=none; b=akFc1ntTgNf+HI55plev8ptCxGvtxUtS8bxIk+rgZSahyq0Y7oBZSTAipvdUDu1xC8/ZlJN2XCilLqJhTF9iGbizluBmCN9l2MWONsUtVkqZvC8bhqwS6LzwFpmXfMaSyftr/NSCMsReK2KbFuFyB9skbEsSefTwANJ7ZSJqhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248947; c=relaxed/simple;
	bh=ftmlZUm13WxGdRUTJnLym9NaWym8BpVy8g2b1tMP78U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9wWxID3hapdWtOnlE2pe4F7WPNi+AMXHkcI+bUjb+/xuslsZMIx8oMjFafDjOKvY43Q67ctOEoovRlKzPx4n6EVIuZ/7QvUaYcxorJKbP2iAevkVutFuE+pkkH7X/fOKIv0CS7Yx7fGcTHL8fBd0jhVcdmc4bF5T9isQfjKvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L/K1eENv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbb4806f67so1099947b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248943; x=1709853743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Ju3+5NsQ7zqLi78mVdBh82QtKzTZZzrfFOA+rFDFs=;
        b=L/K1eENvtww414ZLEnzDtPnjNRpwoUx8rzv082ES4ghMYTt0wArVxwWYwV9LFyhNOY
         0Yv1RLyPpE4A9oYBi1R3kWeUCCPp+CwknA69YGrsM0rq0BlyDH22s4nlOvsuRzD5R7JE
         osCrnmUUiOhHzydd+gGWiju5iJSQZUbnmETb8AARXOWQySCPFBeLauTKBX+M4/2is/r6
         a3jDMMUcuwZDG9NHN9jkf5DbSMP1gyvmb4OIgtPb3dsrnE6N5Zso0K+FLMsDexGzsLWz
         3EaCeKUV7FM9Y4j+e9VUlxp5EF72ldTHsS20NmVNvE0thm7dvHKn2H66IoYzVNK9X3AD
         RomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248943; x=1709853743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Ju3+5NsQ7zqLi78mVdBh82QtKzTZZzrfFOA+rFDFs=;
        b=hBtBjwZmcGlTE0iXrP5BIjztf5cpojlhRTx1x/3qRGtBx9MXcLoQmJ/gDXiXBPpREd
         SESz3CE39RYt52TlND0ez0URTgNr/buf161IuHKuZmkPz0bxpd32NbOtYOf1mVX1v42w
         6ZPU6tKWbBCvoijcJbCht7zZ+kOVYPPtiMnZA/3GIz7VNEpkqLDnZhXKvBeXMrtyr9xb
         seKx4WRc5ofq/F99XH53r2FvOeoc2v9jMrFxGzOLGP7ZxOkFgEbSwItzKrsljhJDKNgO
         3+vj1NAbApan2Q23kSb4yGoUtSOgp1C3xwRddC4mh/c0GCbvw/eca6ZseyEw10n0jiyf
         nsqw==
X-Gm-Message-State: AOJu0YwwX1QkmeHTFGjO5vavN2FUDXGX6MY/QIwqKpGoT//np7ECkIVI
	fQir83lDj4EyrkZRFYbYm4ph5VLb27WAAZgcQzWoOzi/fgAO0A7V50FkCRJdqPqgxxsug0/yrCf
	T
X-Google-Smtp-Source: AGHT+IHzbXWkwDmlfZ/eL4jDsB3ccQ2hOxgMwKxCvl8MiEGc4S4tbeeGWY8zmXhmQ74ouvbz4gXZvw==
X-Received: by 2002:a05:6808:1447:b0:3c1:b28b:76f0 with SMTP id x7-20020a056808144700b003c1b28b76f0mr91074oiv.9.1709248943714;
        Thu, 29 Feb 2024 15:22:23 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:23 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 10/13] riscv: mm: Use a fixed layout for the MM context ID
Date: Thu, 29 Feb 2024 15:21:51 -0800
Message-ID: <20240229232211.161961-11-samuel.holland@sifive.com>
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


