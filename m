Return-Path: <linux-kernel+bounces-96765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE09876120
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64079B21C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017C535CB;
	Fri,  8 Mar 2024 09:44:07 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C203BBDE;
	Fri,  8 Mar 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891046; cv=none; b=rF7pHIhCdk1n8+8aG8awGqs33WqFRufSvosA2H4MPPX4qjAOwlqWAINHmwmdYUfUdBI3q9Vvvxgah3v9NDdP2qzhrOjONx6xpH9CT8q39VUBaPfv0qDyrxSk2nc6iQBJvxmTivGu/uVtqkrWUlb8OITWZC4MZoVslxdR65itpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891046; c=relaxed/simple;
	bh=wUDaBbMe+qyuXdIMTgJAUGuLMP9R+SH2tOiALF1plRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMQyrDzESuA+dulp1DIOvP0KSA+piaGIKWL2/Ah5ZzXbRGCF+A0J+a9r/g564vz9T6oUp6QZQTS+aAgJTk4PaqcXYs+0ZDN/BBFVCuIcPLE2qnbtTa/xhjc6GKMT1JSTo7fOv/p2JjT73r49UGYKkR594NYoMCXFDlUk1Fv8VNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Trh7k6QCGz4f3n6k;
	Fri,  8 Mar 2024 17:43:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7801B1A0283;
	Fri,  8 Mar 2024 17:43:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7Y3eplFg09GQ--.12118S4;
	Fri, 08 Mar 2024 17:43:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	xueshi.hu@smartx.com
Cc: colyli@suse.de,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] raid1: fix use-after-free for original bio in raid1_write_request()
Date: Fri,  8 Mar 2024 17:37:26 +0800
Message-Id: <20240308093726.1047420-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7Y3eplFg09GQ--.12118S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kXrWfuryDJw1fGF4fuFg_yoW5AFyfpw
	4fKa4SvrWDWr1fAa1DtF1UCF1rAan0vFy7CrWxur4xXFnIv34DG3WUXrWrWryjkFWrG3yU
	JFn5C398Zr1DJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Yu Kuai <yukuai3@huawei.com>

r1_bio->bios[] is used to record new bios that will be issued to
underlying disks, however, in raid1_write_request(), r1_bio->bios[]
will set to the original bio temporarily. Meanwhile, if blocked rdev
is set, free_r1bio() will be called causing that all r1_bio->bios[]
to be freed:

raid1_write_request()
 r1_bio = alloc_r1bio(mddev, bio); -> r1_bio->bios[] is NULL
 for (i = 0;  i < disks; i++) -> for each rdev in conf
  // first rdev is normal
  r1_bio->bios[0] = bio; -> set to original bio
  // second rdev is blocked
  if (test_bit(Blocked, &rdev->flags))
   break

 if (blocked_rdev)
  free_r1bio()
   put_all_bios()
    bio_put(r1_bio->bios[0]) -> original bio is freed

Test scripts:

mdadm -CR /dev/md0 -l1 -n4 /dev/sd[abcd] --assume-clean
fio -filename=/dev/md0 -ioengine=libaio -rw=write -bs=4k -numjobs=1 \
    -iodepth=128 -name=test -direct=1
echo blocked > /sys/block/md0/md/rd2/state

Test result:

BUG bio-264 (Not tainted): Object already free
-----------------------------------------------------------------------------

Allocated in mempool_alloc_slab+0x24/0x50 age=1 cpu=1 pid=869
 kmem_cache_alloc+0x324/0x480
 mempool_alloc_slab+0x24/0x50
 mempool_alloc+0x6e/0x220
 bio_alloc_bioset+0x1af/0x4d0
 blkdev_direct_IO+0x164/0x8a0
 blkdev_write_iter+0x309/0x440
 aio_write+0x139/0x2f0
 io_submit_one+0x5ca/0xb70
 __do_sys_io_submit+0x86/0x270
 __x64_sys_io_submit+0x22/0x30
 do_syscall_64+0xb1/0x210
 entry_SYSCALL_64_after_hwframe+0x6c/0x74
Freed in mempool_free_slab+0x1f/0x30 age=1 cpu=1 pid=869
 kmem_cache_free+0x28c/0x550
 mempool_free_slab+0x1f/0x30
 mempool_free+0x40/0x100
 bio_free+0x59/0x80
 bio_put+0xf0/0x220
 free_r1bio+0x74/0xb0
 raid1_make_request+0xadf/0x1150
 md_handle_request+0xc7/0x3b0
 md_submit_bio+0x76/0x130
 __submit_bio+0xd8/0x1d0
 submit_bio_noacct_nocheck+0x1eb/0x5c0
 submit_bio_noacct+0x169/0xd40
 submit_bio+0xee/0x1d0
 blkdev_direct_IO+0x322/0x8a0
 blkdev_write_iter+0x309/0x440
 aio_write+0x139/0x2f0

Since that bios for underlying disks are not allocated yet, fix this
problem by using mempool_free() directly to free the r1_bio.

Fixes: 992db13a4aee ("md/raid1: free the r1bio before waiting for blocked rdev")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afca975ec7f3..fde8434c33df 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1565,7 +1565,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		for (j = 0; j < i; j++)
 			if (r1_bio->bios[j])
 				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
-		free_r1bio(r1_bio);
+		mempool_free(r1_bio, &conf->r1bio_pool);
 		allow_barrier(conf, bio->bi_iter.bi_sector);
 
 		if (bio->bi_opf & REQ_NOWAIT) {
-- 
2.39.2


