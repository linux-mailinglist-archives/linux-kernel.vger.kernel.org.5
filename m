Return-Path: <linux-kernel+bounces-43813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9984191F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B52A28A7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D14F1EE;
	Tue, 30 Jan 2024 02:23:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B5381A0;
	Tue, 30 Jan 2024 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581391; cv=none; b=gCSj+vP7bNo+oY8bgK99MPp/VQwqS/6vultIq1ROfYBbBCauMakFXc4NL8n+E0CPBcteLTxiAvp6ivklq3lKCRdIqTkdMnWXJqmDoEgxmkbU1o4Nvt9QBbqUeZMfu7vzeW+KopPggISRyEqepyqkXcAbtpd0V1o9fWqY0g0UNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581391; c=relaxed/simple;
	bh=yeO1LGdlv/HUZdhkshDDNxzEa5t2WUEBZmRVtUU3LHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KavS/Pi6lcX0IIcTiJMZ9F4KBw2CGOP+PywrR1Z6EsQr0tSZZpZNa3dihh41edvmItSdMaB+FDWDGKv+rXkooPYdgCgxhrabxGNRucj6V9g+mwi91rYYuIxJGgVfWQwoSAg2NryVgiLjeuD3UvygAEEQgxt41OSuBceexnC9aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP88h0c62z4f3m7f;
	Tue, 30 Jan 2024 10:23:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 899731A0199;
	Tue, 30 Jan 2024 10:23:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S12;
	Tue, 30 Jan 2024 10:23:06 +0800 (CST)
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
Subject: [PATCH v4 08/14] dm-raid: add a new helper prepare_suspend() in md_personality
Date: Tue, 30 Jan 2024 10:18:37 +0800
Message-Id: <20240130021843.3608859-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtrykGw13uF4fGrg_yoW8Wr48pa
	yIqay5Ar4UJayavw1DXr4kZa4aq3ZIgrWqyryfJayfZa42grn5W3WFqayDZrZ0yFy3CF13
	Aa1Utw4kuFy09rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes for now, prepare to fix a deadlock for
dm-raid456.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c | 10 +++++++---
 drivers/md/md.h      |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 6b6c011d9f69..16d3348abfed 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3806,10 +3806,14 @@ static void raid_io_hints(struct dm_target *ti, struct queue_limits *limits)
 static void raid_presuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
+	struct mddev *mddev = &rs->md;
 
-	mddev_lock_nointr(&rs->md);
-	md_frozen_sync_thread(&rs->md);
-	mddev_unlock(&rs->md);
+	mddev_lock_nointr(mddev);
+	md_frozen_sync_thread(mddev);
+	mddev_unlock(mddev);
+
+	if (mddev->pers && mddev->pers->prepare_suspend)
+		mddev->pers->prepare_suspend(mddev);
 }
 
 static void raid_presuspend_undo(struct dm_target *ti)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 437ab70ce79b..29b476ff3b9f 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -617,6 +617,7 @@ struct md_personality
 	int (*start_reshape) (struct mddev *mddev);
 	void (*finish_reshape) (struct mddev *mddev);
 	void (*update_reshape_pos) (struct mddev *mddev);
+	void (*prepare_suspend) (struct mddev *mddev);
 	/* quiesce suspends or resumes internal processing.
 	 * 1 - stop new actions and wait for action io to complete
 	 * 0 - return to normal behaviour
-- 
2.39.2


