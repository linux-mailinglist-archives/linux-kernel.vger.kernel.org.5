Return-Path: <linux-kernel+bounces-23562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECA82AE76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B4CB26C70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4E15E86;
	Thu, 11 Jan 2024 12:09:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427AE15AD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T9jzV3fqvz1FJ0j;
	Thu, 11 Jan 2024 20:05:26 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 183751A0190;
	Thu, 11 Jan 2024 20:09:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 11 Jan 2024 20:09:33 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>
Subject: [PATCH v3 2/3] x86/mm/pat: Cleanup unused parameter in follow_phys
Date: Thu, 11 Jan 2024 20:09:28 +0800
Message-ID: <20240111120929.2694440-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111120929.2694440-1-mawupeng1@huawei.com>
References: <20240111120929.2694440-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Parameter flags is always zero in caller untrack_pfn() and
track_pfn_copy(). let's drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index a6a88679c92e..94bcba399701 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -951,8 +951,8 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 }
 
 static int follow_phys(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags,
-		unsigned long *prot, resource_size_t *phys)
+		unsigned long address,  unsigned long *prot,
+		resource_size_t *phys)
 {
 	int ret = -EINVAL;
 	pte_t *ptep, pte;
@@ -965,9 +965,6 @@ static int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = ptep_get(ptep);
 
-	if ((flags & FOLL_WRITE) && !pte_write(pte))
-		goto unlock;
-
 	*prot = pgprot_val(pte_pgprot(pte));
 	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
 
@@ -997,7 +994,7 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
@@ -1084,7 +1081,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
 		}
-- 
2.25.1


