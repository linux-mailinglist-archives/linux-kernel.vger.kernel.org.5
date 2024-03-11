Return-Path: <linux-kernel+bounces-99391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361B8787BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59E01F2454C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483EA5D903;
	Mon, 11 Mar 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejTwuR/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F35D8E4;
	Mon, 11 Mar 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182269; cv=none; b=npsCq2+N2FcvudEHyHb+MazXxbiOSTTL7TTJF8zazQuvwEBraGLHxWExMvLIw1P27wTOuby6Hg0Fs5fkBJBeOsUP2EtYvjBodErfyFdbRE5FImmfhxvYv1rP4m8CEmZd4o9d8Qcc4eRTOoAutuoR7dvmfVaxfiMb9068kjohtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182269; c=relaxed/simple;
	bh=JMIrqkXSyJesx8styDYE/rwVLPhnB+Uu7VY6ykF1GMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCT2YWL52ApZWSYu6c9hm5kRGpOjGTwXPp9RiACokoXl40zrhI3EGLW5DnFd2gllCEXr1Juxt4VJ1634EtHLekvdMDTAUjA+SkSOcUBwU0e2shY7YaClfEYm0l5OW8UuShlJ54Vy7xbRFydd0qJeODffaDokWgCwopozN1TQcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejTwuR/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B8C43601;
	Mon, 11 Mar 2024 18:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182269;
	bh=JMIrqkXSyJesx8styDYE/rwVLPhnB+Uu7VY6ykF1GMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejTwuR/bC5NXUyJxFNffxz1T3iA/KGAhFGxeY1aO36raXS0/ibKLUR87AwWLE5in7
	 VXGPUqxKD8S3IobYFaGLp1JwUJyM9Vn0kbj6JhQ5eVuE6usUfP5FTz9zGJGFoor7b0
	 nrJoOcjY3Tk54KPheNegGc2YdCa2Ja1rnpsgErEAS8k4zGxsF0aqt+g9O28ieROn/c
	 AQGU05qjkmwWYEVrFDUsTOWs541fPthFpdGb6Kp1nGjObVUwN9ZyCcBAYPn/LQJD37
	 HBvYee1gSz5TqGqnSnUkf1xdDktkrupmHdQEaVH+zBFp8Ypq0mRanx6RH5o1Buqy/S
	 c3Q/DfhYQtZvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	sthemmin@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 6.6 03/12] x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor callback
Date: Mon, 11 Mar 2024 14:37:17 -0400
Message-ID: <20240311183727.328187-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 9fef276f9f416a1e85eb48d3bd38e6018a220bf5 ]

In preparation for temporarily marking pages not present during a
transition between encrypted and decrypted, use slow_virt_to_phys()
in the hypervisor callback. As long as the PFN is correct,
slow_virt_to_phys() works even if the leaf PTE is not present.
The existing functions that depend on vmalloc_to_page() all
require that the leaf PTE be marked present, so they don't work.

Update the comments for slow_virt_to_phys() to note this broader usage
and the requirement to work even if the PTE is not marked present.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/r/20240116022008.1023398-2-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240116022008.1023398-2-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/ivm.c        | 12 +++++++++++-
 arch/x86/mm/pat/set_memory.c | 12 ++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8c6bf07f7d2b8..4bf3805aa8ab5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -515,6 +515,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
+	phys_addr_t paddr;
+	void *vaddr;
 	int ret = 0;
 	bool result = true;
 	int i, pfn;
@@ -524,7 +526,15 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
-		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
+		/*
+		 * Use slow_virt_to_phys() because the PRESENT bit has been
+		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+		 * without the PRESENT bit while virt_to_hvpfn() or similar
+		 * does not.
+		 */
+		vaddr = (void *)kbuffer + (i * HV_HYP_PAGE_SIZE);
+		paddr = slow_virt_to_phys(vaddr);
+		pfn_array[pfn] = paddr >> HV_HYP_PAGE_SHIFT;
 		pfn++;
 
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e9..355dc8f5cb7dd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -755,10 +755,14 @@ pmd_t *lookup_pmd_address(unsigned long address)
  * areas on 32-bit NUMA systems.  The percpu areas can
  * end up in this kind of memory, for instance.
  *
- * This could be optimized, but it is only intended to be
- * used at initialization time, and keeping it
- * unoptimized should increase the testing coverage for
- * the more obscure platforms.
+ * Note that as long as the PTEs are well-formed with correct PFNs, this
+ * works without checking the PRESENT bit in the leaf PTE.  This is unlike
+ * the similar vmalloc_to_page() and derivatives.  Callers may depend on
+ * this behavior.
+ *
+ * This could be optimized, but it is only used in paths that are not perf
+ * sensitive, and keeping it unoptimized should increase the testing coverage
+ * for the more obscure platforms.
  */
 phys_addr_t slow_virt_to_phys(void *__virt_addr)
 {
-- 
2.43.0


