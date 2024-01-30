Return-Path: <linux-kernel+bounces-43815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF95841926
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC611F25419
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE895645A;
	Tue, 30 Jan 2024 02:23:13 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A97364D2;
	Tue, 30 Jan 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581392; cv=none; b=gFGZOjacjQDm2B7biD3RIdlZiS3JpT37ADfWqphHp43IgjTZF0n/HPzvH8ccd7uk2TRPLjhDAchtusiX7lVuEWjeL7swl26rISdzgIn8ZniMj6/THhr6h1geh5XYm2aedCzXFKT5WUWawkBCXzcJyGXN7lheDMbyjZ0S/8lqUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581392; c=relaxed/simple;
	bh=6YDQmrYqLiTMI1nBqXhhAgN5M0sQ1yDoPL9hqgOUqgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgzKMzdo4I1daiBAK7NbIQCNCE15QtZSCQFZRmetZhEFEoB+1H4SyZlLw0hj3HmqtnIzmxy0KJ2MmCB3D8Pv+7NnypvkjnpZ4pwzYy9I7EpBXys+YpAiQbbHAGMKumj7H3j2Yvch2VDXFYn8j7zuVB4K2bb54d1R3txeUNEjcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP88j2RTTz4f3m6y;
	Tue, 30 Jan 2024 10:23:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C90E31A01E9;
	Tue, 30 Jan 2024 10:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S14;
	Tue, 30 Jan 2024 10:23:07 +0800 (CST)
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
Subject: [PATCH v4 10/14] md: don't suspend the array for interrupted reshape
Date: Tue, 30 Jan 2024 10:18:39 +0800
Message-Id: <20240130021843.3608859-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S14
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fuFy3ZFWkArykCr17Jrb_yoW8ur13p3
	yakF1ayrs8X39IvayUG3Z7KFyFk3s5trWYy3srG34UAw13Gr1fGr43Gr4q9FyY9ry3trs0
	qr1Yq3s5GF1qkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

md_start_sync() will suspend the array if there are spares that can be
added or removed from conf, however, if reshape is still in progress,
this won't happen at all or data will be corrupted(remove_and_add_spares
won't be called from md_choose_sync_action for reshape), hence there is
no need to suspend the array if reshape is not done yet.

Meanwhile, there is a potential deadlock for raid456:

1) reshape is interrupted;

2) set one of the disk WantReplacement, and add a new disk to the array,
   however, recovery won't start until the reshape is finished;

3) then issue an IO across reshpae position, this IO will wait for
   reshape to make progress;

4) continue to reshape, then md_start_sync() found there is a spare disk
   that can be added to conf, mddev_suspend() is called;

Step 4 and step 3 is waiting for each other, deadlock triggered. Noted
this problem is found by code review, and it's not reporduced yet.

Fix this porblem by don't suspend the array for interrupted reshape,
this is safe because conf won't be changed until reshape is done.

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b942cc126ce0..093abf3ce27b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9391,12 +9391,17 @@ static void md_start_sync(struct work_struct *ws)
 	bool suspend = false;
 	char *name;
 
-	if (md_spares_need_change(mddev))
+	/*
+	 * If reshape is still in progress, spares won't be added or removed
+	 * from conf until reshape is done.
+	 */
+	if (mddev->reshape_position == MaxSector &&
+	    md_spares_need_change(mddev)) {
 		suspend = true;
+		mddev_suspend(mddev, false);
+	}
 
-	suspend ? mddev_suspend_and_lock_nointr(mddev) :
-		  mddev_lock_nointr(mddev);
-
+	mddev_lock_nointr(mddev);
 	if (!md_is_rdwr(mddev)) {
 		/*
 		 * On a read-only array we can:
-- 
2.39.2


