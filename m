Return-Path: <linux-kernel+bounces-115171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF04888E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010E3B30031
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91722B6AA;
	Mon, 25 Mar 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Gvyxo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03213C907;
	Sun, 24 Mar 2024 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324241; cv=none; b=R0+4kEOhUCJWpIxxYt9LLcI60Zvp3+gNK77N9GDxhuaOBNw755srSL301PRMOMpmiWjAGTHuCkC4iqa+MVjVPU23jyvLRIPIep2Bq9Ewnj2N4CBGerpwooEr6FLVzcMu2sHCM2LllHB1mtFdJfOaEtcz7xlzmcWG+E19Jd4S/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324241; c=relaxed/simple;
	bh=YNK11JBRy/npL12b7ivY2GafbRJ5idFF/fFNwrKvM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n57GQyDn3VMtY+pIJzT/nmrgsHwwpgEagfa3Q01QOgXZa7LonaU7I7/BHav7dE3J/G0N0+n6lqeguZnd3cgO8wyU7FMumpG/btVEgDJ1xzRa0Iq32AQ4fxJojPed9Dy/+YtOuXcXz0+GHiQ5uVbjyd3nFMSMB+yujb2I4PyTxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Gvyxo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02AEC43390;
	Sun, 24 Mar 2024 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324240;
	bh=YNK11JBRy/npL12b7ivY2GafbRJ5idFF/fFNwrKvM8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8Gvyxo9fs8hByAqVM5uHsvH9fXUYmXxiOx2Jd/Av0Wzmk8vaTPtfNS3j9lmr2WBL
	 01njgM/odwF7MT8qaH7POg0WaN1xCIEcOTrJxt9IUBt1e5y+vDw0k2SRNgBQ6IRaRB
	 ei+LST0gPpDDvxxCHuI0HkV1rflUkOPWzN+w0qsig5czXiQzOTiObeA4gXdzKw24dP
	 DJQGcq5AkhfDK+4HHjuaoxo/sKdsfk/u1z33ZMBhAJlVD+CCJGwd+cMSpa9DAFkN8d
	 Pbmlh/UB3yMdiTthmWRQwKAxrjdspY66ku9yUc/Y5CU4Wo3uXSuUQXjU6Chle4IQwp
	 XFDSbV2S4Zr2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/148] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 19:48:07 -0400
Message-ID: <20240324235012.1356413-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 8123c44de7dc8..68eb3220be1c9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5886,7 +5886,15 @@ static void md_clean(struct mddev *mddev)
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
@@ -7199,7 +7207,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7294,7 +7301,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7458,7 +7464,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
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


