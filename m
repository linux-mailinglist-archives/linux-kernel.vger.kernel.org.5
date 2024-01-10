Return-Path: <linux-kernel+bounces-22663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E7382A113
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B078286291
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF54EB28;
	Wed, 10 Jan 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GO/bEydH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFC4EB27
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704915334; x=1736451334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iOgBXT4oCCP14tPNy05HoJwBeWOx4dK8ykFicOjjzso=;
  b=GO/bEydHcguuLci+9xM+NtwY2es1C4oCN41MI0PEldxyK2GPE6HRUYHP
   0N6HnUHQ1PfeCyF7sZDJM/1Ivx131xVWc/bUgBvlMEdUZUAzq74AFyPt/
   z2te7/lyKFV2RGdHQa/0OqaVxYYIoUui2iz5jXTWPVjLhENCtxmpX+Pu6
   Lk5vw0UPAsnUE3ruQDqQu4DzCXjviGO7GDd+Q+iyVe0esxe0eg3OE6jeo
   KihWDYt45I6eYAsYNYWi9Kk19YkZXiceiiAOK2HJ7LN9MdjKr3CMijO4F
   JTzh9MF5f+yvWPZzylbLJgcXB7HhJpK/p3OVe2VoSFTreuf9jwCn3AtUW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5377875"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5377875"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 11:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="775325186"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="775325186"
Received: from jganji-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.249.37.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 11:35:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8A36010A3F6; Wed, 10 Jan 2024 22:35:27 +0300 (+03)
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
	Dexuan Cui <decui@microsoft.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCH] x86/mm: Fix memory encryption features advertisement
Date: Wed, 10 Jan 2024 22:35:14 +0300
Message-ID: <20240110193514.15620-1-kirill.shutemov@linux.intel.com>
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

The check assumes that everything is AMD SME/SEV if it has the TDX CPU
feature set.

To avoid confusion, check the cc_vendor directly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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


