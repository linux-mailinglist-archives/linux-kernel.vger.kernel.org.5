Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3811782D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjHUPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjHUPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED5D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C308061861
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65AAC433C8;
        Mon, 21 Aug 2023 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631355;
        bh=ViCdO3mKsu0rpP6MtdWLUzlowcnCJvN7GijE6W+iSaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMzRWXF/8nU1TTsBojqEhv3nqo6J7b23jvjPMJ1BJlZ4tSk1Y4dXWU2HWVLrA1j66
         Fnd1QtrOKO0xij66hBlRITK31JSzw7r3O3zgzDjFW7YV0SsJwgvzaauhPsEuLkXXzF
         9xoISvWonafD/FqlpmjhQaAC+eEUahCA7ub5DrKY9rM/XvJHQsrn0MDAgmL1bTxhj2
         WLumWWntO0YnMkmYNv6FG/Zkh83gfgmgNWY/WkLtGSOFbXg7wqPq6TSeZW9U7WVC/V
         EAswnMFwxOON9QyUkfpnfv1bH11Xt6BOi4+Y0Sz/P95Uz9FqpETvBBn/UmpGQJ/Dbb
         JzePma50DG+8w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: fix error path of f2fs_submit_page_read()
Date:   Mon, 21 Aug 2023 23:22:24 +0800
Message-Id: <20230821152225.4086924-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821152225.4086924-1-chao@kernel.org>
References: <20230821152225.4086924-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error path of f2fs_submit_page_read(), it missed to call
iostat_update_and_unbind_ctx() and free bio_post_read_ctx, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5d9697717353..916e317ac925 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1167,6 +1167,9 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		iostat_update_and_unbind_ctx(bio);
+		if (bio->bi_private)
+			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
 		bio_put(bio);
 		return -EFAULT;
 	}
-- 
2.40.1

