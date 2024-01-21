Return-Path: <linux-kernel+bounces-32179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C68357B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B8A1C20E58
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E863383B2;
	Sun, 21 Jan 2024 20:27:13 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C337713;
	Sun, 21 Jan 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868832; cv=none; b=aRwVA+srv5ScTzk0sug1oz6M77CKZ2dZOYXYOescMKaOXzOVkyYWJJfBrZV/Bqp/sfCt4lWW9A6NWqKoaZqa4rCwVl6VHAOoc8nULQYbrqbJYmCKE4Xbjq5BXj3aEjObP5r+8SWiJPsqZc4Xb4i5fVmOgz3Ol61RQnCIRWABUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868832; c=relaxed/simple;
	bh=uZiztjpinSS7Xdrx+6z3yfBDTTHpVfueyyjwSZhYKaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eopHBvg1iodqMpDfMtbmeSLfUv7CotjnhnT57vw//kzpiPqv8kBLMRCEtT0FfJJnUAGGwagWPz6KXcq8JcumDlEIFgtkAYGEqTfzXdMnmdKmnX6GfGVOL6dDfnyRCbijbv4WzPnmDL4Wp2ivl6Io4gpBQ0qkoj2ipPeASLFDd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id DBDBE1401CF; Sun, 21 Jan 2024 21:27:00 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com,
	syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] block: Fix WARNING in _copy_from_iter
Date: Sun, 21 Jan 2024 21:26:34 +0100
Message-Id: <20240121202634.275068-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.40.1


