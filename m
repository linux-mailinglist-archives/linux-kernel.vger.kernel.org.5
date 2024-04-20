Return-Path: <linux-kernel+bounces-152143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722B8AB9CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2EDB212CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACA12E7F;
	Sat, 20 Apr 2024 05:16:47 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB02205E26;
	Sat, 20 Apr 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590207; cv=none; b=R78m0+rIL8ZqWGstaxMtd8HBS5ruhhcrhm6oNttmWeEgzkxLZK+5F6KY/DwgX40C1qmPu247yQ2Khu1YkaIhZYVeaQn1Stvvn7JxOMmy6q2fKRVJGLork1mmNNoc9+X9EbHG1tLhll9d4EfeU0ECY/e+shJi41HMCZn6OmDO9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590207; c=relaxed/simple;
	bh=QCiswgDcN2bu7vT24ZZH99mPoKGsyGfGASAPrK1ZAqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+ER0PAtoCnTkbYHUysx/rPKckEzTGX6MvzIeGwqjYYHwWomVBYEIWXpsvdjiG74OQZAflgjH2nGUpDdAWAwjDAy/zSHMsqc8rlHoJUMxBOpuE5jZkRWbvgDUuikrHoxM3Jx4v71lEZtjIuoMf5TvApEYT5yLbYBNrOVMdkiqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1713590163tbxfal
X-QQ-Originating-IP: 4z5Ce7vmevKk0ZpNSIX4XoeS4cw4jCO0yDPWypaO99g=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:02 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: OwlQr8knuI9pnCqr4AFwpinQdFPRSsaPpQAH5uRlMe0ThyzJXvjjwwNW1gaUf
	Z7wq606xM9akVpcO01FRLeYLN82y338oa9oRAOrZBpLbVZXac1GB+GKDDwK2NqULaM2fRiz
	epHmS2Ggq2h295aM1QKGPAvjq30C0/F6NBamk2uK0myLc5Atu7zIwzeamP3UtwCHfqPRszB
	S/JTcvivnexf/Bcn36XTxJAPZH52CYrLxlg/j4iFqnYK3oe33HPRhit2RkFJhEn0m4ezp+z
	A2MIuzS7gbslDXPlPUyuvVW8zoRn/6nYBAqz0BPdm+Rw2Zx+jUfXu/ARcVdD8xUmzD7Ha8Y
	MnFi8HOEfaXWXJNZZ7MB1JRKWZ2G0jxxVqnO6h7zPtshv3qgMqzSLTD57tOSHP+2FEGR7+V
	EMQsi7RNVr0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15652962948535279539
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 1/7] sparc/srmmu: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:41 +0800
Message-Id: <20240420051547.3681642-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240420051547.3681642-1-dawei.li@shingroup.cn>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
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


