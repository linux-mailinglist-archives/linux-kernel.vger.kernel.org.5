Return-Path: <linux-kernel+bounces-31762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8FD8333A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59647B21DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB629F4EE;
	Sat, 20 Jan 2024 10:41:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A07D512;
	Sat, 20 Jan 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747283; cv=none; b=Tm033afJILfVH7gRpq6BcLe5U4J670LBOcidt993OfjwkZp36jz+/mF01Fhm0oTIP9lJAlJS9lH5kNONA3p1blVB4+tF9YJSor4ealAKuRYAk7YsI1OD9aVMUGZEJ7l8RklNCU9jDWA+ByBEF1vHbDZIkATEi23qgpLDRcJOd2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747283; c=relaxed/simple;
	bh=XWCMatNblyNOOG9ZYuVi232xYuylTRA2/wcziHuRmDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djgcRN54rPeUM1X9HFMzVu7zDcifwBLwGb8ai2gPmNr7lKRQ5aiRrsLIjo2r9dawPCCDKYo+KIfRHNiOYke8jEHnDWk5OxpR6h1PZJuHBvGFtvFF8xkmhEiA8BjDSUGfq7AHf+dc/lcE7rZx/YwbS29jW+wi7QBpj1xIHypRp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4THCh72RZ6z4f3lfV;
	Sat, 20 Jan 2024 18:41:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 84A7B1A0172;
	Sat, 20 Jan 2024 18:41:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFKo6tlY4mmBQ--.38494S6;
	Sat, 20 Jan 2024 18:41:17 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	heinzm@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/5] md: don't ignore read-only array in md_check_recovery()
Date: Sat, 20 Jan 2024 18:37:31 +0800
Message-Id: <20240120103734.4155446-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFKo6tlY4mmBQ--.38494S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fXFy5AF1DCr1rAFWfuFg_yoW8Kw1rpa
	yfKas8WrW8XF93ZrZrK3WDXay5uw10vrWjyry3u34fAw1rtr43C345uF1UAFWkJa4Fva1j
	v3WrJF43ZFy8Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If array is read-only and md_do_sync() is done. Currently
md_check_recovery() ignore this case, henc sync_thread can't be
unregistered.

Before this patch, use stop_sync_thread() directly for read-only
array will hang because md_check_recovery() can't clear
MD_RECOVERY_RUNNING, which is possible for dm-raid.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 07b80278eaa5..6906d023f1d6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9445,6 +9445,20 @@ static void md_start_sync(struct work_struct *ws)
 		sysfs_notify_dirent_safe(mddev->sysfs_action);
 }
 
+static void unregister_sync_thread(struct mddev *mddev)
+{
+	if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
+		/* resync/recovery still happening */
+		clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!mddev->sync_thread))
+		return;
+
+	md_reap_sync_thread(mddev);
+}
+
 /*
  * This routine is regularly called by all per-raid-array threads to
  * deal with generic issues like resync and super-block update.
@@ -9482,7 +9496,8 @@ void md_check_recovery(struct mddev *mddev)
 	}
 
 	if (!md_is_rdwr(mddev) &&
-	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) &&
+	    !test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9504,8 +9519,7 @@ void md_check_recovery(struct mddev *mddev)
 			struct md_rdev *rdev;
 
 			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-				/* sync_work already queued. */
-				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+				unregister_sync_thread(mddev);
 				goto unlock;
 			}
 
@@ -9568,16 +9582,7 @@ void md_check_recovery(struct mddev *mddev)
 		 * still set.
 		 */
 		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-			if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
-				/* resync/recovery still happening */
-				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				goto unlock;
-			}
-
-			if (WARN_ON_ONCE(!mddev->sync_thread))
-				goto unlock;
-
-			md_reap_sync_thread(mddev);
+			unregister_sync_thread(mddev);
 			goto unlock;
 		}
 
-- 
2.39.2


