Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86577049F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHDP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHDP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:28:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C73A49D4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:27:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ebc896bd7so2183764276.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162859; x=1691767659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZEu7FQxJMwmMQ2ZbaGaDze4HsujzOay4eQMS+qpos8=;
        b=HmgF4Vu/z2UFpEEa5aNZa6sedWXmoJ/DZmFFNhEk4pWiLAQkZQVorYTQctKH3uDMLD
         mj3Hcmc2cHw9IvvhBack7cSbpm6kW8wjEkPiKsi66CbqYjjpDQLrQ5x1+cVpu8yMv2a9
         XNBPj0bNqztWfJDeTb2l4iWSdIBL8kDpukfn8vzY9BFDRsihRFmI5G/xZTOwo4NUFRLU
         +ynAJ9lUkfrprv3GNKOEl6hufYJxWORcGXt0DMN24lgUdh8KXq9YdjamSzLozV9syQ99
         NFeV7GUgWtYSH9/+ggUPmVVqbv4d2kVlEfEv2775n79aqrLFQ+3AD73ymHXIu0XeY1Mj
         vSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162859; x=1691767659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZEu7FQxJMwmMQ2ZbaGaDze4HsujzOay4eQMS+qpos8=;
        b=lR33Cn9yp5Xrjrhv0qwwdeQ1s10po1rVBAFCtyL/wVNLD7qAtVVzp9hAkANBrgImzN
         kYWc1u/rlSpU9Cdn2F1KOMhszI8dLrk5XmO5Wmd9TNj6LmcUVzS1llRi7jqjE/JSvgsT
         31fFUvULAW152lxJzTOkCChYM0wJaUQyzeJJe+DSvkuutxU24/ubKNS8l3n4VVLma88w
         BOngpfQR+IXGbqw3m30eNBiKRHPDZoJJg8FHFwUIfP7B2i9707RnFaCTP+bEcLYYK3Hk
         B2wGaTUnUFwBuGRHY4oHHW9Qw9cDQtGlqqHJDXoMNujS8vyBQFf+IK3kcT5W/1OtbZ4S
         fazQ==
X-Gm-Message-State: AOJu0YyJylTLX5qCiN4UNIhXj/TLBxPFqzXxCEMOWeVwtMp45mtTLODq
        vvkBw9MWV3kvY2wgmlHJlO7Bqx5x0g0=
X-Google-Smtp-Source: AGHT+IHAOVPLc3SFAGSwKHt32pNTYMZjrIqM5CAxOwvtZsJvngxPNlrnfOqcpU9flEZvax2zIpplAXOvcxs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a05:6902:1614:b0:d0d:c74a:a6c0 with SMTP id
 bw20-20020a056902161400b00d0dc74aa6c0mr10191ybb.2.1691162859317; Fri, 04 Aug
 2023 08:27:39 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:23 -0700
In-Reply-To: <20230804152724.3090321-1-surenb@google.com>
Mime-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-6-surenb@google.com>
Subject: [PATCH v4 5/6] mm: always lock new vma before inserting into vma tree
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
        autolearn=ham autolearn_force=no version=3.4.6
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

