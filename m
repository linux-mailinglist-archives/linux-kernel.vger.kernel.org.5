Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75F7FA2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjK0OcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758B19B1;
        Mon, 27 Nov 2023 06:31:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce627400f6so32884815ad.2;
        Mon, 27 Nov 2023 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095465; x=1701700265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmlHMlCcVNl+9QQ+HEZAWjQ4Dk/nWbrv44XxJPOCOUs=;
        b=H9sYfuiUkCJajY1vgdV0dnhNlCGa2WbNjtM11m7CoGDv16DRzn/2u+7U/9ueD4j5Cz
         Dwgc9KEap7Pkx2T7vB6db/7z4DABRH56gEz1dLZE3Ptnlo0oeO0yyVednFz89+FLV4HM
         H4U4tRCIP+4r6ie2u6PqP/Y0tLELo7Tt7xRDnodyYkYTELAyOUf2fx/GRYL6VVlAGPRw
         5khczgHmj6y/fgBgX/XU+qcv4Azo4VnqgerdbdkUzHwLU22aZDl2veEs0kBreHgN1E1i
         /yXxm9HFgcguGUQeM8Ch6K1M3SK63xumqDw7OPgx6OAj0hUUyFDWmVkd3qH857fMEzKv
         EUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095465; x=1701700265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmlHMlCcVNl+9QQ+HEZAWjQ4Dk/nWbrv44XxJPOCOUs=;
        b=okN9sbmf4qS92ZQ93Lj3GeuApsM2ROPUVYtMy1hvv1iCqqqomgY5SGq4qd8ttGzWRu
         ANuRCnM9HEcxnR2rrV2e2IFWZXGGHK30FbQBPXF/+pR0CmqDkTbpiMlGvgisKVDlAgc+
         5E98/wGF0pM9PTm/LghCAEcnMro/8+uTAxFI1L9kb1dTlWbmiyyVKJcUQ9SQZVeQnsvk
         ptN3CldN3we0r3X+6Bf6+8MVVUnxflekyyzxwpyBuHU7yHQ4msQVF/PdI23DYFycs4fm
         5M9Kwlyxe/BvgXpwOE8X0ytMyB1dWsZoOBr+paipKBqXMyPOd7N3M3df7MEA+S+TGoFx
         4rdA==
X-Gm-Message-State: AOJu0YzgtcP/pB/l18u6RkvQDXXR+yHBCgihA1JgFDz07Zs/KXEDyoVL
        hxWNM79vUevNUn0tfjIRF5d2C6cAaeo=
X-Google-Smtp-Source: AGHT+IHcpLQCX7P2fe+VGevVjZMn1ka13x6syqzxnJZTvu2H8fyqHRlIQNkUFJgid2J3N2ExEOyPvA==
X-Received: by 2002:a17:903:41c6:b0:1cf:c2ad:7f43 with SMTP id u6-20020a17090341c600b001cfc2ad7f43mr4877366ple.23.1701095465169;
        Mon, 27 Nov 2023 06:31:05 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:04 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] nilfs2: Switch to kmap_local for directory handling
Date:   Mon, 27 Nov 2023 23:30:27 +0900
Message-Id: <20231127143036.2425-9-konishi.ryusuke@gmail.com>
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

Match ext2 by using kmap_local() instead of kmap().  This is more
efficient.  Also use unmap_and_put_page() instead of duplicating
it as a nilfs function.

[ konishi.ryusuke: followed the change of page release helper call sites ]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c   | 27 +++++++++++++--------------
 fs/nilfs2/namei.c | 12 ++++++------
 fs/nilfs2/nilfs.h |  6 ------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 01900e84bddf..89e8a248e571 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -189,7 +189,7 @@ static void *nilfs_get_page(struct inode *dir, unsigned long n,
 	if (IS_ERR(page))
 		return page;
 
-	kaddr = kmap(page);
+	kaddr = kmap_local_page(page);
 	if (unlikely(!PageChecked(page))) {
 		if (!nilfs_check_page(page, kaddr))
 			goto fail;
@@ -199,7 +199,7 @@ static void *nilfs_get_page(struct inode *dir, unsigned long n,
 	return kaddr;
 
 fail:
-	nilfs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -287,7 +287,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 		for ( ; (char *)de <= limit; de = nilfs_next_entry(de)) {
 			if (de->rec_len == 0) {
 				nilfs_error(sb, "zero-length directory entry");
-				nilfs_put_page(page);
+				unmap_and_put_page(page, kaddr);
 				return -EIO;
 			}
 			if (de->inode) {
@@ -300,13 +300,13 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le64_to_cpu(de->inode), t)) {
-					nilfs_put_page(page);
+					unmap_and_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += nilfs_rec_len_from_disk(de->rec_len);
 		}
-		nilfs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -352,14 +352,14 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 				if (de->rec_len == 0) {
 					nilfs_error(dir->i_sb,
 						"zero-length directory entry");
-					nilfs_put_page(page);
+					unmap_and_put_page(page, kaddr);
 					goto out;
 				}
 				if (nilfs_match(namelen, name, de))
 					goto found;
 				de = nilfs_next_entry(de);
 			}
-			nilfs_put_page(page);
+			unmap_and_put_page(page, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -399,8 +399,7 @@ ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = nilfs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = le64_to_cpu(de->inode);
-		kunmap(page);
-		put_page(page);
+		unmap_and_put_page(page, de);
 	}
 	return res;
 }
@@ -484,7 +483,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct nilfs_dir_entry *)((char *)de + rec_len);
 		}
 		unlock_page(page);
-		nilfs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -512,7 +511,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	nilfs_put_page(page);
+	unmap_and_put_page(page, de);
 out:
 	return err;
 out_unlock:
@@ -609,10 +608,10 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
 int nilfs_empty_dir(struct inode *inode)
 {
 	struct page *page = NULL;
+	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct nilfs_dir_entry *de;
 
 		kaddr = nilfs_get_page(inode, i, &page);
@@ -644,12 +643,12 @@ int nilfs_empty_dir(struct inode *inode)
 			}
 			de = nilfs_next_entry(de);
 		}
-		nilfs_put_page(page);
+		unmap_and_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	nilfs_put_page(page);
+	unmap_and_put_page(page, kaddr);
 	return 0;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index d179db8074c2..c08b1bf9fa7b 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -280,7 +280,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
-	nilfs_put_page(page);
+	unmap_and_put_page(page, de);
 	if (err)
 		goto out;
 
@@ -387,7 +387,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 		if (!new_de)
 			goto out_dir;
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
-		nilfs_put_page(new_page);
+		unmap_and_put_page(new_page, new_de);
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -414,10 +414,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
-		nilfs_put_page(dir_page);
+		unmap_and_put_page(dir_page, dir_de);
 		drop_nlink(old_dir);
 	}
-	nilfs_put_page(old_page);
+	unmap_and_put_page(old_page, old_de);
 
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
@@ -427,9 +427,9 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 
 out_dir:
 	if (dir_de)
-		nilfs_put_page(dir_page);
+		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	nilfs_put_page(old_page);
+	unmap_and_put_page(old_page, old_de);
 out:
 	nilfs_transaction_abort(old_dir->i_sb);
 	return err;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index afd700f5dc4e..8046490cd7fe 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -237,12 +237,6 @@ extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
 extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 			   struct page *, struct inode *);
 
-static inline void nilfs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
-- 
2.34.1

