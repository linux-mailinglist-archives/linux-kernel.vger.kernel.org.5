Return-Path: <linux-kernel+bounces-141852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987158A2440
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306C01F233D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAC15491;
	Fri, 12 Apr 2024 03:17:05 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx309.baidu.com [180.101.52.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFEA12E4E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891825; cv=none; b=Wl5mTXtHmwRfZgHhbPUuV/C2Oex/JekBAJ2SU8utIrUVnhCWI7ZXWlIIe1eFFgcxmTXcafJmmzq+kduAPt6JBWTxLwqTfQdSrRqYFIaqsCw/7jq+/3zjm+tddkK7jvmZgSjC1L3tVSvhxfci6ZLFxVQfUh1lWKCghURrQGwvkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891825; c=relaxed/simple;
	bh=ZbqwmPgrkigCftAY4kWOWC9DW9S6DixYjAuHCk5fars=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iEc3erhkJhUVVZgn8E4N6jKIpGy3aFMqXg450oQuRb9bY/AiGkr7dsjd9KskUfwekbUqaLMArry2qf68tJa3ZBnrMHZwY6GcDbcuZY26tspjiuyVr5TRc4/inClGzd0AWY9vENZ6mImCZLQON9K9UJWXIjwhRylQkZd13dZDxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 462317F00043;
	Fri, 12 Apr 2024 11:01:32 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] x86/sev: take NUMA node into account when allocating memory for per-CPU variables
Date: Fri, 12 Apr 2024 11:01:30 +0800
Message-Id: <20240412030130.49704-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

per-CPU variables are dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7e1e63cc..dfe7c69 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -938,7 +938,7 @@ static int snp_set_vmsa(void *va, bool vmsa)
 #define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
 #define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
 
-static void *snp_alloc_vmsa_page(void)
+static void *snp_alloc_vmsa_page(int cpu)
 {
 	struct page *p;
 
@@ -950,7 +950,7 @@ static void *snp_alloc_vmsa_page(void)
 	 *
 	 * Allocate an 8k page which is also 8k-aligned.
 	 */
-	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	p = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
 	if (!p)
 		return NULL;
 
@@ -1019,7 +1019,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	 * #VMEXIT of that vCPU would wipe out all of the settings being done
 	 * here.
 	 */
-	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page();
+	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page(cpu);
 	if (!vmsa)
 		return -ENOMEM;
 
@@ -1341,7 +1341,7 @@ static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
 
-	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
+	data = memblock_alloc_node(sizeof(*data), PAGE_SIZE, cpu_to_node(cpu));
 	if (!data)
 		panic("Can't allocate SEV-ES runtime data");
 
-- 
2.9.4


