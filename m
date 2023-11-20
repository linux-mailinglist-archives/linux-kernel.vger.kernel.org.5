Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7167A7F0AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjKTDT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjKTDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:19:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBECD3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:19:49 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SYXmQ11N8zWhYP;
        Mon, 20 Nov 2023 11:19:18 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 Nov
 2023 11:19:47 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <Carson.Li1@unisoc.com>,
        <s.hauer@pengutronix.de>, <houtao1@huawei.com>,
        <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ubifs: Check @c->dirty_[n|p]n_cnt and @c->nroot state under @c->lp_mutex
Date:   Mon, 20 Nov 2023 19:13:45 +0800
Message-ID: <20231120111347.2254153-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111347.2254153-1-chengzhihao1@huawei.com>
References: <20231120111347.2254153-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checking of @c->nroot->flags and @c->dirty_[n|p]n_cnt in function
nothing_to_commit() is not atomic, which could be raced with modifying
of lpt, for example:
       P1        P2        P3
run_gc
 ubifs_garbage_collect
              do_commit
 ubifs_return_leb
  ubifs_lpt_lookup_dirty
   dirty_cow_nnode
                       do_commit
			nothing_to_commit
			 if (test_bit(DIRTY_CNODE, &c->nroot->flags)
			 // false
   test_and_set_bit(DIRTY_CNODE, &nnode->flags)
   c->dirty_nn_cnt += 1
                         ubifs_assert(c, c->dirty_nn_cnt == 0)
			 // false !

Fetch a reproducer in Link:
 UBIFS error (ubi0:0 pid 2747): ubifs_assert_failed
 UBIFS assert failed: c->dirty_pn_cnt == 0, in fs/ubifs/commit.c
 Call Trace:
  ubifs_ro_mode+0x58/0x70 [ubifs]
  ubifs_assert_failed+0x6a/0x90 [ubifs]
  do_commit+0x5b7/0x930 [ubifs]
  ubifs_run_commit+0xc6/0x1a0 [ubifs]
  ubifs_sync_fs+0xd8/0x110 [ubifs]
  sync_filesystem+0xb4/0x120
  do_syscall_64+0x6f/0x140

Fix it by checking @c->dirty_[n|p]n_cnt and @c->nroot state with
@c->lp_mutex locked.

Fixes: 944fdef52ca9 ("UBIFS: do not start the commit if there is nothing to commit")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218162
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/commit.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index c4fc1047fc07..5b3a840098b0 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -69,6 +69,14 @@ static int nothing_to_commit(struct ubifs_info *c)
 	if (c->zroot.znode && ubifs_zn_dirty(c->zroot.znode))
 		return 0;
 
+	/*
+	 * Increasing @c->dirty_pn_cnt/@c->dirty_nn_cnt and marking
+	 * nnodes/pnodes as dirty in run_gc() could race with following
+	 * checking, which leads inconsistent states between @c->nroot
+	 * and @c->dirty_pn_cnt/@c->dirty_nn_cnt, holding @c->lp_mutex
+	 * to avoid that.
+	 */
+	mutex_lock(&c->lp_mutex);
 	/*
 	 * Even though the TNC is clean, the LPT tree may have dirty nodes. For
 	 * example, this may happen if the budgeting subsystem invoked GC to
@@ -76,12 +84,15 @@ static int nothing_to_commit(struct ubifs_info *c)
 	 * free space. In this case GC would just change the lprops of this
 	 * LEB (by turning all space into free space) and unmap it.
 	 */
-	if (c->nroot && test_bit(DIRTY_CNODE, &c->nroot->flags))
+	if (c->nroot && test_bit(DIRTY_CNODE, &c->nroot->flags)) {
+		mutex_unlock(&c->lp_mutex);
 		return 0;
+	}
 
 	ubifs_assert(c, atomic_long_read(&c->dirty_zn_cnt) == 0);
 	ubifs_assert(c, c->dirty_pn_cnt == 0);
 	ubifs_assert(c, c->dirty_nn_cnt == 0);
+	mutex_unlock(&c->lp_mutex);
 
 	return 1;
 }
-- 
2.39.2

