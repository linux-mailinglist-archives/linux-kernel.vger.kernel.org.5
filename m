Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21A179A3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjIKGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIKGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:55:32 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91C12D;
        Sun, 10 Sep 2023 23:55:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rkcsz4ct9z4f3knb;
        Mon, 11 Sep 2023 14:55:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd3Zuf5k8FC7AA--.8928S4;
        Mon, 11 Sep 2023 14:55:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     mariusz.tkaczyk@linux.intel.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: simplify md_seq_ops
Date:   Mon, 11 Sep 2023 14:50:10 +0800
Message-Id: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd3Zuf5k8FC7AA--.8928S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw43GrWUGFyUWr17AFWrZrb_yoWrGF18pF
        sI9FW3Ar48X3yFqa1DJa1Du3W5XwnFg34qgr9rG3s3Cr1UJry3ZF1fXw40qr90gay8Wrn8
        Wa1DKa4UWr18G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Use seq_list_start/next/stop() directly. Move printing "Personalities"
to md_sep_start() and "unsed devices" to md_seq_stop().

Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 124 ++++++++++++------------------------------------
 1 file changed, 31 insertions(+), 93 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0fe7ab6e8ab9..9c1155042335 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8192,105 +8192,14 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	return 1;
 }
 
-static void *md_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	struct list_head *tmp;
-	loff_t l = *pos;
-	struct mddev *mddev;
-
-	if (l == 0x10000) {
-		++*pos;
-		return (void *)2;
-	}
-	if (l > 0x10000)
-		return NULL;
-	if (!l--)
-		/* header */
-		return (void*)1;
-
-	spin_lock(&all_mddevs_lock);
-	list_for_each(tmp,&all_mddevs)
-		if (!l--) {
-			mddev = list_entry(tmp, struct mddev, all_mddevs);
-			if (!mddev_get(mddev))
-				continue;
-			spin_unlock(&all_mddevs_lock);
-			return mddev;
-		}
-	spin_unlock(&all_mddevs_lock);
-	if (!l--)
-		return (void*)2;/* tail */
-	return NULL;
-}
-
-static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct list_head *tmp;
-	struct mddev *next_mddev, *mddev = v;
-	struct mddev *to_put = NULL;
-
-	++*pos;
-	if (v == (void*)2)
-		return NULL;
-
-	spin_lock(&all_mddevs_lock);
-	if (v == (void*)1) {
-		tmp = all_mddevs.next;
-	} else {
-		to_put = mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-
-	for (;;) {
-		if (tmp == &all_mddevs) {
-			next_mddev = (void*)2;
-			*pos = 0x10000;
-			break;
-		}
-		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
-		if (mddev_get(next_mddev))
-			break;
-		mddev = next_mddev;
-		tmp = mddev->all_mddevs.next;
-	}
-	spin_unlock(&all_mddevs_lock);
-
-	if (to_put)
-		mddev_put(mddev);
-	return next_mddev;
-
-}
-
-static void md_seq_stop(struct seq_file *seq, void *v)
-{
-	struct mddev *mddev = v;
-
-	if (mddev && v != (void*)1 && v != (void*)2)
-		mddev_put(mddev);
-}
-
 static int md_seq_show(struct seq_file *seq, void *v)
 {
-	struct mddev *mddev = v;
+	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
 	sector_t sectors;
 	struct md_rdev *rdev;
 
-	if (v == (void*)1) {
-		struct md_personality *pers;
-		seq_printf(seq, "Personalities : ");
-		spin_lock(&pers_lock);
-		list_for_each_entry(pers, &pers_list, list)
-			seq_printf(seq, "[%s] ", pers->name);
-
-		spin_unlock(&pers_lock);
-		seq_printf(seq, "\n");
-		seq->poll_event = atomic_read(&md_event_count);
-		return 0;
-	}
-	if (v == (void*)2) {
-		status_unused(seq);
+	if (test_bit(MD_DELETED, &mddev->flags))
 		return 0;
-	}
 
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
@@ -8366,6 +8275,35 @@ static int md_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static void *md_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct md_personality *pers;
+
+	seq_puts(seq, "Personalities : ");
+	spin_lock(&pers_lock);
+	list_for_each_entry(pers, &pers_list, list)
+		seq_printf(seq, "[%s] ", pers->name);
+
+	spin_unlock(&pers_lock);
+	seq_puts(seq, "\n");
+	seq->poll_event = atomic_read(&md_event_count);
+
+	spin_lock(&all_mddevs_lock);
+
+	return seq_list_start(&all_mddevs, *pos);
+}
+
+static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &all_mddevs, pos);
+}
+
+static void md_seq_stop(struct seq_file *seq, void *v)
+{
+	status_unused(seq);
+	spin_unlock(&all_mddevs_lock);
+}
+
 static const struct seq_operations md_seq_ops = {
 	.start  = md_seq_start,
 	.next   = md_seq_next,
-- 
2.39.2

