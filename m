Return-Path: <linux-kernel+bounces-50377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98433847836
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D028B98B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C2132461;
	Fri,  2 Feb 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOxTf0fX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C4131B33;
	Fri,  2 Feb 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899231; cv=none; b=NGebQNgls0E5mZGnPdjjlQkyrcRugsX9BiKF4VOP6yFcfWNK1NM4o7a3KvXF0YeNTSNui/vrCo2p4frL5++SibzzKA9fzPnI/SMRkzgfDfrnKFEN80P6LfmA7w9t0hEaJUAl6Pbtv49Ei1Yg3IIpRsiY/JRWTlnF2CVXkvzOWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899231; c=relaxed/simple;
	bh=gDdzGJEE3xcGXYIzrKSx8hMOKEYOPXPiM9IDmwdOJ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYlLjXbkOUyBzwpmzjT1gF1S9ccwWPGe2n3iuxyph/DVCdKAiWHBQ04DgmFiDPEHX+9Sj+RGViEH+AjAhh6k8YZs0mtc9IcKESGiwsLb/foZySY+N6/5URDNzkc690MqKd/bESfwWJeEUqnlFoemP3WlqSn7oYr2HxNH96kle9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOxTf0fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E8C43399;
	Fri,  2 Feb 2024 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899230;
	bh=gDdzGJEE3xcGXYIzrKSx8hMOKEYOPXPiM9IDmwdOJ3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOxTf0fXqe2/EanI7Wb06oJ7hHJ3Zf6eVpmKTT4jlfNOnvjPNga1MrZh3XATyaw3o
	 oRm0Xrz3kwfcOVkMSUtXq30i9XprnhN5I7JwslagQ0xjd2t2fT8zB8zP8NGt9HrWrh
	 +mUgRmZr/F6ue5YGl9HuzQN5XhoLpU3JouZxpFW18gnMfnXyiFxYU1ONUZTY4a/EfY
	 GkDAkyEHkRsHovYz62zX/8+Z+pxUnFDoO5yFfzd6h/Km9ZPrB0mVvZNaBFZ2+IUnHB
	 8lx40K0omUYi6BDAURt3P/WO8o0jAWMHjRgwDkoeks9wzb84GfUA5E7VDyDQ516cD3
	 TI9uYFGj0LBhA==
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
Subject: [PATCH AUTOSEL 6.6 09/21] block: Fix WARNING in _copy_from_iter
Date: Fri,  2 Feb 2024 13:39:56 -0500
Message-ID: <20240202184015.540966-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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
index 8584babf3ea0..71210cdb3442 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -205,12 +205,19 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
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


