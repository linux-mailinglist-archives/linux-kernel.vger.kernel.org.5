Return-Path: <linux-kernel+bounces-47864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE478453E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723891C240F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7915B961;
	Thu,  1 Feb 2024 09:30:31 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05E15B105;
	Thu,  1 Feb 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779830; cv=none; b=bEEIjJCE816EvQ4nP0jxfD/AtoqUMOi4AMs4q2HNCenaZ7Q7WRMihnywTCSFFEkDCVLToYLIvQSem3Vk/DqxoCGKQ78tdvhbe2YRTwPduzYe8UCHV1ALXFYApP/N5tK7pkzYzXxeCtXXn+an+0ZkkLtj0IyJVo+fhqx91seX3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779830; c=relaxed/simple;
	bh=niaIFrprWvPwC2Lv0RN5Cl1tFCytXopzeriQpGSoAMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpoSpwa8+pBknnpZirnoXmS4nUWBxljhhyFl370geFCfkrMyb339iRhwugW4VexslKOrYRKqHTj8AIHU6vB0uPsSVl7MUoc0/snWPMTfXLhsF/kh9cTeDPMQbvE1HZfZsdTQK5aF1VD95dKGo38+rYIuTLHrRNpUgJfmZkx+l74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQYXs2rwzz4f3l6f;
	Thu,  1 Feb 2024 17:30:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 974E11A0283;
	Thu,  1 Feb 2024 17:30:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S5;
	Thu, 01 Feb 2024 17:30:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	blazej.kucman@linux.intel.com,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	jbrassow@f14.redhat.com,
	neilb@suse.de,
	shli@fb.com,
	akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
Date: Thu,  1 Feb 2024 17:25:46 +0800
Message-Id: <20240201092559.910982-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDAF43ArW7JrWrZr1xGrg_yoW8ZFy7pa
	yIkF1YyrWjyFZ7Aa4qka4UZa4rAr1jqrW5AFy3u34rCa4fKw43CrWYgFyDXFyqkFyxKrZY
	vw4rJa15uw18KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

mddev_suspend() never stop sync_thread, hence it doesn't make sense to
ignore suspended array in md_check_recovery(), which might cause
sync_thread can't be unregistered.

After commit f52f5c71f3d4 ("md: fix stopping sync thread"), following
hang can be triggered by test shell/integrity-caching.sh:

1) suspend the array:
raid_postsuspend
 mddev_suspend

2) stop the array:
raid_dtr
 md_stop
  __md_stop_writes
   stop_sync_thread
    set_bit(MD_RECOVERY_INTR, &mddev->recovery);
    md_wakeup_thread_directly(mddev->sync_thread);
    wait_event(..., !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))

3) sync thread done:
md_do_sync
 set_bit(MD_RECOVERY_DONE, &mddev->recovery);
 md_wakeup_thread(mddev->thread);

4) daemon thread can't unregister sync thread:
md_check_recovery
 if (mddev->suspended)
   return; -> return directly
 md_read_sync_thread
 clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 -> MD_RECOVERY_RUNNING can't be cleared, hence step 2 hang;

This problem is not just related to dm-raid, fix it by ignoring
suspended array in md_check_recovery(). And follow up patches will
improve dm-raid better to frozen sync thread during suspend.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com/
Fixes: 68866e425be2 ("MD: no sync IO while suspended")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2266358d8074..07b80278eaa5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9469,9 +9469,6 @@ static void md_start_sync(struct work_struct *ws)
  */
 void md_check_recovery(struct mddev *mddev)
 {
-	if (READ_ONCE(mddev->suspended))
-		return;
-
 	if (mddev->bitmap)
 		md_bitmap_daemon_work(mddev);
 
-- 
2.39.2


