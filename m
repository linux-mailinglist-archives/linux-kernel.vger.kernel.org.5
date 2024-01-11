Return-Path: <linux-kernel+bounces-23690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87E282B00F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE50A1C2383A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201317989;
	Thu, 11 Jan 2024 13:56:07 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F823C062;
	Thu, 11 Jan 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T9mQK3ZqxzNkn4;
	Thu, 11 Jan 2024 21:55:21 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A93B180077;
	Thu, 11 Jan 2024 21:56:00 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 21:55:59 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v4 3/3] x86/mce: set MCE_IN_KERNEL_COPY_MC for DEFAULT_MCE_SAFE exception
Date: Thu, 11 Jan 2024 21:55:48 +0800
Message-ID: <20240111135548.3207437-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111135548.3207437-1-tongtiangen@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)

From: Kefeng Wang <wangkefeng.wang@huawei.com>

If an MCE has happened in kernel space and the kernel can recover,
mce.kflags MCE_IN_KERNEL_RECOV will set in error_context().

With the setting of MCE_IN_KERNEL_RECOV, the MCE is handled in
do_machine_check(). But due to lack of MCE_IN_KERNEL_COPY_MC, although the
kernel won't panic, the corrupted page don't be isolated, new one maybe
consume it again, which is not what we expected.

In order to avoid above issue, some hwpoison recover process[1][2][3],
memory_failure_queue() is called to cope with such unhandled corrupted
pages, also there are some other already existed MC-safe copy scenarios,
eg, nvdimm, dm-writecache, dax, which don't isolate corrupted pages.

The best way to fix them is set MCE_IN_KERNEL_COPY_MC for MC-Safe Copy,
then let the core do_machine_check() to isolate corrupted page instead
of doing it one-by-one.

EX_TYPE_FAULT_MCE_SAFE is used for the FPU. Here, we do not touch the logic
of FPU. We only modify the logic of EX_TYPE_DEFAULT_MCE_SAFE which is used
in the scenarios described above.

[1] commit d302c2398ba2 ("mm, hwpoison: when copy-on-write hits poison, take page offline")
[2] commit 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
[3] commit 6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/kernel/cpu/mce/severity.c |  4 ++--
 mm/ksm.c                           |  1 -
 mm/memory.c                        | 13 ++++---------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index df67a7a13034..b4b1d028cbb3 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	case EX_TYPE_UACCESS:
 		if (!copy_user)
 			return IN_KERNEL;
+		fallthrough;
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_COPY_MC;
 		fallthrough;
-
 	case EX_TYPE_FAULT_MCE_SAFE:
-	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..ba9d324ea1c6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3084,7 +3084,6 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 		if (copy_mc_user_highpage(folio_page(new_folio, 0), page,
 								addr, vma)) {
 			folio_put(new_folio);
-			memory_failure_queue(folio_pfn(folio), 0);
 			return ERR_PTR(-EHWPOISON);
 		}
 		folio_set_dirty(new_folio);
diff --git a/mm/memory.c b/mm/memory.c
index c66af4520958..33d8903ab2af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2843,10 +2843,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma)) {
-			memory_failure_queue(page_to_pfn(src), 0);
+		if (copy_mc_user_highpage(dst, src, addr, vma))
 			return -EHWPOISON;
-		}
 		return 0;
 	}
 
@@ -6176,10 +6174,8 @@ static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 
 		cond_resched();
 		if (copy_mc_user_highpage(dst_page, src_page,
-					  addr + i*PAGE_SIZE, vma)) {
-			memory_failure_queue(page_to_pfn(src_page), 0);
+					  addr + i*PAGE_SIZE, vma))
 			return -EHWPOISON;
-		}
 	}
 	return 0;
 }
@@ -6196,10 +6192,9 @@ static int copy_subpage(unsigned long addr, int idx, void *arg)
 	struct page *dst = nth_page(copy_arg->dst, idx);
 	struct page *src = nth_page(copy_arg->src, idx);
 
-	if (copy_mc_user_highpage(dst, src, addr, copy_arg->vma)) {
-		memory_failure_queue(page_to_pfn(src), 0);
+	if (copy_mc_user_highpage(dst, src, addr, copy_arg->vma))
 		return -EHWPOISON;
-	}
+
 	return 0;
 }
 
-- 
2.25.1


