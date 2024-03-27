Return-Path: <linux-kernel+bounces-121498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF088E935
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC84B29AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD899132C0C;
	Wed, 27 Mar 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCCSZeD0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23012FF90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553027; cv=none; b=RdR5xaknmd4WP+6n3g00FN8Chn85HFtlAaCku2uwWqR2Fute28AxS5QHPJqkLQPtowGF4NVy9o1A1RyxcwWkb4JMtQQL+UgewgZiXMjNpbVr4u9c5iejFxEfUygGrEolnmsdE84a7wIxSIRyWQSNgAOa8l23kNzJvBcTt44rGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553027; c=relaxed/simple;
	bh=CpBjpEQavMo8dhklNAEvpSGimif1ytF9XYA4webQEgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi3OMusBrgerk+lCjnB8f1XaT4GQCbd/XTuhDXHpFdw/jwTljRzqMLkDYp8/DWMguT4xu66KBUJc7kE1YT08W3TyubRUGE0ny7Zm/O7ShOcIYlJ+BhRB250jaqdn8sKVA5YP8NHNYDUkM/37LyExQv3gGVHSLSbmOtpW83zl0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCCSZeD0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/g69WjpU0rXeMHNQq0wHJ20ikWbVhFRACidICzEeTCE=;
	b=OCCSZeD0ibm7Kx/pNtC0cJMUv/Vuv2Wgmyhqh7vzJdx0GTZrG4fG7ilaUKIKbBIxCjmM83
	NpkIJwCWDro6lh0QscEhYmks4rLmxtm66QLZzLeerRJFN96v2qJGKRn02gH0IijWRfeA9k
	n1olUAedXswAP44GRPsufoL/V9E4G4g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-8gDTITfvNByAZilpWjEGiA-1; Wed, 27 Mar 2024 11:23:43 -0400
X-MC-Unique: 8gDTITfvNByAZilpWjEGiA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69672754479so14006196d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553022; x=1712157822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g69WjpU0rXeMHNQq0wHJ20ikWbVhFRACidICzEeTCE=;
        b=R9Tr3KpNAwAZQGK4uUepI/QLEQJuCe/FVir+GCDWAQVlCfTrsWWIDgSrcjp22At0O7
         8MvWogxEPzJPllwf3PPOyJEgwwPCX+VBWevZdxrAHJ5ldenlGe7kSn67q8rmiGoaUUzy
         fnEM12+Q8jIkMYwUBEi5I49w6owXzUQnhZj+xPlgf4owMJbXbKtfTNOBmUf59m20AImU
         qGBcxA7QubkXl1TzwT4LQ683AiekD+4Xizga39Ohaztm/fWH8Yuv+xN0BQ4uTB9vs8yl
         2pXj/gXEbDH9B1Zqw3SGg7E8pq0f9JGvDQLcrHvEWKgFEF83VbHk1Tt3aCLD4UCLs5yB
         5R/A==
X-Forwarded-Encrypted: i=1; AJvYcCV+FUPd90ldVbh59QzVoMc0f1exG1Cyn0BH9C+83HESCuyK+JGk383XREgUvJEIRbOy5s0i0fVQ9+/jRUgV8iFZTqGFQN77l2mgj3aB
X-Gm-Message-State: AOJu0YxekqrzV+udU4P063LVLee6KHAhAbU9Acu7k9GnH/EJ2mNPvJUv
	LrlbwntCP1w5gQ1y8vvFHlGlYSp45J57HUiddFeigSGtpHcUN4n6cXx7X3/ORGQj+msD0PWYyoc
	TA/DvjMAOSk1T8RkRciaVaX1WQzAVfDMcUj6llo8M/VHlnsNPp3EBJgD2hRC0Yg==
X-Received: by 2002:a05:6214:3187:b0:691:456f:415a with SMTP id lb7-20020a056214318700b00691456f415amr14772473qvb.4.1711553022253;
        Wed, 27 Mar 2024 08:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwFABTpt0oYC5XP41rgqaavJwjTuxekGLogedD16Vy17R/DxfwS2XqF10qrZ+lSq8ZmFvRzQ==
X-Received: by 2002:a05:6214:3187:b0:691:456f:415a with SMTP id lb7-20020a056214318700b00691456f415amr14772425qvb.4.1711553021719;
        Wed, 27 Mar 2024 08:23:41 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:40 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 03/13] mm: Make HPAGE_PXD_* macros even if !THP
Date: Wed, 27 Mar 2024 11:23:22 -0400
Message-ID: <20240327152332.950956-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

These macros can be helpful when we plan to merge hugetlb code into generic
code.  Move them out and define them as long as PGTABLE_HAS_HUGE_LEAVES is
selected, because there are systems that only define HUGETLB_PAGE not THP.

One note here is HPAGE_PMD_SHIFT must be defined even if PMD_SHIFT is not
defined (e.g. !CONFIG_MMU case); it (or in other forms, like HPAGE_PMD_NR)
is already used in lots of common codes without ifdef guards.  Use the old
trick to let complations work.

Here we only need to differenciate HPAGE_PXD_SHIFT definitions. All the
rest macros will be defined based on it.  When at it, move HPAGE_PMD_NR /
HPAGE_PMD_ORDER over together.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7576025db55d..d3bb25c39482 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -64,9 +64,6 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				  enum transparent_hugepage_flag flag);
 extern struct kobj_attribute shmem_enabled_attr;
 
-#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
-#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
-
 /*
  * Mask of all large folio orders supported for anonymous THP; all orders up to
  * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
@@ -87,14 +84,25 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
-#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
+#define HPAGE_PUD_SHIFT PUD_SHIFT
+#else
+#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
+#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
+#endif
+
+#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
+#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
 
-#define HPAGE_PUD_SHIFT PUD_SHIFT
-#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
+#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
@@ -377,13 +385,6 @@ static inline bool thp_migration_supported(void)
 }
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
-#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
-
-#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
-- 
2.44.0


