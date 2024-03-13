Return-Path: <linux-kernel+bounces-101919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3887ACB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF09C1F30009
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52F12B154;
	Wed, 13 Mar 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8dPBsWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917412AAE3;
	Wed, 13 Mar 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348060; cv=none; b=pj3QwTGy2g7VkwPtM6beNMv+fhcq1r6PXZQZi95BAPClhLg5WyR2wXD6PZ7RhDSDmyyQQx0OvFadsXnRFo0QGo6AI5x0KR0VHw8CqPNdyHyOqsbTUN2kkMbjfcC3l0i5PK267rDurK6nA2piFaJEhZPaftReKNMmS4kBVIqWQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348060; c=relaxed/simple;
	bh=8soo9GS6UNsR2dW5H5WpZNode4KvqgLlTEAzK/XQhqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOlJhV9HuN3iPjI3CkdoK7V1cynO6z5UfVKIdJxTLMGsOuz9VwnJ8Co27CJx/sOUXZd80Sa0yJCuw4h7+12Obl6C+pDU7aUYe37krxxgP0EgBKkt3lwoSbGl3LPG7RSHHEJAEB8o5GMnCIxwUf5lqLaUynScJZLscarZanUJ0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8dPBsWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089AFC433F1;
	Wed, 13 Mar 2024 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348059;
	bh=8soo9GS6UNsR2dW5H5WpZNode4KvqgLlTEAzK/XQhqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8dPBsWqkqIoNqBUAmG1ij2OtTz+dA65iHYMdfCArYnyVmJKJiJp+yai8ZqnPd9eC
	 wu+eZ2cISE5tM28ALvSLkvsRQ+KQxGPHUult+xwp+sm/vNvqrcEBRvz3M5lh9GL2D0
	 bnfKb2p124e88LrK2PSRsNkanKROhOZaW20CaJcf4YFljUUHUv+A0ysD33xnTzb8Hd
	 3ei+1BbfFuTzo0/rAdmn5CCvNi//jtJ8sx9tPQpMtmE2R44YF991lKvVS6vuRY53JD
	 /H5usHdI1EEsj4IqEI57bY7oxwMjm/pTzMBb962J6YYjr0xjemodSuueenRy9Fx3dA
	 K28kQH3akgKQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 51/71] elevator: add new field flags in struct elevator_queue
Date: Wed, 13 Mar 2024 12:39:37 -0400
Message-ID: <20240313163957.615276-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 181d06637451b5348d746039478e71fa53dfbff6 ]

There are only one flag to indicate that elevator is registered currently,
prepare to add a flag to disable wbt if default elevator is bfq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20221019121518.3865235-6-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/elevator.c | 6 ++----
 block/elevator.h | 4 +++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 20e70fd3f77f9..9e12706e8d8cb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -512,7 +512,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
-		e->registered = 1;
+		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
 }
@@ -523,11 +523,9 @@ void elv_unregister_queue(struct request_queue *q)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (e && e->registered) {
+	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
-
-		e->registered = 0;
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index 3f0593b3bf9d3..ed574bf3e629e 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -100,10 +100,12 @@ struct elevator_queue
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
-	unsigned int registered:1;
+	unsigned long flags;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
+#define ELEVATOR_FLAG_REGISTERED 0
+
 /*
  * block elevator interface
  */
-- 
2.43.0


