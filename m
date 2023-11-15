Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12EE7EBB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjKOCWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKOCV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:21:59 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CFC4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:21:57 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc56cc8139so4710095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700014916; x=1700619716;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn2h9Srir9IL6Wd7V3sg2WIarQ3OqfWYuKqWkBBDbWo=;
        b=u8Glx/rmchsV2TboFf7J3OXd8KFN9RpWMlgw/O7ujBBOy4HMpn1QIWZq/rI9uHZr3z
         AsW7M7o/68jOBOz/qKy3LB/KINPsSHKoLWsHp6fIW3PffsCk32/o2+dxaBnjeVsjYCwv
         Fp28p1lLhRSV+HstzvdbP5UI1HjCTwZ5GTPQlA8caa4o5OSWnLzA3ibrExooNiD4Q2u8
         sVXdBNBKbMLMmQW+fKDhl5D1boAveCAaC9ejGdbvx+S6ohRlAtAweIts08gLUTF26HMv
         /8vSMEwEKktZm0yHaq+OqsFmiVPpAg0sa+7ChYWjBS5U/rTI6ilJjG2WwTtNtF8xwKck
         bqrw==
X-Gm-Message-State: AOJu0Yy88peM42GkW/JTGd0NxgsHUkKj3aKtAVDrXTSJB7Lj0DGZ9BUK
        Lhsl9NkBvAIehF1koq0A/WYMqrXZSuinksQ8TGC/tj1YqszH9JU=
X-Google-Smtp-Source: AGHT+IHmThcOAQVTrNNpBZwmRInNRUls9bk+Aa5b+EXETfOwcV8DhFLuONGYniUALdoo2WOfCxyH5aOqeAY7vrNjJeeCIwlKkQaN
MIME-Version: 1.0
X-Received: by 2002:a17:902:e5cf:b0:1b3:f9ac:a046 with SMTP id
 u15-20020a170902e5cf00b001b3f9aca046mr1323715plf.5.1700014916582; Tue, 14 Nov
 2023 18:21:56 -0800 (PST)
Date:   Tue, 14 Nov 2023 18:21:56 -0800
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037441d060a279121@google.com>
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
index 581ce9519339..d335f28c822c 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -323,7 +323,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	}
 	if (length < 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
-		res = -EIO;
+		res = length < 0 ? -EIO : -EFBIG;
 		goto out;
 	}
 
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..5472ddd3596c 100644
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
 
+	if (!file_end)
+		return;
+
 	readahead_expand(ractl, start, (len | mask) + 1);
 
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);

