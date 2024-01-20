Return-Path: <linux-kernel+bounces-31761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9A8333A7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888E4282DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9941F4E2;
	Sat, 20 Jan 2024 10:41:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6131ED299;
	Sat, 20 Jan 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747283; cv=none; b=AEX7OzCQ/asV2+HkJP87VBD+54ouS5oL5ck6jQb8PWM802NdayF+wUBi9z0IB1eABeSIiq2hw2+ZOikaTvG37mqYLjlc9sKF/fh8KMAgfq6ZMQtw3s7r0++jpvX19GkcyZ0wfAlP5iSS8IW8o0he7yl1//a9w6yAYi/xFjzRwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747283; c=relaxed/simple;
	bh=fWSeSobJcb8/VlAKsgexEgZ0zygnoLBIO2J4LToYTbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWiOeuw4gFQHRVUjKXOj/UJHTMWK2qzs0CYneZr5cC8UeT70SbWdVNeaR5Ct5sG5re1uB+WYot9rPco1VWtdJ8XcjZadmL5Tah4+lduNjT0Y9l6+h3N176Rk2JyPUzyU03XAqff5rstgz/PepMpNYHmKqiOkXbSj9LZ1wOQOOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4THCh62z2vz4f3lCp;
	Sat, 20 Jan 2024 18:41:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 97CD61A0B3B;
	Sat, 20 Jan 2024 18:41:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFKo6tlY4mmBQ--.38494S4;
	Sat, 20 Jan 2024 18:41:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	heinzm@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/5] md: fix/prevent dm-raid regressions
Date: Sat, 20 Jan 2024 18:37:29 +0800
Message-Id: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFKo6tlY4mmBQ--.38494S4
X-Coremail-Antispam: 1UD129KBjvdXoWruFW8Cry7KF4rCrWrJw4kCrg_yoWDWFbEka
	yI9F97Gr1Uu3Z3WayUur4SyryUCFZrWayUXFWDKrW0qry7X34fuF4Dtr4F9ry7ZFWDKF1k
	Cry8Z3yFv3sFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are some problems that we fixed in md/raid, and some apis is changed.
However, dm-raid rely the old apis(noted that old apis is problematic in
corner cases), and now there are regressions in lvm2 testsuite.

This patchset fix some regressions(patch 1-3), and revert changes to
prevent regressions(patch 4,5). Noted that the problems in patch 4,5 is
not clear yet, and I'm not able to locate the root cause ASAP, hence I
decide to revert changes to prevent regressions first.

Yu Kuai (5):
  md: don't ignore suspended array in md_check_recovery()
  md: don't ignore read-only array in md_check_recovery()
  md: make sure md_do_sync() will set MD_RECOVERY_DONE
  md: revert commit fa2bbff7b0b4 ("md: synchronize flush io with array
    reconfiguration") for dm-raid
  md: use md_reap_sync_thread() directly for dm-raid

 drivers/md/md.c | 58 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

-- 
2.39.2


