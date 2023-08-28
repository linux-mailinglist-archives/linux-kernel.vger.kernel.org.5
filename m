Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9F78B28E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjH1OEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjH1OE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC144120
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF64648DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4154C433CB;
        Mon, 28 Aug 2023 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693231463;
        bh=iMUwEr3cAOvCDFXTWkzjICy1zMedGFdUbOmrXAATAhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hW/aG0Oji4GfBL0hMAOlVKlK3cBo764WQfMEm5/m0WntAIfw2U4t+mRSJrVHHEN2j
         yF1Gc9O0cGAkY9QIuszue5QA6wg9Au+ModHq2sGhpWLodh7cg9BtBnKIg4irpDcYD3
         bKQhkawQ0Sob5HncKBs779zvX7ueuu4naDv1pD4+6sjHAuIRkj1kpZzLlbI/89pSFp
         oBrFbq4udXp/uxRpZcRvs2hc8mC6lNwJKJke5+Vso3ZzPloRlQ/jc7W9+LvnssX9pT
         zJLSwZyDolZiCuFlEC7C0uYeT8fj2VXf44ML7/4yTLPLw83rxFbC0oiTwtT4iQhHnd
         AQFixBkAQjVZg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: compress: fix to avoid use-after-free on dic
Date:   Mon, 28 Aug 2023 22:04:15 +0800
Message-Id: <20230828140417.2951796-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828140417.2951796-1-chao@kernel.org>
References: <20230828140417.2951796-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call trace:
 __memcpy+0x128/0x250
 f2fs_read_multi_pages+0x940/0xf7c
 f2fs_mpage_readpages+0x5a8/0x624
 f2fs_readahead+0x5c/0x110
 page_cache_ra_unbounded+0x1b8/0x590
 do_sync_mmap_readahead+0x1dc/0x2e4
 filemap_fault+0x254/0xa8c
 f2fs_filemap_fault+0x2c/0x104
 __do_fault+0x7c/0x238
 do_handle_mm_fault+0x11bc/0x2d14
 do_mem_abort+0x3a8/0x1004
 el0_da+0x3c/0xa0
 el0t_64_sync_handler+0xc4/0xec
 el0t_64_sync+0x1b4/0x1b8

In f2fs_read_multi_pages(), once f2fs_decompress_cluster() was called if
we hit cached page in compress_inode's cache, dic may be released, it needs
break the loop rather than continuing it, in order to avoid accessing
invalid dic pointer.

Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed blocks")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f33e14dc7f8..1ac34eb49a0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2344,8 +2344,10 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
 		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
-			if (atomic_dec_and_test(&dic->remaining_pages))
+			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic, true);
+				break;
+			}
 			continue;
 		}
 
-- 
2.40.1

