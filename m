Return-Path: <linux-kernel+bounces-88225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98A86DED6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C167828274D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4E6BFDD;
	Fri,  1 Mar 2024 10:03:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747A6A8C7;
	Fri,  1 Mar 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287389; cv=none; b=rc4O7xg5QiP4JO9OvFxHQI3n4o918vBBKsePx8G+DIlEfJ5tBycaqKPlmHoz2mz0eH0dMRu+P7jLxTHNP9vaGTxCqSXtQVZSavu2SPfjAN7RyYx7psLFD3+xiaAxwn6rip8aT5+F3t6So/RmP+SL9c5LRPpenWxg3C25ckhk0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287389; c=relaxed/simple;
	bh=J52L3K3Rhj2ycHk6q4bGsLwgKiV0fudWxJabzPa7F64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ayZT+ddJ254U1SoIYYJdaZ4G6dwkbYOXfhJsIE8PoGkrGL8vksNynOS675QcEEjmnAhirQUpeVUp5NNRNJc6BvTOIBV0w5SV+OosxN7V3wzPrdxh1/+hIX6TwdY8T4sCtIZ3pvhwdG3NNmXZ8Vqw5NaQy1kqa1TdVGYrx8Cto+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmNv35nDgz4f3nbN;
	Fri,  1 Mar 2024 18:02:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 30E011A0838;
	Fri,  1 Mar 2024 18:03:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHTp+FlqmBuFg--.36874S4;
	Fri, 01 Mar 2024 18:03:01 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: zkabelac@redhat.com,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	neilb@suse.de,
	jbrassow@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
Date: Fri,  1 Mar 2024 17:56:48 +0800
Message-Id: <20240301095657.662111-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHTp+FlqmBuFg--.36874S4
X-Coremail-Antispam: 1UD129KBjvJXoW7try8GFy8Zry5Xr1rCFyDZFb_yoW8CFW3pF
	ZxGa4av34kAF17XrnxJ3WjqF15ta1fGFWDA343Gw4rAr4UJry0yrn8tr15Was8CryrZanr
	JFW5t3W5GF1jqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

link to part1: https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/

part1 contains fixes for deadlocks for stopping sync_thread

This set contains fixes:
 - reshape can start unexpected, cause data corruption, patch 1,5,6;
 - deadlocks that reshape concurrent with IO, patch 8;
 - a lockdep warning, patch 9;

I'm runing lvm2 tests with following scripts with a few rounds now,

for t in `ls test/shell`; do
        if cat test/shell/$t | grep raid &> /dev/null; then
                make check T=shell/$t
        fi
done

There are no deadlock and no fs corrupt now, however, there are still four
failed tests:

###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
###       failed: [ndev-vanilla] shell/lvextend-raid.sh

And failed reasons are the same:

## ERROR: The test started dmeventd (147856) unexpectedly

I have no clue yet, and it seems other folks doesn't have this issue.

Yu Kuai (9):
  md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
  md: export helpers to stop sync_thread
  md: export helper md_is_rdwr()
  md: add a new helper reshape_interrupted()
  dm-raid: really frozen sync_thread during suspend
  md/dm-raid: don't call md_reap_sync_thread() directly
  dm-raid: add a new helper prepare_suspend() in md_personality
  dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
    concurrent with reshape
  dm-raid: fix lockdep waring in "pers->hot_add_disk"

 drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++----------
 drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
 drivers/md/md.h      | 38 +++++++++++++++++-
 drivers/md/raid5.c   | 32 ++++++++++++++-
 4 files changed, 196 insertions(+), 40 deletions(-)

-- 
2.39.2


