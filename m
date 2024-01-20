Return-Path: <linux-kernel+bounces-31765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D067E8333B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8677A1F225D0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE614AB9;
	Sat, 20 Jan 2024 10:41:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF412B86;
	Sat, 20 Jan 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747289; cv=none; b=FKsbrMRxQB6d+Uza2CJuNFdgL9+hdkPCaOaa0Plu5piRxWQqaJfg657UlMR43I26LoasVUdHbLjHVUlkRk4LOtyyuAxMJb73qB9614SZ/6Vpeyshz/T2BH/D0bcPjSqng5tByacCqNWhxiO1/GbZRbCOeLZX7S3B2dfbLLb1Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747289; c=relaxed/simple;
	bh=vYtge49+SIPK2TMqk3PqdGYdBsr5TMvfVLJDD/vFH2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uv8fEd0TgWjCJzkNH53aobzlt8gXoQ7EYr9f7SuXHroZArtJNLFhi7WgenGQLcnwZdbV498LN/2RmdG7e2+z7veUdW8gU1swX6CZWuGEVodCaPsvWqh2GRHTlrJp19KvA1dvv3S4Zs20RsU+WJj+XRmnerlL5TubKlm4nmmXpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4THChC0zdZz4f3kG2;
	Sat, 20 Jan 2024 18:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EBD201A0171;
	Sat, 20 Jan 2024 18:41:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFKo6tlY4mmBQ--.38494S9;
	Sat, 20 Jan 2024 18:41:18 +0800 (CST)
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
Subject: [PATCH RFC 5/5] md: use md_reap_sync_thread() directly for dm-raid
Date: Sat, 20 Jan 2024 18:37:34 +0800
Message-Id: <20240120103734.4155446-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RFKo6tlY4mmBQ--.38494S9
X-Coremail-Antispam: 1UD129KBjvJXoWrtr1UWw1xZFWUJw4kWryDJrb_yoW8JrWDp3
	yfWFy5Cr15Crs7Ar17WFyDZFyrZw1S9rWqyr9xCay3Z3W5Jr47Cr1F9FyjgFyDuFWfJwsx
	XF4rJFWfCa48KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that previous patch make sure that stop_sync_thread() can successfully
stop sync_thread, and lvm2 tests won't hang anymore. However, the test
lvconvert-raid-reshape.sh still fail and complain that ext4 is
corrupted.

The root cause is still not clear yet, however, let's convert dm-raid
back to use md_reap_sync_thread() directly. This is not safe but at
least there won't be new regressions. We can decide what to do after
figuring out the root cause.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7db749ba7e60..3e8dd020bf9f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4909,6 +4909,14 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
 	if (work_pending(&mddev->sync_work))
 		flush_work(&mddev->sync_work);
 
+	if (!mddev->gendisk) {
+		mddev_lock_nointr(mddev);
+		md_reap_sync_thread(mddev);
+		if (!locked)
+			mddev_unlock(mddev);
+		return;
+	}
+
 	wait_event(resync_wait,
 		   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)));
-- 
2.39.2


