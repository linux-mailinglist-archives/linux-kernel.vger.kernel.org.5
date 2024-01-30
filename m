Return-Path: <linux-kernel+bounces-43819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2118841931
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC2528362B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81D15AACA;
	Tue, 30 Jan 2024 02:23:15 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A554746;
	Tue, 30 Jan 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581395; cv=none; b=oOw+P9H78tnNMRWBUPNvnTvUmRC62toQOfw7LtcE0jFloJvrHXTKADZ+VBY5pJkCKFBGuTmxXzVm0Dxd/d36uC7b0rKnY+ZD0Q+VtTSi3X25Nc3sZ1ASbDlwVXsQfKT/BM0eq4HBVDHxD7upZgM5Eyg+YqhooClBpdPSe7iqOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581395; c=relaxed/simple;
	bh=lt3pNMtDHV/r0zFHslB52IvlGb8ZyJ3dbmeLd5B+QBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzlccQ0Et0JEmlTBp64nQY0r2bUvFRbNPFt6i9yyG9vbR1oM2v9ioX98JP7lrMfg86kVM2zG6ofDqWyCNMdFVeqQq6mojA99H4Vlql5uD5flJWOXQjbXdWl4c7bMK4xFRADfRNrJxdbCBoyofMG93EN4d4txhGlqGY06HIh+V6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TP88p1PG5z4f3lwP;
	Tue, 30 Jan 2024 10:23:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4D25E1A016E;
	Tue, 30 Jan 2024 10:23:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S18;
	Tue, 30 Jan 2024 10:23:10 +0800 (CST)
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
Subject: [PATCH v4 RFC 14/14] dm-raid: remove mddev_suspend/resume()
Date: Tue, 30 Jan 2024 10:18:43 +0800
Message-Id: <20240130021843.3608859-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S18
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fCw4fWryruryfZr1UZFb_yoW8Kw4rpw
	4IgFWYyw1UJFZrXw4DA3Z2gFy5twn5KrWqkrZxW34fW3W3Gr13Wr18GayUXFWDKFWfAF1D
	Aa15tw4UuryIgrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
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
 drivers/md/dm-raid.c |  8 +++-----
 drivers/md/md.c      | 11 +++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5f78cc19d6f3..ed8c28952b14 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3241,7 +3241,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.in_sync = 1;
 
 	/* Has to be held on running the array */
-	mddev_suspend_and_lock_nointr(&rs->md);
+	mddev_lock_nointr(&rs->md);
 
 	/* Keep array frozen until resume. */
 	md_frozen_sync_thread(&rs->md);
@@ -3829,11 +3829,9 @@ static void raid_postsuspend(struct dm_target *ti)
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
@@ -4091,7 +4089,7 @@ static void raid_resume(struct dm_target *ti)
 		mddev->ro = 0;
 		mddev->in_sync = 0;
 		md_unfrozen_sync_thread(mddev);
-		mddev_unlock_and_resume(mddev);
+		mddev_unlock(mddev);
 	}
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 093abf3ce27b..e3a56a958b47 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -437,6 +437,10 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
 {
 	int err = 0;
 
+	/* Array is supended from dm_suspend() for dm-raid. */
+	if (!mddev->gendisk)
+		return 0;
+
 	/*
 	 * hold reconfig_mutex to wait for normal io will deadlock, because
 	 * other context can't update super_block, and normal io can rely on
@@ -488,6 +492,13 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
 
 static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
 {
+	/*
+	 * Array is supended from dm_suspend() and resumed from dm_resume() for
+	 * dm-raid.
+	 */
+	if (!mddev->gendisk)
+		return;
+
 	lockdep_assert_not_held(&mddev->reconfig_mutex);
 
 	mutex_lock(&mddev->suspend_mutex);
-- 
2.39.2


