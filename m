Return-Path: <linux-kernel+bounces-47867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E18453EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA5828A76F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456715CD75;
	Thu,  1 Feb 2024 09:30:33 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09C15B0FA;
	Thu,  1 Feb 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779833; cv=none; b=WzIam8dU4qsg7PQns4TbiNPhEHmUIn+RQiTGo/44z98FTkEaWK0PQUEOHXWhfaarAm711eTjmM5qmfzrXKNI9tLRXXIlmXRGzW9XD/UohPbQq3XqTS6zqL/Ogq9QBLHoMfKjkvNGHYVgmlsv9b6U1WgtPs3QreiQ7DzWrep3ZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779833; c=relaxed/simple;
	bh=uuJ8tRuvIPDNbFzYKdOhbv8+B/r7ZvglzLK7hF7sQ34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBsnh8XhONeF4sLhi1VgtPYw9eW7kKHSBQw2goGgm2duwbav5jRmJvGEovGM2V/FeUrIVbIr8n2nrUrQk1oMMS8llmhEmdRn5FE/8etjpr6TPv4fQrUedQ3TD5Tcg7C31CNjjyext9TcmD0fjr7oLYzlshokt7bd3ahYpuX5gWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQYXt6xxWz4f3l7J;
	Thu,  1 Feb 2024 17:30:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2E25B1A0232;
	Thu,  1 Feb 2024 17:30:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S7;
	Thu, 01 Feb 2024 17:30:26 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	blazej.kucman@linux.intel.com,
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
Subject: [PATCH v5 03/14] md: make sure md_do_sync() will set MD_RECOVERY_DONE
Date: Thu,  1 Feb 2024 17:25:48 +0800
Message-Id: <20240201092559.910982-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48JF18KF48Xr1fZFW7twb_yoW8tr1rpF
	WkCF98ZrW8ArW7urW2qa4UZFy5Ar10qrW7CFyfW34rAF13Kw4akryjkFyUXFWqkFWxJw4F
	vFs8JFZ8uF95C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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


