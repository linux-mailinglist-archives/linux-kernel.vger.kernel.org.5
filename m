Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BC802BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjLDHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjLDHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:04:25 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF9D5;
        Sun,  3 Dec 2023 23:04:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkF5g51Crz4f3lgC;
        Mon,  4 Dec 2023 15:04:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 5A9AA1A0E29;
        Mon,  4 Dec 2023 15:04:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hD5eW1lTQvKCg--.62157S6;
        Mon, 04 Dec 2023 15:04:28 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/2] md/raid1: support read error check
Date:   Mon,  4 Dec 2023 15:03:27 +0800
Message-Id: <20231204070327.3150356-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204070327.3150356-1-linan666@huaweicloud.com>
References: <20231204070327.3150356-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hD5eW1lTQvKCg--.62157S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kZF13uF17JryxGF17Wrg_yoW8Aw4kpa
        15AF95ArW5J345Zw1DJFWDC3WFk34fKay8Ar95Jw4Ig3s3trZ8KFWjga4agrn8GFn8Gr13
        X398Gr4DCFs7tFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU89L05UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

After commit 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable
read errors."), rdev will be set to faulty if it reads data error to many
times in raid10. Add this mechanism to raid1 now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 9348f1709512..be4e654744c1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2257,16 +2257,24 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
  *	3.	Performs writes following reads for array synchronising.
  */
 
-static void fix_read_error(struct r1conf *conf, int read_disk,
-			   sector_t sect, int sectors)
+static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
+	sector_t sect = r1_bio->sector;
+	int sectors = r1_bio->sectors;
+	int read_disk = r1_bio->read_disk;
 	struct mddev *mddev = conf->mddev;
+	struct md_rdev *rdev = rcu_dereference(conf->mirrors[read_disk].rdev);
+
+	if (exceed_read_errors(mddev, rdev)) {
+		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
+		return;
+	}
+
 	while(sectors) {
 		int s = sectors;
 		int d = read_disk;
 		int success = 0;
 		int start;
-		struct md_rdev *rdev;
 
 		if (s > (PAGE_SIZE>>9))
 			s = PAGE_SIZE >> 9;
@@ -2507,8 +2515,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	if (mddev->ro == 0
 	    && !test_bit(FailFast, &rdev->flags)) {
 		freeze_array(conf, 1);
-		fix_read_error(conf, r1_bio->read_disk,
-			       r1_bio->sector, r1_bio->sectors);
+		fix_read_error(conf, r1_bio);
 		unfreeze_array(conf);
 	} else if (mddev->ro == 0 && test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
-- 
2.39.2

