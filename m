Return-Path: <linux-kernel+bounces-84706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB986AA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C181C285D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C12E852;
	Wed, 28 Feb 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIRlv15O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B32E657
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110454; cv=none; b=pyfzJS5s3rg0OEQgM4ChO/lnAnArJiw8xA/ewBX+at3KVA/CjDLcN9RVd4kl+Er+X2JZVOCvd2K2VlOUIHVxzQr6ntnPbD1Et//QPEsXJ1xu2vG22oibs5QL2ugpdgnF74ypaSBHQePSzSpgbf4x5zl7J9p57swtnOzaG0hA+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110454; c=relaxed/simple;
	bh=iOmUFDLX39h21ei25jSnRNQ4aBAQqUvIdyn5qjppTQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvNEOEVme785QHSjYqw781VBt8sdxUCQW5A8XEKCMiU7pYI7jzURhbZtTuRGDDYKtAqS6KHGX33y8x2LWeRHLkC8c2vzyuJj0ojV3EyN/y0zCRI0XRuITyvYoi+Od3kMvY68C66JlMWWTmwQycZX/kcWBf1+Rj7ZnqdeG/DiUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIRlv15O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709110451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UyoXi+HwlVtJP+87NSGPs1pMI8Qh3FSYjQ5NAjm12k=;
	b=FIRlv15Own9qgijIGYa5t+0F/qdZtrkM6XNb5QPZNFJox3RqFblPZPZ/MyVBKsca4GJJ7F
	uLq2j43az9WspyWFmTqnkovbEaDoWWKF945ivYs8urYIOtA+ynhEobj9VPwgqJMdOfXcTw
	uaYbEozx23eN6OVMuJp2mPTLIQVXLQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-HCv9n8T2MZCG0tEH5MRMGw-1; Wed, 28 Feb 2024 03:54:07 -0500
X-MC-Unique: HCv9n8T2MZCG0tEH5MRMGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A906C108BFC9;
	Wed, 28 Feb 2024 08:54:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A240200A382;
	Wed, 28 Feb 2024 08:53:58 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Yang Shi <shy828301@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH 1/5] mm/ppc: Define pXd_large() with pXd_leaf()
Date: Wed, 28 Feb 2024 16:53:46 +0800
Message-ID: <20240228085350.520953-2-peterx@redhat.com>
In-Reply-To: <20240228085350.520953-1-peterx@redhat.com>
References: <20240228085350.520953-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

The two definitions are the same.  The only difference is that pXd_large()
is only defined with THP selected, and only on book3s 64bits.

Instead of implementing it twice, make pXd_large() a macro to pXd_leaf().
Define it unconditionally just like pXd_leaf().  This helps to prepare
merging the two APIs.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 16 ++--------------
 arch/powerpc/include/asm/pgtable.h           |  2 +-
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 927d585652bc..d1318e8582ac 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1157,20 +1157,6 @@ pud_hugepage_update(struct mm_struct *mm, unsigned long addr, pud_t *pudp,
 	return pud_val(*pudp);
 }
 
-/*
- * returns true for pmd migration entries, THP, devmap, hugetlb
- * But compile time dependent on THP config
- */
-static inline int pmd_large(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-static inline int pud_large(pud_t pud)
-{
-	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 /*
  * For radix we should always find H_PAGE_HASHPTE zero. Hence
  * the below will work for radix too
@@ -1455,6 +1441,7 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
  */
 #define pmd_is_leaf pmd_is_leaf
 #define pmd_leaf pmd_is_leaf
+#define pmd_large pmd_leaf
 static inline bool pmd_is_leaf(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
@@ -1462,6 +1449,7 @@ static inline bool pmd_is_leaf(pmd_t pmd)
 
 #define pud_is_leaf pud_is_leaf
 #define pud_leaf pud_is_leaf
+#define pud_large pud_leaf
 static inline bool pud_is_leaf(pud_t pud)
 {
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 7a1ba8889aea..5928b3c1458d 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -101,7 +101,7 @@ void poking_init(void);
 extern unsigned long ioremap_bot;
 extern const pgprot_t protection_map[16];
 
-#ifndef CONFIG_TRANSPARENT_HUGEPAGE
+#ifndef pmd_large
 #define pmd_large(pmd)		0
 #endif
 
-- 
2.43.0


