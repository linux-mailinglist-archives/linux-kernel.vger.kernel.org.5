Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6298377C64A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjHODPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjHODOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B701990;
        Mon, 14 Aug 2023 20:13:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPxDb5lW5z4f3vdd;
        Tue, 15 Aug 2023 11:13:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ld7dpknET3Ag--.64666S8;
        Tue, 15 Aug 2023 11:13:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 4/7] md: factor out a helper rdev_removeable() from remove_and_add_spares()
Date:   Tue, 15 Aug 2023 11:09:54 +0800
Message-Id: <20230815030957.509535-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815030957.509535-1-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ld7dpknET3Ag--.64666S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4fuw4Uurg_yoW8KFyfpa
        1fKFyYkr4UA3yaqw1kGrn5Ga45Xa18KayIkFyfGa4rZasxAr90qw1rKFy5Xr90yFZ3ZF4Y
        vF15Jw4rCr1xuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, just to make the code simpler and
prepare to delay remove_and_add_spares() to md_start_sync().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 03615b0e9fe1..ea091eef23d1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9153,6 +9153,22 @@ void md_do_sync(struct md_thread *thread)
 }
 EXPORT_SYMBOL_GPL(md_do_sync);
 
+static bool rdev_removeable(struct md_rdev *rdev)
+{
+	if (rdev->raid_disk < 0 || test_bit(Blocked, &rdev->flags) ||
+	    atomic_read(&rdev->nr_pending))
+		return false;
+
+	if (test_bit(RemoveSynchronized, &rdev->flags))
+		return true;
+
+	if (test_bit(In_sync, &rdev->flags) ||
+	    test_bit(Journal, &rdev->flags))
+		return false;
+
+	return true;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9166,11 +9182,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 		return 0;
 
 	rdev_for_each(rdev, mddev) {
-		if ((this == NULL || rdev == this) &&
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    test_bit(Faulty, &rdev->flags) &&
-		    atomic_read(&rdev->nr_pending)==0) {
+		if ((this == NULL || rdev == this) && rdev_removeable(rdev)) {
 			/* Faulty non-Blocked devices with nr_pending == 0
 			 * never get nr_pending incremented,
 			 * never get Faulty cleared, and never get Blocked set.
@@ -9185,19 +9197,12 @@ static int remove_and_add_spares(struct mddev *mddev,
 		synchronize_rcu();
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) &&
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    ((test_bit(RemoveSynchronized, &rdev->flags) ||
-		     (!test_bit(In_sync, &rdev->flags) &&
-		      !test_bit(Journal, &rdev->flags))) &&
-		    atomic_read(&rdev->nr_pending)==0)) {
-			if (mddev->pers->hot_remove_disk(
-				    mddev, rdev) == 0) {
+		    rdev_removeable(rdev) &&
+		    mddev->pers->hot_remove_disk(mddev, rdev) == 0) {
 				sysfs_unlink_rdev(mddev, rdev);
 				rdev->saved_raid_disk = rdev->raid_disk;
 				rdev->raid_disk = -1;
 				removed++;
-			}
 		}
 		if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
 			clear_bit(RemoveSynchronized, &rdev->flags);
-- 
2.39.2

