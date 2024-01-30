Return-Path: <linux-kernel+bounces-44566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B184244A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F991F25F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B1679F0;
	Tue, 30 Jan 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KS7dwp8z"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCB67749
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616081; cv=none; b=TAiA31EXa2TGRmLzkHOX7Z6mnZAAWILwoCms7i9Yu+gEY3i4f6lbghbZpIeuQEKGjxKRf/EmEoesnq/qO9zyT4JxVYtRA2h4ybVNhNMNEBCr9WzvPXCWo7KrZtVfSpCMST17EIk//h3TZbjHIq3++WDW3+BRzTIU3f4RRBUwDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616081; c=relaxed/simple;
	bh=MiwFLS45HdWVedOvpsLGeVeQVvF9T9P1qxXKz4V4K6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h96mP7djWKTEqKIkEEO1AajFg8lPuDxYSz86wFPBy+KeRnYy0KzsUDLAv+CkkhMw3lQAEa3NjiGXfwcI8SB8E4JOw1zHmc8RyOCwp/VqvAkbIZfD4fzIdsQyEirPuEu9BGnAb7mbqpTtKqRHjVc0DG/ZCTPHA+43vmppdo7bBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KS7dwp8z; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so19503261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706616077; x=1707220877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHZFoGtcJrlCRJilwMm607tqzIqnhBQPqkmzm1pT0lA=;
        b=KS7dwp8zlCZyMwnmRsHAEB7ZK97h5LnkIj0wNN/5H9nZsSOzItsHdSzRDHhfFlVIMc
         QkKvzqlgqU05Wo3zFwt+Fd276UbuBLd1/FSOx/w7IPRAI48/mT7+Wox33EjaU29GF3CX
         z3uJnl1Wl6WBrtxF/Nx4z0kurIE+ZbRfgzjwVTX7lHakDOokZPfhK5aSi1BTdJ2HZs4p
         ihvLTo49LxxMcskcmdhDt0KOatsRB8Sbcscll/Wk/brWshgulqcJdEEEf2Uj86QUadpW
         rhuul1nsVzLgciQom7+DAGp0UkSQEHO9d+JFchXCxIO7+f6mR0/u7natKrE9g3WaL4YX
         7ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616077; x=1707220877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHZFoGtcJrlCRJilwMm607tqzIqnhBQPqkmzm1pT0lA=;
        b=gpaNkxtiUXhFQYmXuQd2qRSscQQdq0IOVLQsw5q1j7xDCTLe+24URNSV5Jcnytm97d
         Gu4ifvFQ7S1iwOkv69WAYd0uDDFKmfF7pnjwCxFQsK06irsh2w3FPOHroAatAnRLDiCn
         knlyRB/6qL5d3LrueUguGUXFPiw2g7ikEdd54bG36w9yFdg7Qg0IoV1hpAC0vHEWZyJl
         gls5g8uZBJn3n+FA/BASUa5P3YmkbhOPKCNwdmfDHbjSynhI18G/pxiZSmZT6xaipOOj
         L5hLnu3ykxqwgKEX9FGvwN1pR97SnpXbg/0ixwsMVCUKx7k+giOYCE7VswKCymjGUywP
         FmLQ==
X-Gm-Message-State: AOJu0YyWzXPcLuywwGJcMliNw8JHydeLNGL2nT4NS6SBFV3S1lMAlWmX
	a6rRri+Cji74GhXL4cq5YmEEH0WBsNDxctMz5fOzErJ4nG0+BqN6P869W28tnhg=
X-Google-Smtp-Source: AGHT+IHKxTBCLOunly/kJxa7AZaFa9iq0AQuoHjYi4qoEZOLD43GcWUmIX9hlLSHYhq0NGwn7RPQ3w==
X-Received: by 2002:a05:651c:1a21:b0:2d0:511e:741f with SMTP id by33-20020a05651c1a2100b002d0511e741fmr3473128ljb.48.1706616077377;
        Tue, 30 Jan 2024 04:01:17 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w5-20020a2e9585000000b002cd97c7a029sm921538ljh.16.2024.01.30.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:01:16 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix arch_hugetlb_migration_supported() for NAPOT
Date: Tue, 30 Jan 2024 13:01:14 +0100
Message-Id: <20240130120114.106003-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_hugetlb_migration_supported() must be reimplemented to add support
for NAPOT hugepages, which is done here.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hugetlb.h |  3 +++
 arch/riscv/mm/hugetlbpage.c      | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 4c5b0e929890..20f9c3ba2341 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -11,6 +11,9 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 }
 #define arch_clear_hugepage_flags arch_clear_hugepage_flags
 
+bool arch_hugetlb_migration_supported(struct hstate *h);
+#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 87406b26c3da..29c7606414d2 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -364,7 +364,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		pte_clear(mm, addr, ptep);
 }
 
-static __init bool is_napot_size(unsigned long size)
+static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
 
@@ -392,7 +392,7 @@ arch_initcall(napot_hugetlbpages_init);
 
 #else
 
-static __init bool is_napot_size(unsigned long size)
+static bool is_napot_size(unsigned long size)
 {
 	return false;
 }
@@ -409,7 +409,7 @@ int pmd_huge(pmd_t pmd)
 	return pmd_leaf(pmd);
 }
 
-bool __init arch_hugetlb_valid_size(unsigned long size)
+static bool __hugetlb_valid_size(unsigned long size)
 {
 	if (size == HPAGE_SIZE)
 		return true;
@@ -421,6 +421,16 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 		return false;
 }
 
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	return __hugetlb_valid_size(size);
+}
+
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	return __hugetlb_valid_size(huge_page_size(h));
+}
+
 #ifdef CONFIG_CONTIG_ALLOC
 static __init int gigantic_pages_init(void)
 {
-- 
2.39.2


