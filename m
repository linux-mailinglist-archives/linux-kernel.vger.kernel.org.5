Return-Path: <linux-kernel+bounces-114391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AB888A32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024E9290E68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F0273DB2;
	Sun, 24 Mar 2024 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPvtoksz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EA218555;
	Sun, 24 Mar 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321792; cv=none; b=ZwAwkhc7NydYbpkjDPaygjRE2Oic/Wr1oxe/sPBuiR+WUpXXeiHtpYbvPGTy9iWzgm+LoYsnlekm4Yc+Mza8jrM/XQcDut19MEKS1hmY5AUyQUJqLO9Sb4Q4yP7ZVLTabgDc1aRl5iEaIhX0Twe+fREE8kd8R93sruiJVhp9104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321792; c=relaxed/simple;
	bh=gRR7y8zBTbVbNURT8EutUGIcL/fyEWj/c5CQrKgXbG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBSLy2dQZW7A0MiGrFcfyiRiqzrbAOxND/q66pTemLhFM3TuZgJ/k7YUP1MEzRBaiOgFGhXksY+2KORdANr1VXaZxKkll+58OPlnC2MUAVdPtLGM0+MJU9NpkIZ70hQTa2D4LvkYUM+3a7hsaajEU2oCLf0cN4BqHuyP7JxAOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPvtoksz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66BFC433B2;
	Sun, 24 Mar 2024 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321791;
	bh=gRR7y8zBTbVbNURT8EutUGIcL/fyEWj/c5CQrKgXbG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPvtoksz8tvozk5Usz+fCdXA0BdJWwM9lJWjDtG1B/fO0yudhcrhdXNILPCcQ5viN
	 igrvu88zudr8BKqlJQU3ZevhSpcCaIl2LXwkmo7Qm/Fw1hi/Fj2GBJajQ/GP3Qqcuk
	 cEP7c4bLlKnjqmfNJx1qZ1GJv7t32UgnaE1Tlh4bP/PTQ1nbsx5kRry76Alwic+O23
	 VVZBjbOeSKoErKEUFtDyFgl6aF2mDEi+qE7IyPdCxYQ0ZV5j5SV6KVyB1BzGrO8yZJ
	 S9enybMLsaEylHIIBkydz23264WGwK2xebrpt6QiMlpiWb5o90NzVgZ+szL9Mx5s7x
	 JtOTKZMHdAoRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 519/638] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
Date: Sun, 24 Mar 2024 18:59:16 -0400
Message-ID: <20240324230116.1348576-520-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 271f5eab15db5..7cfa6e4da560c 100644
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


