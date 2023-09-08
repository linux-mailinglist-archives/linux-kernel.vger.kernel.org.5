Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69AF798FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbjIHTek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjIHTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:34:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEF31FE8;
        Fri,  8 Sep 2023 12:34:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A3C433B8;
        Fri,  8 Sep 2023 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201628;
        bh=WnjuK4GWrv7imqTJ3JE3lg2r98F42KrLCH5nvnXBisA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db5uCQpSobrf99xDiBCwUEuWmdIRC/WZbTpDv6lZUAH1bT+xrAO0tRPjMXLPg/m2L
         83z+ryLxv0ANL0AEtUY6frHJA+LBx3J0YFq0M+l/Yq3J0EnU3TkRSoiiS/btaKA8mn
         DfSdtUKqzWUgfvLPKxBAv64voC2dkuyprvrFbvbWJTYHUCsVX8yD0HeGyFYSq6y11+
         v9J/ckuZ4JYbSD0rwJQWYwVTOcwPA3v7JfYXWN9koRw8uRcryPZ88HD6Uy2wUr34PQ
         jnWAzByKQi0YnpZMc7lI6YAKJpXXyF26GXn8OnYVpGwAqXOD819ewdhmXGqa2n1Siq
         i8vjoRxAloQAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 29/31] blk-mq: fix tags leak when shrink nr_hw_queues
Date:   Fri,  8 Sep 2023 15:31:58 -0400
Message-Id: <20230908193201.3462957-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit e1dd7bc93029024af5688253b0c05181d6e01f8e ]

Although we don't need to realloc set->tags[] when shrink nr_hw_queues,
we need to free them. Or these tags will be leaked.

How to reproduce:
1. mount -t configfs configfs /mnt
2. modprobe null_blk nr_devices=0 submit_queues=8
3. mkdir /mnt/nullb/nullb0
4. echo 1 > /mnt/nullb/nullb0/power
5. echo 4 > /mnt/nullb/nullb0/submit_queues
6. rmdir /mnt/nullb/nullb0

In step 4, will alloc 9 tags (8 submit queues and 1 poll queue), then
in step 5, new_nr_hw_queues = 5 (4 submit queues and 1 poll queue).
At last in step 6, only these 5 tags are freed, the other 4 tags leaked.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230821095602.70742-1-chengming.zhou@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 58bf41e8e66c7..d539b73a6be4a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4385,9 +4385,13 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				       int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
+	int i;
 
-	if (set->nr_hw_queues >= new_nr_hw_queues)
+	if (set->nr_hw_queues >= new_nr_hw_queues) {
+		for (i = new_nr_hw_queues; i < set->nr_hw_queues; i++)
+			__blk_mq_free_map_and_rqs(set, i);
 		goto done;
+	}
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
-- 
2.40.1

