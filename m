Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864B980CDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjLKOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbjLKOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:14:05 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0325FFB;
        Mon, 11 Dec 2023 06:09:12 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpkBS6GNsz4f3lVH;
        Mon, 11 Dec 2023 22:09:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id B62641A0767;
        Mon, 11 Dec 2023 22:09:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxEDGHdlUaBxDQ--.22294S4;
        Mon, 11 Dec 2023 22:09:09 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
        kent.overstreet@gmail.com, joern@lazybastard.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
        konishi.ryusuke@gmail.com, willy@infradead.org,
        akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 for-6.8/block 14/18] jbd2: use bdev apis
Date:   Mon, 11 Dec 2023 22:07:44 +0800
Message-Id: <20231211140744.975145-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211140552.973290-1-yukuai1@huaweicloud.com>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxEDGHdlUaBxDQ--.22294S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DtryUur43Kr4DJr4DCFg_yoW8ZFyrpr
        yUGas8CrZFvrW8XF1kGF4kJrWjga40vayUCFnF93Z2yw4Svr1avw18Kr13GFyYvFWFga1U
        Xr1jyay8Kw4YgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_JFI_Gr1lIxAIcVC2z280aVAFwI0_
        Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUb
        ZNVDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Avoid to access bd_inode directly, prepare to remove bd_inode from
block_devcie.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/jbd2/journal.c  | 3 +--
 fs/jbd2/recovery.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ed53188472f9..f1b5ffeaf02a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2003,8 +2003,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		byte_count = (block_stop - block_start + 1) *
 				journal->j_blocksize;
 
-		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
-				byte_start, byte_stop);
+		truncate_bdev_range(journal->j_dev, 0, byte_start, byte_stop);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
 			err = blkdev_issue_discard(journal->j_dev,
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 01f744cb97a4..6b6a2c4585fa 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -290,7 +290,6 @@ int jbd2_journal_recover(journal_t *journal)
 
 	struct recovery_info	info;
 	errseq_t		wb_err;
-	struct address_space	*mapping;
 
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
@@ -309,8 +308,7 @@ int jbd2_journal_recover(journal_t *journal)
 	}
 
 	wb_err = 0;
-	mapping = journal->j_fs_dev->bd_inode->i_mapping;
-	errseq_check_and_advance(&mapping->wb_err, &wb_err);
+	bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -334,7 +332,7 @@ int jbd2_journal_recover(journal_t *journal)
 	err2 = sync_blockdev(journal->j_fs_dev);
 	if (!err)
 		err = err2;
-	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
+	err2 = bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
 	if (!err)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
-- 
2.39.2

