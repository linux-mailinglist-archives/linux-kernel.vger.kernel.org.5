Return-Path: <linux-kernel+bounces-114074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D42888841
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1DD283253
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE6234D90;
	Sun, 24 Mar 2024 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xma6jhBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C9130AEC;
	Sun, 24 Mar 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321364; cv=none; b=pNpyRvgA4fqEnr/WFXLg22//p/PZH2RHTtfU64DaZndlovSt+YD56QAfZHG7W3kRgHRz9W8bKhMeUluLqw2bG15ydkuhfgkEBWPRsIxPghKBwKNcv+fvhAeeNFO5ZmlPEjvraonnHVb17dJxzOt5MP9eV1gNvwxBuXaNx+8MC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321364; c=relaxed/simple;
	bh=p5w55eVFyFulSbPkGv3FAEMmKTTzx6FUbDJaKQt2Dlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+maFjapPAycolpzX0QsOwC+1dcAgvEvjkruchO/Edk9PnYGWeWi++1nZZ5p1XKv3/jyPNsUTVu8SOohkmmY8a4ieTqIYk2uB32Uu5yTrlbUCBJU++dXYWMm1cL3Ik29eh+ehMv2m1ypovCeSBKdsdhaV/UrcOcT2A95XDm2Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xma6jhBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474ABC433F1;
	Sun, 24 Mar 2024 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321364;
	bh=p5w55eVFyFulSbPkGv3FAEMmKTTzx6FUbDJaKQt2Dlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xma6jhBl+M0ZjcTsJ5sMK6AJm2taLpd3NIZdx5Uo3x4zUFQDufIL7pK8rPJZwZD5I
	 3PgqKOQ1DK0y+EV9OyP8cY9v/Dt+b2TrFgUKj0+LlQfrmqeXjk3mZNlb8w02uNyNUg
	 /PtARway1fU18vwXb74WW/cJ+Hap3wQqXVTQzn/jhfKLOPDi5mXY/cljmJwHAc22z2
	 CBlvumpqiA2Ft+0NO2uxX+s2NesY7usexsi23hMCAuHUfGVCkOkSJ4tSPUGqcLnL7D
	 SLPiwkrNnEmvwXfvvWvDoq7B1Kbj6YX5VvZ8JwZW0Cw3W4JrqsNhJZw6d5WsZAmlQy
	 61kd8eJkOjUBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 088/638] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 18:52:05 -0400
Message-ID: <20240324230116.1348576-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index ce0516bdf8fa8..624259f79337f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6235,7 +6235,15 @@ static void md_clean(struct mddev *mddev)
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
@@ -7609,7 +7617,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7693,7 +7700,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7827,7 +7833,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
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


