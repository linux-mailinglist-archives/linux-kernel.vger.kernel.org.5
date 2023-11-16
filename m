Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47237ED8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbjKPB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40EF182
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j75oQuDXytIzx0fg9CVxcXlN+sYlHIe4GGC/3d4Gln4=;
        b=Ie72S6VoYRKq1jIqB5k4Cg7EijAhC5kiEVGJJq6CW4edXDyTiofF9d7IVo7iaAL0p8csTV
        iCHLVk9yV4uFgp47JVd1Xk2fR1OtABnHnIhjQKjNP22ZkJQJc2kT+26RztJulSsk9rcwZ5
        fvZYm5J7Zji6kKHgW1auw3r3X0Gnclg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-vkNfz2qmMNeOn9C8UIiorA-1; Wed, 15 Nov 2023 20:29:13 -0500
X-MC-Unique: vkNfz2qmMNeOn9C8UIiorA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-421ac2bad66so928371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098153; x=1700702953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j75oQuDXytIzx0fg9CVxcXlN+sYlHIe4GGC/3d4Gln4=;
        b=PVzn/HDuUtlLokOzRb3Y8cG9XAgFaD7I8VXmxOtHjdyg2LzV7y8KHIlieYq+uTf/As
         GeioEoN+0GVkdIjzJCPH+/ldPqG+6SWDGDST8qYiFNoviggtdW2NpyfdOnHSTZ0V6AS3
         Jy+E+Top5Ih+s02E6E2KDCp/WTFRqZIY0uznzu4UzH0NhaXSIJLMF4LVITzWDpT63rdI
         ZlcJ9IbnOYQRA81/OSKTsLynvqv4jCmp+dynlf3vqyKrgU7ukfgNw248YhwXt2UPq+k/
         kfFV9K53XhXH2ZuMixVtlnrYQ6CVS8WBklVvmdd+1h7zcYC9F+r/sv90gsRy2mQZJ1jd
         JGEw==
X-Gm-Message-State: AOJu0Yw4tHR5e3n7TBF4zkfoCW+8qqr3yaQALyxaIkoPAwGMYytZRhQO
        KYAwJhIV/1lJPb/W0GGiUDzwdhG1Mh6FAoPp2PJxEp4ZxVfx/emRYgATX8v7wmrHPyfHmSaolVR
        juMhA2N9G5oH27NgeA4YCcr8khYMUmUpK3lfRyHSJ0dnRiuicyaDJbHJ4Ox4U9D1RTElNKslFCo
        4wwjd/2A==
X-Received: by 2002:ac8:7d13:0:b0:41e:4be2:d3eb with SMTP id g19-20020ac87d13000000b0041e4be2d3ebmr10348628qtb.1.1700098153180;
        Wed, 15 Nov 2023 17:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyA/ppnbzE3SBmMhc1vSGcpOQYT5DWDMM4yQxJwgB1XG6+271v4ghGsJVWP9HBrNNkwutL1g==
X-Received: by 2002:ac8:7d13:0:b0:41e:4be2:d3eb with SMTP id g19-20020ac87d13000000b0041e4be2d3ebmr10348586qtb.1.1700098152747;
        Wed, 15 Nov 2023 17:29:12 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:12 -0800 (PST)
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
Subject: [PATCH RFC 01/12] mm/hugetlb: Export hugetlbfs_pagecache_present()
Date:   Wed, 15 Nov 2023 20:28:57 -0500
Message-ID: <20231116012908.392077-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used outside hugetlb.c soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 3 +++
 mm/hugetlb.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 236ec7b63c54..bb07279b8991 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,9 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma,
+				 unsigned long address);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6feb3e0630d1..29705e5c6f40 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6018,8 +6018,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 /*
  * Return whether there is a pagecache page to back given address within VMA.
  */
-static bool hugetlbfs_pagecache_present(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
+bool hugetlbfs_pagecache_present(struct hstate *h,
+				 struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = linear_page_index(vma, address);
-- 
2.41.0

