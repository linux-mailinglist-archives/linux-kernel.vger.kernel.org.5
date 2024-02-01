Return-Path: <linux-kernel+bounces-47870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A178453F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32221C27CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9615DBB0;
	Thu,  1 Feb 2024 09:30:35 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941215B990;
	Thu,  1 Feb 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779834; cv=none; b=lEpLZ8jXEOpHJRBuHp1DSQhgRlqHuJzSZaOR2PoWIH/mam7h59ihptqksKR1AqNetjK7OK154hPbJgvV79AUl3IENvM7ZcG2KKOoGhaUezHJMfwJuIqVB6E+wUYkI8MWtMUOX2548aPAckbNjNs3SmXerz312in52YN2VDxHdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779834; c=relaxed/simple;
	bh=P78HzqbyoW17tfVjgGA+69KAblnYGxtOVqNCc1oclCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tykn6fFwNjbVGh4uPTvZF1t7l3WNDCwTek1JD/+QsQj7BI0oOWPh32j9wKZGUlTadiOcFExJ8kl8T86bMv2z248PGLFeAcIyzp0FMs+Y+KDEhRjJNZ+13ACVDQCMRfM8pDVl8EV5mAPUGuoIYPHWjFpwwiCY/dP3wmglruoQn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQYXx1zxMz4f3l7R;
	Thu,  1 Feb 2024 17:30:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7855C1A027B;
	Thu,  1 Feb 2024 17:30:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S10;
	Thu, 01 Feb 2024 17:30:29 +0800 (CST)
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
Subject: [PATCH v5 06/14] md: fix missing release of 'active_io' for flush
Date: Thu,  1 Feb 2024 17:25:51 +0800
Message-Id: <20240201092559.910982-7-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1UCw1Utw1xZF4kXr1fZwb_yoW8WF4fp3
	y8tas8tr4UGF98t398JF48WF95W3WUtay09FZxAw13AFnxWFs8K39agrW8Xr95Gr1fJ398
	ur4jgr1DWa4UWFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

submit_flushes
 atomic_set(&mddev->flush_pending, 1);
 rdev_for_each_rcu(rdev, mddev)
  atomic_inc(&mddev->flush_pending);
  bi->bi_end_io = md_end_flush
  submit_bio(bi);
                        /* flush io is done first */
                        md_end_flush
                         if (atomic_dec_and_test(&mddev->flush_pending))
                          percpu_ref_put(&mddev->active_io)
                          -> active_io is not released

 if (atomic_dec_and_test(&mddev->flush_pending))
  -> missing release of active_io

For consequence, mddev_suspend() will wait for 'active_io' to be zero
forever.

Fix this problem by releasing 'active_io' in submit_flushes() if
'flush_pending' is decreased to zero.

Fixes: fa2bbff7b0b4 ("md: synchronize flush io with array reconfiguration")
Reported-by: Blazej Kucman <blazej.kucman@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20240130172524.0000417b@linux.intel.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 85fde05c37dd..9e41a9aaba8b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -579,8 +579,12 @@ static void submit_flushes(struct work_struct *ws)
 			rcu_read_lock();
 		}
 	rcu_read_unlock();
-	if (atomic_dec_and_test(&mddev->flush_pending))
+	if (atomic_dec_and_test(&mddev->flush_pending)) {
+		/* The pair is percpu_ref_get() from md_flush_request() */
+		percpu_ref_put(&mddev->active_io);
+
 		queue_work(md_wq, &mddev->flush_work);
+	}
 }
 
 static void md_submit_flush_data(struct work_struct *ws)
-- 
2.39.2


