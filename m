Return-Path: <linux-kernel+bounces-158943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452318B2730
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96BD1F25398
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB414D710;
	Thu, 25 Apr 2024 17:07:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C045149E0E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064839; cv=none; b=D2tl4Ny2L3CzUdGhP8UOCgO0v24ZIG5/MfpUg/fk5MyEx+LCbKIvP1n/OAQa17QlnJL0htjrybTKs1o7KJh/McDYmHevGwjY+4LzZ3OglKiUMv9MtrpSEnMytsBMboXv6Z8TSng182cEXXCDecvDgaEOGc4NNNhaDbCMOIUdX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064839; c=relaxed/simple;
	bh=tHJXdKY1e6AqpOg19P28+P4MIhlfRIV7LEXxAPsKJ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brwnmaxMqtRLl1gI94WcvMpJdCW+HiQNB0cGxg4cOVXsAlDyILigzJiCbFKUDTRJ0OTplluLnXNHzjC+uagVtNW4zZS0JDNnJ6+gEhF4YEzGNO8bhHG2IykynUJS/nO5Bjii073gKBn2+6+AtMhtiC2ejolrexmqMmgosE62Akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC501007;
	Thu, 25 Apr 2024 10:07:43 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1813F793;
	Thu, 25 Apr 2024 10:07:14 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and GUP-fast
Date: Thu, 25 Apr 2024 18:07:04 +0100
Message-Id: <20240425170704.3379492-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__split_huge_pmd_locked() can be called for a present THP, devmap or
(non-present) migration entry. It calls pmdp_invalidate()
unconditionally on the pmdp and only determines if it is present or not
based on the returned old pmd. This is a problem for the migration entry
case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
called for a present pmd.

On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
future call to pmd_present() will return true. And therefore any
lockless pgtable walker could see the migration entry pmd in this state
and start interpretting the fields as if it were present, leading to
BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
I suspect the same is possible on other architectures.

Fix this by only calling pmdp_invalidate() for a present pmd. And for
good measure let's add a warning to the generic implementation of
pmdp_invalidate(). I've manually reviewed all other
pmdp_invalidate[_ad]() call sites and believe all others to be
conformant.

This is a theoretical bug found during code review. I don't have any
test case to trigger it in practice.

Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.

Thanks,
Ryan


 mm/huge_memory.c     | 5 +++--
 mm/pgtable-generic.c | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 89f58c7603b2..80939ad00718 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * for this pmd), then we flush the SMP TLB and finally we write the
 	 * non-huge version of the pmd entry with pmd_populate.
 	 */
-	old_pmd = pmdp_invalidate(vma, haddr, pmd);

-	pmd_migration = is_pmd_migration_entry(old_pmd);
+	pmd_migration = is_pmd_migration_entry(*pmd);
 	if (unlikely(pmd_migration)) {
 		swp_entry_t entry;

+		old_pmd = *pmd;
 		entry = pmd_to_swp_entry(old_pmd);
 		page = pfn_swap_entry_to_page(entry);
 		write = is_writable_migration_entry(entry);
@@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
+		old_pmd = pmdp_invalidate(vma, haddr, pmd);
 		page = pmd_page(old_pmd);
 		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4fcd959dcc4d..74e34ea90656 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
+	VM_WARN_ON(!pmd_present(*pmdp));
 	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return old;
@@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON(!pmd_present(*pmdp));
 	return pmdp_invalidate(vma, address, pmdp);
 }
 #endif
--
2.25.1


