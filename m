Return-Path: <linux-kernel+bounces-41095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B827283EBCD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32091C22402
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3B21361;
	Sat, 27 Jan 2024 07:52:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AB21117;
	Sat, 27 Jan 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341953; cv=none; b=YGvRr9vIzClsxMeUt6ETkn2XXXWlh/xDjTscMf+qZM4A4nToLIBVpRaTFEzcz3sCiV6VFeKu2pyCmzMNUQl2IL9cVCeHVeIwp432rRNvsTgmz285/Ro6isUYo+xy2PsWHsD4ow7ZoW0r8FyRDijlB0TBvWCzv7zWItwK1pKtHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341953; c=relaxed/simple;
	bh=YYyayD+v2iivP+R6gR4731n5JA1gzwDoJc52NdiV/do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byffOYNGr9wpBsQAiE+Pae6sRuXK4BF97IkJSU/DKS20HdTVW1D4UEvjzVLSyWhp8mOLr7CGSXsQ8Tq1tX5J4nuD7ZziUH4UCQZwuQPW5xBvcxtRMDB6zLrk9Dq4lRLCVZZtKpy6DzaimIjwb2KpVY86G5/2VHwB9yi5nJoVK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMRcB0Tjnz4f3k6J;
	Sat, 27 Jan 2024 15:52:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7BDF61A017A;
	Sat, 27 Jan 2024 15:52:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAetrRlWjeACA--.31980S9;
	Sat, 27 Jan 2024 15:52:28 +0800 (CST)
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
Subject: [PATCH v3 05/12] md: export helpers to stop sync_thread
Date: Sat, 27 Jan 2024 15:47:47 +0800
Message-Id: <20240127074754.2380890-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHlxAetrRlWjeACA--.31980S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZryrJF1rCF1fuFyDGF1Utrb_yoW5CFWrpr
	WIqF95Ar4YyrZxZry7Ja4Duay5Zwn2gFyqyry3C3yfJ3Z3trsrGF1Yva4UAFWkGa4fXr1U
	ta15KFW3uFy8Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The new heleprs will be used in dm-raid in later patches to fix
regressions and prevent calling md_reap_sync_thread() directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 33 +++++++++++++++++++++++++++++++--
 drivers/md/md.h |  3 +++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6c5d0a372927..6a76bd27e381 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4915,16 +4915,45 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
 		mddev_lock_nointr(mddev);
 }
 
+void md_idle_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, true);
+}
+EXPORT_SYMBOL_GPL(md_idle_sync_thread);
+
+void md_frozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
+}
+EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
+
+void md_unfrozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	md_wakeup_thread(mddev->thread);
+	sysfs_notify_dirent_safe(mddev->sysfs_action);
+}
+EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
+
 static void idle_sync_thread(struct mddev *mddev)
 {
 	mutex_lock(&mddev->sync_mutex);
-	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
 	if (mddev_lock(mddev)) {
 		mutex_unlock(&mddev->sync_mutex);
 		return;
 	}
 
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev, false, true);
 	mutex_unlock(&mddev->sync_mutex);
 }
@@ -4932,13 +4961,13 @@ static void idle_sync_thread(struct mddev *mddev)
 static void frozen_sync_thread(struct mddev *mddev)
 {
 	mutex_lock(&mddev->sync_mutex);
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
 	if (mddev_lock(mddev)) {
 		mutex_unlock(&mddev->sync_mutex);
 		return;
 	}
 
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev, false, false);
 	mutex_unlock(&mddev->sync_mutex);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc59799..437ab70ce79b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
 extern void md_handle_request(struct mddev *mddev, struct bio *bio);
 extern int mddev_suspend(struct mddev *mddev, bool interruptible);
 extern void mddev_resume(struct mddev *mddev);
+extern void md_idle_sync_thread(struct mddev *mddev);
+extern void md_frozen_sync_thread(struct mddev *mddev);
+extern void md_unfrozen_sync_thread(struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
-- 
2.39.2


