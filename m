Return-Path: <linux-kernel+bounces-41099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866F83EBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4AF1C225F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9924B25;
	Sat, 27 Jan 2024 07:52:35 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7FC1E496;
	Sat, 27 Jan 2024 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341954; cv=none; b=TWLG1xQEDIEfAmw5vvwAe3/NwXuDq1pwe2ao6mSsJt9Q4QG6mCLPuIchjwpGN5r6jEogeJbpmlRs4oLXnxinOYiVZlNJVAgsW7cB7bIMMbBl38ywdWa0x11EXXViWJzt6xV2eZHEA3YClTJ3NWa+pR1SFHg+ABMST24MT4MjgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341954; c=relaxed/simple;
	bh=pAubPNXHPlM/0y/n8diT6F9qbOAS9X4ipmJVWOgC2Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1ojw/fKQIpUL1U98y2AgZlnCDFWpW17OndOGIJVvVa5eUoPyL17IcWH0Ga9qPTqQFJQ9iv00oNv59pRtD0EmlQdjkeLPhZAkJ/hH4zkiKbbDM1Nv5V1Ri2RdH4bo9kXNYrIWSmNzYhdJeNptV11Rh2OJ5OSfCEetadKP9ZjJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMRcB3QSrz4f3jJ7;
	Sat, 27 Jan 2024 15:52:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79ECA1A0232;
	Sat, 27 Jan 2024 15:52:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAetrRlWjeACA--.31980S12;
	Sat, 27 Jan 2024 15:52:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
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
Subject: [PATCH v3 08/12] dm-raid: remove mddev_suspend/resume()
Date: Sat, 27 Jan 2024 15:47:50 +0800
Message-Id: <20240127074754.2380890-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
References: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAetrRlWjeACA--.31980S12
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fCw4fWr1fCr4kZw4fKrg_yoW8XFykpr
	4rWayYvw48JrWjq3WDAan2gFy3t3ZYgrWjyrZ3Gas3u3W3Kw1Sgry8tw4jqFWqyFWxJ3W5
	Aa1Yyw4kuryUKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

dm_suspend() already make sure that no new IO can be issued and will
wait for all dispatched IO to be done. There is no need to call
mddev_suspend() to make sure that again.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 6b6c011d9f69..f1637cf88559 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3241,7 +3241,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.in_sync = 1;
 
 	/* Has to be held on running the array */
-	mddev_suspend_and_lock_nointr(&rs->md);
+	mddev_lock_nointr(&rs->md);
 
 	/* Keep array frozen until resume. */
 	md_frozen_sync_thread(&rs->md);
@@ -3825,11 +3825,9 @@ static void raid_postsuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
-	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
+	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
 		/* Writes have to be stopped before suspending to avoid deadlocks. */
 		md_stop_writes(&rs->md);
-		mddev_suspend(&rs->md, false);
-	}
 }
 
 static void attempt_restore_of_faulty_devices(struct raid_set *rs)
@@ -4085,7 +4083,7 @@ static void raid_resume(struct dm_target *ti)
 		mddev->ro = 0;
 		mddev->in_sync = 0;
 		md_unfrozen_sync_thread(mddev);
-		mddev_unlock_and_resume(mddev);
+		mddev_unlock(mddev);
 	}
 }
 
-- 
2.39.2


