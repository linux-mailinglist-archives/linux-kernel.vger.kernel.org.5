Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4037EA76F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjKNAWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNAWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:22:49 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FBD55
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:22:47 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bdbd1e852dso5934397a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699921366; x=1700526166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZXkQmXxs9uLoWmPwbfBonw96/b5rk+ItiuC8yaL3uw=;
        b=VBSG9+EAf24gtub9gZ9alqUwDssqg7O+ydmXTj5Gh2dd4r8FJ0BSHAsHXUse77ogdf
         xAA/mI0O39bxYlqdIzRfrOTqRLmBZnst/bGI51pD16yxVKnLKCj47VZw57BQMXBLWOWw
         U0ko/ulRnqbg1TPu/D8v1JF6R3kKld201BPTx1gxnK4pN+lQpzmSfZi/mIiv5DcaDr5B
         12gekI8zZuAAszpVmcA0JWqiGUWE2odkPs3UQzbJQI3377RXnqBIWOST8YAgYYyhvbaA
         1SPl5X9wgQHj6Y8+cwzSpW/pn9A9m2tMtMotPXvCz8QYZdTkkJ/3de3ZM73WzFh6FDc8
         jhpQ==
X-Gm-Message-State: AOJu0Yz8gZLIRNEU0bdX0mtI8Epk2AepK375gI2A6njfJx574BXXKZbj
        djUwYrVYBAQM+eP0c2ySk6S66DMyy5chwc77v2gLuqjDQpiAfUI=
X-Google-Smtp-Source: AGHT+IFNH7ffKoAVkF9Y/Te3aRPho1BUZKdpE56f36mFQGzHMMq1YfU2ugRHiV02TTiRN3mDeHI0ILBq1vDKQ7z3pGkKtKOyVMjU
MIME-Version: 1.0
X-Received: by 2002:a63:f54e:0:b0:5bd:d3f7:5192 with SMTP id
 e14-20020a63f54e000000b005bdd3f75192mr155049pgk.6.1699921366345; Mon, 13 Nov
 2023 16:22:46 -0800 (PST)
Date:   Mon, 13 Nov 2023 16:22:46 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000308657060a11c90b@google.com>
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
index 8ba8c4c50770..cb3753782d85 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -566,6 +566,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		max_pages = (expected + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
+		if (!max_pages)
+			break;
 		nr_pages = __readahead_batch(ractl, pages, max_pages);
 		if (!nr_pages)
 			break;

