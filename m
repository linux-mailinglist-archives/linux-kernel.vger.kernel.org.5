Return-Path: <linux-kernel+bounces-50397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B33847875
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A691F2D5E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD213CE8A;
	Fri,  2 Feb 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkx4XBDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E413CE70;
	Fri,  2 Feb 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899270; cv=none; b=D49fBbDtywjKZvHXnnZl7bobo0koz1lB7lgwRiWybqEMnPxORriIq3PHxxi9T2MHv21m0hTI7QxwD/z3VxP5Io636XO0ulOIC8jdkkXT/DnoTd8JONy4SeOb6aYlXX5wG++O/a9gSMw0iTHc18qyrM9nGUkg647EcDGDhAhTYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899270; c=relaxed/simple;
	bh=mWe5ogDf09hcAygCjVRxEZZfskBz0tbK4Ts5EHcO6Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfuMBO4vlaR1TBVrvwMWprdq+2M7b+o1jdUU+55eEwXedI7iWyEkW8hkA/zM22C3CY9RDshhgPm4ja79jUy7N2qhgcuU2ENw1o8Vyuuv5/LKrfYZJzynjCmvw6ljubKTlsPnrPIqmz1onNbqcm3vxZ6rMtCA1Q+XZYbGCYtfQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkx4XBDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E685C43394;
	Fri,  2 Feb 2024 18:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899270;
	bh=mWe5ogDf09hcAygCjVRxEZZfskBz0tbK4Ts5EHcO6Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qkx4XBDYEvQD1tF8xIHbkFWV9FUqsrW+41nCUE18iD7BV9qGa7TNaCpyUlBBKUFsX
	 Y2zZWCIGfyO1LDQyaj+KsFnsFJTC3dknd/PRDOq4ggGKzCHS6zM5IviquHAX5EUlx3
	 XRr84SMeAg0U7zrjm56EBu/fZacYf4QCkh0WFpPG2qnxwxWBV2VPW2KUfz4G3EVgDD
	 coIFys0Z5KD8SifNO5LvaCuHzTG4zVY2u8dAK0Ct0GH0kVeUEzhD1oPEMZ3PNYmp3f
	 Jjx497QmQCHsjIBZvRG8OU1wZQo/PjWUxyMn51FHL9u+LjZMOnBEVpfns/Wj6f4fSZ
	 gLCCskPT1+eqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com,
	syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/15] block: Fix WARNING in _copy_from_iter
Date: Fri,  2 Feb 2024 13:40:44 -0500
Message-ID: <20240202184057.541411-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: "Christian A. Ehrhardt" <lk@c--e.de>

[ Upstream commit 13f3956eb5681a4045a8dfdef48df5dc4d9f58a6 ]

Syzkaller reports a warning in _copy_from_iter because an
iov_iter is supposedly used in the wrong direction. The reason
is that syzcaller managed to generate a request with
a transfer direction of SG_DXFER_TO_FROM_DEV. This instructs
the kernel to copy user buffers into the kernel, read into
the copied buffers and then copy the data back to user space.

Thus the iovec is used in both directions.

Detect this situation in the block layer and construct a new
iterator with the correct direction for the copy-in.

Reported-by: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000009b92c10604d7a5e9@google.com/t/
Reported-by: syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000003faaa105f6e7c658@google.com/T/
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240121202634.275068-1-lk@c--e.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-map.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 66da9e2b19ab..b337ae347bfa 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -203,12 +203,19 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	/*
 	 * success
 	 */
-	if ((iov_iter_rw(iter) == WRITE &&
-	     (!map_data || !map_data->null_mapped)) ||
-	    (map_data && map_data->from_user)) {
+	if (iov_iter_rw(iter) == WRITE &&
+	     (!map_data || !map_data->null_mapped)) {
 		ret = bio_copy_from_iter(bio, iter);
 		if (ret)
 			goto cleanup;
+	} else if (map_data && map_data->from_user) {
+		struct iov_iter iter2 = *iter;
+
+		/* This is the copy-in part of SG_DXFER_TO_FROM_DEV. */
+		iter2.data_source = ITER_SOURCE;
+		ret = bio_copy_from_iter(bio, &iter2);
+		if (ret)
+			goto cleanup;
 	} else {
 		if (bmd->is_our_pages)
 			zero_fill_bio(bio);
-- 
2.43.0


