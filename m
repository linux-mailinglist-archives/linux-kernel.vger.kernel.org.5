Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589A7ED8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjKPB31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344386AbjKPB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F17198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0M65PApL8h6gQcrG6fLgH2zAjMUA+gwn5/0n3MZLTE=;
        b=GHO1LSnrqCHQL4ba81d/XBbF3oovWtWEpxVi2TuEFvGBrqihW9XTKVjbaPZFbp14xHUxy0
        Dk8vPhvUzTwKpfcJy9VPfCzpZ4/5HzAuVUKzh89kkphD4hhVgNrj1Lb7JVw+Da5qgo+/Cy
        lrguGfv0epguiXO0OxiRIRrcW+H85AA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-eANnE0BLNCCdCo4qnJWQMQ-1; Wed, 15 Nov 2023 20:29:18 -0500
X-MC-Unique: eANnE0BLNCCdCo4qnJWQMQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-421be23b19aso883451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098158; x=1700702958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0M65PApL8h6gQcrG6fLgH2zAjMUA+gwn5/0n3MZLTE=;
        b=P5TTnvB7rfwOaEe5bTi5o061054oohYajKyzUPHRYafLfGzAK0djKiM+lPj2dhZQjy
         s6auI3nDLA042DcaD3exMLMjiKg65YI04BLVggQ0BieXRFwmAz4y8f6W+A4z/jKh2G9s
         D9GB9QW6hk1GkSnrRMy3cYAe2XQqvHY8AYX+tn7jT56sjjw+Px1McMMSUlW4BcCvDXPZ
         i4TH+4T4TaqTgltJW11rXUkcBwAUDm2rsAhCyUj0k+MP5YWn3o+61CDnt6klbVQSrCGj
         vOYfsoGLyx6nlfb5xHx4Fxs7ByF5C64BBp7mI/Gu86fOebrDGB0f/p6kqZCLENlD27nk
         W4Mw==
X-Gm-Message-State: AOJu0Yxp4VT51JC2W+SbGBgBHGveDZ/5wZ6MkF72b5WVg7juU+IhmZxM
        caBfE0EHYZK2W7Jh+xamQochu+oVWR4NrM2OD7Wh7udzwR5WdwQ8snjPZm59k6AfVgKVcYDmLHr
        gmEwistp+cj/syDC2arvQN588weosizYOZI4w8sJFxU4Oig5cTCv7GBC2qm0aX7edRnh0WcpduN
        pQbfDZEQ==
X-Received: by 2002:ac8:4716:0:b0:421:abb7:1eac with SMTP id f22-20020ac84716000000b00421abb71eacmr7303886qtp.0.1700098157927;
        Wed, 15 Nov 2023 17:29:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+ZhOFntlbofY44x0fylWHFWXMzqejypTQt/uP49OXaw97pBVx5pY9jGkMxKB+HQGuvx0qxQ==
X-Received: by 2002:ac8:4716:0:b0:421:abb7:1eac with SMTP id f22-20020ac84716000000b00421abb71eacmr7303852qtp.0.1700098157463;
        Wed, 15 Nov 2023 17:29:17 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 04/12] mm: Introduce vma_pgtable_walk_{begin|end}()
Date:   Wed, 15 Nov 2023 20:29:00 -0500
Message-ID: <20231116012908.392077-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce per-vma begin()/end() helpers for pgtable walks.  This is a
preparation work to merge hugetlb pgtable walkers with generic mm.

The helpers need to be called before and after a pgtable walk, will start
to be needed if the pgtable walker code supports hugetlb pages.  It's a
hook point for any type of VMA, but for now only hugetlb uses it to
stablize the pgtable pages from getting away (due to possible pmd
unsharing).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64cd1ee4aacc..349232dd20fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4154,4 +4154,7 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+void vma_pgtable_walk_begin(struct vm_area_struct *vma);
+void vma_pgtable_walk_end(struct vm_area_struct *vma);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index e27e2e5beb3f..3a6434b40d87 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6180,3 +6180,15 @@ void ptlock_free(struct ptdesc *ptdesc)
 	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
+
+void vma_pgtable_walk_begin(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_lock_read(vma);
+}
+
+void vma_pgtable_walk_end(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_vma_unlock_read(vma);
+}
-- 
2.41.0

