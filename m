Return-Path: <linux-kernel+bounces-36696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237F83A525
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EF21F2B1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4417C6B;
	Wed, 24 Jan 2024 09:19:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C217C67;
	Wed, 24 Jan 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087991; cv=none; b=ah6oEY/yEnM+qfb2YRw7xCPEch7Cyr1/TivsBEcjDRbCq6FpxF8cICFya6Fyeli+qBH1C6RMujeAPoMr4ti+Gs4MYWxLtVtKm/2MXr9TO+vPrqrAc6QGnndj9QkGXTeu4KXWZ1u3mUjheujGffe8/5LqXGS+7Ls6Z1GcGSBPnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087991; c=relaxed/simple;
	bh=zbq5mTq1vwpbLsA7BkaKJDAM1FT2S8s+HUXg+ohYWY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQ45zWEkvCefaJfzeceRqJ6T1HOHwfb1iGiBhv5DFLW/x1Judj6pHT1QvNcyTmATdB9v0lvHoVBaL3vG1CXtE+MGMxLoQ68Gfpw5aYC8rmJuJrTHnDXr9Hle2r6viNW7H+8he4ckSSZJ7sxFhzGrCpt4e5Qmb9wTDdf+ZSL9yRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TKdgM0wsNz1xmWl;
	Wed, 24 Jan 2024 17:18:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D0591A017B;
	Wed, 24 Jan 2024 17:19:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:21 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 05/11] md: export helpers to stop sync_thread
Date: Wed, 24 Jan 2024 17:14:15 +0800
Message-ID: <20240124091421.1261579-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124091421.1261579-1-yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)

The new heleprs will be used in dm-raid in later patches to fix
regressions and prevent calling md_reap_sync_thread() directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
 drivers/md/md.h |  3 +++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6c5d0a372927..90cf31b53804 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
 		mddev_lock_nointr(mddev);
 }
 
-static void idle_sync_thread(struct mddev *mddev)
+void md_idle_sync_thread(struct mddev *mddev)
 {
+	lockdep_assert_held(mddev->reconfig_mutex);
+
 	mutex_lock(&mddev->sync_mutex);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, true);
+	mutex_unlock(&mddev->sync_mutex);
+}
+EXPORT_SYMBOL_GPL(md_idle_sync_thread);
+
+void md_frozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(mddev->reconfig_mutex);
+
+	mutex_lock(&mddev->sync_mutex);
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
+	mutex_unlock(&mddev->sync_mutex);
+}
+EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
 
+void md_unfrozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(mddev->reconfig_mutex);
+
+	mutex_lock(&mddev->sync_mutex);
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	md_wakeup_thread(mddev->thread);
+	sysfs_notify_dirent_safe(mddev->sysfs_action);
+	mutex_unlock(&mddev->sync_mutex);
+}
+EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
+
+static void idle_sync_thread(struct mddev *mddev)
+{
 	if (mddev_lock(mddev)) {
 		mutex_unlock(&mddev->sync_mutex);
 		return;
 	}
 
+	mutex_lock(&mddev->sync_mutex);
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev, false, true);
 	mutex_unlock(&mddev->sync_mutex);
 }
 
 static void frozen_sync_thread(struct mddev *mddev)
 {
-	mutex_lock(&mddev->sync_mutex);
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-
 	if (mddev_lock(mddev)) {
 		mutex_unlock(&mddev->sync_mutex);
 		return;
 	}
 
+	mutex_lock(&mddev->sync_mutex);
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


