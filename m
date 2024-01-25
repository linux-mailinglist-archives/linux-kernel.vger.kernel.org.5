Return-Path: <linux-kernel+bounces-38041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597F83BA25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12851F22071
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18213FFD;
	Thu, 25 Jan 2024 06:32:48 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69291CD0C;
	Thu, 25 Jan 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164367; cv=none; b=Brlx2cjvSA0XuwcfO4rwIIcfjc9lRGVsVRZjeckGHI1ExTXc7lUGn9ZEb3JpgWWyp4p48xbqr/7AVx9JKQhwZZZB9z4w747rZ4pXzAO4NCLzsoAJveApd/KiUIV2I5CfoVVcuub9bMGlIXlDR42zvs03lMQn/ltctwetzY+uayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164367; c=relaxed/simple;
	bh=WiwXJN35o/DiV4Bsn8H3z66famApJAedNZEEWE3DwPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQeq9q2pwKbpL9rg6R9OHGYGcj+Zicr+EkWYTp+o2HDcfgHJ0wfrYYe3kpoKnXLbk5779DVw9A1P0oFChtOQ51xGWPDdqcQ7ufyAkam62nsvViA1MUGVH17OUc6mSak7QBWPZnvbbFMeOz+SNby1qVnjnUPerUCjviQq4i1vhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TL9x32Lznz4f3k5n;
	Thu, 25 Jan 2024 14:32:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AEEE11A017A;
	Thu, 25 Jan 2024 14:32:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGGALJlUoSmBw--.63362S7;
	Thu, 25 Jan 2024 14:32:41 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	neilb@suse.com,
	shli@fb.com,
	mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 3/4] md: sync blockdev before stopping raid or setting readonly
Date: Thu, 25 Jan 2024 14:28:40 +0800
Message-Id: <20240125062841.1721193-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125062841.1721193-1-linan666@huaweicloud.com>
References: <20240125062841.1721193-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGGALJlUoSmBw--.63362S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4UuryxXry8Xw43tFW5KFg_yoW8ur4UpF
	s2yr13Wr1jy34rXr17Ga1DG3WYg34xKrWDtryfA3W8ZFy3A3sxWFZYgF4FqryDKas3Ga4r
	tw4UAFn5Wa4xtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
with closing other open fds.") added sync_block before stopping raid and
setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
was ignored. Add sync blockdev to array_state_store() now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 40ab5c7ce394..3f1c9a264c8a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4478,6 +4478,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	int err = 0;
 	enum array_state st = match_word(buf, array_states);
+	bool clear_md_closing = false;
 
 	/* No lock dependent actions */
 	switch (st) {
@@ -4487,6 +4488,16 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	case broken:		/* cannot be set */
 	case bad_word:
 		return -EINVAL;
+	case clear:
+	case readonly:
+	case inactive:
+	case read_auto:
+		if (!mddev->pers || !md_is_rdwr(mddev))
+			break;
+		err = mddev_set_closing_and_sync_blockdev(mddev);
+		if (err)
+			return err;
+		clear_md_closing = true;
 	default:
 		break;
 	}
@@ -4512,6 +4523,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		spin_unlock(&mddev->lock);
 		return err ?: len;
 	}
+
 	err = mddev_lock(mddev);
 	if (err)
 		return err;
@@ -4524,6 +4536,8 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		break;
 	case clear:
 		err = do_md_stop(mddev, 0, NULL);
+		if (!err)
+			clear_md_closing = false;
 		break;
 	case readonly:
 		if (mddev->pers)
@@ -4586,6 +4600,10 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 	}
 	mddev_unlock(mddev);
+
+	if (clear_md_closing)
+		clear_bit(MD_CLOSING, &mddev->flags);
+
 	return err ?: len;
 }
 static struct md_sysfs_entry md_array_state =
-- 
2.39.2


