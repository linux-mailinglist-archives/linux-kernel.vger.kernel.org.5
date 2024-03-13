Return-Path: <linux-kernel+bounces-101917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562487ACB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882961C215F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C99129A74;
	Wed, 13 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h79dsPer"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856286252;
	Wed, 13 Mar 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348058; cv=none; b=fXEQUIsSFh+/S2i5nt1GaPW8qJNFQMKcUjm2Bqgd1jihLCF6hAsa+SU2J2Yc1ptnpzpTjzepEvToOOG2gFO4GIIkeWgkHs1L7UMXWOz/4qzcf6cCLslvDmDB5l3/JRdgTnp4T35IDaI5KsSq0SelW86ektz1LS4ppZR4nsGVkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348058; c=relaxed/simple;
	bh=uLR2HXXfcTb17vMFKT0En/Q5eZl9oBPOTtFoesrxo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX/x2Cw0aF9P0h+6aqLBSaysQ3oVy79VfB5MMUuQkEnyQUo0TCrXhT7XVB/RAAnthECZwNwD54gB0twEMnVTn9qWEmqDME8F0W9yUN8UWo8pt4MuhhZcG8lnKIUj4kY6Cj+XyWYRwPUUDFOj2H8c/1J4H2D42HGRA6hCT9gTC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h79dsPer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CBDC433F1;
	Wed, 13 Mar 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348057;
	bh=uLR2HXXfcTb17vMFKT0En/Q5eZl9oBPOTtFoesrxo0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h79dsPeriBOZgOLZc1oHYRQAwi/E0AiNE8mFgeDcSJJD9J2o9/l2GHLYhvWUNlmc1
	 jmoosxDA4/EwCkVx/smBIlaBSX0vAH8Qqd2q9sAWimi8lFd2MX/zlJ5GT2infigphP
	 HY8Oz/HjUkLLieldCLnGpBju86aOhRulLT/Wn+Q6ljvJrEoqpriGu7SnmpxseA9XkD
	 mamPnuZlcgqAGCXFikCP+EHAz3EXKT0WA7TTv5uP6MnwPRBCYhsGnnCqZZQtZZlRQi
	 EZMZrGmU1PSJbO0OuMIDLQZrhkF47Kp/FWmvSX5WGoMzGvOSl0W7zxWsNZ00MO6nKb
	 xM52LiwRwYfIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 49/71] elevator: remove redundant code in elv_unregister_queue()
Date: Wed, 13 Mar 2024 12:39:35 -0400
Message-ID: <20240313163957.615276-50-sashal@kernel.org>
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

[ Upstream commit 6d9f4cf125585ebf0718abcf5ce9ca898877c6d2 ]

"elevator_queue *e" is already declared and initialized in the beginning
of elv_unregister_queue().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20221019121518.3865235-2-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/elevator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index bd71f0fc4e4b6..20e70fd3f77f9 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -524,8 +524,6 @@ void elv_unregister_queue(struct request_queue *q)
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (e && e->registered) {
-		struct elevator_queue *e = q->elevator;
-
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
 
-- 
2.43.0


