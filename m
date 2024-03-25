Return-Path: <linux-kernel+bounces-116851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495788AA79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6745B47229
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F8215B148;
	Mon, 25 Mar 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjkYF3Xy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210E17C6B0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363227; cv=none; b=YsYH4N94i462F/Kvi79N/R/1ITxnW69eXJt1Qm2D/lUB6GRKAo65HErEMfVPpfruVOW8B6ZR3MCzialQkg3xJa0GNsyjzMDTkJcdBkghW9oXbJZ8XMoXQmp4bKCcXOr1h/kST+SJy4nIzUiMsJPV+sTG3i87RjddBckWT7XP97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363227; c=relaxed/simple;
	bh=bOB3euoyakUv2oEsB37yPol1Ac36digxpBM2Q7o9cSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsKXeJbjnq6x4OtV2qhnkh7ru9D8gmtpvXjIaw28aZSDc5zM+tRX4Giw13pdWb7Zb//nE9EZ7Olk+MbxDdDdR10p6gBuhLx+nvcNonM9jrdTowDeLid3+9tpyeZIsul0eNTyPJbQq0iFXhAwXjJ9DfU55xSuVzYN5TdoFjJCRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjkYF3Xy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363226; x=1742899226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOB3euoyakUv2oEsB37yPol1Ac36digxpBM2Q7o9cSk=;
  b=TjkYF3XytmGk5LkjONv+AAzhg90FqnJ89P6ofKbM8/Bat6Cg4Uo2IXFk
   zFjjswh+XJoWXj8aM80pojf1P8pDrpHTUHQZ/u//qsngzYHj8OQrrftSZ
   AC4hBlHNubZAmCyyS4HYebIBZkQk0vNCDUAgAaPb9QeXoqWw5TThKawNN
   L0Sktxvv4F5EF7KPtRAHfu3ZRPr/AmZBKijrtGL3JrcyvC08g65KYTP0i
   LpgwE7Qyar5UNPLatwThhJHFpDryGmNIWQ3LcrvCSfy/zgqeWTIv6I6sp
   RuG1Ll95AThigjmuSb41t0JgtFurQ7gRnrkXZd1xKaZ6oNp98K9I7keIk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561478"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070174"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070174"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B0553103A; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv9 15/17] x86/mm: Introduce kernel_ident_mapping_free()
Date: Mon, 25 Mar 2024 12:39:09 +0200
Message-ID: <20240325103911.2651793-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper complements kernel_ident_mapping_init(): it frees the
identity mapping that was previously allocated. It will be used in the
error path to free a partially allocated mapping or if the mapping is no
longer needed.

The caller provides a struct x86_mapping_info with the free_pgd_page()
callback hooked up and the pgd_t to free.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/init.h |  3 ++
 arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index cc9ccf61b6bd..14d72727d7ee 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -6,6 +6,7 @@
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
+	void (*free_pgt_page)(void *, void *); /* free buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
 	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
 	unsigned long offset;		 /* ident mapping offset */
@@ -16,4 +17,6 @@ struct x86_mapping_info {
 int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 				unsigned long pstart, unsigned long pend);
 
+void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
+
 #endif /* _ASM_X86_INIT_H */
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index a204a332c71f..c74ea5753ed3 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -4,6 +4,79 @@
  * included by both the compressed kernel and the regular kernel.
  */
 
+static void free_pte(struct x86_mapping_info *info, pmd_t *pmd)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+
+	info->free_pgt_page(pte, info->context);
+}
+
+static void free_pmd(struct x86_mapping_info *info, pud_t *pud)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_present(pmd[i]))
+			continue;
+
+		if (pmd_leaf(pmd[i]))
+			continue;
+
+		free_pte(info, &pmd[i]);
+	}
+
+	info->free_pgt_page(pmd, info->context);
+}
+
+static void free_pud(struct x86_mapping_info *info, p4d_t *p4d)
+{
+	pud_t *pud = pud_offset(p4d, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (!pud_present(pud[i]))
+			continue;
+
+		if (pud_leaf(pud[i]))
+			continue;
+
+		free_pmd(info, &pud[i]);
+	}
+
+	info->free_pgt_page(pud, info->context);
+}
+
+static void free_p4d(struct x86_mapping_info *info, pgd_t *pgd)
+{
+	p4d_t *p4d = p4d_offset(pgd, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (!p4d_present(p4d[i]))
+			continue;
+
+		free_pud(info, &p4d[i]);
+	}
+
+	if (pgtable_l5_enabled())
+		info->free_pgt_page(pgd, info->context);
+}
+
+void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (!pgd_present(pgd[i]))
+			continue;
+
+		free_p4d(info, &pgd[i]);
+	}
+
+	info->free_pgt_page(pgd, info->context);
+}
+
 static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
 			   unsigned long addr, unsigned long end)
 {
-- 
2.43.0


