Return-Path: <linux-kernel+bounces-84970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00686AE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C53283519
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972A15A4A5;
	Wed, 28 Feb 2024 11:49:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1F70CC6;
	Wed, 28 Feb 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120983; cv=none; b=adw8I0wFC3jC8Hdbl65KbCvfq17klaRjUh6Nj1AuB4PLNXhsuCqCqYkeOCLWLhFFei9Exixwp/1WyXecXuCweHgUzanfjBLcEbbdi2XXaiy5F9XgJGm2l6+T7QLj8GVGmvV7Kx6Yn/VPvfZ/ix25Z9wqT3B/FCLI7Ihssn6kKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120983; c=relaxed/simple;
	bh=l2G/1qEl98q1TYO9oqz/qk+59OES667Qv9XxJOAY2EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TEltry2n/OjLcQnTKn2zyfJHGS1rhT3UISBcy/L8IWDHxpEe7ro4lBHipt2nvtSFUuS1ONKyFh9tLxRYDgsvMHjrdx862cZeAJ9P/nEbR20ciShbaHXJPfR22iyqh07cIlqsKMdizsZ4LW4ICwcIpNE1EX7hTMqML/n933ciLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TlCLt3lRhz4f3jd7;
	Wed, 28 Feb 2024 19:49:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BD5B61A01B9;
	Wed, 28 Feb 2024 19:49:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7IHd9l+eamFQ--.6969S4;
	Wed, 28 Feb 2024 19:49:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v3 00/11] md/raid1: refactor read_balance() and some minor fix
Date: Wed, 28 Feb 2024 19:43:22 +0800
Message-Id: <20240228114333.527222-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7IHd9l+eamFQ--.6969S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xCFW7tr4rurWxZw15CFg_yoW5Jw4xp3
	yavFyfXw4DZrW3AFn7Za18G34fJwn3JFWxJFn7tw4F9r1avrWUt3yfJrW8CFWDCry3trnr
	Wr43GrZ7uF1vyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
	J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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
 drivers/md/raid1.c    | 539 +++++++++++++++++++++++++-----------------
 drivers/md/raid1.h    |   1 +
 drivers/md/raid10.c   |  58 ++---
 drivers/md/raid5.c    |  35 +--
 6 files changed, 437 insertions(+), 276 deletions(-)

-- 
2.39.2


