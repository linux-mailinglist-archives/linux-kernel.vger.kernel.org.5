Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C37EAC45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjKNI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjKNI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:58:07 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECC1A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:58:04 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c7c69e4367so982762b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952284; x=1700557084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdVHuRxrgh6ZnDPt3zAPPgzhGD9FhGbirtIg8ADYBkA=;
        b=vy1SKY8Aqaj1Pz9+KpZnp2aytIocLaeWDgtUQJJlpbZrYTGRTv4DZDT7haQlNZv8f2
         pu5Wy7OP3P2mxCfNfaJw4md330ep/6+p+Ymx+adrEBTNimR2WAvdRs0pHZ4tBb2BGnzs
         9NSZRGo3lfOt5Fsoqz0xBAKy6TtumQJ3c5k0b1tUJOF79sbOhAtHMPlZDyqyLKcF88yB
         hmPmFB3rMyunhZOTgB8l8t1EbIQD9V/gWwPKsrXMsTlH9zaTSd+AclckV8Pf8COZ5U0B
         sZrh6m8U6UzN+IjoqenVtIvFSJFCzAeAVAk3vvEQaObASmjLOc5Ax9GumbiwF1H4pOzU
         RWoQ==
X-Gm-Message-State: AOJu0YyRcpXQ7aEARQj60HaHOuBgWMVi7sOJpF7wykPl3rrKgJAWQBOz
        94BMCikqfroZFhxRRB/YVPtfGXphSE4nyN8kT8PT2NJp7cxhyJs=
X-Google-Smtp-Source: AGHT+IGyLkWfWQbD33SW21d0D1epFPdurKI5Id2g7NhoB3M+Y+PBGMH1iD4+UmHt8P4IjWJisAh5L5qU1CJrxNPKNuidSz4Q2ms6
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8504:b0:6c0:568b:d9e5 with SMTP id
 ha4-20020a056a00850400b006c0568bd9e5mr2305596pfb.1.1699952283877; Tue, 14 Nov
 2023 00:58:03 -0800 (PST)
Date:   Tue, 14 Nov 2023 00:58:03 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000407ec060a18fc3f@google.com>
Subject: Re: [syzbot] [PATCH] Test oob in squashfs readahead
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test oob in squashfs readahead
Author: eadavis@qq.com

please test squashfs readahead oob

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 13d88ac54ddd

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 581ce9519339..ba4f53c3725d 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -321,11 +321,16 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
 	}
-	if (length < 0 || length > output->length ||
-			(index + length) > msblk->bytes_used) {
+
+	if (length < 0) {
 		res = -EIO;
 		goto out;
 	}
+	if (length > output->length || (index + length) > msblk->bytes_used) {
+		printk("srd: l:%d, ol: %d, bu: %d,i:%d, c:%d \n", length, 
+				output->length, msblk->bytes_used, index, compressed);
+		length = min_t(int, msblk->bytes_used - index, output->length);
+	}
 
 	if (next_index)
 		*next_index = index + length;
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..b54d6b993357 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -461,6 +461,12 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
 				page->index, squashfs_i(inode)->start);
 
+	if (!file_end) {
+		printk("i:%p, is:%d, %s\n", inode, i_size_read(inode), __func__);
+		res = -EINVAL;
+		goto out;
+	}
+
 	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
@@ -547,6 +553,11 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	int i, file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
+	if (!file_end && !start) {
+		printk("i:%p, is:%d, %s\n", inode, i_size_read(inode), __func__);
+		return;
+	}
+
 	readahead_expand(ractl, start, (len | mask) + 1);
 
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index aa3411354e66..f3b0111e6fbd 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -175,6 +175,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		u64 frag_blk;
 		struct squashfs_lreg_inode *sqsh_ino = &squashfs_ino.lreg;
 
+		printk("in0: %p, fs: %d, it: %d, %s\n", inode, inode->i_size, type, __func__);
 		err = squashfs_read_metadata(sb, sqsh_ino, &block, &offset,
 							sizeof(*sqsh_ino));
 		if (err < 0)
@@ -403,6 +404,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	} else
 		squashfs_i(inode)->xattr_count = 0;
 
+	printk("in: %p, fs: %d, it: %d, %s\n", inode, inode->i_size, type, __func__);
 	return 0;
 
 failed_read:

