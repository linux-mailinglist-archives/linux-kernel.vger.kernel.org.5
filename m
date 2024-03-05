Return-Path: <linux-kernel+bounces-91806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F298D8716DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C961F230ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064381745;
	Tue,  5 Mar 2024 07:29:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC77E56C;
	Tue,  5 Mar 2024 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623780; cv=none; b=XNw0ICJkI6nFnS6b1Fc3FSIB6wZTyjWciv7zCjR11s7jVKprNp2nK+xHT4qh/cprXq/6OgQUePyGP8X0ScQiULHVYkpTW90kuVwewnvFK34RfIE8yQM/3LlP1nmHxQUcV1BGiZxDdWpseS9fvDhO67/mMUbQyXmZnLt/fcPBWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623780; c=relaxed/simple;
	bh=c7vtsLwByVaJ/kOv3+/pS6rhbOr70p9cvZ23xJScbOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3dBt86v1qNr2F0zU97GaUiiTRXuNsfArfJDfTmWXiumNvV3S8CYbaucA/Hw9PHWPCQ0ee0e3xIEcAmNMg4aS5FTr7eE7QFCnEpU9AmtEs1HYMLmlnslGzUqtVGW3Qyy1pH0K1ljBuU1igdLsxZdJ40DHPwuAuYFLLW0x08+oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TpnJ44p7kz4f3jsr;
	Tue,  5 Mar 2024 15:29:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1399D1A0232;
	Tue,  5 Mar 2024 15:29:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHRyeZlGnf+Fw--.17927S11;
	Tue, 05 Mar 2024 15:29:29 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	zkabelac@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	jbrassow@redhat.com,
	neilb@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.8 v2 7/9] dm-raid: add a new helper prepare_suspend() in md_personality
Date: Tue,  5 Mar 2024 15:23:04 +0800
Message-Id: <20240305072306.2562024-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
References: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHRyeZlGnf+Fw--.17927S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtrykGw13uF4fGrg_yoW8uFW7pa
	yIq34Yvr4UJFZI93WDJF4kua4aq3Z3KrWjyr9xJayfZFy2gryrGa4ftayYqrZ8CF15K3W7
	AF4Ut34UWr109FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes for now, prepare to fix a deadlock for
dm-raid456.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-raid.c | 18 ++++++++++++++++++
 drivers/md/md.h      |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 47c4b1b6e532..7d48943acd57 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3803,6 +3803,23 @@ static void raid_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_stripes(rs));
 }
 
+static void raid_presuspend(struct dm_target *ti)
+{
+	struct raid_set *rs = ti->private;
+	struct mddev *mddev = &rs->md;
+
+	if (!reshape_interrupted(mddev))
+		return;
+
+	/*
+	 * For raid456, if reshape is interrupted, IO across reshape position
+	 * will never make progress, while caller will wait for IO to be done.
+	 * Inform raid456 to handle those IO to prevent deadlock.
+	 */
+	if (mddev->pers && mddev->pers->prepare_suspend)
+		mddev->pers->prepare_suspend(mddev);
+}
+
 static void raid_postsuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
@@ -4087,6 +4104,7 @@ static struct target_type raid_target = {
 	.message = raid_message,
 	.iterate_devices = raid_iterate_devices,
 	.io_hints = raid_io_hints,
+	.presuspend = raid_presuspend,
 	.postsuspend = raid_postsuspend,
 	.preresume = raid_preresume,
 	.resume = raid_resume,
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 7f955115d78d..2db0a75febf9 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -648,6 +648,7 @@ struct md_personality
 	int (*start_reshape) (struct mddev *mddev);
 	void (*finish_reshape) (struct mddev *mddev);
 	void (*update_reshape_pos) (struct mddev *mddev);
+	void (*prepare_suspend) (struct mddev *mddev);
 	/* quiesce suspends or resumes internal processing.
 	 * 1 - stop new actions and wait for action io to complete
 	 * 0 - return to normal behaviour
-- 
2.39.2


