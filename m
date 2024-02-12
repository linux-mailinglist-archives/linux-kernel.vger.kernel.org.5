Return-Path: <linux-kernel+bounces-61357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A3851163
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FD11C22530
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A863B2A6;
	Mon, 12 Feb 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGgpLoD2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406B3A8D5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734708; cv=none; b=JENKDga0DLLeACPA8tewhBoOEToWoftolWvVdpozHWUxsAcyog6gWlWShPzJinF5+DCROMTQrc5UmYG4sFKTCb1tpTicFy3GHhfIDHrCET15XN+82sOpQMi/qn1PwRXMWIUMSOhuQ5Izr3Eh2B+8xh2TxqJQ7NPfySyIS6oKOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734708; c=relaxed/simple;
	bh=SxAJq8PySGkIldIS+Dq+6BevKxjnV/qVUXBP60oIUiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY8M6HCaN1Y4CAKHnrrxDen3YPmktBcA0irOjBb/2FUTaB6CY8C5+Nro5obi1hG05jZi0PlpDUbcuEi+TgBrphd2K3OXFJ/8an0/kgoYMlxZvZkosyvqh54gWI0fbtWkgVTTn38CcRXUepAbgrFTl+8p3SqDYIoXu2ne+xb95es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGgpLoD2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707734705; x=1739270705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxAJq8PySGkIldIS+Dq+6BevKxjnV/qVUXBP60oIUiw=;
  b=RGgpLoD23pZM1KAvseQfdqsnUo9zf+Vh25P/SEJo81e5kHVkjDY625Ti
   13a5h2HGe3e6gXCoW7ApB1DIirVB2QGbbtJ72xxmEqxT3s39sJU66KhMJ
   TvHSc3mK2hgVxGpgq6HujSHT10tcSBVlk1efJA7vYV8ytTGf28SJEP5Pj
   hkWPZJ6ze6kUN3gY4NmP4WtCGvma5Xg82FUWgdjQ3m/qmYdK6MCmp4rp3
   ufhqPVyjDks87adoEfDfYCoVP1yZU7tYgfomZx1P/HqVf0PQLsuqixvx5
   GxN4bA+LYQMeJuBdg3AAOzDp/REq4IX4vvZl3q+T6eMl6sQyrE+qSIbgA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1585047"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1585047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935035597"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="935035597"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 02:45:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 483AE53A; Mon, 12 Feb 2024 12:44:53 +0200 (EET)
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
Subject: [PATCHv7 07/16] x86/mm: Return correct level from lookup_address() if pte is none
Date: Mon, 12 Feb 2024 12:44:39 +0200
Message-ID: <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_address() only returns correct page table level for the entry if
the entry is not none.

Make the helper to always return correct 'level'. It allows to implement
iterator over kernel page tables using lookup_address().

Add one more entry into enum pg_level to indicate size of VA covered by
one PGD entry in 5-level paging mode.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 1 +
 arch/x86/mm/pat/set_memory.c         | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index f92da8c9a86d..3612e3167147 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
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
 	if (p4d_large(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*level = PG_LEVEL_1G;
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
 
-	*level = PG_LEVEL_1G;
 	if (pud_large(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*level = PG_LEVEL_2M;
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
 
-	*level = PG_LEVEL_2M;
 	if (pmd_large(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
-- 
2.43.0


