Return-Path: <linux-kernel+bounces-4836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E18182B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263221F25C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F514AA4;
	Tue, 19 Dec 2023 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5RPX8rj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C14A87
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702972593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdhTUt+FrTuSBSRKmaD9aOddOtS2xHAJn3bdMelwyoI=;
	b=S5RPX8rjfwaWxduNP4ARumN1dF0Mc6P09VrcIRPJjancgkznbPEiRTsoawzYM77AqpIJtt
	iWo9fhCmrEbF/tqpDWhxN8SphxsgnjPZSE4vvLGjbP6kwpp3tuyAiQcRPyrzq8fAU3onrC
	8MLmu0WS3xik1xWOaimbrrtWtcTaV0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-zvB374S3NdqDENm7NImiSg-1; Tue, 19 Dec 2023 02:56:29 -0500
X-MC-Unique: zvB374S3NdqDENm7NImiSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298F1185A782;
	Tue, 19 Dec 2023 07:56:28 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B65A2026D6F;
	Tue, 19 Dec 2023 07:56:17 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Rik van Riel <riel@surriel.com>,
	linux-riscv@lists.infradead.org,
	Yang Shi <shy828301@gmail.com>,
	James Houghton <jthoughton@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 03/13] mm: Provide generic pmd_thp_or_huge()
Date: Tue, 19 Dec 2023 15:55:28 +0800
Message-ID: <20231219075538.414708-4-peterx@redhat.com>
In-Reply-To: <20231219075538.414708-1-peterx@redhat.com>
References: <20231219075538.414708-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

ARM defines pmd_thp_or_huge(), detecting either a THP or a huge PMD.  It
can be a helpful helper if we want to merge more THP and hugetlb code
paths.  Make it a generic default implementation, only exist when
CONFIG_MMU.  Arch can overwrite it by defining its own version.

For example, ARM's pgtable-2level.h defines it to always return false.

Keep the macro declared with all config, it should be optimized to a false
anyway if !THP && !HUGETLB.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 4 ++++
 mm/gup.c                | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..6f2fa1977b8a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1355,6 +1355,10 @@ static inline int pmd_write(pmd_t pmd)
 #endif /* pmd_write */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifndef pmd_thp_or_huge
+#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+#endif
+
 #ifndef pud_write
 static inline int pud_write(pud_t pud)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 0a5f0e91bfec..efc9847e58fb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3004,8 +3004,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_thp_or_huge(pmd) || pmd_devmap(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
-- 
2.41.0


