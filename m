Return-Path: <linux-kernel+bounces-20913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE0828748
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4956A1F25562
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC73986E;
	Tue,  9 Jan 2024 13:43:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274739AC0;
	Tue,  9 Jan 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T8XDy6YpWz4f3jJH;
	Tue,  9 Jan 2024 21:42:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 66EBE1A0272;
	Tue,  9 Jan 2024 21:43:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFkTZ1lVgZPAQ--.55732S4;
	Tue, 09 Jan 2024 21:43:02 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] md: fix md_seq_ops() regressions
Date: Tue,  9 Jan 2024 21:39:57 +0800
Message-Id: <20240109133957.2975272-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFkTZ1lVgZPAQ--.55732S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17uFWDXrW8Jw47Ww47twb_yoW5ZFy8pF
	sxZFW3ArWUXrWxKwsxAa1ku3WFq3Wvy34qgr9rG395Cr1UXrnru3W3Xay7XFn8Way8Wwn8
	Xa1DKFy5GrWUJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Commit cf1b6d4441ff ("md: simplify md_seq_ops") introduce following
regressions:

1) If list all_mddevs is emptly, personalities and unused devices won't
   be showed to user anymore.
2) If seq_file buffer overflowed from md_seq_show(), then md_seq_start()
   will be called again, hence personalities will be showed to user
   again.
3) If seq_file buffer overflowed from md_seq_stop(), seq_read_iter()
   doesn't handle this, hence unused devices won't be showed to user.

Fix above problems by print personalities and unused devices in
md_seq_show(), as it used to be.

Fixes: cf1b6d4441ff ("md: simplify md_seq_ops")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e351e6c51cc7..ff3057c787c1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8135,6 +8135,19 @@ static void status_unused(struct seq_file *seq)
 	seq_printf(seq, "\n");
 }
 
+static void status_personalities(struct seq_file *seq)
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
+}
+
 static int status_resync(struct seq_file *seq, struct mddev *mddev)
 {
 	sector_t max_sectors, resync, res;
@@ -8276,20 +8289,10 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 static void *md_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(&all_mddevs_lock)
 {
-	struct md_personality *pers;
-
-	seq_puts(seq, "Personalities : ");
-	spin_lock(&pers_lock);
-	list_for_each_entry(pers, &pers_list, list)
-		seq_printf(seq, "[%s] ", pers->name);
-
-	spin_unlock(&pers_lock);
-	seq_puts(seq, "\n");
 	seq->poll_event = atomic_read(&md_event_count);
-
 	spin_lock(&all_mddevs_lock);
 
-	return seq_list_start(&all_mddevs, *pos);
+	return seq_list_start_head(&all_mddevs, *pos);
 }
 
 static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -8300,16 +8303,23 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void md_seq_stop(struct seq_file *seq, void *v)
 	__releases(&all_mddevs_lock)
 {
-	status_unused(seq);
 	spin_unlock(&all_mddevs_lock);
 }
 
 static int md_seq_show(struct seq_file *seq, void *v)
 {
-	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
+	struct mddev *mddev;
 	sector_t sectors;
 	struct md_rdev *rdev;
 
+	if (v == &all_mddevs) {
+		status_personalities(seq);
+		if (list_empty(&all_mddevs))
+			status_unused(seq);
+		return 0;
+	}
+
+	mddev = list_entry(v, struct mddev, all_mddevs);
 	if (!mddev_get(mddev))
 		return 0;
 
@@ -8385,6 +8395,10 @@ static int md_seq_show(struct seq_file *seq, void *v)
 	}
 	spin_unlock(&mddev->lock);
 	spin_lock(&all_mddevs_lock);
+
+	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
+		status_unused(seq);
+
 	if (atomic_dec_and_test(&mddev->active))
 		__mddev_put(mddev);
 
-- 
2.39.2


