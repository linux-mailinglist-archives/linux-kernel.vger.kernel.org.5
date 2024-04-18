Return-Path: <linux-kernel+bounces-149912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E38A97CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21F61F21F73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918E15E5AD;
	Thu, 18 Apr 2024 10:50:42 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9615E217;
	Thu, 18 Apr 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437442; cv=none; b=JeCTJvJZAK23qYndQKvAwCxPE2vWC8sxtYYl/wtiLUOLIRA4JEjEgHWKmn8Ykb9zYwoOP1QJSASQAieebJ528CYDU4iOWxc2PKsaeS1Lfhtvewsb+21VURsVOI967IZ/fwrHFEsB28khRzPa5yMS/TeEVgnIcwGRXpZkdZkKaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437442; c=relaxed/simple;
	bh=QCiswgDcN2bu7vT24ZZH99mPoKGsyGfGASAPrK1ZAqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTdAgbRMEtGbBTqGFsIJ8kb0rsemu394dhy8KNch7WmQVdCWcUji5n0PSr2/W3qC8WPmk8C3Y8dfaqSeY8NfSNWVS/R0wNyYMvQ1pjE2Yv7rZK2GUiN9j/PGQUaM1SfQ3W2Vahkj/9IaJSZbo5fKasHPcsTzc8mWUWFCaWQURNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1713437406t45jvzb7
X-QQ-Originating-IP: pEXvRM19b7upCM+fX9YdXWbEzjRXRZIJQhdLs2Q5RBM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:50:05 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 7YFKcddXaggfOZmy1nBedkwTPeeppd0uj9KwyxJOD37uhSD0tytPREuyoB+QB
	G4XjMxb0W6DCZrZHw8Z4rnFNCPeV233kpQUjFNNOcoh5wWgZXRndIb/Lrg5x9Xe0Y7la+pr
	tGLd3NCCWFluxBKN9pFWCzCayoTEBbNeUXWPbGE55YDcJ6Zg6eNvoM9039hAAHt/M61RA33
	wu/OM8Ln/+YchbXAZt2s7V/wbNvtwbo7wSSF/gK6PhpwR37vryHA1ENh/xtZSd9wbYJSXlk
	bvuOsk3r2UY90P8zB1mBg9WPEExQkc6De4RHQu16wrzrWFTM2wImWRpl1tZu4DgbA8wh9W2
	M9eKUKcZs8vFM9rhh1EX4RNNoAifAHKSEVVsaZsTW+T8RooMWMEQeVAXQCexpwqCqc1C7JC
	BEYh4Tt+heWpO9eDjGd1Iw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9509053346379215880
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 1/5] sparc/srmmu: Remove on-stack cpumask var
Date: Thu, 18 Apr 2024 18:49:45 +0800
Message-Id: <20240418104949.3606645-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_any_but() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/mm/srmmu.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 852085ada368..86fd20c878ae 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1653,13 +1653,15 @@ static void smp_flush_tlb_all(void)
 	local_ops->tlb_all();
 }
 
+static bool cpumask_any_but_current(struct mm_struct *mm)
+{
+	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
+}
+
 static void smp_flush_cache_mm(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
+		if (cpumask_any_but_current(mm))
 			xc1(local_ops->cache_mm, (unsigned long)mm);
 		local_ops->cache_mm(mm);
 	}
@@ -1668,10 +1670,7 @@ static void smp_flush_cache_mm(struct mm_struct *mm)
 static void smp_flush_tlb_mm(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask)) {
+		if (cpumask_any_but_current(mm)) {
 			xc1(local_ops->tlb_mm, (unsigned long)mm);
 			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
 				cpumask_copy(mm_cpumask(mm),
@@ -1688,10 +1687,7 @@ static void smp_flush_cache_range(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
+		if (cpumask_any_but_current(mm))
 			xc3(local_ops->cache_range, (unsigned long)vma, start,
 			    end);
 		local_ops->cache_range(vma, start, end);
@@ -1705,10 +1701,7 @@ static void smp_flush_tlb_range(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
+		if (cpumask_any_but_current(mm))
 			xc3(local_ops->tlb_range, (unsigned long)vma, start,
 			    end);
 		local_ops->tlb_range(vma, start, end);
@@ -1720,10 +1713,7 @@ static void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
 	struct mm_struct *mm = vma->vm_mm;
 
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
+		if (cpumask_any_but_current(mm))
 			xc2(local_ops->cache_page, (unsigned long)vma, page);
 		local_ops->cache_page(vma, page);
 	}
@@ -1734,10 +1724,7 @@ static void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	struct mm_struct *mm = vma->vm_mm;
 
 	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
+		if (cpumask_any_but_current(mm))
 			xc2(local_ops->tlb_page, (unsigned long)vma, page);
 		local_ops->tlb_page(vma, page);
 	}
@@ -1759,10 +1746,7 @@ static void smp_flush_page_to_ram(unsigned long page)
 
 static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
 {
-	cpumask_t cpu_mask;
-	cpumask_copy(&cpu_mask, mm_cpumask(mm));
-	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-	if (!cpumask_empty(&cpu_mask))
+	if (cpumask_any_but_current(mm))
 		xc2(local_ops->sig_insns, (unsigned long)mm, insn_addr);
 	local_ops->sig_insns(mm, insn_addr);
 }
-- 
2.27.0


