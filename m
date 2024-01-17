Return-Path: <linux-kernel+bounces-28744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3483027F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E731C23D65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60515E80;
	Wed, 17 Jan 2024 09:40:45 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D214005;
	Wed, 17 Jan 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484445; cv=none; b=UCzNYV0A2QLeaNZo6H4C84oKaWP20xTIB8CJAxHBI0HbLOcAft9uF7FLbbbAhwBAF5b+qG3nxlYPUngXTVpslWNCgihDVCvmvsJ1r1czQAwEne2Y5C/Ad10d9SgYnVOrad03r7UZdYJFBqH4faJSbjNR0015xk/bNgv2kgjc5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484445; c=relaxed/simple;
	bh=+x+3AstNH/jlZEVQp/Xzwlu0EpVCjYl0Dxlb3aZMB7s=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=NzVEPdujcZqDuVVwnbFtyqAILGqI2k9G/gUwwdxZihFvGiE/H1CBzj1hHRndJgTV5Q1NwOLf1QkAs6h0Ql5xi/RejQ2AhlY2UL95b73lwiWxHV95WIHW0zaXxB1s/9f14Sh+Ap0YrapZmapWoTfeH68JZF6CPu1ie+UGBQFIWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFLTZ4k80z4f3lVv;
	Wed, 17 Jan 2024 17:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF6111A0C68;
	Wed, 17 Jan 2024 17:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGUoKdlvS9nBA--.17816S7;
	Wed, 17 Jan 2024 17:40:40 +0800 (CST)
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
Subject: [PATCH v2 3/3] md: sync blockdev before stopping raid or setting readonly
Date: Wed, 17 Jan 2024 17:37:07 +0800
Message-Id: <20240117093707.2767209-4-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXaBGUoKdlvS9nBA--.17816S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4UuryxXry8Xw43tFW5KFg_yoW8Cw4rpF
	s2ya45Wr1jqw1fXwnrWayDGa45Gw1xKrWDtrW3A3W8ZFyrZwnxWFZagF4FvryDK3s3Ja4r
	ta1UAFn8Wa4xtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9Z23UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
with closing other open fds.") added sync_block before stopping raid and
setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
was ignored. Add sync blockdev to array_state_store() now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2c793992a604..aea39598457c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4477,6 +4477,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	int err = 0;
 	enum array_state st = match_word(buf, array_states);
+	bool clear_md_closing = false;
 
 	/* No lock dependent actions */
 	switch (st) {
@@ -4511,6 +4512,16 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		spin_unlock(&mddev->lock);
 		return err ?: len;
 	}
+
+	/* we will call set readonly or stop raid, sync blockdev */
+	if (st == clear || (mddev->pers && (st == readonly ||
+	    st == inactive || (st == read_auto && md_is_rdwr(mddev))))) {
+		err = mddev_sync_blockdev(mddev);
+		if (err)
+			return err;
+		clear_md_closing = true;
+	}
+
 	err = mddev_lock(mddev);
 	if (err)
 		return err;
@@ -4523,6 +4534,8 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		break;
 	case clear:
 		err = do_md_stop(mddev, 0, NULL);
+		if (!err)
+			clear_md_closing = false;
 		break;
 	case readonly:
 		if (mddev->pers)
@@ -4585,6 +4598,8 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 	}
 	mddev_unlock(mddev);
+	if (clear_md_closing)
+		clear_bit(MD_CLOSING, &mddev->flags);
 	return err ?: len;
 }
 static struct md_sysfs_entry md_array_state =
-- 
2.39.2


