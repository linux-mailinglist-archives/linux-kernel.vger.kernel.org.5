Return-Path: <linux-kernel+bounces-115812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30808894BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D76A2961B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAB37471C;
	Mon, 25 Mar 2024 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwsfp/0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851B145B00;
	Sun, 24 Mar 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321995; cv=none; b=tWVNNy9zLqTXfR3PK3ppsR9iqhsP8wROhnN10gvBR6sM6LkJFBceLNDEcCW9yd23plVDb8WqIFK9WKo9J3txOFKZTQigON7JsNXgNJXo7b79+pcm3jTCyQ/j8mqHp48KKTLv8t2vKfkmbuPcXc83p3F80HkrL+ZMP6avoyoOHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321995; c=relaxed/simple;
	bh=jIptx+OrhAJEUycGNaeZuUXXxTYLSRbvWIRxbfnIVJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfL/O42aBCBeJHniOTLtJH8KjdpZn7HoL402zLvLvc+GW6UPGZXFw7Vr29I3CvRZsgCVPBiiNFzR6rM0l+v36laKhC927xXcHTGz0uRJ8lBY6IUMc0YLH3Yyk1DLqzpCjm1tp4IZM0aItvqB9pwzjvSjcgNFkO/+CoJvEHbaJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwsfp/0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB5C433C7;
	Sun, 24 Mar 2024 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321995;
	bh=jIptx+OrhAJEUycGNaeZuUXXxTYLSRbvWIRxbfnIVJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wwsfp/0RjLv6i/F3cINeaV5RA/fTK+1KrIXzHVnOO6Cuqafd4GBn6oknKkevsiSiz
	 dGdxcIKFSDZPV3zuvi5dyiMa9fpdGjrtsnVcS1mJR4/qC4W/RnN1SU8exg8SoiN1fd
	 HXLBo6TWZ5gwLNMe9FZZsabHM1GhZZ9DZfEckqXowLZa3pqYulnuM31A719atp6Avt
	 GOjJIYQ7g05YFeY84GKpXs9jXxqKLzzby1BVPwoiMIZxzBaPXz8qHlp5QtqyubwSRN
	 uNkAO3FUEGmZ6GjL0gkPIzSXMcmhafP0GSWErhFH6+I/1QP6BJqyVZFto+BBVhQ0iu
	 da0/NtfoaWdLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/451] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 19:05:43 -0400
Message-ID: <20240324231207.1351418-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 1c87f3e708094..788acc81e7a84 100644
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
 	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
@@ -7571,7 +7579,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7658,7 +7665,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7821,7 +7827,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
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


