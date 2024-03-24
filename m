Return-Path: <linux-kernel+bounces-115354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FD889B11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B81C34135
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06281EC4CC;
	Mon, 25 Mar 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alkpp2LL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970E1422B6;
	Sun, 24 Mar 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320544; cv=none; b=c5C1356/MS7OUSnjsH3itjFFN93ogLMpeQaA/bJrsuxYK8FFpOxwzy8QRuD+ODaFVtxifwYHcPovDsnEgrXWnqZ1TKGXmU9RT4CfhgV+TFLNW9XmtjjbvZ9ZDG6HIZGUFAPjNlrhwDkI1uO88ldiNU6Wg7QqXpTRwiuwkuQDP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320544; c=relaxed/simple;
	bh=CP0GBc2tzjL7Eq3mKNB5Vuisggt/8ApKO4BnLcAc2Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEFEwShYsw2PGoQZcu9bIaURrZLcnzM7SctdHteZDKRjNZygqLPuJ+deGBFexcISI82C/mX6GcoXgtSKU5e0GCW0uuSk3+bV3a3v4vhpXT76/RTApgFGyrGcWvBSjPdxuKKu/eX+LWW6V0Bi3GO2I6ejC0VFVOc2iI545csGiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alkpp2LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740EC43390;
	Sun, 24 Mar 2024 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320543;
	bh=CP0GBc2tzjL7Eq3mKNB5Vuisggt/8ApKO4BnLcAc2Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Alkpp2LL6ePAoHUhl/rjiHwj5Vw1qaiQOt1gaKVVMZEoKPZ8MP4r+Myw2+e+hUcNl
	 9IJMETN3XIE8RlTPV1Soi788IwDRQ60w04lFz8CIXTx64MNSSHt8QV3w4ejNnaJyZ+
	 sfXmHKJHCRIsW2BvWx49o90APKG8fGtlWv0vPS2A77VH3Fm0xQHGZUwrb0PcJUonTS
	 gqyzReCqoNJu+g4nx0q5T5qTNtVktwBWQ7oWeSDZKkWRm9w6C160yYlVNcgJOhzM0k
	 KfqSchbPZsyJnQ9Y6EMrlgwehi0VkDTisnUdMLA11fjeqd6Ys4c5EcBzNAE2xQpAYD
	 1pPt34rQ/Kisw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 104/713] md: Don't clear MD_CLOSING when the raid is about to stop
Date: Sun, 24 Mar 2024 18:37:10 -0400
Message-ID: <20240324224720.1345309-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 0b49033afa6bc..b2f27ac51bfb6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6304,7 +6304,15 @@ static void md_clean(struct mddev *mddev)
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
@@ -7650,7 +7658,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7734,7 +7741,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7876,7 +7882,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 				     mddev_unlock(mddev);
 
 out:
-	if(did_set_md_closing)
+	if (cmd == STOP_ARRAY_RO || (err && cmd == STOP_ARRAY))
 		clear_bit(MD_CLOSING, &mddev->flags);
 	return err;
 }
-- 
2.43.0


