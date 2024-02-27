Return-Path: <linux-kernel+bounces-83166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE62868FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DCC1C213E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFAB13AA2C;
	Tue, 27 Feb 2024 12:09:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C813A254;
	Tue, 27 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035770; cv=none; b=YFKXC/EqKx6xp3T8HlLAIXheXEkF1teldQqaPhHlbij9wPq3Ret85nQdNGbVW8QwJz8/w38SWgLVD4idwH5ZXSg/1zuHD1U1Zsmv5DQyKKGUwQgfuhBznuZlmKOLSpvwuMoNQ5JuT22I4l0fodHS951rN7Ydfdn4eed7W6Ac9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035770; c=relaxed/simple;
	bh=kUwH7DmIMW/4Ko5W7N5/xUBfhD7XJme0RnuZkmCPsvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6KTSfDZo02jJHpr+hFKgtM04ULScv/B/y7M9tmEaRDrCwsUOzOK2BcyFN2KnjX7dY4t+k57o65m+IHUJ4orDXpSzKBPezb2nfFC3Hefhx7/5t1lTIjCRh0A9e6mQCPqCON1H7ubCB/EtJMdQ01aCQBExoykdG8l6acaEeYblCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkbrG3ZxSz4f3jMp;
	Tue, 27 Feb 2024 20:09:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AEEC61A016E;
	Tue, 27 Feb 2024 20:09:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S4;
	Tue, 27 Feb 2024 20:09:21 +0800 (CST)
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
Subject: [PATCH md-6.9 v2 00/10] md/raid1: refactor read_balance() and some minor fix
Date: Tue, 27 Feb 2024 20:03:17 +0800
Message-Id: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fGF13WFW8tw15Zr1DZFb_yoW8KF1Dp3
	yY9FyfXw4DZrW3AFn3Za18G34fJwn3JFWxJr97t34F9r1avrWUt393JrW8CFWDCry5trn7
	Wr47GrZ7uF10yFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Yu Kuai (10):
  md: add a new helper rdev_has_badblock()
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
 drivers/md/raid1-10.c |  69 +++++++
 drivers/md/raid1.c    | 465 +++++++++++++++++++++++++-----------------
 drivers/md/raid1.h    |   1 +
 drivers/md/raid10.c   |  58 ++----
 drivers/md/raid5.c    |  35 ++--
 6 files changed, 391 insertions(+), 248 deletions(-)

-- 
2.39.2


