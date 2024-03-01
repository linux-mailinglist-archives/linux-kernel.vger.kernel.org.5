Return-Path: <linux-kernel+bounces-88226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2486DED8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC001C223EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCA46CDA7;
	Fri,  1 Mar 2024 10:03:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D446BB4F;
	Fri,  1 Mar 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287389; cv=none; b=or1xWsY1WwUnn7JjuNkdb8mhpIT19QeoxHtFogDoxUuPavBMNqS+qPLHGzYt9TbhUKO/jm8vniKsXKYZnw1FDo1kKKuR7NE/Du89diNYwcbT2SYI1w7XEyfoYgCXDgX4Ejzr0dr5771eloe0untOsFzfyUEuapNQwvxDGhoYh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287389; c=relaxed/simple;
	bh=NkhE9vZydeEeuRLbuxoEqrW0HRh9CMnEfpP62kWndPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oos8E+1oLhXn21Vhktm32U0YNVn8TTW2gBHtVjnm4XwWsVvlbIwBjWhRQ3dpx4Mu2q0bGc40HjIrpA0lcx+PdwZvRrn2oX5SGThNSCFiq1osrIWXtIFxQ+dnKcy2Q6z2E6mXnAPqOVHYLYa7g8o7cXdrDgCppsrn6qW6hCHMNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmNv871Khz4f3kp6;
	Fri,  1 Mar 2024 18:03:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 645081A111A;
	Fri,  1 Mar 2024 18:03:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHTp+FlqmBuFg--.36874S6;
	Fri, 01 Mar 2024 18:03:04 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: zkabelac@redhat.com,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	neilb@suse.de,
	jbrassow@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 2/9] md: export helpers to stop sync_thread
Date: Fri,  1 Mar 2024 17:56:50 +0800
Message-Id: <20240301095657.662111-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301095657.662111-1-yukuai1@huaweicloud.com>
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHTp+FlqmBuFg--.36874S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43Gr45Wry5CF1kXr4ktFb_yoW8KF4fpr
	W2qFn5Cr4YyrW3Z347Ga4Dua4Yvwn2gFyktry3C3yfJ3WfJryDGF15Z3WUAFyDGa4fJr1q
	q3W5Kay3ury8Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The new heleprs will be used in dm-raid in later patches to fix
regressions and prevent calling md_reap_sync_thread() directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 29 +++++++++++++++++++++++++++++
 drivers/md/md.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7156e765d027..5f6496cf43f5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4912,6 +4912,35 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
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
diff --git a/drivers/md/md.h b/drivers/md/md.h
index a079ee9b6190..a6d33f10b107 100644
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


