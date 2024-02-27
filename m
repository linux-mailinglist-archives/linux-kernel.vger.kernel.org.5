Return-Path: <linux-kernel+bounces-84044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F196C86A1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEB51C27EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210415A49E;
	Tue, 27 Feb 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d14EV88l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2915956C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069119; cv=none; b=hjoeuca9ip3JRJpG8ftBtM2E1GAtFcAG+oWdlyYqPrwIetQWDVTbL0MFqUpDisllnX3iYCZdgtTIxXXp8fRwgtNIK00VLdZCpr94z2mXqMRyZ+ErWZlxZGfk43pSfUj49lUQR1D6cSd5K0eO41fykZAKc0nSEqGjKtkP9tiJ/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069119; c=relaxed/simple;
	bh=R/jnQJ7PA5+pcFQcinQUmyRlg1Ef9fKzEGnFbhwA+qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZinVr64prEXImIYtaOGZoflRzzdK2Q2LsYVcg4DNjOfv2/JH8iNsn8Gqb+jr5l9G06vX7lv55W6c/LygFzKU0iwTd7IAc83lmCp6lMn5KjIPhrZNABcRuQWfwku7bgMOItRucR1YVGRk2v1Jnv3ghpFHkbYh2XkomJY/89WVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d14EV88l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069118; x=1740605118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/jnQJ7PA5+pcFQcinQUmyRlg1Ef9fKzEGnFbhwA+qE=;
  b=d14EV88ld00Sulgujh7RLzaDyIjZZMRAe/LxaFg743yl50l/qfFAPkoT
   86R+Cslc3MM/nXOtze3TbSo/2CNDLmjLoP5oai/Phr9VpOTrWLfGwuWDr
   uIL2HLgogZgx/MVgDW6x7KGyZFvAWF6KEMVFtgvca1azjR3naML8WnAxu
   vnblSDThzf+wi54HUy8epX2ECL4Iac+uTKNMACaS8av613+/EgEZJROlg
   lyy8jIA/DgHIfzgmATbjbSMzQShOksRQNysq16DLrWGJUiFuwBizuWvaV
   YDWi99jLtGapyX+l8HHmo79V7aLfRC5ABKI7Bc7H50EdIpaC4RLszfGRG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3567071"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3567071"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032922"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032922"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 720C6B0D; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
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
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCHv8 11/17] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
Date: Tue, 27 Feb 2024 23:24:46 +0200
Message-ID: <20240227212452.3228893-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
things, guides where direct mapping ends. Any memory above max_pfn is
not going to be present in the direct mapping.

e820__end_of_ram_pfn() finds the end of the ram based on the highest
E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
calculation.

Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
tables and might be required by kernel to function properly.

Usually the problem is hidden because there is some E820_TYPE_RAM memory
above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
can fit under the last E820_TYPE_ACPI range.

Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
E820_TYPE_ACPI memory.

The problem was discovered during debugging kexec for TDX guest. TDX
guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
it between the kernels on kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/kernel/e820.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..99c80680dc9e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -827,7 +827,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type type)
+static unsigned long __init e820_end_ram_pfn(unsigned long limit_pfn)
 {
 	int i;
 	unsigned long last_pfn = 0;
@@ -838,7 +838,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
-		if (entry->type != type)
+		if (entry->type != E820_TYPE_RAM &&
+		    entry->type != E820_TYPE_ACPI)
 			continue;
 
 		start_pfn = entry->addr >> PAGE_SHIFT;
@@ -864,12 +865,12 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 
 unsigned long __init e820__end_of_ram_pfn(void)
 {
-	return e820_end_pfn(MAX_ARCH_PFN, E820_TYPE_RAM);
+	return e820_end_ram_pfn(MAX_ARCH_PFN);
 }
 
 unsigned long __init e820__end_of_low_ram_pfn(void)
 {
-	return e820_end_pfn(1UL << (32 - PAGE_SHIFT), E820_TYPE_RAM);
+	return e820_end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
 
 static void __init early_panic(char *msg)
-- 
2.43.0


