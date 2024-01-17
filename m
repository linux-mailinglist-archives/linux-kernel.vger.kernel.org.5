Return-Path: <linux-kernel+bounces-28743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5683027C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1721F24958
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EB214A93;
	Wed, 17 Jan 2024 09:40:45 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C814004;
	Wed, 17 Jan 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484445; cv=none; b=jRMmWfJfVW2W8O28kGXdlK0X7ol0dZTmpClWfXPmbdoboenjyCum2IJOdaSxXaNavu58A4SVZL6Ln4G2AY4DOOGeWgYkpfOlljvRJ2mtn5GJ6LLn4+cPtnGdlZL6kWPK29vXM71+L3ipmHwOEtx/ipOpFVYJm5y/SsldMPxpyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484445; c=relaxed/simple;
	bh=OiVnCB6oXQEeaIlOVUULWUvKGuAeNeBLGj0dwDEg9hk=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=Qo1jM7ho4xazaJjeeoUxbXi2qGqBxNilG2ASsVHFdIOtcld6x3IGul1VdPu7uonCptZqLd2JHnxPJqg/eyX+tWWShoxvbXb3VWYJzpC4KhsK2L1jg4zT0tdFFjA/Tms5M5V/ovRDaIHAbzTunsu3mLOWlAZrAKTPh2/CkOs2jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TFLTc0F4qz4f3jXX;
	Wed, 17 Jan 2024 17:40:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BB8EC1A101D;
	Wed, 17 Jan 2024 17:40:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGUoKdlvS9nBA--.17816S5;
	Wed, 17 Jan 2024 17:40:39 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	shli@fb.com,
	neilb@suse.com,
	zlliu@suse.com,
	mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 1/3] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Wed, 17 Jan 2024 17:37:05 +0800
Message-Id: <20240117093707.2767209-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117093707.2767209-1-linan666@huaweicloud.com>
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGUoKdlvS9nBA--.17816S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13Zr18XryUAw4DCFy5CFg_yoW8Xr4kpw
	4fJFy5Kwn8K34akrsrXF1kXa4Fq34ftrWvyry29ayrZa4UW347JrZYg3yDKrs8Wr95XFs8
	X3W7JayUW3WkWwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1yIUUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

The raid should not be opened anymore when it is about to be stopped.
However, other processes can open it again if the flag MD_CLOSING is
cleared before exiting. From now on, this flag will not be cleared when
the raid will be stopped.

Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bdd57324c37..4bf821b89415 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6254,7 +6254,15 @@ static void md_clean(struct mddev *mddev)
 	mddev->persistent = 0;
 	mddev->level = LEVEL_NONE;
 	mddev->clevel[0] = 0;
-	mddev->flags = 0;
+	/*
+	 * Don't clear MD_CLOSING, or mddev can be opened again.
+	 * 'hold_active != 0' means mddev is still in the creation
+	 * process and will be used later.
+	 */
+	if (mddev->hold_active)
+		mddev->flags = 0;
+	else
+		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
 	mddev->sb_flags = 0;
 	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
@@ -7728,6 +7736,12 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	case STOP_ARRAY:
 		err = do_md_stop(mddev, 0, bdev);
+		if (!err)
+			/*
+			 * mddev has been stopped, keep flag the
+			 * MD_CLOSING to prevent reuse.
+			 */
+			did_set_md_closing = false;
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-- 
2.39.2


