Return-Path: <linux-kernel+bounces-86507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0E86C65A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D8FB260AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59966B2D;
	Thu, 29 Feb 2024 10:03:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164763503;
	Thu, 29 Feb 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201006; cv=none; b=SpiwikT3gMteluLUiK5WOpPAMrxlY/p8jw88jW04D3bTOjJAB+nBe3/U0QGg1ZAA39woRJSyrMc256hXbptCDDiDivFcRYsIfOQxPh4YforHubK0J+ZnfCMYENHHf4CgwQYWNFHc8aH3OyusPjB+5je1Tqq3qVngXf/nwSd7Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201006; c=relaxed/simple;
	bh=QYOlqih7BF6kX5BYdwF9n3/QSS94mDOA3t9MJUII4Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIonyfpfHsD8U9I2dqzI6POlmSHXYuxSe6O63JcwW91aCH6UR1Eoqn3G1ZpcXkffnYs1H6BrVhCFKMATf8plA67PFDbQ37s+n8JFBUO7rxIn+NS9w93tiAQcAIsN+D4tvxgvDutxenOrDuEgTM+FvFJV6YO3mnYHcH1WMCLVvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxr0MyFz4f3mHM;
	Thu, 29 Feb 2024 18:03:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 661FB1A1332;
	Thu, 29 Feb 2024 18:03:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S9;
	Thu, 29 Feb 2024 18:03:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	neilb@suse.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v4 05/11] md/raid1-10: add a helper raid1_check_read_range()
Date: Thu, 29 Feb 2024 17:57:08 +0800
Message-Id: <20240229095714.926789-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229095714.926789-1-yukuai1@huaweicloud.com>
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S9
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8Zw15tF1rurW5CF4kWFg_yoW8KFy5pr
	4Yya43tr1UK3y3W3W3uF1xC34FyayfWFW8GrWfX3WDWry5Ga9akF97JryjgFyDWry3Xw12
	qa1j9rWxua47CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The checking and handler of bad blocks appear many timers during
read_balance() in raid1 and raid10. This helper will be used in later
patches to simplify read_balance() a lot.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1-10.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 512746551f36..9bc0f0022a6c 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -227,3 +227,52 @@ static inline bool exceed_read_errors(struct mddev *mddev, struct md_rdev *rdev)
 
 	return false;
 }
+
+/**
+ * raid1_check_read_range() - check a given read range for bad blocks,
+ * available read length is returned;
+ * @rdev: the rdev to read;
+ * @this_sector: read position;
+ * @len: read length;
+ *
+ * helper function for read_balance()
+ *
+ * 1) If there are no bad blocks in the range, @len is returned;
+ * 2) If the range are all bad blocks, 0 is returned;
+ * 3) If there are partial bad blocks:
+ *  - If the bad block range starts after @this_sector, the length of first
+ *  good region is returned;
+ *  - If the bad block range starts before @this_sector, 0 is returned and
+ *  the @len is updated to the offset into the region before we get to the
+ *  good blocks;
+ */
+static inline int raid1_check_read_range(struct md_rdev *rdev,
+					 sector_t this_sector, int *len)
+{
+	sector_t first_bad;
+	int bad_sectors;
+
+	/* no bad block overlap */
+	if (!is_badblock(rdev, this_sector, *len, &first_bad, &bad_sectors))
+		return *len;
+
+	/*
+	 * bad block range starts offset into our range so we can return the
+	 * number of sectors before the bad blocks start.
+	 */
+	if (first_bad > this_sector)
+		return first_bad - this_sector;
+
+	/* read range is fully consumed by bad blocks. */
+	if (this_sector + *len <= first_bad + bad_sectors)
+		return 0;
+
+	/*
+	 * final case, bad block range starts before or at the start of our
+	 * range but does not cover our entire range so we still return 0 but
+	 * update the length with the number of sectors before we get to the
+	 * good ones.
+	 */
+	*len = first_bad + bad_sectors - this_sector;
+	return 0;
+}
-- 
2.39.2


