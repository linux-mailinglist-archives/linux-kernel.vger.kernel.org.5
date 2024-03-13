Return-Path: <linux-kernel+bounces-101918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B787ACB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D1BB220B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715B12A179;
	Wed, 13 Mar 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzlZnuPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35C129A71;
	Wed, 13 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348058; cv=none; b=ZOLPlpHHMYqROFkKv/xTquGq90RCmew46SZZlfcYHb2Uh0+VOBtUOqXfI5R1IFVibv0u6BEHMeDNuXSYPxuGwzDoZcWoqXAFHZih3vhpKkb96fdPAWHlPjIVEa+e0BIBuA3P4QtCr7Hbf6NrHeu4KWmA0uo3TjcB28Tibe6G16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348058; c=relaxed/simple;
	bh=FpeRx9boRT8MSPiDXGUBZqeHsaeq82xaEA/cTWzG/ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcYSkwCa7VVnIsteOsC8WSe0LQYNfOv20la6vdWTkD+ZuNVXLZA534LumZIwHOgl8iJX2ZByB9CT19DgANrEezolNO6HWLct23N4lJtHaFcQNEqXpOqnFuJ7+n06TviOGfgmjRwMF9HYG1qeeMv9ZgQu8Re9it9SpNCzAFuQj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzlZnuPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A5C43394;
	Wed, 13 Mar 2024 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348058;
	bh=FpeRx9boRT8MSPiDXGUBZqeHsaeq82xaEA/cTWzG/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzlZnuPSyaUQVSdOSnquR4+jHsW3jd776cN5e4Is68NCcgwDebknYKqo+oM02hQ+H
	 Q3Z+eiEXNf0X4Mm18hTcgv7FZ1nIx6RZiSsSH0ufehh5M03JBoEPaLHdHTWztS5EyS
	 mZCqG4aXW0n18EHloSxtvy5oBOODDdEUcT7bk9A9Y/xeTACYuVxikyjeeqOu3ydC2R
	 ZlEqMS3nniKS5VonfltpoxPjr2pIuCQcP64d/YTRZ2UcZ4w3ncmXGc6YSRHX/eILEu
	 Zl+mpGu08oTO7hfAzAvDgUlToEj1OaRlylqW8SnuFgZE3hjQ+RGwnHoJo2dUEFEVEL
	 E6iXpf37htbEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 50/71] blk-wbt: remove unnecessary check in wbt_enable_default()
Date: Wed, 13 Mar 2024 12:39:36 -0400
Message-ID: <20240313163957.615276-51-sashal@kernel.org>
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

[ Upstream commit b11d31ae01e6b0762b28e645ad6718a12faa8d14 ]

If CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20221019121518.3865235-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-wbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c293e08b301ff..c5a8c10028a08 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -651,7 +651,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
+	if (queue_is_mq(q))
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
-- 
2.43.0


