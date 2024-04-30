Return-Path: <linux-kernel+bounces-163687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA48B6E54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767CB1C21986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397E129A83;
	Tue, 30 Apr 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b/+JUPA4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC712838C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469124; cv=none; b=fFi//mAJ/JjeUmRpAltCgvkIZJxWH8L/JL17ntD/0UcmJhS7OnUVIKSGCGUTyDIncfF4zy4K9qRbh8idYDTGfMK74nBWcA0mEsMxFnWr21CL8iyA4tv7u9qhpy2HjsefesTC7v6vZyP5XVu/+awQs3E6eG4eyhlGBe7zZQiyBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469124; c=relaxed/simple;
	bh=4Pyrk1n5Ihd8SoQ6AnQF6p0Em7a2omxYIXzZBsf+dJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XkoqC4jJ8oaAw4cAagzHEYdztnURBf0+t7QXoFJcnI0jWBKL05a4n/Ox8jLsY3edG/v71gAYno2UmNmFs5idXekIEKdj+oJUk73mPcMlhGgbS8C9XZKDtI+gJXKj2sA6LDrt5A980baTKc2oYNef2j5b5O/jVp4AJhtt4raZcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b/+JUPA4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=8J509ZtKoQn0gx1wYtwLPsjmvHOD8SRPEHQea+vmJyg=;
	b=b/+JUPA4FdtJfz/msUcQssSx0FMbAlaZzSzRh8QeThbZwb/HUPz1N41GxNg4hA
	RZv9Q43d1HGHLi7TCxLFRPqpBQ373j6xa9th31nWCsgdmIC7kDPTm2ovihfVlB5o
	UnytjbjyS4yzETMMFSi/U+Ck2MO/gb2tse/vM6Oookz3U=
Received: from yangzhang2020.localdomain (unknown [60.24.209.33])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnz5hFuDBmqJS6Bg--.50500S2;
	Tue, 30 Apr 2024 17:22:13 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: alexghiti@rivosinc.com
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alex@ghiti.fr,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH V1] riscv: mm: Support > 1GB kernel image size when creating early page table
Date: Tue, 30 Apr 2024 17:22:11 +0800
Message-Id: <20240430092211.26269-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz5hFuDBmqJS6Bg--.50500S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW3JF47XF4UWry3Wr15urg_yoWrKryxpr
	WrGF1rKF4UJFZrtw4fJrW5Cr1fAw1xGay3JFWxG3WxGayayrWagr45Kr43AFy0kFn3XFyr
	Xw4qgay5uayUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6_M3UUUUU=
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAnQ8mVOCjoBAQAAs0

From: "yang.zhang" <yang.zhang@hexintek.com>

By default, when creating early page table, only one PMD page table, but
if kernel image size exceeds 1GB, it need two PMD page table, otherwise,
it would BUG_ON in create_kernel_page_table.

In addition, if trap earlier, trap vector doesn't yet set properly, current
value maybe set by previous firmwire, typically it's the _start of kernel,
it's confused and difficult to debuge, so set it earlier.
---
I'm not sure whether hugesize kernel is reasonable, if not, ignore this patch.
This issue can be reproduced simpily by changing '_end' in vmlinux.lds.S
such as _end = . + 0x40000000；

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
---
 arch/riscv/mm/init.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..094b39f920d3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -386,11 +386,13 @@ static void __init create_pte_mapping(pte_t *ptep,
 static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
+static pmd_t early_pmd2[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
 #define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
 #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
 #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
+#define early_pmd2      ((pmd_t *)XIP_FIXUP(early_pmd2))
 #endif /* CONFIG_XIP_KERNEL */
 
 static p4d_t trampoline_p4d[PTRS_PER_P4D] __page_aligned_bss;
@@ -432,9 +434,14 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	BUG_ON((va - kernel_map.virt_addr) >> PUD_SHIFT);
+	uintptr_t end_pud_idx = pud_index(kernel_map.virt_addr + kernel_map.size - 1);
+	uintptr_t current_pud_idx = pud_index(va);
 
-	return (uintptr_t)early_pmd;
+	BUG_ON(current_pud_idx > end_pud_idx);
+	if (current_pud_idx == end_pud_idx)
+		return (uintptr_t)early_pmd2;
+	else
+		return (uintptr_t)early_pmd;
 }
 
 static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
@@ -769,6 +776,18 @@ static void __init set_mmap_rnd_bits_max(void)
 	mmap_rnd_bits_max = MMAP_VA_BITS - PAGE_SHIFT - 3;
 }
 
+static pmd_t *__init select_pmd_early(uintptr_t pa)
+{
+	uintptr_t end_pud_idx = pud_index(kernel_map.phys_addr + kernel_map.size - 1);
+	uintptr_t current_pud_idx = pud_index(pa);
+
+	BUG_ON(current_pud_idx > end_pud_idx);
+	if (current_pud_idx == end_pud_idx)
+		return early_pmd2;
+	else
+		return early_pmd;
+}
+
 /*
  * There is a simple way to determine if 4-level is supported by the
  * underlying hardware: establish 1:1 mapping in 4-level page table mode
@@ -780,6 +799,7 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
+	pmd_t *target_pmd, *target_pmd2;
 
 	if (satp_mode_cmdline == SATP_MODE_57) {
 		disable_pgtable_l5();
@@ -789,17 +809,24 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 		return;
 	}
 
+	target_pmd = select_pmd_early(set_satp_mode_pmd);
+	target_pmd2 = select_pmd_early(set_satp_mode_pmd + PMD_SIZE);
 	create_p4d_mapping(early_p4d,
 			set_satp_mode_pmd, (uintptr_t)early_pud,
 			P4D_SIZE, PAGE_TABLE);
 	create_pud_mapping(early_pud,
-			   set_satp_mode_pmd, (uintptr_t)early_pmd,
+			   set_satp_mode_pmd, (uintptr_t)target_pmd,
+			   PUD_SIZE, PAGE_TABLE);
+	/* Handle the case where set_satp_mode straddles 2 PUDs */
+	if (target_pmd2 != target_pmd)
+		create_pud_mapping(early_pud,
+			   set_satp_mode_pmd + PMD_SIZE, (uintptr_t)target_pmd2,
 			   PUD_SIZE, PAGE_TABLE);
 	/* Handle the case where set_satp_mode straddles 2 PMDs */
-	create_pmd_mapping(early_pmd,
+	create_pmd_mapping(target_pmd,
 			   set_satp_mode_pmd, set_satp_mode_pmd,
 			   PMD_SIZE, PAGE_KERNEL_EXEC);
-	create_pmd_mapping(early_pmd,
+	create_pmd_mapping(target_pmd2,
 			   set_satp_mode_pmd + PMD_SIZE,
 			   set_satp_mode_pmd + PMD_SIZE,
 			   PMD_SIZE, PAGE_KERNEL_EXEC);
@@ -829,7 +856,9 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 	memset(early_pg_dir, 0, PAGE_SIZE);
 	memset(early_p4d, 0, PAGE_SIZE);
 	memset(early_pud, 0, PAGE_SIZE);
-	memset(early_pmd, 0, PAGE_SIZE);
+	memset(target_pmd, 0, PAGE_SIZE);
+	if (target_pmd2 != target_pmd)
+		memset(target_pmd2, 0, PAGE_SIZE);
 }
 #endif
 
-- 
2.25.1


