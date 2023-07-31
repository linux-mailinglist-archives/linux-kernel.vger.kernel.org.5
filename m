Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CE769F24
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjGaRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjGaRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408B1718
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d064a458dd5so3590181276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823564; x=1691428364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k54nr7y8sT8Wz3UIefWJCe/J3ZJoLd0MPdD7SX1yxV4=;
        b=f9Xkv4qDndAI0YdOZ2cqpuzigjJkWQ867WFypP7OSwCe0TjMpUnPnkD5Y6ryh7F15Y
         M9Q14b7Q7rdYUncpsFgbIcnXrps3cXu/n5nLbGedhZ45/p7BeS8PbqD3FkLK8kNSVcWe
         sJK2CotFttBgUzcy2VXRjvFzjM5g8hEPvN+5TMKbT+Soi/X9AdWfs7huzDn319kCX/N6
         GMp6dPMzi2Z4psHXbwS83zAFVmyMj0uFSK8waScyRdzBafY4I+1PCGfjiTaar6EOvw8g
         4FjFEveEJTGYSjlmO9UfUzptyPCWrdDCvasot5Lp1U7AI3L7Llir4ep5LDCt1MtOBHu3
         6mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823564; x=1691428364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k54nr7y8sT8Wz3UIefWJCe/J3ZJoLd0MPdD7SX1yxV4=;
        b=hHuCPqOP+KtJMsscykRNJcNM5/VfBLExn5SHnHjemOJgpecE3H86qALIEbQL+MOsQo
         /owYhm++NAzyL2+iGlnimKPxE5L1XzulegDw1XbpVl4CsQECNLP++6OmRc1Arp2EFqaq
         sGgYlh29m8N+xDOBEcFBt1Ch0BPCEyUFteTRsPlmIE1hE+w/OLgij146JTkvdWy1dXcU
         LNxLg9Sj8MnPqBTiNwtIWpHhQuAEXlMOS2mN6WQlWHLxNeJUxIXZYTmXrVh9HgtruR++
         H1SoQOi3hDbqNZ4cqTTTkpcBF55olXYSZss1MAgjFE1EIterZTrdjhUpJx96vfN5VnQR
         iL4Q==
X-Gm-Message-State: ABy/qLY+lArDusKtnqNksAC/vOtxVoBzKmgpu6P4uouu41jde0AsXmGV
        hCElT0e06Y+Fjm48LnG4jhdYE0A7JUk=
X-Google-Smtp-Source: APBJJlFUd/WIRrMRABoKwcapNJpdOFT19YiYMf0HEPYfoNPTpuOYC63k+ANMx6Qm9ThWVSfUuBUUFqFSUIk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a05:6902:11ca:b0:d09:b19:fe2c with SMTP id
 n10-20020a05690211ca00b00d090b19fe2cmr63888ybu.12.1690823564414; Mon, 31 Jul
 2023 10:12:44 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:29 -0700
In-Reply-To: <20230731171233.1098105-1-surenb@google.com>
Mime-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-4-surenb@google.com>
Subject: [PATCH 3/6] mm: replace mmap with vma write lock assertions when
 operating on a vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.487.g6d72f3e995-goog

