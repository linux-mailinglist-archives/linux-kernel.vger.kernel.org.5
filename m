Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BD80BA60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjLJLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:35:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12620FA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:36:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E864C433C9;
        Sun, 10 Dec 2023 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208161;
        bh=dLds5jvPY7Yl05BDqmaObZ0ySYYRFXngO3CypVRgnUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0r5UZOClT+qxOhTdmYQ5XIChARJWxNgHecNvTNmjAykLquVh3aAgFAyVWKqs2xep
         qZREYMfFsuYh0dUfNi9MHVzHXWebCXChp9SK6Bjbc20Y8MSlastnbfp3NIJF/6s5Cx
         KAxkucpK0lghl+M4lfsuwHNlpRYHfo14s6Z/OMF7Ld/ewODQSRj0sBvPw3lfXk+riR
         wizq5S8I54LwWIrKPmNy3ZcJlpE6KTcZ8M/77szdlhGFcTOtmeEZoblhMNagdh9KdM
         W3SwghyJX35n9dRggoyvpJS9YhzTpPa8PGq3Exvx/H48b6W1pGCOrwjVZ83ZbmJvvC
         9UdldAVXXF8Hg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/6] f2fs: fix to wait on block writeback for post_read case
Date:   Sun, 10 Dec 2023 19:35:43 +0800
Message-Id: <20231210113547.3412782-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If inode is compressed, but not encrypted, it missed to call
f2fs_wait_on_block_writeback() to wait for GCed page writeback
in IPU write path.

Thread A				GC-Thread
					- f2fs_gc
					 - do_garbage_collect
					  - gc_data_segment
					   - move_data_block
					    - f2fs_submit_page_write
					     migrate normal cluster's block via
					     meta_inode's page cache
- f2fs_write_single_data_page
 - f2fs_do_write_data_page
  - f2fs_inplace_write_data
   - f2fs_submit_page_bio

IRQ
- f2fs_read_end_io
					IRQ
					old data overrides new data due to
					out-of-order GC and common IO.
					- f2fs_read_end_io

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 27015b7875ae..dce8defdf4c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2556,9 +2556,6 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 
 	page = fio->compressed_page ? fio->compressed_page : fio->page;
 
-	/* wait for GCed page writeback via META_MAPPING */
-	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
-
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return 0;
 
@@ -2745,6 +2742,10 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 	}
 
+	/* wait for GCed page writeback via META_MAPPING */
+	if (fio->post_read)
+		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
+
 	/*
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
-- 
2.40.1

