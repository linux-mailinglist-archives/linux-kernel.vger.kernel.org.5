Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1D7FC83D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376407AbjK1VLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376381AbjK1VKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177704211
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390FAC43391;
        Tue, 28 Nov 2023 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205686;
        bh=yFXeZFzrBMhAgfi/v3PgoyaosZfMWqxXdzBpoTYJsks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP6HR+FPIAS7ZSgkJqFMCewPalc3qz2lhJA7FZOs8f1xGZu11GEWfJg8TvMWcRy20
         gHbyXwZs98Nkh+2cMEd3IeiLx3aIpWJowIs51gq1mMwgnL2Nxl6SIFIHigEYYVQfMd
         BTF44+lgNL0mgu8Na00ZdbEWYMTf9oKRA/2KvFI+UknFhMNNLvV8jcRl4JW2mz0TZK
         7UiOLRSjjMSk63S2zNBZg0STZn5uE9Hn6fpz9YP9luCsFlWiEqmU7KxgHnHhkFqBL7
         V11HSw/72DZHHrgj2RU0sQygr5/4Qa/zKbnhL6uNhsK2w/9oFmsciqTcQyqxD0VUCx
         YKAASNP2iY9yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.i.king@gmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        kent.overstreet@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-bcache@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 07/25] bcache: remove redundant assignment to variable cur_idx
Date:   Tue, 28 Nov 2023 16:07:23 -0500
Message-ID: <20231128210750.875945-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit
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
index 7bac2a88b794a..e6d77aaea56bc 100644
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

