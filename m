Return-Path: <linux-kernel+bounces-76050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1085F25F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C28286B38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F61B7EB;
	Thu, 22 Feb 2024 08:03:57 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423017BB6;
	Thu, 22 Feb 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589037; cv=none; b=TfbTFTR8mRkF7W677+uX0SzUBVeXwDaKskeRSTi8D6AS7hRPfTh5va0DQLaueEKZ1spw0r2cvAxu3kPofD/NaKtaQsSN8ihV/2hyzrxQtWXzVni96vTBwDgbszU1j2ei9KURcwRqV0hnUbn1GLeo/SWws9k0zJNnln1Fk6kVU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589037; c=relaxed/simple;
	bh=Z0n7pAD254UYraghApQ4/8UxVK58E9XO9dLVWzyEbwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1TVIboKt1IWxZ4NRdMY4PHQiJAOlylC+IfeslCLkIQUMbCTGgUQdwOuAhe3WAZAKFS5PM4UIFBWxBunjn3ceHThWsVM4q6AWbrKvYk59wvovqCNLm6OT5oTWovLmbrV33/O4WKhtcz9QoJYTfMzRUdVXVlkLeJz/Di3jv5RUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgQdB3CcQz4f3kq8;
	Thu, 22 Feb 2024 16:03:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A1FA51A0176;
	Thu, 22 Feb 2024 16:03:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S4;
	Thu, 22 Feb 2024 16:03:42 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: paul.e.luse@linux.intel.com,
	song@kernel.org,
	neilb@suse.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some minor fix
Date: Thu, 22 Feb 2024 15:57:56 +0800
Message-Id: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3ZFyxJF17WF1kJw17GFg_yoW8tr1Up3
	yavFy3Zwn8ZrW3AFn3Zw48G343twn3JFWxJas7Jw4F9r1avFWUA397JrW8CFWDCFy5trn7
	Xr17GrZ7uF1FyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The orignial idea is that Paul want to optimize raid1 read
performance([1]), however, we think that the orignial code for
read_balance() is quite complex, and we don't want to add more
complexity. Hence we decide to refactor read_balance() first, to make
code cleaner and easier for follow up.  

Before this patchset, read_balance() has many local variables and many
braches, it want to consider all the scenarios in one iteration. The
idea of this patch is to devide them into 4 different steps:

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

Yu Kuai (10):
  md: add a new helper rdev_has_badblock()
  md: record nonrot rdevs while adding/removing rdevs to conf
  md/raid1: fix choose next idle in read_balance()
  md/raid1-10: add a helper raid1_check_read_range()
  md/raid1-10: factor out a new helper raid1_should_read_first()
  md/raid1: factor out read_first_rdev() from read_balance()
  md/raid1: factor out choose_slow_rdev() from read_balance()
  md/raid1: factor out choose_bb_rdev() from read_balance()
  md/raid1: factor out the code to manage sequential IO
  md/raid1: factor out helpers to choose the best rdev from
    read_balance()

 drivers/md/md.c       |  28 ++-
 drivers/md/md.h       |  12 ++
 drivers/md/raid1-10.c |  69 +++++++
 drivers/md/raid1.c    | 454 ++++++++++++++++++++++++------------------
 drivers/md/raid10.c   |  66 ++----
 drivers/md/raid5.c    |  35 ++--
 6 files changed, 402 insertions(+), 262 deletions(-)

-- 
2.39.2


