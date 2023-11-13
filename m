Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4827E9BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjKMMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKMMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:10:47 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD6D75
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:10:44 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b7dfda133dso3861682a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699877444; x=1700482244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bMAkJl1EeK0/SJE7D1xym8LHwFYj+jKelRKIgovb3U=;
        b=bn9CiIA9hlky1nvw8J0aAhE5lr+xwWZ4b17F4w2mTMwqqpwie/HBGvypyn8lV3XsUz
         IieXYi2InnyHg9qyD21Po1adfYgmBdEAIuxyd8lxU5YZTXqO8InGFCE3OAE7a1NFfpou
         v/qJT00TIXYVXXf1q6xRkwU3enHaXRdhFArGDxJDTXLc7ENjWeNpUy6RCnHnwJVy2vfq
         AXwas4qNs6cMTv3iFC2AzvC28N3T/p8h0bh25/MroeuS4kXN+1IBwiEP6EKGbCXLJtLp
         8fepen9CRCOIBxNIXugos0dXI2iGz3hid+pMkJDxzHw94PxTxPJzCsvz+24N8BD5F9fB
         oVdw==
X-Gm-Message-State: AOJu0Ywc6HJtRqLP6g8j+9f6rwUUJ2LaNYv2++nRb7hpOAsWnGRB9xDX
        0uZXoS+8vfsPu4L7yHgKgEIRoHk/9mNHqH7IQm+GL20vOGyq2Jc=
X-Google-Smtp-Source: AGHT+IELclRzs++Gy3P6hvvghIGx8xzhfDWVPkNisTjgxdmjwz4N66+pTiTQQMGjeA41iUZsYKrSlkNViI+AxgUvtf4xPeIcZWi+
MIME-Version: 1.0
X-Received: by 2002:a65:6212:0:b0:5ac:26f:db7c with SMTP id
 d18-20020a656212000000b005ac026fdb7cmr1735464pgv.8.1699877444101; Mon, 13 Nov
 2023 04:10:44 -0800 (PST)
Date:   Mon, 13 Nov 2023 04:10:43 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037ae74060a078f99@google.com>
Subject: Re: [syzbot] [PATCH] Test oob in squashfs readahead
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index 8ba8c4c50770..a60c2be4447e 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -553,6 +553,9 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	if (!pages)
 		return;
 
+	printk("p: %p, bs: %d, bl: %d, mp: %d, start: %d, fe: %d, %s\n", 
+			pages, msblk->block_size, msblk->block_log,
+			max_pages, start, file_end, __func__);
 	for (;;) {
 		pgoff_t index;
 		int res, bsize;
@@ -566,6 +569,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		max_pages = (expected + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
+		printk("p: %p, mp: %d, e: %d,isr: %d, start: %d, %s\n", pages, max_pages,
+				expected, i_size_read(inode), start, __func__);
 		nr_pages = __readahead_batch(ractl, pages, max_pages);
 		if (!nr_pages)
 			break;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 22e812808e5c..aad49a62b5ce 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -275,6 +275,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (msblk->block_log > SQUASHFS_FILE_MAX_LOG)
 		goto failed_mount;
 
+	printk("bs: %d, bl: %d, %s\n", msblk->block_size, msblk->block_log, __func__);
+
 	/* Check that block_size and block_log match */
 	if (msblk->block_size != (1 << msblk->block_log))
 		goto insanity;

