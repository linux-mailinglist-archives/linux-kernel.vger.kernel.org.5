Return-Path: <linux-kernel+bounces-154686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AAA8ADFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E4C281F96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0786D55C2A;
	Tue, 23 Apr 2024 08:31:45 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497D79D3;
	Tue, 23 Apr 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861104; cv=none; b=imwsumO9XqomoKXWOsQirIzfZ5cWF4v4wPmMA8+y1i4R3Lw4kh2Vs7Lx0QcjtcGOl0Ax1sDTOEV5CscwpsZDq+9R8+6y3HWvOmuddz+qdrda/MejnnVtKmxEL1n/8gxLzCoAz9chOXFDkrPRvb7MbzI2I70D82CqUBBmHZe42rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861104; c=relaxed/simple;
	bh=eGgBQtvqHszHLZjEaVNOzyrzgGeymXRzgL/zYDf5Cj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTWgdPYEuLzSv88+tdnSh7515TxlmqF47Lb+OYuYv+s3n4Lw1Egn57bzAOu4T6OTV43o8qsHNvXAWRUUP48U9NH5jlKCG6s6yFtlFJqPudnY50XXMHUQxD3Wx9YmQRw+T2HboXaYY/24j3NE1TTyfAYGwnx1Ns23Yw26BzAvXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1713861067tou125gg
X-QQ-Originating-IP: 51OwVtAtuarwI4cCOTceEqcV9mknxm2HbvPOgPobPo0=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:05 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: j86OQQvu8eQ1KhrGmCdEjrtfAbzGLSdea3066tUtHFRZeB3xbcnbrMa6/vNVC
	qrSR54Kjk6fKefvit8IzvrooMnYPYRldF/GLWR3VBzoNXJDegfDGxizLpcW5z8RAkdnEOqt
	+u5QwNny/+pQvYGlX5aXNN5X10gLT4fdxQvBOgBde5x+mfYFFoP3lsEba7xyM59vv6tHNzR
	odb+ahZYquwTveFuVonFYmjHqFZizYWVTnBy33DpzDA4ErmqvAS8Lw4z3SfvdBK3t26FJP+
	CNXbFhfNr9+r3NFdR/Nhuy9TFIHpdyXronYd9V+Mgv/mvkXCocZ6vr86HNSkMfm51gmWKoj
	2h5hHsqqc4Brr5j4aFah4xry9zGQEtJRkbjvVbbb514WM2qdUxmb11BhkiyIltY7SLDREfd
	UFtB97v3rjRrcqHuYo6p8g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7545835907098097455
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 1/6] sparc/srmmu: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:38 +0800
Message-Id: <20240423083043.3735921-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423083043.3735921-1-dawei.li@shingroup.cn>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
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


