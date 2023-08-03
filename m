Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9829776F09F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjHCR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHCR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:27:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2963C16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:27:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d074da73c3eso1372781276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083627; x=1691688427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZEu7FQxJMwmMQ2ZbaGaDze4HsujzOay4eQMS+qpos8=;
        b=iMlvdhm/bxVV7kv0V79kx1hxAyb+1GfcPnJNgAo6LGdR0bN5ykKWLzgwRkr0IsKULR
         2o34cI0Yf3y9b3S2Dr1CwRyv6f01fPNaOoXOCMRAQbhpK1DPGFgCjTrhlWjoMsqAvyL0
         8VUIztQRc1OQyCbz5DagmCU/mu3dLq6uVQlfq3eZNISYdHHkvNHZJzuMW6YuKo90+kyC
         hjZ+CUef9CzPm33relwkpyOY3ShX8wwK6g3JLpiI+W0wl5DrWoPM2vnAEuwmowfvDdjR
         SwLvk9fJF/d9WaXsmtAEQnK/vJCJQgoZOjJbm+glRWLSwwbs7FTj9oR+NIkDHwsI3k9/
         MBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083627; x=1691688427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZEu7FQxJMwmMQ2ZbaGaDze4HsujzOay4eQMS+qpos8=;
        b=gym2yatDLXopktTQ3D5GGwbjbq79JRjNjcfMRG7gmtWdu33WQ8Yy4hRzdd2nJfBpf5
         QNCeZdrCERPUsQdaxwC/smGWUOK4gxz+mj0fBHCQ1J3v/v7gVTS8cKYtTQ5+cAOJNDFd
         uSJ4oOhNM0ir/3mh9dkvFpFLkqNR+NB7vI4Y0F66871fba5Z2eud9Z4aqBh6z14/RChm
         wLxdXuVFHMcPZoMECuTwbylzqqzEUe2HWvCtgmpCgY1y0HCs5YGDOIa1qmUbOThowWNJ
         VYhxwotmtxVuci8FBwibJOAKK8wBzL8vsa22o5W1vi1e26uztwkeOwckvkm5wjMpRr4Q
         CA5A==
X-Gm-Message-State: ABy/qLZYA61oBxdtXDzxL71dF4StPrjQ8jDiwTV8OtFpxZfoWLdXLXxt
        eSDh2W2cWvZXAebZePqETXruNLqmKYc=
X-Google-Smtp-Source: APBJJlEm+TAFgwKeycGXNkE9sZYz1YS9giHD/D1paY/qC/rrcXYAkNTs0f2pZWBHAJYKXSdQl1MdNfKRQzw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a25:19c2:0:b0:d0d:1563:58f2 with SMTP id
 185-20020a2519c2000000b00d0d156358f2mr129793ybz.2.1691083627024; Thu, 03 Aug
 2023 10:27:07 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:50 -0700
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
Mime-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-6-surenb@google.com>
Subject: [PATCH v3 5/6] mm: always lock new vma before inserting into vma tree
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it's not strictly necessary to lock a newly created vma before
adding it into the vma tree (as long as no further changes are performed
to it), it seems like a good policy to lock it and prevent accidental
changes after it becomes visible to the page faults. Lock the vma before
adding it into the vma tree.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3937479d0e07..850a39dee075 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -412,6 +412,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	if (vma_iter_prealloc(&vmi))
 		return -ENOMEM;
 
+	vma_start_write(vma);
+
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
@@ -477,7 +479,8 @@ static inline void vma_prepare(struct vma_prepare *vp)
 	vma_start_write(vp->vma);
 	if (vp->adj_next)
 		vma_start_write(vp->adj_next);
-	/* vp->insert is always a newly created VMA, no need for locking */
+	if (vp->insert)
+		vma_start_write(vp->insert);
 	if (vp->remove)
 		vma_start_write(vp->remove);
 	if (vp->remove2)
@@ -3098,6 +3101,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma->vm_pgoff = addr >> PAGE_SHIFT;
 	vm_flags_init(vma, flags);
 	vma->vm_page_prot = vm_get_page_prot(flags);
+	vma_start_write(vma);
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
@@ -3345,7 +3349,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_start_write(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks = false;
-- 
2.41.0.585.gd2178a4bd4-goog

