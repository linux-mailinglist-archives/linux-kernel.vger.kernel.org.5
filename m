Return-Path: <linux-kernel+bounces-156182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B58AFEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1712D1F21968
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC37143889;
	Wed, 24 Apr 2024 02:56:49 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50423142E8A;
	Wed, 24 Apr 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927409; cv=none; b=UfoBdgJmWYsGwxMxMm719EeovRzaz2JmoVN7zvZFDpCanwxQ9JuSJwhxbkLXpHKDQV5dQ+NPlKJ2WEUihrU7VvhkLsZAjUS95QJMxc/g2TA8R8P9v0h9HgDdrPkpj4uqz2SKG2MWZde05gWZDifQGwS1f2AFj0jAxW/vOCRtd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927409; c=relaxed/simple;
	bh=eGgBQtvqHszHLZjEaVNOzyrzgGeymXRzgL/zYDf5Cj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNQy4N9Dn3a4oj10A5Em/wwhqPNBJ7pm0fA2muHGonHN83//qHLx5d6oq8dOdQUQK0Qx2oICgz6VZLPVI8O0NjW/5438YFYtnRfz8M9ounedx7J4Qf+n92yeSNwBSnNhTxYLy6Sl6wI0ZRexRr04Rm0h2RBmx+e0drX2IJ3pj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz11t1713927362tuq3f5
X-QQ-Originating-IP: r4SzD00NWbLMn6CzY4bmfQwvShdm3liWPDr3PAhKA8A=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:56:00 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: KdN0SWBFoH4pfnOT4RnGCvcbVf07FHD8cWXeImdce+6Iq6YSHyIsvsSoD9y27
	KsCp8ccVwDj4QBYvvGKjf2vJo47SQ71YVQg6KR9FhTDlnqPerN9/7ootNfd27xVFJ7cvdRx
	2UUjtH9BGHDlTiNkxS2IahGAstKxKzxunZslIzg78B8RA7AuptFCH3hALQG716tHPqUNRwW
	JpGE5jooPD+tao1IM1lufWUHtfP04D1+7ipsmORCb38Qv/PtsFa2WYWNW5ha5nTfPByBkOd
	Bgo5kMP6eTUtHWH/NfCpMSIKsrjnPAk8OzhpWnVoI3o26rY3ShOeBfVHHRHT5ta4K5Noctu
	D2BbhREYfzRh0J4/X8hutImW2ZK/eQ5Qqo134AujtK9Xtre+ZrvZ3yK/6d96+KjbX29MJwl
	mliS/JVPpFFGmun6FL8YYQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17482992141322820079
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 1/5] sparc/srmmu: Remove on-stack cpumask var
Date: Wed, 24 Apr 2024 10:55:44 +0800
Message-Id: <20240424025548.3765250-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424025548.3765250-1-dawei.li@shingroup.cn>
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_any_but() to avoid the need for a temporary cpumask on
the stack and simplify code.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/mm/srmmu.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 852085ada368..9df51a62333d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1653,13 +1653,15 @@ static void smp_flush_tlb_all(void)
 	local_ops->tlb_all();
 }
 
+static bool any_other_mm_cpus(struct mm_struct *mm)
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
+		if (any_other_mm_cpus(mm))
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
+		if (any_other_mm_cpus(mm)) {
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
+		if (any_other_mm_cpus(mm))
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
+		if (any_other_mm_cpus(mm))
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
+		if (any_other_mm_cpus(mm))
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
+		if (any_other_mm_cpus(mm))
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
+	if (any_other_mm_cpus(mm))
 		xc2(local_ops->sig_insns, (unsigned long)mm, insn_addr);
 	local_ops->sig_insns(mm, insn_addr);
 }
-- 
2.27.0


