Return-Path: <linux-kernel+bounces-37084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27C83AB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9BD1F263AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEA7A702;
	Wed, 24 Jan 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr6kEbpZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AC22084
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104948; cv=none; b=DfWZVuiDix65tP9XLHrJeScVdboB/qBERHa8U3gxIKFM8EuNLrOCMhInMzX5qUFqVzcB3r3MWpz+Y2rJWhkmi65TLlsj9jeipT+YdNdFSPi8psoDIROYQp8kRXjPKwLwA1ys120EmIFhBUgUOpXaaeXw4OUZuUkDr24AgoWQHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104948; c=relaxed/simple;
	bh=kMLlSWZyVMHXVTtl/OfZFuYeY/EXz2BpA61dEoPloQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cehh4w7KTtXTZWHh2jKiqD+6lxOf9fVYkc2DWYIMkn2neBvejK7T1tU9wmseDEANKPygrYWGenuZprgbMTKqWNoSN0CREAkcDHcREnvowrR4b+jftf1mZCoyGaoi5X/ryO32vDqRS74TOaY03494wUNFtsfiK40FrQFk02zVDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tr6kEbpZ; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706104946; x=1737640946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kMLlSWZyVMHXVTtl/OfZFuYeY/EXz2BpA61dEoPloQE=;
  b=Tr6kEbpZzLlmIsMdpPOSNUoM+b23+pWULVRJsX7ScKqCzxSx24wRbL3a
   8VV10f8ZQirSD0oWpolNRxEMSPwO/ZDiFLVGv9IvIHp5wAobrORi5OqBW
   xRfuMfxxkYouxD6T7YxcdN0/MivPMJPK9bUeiHnbSGXmJUcxPXd18yS03
   NM9wpLZ35gPY5ZzRK1ChLm+kJp9wSQYMxehvtgHY+XrGz75n6w8Fy1JpU
   SNnL4khow/POMqY9o8WmhV/+QD2xb0ok3rjlsHAw8hQK6ZABDwS7Wg1CS
   20SegcwfctVhiNNUeYQyL67mM0lDtNQCj8onpekplJbqu5XA+/AZtONHi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400704262"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400704262"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909667796"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909667796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2024 06:02:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2B41587; Wed, 24 Jan 2024 16:02:20 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCHv2, RESEND] x86/mm: Fix memory encryption features advertisement
Date: Wed, 24 Jan 2024 16:02:16 +0200
Message-ID: <20240124140217.533748-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When memory encryption is enabled, the kernel prints the encryption
flavor that the system supports.

The check assumes that everything is AMD SME/SEV if it doesn't have
the TDX CPU feature set.

Hyper-V vTOM sets cc_vendor to CC_VENDOR_INTEL when it runs as L2 guest
on top of TDX, but not X86_FEATURE_TDX_GUEST. Hyper-V only needs memory
encryption enabled for I/O without the rest of CoCo enabling.

To avoid confusion, check the cc_vendor directly.

Possible alternative is to completely removing the print statement.
For a regular TDX guest, the kernel already prints a message indicating
that it is booting on TDX. Similarly, AMD and Hyper-V can also display
a message during their enumeration process.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/mm/mem_encrypt.c | 56 +++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..d035bce3a2b0 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -42,38 +42,42 @@ bool force_dma_unencrypted(struct device *dev)
 
 static void print_mem_encrypt_feature_info(void)
 {
-	pr_info("Memory Encryption Features active:");
+	pr_info("Memory Encryption Features active: ");
 
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-		pr_cont(" Intel TDX\n");
-		return;
-	}
+	switch (cc_vendor) {
+	case CC_VENDOR_INTEL:
+		pr_cont("Intel TDX\n");
+		break;
+	case CC_VENDOR_AMD:
+		pr_cont("AMD");
 
-	pr_cont(" AMD");
-
-	/* Secure Memory Encryption */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/* Secure Memory Encryption */
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
+		*/
+			pr_cont(" SME\n");
+			return;
+		}
+
+		/* Secure Encrypted Virtualization */
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+			pr_cont(" SEV");
+
+		/* Encrypted Register State */
+		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+			pr_cont(" SEV-ES");
+
+		/* Secure Nested Paging */
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			pr_cont(" SEV-SNP");
+
+		pr_cont("\n");
+		break;
+	default:
+		pr_cont("Unknown\n");
 	}
-
-	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		pr_cont(" SEV-ES");
-
-	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_cont(" SEV-SNP");
-
-	pr_cont("\n");
 }
 
 /* Architecture __weak replacement functions */
-- 
2.43.0


