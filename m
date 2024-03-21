Return-Path: <linux-kernel+bounces-110729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B48862F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8502B23330
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11913774D;
	Thu, 21 Mar 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPecyvx2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DB13699F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058896; cv=none; b=oGWRGTevXzh74k3LsPDlTuQS5kTpzCcklIXByHYHPVNVxU/1fHxyYF9RREz2bN4cn5OlNl/1hVHwbBuOGtCI61LjCbRF3N3B37gsmQ5jBV8WmtReWVuZxFrZyuiLBXZ9B4jy5gwJJ4MW9U2cNu6ZgbyEA0mVUfSsh5GUDk2X46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058896; c=relaxed/simple;
	bh=d+CzKNkrB4Sb8dVg0BsB74DxnyM36sf/PIc4dUau+go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+LIB/bu2P9Py8gbtag17vRIxnY+9QLclPYB/c4g0yjFAsEM8jzz7K3EzrFHFL5wM1KQWmdR726jHYyWnmQm4ELLmK/RLlGJA4JUWCtBWY3H7EtcyEEkKiKuU7Pl3arq2CcTC+vZ0okqouOuHPDUn8BKMinvNL4bIXnsNBRKvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPecyvx2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdRUTOTGji9K1EOtUzCYNHXUg1STGKkafiwUdqA6oYA=;
	b=MPecyvx2PxH5WQgAKJl4QE0aW2tCOSRnRvjzPlmRtr9A158IalKQTJrWPGXPuz3Or1Sy2T
	g2nFRHSyE++OVnlMPbNO1h2e7eB05u8IaQpcusQJYhUZlMFyNRlEIUW0wIqOGYYRTV87aS
	Aw31Q/dwmt8Nk/T0Mxz9qe1JpDq2R5o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-O7V0yWH8M_-nvw72YskUDw-1; Thu, 21 Mar 2024 18:08:11 -0400
X-MC-Unique: O7V0yWH8M_-nvw72YskUDw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69152af7760so3924776d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058891; x=1711663691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdRUTOTGji9K1EOtUzCYNHXUg1STGKkafiwUdqA6oYA=;
        b=fzeQYe6clR/z88qYHPh4SRnVhG+y2NwvCoYhf5tq2jKERUb9OSFah2xqbpCaQ4D5uC
         zYCR5bSi4Qs2gEinzgzKre1aDZx5P6/edAfEJFaTJEZL/W9T9vZ4XoWxvjh6AlVIlbW2
         axGGq17sxvstc+rLGA75MdibipW+0fFxYj9uHS7J4O80M3/59bioYfBZ/afx/qnbKsdg
         n+0FMSxL/uFnUZN1BxUfGc60Jypvn3Y3gxgFtjNUCUOoNB7dpOwGcpN1qKowK0zzKvPX
         /OtaNqetll2Kno1VRG5IEPONxRaq7pQcEny+VNcdyR9hIXuOwBNENfRKrtuEKtVWumUc
         9L5w==
X-Forwarded-Encrypted: i=1; AJvYcCV83SZhC/herNRvb7q8zlGavD+AYV4JKa7ThrgChl+H99sbDvUXZQk80z1QmC0Z3Xilsi51zJjmsYtTySay6EbaJmUGO3Tbn+L05YCP
X-Gm-Message-State: AOJu0Yx2iVXioemfc13p9WDcQc2Hjb6TnsBueaO/BqrqfDnxVHsoiMc4
	esDzAbI+gPgslItqhijxYvVlQqr9ysbH1jEjo/BWYa4p6gsAJsHmxxsPz+XNiWEzvAPfurlZewo
	REwINVFCB8nO7YhyjWtxCdLYhGBUYWdqjLttMAe0RqKtQ223r59VCeA+/1anHxA==
X-Received: by 2002:a05:6214:3a8a:b0:690:3c85:c5b with SMTP id nz10-20020a0562143a8a00b006903c850c5bmr195551qvb.3.1711058891330;
        Thu, 21 Mar 2024 15:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG16ns9jJ9MJ80ThL7hh1B1qvLdYLgSNyXX5iyvBQC6076/qVHetDei+F5v2+719IrZ5asQ9g==
X-Received: by 2002:a05:6214:3a8a:b0:690:3c85:c5b with SMTP id nz10-20020a0562143a8a00b006903c850c5bmr195527qvb.3.1711058890838;
        Thu, 21 Mar 2024 15:08:10 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:10 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 03/12] mm: Make HPAGE_PXD_* macros even if !THP
Date: Thu, 21 Mar 2024 18:07:53 -0400
Message-ID: <20240321220802.679544-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321220802.679544-1-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

These macros can be helpful when we plan to merge hugetlb code into generic
code.  Move them out and define them even if !THP.

We actually already defined HPAGE_PMD_NR for other reasons even if !THP.
Reorganize these macros.

Reviewed-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..3bcdfc7e5d57 100644
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
@@ -87,14 +84,19 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
 #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
+#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
 #define HPAGE_PUD_SHIFT PUD_SHIFT
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
@@ -378,13 +380,6 @@ static inline bool thp_migration_supported(void)
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


