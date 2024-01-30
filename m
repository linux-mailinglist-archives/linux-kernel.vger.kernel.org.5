Return-Path: <linux-kernel+bounces-43812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30784191D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832C328A298
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1C3C498;
	Tue, 30 Jan 2024 02:23:11 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE7376F9;
	Tue, 30 Jan 2024 02:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581390; cv=none; b=oxKr8Utuu13Zk2lfx8zidpb07SjTmSVGGpuGqVTKynzzLl+N4kh181JrlFA60da43aB5XxJbjvWEoqyZH454NXz48KyjPFn9yxn2n9n9SjW3OKH+AGAgkQXdzbfC5q4YEpvhVkbNsCkw9KalSvSa5+va5x+ptAXPHBY4+/wvcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581390; c=relaxed/simple;
	bh=orTUf8OIgVO5EnJ8e56Og6bXoRyUdV4mYFLO+shF788=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK9FEYLY5N/psPDfG5cGruptqJMmrLE863V6maW6hvcwqdtMTnOiPE4vUr0TW5XfiwZ8v/92T/XG3srs9HH+c/FVKZKZONiedglcdS/dCg0VUGJgPZNh/nsiD7rG8PhbyD9nwQ9nWKKsrwOcLn0D/8oajXJYWVvERejNvEPa+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP88g3JyZz4f3m6n;
	Tue, 30 Jan 2024 10:22:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E45671A0199;
	Tue, 30 Jan 2024 10:23:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S11;
	Tue, 30 Jan 2024 10:23:05 +0800 (CST)
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
Subject: [PATCH v4 07/14] md/dm-raid: don't call md_reap_sync_thread() directly
Date: Tue, 30 Jan 2024 10:18:36 +0800
Message-Id: <20240130021843.3608859-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S11
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xAF18KFyDuFy5Ww48JFb_yoW8Kw4fpa
	yakas8Ar48JrW3ZFsrt3WDWayFv3ZFq3yqyFWfG3y3JF1fKF43WF1j9a17ZFWDJFWfta4U
	XFZ8tF45uF4YqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Currently md_reap_sync_thread() is called from raid_message() directly
without holding 'reconfig_mutex', this is definitely unsafe because
md_reap_sync_thread() can change many fields that is protected by
'reconfig_mutex'.

However, hold 'reconfig_mutex' here is still problematic because this
will cause deadlock, for example, commit 130443d60b1b ("md: refactor
idle/frozen_sync_thread() to fix deadlock").

Fix this problem by using stop_sync_thread() to unregister sync_thread,
like md/raid did.

Fixes: be83651f0050 ("DM RAID: Add message/status support for changing sync action")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5ce3c6020b1b..6b6c011d9f69 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3719,6 +3719,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 {
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
+	int ret = 0;
 
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
@@ -3726,17 +3727,24 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
 		return -EBUSY;
 
-	if (!strcasecmp(argv[0], "frozen"))
-		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	else
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (!strcasecmp(argv[0], "frozen")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
 
-	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
-		if (mddev->sync_thread) {
-			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_reap_sync_thread(mddev);
-		}
-	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
+		md_frozen_sync_thread(mddev);
+		mddev_unlock(mddev);
+	} else if (!strcasecmp(argv[0], "idle")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
+
+		md_idle_sync_thread(mddev);
+		mddev_unlock(mddev);
+	}
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
 		; /* MD_RECOVERY_NEEDED set below */
-- 
2.39.2


