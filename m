Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5465F78A46F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjH1CFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjH1CE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:58 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5278123;
        Sun, 27 Aug 2023 19:04:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RYv5J4tRqz4f3kp5;
        Mon, 28 Aug 2023 10:04:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S22;
        Mon, 28 Aug 2023 10:04:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 18/28] md: quiesce before md_kick_rdev_from_array() for md-cluster
Date:   Mon, 28 Aug 2023 10:00:11 +0800
Message-Id: <20230828020021.2489641-19-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S22
X-Coremail-Antispam: 1UD129KBjvJXoWxAry5uF13ZrWruryfGw1rWFg_yoW5WrWkpa
        y2gFyYgr4DXry3Jw13G3s8Ga45tr10krZ2y34xCa4Yy3W3Krs8C3WrWa45trZrAFyYyF1a
        va15G3yDW3WxuFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

md_kick_rdev_from_array() can be called from md_check_recovery() and
md_reload_sb() for md-cluster, it's very complicated to use new apis to
suspend the array before holding 'reconfig_mutex' in this case.

Fortunately, md-cluster is only supported for raid1 and raid10, and they
both impelement quiesce() callback that is safe to be called from daemon
thread. Hence use quiesce() callback to prevent io concurrent with
removing rdev from the array.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a3bc4968fa0f..3343767882bb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9609,6 +9609,21 @@ void md_check_recovery(struct mddev *mddev)
 
 		if (mddev_is_clustered(mddev)) {
 			struct md_rdev *rdev, *tmp;
+			bool suspended = false;
+
+			/*
+			 * md-cluster is used for raid1/raid10, and they both
+			 * implement quiesce() callback that is safe to be
+			 * called from daemon thread.
+			 */
+			rdev_for_each(rdev, mddev)
+				if (test_bit(ClusterRemove, &rdev->flags) &&
+				    rdev->raid_disk < 0) {
+					mddev->pers->quiesce(mddev, true);
+					suspended = true;
+					break;
+				}
+
 			/* kick the device if another node issued a
 			 * remove disk.
 			 */
@@ -9617,6 +9632,9 @@ void md_check_recovery(struct mddev *mddev)
 						rdev->raid_disk < 0)
 					md_kick_rdev_from_array(rdev);
 			}
+
+			if (suspended)
+				mddev->pers->quiesce(mddev, false);
 		}
 
 		if (try_set_sync && !mddev->external && !mddev->in_sync) {
@@ -9904,6 +9922,7 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	struct md_rdev *rdev2, *tmp;
+	bool suspended = false;
 	int role, ret;
 
 	/*
@@ -9918,6 +9937,22 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 			md_bitmap_update_sb(mddev->bitmap);
 	}
 
+	/*
+	 * md-cluster is used for raid1/raid10, and they both
+	 * implement quiesce() callback.
+	 */
+	rdev_for_each(rdev2, mddev) {
+		if (test_bit(Faulty, &rdev2->flags))
+			continue;
+		role = le16_to_cpu(sb->dev_roles[rdev2->desc_nr]);
+		if (test_bit(Candidate, &rdev2->flags) &&
+		    role == MD_DISK_ROLE_FAULTY) {
+			mddev->pers->quiesce(mddev, true);
+			suspended = true;
+			break;
+		}
+	}
+
 	/* Check for change of roles in the active devices */
 	rdev_for_each_safe(rdev2, tmp, mddev) {
 		if (test_bit(Faulty, &rdev2->flags))
@@ -9966,6 +10001,9 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	}
 
+	if (suspended)
+		mddev->pers->quiesce(mddev, false);
+
 	if (mddev->raid_disks != le32_to_cpu(sb->raid_disks)) {
 		ret = update_raid_disks(mddev, le32_to_cpu(sb->raid_disks));
 		if (ret)
-- 
2.39.2

