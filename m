Return-Path: <linux-kernel+bounces-112912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1A887FB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133302813E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965245970;
	Sun, 24 Mar 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPohn6xB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788C5D8E1;
	Sun, 24 Mar 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319723; cv=none; b=BgKzkS8y7yiGqJYzZpX/xfXJV/Lq8jXAu8VYY+2UFK3DPM4jD7d7vScXc53LfDS+teNMNKV+2//7uenEl5YdCA6i3LvPUZ9AwLa03l/63Er0VhpRyFZFMu/7O+UDfdYO9Snmn/dLfMmwR7Sq0abfiqxUZoqsXqUud38CwOQZ+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319723; c=relaxed/simple;
	bh=9ow4d0I8ykKepUEvPvrJCVgpBOAMKiYp+QNhUH5Nfv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW7twq92qh4WjZKPTNwVLZ7F5hHXDA0RXz1obcHfLn5gTMGA5O29f8S7rqvDGYI4a9qE4Ta+v3JdxdywgMWr+8iByS69Woq7iJPamBUoBiWYB8e+3+H44JEMtl5B7oiCh/3Q1ScLoWxtcGdVXb7eRWktxjBRsaNvG5inZQrxUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPohn6xB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF80C433B1;
	Sun, 24 Mar 2024 22:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319723;
	bh=9ow4d0I8ykKepUEvPvrJCVgpBOAMKiYp+QNhUH5Nfv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPohn6xBclq1NYKNUfcswXshr1jgGuSBPqmff3GMCPSYHEGQCGVnJsTsUBAGtT9aF
	 vr1OtAeMPBRsycmJmsIScehY1GAXMg/ulwTnQaduGxvRIdTvkPUyeZgqG5kJiwEivv
	 ixzuIfj8Tu7c9AnrV4eF+KDkrScHIN5poDNUFH3cqyE4yduoLe35Lu7D/F62nXY7xx
	 K2JOWrzqkilr82Ic/MC9O+1l4C5fkbuX2KAQ9XVTaDDeodrIpGOm/qyAwSAs65JrfG
	 yZdbtDcvToiUoEvdGqXtlj69xPUWfvEZT2Lbp7f4KX8N/RjScdQAMj02OLB3bFlgju
	 C6axcDvfbPbdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 025/715] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 18:23:24 -0400
Message-ID: <20240324223455.1342824-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index bfd04a9e80796..d344e6fa3b26f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6279,7 +6279,15 @@ static void md_clean(struct mddev *mddev)
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
@@ -7625,7 +7633,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7709,7 +7716,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7851,7 +7857,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 				     mddev_unlock(mddev);
 
 out:
-	if(did_set_md_closing)
+	if (cmd == STOP_ARRAY_RO || (err && cmd == STOP_ARRAY))
 		clear_bit(MD_CLOSING, &mddev->flags);
 	return err;
 }
-- 
2.43.0


