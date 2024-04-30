Return-Path: <linux-kernel+bounces-164018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88548B7733
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E161C22811
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78E171E45;
	Tue, 30 Apr 2024 13:31:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B417165C;
	Tue, 30 Apr 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483914; cv=none; b=aylwXWKJsW0LjyaXXAG7meUsFJP051OP3oxpCleWxhwjtyk6hZkN54iuWnLnNvwd2yHe5akLqQdyPSi8C1KAMujQJu6rYFtBC1auxrjG0yRZflUL8sKb/OA1OWwZYnDnk+dd54k8geDICMzvkVeSkdZFqV8/PMq/Y4erw+rSIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483914; c=relaxed/simple;
	bh=hD6QLqSLsE+vq7qrfMWamupfDTBtpVkRT+1l1z85hHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8yll/SbxCzdlNQT2vdqXBju8/iGJEqsO4vZbWx+SMaevW/WSevK6+lCKaNU/9HG7ZaPW19irr6Bg4zVlPZW/JmmDTKI+2OOC5Ovq8+8vgnCdJDCLhhJ9k7OI2ekGB1/1nWaiX1A3ZgHrLPyCeKuc+0pS8C0iHA9MByy3bZfbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33C712F4;
	Tue, 30 Apr 2024 06:32:18 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9F63F793;
	Tue, 30 Apr 2024 06:31:50 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Date: Tue, 30 Apr 2024 14:31:38 +0100
Message-Id: <20240430133138.732088-1-ryan.roberts@arm.com>
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
based on the returned old pmd.

But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
pmd_present() calls to return true - even for a swap pmd. Therefore any
lockless pgtable walker could see the migration entry pmd in this state
and start interpretting the fields (e.g. pmd_pfn()) as if it were
present, leading to BadThings (TM). GUP-fast appears to be one such
lockless pgtable walker.

While the obvious fix is for core-mm to avoid such calls for non-present
pmds (pmdp_invalidate() will also issue TLBI which is not necessary for
this case either), all other arches that implement pmd_mkinvalid() do it
in such a way that it is robust to being called with a non-present pmd.
So it is simpler and safer to make arm64 robust too. This approach means
we can even add tests to debug_vm_pgtable.c to validate the required
behaviour.

This is a theoretical bug found during code review. I don't have any
test case to trigger it in practice.

Cc: stable@vger.kernel.org
Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi all,

v1 of this fix [1] took the approach of fixing core-mm to never call
pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that only arm64
suffers this problem; all other arches are robust. So his suggestion was to
instead make arm64 robust in the same way and add tests to validate it. Despite
my stated reservations in the context of the v1 discussion, having thought on it
for a bit, I now agree with Zi Yan. Hence this post.

Andrew has v1 in mm-unstable at the moment, so probably the best thing to do is
remove it from there and have this go in through the arm64 tree? Assuming there
is agreement that this approach is right one.

This applies on top of v6.9-rc5. Passes all the mm selftests on arm64.

[1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/

Thanks,
Ryan


 arch/arm64/include/asm/pgtable.h | 12 +++++--
 mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..7d580271a46d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -511,8 +511,16 @@ static inline int pmd_trans_huge(pmd_t pmd)

 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
-	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
-	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
+	/*
+	 * If not valid then either we are already present-invalid or we are
+	 * not-present (i.e. none or swap entry). We must not convert
+	 * not-present to present-invalid. Unbelievably, the core-mm may call
+	 * pmd_mkinvalid() for a swap entry and all other arches can handle it.
+	 */
+	if (pmd_valid(pmd)) {
+		pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
+		pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
+	}

 	return pmd;
 }
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 65c19025da3d..7e9c387d06b0 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -956,6 +956,65 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HUGETLB_PAGE */

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if !defined(__HAVE_ARCH_PMDP_INVALIDATE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args *args)
+{
+	unsigned long max_swap_offset;
+	swp_entry_t swp_set, swp_clear, swp_convert;
+	pmd_t pmd_set, pmd_clear;
+
+	/*
+	 * See generic_max_swapfile_size(): probe the maximum offset, then
+	 * create swap entry will all possible bits set and a swap entry will
+	 * all bits clear.
+	 */
+	max_swap_offset = swp_offset(pmd_to_swp_entry(swp_entry_to_pmd(swp_entry(0, ~0UL))));
+	swp_set = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
+	swp_clear = swp_entry(0, 0);
+
+	/* Convert to pmd. */
+	pmd_set = swp_entry_to_pmd(swp_set);
+	pmd_clear = swp_entry_to_pmd(swp_clear);
+
+	/*
+	 * Sanity check that the pmds are not-present, not-huge and swap entry
+	 * is recoverable without corruption.
+	 */
+	WARN_ON(pmd_present(pmd_set));
+	WARN_ON(pmd_trans_huge(pmd_set));
+	swp_convert = pmd_to_swp_entry(pmd_set);
+	WARN_ON(swp_type(swp_set) != swp_type(swp_convert));
+	WARN_ON(swp_offset(swp_set) != swp_offset(swp_convert));
+	WARN_ON(pmd_present(pmd_clear));
+	WARN_ON(pmd_trans_huge(pmd_clear));
+	swp_convert = pmd_to_swp_entry(pmd_clear);
+	WARN_ON(swp_type(swp_clear) != swp_type(swp_convert));
+	WARN_ON(swp_offset(swp_clear) != swp_offset(swp_convert));
+
+	/* Now invalidate the pmd. */
+	pmd_set = pmd_mkinvalid(pmd_set);
+	pmd_clear = pmd_mkinvalid(pmd_clear);
+
+	/*
+	 * Since its a swap pmd, invalidation should effectively be a noop and
+	 * the checks we already did should give the same answer. Check the
+	 * invalidation didn't corrupt any fields.
+	 */
+	WARN_ON(pmd_present(pmd_set));
+	WARN_ON(pmd_trans_huge(pmd_set));
+	swp_convert = pmd_to_swp_entry(pmd_set);
+	WARN_ON(swp_type(swp_set) != swp_type(swp_convert));
+	WARN_ON(swp_offset(swp_set) != swp_offset(swp_convert));
+	WARN_ON(pmd_present(pmd_clear));
+	WARN_ON(pmd_trans_huge(pmd_clear));
+	swp_convert = pmd_to_swp_entry(pmd_clear);
+	WARN_ON(swp_type(swp_clear) != swp_type(swp_convert));
+	WARN_ON(swp_offset(swp_clear) != swp_offset(swp_convert));
+}
+#else
+static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args *args) { }
+#endif /* !__HAVE_ARCH_PMDP_INVALIDATE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
 static void __init pmd_thp_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
@@ -982,6 +1041,8 @@ static void __init pmd_thp_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
 	WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))));
 #endif /* __HAVE_ARCH_PMDP_INVALIDATE */
+
+	swp_pmd_mkinvalid_tests(args);
 }

 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
--
2.25.1


