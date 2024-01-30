Return-Path: <linux-kernel+bounces-43805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D349E841900
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0476A1C24307
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2B36AE5;
	Tue, 30 Jan 2024 02:23:06 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD12364BE;
	Tue, 30 Jan 2024 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581385; cv=none; b=r9fJlb7rKtLnYHGn+8TPt/06OO5fzTRJ/bVZthUyKdV+auqAidZyPeZ5jxCd4/86UufzVOxS4Ojan+8BJUDgkSl2L2zU2FoQYqeZsq85sLL7ky2tJz8iuJNMpZwb5hIIxRO8GLaWxptc1BLz5yMNvztBeIUUuOXkmTS+1o5UTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581385; c=relaxed/simple;
	bh=18vszlirQyD8TnYTZtJHEle4cUSQhFGzUuElgIUgXY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yki0vBbGIudDrZ4CZHNcMTXIvhG1bnnrc+h7K4nM6RmUTO8E6sQDgaEGm9ioxps+q0N/njK72tJukaS+Hy3yYRMSZqqLMIA0ZCUIhNCKU/6BWaRBYt0FfaT5smPsM4X3GmcHZ026tv0KX+bNRxEdh8X9Pc3b3tpkVo/ut+D4KMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP88d11nWz4f3k6X;
	Tue, 30 Jan 2024 10:22:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A62B11A0272;
	Tue, 30 Jan 2024 10:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S4;
	Tue, 30 Jan 2024 10:22:59 +0800 (CST)
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
Subject: [PATCH v4 00/14] dm-raid: fix v6.7 regressions
Date: Tue, 30 Jan 2024 10:18:29 +0800
Message-Id: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4UAF1xZw47XF1fCF1kAFb_yoWxCw45pa
	y3Ga4aqrW8CFn2grZxJ3W8XFy5KFyfJa98Ca43K3y8A345ta4IyrZ5Ka15Wa90kry3Aw4U
	JrWUta45uF1jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - add patch 10 to fix a raid456 deadlock(for both md/raid and dm-raid);
 - add patch 13 to wait for inflight IO completion while removing dm
 device;

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

Test result:

I apply this patchset on top of v6.8-rc1, and run lvm2 tests suite with
folling cmd for 24 round(for about 2 days):

for t in `ls test/shell`; do
        if cat test/shell/$t | grep raid &> /dev/null; then
                make check T=shell/$t
        fi
done

failed count                             failed test
      1 ###       failed: [ndev-vanilla] shell/dmsecuretest.sh
      1 ###       failed: [ndev-vanilla] shell/dmsetup-integrity-keys.sh
      1 ###       failed: [ndev-vanilla] shell/dmsetup-keyring.sh
      5 ###       failed: [ndev-vanilla] shell/duplicate-pvs-md0.sh
      1 ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
      2 ###       failed: [ndev-vanilla] shell/duplicate-vgnames.sh
      1 ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
      1 ###       failed: [ndev-vanilla] shell/integrity.sh
      6 ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
      2 ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
      5 ###       failed: [ndev-vanilla] shell/lvconvert-raid-reshape-stripes-load-reload.sh
      4 ###       failed: [ndev-vanilla] shell/lvconvert-raid-restripe-linear.sh
      1 ###       failed: [ndev-vanilla] shell/lvconvert-raid1-split-trackchanges.sh
     20 ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
     20 ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
     24 ###       failed: [ndev-vanilla] shell/lvextend-raid.sh

And I ramdomly pick some tests verified by hand that these test will
fail in v6.6 as well(not all tests, I don't have the time do do this yet):

shell/lvextend-raid.sh
shell/lvcreate-large-raid.sh
shell/lvconvert-repair-raid.sh
shell/lvchange-rebuild-raid.sh
shell/lvchange-raid1-writemostly.sh

Yu Kuai (14):
  md: don't ignore suspended array in md_check_recovery()
  md: don't ignore read-only array in md_check_recovery()
  md: make sure md_do_sync() will set MD_RECOVERY_DONE
  md: don't register sync_thread for reshape directly
  md: export helpers to stop sync_thread
  dm-raid: really frozen sync_thread during suspend
  md/dm-raid: don't call md_reap_sync_thread() directly
  dm-raid: add a new helper prepare_suspend() in md_personality
  md: export helper md_is_rdwr()
  md: don't suspend the array for interrupted reshape
  md/raid456: fix a deadlock for dm-raid456 while io concurrent with
    reshape
  dm-raid: fix lockdep waring in "pers->hot_add_disk"
  dm: wait for IO completion before removing dm device
  dm-raid: remove mddev_suspend/resume()

 drivers/md/dm-raid.c |  78 +++++++++++++++++++---------
 drivers/md/dm.c      |   3 ++
 drivers/md/md.c      | 120 +++++++++++++++++++++++++++++--------------
 drivers/md/md.h      |  16 ++++++
 drivers/md/raid10.c  |  16 +-----
 drivers/md/raid5.c   |  61 ++++++++++++----------
 6 files changed, 190 insertions(+), 104 deletions(-)

-- 
2.39.2


