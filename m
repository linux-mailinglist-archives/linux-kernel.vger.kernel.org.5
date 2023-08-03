Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272CC76F096
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjHCR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjHCR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:27:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEEB30C2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:27:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d27ac992539so1282230276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083622; x=1691688422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfajP5IIbFpg2Y7BQRxvk1sHiLCqjf/rsCkC3jBCtoI=;
        b=HHki6L/bmVrbbgbTtB9WdMtyro9jT73+cCAxKEfbQcmR3qH9v6ec6CcbLdBDBiHtbD
         DgkXEJ1VQUd+cMDxmtIXTtXdoPNmy73uD9LZlwIoe2mdEcYq/BSd/gAhOgP0fAm/mz7/
         8v51YuDLWoZ2H6bS1nhWVnhqzAMn395dK93Vn63kHAx/qo6JPUNuF05lCgUdd7cwcCXg
         Le/Ctgs2wSzsf6ywyFYUPRCg/ETixmQpFAd/6SNe06GNe12jbStG/hoYgMj4KbT0T2lp
         njpni/PXfMsrjLG8JE43HZ3PBUxm8AfwfKRLkTOdqi08qFkN+w6s2O9SAGVXJ8RtvGZy
         fOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083622; x=1691688422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfajP5IIbFpg2Y7BQRxvk1sHiLCqjf/rsCkC3jBCtoI=;
        b=drdrzpNXl/Gyfd96B49WomhsHbJZMSTKJ5+HEs0hgJ9SIZnoO0HPUTluJUh54wSCWW
         dUPber416XL+NnP/sEr5mSnrdurBdOVXwQtFeMvP94JQv/pywHMhG7MUv+RFI68jhyr9
         S9mqTu7fLcuSD792kUgAIPTzWtEPXCeflFfqH/kRVs40Y4e3rIdFyoyq3+YdBLBbekN3
         40Q4nHD2HrfS+Ijvm4YUt1yg1rHLlF5NT9PYmOk1Y8lL5vMMqYGJSUP33QOAhPWE2dvz
         Kb/1+IPwGLbKoURKhxg5ZKXxaj0GIY6xGnn3MFJoG9dd7yx8OTElI85HHdk8Bkgkdlb5
         PW0w==
X-Gm-Message-State: ABy/qLbCqCh5wMH93EM/pw3hb5gfzpTJKmfIOxgVnFrW7MPh2B8/bua5
        Do5LzFYE+nYnCUkM+RJ9YAW6fOk6Hbs=
X-Google-Smtp-Source: APBJJlERuzjun8O5+88x8UQezAzWCkSvC+SxUAPYIz16CZMGZKaq/Tmi2dNZnAJHx5Bu+iggd6tbtkFAIsk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a05:6902:569:b0:d11:3c58:2068 with SMTP id
 a9-20020a056902056900b00d113c582068mr132529ybt.2.1691083622391; Thu, 03 Aug
 2023 10:27:02 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:48 -0700
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
Mime-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-4-surenb@google.com>
Subject: [PATCH v3 3/6] mm: replace mmap with vma write lock assertions when
 operating on a vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vma write lock assertion always includes mmap write lock assertion and
additional vma lock checks when per-VMA locks are enabled. Replace
weaker mmap_assert_write_locked() assertions with stronger
vma_assert_write_locked() ones when we are operating on a vma which
is expected to be locked.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/hugetlb.c    | 2 +-
 mm/khugepaged.c | 5 +++--
 mm/memory.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..1d871a1167d8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5028,7 +5028,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					src_vma->vm_start,
 					src_vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
-		mmap_assert_write_locked(src);
+		vma_assert_write_locked(src_vma);
 		raw_write_seqcount_begin(&src->write_protect_seq);
 	} else {
 		/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78c8d5d8b628..1e43a56fba31 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1495,7 +1495,7 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	};
 
 	VM_BUG_ON(!PageTransHuge(hpage));
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_assert_write_locked(vma);
 
 	if (do_set_pmd(&vmf, hpage))
 		return SCAN_FAIL;
@@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 	pmd_t pmd;
 	struct mmu_notifier_range range;
 
-	mmap_assert_write_locked(mm);
+	vma_assert_write_locked(vma);
 	if (vma->vm_file)
 		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
 	/*
@@ -1570,6 +1570,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	int count = 0, result = SCAN_FAIL;
 	int i;
 
+	/* Ensure vma can't change, it will be locked below after checks */
 	mmap_assert_write_locked(mm);
 
 	/* Fast check before locking page if already PMD-mapped */
diff --git a/mm/memory.c b/mm/memory.c
index 603b2f419948..652d99b9858a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1312,7 +1312,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		 * Use the raw variant of the seqcount_t write API to avoid
 		 * lockdep complaining about preemptibility.
 		 */
-		mmap_assert_write_locked(src_mm);
+		vma_assert_write_locked(src_vma);
 		raw_write_seqcount_begin(&src_mm->write_protect_seq);
 	}
 
-- 
2.41.0.585.gd2178a4bd4-goog

