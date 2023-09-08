Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBEF79904B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjIHTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbjIHThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:37:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32419E;
        Fri,  8 Sep 2023 12:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A66C43391;
        Fri,  8 Sep 2023 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201501;
        bh=b9nWo1DBJMfmUN0WRxx5L0ZK61Qp3jBoMn7uXGftn4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G09hlp2t7AI1sSs2sy1U2Zvyq5YbDOAMgyYVvrPP+NJfSXNK3l7++qGiK7h3ldJVO
         M+Fft7pi5WlmdSbuTfg00YNPCmsN07bAx27k3x1M69AKNir0+mJSqk0bqPM9ZoQAtO
         EcBJYdYMUklcqVM40M61zsIT7gIq7ANlAG2tDxkJekOKEGstVjj+IpR/1LkBZ2wpsS
         6DpKGwzxjl+cINBo7+k1fY9DmRuyuHSm9bocpztraLd1xNGmKPyL6kUUy0cyjOZVIu
         uRdQK6G+g2CoC47Y9A7wfwXMIL035VtAg/rGrsT5d9a5SXM+ioglUesqdpQ7rohZDs
         hEkStghqaqFvg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 34/36] blk-mq: fix tags leak when shrink nr_hw_queues
Date:   Fri,  8 Sep 2023 15:28:45 -0400
Message-Id: <20230908192848.3462476-34-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index 953f08354c8c3..d9b365c2eaa0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4402,9 +4402,13 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
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

