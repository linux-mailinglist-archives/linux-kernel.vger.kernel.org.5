Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938F7EA80F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKNBEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:04:47 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE43D57
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:04:44 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so4928144b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699923884; x=1700528684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB2Gj39aJe1+ysQg7fVX0jXH8R4SexdhR8CmObDPcGY=;
        b=D7OaLHjvhEaA1RqSv0SZOVxc4zlS0MOz9r4x6n2kGws2JmmL5KR+AS4q5uUMvnGQTj
         A8Oi/st5kA6KsohOLOJlYsIq/3mAlCVO8RRCYYtKgdY6Bm/uX4ovLBK8BS3BHzXt9l9J
         8Y7tDzoU+TWylE/Azub12x/pFsrT5cnhRVbvHxX/DVZpaf4WSfRHvfn55jQ8tSCwTD2L
         MTSu2TUXBTnSE52VlmXNtgcKc/46iAT6qs9y8BQTVmoMy2atsTSrLr6nGE4FxVgqRg9M
         BkD0xSoeWfdKCi4Xpvl/f4InURemzFQq7GODwC7qKKGLKkhWmIWSB9TRZDr5oQ4WBgJr
         I0ZA==
X-Gm-Message-State: AOJu0YycELCGS+uwZdraOxASow8Fp8Cko+n89oN6Lnvkdmpj5t3OqlBn
        jKJkOhtTNqN+tbuj1ouAzpXgIWojFopUYcCof6puz6DKmRWmzLY=
X-Google-Smtp-Source: AGHT+IHZZISfTEW08AkLkRl2SgHO2RMmkhOmJLZ1gpQSWoa2DowRNI1tEIMTrOJOH5Q37o5CNKvBwUN0v7YtutSu2RkqvboDl8fZ
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3027:b0:6c4:ec00:2941 with SMTP id
 ay39-20020a056a00302700b006c4ec002941mr2451130pfb.4.1699923884044; Mon, 13
 Nov 2023 17:04:44 -0800 (PST)
Date:   Mon, 13 Nov 2023 17:04:43 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000411acb060a125f72@google.com>
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

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..0a586a7f470e 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -547,6 +547,9 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	int i, file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
+	if (!file_end && !start)
+		return;
+
 	readahead_expand(ractl, start, (len | mask) + 1);
 
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index f1ccad519e28..9c167df9248d 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -35,6 +35,9 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	struct squashfs_page_actor *actor;
 	void *pageaddr;
 
+	if (!file_end)
+		return -EINVAL;
+
 	if (end_index > file_end)
 		end_index = file_end;
 

