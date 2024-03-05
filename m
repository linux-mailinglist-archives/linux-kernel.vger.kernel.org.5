Return-Path: <linux-kernel+bounces-91798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C588716CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F45A283107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD97EF10;
	Tue,  5 Mar 2024 07:29:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C77E0E8;
	Tue,  5 Mar 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623773; cv=none; b=jtv5yUC7rxZ2MQDzy1TxyqQwLIK80qcXf84hzlvYxnT7e5Wky71npuN1toEYLFRIdXPK+o/6R+bxWuGUWPHdOqGY8+vDC7+6iLVDNBxN1I9PlFJGD4zyFDP2sfqoQaDSGzEDsEoxbbLVTU/pWVMD3IgEelIiWeYfhibQDkyUGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623773; c=relaxed/simple;
	bh=ojoWb/Jkc5XMZZ+TuEOXOAjzQPzYFCm5VsSiYRYXWDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SREdcTVKV33f5LHSMk3Hg4rKPLZR0YeuM778R/EefDX+iepLllGpacJMG+4vEh/jtP2DfrUOZEm1kARNFQardbtSLEoU6nN5ePawL4Bk+uXx7F6UzI6jA8xk3bO4vGfTm0f+TggFuH8zUUjk5AyYANWPUO1+GGwSahwmbM62N+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpnHy2BjWz4f3lgB;
	Tue,  5 Mar 2024 15:29:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C2E661A016E;
	Tue,  5 Mar 2024 15:29:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHRyeZlGnf+Fw--.17927S4;
	Tue, 05 Mar 2024 15:29:23 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	zkabelac@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	heinzm@redhat.com,
	jbrassow@redhat.com,
	neilb@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.8 v2 0/9] dm-raid, md/raid: fix v6.7 regressions part2
Date: Tue,  5 Mar 2024 15:22:57 +0800
Message-Id: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHRyeZlGnf+Fw--.17927S4
X-Coremail-Antispam: 1UD129KBjvJXoW7try8GFy8Zry5Xr1rCFyDZFb_yoW8WFW7pa
	y3CF13Zw4kAr13ursxW3Wjga4rta1rJrWDJ3sxGw4rZr1UZr1Ikw17tF15WF98ZFyfXr4D
	JF4ay3WUGF1jqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Changes in v2:
 - Change the title from '-next' to 'md-6.8';
 - Add Acked-by tag from Mike;
 - Add Singed-off-by tag from Xiao;

link to part1: https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/

part1 contains fixes for deadlocks for stopping sync_thread

This set contains fixes:
 - reshape can start unexpected, cause data corruption, patch 1,5,6;
 - deadlocks that reshape concurrent with IO, patch 8;
 - a lockdep warning, patch 9;

I'm running lvm2 tests with following scripts with a few rounds now,

for t in `ls test/shell`; do
        if cat test/shell/$t | grep raid &> /dev/null; then
                make check T=shell/$t
        fi
done

There are no deadlocks now, there are still some fs corruption, however,
it's verified there are no new failed tests compared to v6.6.

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


