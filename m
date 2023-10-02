Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5B7B5DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjJBXPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjJBXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C110BCC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:15:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40652e5718cso3311145e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288505; x=1696893305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSkssDhEiWfimKWDZskn49BRf30NYKZNHbeb9+/CySI=;
        b=I6SJWj6mhap6/PZcry5n1JUgyCiOpf+0xKdAMTHsCd+raNERvnu4oIP3OMJy8bfqtU
         0nUSXRKrVZ3NxYmfN4lKpDJ7jPXmWaO2sdPGAx3tLdZvCQnjn/eFv1l/wgqbb0rN6gtg
         KmlpLRDti5PLjUaQgUnTisNB1y02i/H4OhPapjX/L4rtBGDc4QP0+b4GEr4r2mXcwes/
         wYPUB/RXN9irphtXN9yjk4mXq/EfAYFQq2Mdy+MgU3wxmlQRXJHQRKCC9Pjotp35Qn3r
         qMDGzm15bhYh6mDzAmDYXuhOjNaD7yGZakajvmyD/AzWeKGY/s3D6iqEqp1C4vLchhHK
         YtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288505; x=1696893305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSkssDhEiWfimKWDZskn49BRf30NYKZNHbeb9+/CySI=;
        b=gz/HFCbl7n/EREttfiubOGRv+Z6HBJCrEwwEY6WIRjiIuBKW0+MrpRBUJLPLpdCbFW
         dtHrI9OBzdS2uLMvzN9Td17GjEwvSgUy8WTnUb8dG+w0F8O6MmpjFF8hXxfc75Kklr8o
         86XFEg1aMhIA8vRDwZKGXuCGFEp94SZonEBLqgcM6G42UJPvTtNKE4aLIRbeiy0sOHzl
         MbasQcf+xRuXtU+LzQR1lZ3exoo4VpGOF1zEGxS0QJOOKt3sS94lxQLVE+OHEIGZH98E
         shOzXzEOO4+/8yCJWTsco3haRFz5UDymbykCfbUvdlfToc6Hn9AS2jnvs/D04idosq/r
         qZPA==
X-Gm-Message-State: AOJu0YxfJVBw6xBynXv3Skv+1q/gk091nPfrBLcfmXNHQiFr28+Fb4Ro
        wEFpYXrFIVysbbHuDS31DHs=
X-Google-Smtp-Source: AGHT+IEGWuQdhMJNjpLTPPxmWTPQIgDGApVsDy6H+Wd+pJhPThR2GTKhSJQpOGnzKTM7ZLEyCa1p/g==
X-Received: by 2002:a5d:4486:0:b0:321:6833:b930 with SMTP id j6-20020a5d4486000000b003216833b930mr12054922wrq.16.1696288505066;
        Mon, 02 Oct 2023 16:15:05 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e31-20020a5d595f000000b0031fbbe347e1sm63860wri.65.2023.10.02.16.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:15:04 -0700 (PDT)
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
Subject: [PATCH v2 4/4] mm/gup: adapt get_user_page_vma_remote() to never return NULL
Date:   Tue,  3 Oct 2023 00:14:54 +0100
Message-ID: <00319ce292d27b3aae76a0eb220ce3f528187508.1696288092.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696288092.git.lstoakes@gmail.com>
References: <cover.1696288092.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c |  4 ++--
 include/linux/mm.h      | 12 +++++++++---
 kernel/events/uprobes.c |  4 ++--
 mm/memory.c             |  3 +--
 4 files changed, 14 insertions(+), 9 deletions(-)

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
index 7b89f7bd420d..fa608cba041f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2425,6 +2425,9 @@ long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned int gup_flags, struct page **pages,
 			   int *locked);
 
+/*
+ * Retrieves a single page alongside its VMA. Does not support FOLL_NOWAIT.
+ */
 static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
 						    unsigned long addr,
 						    int gup_flags,
@@ -2432,12 +2435,15 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
 {
 	struct page *page;
 	struct vm_area_struct *vma;
-	int got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
+	int got;
+
+	if (WARN_ON_ONCE(unlikely(gup_flags & FOLL_NOWAIT)))
+		return ERR_PTR(-EINVAL);
+
+	got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
 
 	if (got < 0)
 		return ERR_PTR(got);
-	if (got == 0)
-		return NULL;
 
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

