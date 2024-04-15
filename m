Return-Path: <linux-kernel+bounces-145133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82538A4FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232ADB20F27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9304F128376;
	Mon, 15 Apr 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoBAD1Nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1216127E04;
	Mon, 15 Apr 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185414; cv=none; b=hnFZS3WwH2gTFqQHffp7C4KSbe8MoPnfhXrLHNluNZqCWbke1yx/t0OVQBbcxqZcAmqh4IEg9yOFl+RYqWDy1/gpsu42N7nKret5RVA7RpiVd0p/K0eONP+KTmIBIZcKG8z43fUqNh2LlOvZcbjsqd3tsl5R99veS3ygVAS7h64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185414; c=relaxed/simple;
	bh=TmsmNj7bRkz5rFs75rWI7SSlKnqyyER7J97nLh86c7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH0vBAEjdPCupU9rfeNU6t481+8oBZNr9cwrDHOeEfuuc7fHfKM515fYrBDXam1xhqGG0EFCtfadfs+lbCDPSOxorJUjztLonGqxitGd648uz52rKcNU+ObHW9Z6ZZtAgb+c+W6nMq9XNd6ZOWkFJPC/iCYTzVhUBqv8R011xGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoBAD1Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60706C4AF08;
	Mon, 15 Apr 2024 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185414;
	bh=TmsmNj7bRkz5rFs75rWI7SSlKnqyyER7J97nLh86c7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoBAD1NxA/0PJZvMaKYqkypifDbbfMqBuIO6/1x3UYMEEPWQoD3JOLzmpEr8DYnyA
	 Rj/KcZelrtzLvyGDR4Z1AE3KTwUMbk1s+oL9SrCyZ4eUU33YMjVc64JXvTnwEiuaFm
	 M2GMMS3ZSB0nWOX8Fup5WgPdrEmxWV3l0c1gy5NHZLmDPk3/aC3+/B6FfSxaQFTDTs
	 gcSSbk3CIB6VYQNIJgRbGubzUB6diirVaXTYdvOGTQ5Xzt2iJ2ZS2z2/HkSzwDdmx0
	 IGYl3ttKsZEsTRHFktwEeMsFjZAnFw+OkJUWCYtMY4Ke0OE4u5M21HL2c0Vs7E3YfW
	 5NROqKJL8VLfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/12] block: fix overflow in blk_ioctl_discard()
Date: Mon, 15 Apr 2024 06:03:43 -0400
Message-ID: <20240415100358.3127162-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
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
index d1d8e8391279a..68265f914c27b 100644
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


