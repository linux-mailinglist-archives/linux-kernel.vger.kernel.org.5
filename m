Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C062F7FA2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjK0OcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399B136;
        Mon, 27 Nov 2023 06:31:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfb30ce241so17250435ad.0;
        Mon, 27 Nov 2023 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095469; x=1701700269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBt5qqEXcIxLlVq5mn6Mu1pF2TRKVo2Ss4zaqApVgBQ=;
        b=YtOsSu6w/+/1n8ZYa7O2o087Suja++niiFuL1c8/2I3TtgIDj9fy2GiINUA3+5SCW6
         tWc/NgxXmgh6g4iMLvpAtDLU153BjMLnqyFkSNVIEQjcVsAY9lYZGO1Xrg99U5ZJyWPX
         1ktI3EjUd5M/d8blAYicuwAE0FBMFRjt3VTK945cKP5qM0iZSBohy76l7QNI3B+hnSi1
         NTJqz3q29uaEXy0eZf3JfpHedOHB4CJPaEJU1g0rlFi2VJ6TA2gkME0tjpN8TYiAzdmO
         x/VkQgz1zzlgtDfwWRmSptsEta2wFBBckSZUW0cSAfuoDsnVugNS6vrjXTDQKyo9Dkst
         rWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095469; x=1701700269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBt5qqEXcIxLlVq5mn6Mu1pF2TRKVo2Ss4zaqApVgBQ=;
        b=jdB8aP3athxq9eZ48ce655Y/WZMKFuLGOKIqIHLZWfJuotHsjPE1SOIQG7fifGk+bT
         BaTo5OG8fdhmkkc2knFvc/YCoE/XQFjVYvSv9f429Cq59Oa71eEybHoJoXkAYqUUf1Zm
         QmuICddnNJEiAmIaY9lwpT6UZOKmC8Hk0zbaqc5O/OhM8qoCkat1zvug4TTqhtfzobHG
         SOaObdwP4pl2X3XTknZuky5MO1cWTJzndIzC8jDysdLkzhefFopog01Yl8HG1kMY5J/u
         KSWkzeBpKTCcjfpao9dRp1QJ7t/kBwtDHPYq+P021/iC9z1ZSOVLoJS6VM/z5Q4OTZXM
         2j3g==
X-Gm-Message-State: AOJu0Yw2c4tMMUhaqRS/7b2NI1sN3QFFy2HeRbqUtj9hbYFZz59KXiIb
        ZvjCL6F+QLrvwNOpEztRYSg=
X-Google-Smtp-Source: AGHT+IGGggnKsTbQDYtZGZyl5Gak4PUXvkGjS5Ry3Cc0on0EINCc1SQWs6MdPJJxFiz/20o0jk6y+w==
X-Received: by 2002:a17:903:120b:b0:1cc:bf63:929 with SMTP id l11-20020a170903120b00b001ccbf630929mr15110401plh.64.1701095469174;
        Mon, 27 Nov 2023 06:31:09 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:08 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] nilfs2: Add nilfs_get_folio()
Date:   Mon, 27 Nov 2023 23:30:28 +0900
Message-Id: <20231127143036.2425-10-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
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

Convert nilfs_get_page() to be a wrapper.
Also convert nilfs_check_page() to nilfs_check_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 53 +++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 89e8a248e571..5c9ca3f0d7f4 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -107,18 +107,18 @@ static void nilfs_commit_chunk(struct page *page,
 	unlock_page(page);
 }
 
-static bool nilfs_check_page(struct page *page, char *kaddr)
+static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 {
-	struct inode *dir = page->mapping->host;
+	struct inode *dir = folio->mapping->host;
 	struct super_block *sb = dir->i_sb;
 	unsigned int chunk_size = nilfs_chunk_size(dir);
-	unsigned int offs, rec_len;
-	unsigned int limit = PAGE_SIZE;
+	size_t offs, rec_len;
+	size_t limit = folio_size(folio);
 	struct nilfs_dir_entry *p;
 	char *error;
 
-	if ((dir->i_size >> PAGE_SHIFT) == page->index) {
-		limit = dir->i_size & ~PAGE_MASK;
+	if (dir->i_size < folio_pos(folio) + limit) {
+		limit = dir->i_size - folio_pos(folio);
 		if (limit & (chunk_size - 1))
 			goto Ebadsize;
 		if (!limit)
@@ -140,7 +140,7 @@ static bool nilfs_check_page(struct page *page, char *kaddr)
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	folio_set_checked(folio);
 	return true;
 
 	/* Too bad, we had an error */
@@ -163,8 +163,8 @@ static bool nilfs_check_page(struct page *page, char *kaddr)
 	error = "directory entry across blocks";
 bad_entry:
 	nilfs_error(sb,
-		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
-		    dir->i_ino, error, (page->index << PAGE_SHIFT) + offs,
+		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
+		    dir->i_ino, error, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode),
 		    rec_len, p->name_len);
 	goto fail;
@@ -172,37 +172,48 @@ static bool nilfs_check_page(struct page *page, char *kaddr)
 	p = (struct nilfs_dir_entry *)(kaddr + offs);
 	nilfs_error(sb,
 		    "entry in directory #%lu spans the page boundary offset=%lu, inode=%lu",
-		    dir->i_ino, (page->index << PAGE_SHIFT) + offs,
+		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode));
 fail:
-	SetPageError(page);
+	folio_set_error(folio);
 	return false;
 }
 
-static void *nilfs_get_page(struct inode *dir, unsigned long n,
-		struct page **pagep)
+static void *nilfs_get_folio(struct inode *dir, unsigned long n,
+		struct folio **foliop)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
+	struct folio *folio = read_mapping_folio(mapping, n, NULL);
 	void *kaddr;
 
-	if (IS_ERR(page))
-		return page;
+	if (IS_ERR(folio))
+		return folio;
 
-	kaddr = kmap_local_page(page);
-	if (unlikely(!PageChecked(page))) {
-		if (!nilfs_check_page(page, kaddr))
+	kaddr = kmap_local_folio(folio, 0);
+	if (unlikely(!folio_test_checked(folio))) {
+		if (!nilfs_check_folio(folio, kaddr))
 			goto fail;
 	}
 
-	*pagep = page;
+	*foliop = folio;
 	return kaddr;
 
 fail:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return ERR_PTR(-EIO);
 }
 
+static void *nilfs_get_page(struct inode *dir, unsigned long n,
+		struct page **pagep)
+{
+	struct folio *folio;
+	void *kaddr = nilfs_get_folio(dir, n, &folio);
+
+	if (!IS_ERR(kaddr))
+		*pagep = &folio->page;
+	return kaddr;
+}
+
 /*
  * NOTE! unlike strncmp, nilfs_match returns 1 for success, 0 for failure.
  *
-- 
2.34.1

