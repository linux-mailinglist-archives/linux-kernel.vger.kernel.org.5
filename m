Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185757EAA90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjKNGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjKNGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:35:45 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466D19B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 22:35:42 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c16f262317so2568957a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 22:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699943742; x=1700548542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+b4tjqYTMo+ud+h4iO/4QGJnvZwgd6PsWcf8tqR6bk=;
        b=ObO94ViBaj+hDn9qVg+CG8cvK2sbUND04qOtZNmvgX6/XKCqlQL9a1h2CtQ3tqCRfX
         Yx/e0Az4AxNogMcRmRpWxulMEckYC9RYQWUxdARdYml1afiFZlFCWlC+3K9R2MYJK1lh
         Ofa7foaj0sOJnJFuhevsEfh3Fm9R30nlTJ5KuFaoNnXl7jghseWoXTomMsYt+WTnSIya
         dag/RnJmAOhRQiR21/WC1u3kwUwW0ALMIS1RZ9Qt3qXuyuU/8G7JQeRO4sQf71SsUfEg
         QhWmzfQuWymkgTDHvx8FioNeu8RQNZh7m8oJSQ40Rrdp67gBXOG3UKQv6eTYnrkigU0B
         yXIQ==
X-Gm-Message-State: AOJu0YxibUWTHyn2e5vNliBxz3GOmp16qmQCRgK402JTz9g2Vlly7Kan
        VoGR/LYc5PSkPcaNjTxVXzeEarzxeW5SDPx5KqNhKE7TrXyfRrg=
X-Google-Smtp-Source: AGHT+IGuWJ1r32yOOblPmxgjl916/opxFHO6jwKYAg6bhRvGuNqxtHpOk13NyVkHJRoZ7VplVMtN0Xc2zeIINFqQu1qlwvDZA9+t
MIME-Version: 1.0
X-Received: by 2002:a63:d712:0:b0:5c1:814b:890f with SMTP id
 d18-20020a63d712000000b005c1814b890fmr333910pgg.1.1699943741894; Mon, 13 Nov
 2023 22:35:41 -0800 (PST)
Date:   Mon, 13 Nov 2023 22:35:41 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfb54d060a16fec6@google.com>
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
index 581ce9519339..7db8f2920c9e 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -287,6 +287,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 
 		if (index + 2 > msblk->bytes_used) {
 			res = -EIO;
+			printk("srd1: i:%d, bu:%d \n", index, msblk->bytes_used);
 			goto out;
 		}
 		res = squashfs_bio_read(sb, index, 2, &bio, &offset);
@@ -295,6 +296,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 
 		if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
 			res = -EIO;
+			printk("srd2 \n");
 			goto out_free_bio;
 		}
 		/* Extract the length of the metadata block */
@@ -305,6 +307,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		} else {
 			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
 				res = -EIO;
+				printk("srd3 \n");
 				goto out_free_bio;
 			}
 			data = bvec_virt(bvec);
@@ -324,6 +327,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	if (length < 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
 		res = -EIO;
+		printk("srd4: l:%d, ol: %d, bu: %d \n", length, output->length, msblk->bytes_used);
 		goto out;
 	}
 
@@ -336,10 +340,12 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 
 	if (compressed) {
 		if (!msblk->stream) {
+			printk("srd5 \n");
 			res = -EIO;
 			goto out_free_bio;
 		}
 		res = msblk->thread_ops->decompress(msblk, bio, offset, length, output);
+		printk("srd6: r: %d \n", res);
 	} else {
 		res = copy_bio_to_actor(bio, output, offset, length);
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
index aa3411354e66..e7c2ccd6a382 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -403,9 +403,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	} else
 		squashfs_i(inode)->xattr_count = 0;
 
+	printk("in: %p, fs: %d, it: %d, %s\n", inode, inode->i_size, type, __func__);
 	return 0;
 
 failed_read:
+	printk("in: %p, fs: %d, it: %d, %s\n", inode, inode->i_size, type, __func__);
 	ERROR("Unable to read inode 0x%llx\n", ino);
 	return err;
 }

