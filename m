Return-Path: <linux-kernel+bounces-23457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F0082AD10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE0E1C2216E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3025514F9B;
	Thu, 11 Jan 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W61qeUVg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6314F88
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704971554; x=1736507554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1YFtBXWVelzOCij9mu8FZw930rKm1mM6tLkMC1PxwA8=;
  b=W61qeUVgV7B7ZJ/4uZmGD/ID7cFfikWkAYSIqDLkThXVDJGGIsBRHnhz
   n1h6WJqTnxDhvQ9jCr5Snpbl8M1AqvNqTn7p+bl6VBgtCJ1Rr8mXYd6nz
   j1VTXSjcWmOkz1zZN/foNsYQA2XxzgLQhx+L69Q97FZleQ38j5tuC2Nui
   vluMKWTh6TZlf3FmIHTtw05G9p3e7xm+1OrUv4aM0iVueGtC9ZgYXr+8D
   yVwWbkgHF5cqg4QqIGj9pqAEcpA9jsHl9iQULcm67Cf+cEnXgTMuhzvcD
   LKfD3mSgTRzWfDYkv1Mojce0U0kBrRTeLCJ2SJgZGIXv2QGGZMVGv6qX7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6175587"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="6175587"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="24593644"
Received: from gcrisanx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:12:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B879810A557; Thu, 11 Jan 2024 14:12:27 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dexuan Cui <decui@microsoft.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Date: Thu, 11 Jan 2024 14:12:24 +0300
Message-ID: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
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
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
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
2.41.0


