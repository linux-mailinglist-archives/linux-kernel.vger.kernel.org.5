Return-Path: <linux-kernel+bounces-152823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA88AC4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD61C20D72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E0487BE;
	Mon, 22 Apr 2024 07:07:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740C482FA;
	Mon, 22 Apr 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769661; cv=none; b=FKVp+VqQjBgoCDE5tRVVZZ57ZhdcQOWjhJ2WISi9g+PkfRpeRmCVejrc/EOoV9J7bTZ4SVm9cK4Brxa6zLqiO31OkDIS0ro1ghDNWXCldpdw/Et1iuq77b1t/dNUjeCBUz/jhLQd/BlwxrEb1dGeJMna6LIESE/G1lb65J03UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769661; c=relaxed/simple;
	bh=RvV8KDMtZorXebKWi+GxrzGmHsJmjPE71XulHd5dPyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PogAuT6eIkVrGJ8vXT7yMcaw1skvZOMlqw5UMWUVmcbRBaYToOu0XeayP8k9cTUhFAIvOSPiBu62n0Rk7kmPqUvHXD2QOFvANmxGGzr6nX97xGQyB6VLVbzy1USZ5/8fN5+IaOIB8njl6digXe2HJIMs0adAISkJnlg/LiSDq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNGXY6C3zz4f3k6M;
	Mon, 22 Apr 2024 15:07:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A324D1A0568;
	Mon, 22 Apr 2024 15:07:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6vDCZmwE6RKg--.62553S4;
	Mon, 22 Apr 2024 15:07:29 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	linan122@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] md: fix resync softlockup when bitmap size is less than array size
Date: Mon, 22 Apr 2024 14:58:24 +0800
Message-Id: <20240422065824.2516-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6vDCZmwE6RKg--.62553S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45KFWrWFyfuFWkCr45Wrg_yoW5WF1kpr
	WUKFW3Cry5t3y5XF4jvry8uFyFvr98trZrKF1xG343Ca4rJFsxGrWkGF1Yga1kWrWfGFZ8
	Wws8WF95uF1kWaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Is is reported that for dm-raid10, lvextend + lvchange --syncaction will
trigger following softlockup:

kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [mdX_resync:6976]
CPU: 7 PID: 3588 Comm: mdX_resync Kdump: loaded Not tainted 6.9.0-rc4-next-20240419 #1
RIP: 0010:_raw_spin_unlock_irq+0x13/0x30
Call Trace:
 <TASK>
 md_bitmap_start_sync+0x6b/0xf0
 raid10_sync_request+0x25c/0x1b40 [raid10]
 md_do_sync+0x64b/0x1020
 md_thread+0xa7/0x170
 kthread+0xcf/0x100
 ret_from_fork+0x30/0x50
 ret_from_fork_asm+0x1a/0x30

And the detailed process is as follows:

md_do_sync
 j = mddev->resync_min
 while (j < max_sectors)
  sectors = raid10_sync_request(mddev, j, &skipped)
   if (!md_bitmap_start_sync(..., &sync_blocks))
    // md_bitmap_start_sync set sync_blocks to 0
    return sync_blocks + sectors_skippe;
  // sectors = 0;
  j += sectors;
  // j never change

Root cause is that commit 301867b1c168 ("md/raid10: check
slab-out-of-bounds in md_bitmap_get_counter") return early from
md_bitmap_get_counter(), without setting returned blocks.

Fix this problem by always set returned blocks from
md_bitmap_get_counter"(), as it used to be.

Noted that this patch just fix the softlockup problem in kernel, the
case that bitmap size doesn't match array size still need to be fixed.

Fixes: 301867b1c168 ("md/raid10: check slab-out-of-bounds in md_bitmap_get_counter")
Reported-and-tested-by: Nigel Croxon <ncroxon@redhat.com>
Closes: https://lore.kernel.org/all/71ba5272-ab07-43ba-8232-d2da642acb4e@redhat.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 059afc24c08b..f5b66d52cbe3 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1424,15 +1424,17 @@ __acquires(bitmap->lock)
 	sector_t chunk = offset >> bitmap->chunkshift;
 	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
 	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
-	sector_t csize;
+	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
+
 	if (page >= bitmap->pages) {
 		/*
 		 * This can happen if bitmap_start_sync goes beyond
 		 * End-of-device while looking for a whole page or
 		 * user set a huge number to sysfs bitmap_set_bits.
 		 */
+		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
@@ -1441,8 +1443,7 @@ __acquires(bitmap->lock)
 	    bitmap->bp[page].map == NULL)
 		csize = ((sector_t)1) << (bitmap->chunkshift +
 					  PAGE_COUNTER_SHIFT);
-	else
-		csize = ((sector_t)1) << bitmap->chunkshift;
+
 	*blocks = csize - (offset & (csize - 1));
 
 	if (err < 0)
-- 
2.39.2


