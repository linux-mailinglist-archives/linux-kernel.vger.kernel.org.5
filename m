Return-Path: <linux-kernel+bounces-113455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B14888480
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B8AB22899
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19821B05E1;
	Sun, 24 Mar 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrtLL/hW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F171AFCEE;
	Sun, 24 Mar 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320257; cv=none; b=Vs78LUBTzwdX8JjLT4PGBSJZsW2avZ/Inz9xpno0RwoPpff/IYbvaK7KpNwzocBqwRxknI2n2nDt5khQEfYdcb/AVgWBd4nF6ycYtKcrFk9nYBMTCfb5nt9EABhet2n226tk+N/sKC7n7KpAXC+s+QS/4F932AMef8orl5baGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320257; c=relaxed/simple;
	bh=WB7D8v23obP/TjwQh7iM+gl7QpnCg9eEFLWDW9/GHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdHQqf/u8ja83zklCQwrAXBgON2dwDv8Y8CK6cRYHKSy2trdcHplNz/ihr8iDhd9DhrZu0cVC1XCrwiiO6fJx9i4j/IYTKc8G/xqyJkdYpWZlfWXWsOnl1dwPQOF6N51pWc3R3gdvQngdgXMttBKGNSp6cT7zxipsHkFJGiRFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrtLL/hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD1FC43330;
	Sun, 24 Mar 2024 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320256;
	bh=WB7D8v23obP/TjwQh7iM+gl7QpnCg9eEFLWDW9/GHMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrtLL/hW0LIxFVFHqAu6A3bW7xtX+OQmZbsUIV9etrXnXsqBpkUC77+NQ3u/VPcda
	 jjBFPVcahbiHosYagc67fcGXJI6vXpzjkikDj4vY9azxUJjuwPdYYCV2iMvvu6JMxd
	 kW04QkVon8ZorHyOq/FPkYyB496IEuvkchbPGfWm6GF6ZEnGeFnpdKc+mUXWHEWWK2
	 uGzg0B02VOTE5YKqONEWj1EoZRQPd0z7Up5Xvhp+d3MJxhbmsPKvNjzWSZxbepPQkk
	 jc6Foj7wyOIKgYkzU5FswsWMhN5ftb6Qkotg/1AdjOXA20mvhd8UGPkUCs1DSX97jX
	 lXAHVe3ry4FWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 564/715] f2fs: zone: fix to wait completion of last bio in zone correctly
Date: Sun, 24 Mar 2024 18:32:23 -0400
Message-ID: <20240324223455.1342824-565-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 536af8211586af09c5bea1c15ad28ddec5f66a97 ]

It needs to check last zone_pending_bio and wait IO completion before
traverse next fio in io->io_list, otherwise, bio in next zone may be
submitted before all IO completion in current zone.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 65fe48bb17d16..ac82e69a9f5fd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1010,7 +1010,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
-
+next:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
 		wait_for_completion_io(&io->zone_wait);
@@ -1020,7 +1020,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	}
 #endif
 
-next:
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
-- 
2.43.0


