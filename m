Return-Path: <linux-kernel+bounces-130086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2E8973EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0509E1C20E03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8514A092;
	Wed,  3 Apr 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9Dkczu4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD02149DFD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157836; cv=none; b=W8qeF1MAzZoVKK1ZFojw86H2/SxdftIIAvHJBCE8BZVAbGmvshP80qOSLQGnwvHYCVgYyvWmQUS5QQ18eo2Pze7Z2mZQN0Wc1tfbh1ze15zsbCHSbqMIgUWpXjo4gbx6kUGOFpgzGBC6PlS4xBHdC6laieKIIQ8aL1HsuHUsNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157836; c=relaxed/simple;
	bh=c+HYWu5qoda4Xr/d7iNbf5Be/CK/oiDAbZU/Qi/e4y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0Kw5j5W2QU1G0zZE5Gti0cgaP9Grj/nnu8AGsSj3yTfaUDq8NZIRLpwBaatomFs6Hz97Ti91dzIthkQI0T4m3tjvxgrBTSGqBnCeT0KW4wWOPwSGvZ6kuMYv2F0lFVRDw7VlhgPkTvivBiRX9Ye31vW/fbzaT8jNlc0CzQ5wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9Dkczu4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712157836; x=1743693836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+HYWu5qoda4Xr/d7iNbf5Be/CK/oiDAbZU/Qi/e4y4=;
  b=P9Dkczu41FplzeQPvPgcaYLSAvPh8ntcn3sJHNA0x+YGiWW253sj6FOm
   dcsqKbW8bjzmNsR22C0nGztZw59mvR4hNX6tMxSafldT+dIvhBRhWyDTQ
   d8JZufTi6+MCFlbsXD9oazLsGHVAiz63dO6f6ut5ImlF1nn1/GcX3krjp
   WBN2Uuz9c22as2BtkSvKfKhklENoKfsmzmnzjmkq2b9/XAXdwE1AKfZCW
   z+set9s6jVN8vYpWxMcIIjd3U968cjnaiigLgNwxHmgYuTOfTuPmsTMsB
   Fj70OUYnYGShThujt6vn6fuR5B+FLmI8YQDjxXCuB5jyaaStXXGvkM1PL
   w==;
X-CSE-ConnectionGUID: Vk4JoShgTeeAAPQC5DD8Fw==
X-CSE-MsgGUID: /4T5hDCSQX2Qsm7wqkcXYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="29877897"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="29877897"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085208"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 08:23:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A9B1D3E5; Wed,  3 Apr 2024 18:23:48 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: kirill.shutemov@linux.intel.com
Cc: adrian.hunter@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	elena.reshetova@intel.com,
	jun.nakajima@intel.com,
	kai.huang@intel.com,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com
Subject: [PATCHv9.1 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Wed,  3 Apr 2024 18:23:42 +0300
Message-ID: <20240403152342.918612-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on setup, TDX guests might be allowed to clear CR4.MCE.
Attempt to clear it leads to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v9.1:
  - Preserve CR4.MCE instead of setting it unconditionally.

---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..8e2037d78a1f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
+1:
+	testq	$X86_CR4_MCE, %r13
+	jz	1f
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
 1:
 	movq	%rax, %cr4
 
-- 
2.43.0


