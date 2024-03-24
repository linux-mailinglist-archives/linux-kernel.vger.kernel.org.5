Return-Path: <linux-kernel+bounces-116125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A7889599
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B0F1C2D588
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA85D49A;
	Mon, 25 Mar 2024 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shcQElUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363117A39C;
	Sun, 24 Mar 2024 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323662; cv=none; b=jcqYJ+9USgUZueEQjvbgLw8RDz3FuRwhP6Yy0/RtyZv/+IgvIZF/MHXKh54o1HQPIRorcssjmXrEgFUtdUGggYjBS25OpwGlk4jMxvwzsmNrhdY9zT0cxeTwhcWQB42qFwYOPn+mFw0S9GSeGFS6QZ6uP71xkTIB9jXIaQ2uuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323662; c=relaxed/simple;
	bh=4o61d4k2DAVEjGzNj9t2LcUukFfJ64pIJLJSjHvQuns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D67iMu8niAMl4FVXGV2JU8Scgmc8TAJ5XEEarPble3v9OZpfF1RHqTDbuPYDD8cTrpk2SVslUqw0O89+k7kgjyirLMfUH00OnQ6AZlP6nrbJFp62AZPI0lIuJyh4qRV6wkqwfKGejNlTfxSTwrE4r8WdP7khBFOG+Y37UX8TKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shcQElUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0E5C43390;
	Sun, 24 Mar 2024 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323662;
	bh=4o61d4k2DAVEjGzNj9t2LcUukFfJ64pIJLJSjHvQuns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=shcQElUQ5B8JyoHzaf0hl7h8Hr8vrw5jNsx3qyna1C0yjQfq1vnykpfUg7TJ6l0vf
	 dOBzeH9SHPFUFkudWqsBoEEVMbLzWa4ch5KMWJb9yxSaPUHnpj4Gg0dOFGNrduV1af
	 +/20zTAycIojx+TvJvfwh3FQyOZ4zZNxbwoLSMW8pENUfiw0a0URobeTs1gNTmZDoO
	 TV+8kI83VHJlzqz6OZ3sGyBGKIsLNBaZtXGxiaTL5yQao0hmmR1kR7ZzikARLSe7ZH
	 z0ExatI2wEgRuZVHaiB0dDgb3S+Hzc+Ulv3Zt4J5BMUl5snTQysHizvuQukcg4eVdl
	 9SOKbQqNMt4bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 034/238] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 19:37:02 -0400
Message-ID: <20240324234027.1354210-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 9674f54e41fffaf06f6a60202e1fa4cc13de3cf5 ]

The raid should not be opened anymore when it is about to be stopped.
However, other processes can open it again if the flag MD_CLOSING is
cleared before exiting. From now on, this flag will not be cleared when
the raid will be stopped.

Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240226031444.3606764-6-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d6f12338cb989..09c7f52156f3f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6243,7 +6243,15 @@ static void md_clean(struct mddev *mddev)
 	mddev->persistent = 0;
 	mddev->level = LEVEL_NONE;
 	mddev->clevel[0] = 0;
-	mddev->flags = 0;
+	/*
+	 * Don't clear MD_CLOSING, or mddev can be opened again.
+	 * 'hold_active != 0' means mddev is still in the creation
+	 * process and will be used later.
+	 */
+	if (mddev->hold_active)
+		mddev->flags = 0;
+	else
+		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
 	mddev->sb_flags = 0;
 	mddev->ro = 0;
 	mddev->metadata_type[0] = 0;
@@ -7562,7 +7570,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7649,7 +7656,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7813,7 +7819,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 		mddev->hold_active = 0;
 	mddev_unlock(mddev);
 out:
-	if(did_set_md_closing)
+	if (cmd == STOP_ARRAY_RO || (err && cmd == STOP_ARRAY))
 		clear_bit(MD_CLOSING, &mddev->flags);
 	return err;
 }
-- 
2.43.0


