Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D737A77BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjITJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:40:09 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D91AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:40:02 -0700 (PDT)
X-QQ-mid: bizesmtp74t1695202772tn02677e
Received: from [10.23.230.53] ( [121.46.247.130])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Sep 2023 17:38:50 +0800 (CST)
X-QQ-SSF: 01400000000000101000000A0000000
X-QQ-FEAT: vrqOr+ppv0sOrG/PUzmadjlzcJfWoUqZsFhBWAm5zn1sikR/Q/rd4MGQJXch0
        cuoSfOXHIBii+lU45P553185ZJk8s7C6HwrhMjnhpImBMzsZ+KT6DTBYTUH7MS+ftXfZPIM
        tZ5MW5OUVUwOKcE1PajYjUC+5eQVTQHHmzZkpU6fdu1fXOsyi1Oe86QOrt9sm0fP+8+Ti/d
        giXrZ7BRYEwW0dP0yJapC40qVmQz7KpyWa6tuL81KiBzBlKcLTY/ONaTPfBxBQhV2xAO4kq
        NVPBN3grP/71hu0vf5sh5DzKt8W75N6kEgezJ90Mf6OtgPd1WV5D+EHSukSl55Vbhi8TVJw
        sYvrIYIzXO/C5w815zRkkRSc9YbplMReWY10q9EzP/A2h6HcEi1GtmSKi6iYw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17908884623268010789
Message-ID: <181C946095F0252B+7cc60eca-1abf-4502-aad3-ffd8ef89d910@ex.bilibili.com>
Date:   Wed, 20 Sep 2023 17:38:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   liwenyu <wenyuli@ex.bilibili.com>
Subject: [PATCH] delayacct: add memory reclaim delay in get_page_from_freelist
Organization: bilibili
To:     akpm@linux-foundation.org
Cc:     bsingharora@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangyun@bilibili.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ex.bilibili.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current memory reclaim delay statistics only count the direct memory
reclaim of the task in do_try_to_free_pages(). In systems with NUMA
open, some tasks occasionally experience slower response times, but the
total count of reclaim does not increase, using ftrace can show that
node_reclaim has occurred.

The memory reclaim occurring in get_page_from_freelist() is also due to
heavy memory load. To get the impact of tasks in memory reclaim, this
patch adds the statistics of the memory reclaim delay statistics for
__node_reclaim().

Signed-off-by: Wen Yu Li <wenyuli@ex.bilibili.com>
---
  mm/vmscan.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..88be3dedc584 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -8026,6 +8026,7 @@ static int __node_reclaim(struct pglist_data 
*pgdat, gfp_t gfp_mask, unsigned in

  	cond_resched();
  	psi_memstall_enter(&pflags);
+	delayacct_freepages_start();
  	fs_reclaim_acquire(sc.gfp_mask);
  	/*
  	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
@@ -8048,6 +8049,7 @@ static int __node_reclaim(struct pglist_data 
*pgdat, gfp_t gfp_mask, unsigned in
  	memalloc_noreclaim_restore(noreclaim_flag);
  	fs_reclaim_release(sc.gfp_mask);
  	psi_memstall_leave(&pflags);
+	delayacct_freepages_end();

  	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);

-- 
2.30.2

