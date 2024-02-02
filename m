Return-Path: <linux-kernel+bounces-50354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A88477EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0154F2872E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F34B80605;
	Fri,  2 Feb 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrtVG04s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020415F302;
	Fri,  2 Feb 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899182; cv=none; b=iWJ3UVaBF8fXdlFZoq0SiD3lK8fe3Iu447+Zqv0dlYD6vu4x4rrtpiJSY4jt2j+1fOtKWk3Jn1+vbzrlkIFfeJrGT9RSq06HeM9TtfZ75W7M3TbTqA9q2MvPVvc/sZhEiqTrYOtvZ8wHFp1ho9S1Pur4p+hReQN8fCr9oW6xii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899182; c=relaxed/simple;
	bh=gDdzGJEE3xcGXYIzrKSx8hMOKEYOPXPiM9IDmwdOJ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv4tDRS1/WcFbDduYkGUyq4k829CKqeHBLwwSaDckx7igBpB+tAuIe5HzGMK/eYCvDCSSBd/r175WIEAg9sW4PVx3SAx13z1365MDxoCYccQSw1EZtZw8X9/0fWSkHidJ48XGo+uvZAZ88k5S8bCH6XW1qLJxq/TLZ9z20zGuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrtVG04s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DEDC433C7;
	Fri,  2 Feb 2024 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899182;
	bh=gDdzGJEE3xcGXYIzrKSx8hMOKEYOPXPiM9IDmwdOJ3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrtVG04saa6jIO5gee/nA7FN+wL8OVLAOuzugh7e3JMjx5zZYFD7lJbuuF+5pJV80
	 Ht51S/ef/kg80ooiiMhFzTjbruJRVBOXBG99tRRPDZAEiGCZ2SzhAI2p0zmzwFwa0X
	 CQUHHbh9X1Krof/DceIKpsyKDreDwe0vObciU7pcCJ9hywTYRvQU0mJMBsXyGI++K6
	 R1PgMx2nr4tDqjZxSHzpxMywiGdnAVszdbzMLHe6Qy69xP1UjnIlipf2PT6U2dSyl8
	 6Ep4CRgBxLs/vLI4wlLfJlLkd0NRZp0IjbkIPgggKjsz+zGRMLOaMav/gdqmk/2W+Z
	 6Jk2xCTiLhH6g==
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
Subject: [PATCH AUTOSEL 6.7 10/23] block: Fix WARNING in _copy_from_iter
Date: Fri,  2 Feb 2024 13:39:06 -0500
Message-ID: <20240202183926.540467-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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


