Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B237EA87B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKNBz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjKNBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:55:26 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB6ED48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:55:23 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5bd26ef66d1so6057581a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699926922; x=1700531722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eDeeli0lZRhE0xtdMIwASfur6FEX6A3C1Zgm8x0Ad0=;
        b=lrPiSyd3LsIkhPWg57S5xjU3hrOaFpm1ICTuCamjUGOpFWNO7axXKHO7eiL7hYJEOV
         DAj8tuW6zP+ee1HCUr3vPLhB2Kxc2/LwyAOHETO0gRbXPC4/mGYB1jimpZM1vDFoUpRr
         JBC+jBzd2HMF3s6pb15Quy5jXAciL/ZTg5LsG4MvFBntipYy+JRWko2cz7oiPIeHxXfG
         UkERzn0Y4ArIKuk77a6X1yJb49OyrvC4IrWLvUhOuZ7hgUDCkPC7YpfY9ri+U8qW8I9a
         oE2nTvc4HMXDAXr9HZr93IKWIPJZl+1M1w4Rq4iqcLpc7vbBEisaaapS2vQB1llNIGYc
         RHow==
X-Gm-Message-State: AOJu0Yw4j+EBKm6WC01DOlC7VC98c58i/Xk6TqWPPFLawwP8i1rDgUx2
        EjxGhzN+rM0+IyXkv4ooP6s2MmehbjDk2TJibsfgJl29VuNtZ98=
X-Google-Smtp-Source: AGHT+IEmfN6cS/dFMTqofzj0pqQfMV4Y546sHi8ui4q4Bhb3ijEVDCkY+dYucbX4Ob3u/mtI5WZugKFRi8UyVAgi3nF4T7kL1Vi7
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:90b:b0:5b9:803b:1fbc with SMTP id
 ck11-20020a056a02090b00b005b9803b1fbcmr182745pgb.12.1699926922605; Mon, 13
 Nov 2023 17:55:22 -0800 (PST)
Date:   Mon, 13 Nov 2023 17:55:22 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dbe53060a1314ba@google.com>
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
index 8ba8c4c50770..e6dc2a5a8bcd 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -461,6 +461,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
 				page->index, squashfs_i(inode)->start);
 
+	if (!file_end) {
+		res = -EINVAL;
+		goto out;
+	}
+
 	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
@@ -547,6 +552,9 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	int i, file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
+	if (!file_end && !start)
+		return;
+
 	readahead_expand(ractl, start, (len | mask) + 1);
 
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);

