Return-Path: <linux-kernel+bounces-86327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C795886C3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB161F227FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9863535AE;
	Thu, 29 Feb 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWxzOF75"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EB53370
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196204; cv=none; b=NLQo1l129aDQx3ydIE0dACDOMa21aCD0yPTEKU8ZWBl3KUSWXCg+NSXsepZK3UQxnHcPeiHcQuGk1aGn9X3tw2bMIZYHfTtv9FwPWSk9FzBTFT3+cjM2kd+KU8AhIv2MrhJH1ygJeeBOAa8f4E8Ucs344TiDsdaswM6wn4NyNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196204; c=relaxed/simple;
	bh=SujJ/twmkReQj+vxUjlVWk0iurtcUwJy8YcxyG1MwjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6+3eOnwy3H/8aRM466I+8sVH4JeNfsO9Ns8eqZVW2Zw0HNjN3GsFzIM3jkQnnGytX/cbRMlpjIUVGYsqM8LAsMYGYQ8zArLZ7JFMrJJvwmY9TzeBHANvlsfAAlvwiaf0ROsUcV0JYMKxATKVpY431CyjlG+VdASLlilEjjlzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWxzOF75; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJJ0eqDZ1S0vUv+Nro3fA2Y1PjBXchWPHo5qT9tenrk=;
	b=UWxzOF754cvxC8AoFyBGc5/ffjDxENjD/GvMWhP5tTxfI97hv7ho4ugh+0UvgDc/2+ZauS
	Y9+8b+T0t5PDLvQjC0l/XZoTqWAFX4RALa9xK9R7XuQJ0NfoWeozEzdua0HUAJ5tPfIRiA
	N8rL61A0GR5WmzUy7NlRiEytb8VDRn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-nrzUiLqfPF6NDPYG9jg0YA-1; Thu, 29 Feb 2024 03:43:15 -0500
X-MC-Unique: nrzUiLqfPF6NDPYG9jg0YA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7393383BA86;
	Thu, 29 Feb 2024 08:43:14 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7863E28D;
	Thu, 29 Feb 2024 08:43:07 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH v2 1/7] mm/ppc: Define pXd_large() with pXd_leaf()
Date: Thu, 29 Feb 2024 16:42:52 +0800
Message-ID: <20240229084258.599774-2-peterx@redhat.com>
In-Reply-To: <20240229084258.599774-1-peterx@redhat.com>
References: <20240229084258.599774-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Peter Xu <peterx@redhat.com>

The two definitions are the same.  The only difference is that pXd_large()
is only defined with THP selected, and only on book3s 64bits.

Instead of implementing it twice, make pXd_large() a macro to pXd_leaf().
Define it unconditionally just like pXd_leaf().  This helps to prepare
merging the two APIs.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
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


