Return-Path: <linux-kernel+bounces-28503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32A82FF55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D2F1F24F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9780567D;
	Wed, 17 Jan 2024 03:38:48 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324D01C13;
	Wed, 17 Jan 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462728; cv=none; b=Cxk4U7aaQ4YCOjo1ypX/hc7VTybjQJn8d/0P8V5O5BuK0wMRkin8b8jCXSWRJK0ILOaYmSIbBSHqbP8WbcUx+NUE0ZDszBxI6BR0hQwAdm0Gghi2Qs7wPHkp++rRQrd8evX9T40zQ8A8EN282AIqGoRsZxoF0fZFGSCo/pI+KdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462728; c=relaxed/simple;
	bh=DpUHH/MtmlZWirIGpFpniqdoG1uWcNpU8vFuNpinZx4=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=N8wvoWiIjCCI8z+MqLHq3poJvzPICMAcyYZWG9M1in9lrGmbt44CHoGs7XHC5/e7wo0sf7aUDuRAITlgKqQfkAWWNvXtHjM/pjOeg2m3Pi+Pz0a8zazxYdioObMf0CgNpe7VyrTXHGEe2VCnYKvPRhVxaNUeW34tVwDm5IX2IQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFB6762fLz4f3lVm;
	Wed, 17 Jan 2024 11:23:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E881B1A0171;
	Wed, 17 Jan 2024 11:23:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4jSKdlFKhLBA--.54857S6;
	Wed, 17 Jan 2024 11:23:17 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	axboe@kernel.dk
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 2/2] md: don't account sync_io if iostats of the disk is disabled
Date: Wed, 17 Jan 2024 11:19:46 +0800
Message-Id: <20240117031946.2324519-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117031946.2324519-1-linan666@huaweicloud.com>
References: <20240117031946.2324519-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4jSKdlFKhLBA--.54857S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxKF4kKr1xuF15Jr4DCFg_yoW8XrW7pa
	95AF93A34UXr45Wa4DXryDCa4rW3srKFWUJrW7u3yfXFyaqr9xGF4rXayqqF1DWFWrGFWa
	v3WjyrZ093W0yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1xhLUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If iostats is disabled, disk_stats will not be updated and
part_stat_read_accum() only returns a constant value. In this case,
continuing to count sync_io and to check is_mddev_idle() is no longer
meaningful.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h | 3 ++-
 drivers/md/md.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1a4f976951c1..e2d03a7a858c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -584,7 +584,8 @@ extern void mddev_unlock(struct mddev *mddev);
 
 static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
 {
-	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
+	if (blk_queue_io_stat(bdev->bd_disk->queue))
+		atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
 }
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a6829ea5b560..919d6affc0ac 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
+
+		if (!init && !blk_queue_io_stat(disk->queue))
+			continue;
+
 		curr_events =
 			(long long)part_stat_read_accum(disk->part0, sectors) -
 			atomic64_read(&disk->sync_io);
-- 
2.39.2


