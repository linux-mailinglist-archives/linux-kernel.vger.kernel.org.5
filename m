Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750EC7A54E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIRVQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjIRVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:16:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1881112
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:16:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814a1f7378so11359997276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695071772; x=1695676572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yc4butG+BWb+Qe3ZuJ7BVqA63qdbImB+9mEwJw3lgvg=;
        b=vo0Go2MtIrzVrANqaF138nFKOU1lWAv2RRA6TURPWrM/i6qtIu8L3xHDhMo1QpaJMi
         ux3sLKWXrCfck9XI6i3yAI2s1l2GbrIZOqIhu5bmKseIAVmF7aiqTYZwirsNXErjhdNv
         RmxrOl+sus6I8RXihKcLdVH2yoMeQWgKQPmvFgGd1sfOjm7LBNwCgz9coFTKJDlTRgWu
         cEQfeSzx/zz7H29b4ovfeAKjhQyGQcwKcARbJ9Y9zisjztwM/R+guiREyS5OAbZzl04I
         yNxaJRwkT0a030zz8dSyFVoGLqZe0tQ+oUOAZSPaY8oMFJKK5ZqwRuTLtY2pMH1wzxC7
         uNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695071772; x=1695676572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yc4butG+BWb+Qe3ZuJ7BVqA63qdbImB+9mEwJw3lgvg=;
        b=sXlsUIpZAPWlnzC/AQeOG3FRiVSP+FmZnjjklBNE55DnijDBKxXEtb/Z/jRgCVrKPy
         gAk3zl01cMHEYR3UZTXmfJ4rwtnl4gudTos+qdGwTiBWnscEquynNnWOOC/TVbzb10CU
         5qB9ePI9/L+xUKEsdV3CmnbwRv1Be/oD//uxV3ZWDXIEM05y1jupJuROl15vT+1t5cGT
         LZrLc9zGBuEPVLfZSsyxXvrBBlvk5cykVolRWTXiEHxFv/WuWJfFDYayGeKxIx0Ah4DC
         RiC9WKZ+ZLfP8wELl2bIVmbqNde+MQ/JbI/EDFSYSB7K1U8gWZ/+mBCrcJuAMN1rhxgr
         GK4Q==
X-Gm-Message-State: AOJu0Ywlg5VpsiCxwdYQV7IBEVFZa7J4npNUo0cFEOLlF2829GVOvFic
        7SxxMblUFfkgnHvp435ZerbtkHS22gk=
X-Google-Smtp-Source: AGHT+IGgw8JZ/Scb/L4UPVe1y9d1eUoneO5O5nz4m++Nj62RgVWM1SbDUZOxeYP+4xMVpyAcx3I+S+qNxU4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9830:817:b32f:99da])
 (user=surenb job=sendgmr) by 2002:a25:d3cb:0:b0:d80:8aa6:5ac0 with SMTP id
 e194-20020a25d3cb000000b00d808aa65ac0mr16652ybf.4.1695071771967; Mon, 18 Sep
 2023 14:16:11 -0700 (PDT)
Date:   Mon, 18 Sep 2023 14:16:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918211608.3580629-1-surenb@google.com>
Subject: [PATCH 1/1] mm: lock VMAs skipped by a failed queue_pages_range()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com, shy828301@gmail.com,
        mhocko@suse.com, vbabka@suse.cz, surenb@google.com,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
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

When queue_pages_range() encounters an unmovable page, it terminates
its page walk. This walk, among other things, locks the VMAs in the range.
This termination might result in some VMAs being left unlock after
queue_pages_range() completes. Since do_mbind() continues to operate on
these VMAs despite the failure from queue_pages_range(), it will encounter
an unlocked VMA.
This mbind() behavior has been modified several times before and might
need some changes to either finish the page walk even in the presence
of unmovable pages or to error out immediately after the failure to
queue_pages_range(). However that requires more discussions, so to
fix the immediate issue, explicitly lock the VMAs in the range if
queue_pages_range() failed. The added condition does not save much
but is added for documentation purposes to understand when this extra
locking is needed.

Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")
Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000f392a60604a65085@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mempolicy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..cbc584e9b6ca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1342,6 +1342,9 @@ static long do_mbind(unsigned long start, unsigned long len,
 	vma_iter_init(&vmi, mm, start);
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
+		/* If queue_pages_range failed then not all VMAs might be locked */
+		if (ret)
+			vma_start_write(vma);
 		err = mbind_range(&vmi, vma, &prev, start, end, new);
 		if (err)
 			break;
-- 
2.42.0.459.ge4e396fd5e-goog

