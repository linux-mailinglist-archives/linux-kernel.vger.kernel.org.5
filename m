Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4346D76C01D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHAWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjHAWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:07:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF61BC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:07:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b107so75693947b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927668; x=1691532468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QxBrE/UCHWlQTdGOylRc3uDNTY7RNXyaur9L23gJy4g=;
        b=LGbOmtH0lMhdDYO3+2ECExEYuxVvpb5dUlLecAiJAGrPI9PAJfTN7UrlhG2D2+sMgI
         A0HPsE7Dh7snipQv/ppKfZkrtywqFIDj94GgYYg1RmHEKQD/JrUFvPL4mXaNgmgR43fS
         rzNN/7cPcSEEUD6MphOEKlUIyUYRI9RNEW1ibPgtDMhMmPz+MaEiw+C/wPcvGj3gdm+s
         wmBOfyKZ9Eq/c9nMUYmgRF+ijS83GqRJwTrxNUo/kn28ipzSQ7VAbYmtkG9fCdYkXi0z
         Hhzh6iMenp89gYpIovNtlhgbKlD0/7Qoap5BixiG9npmNeurITeJhKlGDSUEA6RAa5bC
         2mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927668; x=1691532468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxBrE/UCHWlQTdGOylRc3uDNTY7RNXyaur9L23gJy4g=;
        b=Ap1x9hm3PT8GMK937q1zhkKCDQy2c843axWqM+u6Ui0pCmvUssMZWA0JFT8JbdISkD
         8XN8GHcOMzKCClzm1MUAuT6F3ELlg+8Ub/62ciezlFqjdLDR4KDdBVf1Wh9tMZfyFWdB
         I1JSLiY9lMuNE0SD1mI7PmnX/0am/HAT4MGdMXBe4E6PblSNbUyhMciNclFik4xWzip/
         d5XUkyDXQ8JzRUWzUr2NflFth9obtnI/+T0yf/wNnp8rz0FAcAyPBj16mj256X7EXw2X
         0acOJAfH6GVo05s2do9Beb0tzEgqhGR17U7BF09B1rycGScC5nqmjgN0LL4EacMOc+FS
         Nl+g==
X-Gm-Message-State: ABy/qLbendCnW0g3QhKc4siJGqrfh2S1YxE4xFWLChquogd/9wgzVXSg
        LnBknTbQ1YHUbRVFTyaVv0+gYNsXUmo=
X-Google-Smtp-Source: APBJJlFGce4m/S34cz0bw8Xemucsi7OipxmEL+9L+engD7fhL2P1Th2X8JjKAj9JtV2822hEHcXYgtjOeKk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a81:ae02:0:b0:576:b244:5a4e with SMTP id
 m2-20020a81ae02000000b00576b2445a4emr129366ywh.10.1690927668528; Tue, 01 Aug
 2023 15:07:48 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:31 -0700
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
Mime-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-6-surenb@google.com>
Subject: [PATCH v2 5/6] mm: always lock new vma before inserting into vma tree
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.585.gd2178a4bd4-goog

