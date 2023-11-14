Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24067EABEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjKNIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjKNIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:01 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB71702;
        Tue, 14 Nov 2023 00:45:53 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso4142832b3a.1;
        Tue, 14 Nov 2023 00:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951553; x=1700556353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umby/gWaD1NG+I+nr3l0/ZqYcII4I1MQz6hPgggA34k=;
        b=exrJ6969GK5Ej3rCN3aS9kX3Dm+Nr/RF3WauIv/kegCBXUq4KScwG6C2runr1pc7XF
         qdyPnOlA+3Weo/KMnsYMMpAIWGfnDJCDeBfq47z1WQwxKElVHr+rokpjl8b/C+Nk9WxB
         mMjeGQBEts7krWw+hVGKQtXRO+xlOgieWD6AsmfqnOtoQjbv+jNhslxaEFdRi7jpNcvz
         l5h5+XaR5KyilJs18/k0clj5Ao3CBQrUM/VjDL0SjhuEmvBUgl9iCxu7mMp7zistTaTM
         AZpuLWGgJDtUjXighP69VLAcCf11uSd/g5cVm9nUMH544iocpEluGKA5xyLEd+XsVo9h
         do0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951553; x=1700556353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umby/gWaD1NG+I+nr3l0/ZqYcII4I1MQz6hPgggA34k=;
        b=ZvpLvMkq5Tayc6n+1L3HZLa5A7KMIL7bjsASs+IYjULu83aTM26IaunCHGicLo+GDa
         kFA2t3WF5vKSfiMdKUWqNFGndPTZzGotv+c+sDBI+pG/jUoj4kzc6Ht/Dwupo0oSSlFg
         OeJwtnxJ9oJKjB/qD6+f0m6NiPhELYmas82CI4BONv/pYcRbULp4+gTSBB6NpDWkt3G4
         VsupppJkm5zPeA5kj6yazyolOurmaPwSb6XStoy1Q8Po3c7RYhHAlEG4RZzx9VViY+ll
         CEXZe/C8/h9oqnYnppZhQdyoYpQLwlaWuerY89nY+AbLHmC9rl720iiNrvHJo/EluFJc
         8pFA==
X-Gm-Message-State: AOJu0YycTdelT55Z/jRbCwjwk5aASzH6gerYmElA4MXdD7vvBEs9rfpd
        +fkYuv7kGmUuUAMsHw2yuesOm0D+xeI=
X-Google-Smtp-Source: AGHT+IGGYAjbGkfsRqilXeYukhPGeI/paHDvR9ncPZdGDta/CNE/gjRJ6SwuiPa1YraYcFy9DWrTpg==
X-Received: by 2002:a05:6a20:9387:b0:17e:aa00:ca62 with SMTP id x7-20020a056a20938700b0017eaa00ca62mr2258319pzh.17.1699951553184;
        Tue, 14 Nov 2023 00:45:53 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:52 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] nilfs2: Convert nilfs_page_mkwrite() to use a folio
Date:   Tue, 14 Nov 2023 17:44:27 +0900
Message-Id: <20231114084436.2755-12-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Using the new folio APIs saves seven hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/file.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 740ce26d1e76..bec33b89a075 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -45,34 +45,36 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vma->vm_file);
 	struct nilfs_transaction_info ti;
+	struct buffer_head *bh, *head;
 	int ret = 0;
 
 	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
 
 	sb_start_pagefault(inode->i_sb);
-	lock_page(page);
-	if (page->mapping != inode->i_mapping ||
-	    page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (folio->mapping != inode->i_mapping ||
+	    folio_pos(folio) >= i_size_read(inode) ||
+	    !folio_test_uptodate(folio)) {
+		folio_unlock(folio);
 		ret = -EFAULT;	/* make the VM retry the fault */
 		goto out;
 	}
 
 	/*
-	 * check to see if the page is mapped already (no holes)
+	 * check to see if the folio is mapped already (no holes)
 	 */
-	if (PageMappedToDisk(page))
+	if (folio_test_mappedtodisk(folio))
 		goto mapped;
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		int fully_mapped = 1;
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			if (!buffer_mapped(bh)) {
 				fully_mapped = 0;
@@ -81,11 +83,11 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 		} while (bh = bh->b_this_page, bh != head);
 
 		if (fully_mapped) {
-			SetPageMappedToDisk(page);
+			folio_set_mappedtodisk(folio);
 			goto mapped;
 		}
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 
 	/*
 	 * fill hole blocks
@@ -105,7 +107,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	folio_wait_stable(folio);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return vmf_fs_error(ret);
-- 
2.34.1

