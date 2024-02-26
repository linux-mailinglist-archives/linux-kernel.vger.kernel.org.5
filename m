Return-Path: <linux-kernel+bounces-80459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B578668A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E661F21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1E1BC57;
	Mon, 26 Feb 2024 03:20:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1012E7C;
	Mon, 26 Feb 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917642; cv=none; b=nL2lbDJ+954H9EWucAMXZoz87NI5z1rZWdHT+NJZh2Z0324yjZP37AA3ihdkwnyDZ7EAS0ltNIECI5ZXPdw2GvvFo+Q4TiwzGdpDD4tFKRGXOHdnwjDPvqM0qDpnF9uNbXGea6yKjSsbLi47rhyDWkLzRnn0vxl+r9vq1r+F6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917642; c=relaxed/simple;
	bh=EAoH9fiyipph/aMWa/iXsmHMM0w0EiUAeeA+Y5DOTEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxLybuGG5qwQ6qaKiK+mDgeesNfX+9px1on/tMEOX/2qockWcXxZPd0J/wIXMAwq7tAhu65HJALa4NtqtoolIvqD/VdSl7le96LczqCakIw9Jy4RJuvHVN12z/BMOLEyvds9u9mf117UECOYABIjuLfSs/vYF/UFf0K7pv+3yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8Y6dmmz4f3mHV;
	Mon, 26 Feb 2024 11:20:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 355DE1A0BA7;
	Mon, 26 Feb 2024 11:20:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S11;
	Mon, 26 Feb 2024 11:20:37 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: mariusz.tkaczyk@linux.intel.com,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v7 7/9] md: sync blockdev before stopping raid or setting readonly
Date: Mon, 26 Feb 2024 11:14:42 +0800
Message-Id: <20240226031444.3606764-8-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226031444.3606764-1-linan666@huaweicloud.com>
References: <20240226031444.3606764-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4UuryxXry8Xw43tFW5KFg_yoW8XrWfpF
	4vyr15Wr1Dt34ftwsrWa1kWa45Was7tFWDKrW3Z348ZFy7AwnxGFZagFWYvryDK34fGFyS
	qw4UJFn8Wa4xtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbxR67UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
with closing other open fds.") added sync_block before stopping raid and
setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
was ignored. Add sync blockdev to array_state_store() now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index cba1027b279e..fe0c7c80fb5e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4500,6 +4500,17 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	case broken:		/* cannot be set */
 	case bad_word:
 		return -EINVAL;
+	case clear:
+	case readonly:
+	case inactive:
+	case read_auto:
+		if (!mddev->pers || !md_is_rdwr(mddev))
+			break;
+		/* write sysfs will not open mddev and opener should be 0 */
+		err = mddev_set_closing_and_sync_blockdev(mddev, 0);
+		if (err)
+			return err;
+		break;
 	default:
 		break;
 	}
@@ -4599,6 +4610,11 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 	}
 	mddev_unlock(mddev);
+
+	if (st == readonly || st == read_auto || st == inactive ||
+	    (err && st == clear))
+		clear_bit(MD_CLOSING, &mddev->flags);
+
 	return err ?: len;
 }
 static struct md_sysfs_entry md_array_state =
-- 
2.39.2


