Return-Path: <linux-kernel+bounces-86498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF086C647
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619FC28768B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7364CC1;
	Thu, 29 Feb 2024 10:03:25 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EB63502;
	Thu, 29 Feb 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201005; cv=none; b=GTX5dFBjWbxBOsgA0SZBtkwbM1Xu7+2f96BZz60qpXcGv3VcspK0cVeKt7p6QOve0toraQmsu/cQUIP05k6ojV+93EjBnG63JHOmGPpW4muMA8wBpUIGYsfNdOjkNpIOvY15GTOlnWZKAXLYOMuU/Y/glJ2XZ1Mnit8730MAVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201005; c=relaxed/simple;
	bh=LI79+lN+wYIqz4NOlOpAtm7WOMi4Tp6Qb9OVs4Xtbk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+f/fIWBw/29fuaBeWeb98h8uWSxvJ13RkfH22obhNldYD86DNsYL6aHikKq1HWj0lPI4CLFXYfkAtWI4e3va5SY/rrmGUMul4GjnzaUb1vLXPTGkJvPFWTfKKwCIupmK6tZQkdoH4cNeMDHILt9z2ohSs0P5Net1IKUAbU/nLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxs54pjz4f3jqZ;
	Thu, 29 Feb 2024 18:03:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 19D141A06D9;
	Thu, 29 Feb 2024 18:03:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S4;
	Thu, 29 Feb 2024 18:03:15 +0800 (CST)
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
Subject: [PATCH md-6.9 v4 00/11] md/raid1: refactor read_balance() and some minor fix
Date: Thu, 29 Feb 2024 17:57:03 +0800
Message-Id: <20240229095714.926789-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18XFyfJr13Zr15Kr1UAwb_yoW5XFyfp3
	yavFyfXw4DZrZxAFn7Za1xG34fG3s3JFWxJrn7Ww1F9r1aqrWDt3yfJrWxCFWDCFy3trnr
	Wr43KrZ7uF10ya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - fix a problem in v2, that replacement rdev->raid_disk is set to
 raid_disk + conf->mirros, which will cause test 01replace to run
 forever, and mdadm tests looks good now(no new regression);
Changes in v3:
 - add patch 2, and fix that setup_conf() is missing in patch3;
 - add some review tag from Xiao Ni(other than patch 2,3);
Changes in v2:
 - add new conter in conf for patch 2;
 - fix the case choose next idle while there is no other idle disk in
 patch 3;
 - add some review tag from Xiao Ni for patch 1, 4-8

The original idea is that Paul want to optimize raid1 read
performance([1]), however, we think that the original code for
read_balance() is quite complex, and we don't want to add more
complexity. Hence we decide to refactor read_balance() first, to make
code cleaner and easier for follow up.  

Before this patchset, read_balance() has many local variables and many
branches, it want to consider all the scenarios in one iteration. The
idea of this patch is to divide them into 4 different steps:

1) If resync is in progress, find the first usable disk, patch 5;
Otherwise:
2) Loop through all disks and skipping slow disks and disks with bad
blocks, choose the best disk, patch 10. If no disk is found:
3) Look for disks with bad blocks and choose the one with most number of
sectors, patch 8. If no disk is found:
4) Choose first found slow disk with no bad blocks, or slow disk with
most number of sectors, patch 7.

Note that step 3) and step 4) are super code path, and performance
should not be considered.

And after this patchset, we'll continue to optimize read_balance for
step 2), specifically how to choose the best rdev to read.

[1] https://lore.kernel.org/all/20240102125115.129261-1-paul.e.luse@linux.intel.com/

Yu Kuai (11):
  md: add a new helper rdev_has_badblock()
  md/raid1: factor out helpers to add rdev to conf
  md/raid1: record nonrot rdevs while adding/removing rdevs to conf
  md/raid1: fix choose next idle in read_balance()
  md/raid1-10: add a helper raid1_check_read_range()
  md/raid1-10: factor out a new helper raid1_should_read_first()
  md/raid1: factor out read_first_rdev() from read_balance()
  md/raid1: factor out choose_slow_rdev() from read_balance()
  md/raid1: factor out choose_bb_rdev() from read_balance()
  md/raid1: factor out the code to manage sequential IO
  md/raid1: factor out helpers to choose the best rdev from
    read_balance()

 drivers/md/md.h       |  11 +
 drivers/md/raid1-10.c |  69 ++++++
 drivers/md/raid1.c    | 550 +++++++++++++++++++++++++-----------------
 drivers/md/raid1.h    |   1 +
 drivers/md/raid10.c   |  58 ++---
 drivers/md/raid5.c    |  35 +--
 6 files changed, 444 insertions(+), 280 deletions(-)

-- 
2.39.2


