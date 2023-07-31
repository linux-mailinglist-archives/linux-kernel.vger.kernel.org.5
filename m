Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C2769F27
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGaRP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjGaRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0B1FFD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1efa597303so9846789276.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823569; x=1691428369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl37fA/fktQ3urfS+YwWUE+qcRJpc6Gt7zobpPnOyFQ=;
        b=LgDlXg7e+opMqwWMES1LLqVmtZkaKcma+JDWWp+e4CicAgmkjcvE9XhQBziMq2eTa3
         PXWdlSTMfbarj3wXfNgyENr1RvdnAJxrQvtE9y8G7VjJ080QaAAJjzFwuwEaNmQ0DHyN
         a1+nQsa+bGNOM4jP3sCAuVCP01EJzsRkj0hXximLEb2Mfn0aWk9hMuhEtMt7RzQ2IfWq
         dTRWuwzCf9427UAvrXN1bePAw/m+zuKvf0/dCjndjuyKyBwMXDIzsawqi0xrdLmdKZLv
         FQU527Nzu03LfekDUrASNgZQizxrizQv19ZDdXWFCDoALbzcJ8zvPoznDlPtXbvB3a/3
         h6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823569; x=1691428369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl37fA/fktQ3urfS+YwWUE+qcRJpc6Gt7zobpPnOyFQ=;
        b=hfQuGCcc7CM8tHHC/4l+VK84AMV2jUz8q9wJ2iQutqaVw6DgnuLn98ps3/0A0Rb8Ky
         xY/ZOb57aAaFT04F5GTsiyYxtB4BATjceFXpR/AuDdZxuhOe0wv3mkmhGVdAcgiAPAkc
         4FSZ9oM947YgaaTx+93nDbauTlWQpBkXff3bj4iZHlIB8vmtM939shO0UcaFyayV4cwA
         XRcFJ6490VKvI/SGSdpK4FcyhSEty2DHcfQ5dcrIMKmJ/kXFilwK69EFc7otwwUlCZqB
         Vybr/7hT/3flT5ZXmQgvRvIzspwrY/gi9QOPK2gdYZ+40A2WZc0fadhpkxHzPFH+r3ii
         IqBA==
X-Gm-Message-State: ABy/qLb4LcGTfE+IabPI4JrYuRu55j/YmqLgDkRn+oj36/WbouIkgcYu
        DMgx0GfSt81DPhCNezgjpo/BVk+ydl4=
X-Google-Smtp-Source: APBJJlHhlXYyfYo/Ka1CDxxExi2V2guG40bRgvHWyuWMJtZm8ytlVRtn32TdlCPCKVgUKlv/bdcqKCA4SCM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a25:e658:0:b0:d1c:57aa:d267 with SMTP id
 d85-20020a25e658000000b00d1c57aad267mr113311ybh.5.1690823568750; Mon, 31 Jul
 2023 10:12:48 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:31 -0700
In-Reply-To: <20230731171233.1098105-1-surenb@google.com>
Mime-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-6-surenb@google.com>
Subject: [PATCH 5/6] mm: always lock new vma before inserting into vma tree
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

While it's not strictly necessary to lock a newly created vma before
adding it into the vma tree (as long as no further changes are performed
to it), it seems like a good policy to lock it and prevent accidental
changes after it becomes visible to the page faults. Lock the vma before
adding it into the vma tree.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
2.41.0.487.g6d72f3e995-goog

