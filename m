Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02D7FA2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjK0Ocd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213D1A7;
        Mon, 27 Nov 2023 06:31:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfd78f8a12so5374665ad.2;
        Mon, 27 Nov 2023 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095482; x=1701700282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYhxtv86BtK/w/7d1AHNEGaD3rJv/iHyqgFD4qVbk18=;
        b=SbhbYCgdRRJLY580S8COCvn54sLEVfwmMgo0d7JdRY2xOyN7Ff9fn5WCO8o+FwW0oZ
         /sclR8OD0JmkN6aTv/bBwD2A90IDWQvhJCSNguOMZ2V4Iah5SR/c99zjCH+x4w41C3Hz
         63qjI8LND+2hYDLmCgsmLKTS+ONS5v75+/BNRU087DzoadWlksUJ9UjuKbz8/I1bxWR+
         3j3Okrqj4W0d2YkvUZ+FwguBM7xOUerK9pQFHZ4zxFN7gq/dy6aRdwihMY8UMMpw/jqx
         2W2MUWiuJV9HJxeN0NPrY94W+sP+wBCnjo2Exw7PTuzc65EYhfZJ30Rbyvz4KNBsJ9E+
         q05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095482; x=1701700282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYhxtv86BtK/w/7d1AHNEGaD3rJv/iHyqgFD4qVbk18=;
        b=TgwXaetQeSUsuRXVlnCe3zjKb8bjd/6cRxhNhhcR51xnNe++4UX3Gf1+VqkyV5MfDk
         0AReYKRIaPxQNMvkcsbcwxCgPMpDOM4xccNK2Og7H9ZLksL2OVl7DFb/zJm9hGyorfht
         JxRTUWKUNvrgKmkV06ipG4zOBlZHlA7Xk+8PAwgTRdRQU/DnHeIj8QlIW636apeHoJG3
         gFmELsLf2jzZdT9FCKeZ/pmzHHZVYpiwDjdnos6QOp0MGsuV+OF97KbK3bb445bTWJjv
         F5Ar4EWjj4UJcbF1AgVKdQ8U2tYXseyxpnLG2JoEuGUrWuLpiqJiRvNU7nRG1imcDK+9
         47/w==
X-Gm-Message-State: AOJu0YxRTc2s7ssLOzeNrR6ZZlkAFUG+GTHgV3Lcvctv6Oh1ar80yGIM
        iruV6jK5ig2goSArll91ybbitet4CUM=
X-Google-Smtp-Source: AGHT+IEPqbn3qSwDis9foPC4G7E12/KJ/W/nZq0LekG/FKWFcjYE//iyh9890Ft07kCpA+JyjG6YlQ==
X-Received: by 2002:a17:902:d2c6:b0:1cf:cf34:d4fa with SMTP id n6-20020a170902d2c600b001cfcf34d4famr4051225plc.28.1701095481683;
        Mon, 27 Nov 2023 06:31:21 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:21 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] nilfs2: Convert nilfs_add_link() to use a folio
Date:   Mon, 27 Nov 2023 23:30:32 +0900
Message-Id: <20231127143036.2425-14-konishi.ryusuke@gmail.com>
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

Remove six calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 2a759598801b..8d8c42e34148 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -439,30 +439,28 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	unsigned int chunk_size = nilfs_chunk_size(dir);
 	unsigned int reclen = NILFS_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct nilfs_dir_entry *de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
-	char *kaddr;
-	unsigned int from, to;
+	size_t from, to;
 	int err;
 
 	/*
 	 * We take care of directory expansion in the same loop.
-	 * This code plays outside i_size, so it locks the page
+	 * This code plays outside i_size, so it locks the folio
 	 * to protect that region.
 	 */
 	for (n = 0; n <= npages; n++) {
+		char *kaddr = nilfs_get_folio(dir, n, &folio);
 		char *dir_end;
 
-		kaddr = nilfs_get_page(dir, n, &page);
-		err = PTR_ERR(kaddr);
 		if (IS_ERR(kaddr))
-			goto out;
-		lock_page(page);
+			return PTR_ERR(kaddr);
+		folio_lock(folio);
 		dir_end = kaddr + nilfs_last_byte(dir, n);
 		de = (struct nilfs_dir_entry *)kaddr;
-		kaddr += PAGE_SIZE - reclen;
+		kaddr += folio_size(folio) - reclen;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
@@ -489,16 +487,16 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			de = (struct nilfs_dir_entry *)((char *)de + rec_len);
 		}
-		unlock_page(page);
-		unmap_and_put_page(page, kaddr);
+		folio_unlock(folio);
+		folio_release_kmap(folio, kaddr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	from = offset_in_page(de);
+	from = offset_in_folio(folio, de);
 	to = from + rec_len;
-	err = nilfs_prepare_chunk(page, from, to);
+	err = nilfs_prepare_chunk(&folio->page, from, to);
 	if (err)
 		goto out_unlock;
 	if (de->inode) {
@@ -513,16 +511,15 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	memcpy(de->name, name, namelen);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(page, page->mapping, from, to);
+	nilfs_commit_chunk(&folio->page, folio->mapping, from, to);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	unmap_and_put_page(page, de);
-out:
+	folio_release_kmap(folio, de);
 	return err;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	goto out_put;
 }
 
-- 
2.34.1

