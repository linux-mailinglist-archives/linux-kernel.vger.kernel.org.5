Return-Path: <linux-kernel+bounces-136754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DA89D7DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F25B20F50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188A12E1C9;
	Tue,  9 Apr 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgInYNqO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DA12AAFD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662231; cv=none; b=kbN14m3qjtqCBqct7wBtlI4HF8sldAS56HzgT/Ik9yHsYPFIUFfKNcy6XlNhnnzypa948K4jKjT/S4DXtJQ38Oou5EgySmmDcxFhqFUK/R/2jjBv+xsSPu8Lz5cqvVJTzFAGHUSMbVj/9FJ05rBLE7Kh8F4fJP27FaYxyRAIWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662231; c=relaxed/simple;
	bh=FRVnXY4MbEwxUbpm7ENrokEpVcnmLdQIC6319kgeLp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boJoXQIBb0QEqkYcBjRqLWcwvzi7YARdeeJGDf4Epb67uOh/HJPGubg4MiPARmVPjgxbzuojGWMRk0Srcnt+YjvFuduSzC+F6guwugVAobfCnL+BwFWM+ghsRkbeqS14BwuL2Y2GVx/TUj1PJmYUcf66NWdpGO8xhAEYzNVb5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgInYNqO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712662230; x=1744198230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRVnXY4MbEwxUbpm7ENrokEpVcnmLdQIC6319kgeLp8=;
  b=RgInYNqOCAWVGjJQWxjJjt6SJfsLKrM0NckMOwB7tTkJk64Y/fKSUzGE
   vvScVjcrtSj4j00DowEbjT0iTNxVldC5quAcluxL9eiZf76IppeFGzZPW
   xg5mZubfHVn621DrCpW80kAoe9YHCSK4bagxCfEgZaL8LhG4+lhShY1FM
   NcuQBjkKld/6wsU46XJULsDQo5YWqLcPBh6CMdOQWjpS9h9EtJoHhYxrJ
   txpNwbbBWozUFt8hNPDdbmVRGwBY7MzKG5EqSGb97urY6ibyjLSFk2I1H
   /9gBGZqyqkOcoUjRM8uyYCFN9IV4meZlSugc4U213Kyx/oJBvl/YU4nM0
   A==;
X-CSE-ConnectionGUID: vO2zgooyQuW/0BpCC2sPHQ==
X-CSE-MsgGUID: knmesmTORWqW961hfnAeMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30460396"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="30460396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093335"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 04:30:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C6CF9A70; Tue,  9 Apr 2024 14:30:17 +0300 (EEST)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv10 07/18] x86/mm: Return correct level from lookup_address() if pte is none
Date: Tue,  9 Apr 2024 14:29:59 +0300
Message-ID: <20240409113010.465412-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, lookup_address() returns two things:
  1. A "pte_t" (which might be a p[g4um]d_t)
  2. The 'level' of the page tables where the "pte_t" was found
     (returned via a pointer)

If no pte_t is found, 'level' is essentially garbage.

Always fill out the level.  For NULL "pte_t"s, fill in the level where
the p*d_none() entry was found mirroring the "found" behavior.

Always filling out the level allows using lookup_address() to precisely
skip over holes when walking kernel page tables.

Add one more entry into enum pg_level to indicate the size of the VA
covered by one PGD entry in 5-level paging mode.

Update comments for lookup_address() and lookup_address_in_pgd() to
reflect changes in the interface.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/include/asm/pgtable_types.h |  1 +
 arch/x86/mm/pat/set_memory.c         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0b748ee16b3d..3f648ffdfbe5 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -548,6 +548,7 @@ enum pg_level {
 	PG_LEVEL_2M,
 	PG_LEVEL_1G,
 	PG_LEVEL_512G,
+	PG_LEVEL_256T,
 	PG_LEVEL_NUM
 };
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e5b454036bf3..6c49f69c0368 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry (or NULL if the entry does not exist) and
+ * the level of the entry.
  */
 pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 			     unsigned int *level)
@@ -666,32 +667,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 
-	*level = PG_LEVEL_NONE;
+	*level = PG_LEVEL_256T;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*level = PG_LEVEL_512G;
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
 		return NULL;
 
-	*level = PG_LEVEL_512G;
 	if (p4d_leaf(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*level = PG_LEVEL_1G;
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
 
-	*level = PG_LEVEL_1G;
 	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*level = PG_LEVEL_2M;
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
 
-	*level = PG_LEVEL_2M;
 	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
@@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
  *
- * Note: We return pud and pmd either when the entry is marked large
- * or when the present bit is not set. Otherwise we would return a
- * pointer to a nonexisting mapping.
+ * Note: the function returns p4d, pud or pmd either when the entry is marked
+ * large or when the present bit is not set. Otherwise it returns NULL.
  */
 pte_t *lookup_address(unsigned long address, unsigned int *level)
 {
-- 
2.43.0


