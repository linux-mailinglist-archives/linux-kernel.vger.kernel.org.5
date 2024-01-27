Return-Path: <linux-kernel+bounces-41091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F183EBBF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44600B22F47
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F31DFC5;
	Sat, 27 Jan 2024 07:52:11 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4F12E6F;
	Sat, 27 Jan 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341930; cv=none; b=M7WVm97cuxwGHW8ve6U724e9J2woqWe4wrE1kQ0Gv64gjR2TFjD2IxBLremDTEE9cy3ViuxK4UtKKRNLpi1cMbZK7ieTopR/ESux1GbXfK5Q+3pzFoQqEOtwwN6w0d7/Yj6cvm5ih22AMbftA2i2yoB3suYF+tFI8kvX9O+U+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341930; c=relaxed/simple;
	bh=/Ybye6PWoySu8VSP7PYa3l3zDDKfQ8lhm0y1fIuw9iY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ni6HwknHb3eCVK+nkiYWTS0sRtfExpFyLCXx5IFnW8szgXKYkMj3Ip23Zc2OUbMSWu0p/RMcL/GmK7BBDsaq0g2OX4JMCwsGQxW4ZvK7w18EK02qQIUukuQ90U6wnd6Qc9GjD5fgPNQQiulWF1d5T77lGqJxkwIZMaUKKs+ldyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMRbg6BPVz4f3jYJ;
	Sat, 27 Jan 2024 15:51:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D77B71A0232;
	Sat, 27 Jan 2024 15:52:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAetrRlWjeACA--.31980S4;
	Sat, 27 Jan 2024 15:52:00 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
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
Subject: [PATCH v3 00/12] dm-raid: fix v6.7 regressions
Date: Sat, 27 Jan 2024 15:47:42 +0800
Message-Id: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAetrRlWjeACA--.31980S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xZw4rCr15WFyxXr1kZrb_yoW7Jry5pa
	yakw13Xr4UCrn7urZ3J3W0qa45Kas5JrW5Gr9xJ34rAw1YyFyIyrW8GayUWFWDAFy3Jw45
	tr45Ka4F9a4YyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	QVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - fix a problem in patch 5;
 - add patch 12;

Changes in v2:
 - replace revert changes for dm-raid with real fixes;
 - fix dm-raid5 deadlock that exist for a long time, this deadlock is
 triggered because another problem is fixed in raid5, and instead of
 deadlock, user will read wrong data before v6.7, patch 9-11;

First regression related to stop sync thread:

The lifetime of sync_thread is designed as following:

1) Decide want to start sync_thread, set MD_RECOVERY_NEEDED, and wake up
daemon thread;
2) Daemon thread detect that MD_RECOVERY_NEEDED is set, then set
MD_RECOVERY_RUNNING and register sync_thread;
3) Execute md_do_sync() for the actual work, if it's done or
interrupted, it will set MD_RECOVERY_DONE and wake up daemone thread;
4) Daemon thread detect that MD_RECOVERY_DONE is set, then clear
MD_RECOVERY_RUNNING and unregister sync_thread;

In v6.7, we fix md/raid to follow this design by commit f52f5c71f3d4
("md: fix stopping sync thread"), however, dm-raid is not considered at
that time, and following test will hang:

shell/integrity-caching.sh
shell/lvconvert-raid-reshape.sh

This patch set fix the broken test by patch 1-4;
 - patch 1 fix that step 4) is broken by suspended array;
 - patch 2 fix that step 4) is broken by read-only array;
 - patch 3 fix that step 3) is broken that md_do_sync() doesn't set
 MD_RECOVERY_DONE; Noted that this patch will introdece new problem that
 data will be corrupted, which will be fixed in later patches.
 - patch 4 fix that setp 1) is broken that sync_thread is register and
 MD_RECOVERY_RUNNING is set directly, md/raid behaviour, not related to
 dm-raid;

With patch 1-4, the above test won't hang anymore, however, the test
will still fail and complain that ext4 is corrupted;

Second regression related to frozen sync thread:

Noted that for raid456, if reshape is interrupted, then call
"pers->start_reshape" will corrupt data. And dm-raid rely on md_do_sync()
doesn't set MD_RECOVERY_DONE so that new sync_thread won't be registered,
and patch 3 just break this.

 - Patch 5-6 fix this problem by interrupting reshape and frozen
 sync_thread in dm_suspend(), then unfrozen and continue reshape in
dm_resume(). It's verified that dm-raid tests won't complain that
ext4 is corrupted anymore.
 - Patch 7 fix the problem that raid_message() call
 md_reap_sync_thread() directly, without holding 'reconfig_mutex'.

Last regression related to dm-raid456 IO concurrent with reshape:

For raid456, if reshape is still in progress, then IO across reshape
position will wait for reshape to make progress. However, for dm-raid,
in following cases reshape will never make progress hence IO will hang:

1) the array is read-only;
2) MD_RECOVERY_WAIT is set;
3) MD_RECOVERY_FROZEN is set;

After commit c467e97f079f ("md/raid6: use valid sector values to determine
if an I/O should wait on the reshape") fix the problem that IO across
reshape position doesn't wait for reshape, the dm-raid test
shell/lvconvert-raid-reshape.sh start to hang at raid5_make_request().

For md/raid, the problem doesn't exist because:

1) If array is read-only, it can switch to read-write by ioctl/sysfs;
2) md/raid never set MD_RECOVERY_WAIT;
3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
   'reconfig_mutex' anymore, it can be cleared and reshape can continue by
   sysfs api 'sync_action'.

However, I'm not sure yet how to avoid the problem in dm-raid yet.

 - patch 9-11 fix this problem by detecting the above 3 cases in
 dm_suspend(), and fail those IO directly.

If user really meet the IO error, then it means they're reading the wrong
data before c467e97f079f. And it's safe to read/write the array after
reshape make progress successfully.

There are also some other minor changes: patch 8 and patch 12;

Yu Kuai (12):
  md: don't ignore suspended array in md_check_recovery()
  md: don't ignore read-only array in md_check_recovery()
  md: make sure md_do_sync() will set MD_RECOVERY_DONE
  md: don't register sync_thread for reshape directly
  md: export helpers to stop sync_thread
  dm-raid: really frozen sync_thread during suspend
  md/dm-raid: don't call md_reap_sync_thread() directly
  dm-raid: remove mddev_suspend/resume()
  dm-raid: add a new helper prepare_suspend() in md_personality
  md: export helper md_is_rdwr()
  md/raid456: fix a deadlock for dm-raid456 while io concurrent with
    reshape
  dm-raid: fix lockdep waring in "pers->hot_add_disk"

 drivers/md/dm-raid.c | 78 ++++++++++++++++++++++++-----------
 drivers/md/md.c      | 96 ++++++++++++++++++++++++++++----------------
 drivers/md/md.h      | 16 ++++++++
 drivers/md/raid10.c  | 16 +-------
 drivers/md/raid5.c   | 61 +++++++++++++++-------------
 5 files changed, 167 insertions(+), 100 deletions(-)

-- 
2.39.2


