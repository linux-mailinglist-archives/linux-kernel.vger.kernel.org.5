Return-Path: <linux-kernel+bounces-51521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D3848C24
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEC1F23E45
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D881125BB;
	Sun,  4 Feb 2024 08:26:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1C12B6C;
	Sun,  4 Feb 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035200; cv=none; b=LchtFqPj9NwU9A3AHese6ms0DY+GSBff6e22B3G4xXlf5Vak6gbsm21aXT3cUxey7x8SpftC51NH3+PuxztQsjlIuOXHmOw/svm+G5rZ2YdNd0OqgOhRcEeaRm/SWp4cgR6ftpIKgMYn6DxB1t8AC/PlUbin7eeOmupAsM0mPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035200; c=relaxed/simple;
	bh=4zXDJkLQztiGlvBIDP7y8d8iYlaOAyzhpsC76GSWYcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le25qlFP+rPIsm0yypZKpC762HD3w3ElZxYmlvXQ4HOvFD6FU+LkrGAZGiENeuOP/8FbxR8SClKdjMhvcc48yHCdcUM4eTtcr4AifUqVywkAxNxkYEoC043kinBjint0mf2mjSFdji31HEo78ZAvG0ExkMSXr6DEudMyr4DmjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TSMyQ0lJtzsWrZ;
	Sun,  4 Feb 2024 16:25:18 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DF7618001A;
	Sun,  4 Feb 2024 16:26:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 16:26:33 +0800
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
Subject: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for DEFAULT_MCE_SAFE exception
Date: Sun, 4 Feb 2024 16:26:26 +0800
Message-ID: <20240204082627.3892816-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204082627.3892816-1-tongtiangen@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Currently, some kernel memory copy scenarios[1][2][3] which use
copy_mc_{user_}highpage() to safely abort copy and report 'bytes not copied'
when accessing the poisoned source page, a recoverable synchronous exception
generated in the processing and the fixup type EX_TYPE_DEFAULT_MCE_SAFE is
used to distinguish from other exceptions, and an asynchronous
memory_failure_queue() is called to handle memory failure of the source page
, but scheduling someone else to handle it at some future point is
unpredictable and risky.

The better way is immediately deal with it during current context,
fortunately, there is already a framework to synchronously call
memory_failure(), see kill_me_never() in do_machine_check(), a task work is
triggered once MCE_IN_KERNEL_COPYIN is set, in order to fix above issue,
setting MCE_IN_KERNEL_COPYIN for EX_TYPE_DEFAULT_MCE_SAFE case too.

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
index bca780fa5e57..b2cce1b6c96d 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -292,11 +292,11 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	case EX_TYPE_UACCESS:
 		if (!copy_user)
 			return IN_KERNEL;
+		fallthrough;
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
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
index 8d14ba440929..ee06a8f766ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2846,10 +2846,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma)) {
-			memory_failure_queue(page_to_pfn(src), 0);
+		if (copy_mc_user_highpage(dst, src, addr, vma))
 			return -EHWPOISON;
-		}
 		return 0;
 	}
 
@@ -6179,10 +6177,8 @@ static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 
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
@@ -6199,10 +6195,9 @@ static int copy_subpage(unsigned long addr, int idx, void *arg)
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


