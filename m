Return-Path: <linux-kernel+bounces-61355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1F851162
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902DA285139
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20353B2A1;
	Mon, 12 Feb 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tylije1X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D03A8D0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734708; cv=none; b=YSZi1rH2xB9tw01CQu8Od2mJy4zrTI4Rj1kP+e+Y7D3MsznlO7pCIW+en6VjSv9iWsqkGwDocSDWs6rc5QZEF1IQgDDQNXGFv8owTIc41BIutmswbtV6D9TyGuBLQdhO0yUB4fH4LAaOt+NLVMHFh1fA7n/2Da3/GHF1ni5x+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734708; c=relaxed/simple;
	bh=LcZSO2fCT5WaMkS6shCgOhCUo14EJT04WN8x+U0u+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMOpwxd4BjbYZNq7ug6ElUwuewDh660RJP3dZxylFQFR032MvGskC0XSvkcMfGio/2KlEFVVEhonDLjsUnYFJW6OpTUKbmUbgJ8ZxI9hVS6QxhlbUUlAqXJJ9WWuPLR20SJ1fJXt/AYXxSDnbcs4pWmv71CX2UxEl4k5NSZiX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tylije1X; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707734705; x=1739270705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcZSO2fCT5WaMkS6shCgOhCUo14EJT04WN8x+U0u+KI=;
  b=Tylije1XYbeDB2PsUKT2HT5vnHXUbWdGgPOLE367e5DegQFUY0tRDbqn
   PadWDmmQmoAgy5r2m7jfevRpJVwRZVleCtfBt4zs3CKPSF7JO/gSlkqqZ
   jR3gdhKXbDuZ6sXUCcJoMC6z5x10nuCtzbxHAnMjJW0vLO/YpZE+ClX9c
   X7lMSR0qwAoMCM12iVAX2yCbJLJOwwHN0mF6XgBddw13GpsKrtfHyLXO1
   fT5iyyznsvBpBJObBE1FBeV7BULBcnQbiWCu0KZlbNFQLGH0NmEXIh2Pq
   TyjPGniXekkq+CHH7mpSZfTtK6JWPorr09RHKZ21K9mAtHobth5vy7U4x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1585057"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1585057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935035599"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="935035599"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 02:45:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2AEBC535; Mon, 12 Feb 2024 12:44:53 +0200 (EET)
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
Subject: [PATCHv7 05/16] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Mon, 12 Feb 2024 12:44:37 +0200
Message-ID: <20240212104448.2589568-6-kirill.shutemov@linux.intel.com>
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

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..e144bcf60cbe 100644
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
@@ -145,12 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
+	 *    in TDX guests.
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
 1:
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
 	movq	%rax, %cr4
 
 	jmp 1f
-- 
2.43.0


