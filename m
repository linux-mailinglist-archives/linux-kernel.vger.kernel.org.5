Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3678A042
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjH0Qud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjH0QuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:50:01 -0400
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0CAFA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:49:57 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 27 Aug
 2023 19:49:54 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 27 Aug
 2023 19:49:54 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com>
Subject: [PATCH] fs: ntfs3: fix possible NULL-ptr-deref in ni_readpage_cmpr()
Date:   Sun, 27 Aug 2023 09:49:44 -0700
Message-ID: <20230827164944.52560-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller identified a possible issue with calling unlock_page() for
pages that have not been correctly allocated by
find_or_create_page(), leading to possible NULL pointer dereferences
among other issues.

Specifically, in case of an error with aforementioned
find_or_create_page() function due to memory issues,
ni_readpage_cmpr() attempts to erroneously unlock and release all
elements of 'pages'.

This patch ensures that we only deal with the pages successfully
allocated with calls to find_or_create_page().

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 fs/ntfs3/frecord.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16bd9faa2d28..9789b2ac7e2d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2095,7 +2095,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	struct page **pages = NULL; /* Array of at most 16 pages. stack? */
 	u8 frame_bits;
 	CLST frame;
-	u32 i, idx, frame_size, pages_per_frame;
+	u32 i, idx, frame_size, pages_per_frame, pages_created = 0;
 	gfp_t gfp_mask;
 	struct page *pg;
 
@@ -2138,6 +2138,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 			goto out1;
 		}
 		pages[i] = pg;
+		pages_created++;
 	}
 
 	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame);
@@ -2146,7 +2147,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	if (err)
 		SetPageError(page);
 
-	for (i = 0; i < pages_per_frame; i++) {
+	for (i = 0; i < pages_created; i++) {
 		pg = pages[i];
 		if (i == idx)
 			continue;
-- 
2.25.1

