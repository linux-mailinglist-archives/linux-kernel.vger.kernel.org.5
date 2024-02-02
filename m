Return-Path: <linux-kernel+bounces-49860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F374284709B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C14C1C209BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD809185B;
	Fri,  2 Feb 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PESRYAFn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23B386
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878037; cv=none; b=A4GXPp5a3FaU+mH74fNaH7C1ErkbpuTkVh4odehuxKK9t0F3V0Fv7KxpP/by3kOvj05mTcXlYjxxUF6HXTrDwrJkMkgacclnIPTf2WYevTbjOJtXhG3s4L/pIYGvB7RU1Y98bGeQgycXQY6ZXZ/yhW5kC78reW8sS52tf22ckkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878037; c=relaxed/simple;
	bh=DTdTGv5jwgBZJvrSk5oU9nxNUBh4BYxD1UYqZlHxGMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BNwGETRz+FXbFQJwz7j6JyDEIOJAB0fy6PKfdDo50zIfKwds/bpxzOzS7lI9AkP2vIBPcs2H7LkdNLDVUsOeJZkpyInx7271Ye67xQhlXHx/C08ALWCah2Q6OhL8fP2QRhMABlMy6EPTUGtcRGUolnBxUq9kCuZiKOqmMF/6UNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PESRYAFn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fc2e36eeeso10133875e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706878032; x=1707482832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfkivfnJ5u+aO1iLj8a/ny9nA+pVGD6k9UGnv2RP5H0=;
        b=PESRYAFnmTajA4PRWWCKpS8itDdpZadUwxCU86kbWx0pmYuF8PQq/s+Epdy+emWvPx
         h5XyKPJ6irK/D/eBVxOrPgfc3iDy9WuGbKojWFAV8ZzSeAr+0ygXkiRAtqKDY9pO+mlQ
         lUH1vDs5OXyzhyQT1v/qPkxeuzlRry6TQ/sSnfVL+hi9VECxliRucwkHhmZs6Jj/pwyQ
         SKN/riZcHn6tKnUEh5b/3CvubXJNKYF0mcfKdMXtRhrkb+ZZYXlIDjISinl+i+9Jf9dO
         3TZfUMcwqP5q/5zLV5g1u4hGXfuMvZdTnuTIUSOAlRzwoXr6Zrj0uEAZs+h2EUOuOveC
         fn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878032; x=1707482832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfkivfnJ5u+aO1iLj8a/ny9nA+pVGD6k9UGnv2RP5H0=;
        b=jGISayLSW/wFdXla0nsoQYfi5ngP73MAG8cPqtyKDG36cdZXOILTrmu5maK1ihjuKq
         NVZb2Z73SjMabMyirM8nKyL4k5Q0ueVtE0rT5/ViFSzCrJP1ox1ZyPKr1h2Rq9eCSdto
         /e7qMunQfzKTLRGnc8AOQT7geuflgOfVRsEOm7qaS7XT0qu9Ku9h0Tjkh8N0fdDI8FD4
         JYNujkjKQ6Xosuaz8I3PZHCL6p2db/pBxryFws/RLy4om5d24gsHlrUTfXHi20NAS9AB
         No3YoCcWOUY4iDWgONg7oHus/6+wVGV8iYSKvx4gWOg6fE5CsS+ZNldCawE8vNvUEdZL
         uu/A==
X-Gm-Message-State: AOJu0Ywkd3Njmii983CtSIvoUA/9GsDIHvS4okBJiDNrz5ThkWcgc+YD
	YgXqfWo3UNIMl6eyBeI8nGdgDzzrj+iltyjZLvCFn3V84O+SMFJpofnFoPLkc5Q=
X-Google-Smtp-Source: AGHT+IGW7mLQd+I8OpKoYp3aw/Sq6pSMDtp0mSYKqVsXNS+hXaqH5gCV8Bfi6HvhJmWBkTXlW10rgQ==
X-Received: by 2002:a05:600c:4709:b0:40e:f9d4:2b03 with SMTP id v9-20020a05600c470900b0040ef9d42b03mr1507552wmo.12.1706878032498;
        Fri, 02 Feb 2024 04:47:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6QBdzXJgulKyw/8w7uhhABXlGq1XlbpEYQ1YsvEknY9QlWOelrc3MMu7wxmrw5jQIdNgQYL7vvq00ZdPh9le5UmJb7Z6F67esOXsiUhwwScAWy5wDxmsyVBuNd3/mEutbhFb6oOObAjzHlfjiTJX4brze8D/acKS+ud7tC8z23okCerwSGDPgC6H9G+9Go14oHVrPatJBaw==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c228d00b0040fb0c90da6sm7215696wmf.14.2024.02.02.04.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:47:12 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Only flush the mm icache when setting an exec pte
Date: Fri,  2 Feb 2024 13:47:11 +0100
Message-Id: <20240202124711.256146-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We used to emit a flush_icache_all() whenever a dirty executable
mapping is set in the page table but we can instead call
flush_icache_mm() which will only send IPIs to cores that currently run
this mm and add a deferred icache flush to the others.

The number of calls to sbi_remote_fence_i() (tested without IPI
support):

With a simple buildroot rootfs:
* Before: ~5k
* After :  4 (!)

Tested on HW, the boot to login is ~4.5% faster.

With an ubuntu rootfs:
* Before: ~24k
* After : ~13k

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 14 +++++++-------
 arch/riscv/mm/cacheflush.c       |  4 ++--
 arch/riscv/mm/pgtable.c          |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..058cfa89dd29 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -513,12 +513,12 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	WRITE_ONCE(*ptep, pteval);
 }
 
-void flush_icache_pte(pte_t pte);
+void flush_icache_pte(struct mm_struct *mm, pte_t pte);
 
-static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
+static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 {
 	if (pte_present(pteval) && pte_exec(pteval))
-		flush_icache_pte(pteval);
+		flush_icache_pte(mm, pteval);
 
 	set_pte(ptep, pteval);
 }
@@ -529,7 +529,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	page_table_check_ptes_set(mm, ptep, pteval, nr);
 
 	for (;;) {
-		__set_pte_at(ptep, pteval);
+		__set_pte_at(mm, ptep, pteval);
 		if (--nr == 0)
 			break;
 		ptep++;
@@ -541,7 +541,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
-	__set_pte_at(ptep, __pte(0));
+	__set_pte_at(mm, ptep, __pte(0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
@@ -707,14 +707,14 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(mm, pmdp, pmd);
-	return __set_pte_at((pte_t *)pmdp, pmd_pte(pmd));
+	return __set_pte_at(mm, (pte_t *)pmdp, pmd_pte(pmd));
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
 {
 	page_table_check_pud_set(mm, pudp, pud);
-	return __set_pte_at((pte_t *)pudp, pud_pte(pud));
+	return __set_pte_at(mm, (pte_t *)pudp, pud_pte(pud));
 }
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b0774993c0f3..3e234e95d952 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -85,12 +85,12 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_MMU
-void flush_icache_pte(pte_t pte)
+void flush_icache_pte(struct mm_struct *mm, pte_t pte)
 {
 	struct folio *folio = page_folio(pte_page(pte));
 
 	if (!test_bit(PG_dcache_clean, &folio->flags)) {
-		flush_icache_all();
+		flush_icache_mm(mm, false);
 		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index ef887efcb679..533ec9055fa0 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -10,7 +10,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  pte_t entry, int dirty)
 {
 	if (!pte_same(ptep_get(ptep), entry))
-		__set_pte_at(ptep, entry);
+		__set_pte_at(vma->vm_mm, ptep, entry);
 	/*
 	 * update_mmu_cache will unconditionally execute, handling both
 	 * the case that the PTE changed and the spurious fault case.
-- 
2.39.2


