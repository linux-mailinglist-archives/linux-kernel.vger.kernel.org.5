Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C97EA954
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjKNEGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKNEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:06:11 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2031A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:06:08 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc385e90e2so53224005ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699934768; x=1700539568;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lOAWyANnk6qBk5R5NezK6vdjso9mZKLI7KGGcXdX7k=;
        b=JQg0zRFQwe48/oGKBd0cBxdX4UY4FStSXB2JbF0CD9+xq1EsIKCWxzZ98nV7o9GXZs
         OidXeZPIJdGWaqz/P5nBRC1aj8gEzrVhVKsMvb3BbNLxA7x7auya1GUV/AMboD9G8XTR
         NrJtpJNhZQcM9aZH/aNllRsW9ldKcffL/VEKBTpYjzj+B4XBYDgp+wSIdQUhVDQHWUHQ
         QHJiEh1I4oicpphwaaTPQcH0LiyYRJgigCDBxgrUSly9vMiJAjcRs0Gg2YKODbpQXJBZ
         ZAu74N3/bvefrGiVSzv3wwFfN1MqvZoIdMaS2H4d8cx/A2ZXm0/iDOtRrRxM0A/w1XRS
         MOKQ==
X-Gm-Message-State: AOJu0Ywn1YFd77RdIlvWD4eLKJHENYVg/iB7QoP091+o2DAX7OIjH50o
        tdkPZ9q/De02zzEkg0fBzWH3MjIwYc9kLLo6mjzU8OWMU4VQCDY=
X-Google-Smtp-Source: AGHT+IGuoKINpfjIWcuC/7YUwz2qb315ewSPkls9LoAxn/349/dh+KZxNRxGeXal7/f5KXUAPnMSfZ+NtG4/v/WLQbiwMzqW/Pd3
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4d2:b0:1cc:408e:1b19 with SMTP id
 o18-20020a170902d4d200b001cc408e1b19mr381162plg.1.1699934768406; Mon, 13 Nov
 2023 20:06:08 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:06:08 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000328cc060a14e823@google.com>
Subject: Re: [syzbot] [PATCH] Test oob in squashfs readahead
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

