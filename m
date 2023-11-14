Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83157EA928
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjKNDdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKNDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:33:07 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66B18F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:33:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso51897155ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699932784; x=1700537584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0LnG21HgfoseXRLmb2WFOrP2YWxh7DkZ8XFF0TX1A=;
        b=aDQsanFreAh13mqMdkDx1CeL8EeOwJzp6MDEGDrxunuZ/QYpW8KiVqjWJCVLGnPamn
         Jf9c7d9lVH8x87Sw0iigpXCld1oUOfokBusKN0M6pwydu+zca+x+PPQmGcxEAr82lSLN
         MsJ+rZJasrefbYdn4W0kdxYiTPxEfg5tG4pCaK3E7PO5U6Z0JBUzs7Qglth0IpFmnkNu
         gZA7FHbmCuUWZNNDz3TUlwimBggge75uLou7lLZdJKSZD51JwsxSs9ZZSbXoSkZvheS7
         yAU3RdO9VjXyTXjS+rqHNxNqQTpiZmk6djotoif9+GnLr4Yx/xkNx5OZN5oW+bTWdOxX
         HwQw==
X-Gm-Message-State: AOJu0YztYyxPUncuGczKNYN6iOR13twOxAaNsbMl3J+WOpE8kknJoHal
        HH+NjiRuqzlhZtpdETXhRBwueyZkgAD6Dql2mVnCDUr0agt478U=
X-Google-Smtp-Source: AGHT+IGBY8BuL4zyieCE3mRav7UcsTNpbZqOv/UNAoaJZa/vct6zcB61lflXht3xTlDzWyG9EdK/KxQ/SqwPe0wQzEIBlV8fwlV6
MIME-Version: 1.0
X-Received: by 2002:a17:902:ac8f:b0:1cc:2769:28a5 with SMTP id
 h15-20020a170902ac8f00b001cc276928a5mr318736plr.5.1699932783996; Mon, 13 Nov
 2023 19:33:03 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:33:03 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb74b9060a14717c@google.com>
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
index aa3411354e66..680d8b302e60 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -125,6 +125,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	offset = SQUASHFS_INODE_OFFSET(ino);
 
 	type = le16_to_cpu(sqshb_ino->inode_type);
+	printk("in: %p, fs: %d, it: %d, %s\n", inode, le32_to_cpu(sqsh_ino->file_size), type, __func__);
 	switch (type) {
 	case SQUASHFS_REG_TYPE: {
 		unsigned int frag_offset, frag;

