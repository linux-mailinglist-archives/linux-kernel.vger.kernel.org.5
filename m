Return-Path: <linux-kernel+bounces-99404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5B8787ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2176B281BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F660DE6;
	Mon, 11 Mar 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr/Bqk76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151155782;
	Mon, 11 Mar 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182328; cv=none; b=uuZ58N6Zfq/+LpaGOisdG+SZxfE5kPXEx6Row7Ufds4MiFh8JrLGo75vurIuIOiB26oPpXdaVruHyBI6dM+ggqabM3o63mG3DDpHzXBYfeZetoBw6yQg9DNEzcLQcxjOKmgc51MyJfXROdI2ilobyF6Rr9N8B0SsW7Jf63LlL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182328; c=relaxed/simple;
	bh=iVJcHp1ylZb9WznCQWx4gusFdtP2Tlc76UN0f+Y0b1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVTT2cR0pK+ePtL7AKeoMcpLoka13Mm5wFoQB1+XzPIgGZDk6iOnFuAmeSpd8xjvCq6hgvUoMM2ScFufKE5jhdhhCps1BtfPvUIJmiO8sBr0cnbl+fRJNh/MZpFKtStMu+fjCnGGMQtIOf5QNobEMdVbRE5/wGuaDTA5y/k+f1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr/Bqk76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F8C433F1;
	Mon, 11 Mar 2024 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182327;
	bh=iVJcHp1ylZb9WznCQWx4gusFdtP2Tlc76UN0f+Y0b1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pr/Bqk76phpYDNoPlCuyqSLGYta95AhNeAVCI6a5SZ7U3u4YAZjOLyZLVwQFEg3kG
	 kGpD5vjcYakr3iw5Lmu4qVxvb0dJXGR4GwhsBQC054mIbyg+AM9UiDAqGUlaUS2UEP
	 1h7G68cp5rZt7yqkqk+M7zAY6orYydMUpJXXHzvdM9VbOOr21UR3LNAKHm1lli46Q1
	 YYMm77R+W7MeYOcuhRxAUNVmHsuFLO4lqDTPiqQG1BGE/urd8xedKwaygDBa8qHcSL
	 oEzS0eSY9b0qcB2xi9kb6sVgmU3E4Mtsyg0ZQ8ve7mYxsupWXLGZhCDA9YhpqyD6tu
	 iMYepxp2t0jVg==
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
Subject: [PATCH AUTOSEL 6.1 3/7] x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor callback
Date: Mon, 11 Mar 2024 14:38:21 -0400
Message-ID: <20240311183826.328535-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183826.328535-1-sashal@kernel.org>
References: <20240311183826.328535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index 1dbcbd9da74d4..fd08270dd7946 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -332,6 +332,8 @@ int hv_set_mem_host_visibility(unsigned long kbuffer, int pagecount, bool visibl
 	enum hv_mem_host_visibility visibility = visible ?
 			VMBUS_PAGE_VISIBLE_READ_WRITE : VMBUS_PAGE_NOT_VISIBLE;
 	u64 *pfn_array;
+	phys_addr_t paddr;
+	void *vaddr;
 	int ret = 0;
 	int i, pfn;
 
@@ -343,7 +345,15 @@ int hv_set_mem_host_visibility(unsigned long kbuffer, int pagecount, bool visibl
 		return -ENOMEM;
 
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
index 5f0ce77a259d8..fcc0d0f16be3f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -723,10 +723,14 @@ pmd_t *lookup_pmd_address(unsigned long address)
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


