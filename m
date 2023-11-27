Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD147FA2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjK0Och (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD41B5;
        Mon, 27 Nov 2023 06:31:19 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so8815355ad.1;
        Mon, 27 Nov 2023 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095479; x=1701700279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiorARWlp4qpkHsXWYNAOFHyrVXE8mudjiPl7CQm/78=;
        b=Qlj7ObEVkgGfo0F+ejgNcIffZ6OYUtkuFJcPjUEJt66z1LHX24NLuaBc1nL8P1gORx
         dxyRk9buSB+wFBmCBKtlrWUxjjTJT9rE/UB/SFvkMdixk0gdNsCgh5o8cOdj1TGPMEKs
         LNKtPTpOyZW7hzAfVJRaDfJz2Y6RK/c0HROQSeJpNiSNYR5bCTa+gevAGiP1uY6yFJS6
         ts5TSOZ1mrpMuGUftnd/FFVB/h7u3zJLLqV+0nb1YRmPExp5XetDpqeXNne4TNPORLgS
         PeBt0n+P1qr8VQU9TSJX8l6Ywbnel6jrBydQ0scbfxSFHvTrzwo/Vcn5/xFhx0nSK5iP
         V6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095479; x=1701700279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiorARWlp4qpkHsXWYNAOFHyrVXE8mudjiPl7CQm/78=;
        b=L+RFO2jMGd/qN+OxgTlMdawEn7Ouw3lOiBWjfpqZOX1pbl0EaC0aCyeaL4IwvKyTyn
         trhod/PvkshUosjdbkebMnfqhZGBUt1sLnVlBzje4rGIuTF4UlHiuBGJjGokfA9h2t2H
         KtyCEuVbDREQxwfEOFSyYth9OqrL1EQiNNZu4RBbN3gRmztipdVnfxELH603yDcdC1yf
         PyMQBTR0LUsn2/pps0FJ+8jciac+Ha/D6aplunW3mMGUKrFVqAW/Zw7bYtg0bJvVpaWu
         UH5GJasgvQWi6ejem2Ifpde7oZZARXoOSt8HdmWp2NX8VIxO6qJ6J5EYMrojkgEe6viW
         Lhvw==
X-Gm-Message-State: AOJu0YyAruV+FY39JQDiyUuISG7ghZRfq02/UPGtQYmRt0X3wzGKEX3t
        wZ+53S+dY+OGdqja4hsCFFZDPemarK8=
X-Google-Smtp-Source: AGHT+IFarF66RG3004ITpjBR2ukq0GnNAI2kVE4RFG4Cg8APf1Ne6cbdYR5mOEbfTktjyDo/Uju42w==
X-Received: by 2002:a17:902:6941:b0:1cf:ce79:88e8 with SMTP id k1-20020a170902694100b001cfce7988e8mr3776147plt.29.1701095478869;
        Mon, 27 Nov 2023 06:31:18 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:18 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] nilfs2: Convert nilfs_rename() to use folios
Date:   Mon, 27 Nov 2023 23:30:31 +0900
Message-Id: <20231127143036.2425-13-konishi.ryusuke@gmail.com>
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

This involves converting nilfs_find_entry(), nilfs_dotdot(),
nilfs_set_link(), nilfs_delete_entry() and nilfs_do_unlink()
to use folios as well.

[ konishi.ryusuke: followed the change of page release helper call sites ]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c   | 68 ++++++++++++++++++++++-------------------------
 fs/nilfs2/namei.c | 36 ++++++++++++-------------
 fs/nilfs2/nilfs.h | 20 +++++++-------
 3 files changed, 60 insertions(+), 64 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index a79726182867..2a759598801b 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -323,38 +323,35 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 }
 
 /*
- *	nilfs_find_entry()
+ * nilfs_find_entry()
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the page in which the entry was found, and the entry itself
- * (as a parameter - res_dir). Page is returned mapped and unlocked.
- * Entry is guaranteed to be valid.
+ * Finds an entry in the specified directory with the wanted name. It
+ * returns the folio in which the entry was found, and the entry itself.
+ * The folio is mapped and unlocked.  When the caller is finished with
+ * the entry, it should call folio_release_kmap().
+ *
+ * On failure, returns NULL and the caller should ignore foliop.
  */
-struct nilfs_dir_entry *
-nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
-		 struct page **res_page)
+struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
+		const struct qstr *qstr, struct folio **foliop)
 {
 	const unsigned char *name = qstr->name;
 	int namelen = qstr->len;
 	unsigned int reclen = NILFS_DIR_REC_LEN(namelen);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct folio *folio = NULL;
 	struct nilfs_inode_info *ei = NILFS_I(dir);
 	struct nilfs_dir_entry *de;
 
 	if (npages == 0)
 		goto out;
 
-	/* OFFSET_CACHE */
-	*res_page = NULL;
-
 	start = ei->i_dir_start_lookup;
 	if (start >= npages)
 		start = 0;
 	n = start;
 	do {
-		char *kaddr = nilfs_get_folio(dir, n, &folio);
+		char *kaddr = nilfs_get_folio(dir, n, foliop);
 
 		if (!IS_ERR(kaddr)) {
 			de = (struct nilfs_dir_entry *)kaddr;
@@ -363,14 +360,14 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 				if (de->rec_len == 0) {
 					nilfs_error(dir->i_sb,
 						"zero-length directory entry");
-					folio_release_kmap(folio, kaddr);
+					folio_release_kmap(*foliop, kaddr);
 					goto out;
 				}
 				if (nilfs_match(namelen, name, de))
 					goto found;
 				de = nilfs_next_entry(de);
 			}
-			folio_release_kmap(folio, kaddr);
+			folio_release_kmap(*foliop, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -387,14 +384,13 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	return NULL;
 
 found:
-	*res_page = &folio->page;
 	ei->i_dir_start_lookup = n;
 	return de;
 }
 
-struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
+struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
+	struct nilfs_dir_entry *de = nilfs_get_folio(dir, 0, foliop);
 
 	if (IS_ERR(de))
 		return NULL;
@@ -405,30 +401,30 @@ ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 {
 	ino_t res = 0;
 	struct nilfs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 
-	de = nilfs_find_entry(dir, qstr, &page);
+	de = nilfs_find_entry(dir, qstr, &folio);
 	if (de) {
 		res = le64_to_cpu(de->inode);
-		unmap_and_put_page(page, de);
+		folio_release_kmap(folio, de);
 	}
 	return res;
 }
 
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
-		    struct page *page, struct inode *inode)
+		    struct folio *folio, struct inode *inode)
 {
-	unsigned int from = offset_in_page(de);
-	unsigned int to = from + nilfs_rec_len_from_disk(de->rec_len);
-	struct address_space *mapping = page->mapping;
+	size_t from = offset_in_folio(folio, de);
+	size_t to = from + nilfs_rec_len_from_disk(de->rec_len);
+	struct address_space *mapping = folio->mapping;
 	int err;
 
-	lock_page(page);
-	err = nilfs_prepare_chunk(page, from, to);
+	folio_lock(folio);
+	err = nilfs_prepare_chunk(&folio->page, from, to);
 	BUG_ON(err);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(page, mapping, from, to);
+	nilfs_commit_chunk(&folio->page, mapping, from, to);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
@@ -532,14 +528,14 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date.
+ * previous entry. Folio is up-to-date.
  */
-int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
+int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
-	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
-	unsigned int from, to;
+	char *kaddr = (char *)((unsigned long)dir & ~(folio_size(folio) - 1));
+	size_t from, to;
 	struct nilfs_dir_entry *de, *pde = NULL;
 	int err;
 
@@ -559,13 +555,13 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 	}
 	if (pde)
 		from = (char *)pde - kaddr;
-	lock_page(page);
-	err = nilfs_prepare_chunk(page, from, to);
+	folio_lock(folio);
+	err = nilfs_prepare_chunk(&folio->page, from, to);
 	BUG_ON(err);
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
-	nilfs_commit_chunk(page, mapping, from, to);
+	nilfs_commit_chunk(&folio->page, mapping, from, to);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 out:
 	return err;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index c08b1bf9fa7b..959bd9fb3d81 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -260,11 +260,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode;
 	struct nilfs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	err = -ENOENT;
-	de = nilfs_find_entry(dir, &dentry->d_name, &page);
+	de = nilfs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de)
 		goto out;
 
@@ -279,8 +279,8 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 			   inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
-	err = nilfs_delete_entry(de, page);
-	unmap_and_put_page(page, de);
+	err = nilfs_delete_entry(de, folio);
+	folio_release_kmap(folio, de);
 	if (err)
 		goto out;
 
@@ -348,9 +348,9 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct page *dir_page = NULL;
+	struct folio *dir_folio = NULL;
 	struct nilfs_dir_entry *dir_de = NULL;
-	struct page *old_page;
+	struct folio *old_folio;
 	struct nilfs_dir_entry *old_de;
 	struct nilfs_transaction_info ti;
 	int err;
@@ -363,19 +363,19 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 		return err;
 
 	err = -ENOENT;
-	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_de)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = nilfs_dotdot(old_inode, &dir_page);
+		dir_de = nilfs_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
-		struct page *new_page;
+		struct folio *new_folio;
 		struct nilfs_dir_entry *new_de;
 
 		err = -ENOTEMPTY;
@@ -383,11 +383,11 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
-		unmap_and_put_page(new_page, new_de);
+		nilfs_set_link(new_dir, new_de, new_folio, old_inode);
+		folio_release_kmap(new_folio, new_de);
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -410,14 +410,14 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	nilfs_delete_entry(old_de, old_page);
+	nilfs_delete_entry(old_de, old_folio);
 
 	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
-		unmap_and_put_page(dir_page, dir_de);
+		nilfs_set_link(old_inode, dir_de, dir_folio, new_dir);
+		folio_release_kmap(dir_folio, dir_de);
 		drop_nlink(old_dir);
 	}
-	unmap_and_put_page(old_page, old_de);
+	folio_release_kmap(old_folio, old_de);
 
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
@@ -427,9 +427,9 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 
 out_dir:
 	if (dir_de)
-		unmap_and_put_page(dir_page, dir_de);
+		folio_release_kmap(dir_folio, dir_de);
 out_old:
-	unmap_and_put_page(old_page, old_de);
+	folio_release_kmap(old_folio, old_de);
 out:
 	nilfs_transaction_abort(old_dir->i_sb);
 	return err;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 8046490cd7fe..98cffaf0ac12 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -226,16 +226,16 @@ static inline __u32 nilfs_mask_flags(umode_t mode, __u32 flags)
 }
 
 /* dir.c */
-extern int nilfs_add_link(struct dentry *, struct inode *);
-extern ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
-extern int nilfs_make_empty(struct inode *, struct inode *);
-extern struct nilfs_dir_entry *
-nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
-extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
-extern int nilfs_empty_dir(struct inode *);
-extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct page *, struct inode *);
+int nilfs_add_link(struct dentry *, struct inode *);
+ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
+int nilfs_make_empty(struct inode *, struct inode *);
+struct nilfs_dir_entry *nilfs_find_entry(struct inode *, const struct qstr *,
+		struct folio **);
+int nilfs_delete_entry(struct nilfs_dir_entry *, struct folio *);
+int nilfs_empty_dir(struct inode *);
+struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct folio **);
+void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
+			   struct folio *, struct inode *);
 
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
-- 
2.34.1

