Return-Path: <linux-kernel+bounces-113923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0564888763
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD41C2626B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91658214861;
	Sun, 24 Mar 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4T9RBkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A801EE69E;
	Sun, 24 Mar 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321016; cv=none; b=Qh47f/8bDvsZULr6baElvA5yNo6J16Qzs6gYVSSUZNOz2Ii4O9MuM+vqztOfH5v1lQ66CpaXRLx1KuW2vzngsypeCtMiiBvhDBD9AuNDlxnncRwesjoXqpZGR7Kan3G6eoEnpkR2N9VaUQX6y/t33towcZq+pQrVd7HiRXTmP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321016; c=relaxed/simple;
	bh=19L1yPQ4T1sGP6DTsBrKJu630UBqc4iVbXH6j+T7q0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acOUNe0kAaihLLFeAosX54hU6fZgYSwOBpZSf2N+YeC85JCpELZpe5YJXXUGv9rKoEV9Q74e18zs/LaIux4lOPWC0LrhVdHoZeb4cjR3+jOR6jdVyblCtX7/vcJpdMlbkUjL97PRXR8ORB+o2HpqZbPpbLMI5fNTvR/7H5RR6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4T9RBkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36DEC433A6;
	Sun, 24 Mar 2024 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321014;
	bh=19L1yPQ4T1sGP6DTsBrKJu630UBqc4iVbXH6j+T7q0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4T9RBkjeVIdT9/wKBKVQbllz7vKIQHVQipAvtv7QFUThugOliaHb51WNJC8WcPuV
	 NC1GNCzUfJ/VIPMSIgPPWgH+h4Cno/oSQPVczOmj9sNnMkOL+I+J+uHmRxRjHMlQhq
	 G7AVMOAHCoD9OzoPEoPX0tbL14pSU1WToxa3iqNwbMSnn0uoXzvAewmn1D1GUeq3TT
	 nUJzYO6BF8B2MPHLVXYdNNXRWO+P9d0ohtOdini4IO7IwojM90WydcC4kxQyV+uukm
	 u1jVk77yKtSxh6fic9cge3X7tc0bnzTAcL/FaZei8DNbNYxr4mmALS3B5/qJmmzO8e
	 AMquEiR57k7nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 577/713] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
Date: Sun, 24 Mar 2024 18:45:03 -0400
Message-ID: <20240324224720.1345309-578-sashal@kernel.org>
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

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit c2034ef6192a65a986a45c2aa2ed05824fdc0e9f ]

BUG: kernel NULL pointer dereference, address: 0000000000000014
RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
Call Trace:
<TASK>
? show_regs+0x6e/0x80
? __die+0x29/0x70
? page_fault_oops+0x154/0x4a0
? prb_read_valid+0x20/0x30
? __irq_work_queue_local+0x39/0xd0
? irq_work_queue+0x36/0x70
? do_user_addr_fault+0x314/0x6c0
? exc_page_fault+0x7d/0x190
? asm_exc_page_fault+0x2b/0x30
? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
? f2fs_submit_page_write+0x736/0x780 [f2fs]
do_write_page+0x50/0x170 [f2fs]
f2fs_outplace_write_data+0x61/0xb0 [f2fs]
f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
..
It is possible that other threads have added this fio to io->bio
and submitted the io->bio before entering f2fs_submit_page_write().
At this point io->bio = NULL.
If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
then an NULL pointer dereference error occurs at bio_get(io->bio).
The original code for determining zone end was after "out:",
which would have missed some fio who is zone end. I've moved
 this code before "skip:" to make sure it's done for each fio.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cd9f1c6039c49..d71683039b961 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1080,10 +1080,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	io->last_block_in_bio = fio->new_blkaddr;
 
 	trace_f2fs_submit_page_write(fio->page, fio);
-skip:
-	if (fio->in_list)
-		goto next;
-out:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
 			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
@@ -1096,6 +1092,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 	}
 #endif
+skip:
+	if (fio->in_list)
+		goto next;
+out:
 	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
 				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
-- 
2.43.0


