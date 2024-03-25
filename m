Return-Path: <linux-kernel+bounces-116856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9EF88A49C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AA42E2F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F4517C65B;
	Mon, 25 Mar 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcOqF1gW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AC14A0AF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363218; cv=none; b=SDvOJok7gDxYZodHqfayxs7EPKQePD2I2VMx8KBwj4oI1/QdGLHhkR20rDoO4LDfSuXnWUTSj9HnDCmn6wOl6M00NMYBUypoBF4X9NV+x3epfyzJw383XvfdTMDTXmk3shxg/7OXH8LHYSeeMZvgroZNlExOl2ShFpk9ZAKo8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363218; c=relaxed/simple;
	bh=7jFuowaz0Vw+N4idIIhc+R9JJKXqB88Qml6sO/pIcmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWBlFCM9MQVpESN0z9TWKYPDAr6JWVZYW27DFYqw2zKW5De/cf4yT4vHd22ZRYTXgiwPYTriHH7cElsIEumC038gjSnQjwxuC4UQgBKjLiH4W5iRaQmiwx/R+DUUTAajPZCaJT/wdZi4xbiirjDmw/qboN+Zl3FREO7uIbeErzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcOqF1gW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363216; x=1742899216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jFuowaz0Vw+N4idIIhc+R9JJKXqB88Qml6sO/pIcmM=;
  b=jcOqF1gWpfKrhBOoMDCkvEu+OSJEXc+xnQOqXnjAtowkDPc1k0vHiVG+
   PIarShMNhiC1x76sACEMWpZrSEWH+jcXZLbi9JDUIpvHLjCQLuvOwRIYz
   bX9WqqTcfJD2pAcza6u/ZTjCqaB9M/ahLqv2iT40XrOxKN4+GptqxpkUJ
   V0rqGw/75zyPzAsfKtZnMAiVtcyxxIi3tGOBVp2iSsNn6HBPqDYW7gZqm
   eaRIdtKPZxUuvaVqgxevGcDGkbkEJCxrVInYofp0UTNTgh2oMT7M/liJx
   MFlKnqT0uy2DY067j8oVtkvqlEb+mqVA4VzJVUUSoSEAZhocEryU03Eej
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561356"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070149"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070149"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 149005A8; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
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
Subject: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Mon, 25 Mar 2024 12:38:59 +0200
Message-ID: <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
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

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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


