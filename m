Return-Path: <linux-kernel+bounces-33995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42A8371AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AF51C26B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016955C3A;
	Mon, 22 Jan 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIl3LD3L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F855C30
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948817; cv=none; b=FtslDYW6sQcpjV5SKIbcHIyoHOtu4lX5ghfpDhG4q4I9YgifG6BnNREvYrgIs5sdrBK7sFe6WA3aWQw0gG5QGvG2yGwgxGoqcQ58dBAX1fyZ7wu+KJZvFm49ipN564jy0WE3Rfvm9/rx6AHVXX08TPzfn90cNGtMY5qVYu1PYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948817; c=relaxed/simple;
	bh=1nu2DhOh/V7w6Lm1HJ4NygnNAaN6RKpZ4eSyAXucXx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HD6xVqjEiBCc+qbtMnbcWBtgbicL5xUOGsh6V07Zzxs03i9nlWo8YiEIKuxKBrp+hJbp8utk300vpOwGyqTY3ZcYUNDHPrBC5dySMrSimPGReU4pYmRsgwNJhpD6Z328W4EKrpkSyRFCMH7Isipdb9xE9fm9LdfAjzDhpGEAEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIl3LD3L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705948815; x=1737484815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1nu2DhOh/V7w6Lm1HJ4NygnNAaN6RKpZ4eSyAXucXx8=;
  b=PIl3LD3LdWvLwcoWVXlMy2pyt5ADUQi4yI4wxFfsYd4OqzAd9D47XH3Y
   x5YxIKb9HtRAC7r6g3JlLkDKVZOLYaG29Qx56bJsYrXquymxWXCsEY+lt
   1oyZgDmZ9IVSDTgXxdDCvTFo2mabMK5dEGvtNv6AXvU2Kt0c3p4oZmBkn
   R3vVzSwsN7suE48TAooTUC/UyJtZ+CcMn63gRRbIvqIF1ZKsXqTREL+sm
   sSjaYx9EuF2ofOSdvdDbdm1iGe8bsAT8qgXucTHK5m+uXaaFEXvvMsPXl
   Ne2CkoWrOlKTKCFpWJ3ENZlFOFFPLTaAZltLL5gNadTZ7/AVJO3hNi8xK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14802332"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="14802332"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1292147"
Received: from lmneiber-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.176.143])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:40:11 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com,
	isaku.yamahata@intel.com,
	seanjc@google.com,
	mikelley@microsoft.com,
	thomas.lendacky@amd.com,
	decui@microsoft.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v3] x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails
Date: Mon, 22 Jan 2024 10:40:03 -0800
Message-Id: <20240122184003.129104-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.
In terms of security, the problematic case is guest PTEs mapping the
shared alias GFNs, since the VMM has control of the shared mapping in the
EPT/NPT.

Such conversion errors may herald future system instability, but are
temporarily survivable with proper handling in the caller. The kernel
traditionally makes every effort to keep running, but it is expected that
some coco guests may prefer to play it safe security-wise, and panic in
this case. To accommodate both cases, warn when the arch breakouts for
converting memory at the VMM layer return an error to CPA. Security focused
users can rely on panic_on_warn to defend against bugs in the callers. Some
VMMs are not known to behave in the troublesome way, so users that would
like to terminate on any unusual behavior by the VMM around this will be
covered as well.

Since the arch breakouts host the logic for handling coco implementation
specific errors, an error returned from them means that the set_memory()
call is out of options for handling the error internally. Make this the
condition to warn about.

It is possible that very rarely these functions could fail due to guest
memory pressure (in the case of failing to allocate a huge page when
splitting a page table). Don't warn in this case because it is a lot less
likely to indicate an attack by the host and it is not clear which
set_memory() calls should get the same treatment. That corner should be
addressed by future work that considers the more general problem and not
just papers over a single set_memory() variant.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 - Rebased on tip/x86/tdx.
 - Added Reviewed-by's.
 - Changed subject per Dave's comments.
 - Moved comment "Notify hypervisor that..." closer to code it refers
   to.
---
 arch/x86/mm/pat/set_memory.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..d4323ab7c970 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
+		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2166,13 +2166,20 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
-	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		goto vmm_fail;
+
+	return 0;
+
+vmm_fail:
+	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
+		  (void *)addr, numpages, enc ? "private" : "shared");
+
+	return -EIO;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)

base-commit: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
-- 
2.34.1


