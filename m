Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5CF7E9A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjKMLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjKMLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:00:34 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C410D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:00:31 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28016806be2so5263184a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699873231; x=1700478031;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nurGn4++F4CxaCRHpLPUpX0XmLm4g0gqNDAXT8uNP4k=;
        b=vUE3bDsmys+cHIqGBEeji+BhXkAOBnWS9Sj2LR4ozklK7arTmw7/12q1YV7q9EVmfi
         vs6HmV960JWbd8KFmUjcGfKPDnbGGRF3MlAFsnkceohQrcc29nUjbCshDVUTvmX7Elwz
         ViiWuIlJsgsd5jctJlPIP1fCVdODRFfmgDIMYZtWNGfVS9EMIhNstk5+wXrVKgD/BbD+
         JBu43OLUjcakCDKgca/W87m0duCTuoteXCsQTU/lQP7fDw4/H8yB40bl4+B6Jououow0
         7xNeGHO8Sar0NEogDGIQF83XwJcN8rzd3AiqiWx8/3WzDRfNQksugDFHP3KJfkq6MCeh
         AaqA==
X-Gm-Message-State: AOJu0YxO8C0jzcBzritsQ+c0ZRy3Rwd8g0tAPEod5v9bAtwm/trB79sE
        r3jJWH/Ptbm7SeF4NpoclZiG1pp/1Sex4LNiYpMFBKWXl06ybTg=
X-Google-Smtp-Source: AGHT+IGbzcFfYX7bbCHDle8+OruXULi0uV5DEkYXrCf+B13BPLAoak4Kk6vx+RpXRBbLq6y2e5tFFmJEMYiW+qwpVcS/6QrEeHJH
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2291:b0:280:47ba:7685 with SMTP id
 kx17-20020a17090b229100b0028047ba7685mr2879315pjb.0.1699873230916; Mon, 13
 Nov 2023 03:00:30 -0800 (PST)
Date:   Mon, 13 Nov 2023 03:00:30 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000179181060a069430@google.com>
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

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..c91a37be5589 100644
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
 
+		printk("p: %p, mp: %d, e: %d, idx: %d, s: %d, %s\n", pages, max_pages,
+				expected, pages[0]->index, start, __func__);
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

