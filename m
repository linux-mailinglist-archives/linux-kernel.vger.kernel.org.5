Return-Path: <linux-kernel+bounces-36691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A883A516
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6992628EC31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253717C6C;
	Wed, 24 Jan 2024 09:18:38 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472D1804F;
	Wed, 24 Jan 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087917; cv=none; b=PXoBuQ8rkWcFlLEkSVEGaaKlXH6PTHV2o/8OI9Ng+neizt8E3+VUdysOxdzUFPmswcDLvQoyqToJc2/7CQhtkuqXeFf1hKrCv9tkPasZNLXMYoD72CrMUlOBOHxx3087qkeX8o8Ep7KbnRknQVHn72oPKCOY9IKwA0ptjExg5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087917; c=relaxed/simple;
	bh=xm2ioImktagySdW6thxgXV5AilNJP9mQwonCGuaB9Ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gEnZF3xBRmnbzQMgwzhRnVqneURDHnBZbK9F1jwoFjsSzF4urIWaHZc2KONDfq6wE0yIaRHWj8ks+2J5Ps3pw0la9theny4NkWEshC0CYtiQX5TUU6uY4p4Bc9/pe3jM5iuZHosNQPf7/ZxzLEfylqWt6DoywYaagUd3yMdjleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TKdcv4jcKz1Q899;
	Wed, 24 Jan 2024 17:16:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 381EF1A0170;
	Wed, 24 Jan 2024 17:18:17 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:15 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
Date: Wed, 24 Jan 2024 17:14:10 +0800
Message-ID: <20240124091421.1261579-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
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
 MD_RECOVERY_RUNNING is set directly;

With patch 1-4, the above test won't hang anymore, however, the test
will still fail and complain that ext4 is corrupted;

Second regression related to frozen sync thread:

Noted that for raid456, if reshape is interrupted, then call
"pers->start_reshape" will corrupt data. This is because dm-raid rely on
md_do_sync() doesn't set MD_RECOVERY_DONE so that new sync_thread won't
be registered, and patch 3 just break this.

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

Tests:

I already run the following two tests many times and verified that they
won't fail anymore:

shell/integrity-caching.sh
shell/lvconvert-raid-reshape.sh

For other tests, I'm still running. However, I'm sending this patchset
in case people think the fixes is not appropriate. Running the full
tests will cost lots of time in my VM, and I'll update full test results
soon.

Yu Kuai (11):
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

 drivers/md/dm-raid.c |  76 +++++++++++++++++++++----------
 drivers/md/md.c      | 104 ++++++++++++++++++++++++++++---------------
 drivers/md/md.h      |  16 +++++++
 drivers/md/raid10.c  |  16 +------
 drivers/md/raid5.c   |  61 +++++++++++++------------
 5 files changed, 171 insertions(+), 102 deletions(-)

-- 
2.39.2


