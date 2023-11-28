Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E497FC863
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbjK1VGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376320AbjK1VGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554261BC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D266BC433CB;
        Tue, 28 Nov 2023 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205594;
        bh=2rhaJ0HB8GuEVIPSqohYD64j1QFkH4NYFmviT6cUuCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs1hUyiuwXOqPwB7fodgDLUW/na3yIWw4AvVZQuqfvACFlEThVDiyYtVjj+wsqmIn
         6HUlFDVKOVs3P83Kzg1OJhjEhiJT4fV1cxEssmJKqHNDPEKBnTUwsJsj1Yb1biO173
         LCO6FBWA07e9YzCiZRs49PZ3vJG1tDANI6+jwQqLEjl/ed4heXA2zq3MyrZX9ZTC/S
         AEBu/E0MjyyYZ6vgXnyV3U9cFykhKC+39GJjpBS8kx/dZL+BiAQPFCL3YMA9/70Oaq
         E43l5W0GJtoC4kJEHM1fRveplAbgIh1wlPEQsHOr0GR5ngDDHCYuxAz5aqLVzRTjgd
         /jNBSZ8JB06iw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.i.king@gmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        kent.overstreet@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-bcache@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 08/40] bcache: remove redundant assignment to variable cur_idx
Date:   Tue, 28 Nov 2023 16:05:14 -0500
Message-ID: <20231128210615.875085-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit be93825f0e6428c2d3f03a6e4d447dc48d33d7ff ]

Variable cur_idx is being initialized with a value that is never read,
it is being re-assigned later in a while-loop. Remove the redundant
assignment. Cleans up clang scan build warning:

drivers/md/bcache/writeback.c:916:2: warning: Value stored to 'cur_idx'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20231120052503.6122-4-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 24c049067f61a..c3e872e0a6f2c 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -913,7 +913,7 @@ static int bch_dirty_init_thread(void *arg)
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
-	cur_idx = prev_idx = 0;
+	prev_idx = 0;
 
 	bch_btree_iter_init(&c->root->keys, &iter, NULL);
 	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
-- 
2.42.0

