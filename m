Return-Path: <linux-kernel+bounces-91805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B948716E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77F61C22230
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223980BF8;
	Tue,  5 Mar 2024 07:29:38 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07E7FBA9;
	Tue,  5 Mar 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623777; cv=none; b=HhbyZC4gk5W1zAlPVkN1rxb0DB9wn8k0fue3xtgQnKVQzNV1ZZPjzau6es8Lpkm0X8PjBQknkqc/1FkiCzNKuJyx2U70q8UDpI3+08/ReCfw6UGdK4Ln6pglPHA51hjaOyR+oNsv0CrCnYlnKn2jur2Vbi/NWlkIFvcOXDTnDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623777; c=relaxed/simple;
	bh=R2YXfoOPVIp/T74tk6RMErRlgJH831cBMUKOY5WBfuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xmw136v+wg8PeMPoQ5DxUb8rMH//BZql9p1SOmrXTOLAtC9cOFbMRzX9w8lG4q55rGr5Mm064PjkfvxvzkeLbBwf5WuUzrb2zq9+3CqCaJi+o0ePYTPWmWMZZQS2Omw8tyB4MLsivEyG6CizfmjR7k89fZkWJcPX8mqS76RVZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TpnJ14MxMz4f3jrg;
	Tue,  5 Mar 2024 15:29:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 051071A0172;
	Tue,  5 Mar 2024 15:29:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHRyeZlGnf+Fw--.17927S6;
	Tue, 05 Mar 2024 15:29:26 +0800 (CST)
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
Subject: [PATCH md-6.8 v2 2/9] md: export helpers to stop sync_thread
Date: Tue,  5 Mar 2024 15:22:59 +0800
Message-Id: <20240305072306.2562024-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHRyeZlGnf+Fw--.17927S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43Gr45Xw4kury8Kr1kuFg_yoW5JrWrpr
	W2qFn5Ar4YyFW3Zry7Ga4Dua4Yvwn2gFyktry3C3yfJ3WfKryDGF15Z3WUAFyDCa4rJr1q
	q3W5KFW3ury8Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/md.c | 29 +++++++++++++++++++++++++++++
 drivers/md/md.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 23f31fd1d024..22e7512a5b1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4919,6 +4919,35 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
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


