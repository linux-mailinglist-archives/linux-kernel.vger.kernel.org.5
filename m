Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082F7FA2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjK0Obl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjK0ObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DC10D2;
        Mon, 27 Nov 2023 06:30:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfc1512df1so8689815ad.2;
        Mon, 27 Nov 2023 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095445; x=1701700245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ/vM3XQ9Xzn38++4z91sUsmQpG2Xapck6PJLaG5SCE=;
        b=Y1GSpM2LkZobFg3DhhQEurZNU5tUlLLV8CMxAIMjeVoeIuzFdwGdbSKuoArwzzksVO
         jL+hRd2IS7MmR0Ox1a6ZD4X5IvcMNNIrjIGN5oJlEKN0B+fqihw/mYVyi7fqnf3nPG8K
         KvZQi4vOErbD+EDEt9Mo+WchWfWmiVNpmoxnzebbbdGsKBDXv22ut3eqr3C/azfQ6A3t
         9AMdY7yQWvbZfqldjwUF/GKveBsCjDNlTV+mpIFt7TaYovr4v9NZ0seV8PC0tt5qIFyW
         i3JBpc098xFkH2WDGXTPsVD7DUQXwS1r1ErCFJEoWqQ4iqf6YxholXqifrFLuAalkC0w
         TknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095445; x=1701700245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ/vM3XQ9Xzn38++4z91sUsmQpG2Xapck6PJLaG5SCE=;
        b=DujTGdlSQOv5dHl9tLQ32L8L6gTbVuMSheyrVgGPLQ84KdkgwO6KyQ0MGS0JvIsmbK
         xdlvNjlKwp9JfEaUxY+3ae1hI6KZZ+phX0yuTxzLWcycNKub2penN0dVB89Stt7XBaMF
         F+JR5t4dNG44AWthbWSHxyAS8nPuXrqhi9a0CcxfZDi71RHuQ1+Lgj21geRxe0UP31pi
         YhlW9iX2R2En7yd+xMvZX4YQ5DzM7dRWMKdNvkdKpUz42s+y7AEtZ/a3MBEGBQoLdfYN
         Ek4XwneQ9YS3HtH5GKaKFpIYzcFoUV0KqC/Craxmq1RWKfDyqb7BVT3VgQgty55OiMDE
         gZDg==
X-Gm-Message-State: AOJu0Ywd1ilxoBb7yfvY5jofu8xZaAn1YSe2VOEzIwe9cjzV9wqg+xSg
        D3v0Ifmhm2ub061e3RBz7SruC8Y7PlE=
X-Google-Smtp-Source: AGHT+IFy5VE+vtEgemkre65ANI2Q1mcBjoivTg3gEz1BU1CGEIwKQ7nLOEdhMaUTK1QeSN1tKTCFZg==
X-Received: by 2002:a17:902:c144:b0:1cf:bf7b:ae07 with SMTP id 4-20020a170902c14400b001cfbf7bae07mr4772809plj.7.1701095445321;
        Mon, 27 Nov 2023 06:30:45 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:30:44 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
Date:   Mon, 27 Nov 2023 23:30:20 +0900
Message-Id: <20231127143036.2425-2-konishi.ryusuke@gmail.com>
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

In a few directory operations, the call to nilfs_put_page() for a page
obtained using nilfs_find_entry() or nilfs_dotdot() is hidden in
nilfs_set_link() and nilfs_delete_entry(), making it difficult to track
page release and preventing change of its call position.

By moving nilfs_put_page() out of these functions, this makes the page
get/put correspondence clearer and makes it easier to swap
nilfs_put_page() calls (and kunmap calls within them) when modifying
multiple directory entries simultaneously in nilfs_rename().

Also, update comments for nilfs_set_link() and nilfs_delete_entry() to
reflect changes in their behavior.

To make nilfs_put_page() visible from namei.c, this moves its definition
to nilfs.h and replaces existing equivalents to use it, but the exposure
of that definition is temporary and will be removed on a later
kmap -> kmap_local conversion.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c   | 11 +----------
 fs/nilfs2/namei.c | 13 +++++++------
 fs/nilfs2/nilfs.h |  6 ++++++
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index de2073c47651..b9f13bdf8fba 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -64,12 +64,6 @@ static inline unsigned int nilfs_chunk_size(struct inode *inode)
 	return inode->i_sb->s_blocksize;
 }
 
-static inline void nilfs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
@@ -413,7 +407,6 @@ ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	return res;
 }
 
-/* Releases the page */
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
@@ -428,7 +421,6 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
-	nilfs_put_page(page);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
@@ -533,7 +525,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Page is up-to-date.
  */
 int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 {
@@ -569,7 +561,6 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 	nilfs_commit_chunk(page, mapping, from, to);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 out:
-	nilfs_put_page(page);
 	return err;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 2a4e7f4a8102..99255694cbe9 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -280,6 +280,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
+	nilfs_put_page(page);
 	if (err)
 		goto out;
 
@@ -386,6 +387,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 		if (!new_de)
 			goto out_dir;
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_put_page(new_page);
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -409,9 +411,11 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	inode_set_ctime_current(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
+	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
+		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
 	nilfs_mark_inode_dirty(old_dir);
@@ -421,13 +425,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	return err;
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		nilfs_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	nilfs_put_page(old_page);
 out:
 	nilfs_transaction_abort(old_dir->i_sb);
 	return err;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 8046490cd7fe..afd700f5dc4e 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -237,6 +237,12 @@ extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
 extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 			   struct page *, struct inode *);
 
+static inline void nilfs_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
+
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
-- 
2.34.1

