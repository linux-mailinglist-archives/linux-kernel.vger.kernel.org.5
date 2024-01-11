Return-Path: <linux-kernel+bounces-23564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6482AE78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA41C22E13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5C16425;
	Thu, 11 Jan 2024 12:09:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987216402
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T9k2T2cGgz1Q8Bs;
	Thu, 11 Jan 2024 20:08:01 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 9534A1A0172;
	Thu, 11 Jan 2024 20:09:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 11 Jan 2024 20:09:34 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>
Subject: [PATCH v3 3/3] x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails
Date: Thu, 11 Jan 2024 20:09:29 +0800
Message-ID: <20240111120929.2694440-4-mawupeng1@huawei.com>
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

Since there is no obvious reason to keep this WARN_ON_ONCE if follow_phys
fails in track_pfn_copy/untrack_pfn, Drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 94bcba399701..2fd37c2b29d6 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -994,10 +994,9 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return -EINVAL;
-		}
+
 		pgprot = __pgprot(prot);
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
@@ -1081,10 +1080,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return;
-		}
 
 		size = vma->vm_end - vma->vm_start;
 	}
-- 
2.25.1


