Return-Path: <linux-kernel+bounces-24872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202B82C3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337C31C21BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D67763E;
	Fri, 12 Jan 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cRjBV0eg"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF577628;
	Fri, 12 Jan 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5408:0:640:72fa:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTP id 99742608F4;
	Fri, 12 Jan 2024 19:50:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JonQVQ0tDiE0-IWp8t1EP;
	Fri, 12 Jan 2024 19:50:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705078232; bh=rVVwhkAzgNNIjBnRMvtTLSOGJVz0cJRV+tdzW1zfGkg=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=cRjBV0eglXmwE22B1dB+3kFCg6WSmP/CvWnfVgvwSWy6A9rLFrJ/6QklGA7VrhxiF
	 zWrm7Wts5nypD2W3tyHH3mVUkjvbzB1v6GM113GqiVgKvkn5rOTUU3NG8hY8CMX6nD
	 p2gY5FwY3gLOmih6HLZR7eJtDi+AJd5UlWFe9OYQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Dave Kleikamp <shaggy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	jfs-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org,
	Mikhail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: [PATCH 5.10/5.15] jfs: add check if log->bdev is NULL in lbmStartIO()
Date: Fri, 12 Jan 2024 19:50:07 +0300
Message-Id: <20240112165007.4764-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing of 5.10 stable branch shows NULL pointer dereference happens in 
lbmStartIO() on log->bdev pointer. The reason for bdev being NULL is the 
JFS_NOINTEGRITY flag is set on mount of this fs. When this flag is enabled,
it results in the open_dummy_log function being called, which initializes a
new dummy_log, but does not assign a value to bdev.

The error is fixed in 5.18 by commit
07888c665b405b1cd3577ddebfeb74f4717a84c4.
Backport of this commit is too intrusive, so it is more reasonable to apply
a small patch to fix this issue.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
Signed-off-by: Pavel Koshutin <koshutin.pavel@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
---
 fs/jfs/jfs_logmgr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 78fd136ac13b..d6f0fea96ba1 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1983,7 +1983,8 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 	bio = bio_alloc(GFP_NOFS, 1);
 
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
+	if (log->bdev != NULL)
+		bio_set_dev(bio, log->bdev);
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2127,7 +2128,8 @@ static void lbmStartIO(struct lbuf * bp)
 
 	bio = bio_alloc(GFP_NOFS, 1);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
+	if (log->bdev != NULL)
+		bio_set_dev(bio, log->bdev);
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
-- 
2.25.1


