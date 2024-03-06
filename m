Return-Path: <linux-kernel+bounces-93793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC08734FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0490AB2CC84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4F605D9;
	Wed,  6 Mar 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgJq3k63"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C805605C9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721794; cv=none; b=KvmQHV+lmbc3xktcNpfFehnjyL68B9PST/OerPwaJnTnWZMwU6Rt16xz6dw3UxRZahzYd3lBP+2chyRaVU08QAN2q/haUFwFOf+dEAotdMV8Pxd1MyWSoAyWmjOtoU4wZguLXttaZgIyQ/rNV8Ak19rWIVElUeRyyrh9bqT/+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721794; c=relaxed/simple;
	bh=t18R28ny76a7TFkmozYcxNFR6pN9FqPc0sZ3mbG+iGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe6H2zlcSm4Ze9tfAJaRk+Ie9qLVnqhkoMQ3gIIK9s67iW9U865+/ckFCglTJ4g+Bskois7ZJoLx6PKEslSVwa4m9HvkNkug6Kyxv8pLzuWlUj2pJXM1ibBI9KB6liCIZbLT2vGElp1jbr+VjCGqc6Mq58K54OIkKodYeHG/I1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgJq3k63; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZurg04juSYF/uW9HtnhgkfMM1C/gArxmrpoVNEgvCQ=;
	b=HgJq3k63XX/ienOhVi9BGJEeTEX8yucrH3k1moQ08pe2PxtMP0Z6dlsquQw7um0evJvOCo
	ep/Njojqfg4NEO5GcrQj0nMgDxNsEcWHzTjaVKZedAsphqFYuLQBZiyFFpQRkAns7JLZKf
	/WWSrdicQKt3TRknx3c+MlgvDk44BZw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-yz4Oyb-YMiytY0-QZ4ib3A-1; Wed,
 06 Mar 2024 05:43:02 -0500
X-MC-Unique: yz4Oyb-YMiytY0-QZ4ib3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79C4B3C0DF76;
	Wed,  6 Mar 2024 10:43:01 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45DD5111DCFF;
	Wed,  6 Mar 2024 10:42:53 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Salter <msalter@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH RFC 08/13] mm/arm64: Merge pXd_huge() and pXd_leaf() definitions
Date: Wed,  6 Mar 2024 18:41:42 +0800
Message-ID: <20240306104147.193052-9-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Peter Xu <peterx@redhat.com>

Unlike most archs, aarch64 defines pXd_huge() and pXd_leaf() slightly
differently.  Redefine the pXd_huge() with pXd_leaf().

There used to be two traps for old aarch64 definitions over these APIs that
I found when reading the code around, they're:

 (1) 4797ec2dc83a ("arm64: fix pud_huge() for 2-level pagetables")
 (2) 23bc8f69f0ec ("arm64: mm: fix p?d_leaf()")

Define pXd_huge() with the current pXd_leaf() will make sure (2) isn't a
problem (on PROT_NONE checks). To make sure it also works for (1), we move
over the __PAGETABLE_PMD_FOLDED check to pud_leaf(), allowing it to
constantly returning "false" for 2-level pgtables, which looks even safer
to cover both now.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 arch/arm64/mm/hugetlbpage.c      | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..14d24c357c7a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -704,7 +704,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!pud_table(pud))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
+#else
+#define pud_leaf(pud)		false
+#endif
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 #define pud_user(pud)		pte_user(pud_pte(pud))
 #define pud_user_exec(pud)	pte_user_exec(pud_pte(pud))
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0e10bb0a95..1234bbaef5bf 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -81,16 +81,12 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
 
 int pud_huge(pud_t pud)
 {
-#ifndef __PAGETABLE_PMD_FOLDED
-	return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
-#else
-	return 0;
-#endif
+	return pud_leaf(pud);
 }
 
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-- 
2.44.0


