Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365957EAB18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjKNHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:53:50 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47AADD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:53:47 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc49991f33so61887505ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699948427; x=1700553227;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jIuM5Eeqb2VBcpuHNbjIziZ1wCSqMb5QFUywRcTf9A=;
        b=P8p2sLGZ372qIrfzL0oN4nJtBAfY5IYPWAHlVUDFox30ASMwAC/8PMDSYh0RrnQyLl
         nZPhb40gkASOy9kjZGQjG+vRKxGtJQDrh/e+SHLnTqURrikD4wxxBarTLNr2NtCtNyh/
         MLaz/UsH9QDIiOdK4Rdpk7dZb0wmR73fkIDtI2x/JG4xmQA7puxI6tDRN5SRMBm9E6v8
         qbYZ/ESDfF5A0QqbBorMqGgRfZxBpxu5zG+9LK8K4fk3CCK7VeJZTLPUPZIDik+zrMyk
         X/T4X+MMGWAriwzS8gAHf9ssvILxgr/lsTT7a/fcybq2xKpmHrNh0nvLr/+Lvo7jAapj
         /ApA==
X-Gm-Message-State: AOJu0YwCn0N1pKAVNr5IWYVVUwSBo4bhfFtfbOF9J5QBUijnOYmvEKJ7
        Vw37VtN1ciw3HPp8mXEzsWuOFcrtWU2iwuF4uoasW+sEaYsviMA=
X-Google-Smtp-Source: AGHT+IFMx1q6pgyUiJLSn8n1mZXTl6brspPi9yVyubPj3NI09qmZYQd1hAMucAl5Gi3ma6nb1ioWgr0hgKV4SfHOcDuIYEkfx1w7
MIME-Version: 1.0
X-Received: by 2002:a17:902:f7c5:b0:1cc:3f93:fc2e with SMTP id
 h5-20020a170902f7c500b001cc3f93fc2emr389201plw.5.1699948427536; Mon, 13 Nov
 2023 23:53:47 -0800 (PST)
Date:   Mon, 13 Nov 2023 23:53:47 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028efe8060a181604@google.com>
Subject: Re: [syzbot] [PATCH] Test oob in squashfs readahead
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index 581ce9519339..1c7c5500206b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -314,9 +314,11 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		bio_uninit(bio);
 		kfree(bio);
 
+		printk("datal: %d \n", length);
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
 		index += 2;
+		printk("datal2: %d, c:%d, i:%d \n", length, compressed, index);
 
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
@@ -324,6 +326,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	if (length < 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
 		res = -EIO;
+		printk("srd: l:%d, ol: %d, bu: %d \n", length, output->length, msblk->bytes_used);
 		goto out;
 	}
 
@@ -340,6 +343,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 			goto out_free_bio;
 		}
 		res = msblk->thread_ops->decompress(msblk, bio, offset, length, output);
+		printk("srd6: r: %d \n", res);
 	} else {
 		res = copy_bio_to_actor(bio, output, offset, length);
 	}
diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 5062326d0efb..dac9eedea868 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -340,6 +340,7 @@ int squashfs_read_metadata(struct super_block *sb, void *buffer,
 	if (unlikely(length < 0))
 		return -EIO;
 
+	printk("srm: %d\n", length);
 	while (length) {
 		entry = squashfs_cache_get(sb, msblk->block_cache, *block, 0);
 		if (entry->error) {
@@ -381,6 +382,7 @@ struct squashfs_cache_entry *squashfs_get_fragment(struct super_block *sb,
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 
+	printk("sgf: %d\n", length);
 	return squashfs_cache_get(sb, msblk->fragment_cache, start_block,
 		length);
 }
@@ -396,6 +398,7 @@ struct squashfs_cache_entry *squashfs_get_datablock(struct super_block *sb,
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 
+	printk("sgd: %d\n", length);
 	return squashfs_cache_get(sb, msblk->read_page, start_block, length);
 }
 
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

