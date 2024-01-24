Return-Path: <linux-kernel+bounces-36692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8D83A518
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7181F2ACB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE11802E;
	Wed, 24 Jan 2024 09:18:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C717BD9;
	Wed, 24 Jan 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087936; cv=none; b=nXgwP/cwGY2ECHOSqQM6gUeDxixs+DiybRgNEEy7gypjC1FNVBOQdTMRTJ+yxDCRShgLgSIQ3BCQfFq5HMj7Z4xWnBMayd/yp/M+odwuwRwm7uIix79sKDOoNJWQZ0Ae0yB1CbeKA5Olicch7ZNORII1xigMfhr4sidGuM7hmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087936; c=relaxed/simple;
	bh=2sguAUmXQJy+/hHUZSNRGWcK1pkkMCFPkqUUzc67Cms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtwsReNc/A0UuadZaPRoWmmvQZIJKLty8R4RMV1ra7MWIfDGPkRIsUiKn70Tih6dHjSQ7engkX37JjwDp7RJ55DQHbw6Jy8I9prnH3Igvps2dJKGaR3n8LjlqRv9CLj0kgXaZOGgDB25xSzgC2JI4ZFBnIIILuFfCxUgvABNGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TKdZ95hK4z1FJkm;
	Wed, 24 Jan 2024 17:14:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 463891A016E;
	Wed, 24 Jan 2024 17:18:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:17 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 01/11] md: don't ignore suspended array in md_check_recovery()
Date: Wed, 24 Jan 2024 17:14:11 +0800
Message-ID: <20240124091421.1261579-2-yukuai3@huawei.com>
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

mddev_suspend() never stop sync_thread, hence it doesn't make sense to
ignore suspended array in md_check_recovery(), which might cause
sync_thread can't be unregistered.

After commit f52f5c71f3d4 ("md: fix stopping sync thread"), following
hang can be triggered by test shell/integrity-caching.sh:

1) suspend the array:
raid_postsuspend
 mddev_suspend

2) stop the array:
raid_dtr
 md_stop
  __md_stop_writes
   stop_sync_thread
    set_bit(MD_RECOVERY_INTR, &mddev->recovery);
    md_wakeup_thread_directly(mddev->sync_thread);
    wait_event(..., !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))

3) sync thread done:
md_do_sync
 set_bit(MD_RECOVERY_DONE, &mddev->recovery);
 md_wakeup_thread(mddev->thread);

4) daemon thread can't unregister sync thread:
md_check_recovery
 if (mddev->suspended)
   return; -> return directly
 md_read_sync_thread
 clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 -> MD_RECOVERY_RUNNING can't be cleared, hence step 2 hang;

This problem is not just related to dm-raid, fix it by ignoring
suspended array in md_check_recovery(). And follow up patches will
improve dm-raid better to frozen sync thread during suspend.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com/
Fixes: 68866e425be2 ("MD: no sync IO while suspended")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2266358d8074..07b80278eaa5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9469,9 +9469,6 @@ static void md_start_sync(struct work_struct *ws)
  */
 void md_check_recovery(struct mddev *mddev)
 {
-	if (READ_ONCE(mddev->suspended))
-		return;
-
 	if (mddev->bitmap)
 		md_bitmap_daemon_work(mddev);
 
-- 
2.39.2


