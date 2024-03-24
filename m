Return-Path: <linux-kernel+bounces-114755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA6889102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B301C2CE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B613D260;
	Mon, 25 Mar 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXMahLPX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6D2745F5;
	Sun, 24 Mar 2024 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323341; cv=none; b=iW8085G+lhepst0L2+uer9ObLAy+OAjH0sbFiXuWqypAQkPeXDt13Be0wt89th4EdRRIUPrTB4L6dO5aUO10HtQqcyCFa0ihKNDAXqKRijd7+Yqki9tckasZAjFMMLpcXQJvip5/Q9Dss8/EWwzSxsLJw1mPtrjSzRhb8ugYDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323341; c=relaxed/simple;
	bh=VKz/S+EARHQkPHWZCbtg1WoF8qFHQoAanzE/UknEQCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMd/g/xP2Ly0DRUBM6hxVX9ufTnlHkCmCKQDqIq5sxYu1AAE6JL5HEUfJrlNJGW7EINLQ/Sk86DudSo7EJ/bRTFS4MbEJWnktkUuyA7o8DqEm91sy/lx2psmWHHS454N8Ymk7nR9RcMa0zUm9FsJwqvYnYk7FIBO4Tv5OMb5T/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXMahLPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87277C43399;
	Sun, 24 Mar 2024 23:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323341;
	bh=VKz/S+EARHQkPHWZCbtg1WoF8qFHQoAanzE/UknEQCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXMahLPXUuLXXk9sUBETqjRifE1L5uORE6TjkGvAdzgwu2PP6cvyUYRFG0x60zU1o
	 8g4ZwF1Y1d/eyanNihoP/dR2Di7UCaCTqVZ4WqwVB8/TW9FBfYjhgI/eGWko4cogAT
	 pwDbITKJuAm9GLCvwEnNJBG76DHl0E2lPncSbMHGA9bFMLMqC/cX8R0DMXIjUoxlvD
	 VP030y4G8oHPdb1K6EjYO4KYxWdn4C7LoxmUHvezMpG/8AAzWXdTx8ww73mnpLPR1q
	 kSxzvfrbV1XBqKnnnBA2xfSauhEGlwG4RlnLD7qfwRNn4iKQ5Fn5vSs6Y4ple3WtMM
	 9pJVYpKN+PaBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/317] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 19:30:21 -0400
Message-ID: <20240324233458.1352854-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index a17f2f725822a..c937ad7f6b73a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6230,7 +6230,15 @@ static void md_clean(struct mddev *mddev)
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
@@ -7550,7 +7558,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7637,7 +7644,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7800,7 +7806,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
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


