Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B297F0AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjKTDUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjKTDT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:19:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758513E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:19:51 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SYXj26WJTzsRH6;
        Mon, 20 Nov 2023 11:16:22 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 Nov
 2023 11:19:48 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <Carson.Li1@unisoc.com>,
        <s.hauer@pengutronix.de>, <houtao1@huawei.com>,
        <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ubifs: Don't stop retrying even if committing times exceeds two
Date:   Mon, 20 Nov 2023 19:13:47 +0800
Message-ID: <20231120111347.2254153-4-chengzhihao1@huawei.com>
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we catched ENOSPC returned by make_reservation() while doing
fsstress on UBIFS, we got following information when it occurred (See
details in Link):

 UBIFS error (ubi0:0 pid 3640152): make_reservation [ubifs]: cannot
 reserve 112 bytes in jhead 2, error -28
 CPU: 2 PID: 3640152 Comm: kworker/u16:2 Tainted: G    B   W
 Hardware name: Hisilicon PhosphorHi1230 EMU (DT)
 Workqueue: writeback wb_workfn (flush-ubifs_0_0)
 Call trace:
  dump_stack+0x114/0x198
  make_reservation+0x564/0x610 [ubifs]
  ubifs_jnl_write_data+0x328/0x48c [ubifs]
  do_writepage+0x2a8/0x3e4 [ubifs]
  ubifs_writepage+0x16c/0x374 [ubifs]
  generic_writepages+0xb4/0x114
  do_writepages+0xcc/0x11c
  writeback_sb_inodes+0x2d0/0x564
  wb_writeback+0x20c/0x2b4
  wb_workfn+0x404/0x510
  process_one_work+0x304/0x4ac
  worker_thread+0x31c/0x4e4
  kthread+0x23c/0x290
 (pid 3640152) Budgeting info: data budget sum 17576, total budget sum 17768
	budg_data_growth 4144, budg_dd_growth 13432, budg_idx_growth 192
	min_idx_lebs 13, old_idx_sz 988640, uncommitted_idx 0
	page_budget 4144, inode_budget 160, dent_budget 312
	nospace 0, nospace_rp 0
	dark_wm 8192, dead_wm 4096, max_idx_node_sz 192
	freeable_cnt 0, calc_idx_sz 988640, idx_gc_cnt 0
	dirty_pg_cnt 4, dirty_zn_cnt 0, clean_zn_cnt 4811
	gc_lnum 21, ihead_lnum 14
	jhead 0 (GC)	 LEB 16
	jhead 1 (base)	 LEB 34
	jhead 2 (data)	 LEB 23
	bud LEB 16
	bud LEB 23
	bud LEB 34
	old bud LEB 33
	old bud LEB 31
	old bud LEB 15
	commit state 4
 Budgeting predictions:
	available: 33832, outstanding 17576, free 15356
 (pid 3640152) start dumping LEB properties
 (pid 3640152) Lprops statistics: empty_lebs 3, idx_lebs  11
	taken_empty_lebs 1, total_free 1253376, total_dirty 2445736
	total_used 3438712, total_dark 65536, total_dead 17248
 LEB 15 free 0      dirty 248000   used 5952   (taken)
 LEB 16 free 110592 dirty 896      used 142464 (taken, jhead 0 (GC))
 LEB 21 free 253952 dirty 0        used 0      (taken, GC LEB)
 LEB 23 free 0      dirty 248104   used 5848   (taken, jhead 2 (data))
 LEB 29 free 253952 dirty 0        used 0      (empty)
 LEB 33 free 0      dirty 253952   used 0      (taken)
 LEB 34 free 217088 dirty 36544    used 320    (taken, jhead 1 (base))
 LEB 37 free 253952 dirty 0        used 0      (empty)
 OTHERS: index lebs, zero-available non-index lebs

According to the budget algorithm, there are 5 LEBs reserved for budget:
three journal heads(16,23,34), 1 GC LEB(21) and 1 deletion LEB(can be
used in make_reservation()). There are 2 empty LEBs used for index nodes,
which is calculated as min_idx_lebs - idx_lebs = 2. In theory, LEB 15
and 33 should be reclaimed as free state after committing, but it is now
in taken state. After looking the realization of reserve_space(), there's
a possible situation:

LEB 15: free 2000 dirty 248000 used 3952 (jhead 2)
LEB 23: free 2000 dirty 248104 used 3848 (bud, taken)
LEB 33: free 2000 dirty 251952 used 0    (bud, taken)

      wb_workfn          wb_workfn_2
do_writepage // write 3000 bytes
 ubifs_jnl_write_data
  make_reservation
   reserve_space
    ubifs_garbage_collect
     ubifs_find_dirty_leb // ret ENOSPC, dirty LEBs are taken
   nospc_retries++  // 1
   ubifs_run_commit
    do_commit

LEB 15: free 2000 dirty 248000 used 3952 (jhead 2)
LEB 23: free 2000 dirty 248104 used 3848 (dirty)
LEB 33: free 2000 dirty 251952 used 0    (dirty)

                   do_writepage // write 2000 bytes for 3 times
		    ubifs_jnl_write_data
		    // grabs 15\23\33

LEB 15: free 0    dirty 248000 used 5952 (bud, taken)
LEB 23: free 0    dirty 248104 used 5848 (jhead 2)
LEB 33: free 0    dirty 253952 used 0    (bud, taken)

   reserve_space
    ubifs_garbage_collect
     ubifs_find_dirty_leb // ret ENOSPC, dirty LEBs are taken
   if (nospc_retries++ < 2) // false
 ubifs_ro_mode !

Fetch a reproducer in Link.

The dirty LEBs could be grabbed by other writeback threads, which fails
finding dirty LEBs of GC in current thread, so make_reservation() should
try many times to invoke GC&&committing, but current realization limits
the times of retrying as 'nospc_retries'(twice). Actually the limitation
of retrying times should be removed from make_reservation(), but
considering the existence of 'cmt_retries' in case of infinite loop,
just remove 'nospc_retries' and set the limitation of retrying times same
as 'cmt_retries'.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218164
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/journal.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index f0a5538c84b0..ec42d42f06dc 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -310,7 +310,7 @@ static int write_head(struct ubifs_info *c, int jhead, void *buf, int len,
  */
 static int make_reservation(struct ubifs_info *c, int jhead, int len)
 {
-	int err, cmt_retries = 0, nospc_retries = 0;
+	int err, cmt_retries = 0;
 
 again:
 	down_read(&c->commit_sem);
@@ -323,21 +323,14 @@ static int make_reservation(struct ubifs_info *c, int jhead, int len)
 	if (err == -ENOSPC) {
 		/*
 		 * GC could not make any progress. We should try to commit
-		 * once because it could make some dirty space and GC would
-		 * make progress, so make the error -EAGAIN so that the below
-		 * will commit and re-try.
-		 */
-		if (nospc_retries++ < 2) {
-			dbg_jnl("no space, retry");
-			err = -EAGAIN;
-		}
-
-		/*
-		 * This means that the budgeting is incorrect. We always have
-		 * to be able to write to the media, because all operations are
-		 * budgeted. Deletions are not budgeted, though, but we reserve
-		 * an extra LEB for them.
+		 * because it could make some dirty space and GC would make
+		 * progress, so that the below will commit and re-try. This
+		 * process could repeat many times(cmt_retries < 128),
+		 * journal heads in other threads could grab the dirty lebs,
+		 * which fails finding dirty LEBs of GC in current thread.
 		 */
+		dbg_jnl("no space, retry");
+		err = -EAGAIN;
 	}
 
 	if (err != -EAGAIN)
@@ -350,7 +343,8 @@ static int make_reservation(struct ubifs_info *c, int jhead, int len)
 	if (cmt_retries > 128) {
 		/*
 		 * This should not happen unless the journal size limitations
-		 * are too tough.
+		 * are too tough, or the racing between GC and journal heads
+		 * switching is too frequent when space is nearly run out.
 		 */
 		ubifs_err(c, "stuck in space allocation");
 		err = -ENOSPC;
-- 
2.39.2

