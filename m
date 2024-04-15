Return-Path: <linux-kernel+bounces-145108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136908A4FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C515D284689
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3227C090;
	Mon, 15 Apr 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu1F0hva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D08762DC;
	Mon, 15 Apr 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185368; cv=none; b=Ym/gvIKUCeuKlxPgmPl+vncVhtZUOivYfrh7T1t0VQ4E+tSh7dFJJozb020zR1IVNvTEMiDXW3BQegDo509cz5AnLj2+SZyxp20floskbPIgo685PEZxjyE71mMdkz54nqfePYr/pXHqQKhUQebFVxmSVi26ahiM66eNHmFtVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185368; c=relaxed/simple;
	bh=k3ZZMuQVFwRl1gMlxSorEaL5Mxk0oRTuF99ryI1nZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILW/AtMi4ZMtNgesnfbiDxNL/GEpIshszYQQBBCi0llc+1vP7wIrHomf8mMV2s129EGSfOXI20qlUyqvlkFJxBKFF8DHYX2OfBGBLDS2KcqwjRavWYlNKnKO40m+OZx4SieNTxS/58gVPmYgvNw32gBni90vU7p/7M3RDo+7IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu1F0hva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79F0C2BD10;
	Mon, 15 Apr 2024 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185368;
	bh=k3ZZMuQVFwRl1gMlxSorEaL5Mxk0oRTuF99ryI1nZrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tu1F0hvaUkX3tjq0qjmq5z8oshVhxYfV0VGH/pnRXlrIpT1SWFUBZo52Dg/31XFLz
	 4qqfUbPPhICQ4ySljdg8G2yLrMtvIZ+0+2r5zmJ9R3sRs3ah3NqXTOI0RHDvmEBgfJ
	 yhx+Antyo85Ldj/IeTtRTx2GZpacd1Vyr0pW1h2EIdAH9KIEVJozbQi1lPTDiCp9vj
	 T0++4TpO844pgAYvqmBecOUcvTpEoyi50WAkKFhNL9k2J95p2T/mAx1WAo4MhxQkzc
	 BBcFai/d71jt80+nwPdSvGvyn3a9j45DCI8h5wlEcgAGncZHB5soOFFys+7/oX/eeu
	 NhrnntWYszJuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 09/15] block: fix overflow in blk_ioctl_discard()
Date: Mon, 15 Apr 2024 06:02:49 -0400
Message-ID: <20240415100311.3126785-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155 ]

There is no check for overflow of 'start + len' in blk_ioctl_discard().
Hung task occurs if submit an discard ioctl with the following param:
  start = 0x80000000000ff000, len = 0x8000000000fff000;
Add the overflow validation now.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240329012319.2034550-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 438f79c564cfc..24246465e39b6 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	uint64_t start, len, end;
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
@@ -110,7 +110,8 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (len & 511)
 		return -EINVAL;
 
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
-- 
2.43.0


