Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131787B4884
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjJAQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjJAQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:00:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF87E1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:00:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so15624050f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696176015; x=1696780815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k884TE7KNx/WnBRBjm/8oTv2AQyhCRgzdEjEHuml8kg=;
        b=eC9v2aDJav36tUfYswA4Ze3QQ6KNhS2sPi3X+0XZvGEt6RiOGnHEFN7ks5WJKS5GVK
         8RD9V2mf2jzuPrCFcosWNXr2/J3xsXoKC62g/7LHBWYPoFF0CN4/rGKNwD6f5bbSLWOm
         Hd8EKWgLBo124NZERmoyUeVzdsWMsqZI2N6ggQPptylgZ0mqqn1eey6aH+kqcBpFDQ77
         0DttRbbNSUNaflltsL/j3ukJEaQ085f4JCF3tgTMvA2XQI02BOVBy2iUF9dzKLlNhObp
         3FjPgeAqz3UoRHKdyKVpK0X30L8lpFxA8BEiH5Ms5b9EB3apVrK20scqaWg/1iBRg2V9
         /W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696176015; x=1696780815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k884TE7KNx/WnBRBjm/8oTv2AQyhCRgzdEjEHuml8kg=;
        b=Cc37zSFpMSfPlBb8aNtT9fH391un6/U6bggvzUvkKNFZIfEN6DDMg9QsWu623nDyM4
         qClonr+xPwd6Y8H9PRdSkJrY5efhAZy8Ftz/MxQ9Fdf24VOm4sObHbFDtjbVh9Sn5f1+
         3VQbFSPLydJTNU/0Ua1M19vHqn64ZIbw57M7fhaAP2DOCzf9mKqnRckQUzPh4tmuZlF8
         B9jGLkmX11YnB/FdqXrsCvclaKnxIkJf4oEdHRxYw5qJELpLDD4DD/9HhX8lJGj827Sy
         nhtTdWYR9uIQn37uRgvIn2p3c3iYgU6UCc+DBmAcJ/WUj05kkS4ICZzNvEUuTk/Z2rx/
         xB1Q==
X-Gm-Message-State: AOJu0YwHxlnjgIqzoR5MMZwViK2mewEQ+7uT+cUrgOpNNgIVA7v+aCA4
        Q8DGBIZ/ME0SgnVSyME9kxI=
X-Google-Smtp-Source: AGHT+IFz6TUSlKf+sA6AqE1HJa6bCLgZ7TQdxdFdV0t++vM23Tcc6lgRka6dafHVYFayTJul4FVAXw==
X-Received: by 2002:a5d:6e53:0:b0:321:5971:23a5 with SMTP id j19-20020a5d6e53000000b00321597123a5mr7951114wrz.20.1696176014911;
        Sun, 01 Oct 2023 09:00:14 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm5487695wmb.27.2023.10.01.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:00:14 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 4/4] mm/gup: adapt get_user_page_vma_remote() to never return NULL
Date:   Sun,  1 Oct 2023 17:00:05 +0100
Message-ID: <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696174961.git.lstoakes@gmail.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_pages_remote() will never return 0 except in the case of
FOLL_NOWAIT being specified, which we explicitly disallow.

This simplifies error handling for the caller and avoids the awkwardness of
dealing with both errors and failing to pin. Failing to pin here is an
error.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c |  4 ++--
 include/linux/mm.h      | 16 +++++++++++++---
 kernel/events/uprobes.c |  4 ++--
 mm/memory.c             |  3 +--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 4edecaac8f91..8878b392df58 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -411,8 +411,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
 
-		if (IS_ERR_OR_NULL(page)) {
-			err = page == NULL ? -EIO : PTR_ERR(page);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
 			break;
 		}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b89f7bd420d..da9631683d38 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2425,6 +2425,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned int gup_flags, struct page **pages,
 			   int *locked);
 
+/* Either retrieve a single VMA and page, or an error. */
 static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
 						    unsigned long addr,
 						    int gup_flags,
@@ -2432,12 +2433,21 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
 {
 	struct page *page;
 	struct vm_area_struct *vma;
-	int got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
+	int got;
+
+	if (unlikely(gup_flags & FOLL_NOWAIT))
+		return ERR_PTR(-EINVAL);
+
+	got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
 
 	if (got < 0)
 		return ERR_PTR(got);
-	if (got == 0)
-		return NULL;
+
+	/*
+	 * get_user_pages_remote() is guaranteed to not return 0 for
+	 * non-FOLL_NOWAIT contexts, so this should never happen.
+	 */
+	VM_WARN_ON(got == 0);
 
 	vma = vma_lookup(mm, addr);
 	if (WARN_ON_ONCE(!vma)) {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3048589e2e85..435aac1d8c27 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,8 +474,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
-	if (IS_ERR_OR_NULL(old_page))
-		return old_page ? PTR_ERR(old_page) : 0;
+	if (IS_ERR(old_page))
+		return PTR_ERR(old_page);
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
diff --git a/mm/memory.c b/mm/memory.c
index e2743aa95b56..f2eef3d1cf58 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5905,7 +5905,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
 
-		if (IS_ERR_OR_NULL(page)) {
+		if (IS_ERR(page)) {
 			/* We might need to expand the stack to access it */
 			vma = vma_lookup(mm, addr);
 			if (!vma) {
@@ -5919,7 +5919,6 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				continue;
 			}
 
-
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
-- 
2.42.0

