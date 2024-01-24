Return-Path: <linux-kernel+bounces-37040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14CD83AA80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103661C274F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EA7A72E;
	Wed, 24 Jan 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmVphWRR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999C77654
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101149; cv=none; b=qv4EC1oF3ngdxkrmZcMgVZ/caJaWg1sJjc/bnwgv9ror5a+5UocMGW5f0b3qGwtSuCkd3SVYNh945IWzm6CXTTA4YdkVCyGNAHJX99uQrsaoUja/YfVo34JY1KubzYOU3WAxsuPHH+d57uh02qQ2vMvgRYOaGf/YRWuJUFvRUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101149; c=relaxed/simple;
	bh=ttorKfrAsCfwHjNDg0dNsgpEDrTBddN8JkJtVUzul2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go0jV6r4OfeqzqEBQ4z1PbZJirw9FmMkdbLYw0MELjcmweCxXPdo9sU2nlWKsl62ldH8ZIt2tx2TIPBxzqd2ALKtPJo3JsLl4aaPVPrinPxGS63LXrlImI+hVQG8jH2QgvN3Gw/hj+fuydWqbZWBQJP+sZKBvrNXDNJr7u9w0qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmVphWRR; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101148; x=1737637148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttorKfrAsCfwHjNDg0dNsgpEDrTBddN8JkJtVUzul2k=;
  b=TmVphWRR7I+yNOPKnJhmoYqbA9DV9IeeDCJdN6iQh00riT0T1JWhYvAe
   R8OoJdQe1dstzFxD/ZItrK6TBioLkMxuZyXmR0IShIEvT4wUuq5+5nmMQ
   oye00VfFv4SHvS6wTqMLBfUA2KFZ7giyD9EDxbkc6Z8XJqOaKHBnDivc7
   9LukxAISjSLMjAm6sv6MK+q2egMCwKozt30toVusSyDIzXk+V/Fq9PTWs
   NG2FKSOq24PAWFrtlDo9tinESvECl4ipNlHxOzkr1cyylPKZU0E06aFWM
   1DPsDx/fad5Ux2iZvuX87c2uU9IITidE9TsEOaRvB5dROYBD+O9PFOqwm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110888"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924196"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:58:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 79DB976F; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
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
Subject: [PATCHv6 08/16] x86/tdx: Account shared memory
Date: Wed, 24 Jan 2024 14:55:49 +0200
Message-ID: <20240124125557.493675-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will convert all shared memory back to private during kexec.
The direct mapping page tables will provide information on which memory
is shared.

It is extremely important to convert all shared memory. If a page is
missed, it will cause the second kernel to crash when it accesses it.

Keep track of the number of shared pages. This will allow for
cross-checking against the shared information in the direct mapping and
reporting if the shared bit is lost.

Include a debugfs interface that allows for the check to be performed at
any point.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26fa47db5782..fd212c9bad89 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <asm/coco.h>
@@ -38,6 +39,13 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+static atomic_long_t nr_shared;
+
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -821,6 +829,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
 		return -EIO;
 
+	if (enc)
+		atomic_long_sub(numpages, &nr_shared);
+	else
+		atomic_long_add(numpages, &nr_shared);
+
 	return 0;
 }
 
@@ -896,3 +909,59 @@ void __init tdx_early_init(void)
 
 	pr_info("Guest detected\n");
 }
+
+#ifdef CONFIG_DEBUG_FS
+static int tdx_shared_memory_show(struct seq_file *m, void *p)
+{
+	unsigned long addr, end;
+	unsigned long found = 0;
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte))
+			found += size / PAGE_SIZE;
+
+		addr += size;
+
+		cond_resched();
+	}
+
+	seq_printf(m, "Number of shared pages in kernel page tables:  %16lu\n",
+		   found);
+	seq_printf(m, "Number of pages accounted as shared:           %16ld\n",
+		   atomic_long_read(&nr_shared));
+	return 0;
+}
+
+static int tdx_shared_memory_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tdx_shared_memory_show, NULL);
+}
+
+static const struct file_operations tdx_shared_memory_fops = {
+	.open           = tdx_shared_memory_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static __init int debug_tdx_shared_memory(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return 0;
+
+	debugfs_create_file("tdx_shared_memory", 0400, arch_debugfs_dir,
+			    NULL, &tdx_shared_memory_fops);
+	return 0;
+}
+fs_initcall(debug_tdx_shared_memory);
+#endif
-- 
2.43.0


