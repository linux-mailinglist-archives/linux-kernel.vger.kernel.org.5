Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181A80FBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377738AbjLMAJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377932AbjLMAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:08:57 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB6D69;
        Tue, 12 Dec 2023 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FR4Bu1shg/1OWRZtkrUGIBB3IegyXrsoJGzrPQwNckk=; b=ssFYiY+Cz+KBWgVJ8B4d/3gkXn
        kdaPXjvqWiMyWeNeW415BxuXaOWZr/rvcir6rjSIoi3+3+lILgmATZ+W4bxcDxpbUJecBraaiNNjy
        hs6OMshEfgHBMffYJg9yaunRID73USie1VzRAZWF6e58h9C+/gJyZTrKVFAW6ty9obhyjJHYaTTBr
        5lx++i3OL+RVyNGUqQRkgB0MXkurp+x0zQ5+apPumm5oVu1FBjZW6eUBbM3V9ODiWQF7pE9pH4R2K
        yYFjgvhyQJ9puJPYM1270dYvEnmZQoEaYZHvcjmbcjR5lvDvT2xZxSMzV7WaL80TaY/EFwqpfuIUE
        Ar8BllQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDCny-00BX1z-04;
        Wed, 13 Dec 2023 00:08:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] minixfs: use offset_in_page()
Date:   Wed, 13 Dec 2023 00:08:46 +0000
Message-Id: <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000656.GI1674809@ZenIV>
References: <20231213000656.GI1674809@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's cheaper and more idiomatic than subtracting page_address()
of the corresponding page...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/minix/dir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 62c313fc9a49..34a5d17f0796 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -268,7 +268,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) + p - (char *)page_address(page);
+	pos = page_offset(page) + offset_in_page(p);
 	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
 	if (err)
 		goto out_unlock;
@@ -296,8 +296,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = page_address(page);
-	loff_t pos = page_offset(page) + (char*)de - kaddr;
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	unsigned len = sbi->s_dirsize;
 	int err;
@@ -421,8 +420,7 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 {
 	struct inode *dir = page->mapping->host;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
-- 
2.39.2

