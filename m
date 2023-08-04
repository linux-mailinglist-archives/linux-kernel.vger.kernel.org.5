Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979EB77049A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHDP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjHDP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:27:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34365593
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:27:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a6269dbfso15062797b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162854; x=1691767654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfajP5IIbFpg2Y7BQRxvk1sHiLCqjf/rsCkC3jBCtoI=;
        b=jZlRzwl/sZxeKY0Q22GmSPxgFIqyr2sjFjG2dJWAnROoCqd561GTzeSUKMtg/2mqt1
         ggyBLLrU1fznQHJEpV6iArmu4q/1ElFb+5c8i813a5QvYsRPPftZDP04yYsFkEpBfTFv
         biqZHQTtxZS7XMj4IKe/OZIiQ2Hzx3Sc4KiQkuiuVJ83Jibh5wp9rdvvqebLNTk9QL7W
         NA08SkaqEcu5wURtIv2bzCzal6v9uxf83gQzzLLvQVI6Kfk5jLDfOArO5bHqXdZSMQ1C
         ssQWic0dvDYtH0HIwM19ShxQ3BVwkNI58J3XyBg9Vj3lhfWdSX5jmfTA1qFRH0njGemz
         MjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162854; x=1691767654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfajP5IIbFpg2Y7BQRxvk1sHiLCqjf/rsCkC3jBCtoI=;
        b=KX6Zj6hFPOtQiYKA8dapnpdgCtyF6gGauWXwmXFMypE5Dlli7iqr0fA25HhSqHE60J
         RRd3nfh9nhwyIOcTKFIG3VPFDxaOmS8+WGXxWRI7oR0fdfaJYZX2vC3MdNbGSa3uykiJ
         SfQQ49HlJ96Mv8jEkp8/Ist3ew50Xgw9ENGQotlgKAw3zYBeRd+SVaO8C/jDID++ODS/
         d/5VSFesu6rr7TAl0pg8xSPf4nk6CbhOLOQ/LNwRRFxExCd7bE1nrxUdRIBx283PEHdF
         3kG4DnvUWhyk9pAKcEfaquW97qPLiPyjF5CGxquGn/wWyINHepqe1oCgZHRdVcmf/hmN
         X9Yg==
X-Gm-Message-State: AOJu0YyJuDR6vgjCkKr/l0YFBtgXHdxDbhboUvehqQT/RDI0Fa3bxLEU
        VnPgkYdR2j3MukMUmpVuJvFVRuTtoG0=
X-Google-Smtp-Source: AGHT+IHa9ndTaenWukiguHAw5+MvFDtv8DkvZBd31Rp3irRnrIogFfiHRjgfkWXCeFLeklAX7f0FtCBLNkg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a05:690c:448a:b0:583:9d8d:fb0d with SMTP id
 gr10-20020a05690c448a00b005839d8dfb0dmr1503ywb.0.1691162854651; Fri, 04 Aug
 2023 08:27:34 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:21 -0700
In-Reply-To: <20230804152724.3090321-1-surenb@google.com>
Mime-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-4-surenb@google.com>
Subject: [PATCH v4 3/6] mm: replace mmap with vma write lock assertions when
 operating on a vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

