Return-Path: <linux-kernel+bounces-36694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE783A51F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA221C212E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D718182BE;
	Wed, 24 Jan 2024 09:19:21 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0D17BC6;
	Wed, 24 Jan 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087961; cv=none; b=J64Ua011OzMDLoAv9HHKTrO/epFTZQ7NnxbAvUALxxMf1ANx5uSmTs3+yDZ9dkFe6UiMQtaO4jXiHdMkov5zpWONzHpu79EJt67VL1w44JFS5wWj1ZQV0X5xiRmsoCgHvtGbKGL6blYXLx7XD4sAwysfLuW9dX9RiHIQnHr6v5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087961; c=relaxed/simple;
	bh=UUDMydkf3OhAgyA/75Pu09FbhTIJc5xXjjkQoQ6FzIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfo9ZFddZuCB9ShYuOfubArgJ4vK7AIQV8VT47/V47VydRNuabirXUtD6wsMOn4SJ27ETXkc12QL0Ou8k9u9toKyzAyo9B003u6v3MmdCsnvNu94piIWDhZEMnFu+J6o1CMCUnyB6Uqx5vGDT+CZX2RgSYAYID0dDMVklTpYEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TKddn2Vtlz1gxy6;
	Wed, 24 Jan 2024 17:17:33 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 616B31A016C;
	Wed, 24 Jan 2024 17:19:02 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:19 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 03/11] md: make sure md_do_sync() will set MD_RECOVERY_DONE
Date: Wed, 24 Jan 2024 17:14:13 +0800
Message-ID: <20240124091421.1261579-4-yukuai3@huawei.com>
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

stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
stop_sync_thread().

If MD_RECOVERY_WAIT is set or the array is read-only, md_do_sync() will
return without setting MD_RECOVERY_DONE, and after commit f52f5c71f3d4
("md: fix stopping sync thread"), dm-raid switch from
md_reap_sync_thread() to stop_sync_thread() to unregister sync_thread
from md_stop() and md_stop_writes(), causing the test
shell/lvconvert-raid-reshape.sh hang.

We shouldn't switch back to md_reap_sync_thread() because it's
problematic in the first place. Fix the problem by making sure
md_do_sync() will set MD_RECOVERY_DONE.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/ece2b06f-d647-6613-a534-ff4c9bec1142@redhat.com/
Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
Fixes: 5fd6c1dce06e ("[PATCH] md: allow checkpoint of recovery with version-1 superblock")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6906d023f1d6..c65dfd156090 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8788,12 +8788,16 @@ void md_do_sync(struct md_thread *thread)
 	int ret;
 
 	/* just incase thread restarts... */
-	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
-	    test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
+	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 		return;
-	if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
+
+	if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
+		goto skip;
+
+	if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
+	    !md_is_rdwr(mddev)) {/* never try to sync a read-only array */
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-		return;
+		goto skip;
 	}
 
 	if (mddev_is_clustered(mddev)) {
-- 
2.39.2


