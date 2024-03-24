Return-Path: <linux-kernel+bounces-114410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B47888A51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0821F229B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC568176530;
	Sun, 24 Mar 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLnqL4+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B001553AD;
	Sun, 24 Mar 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321823; cv=none; b=mAUuNRHwchUzxqWO7wM2vUemkrEf15dRIs+yrDf2eWIFrU4wxDKIrAlu+eoPCWapmM6CunjhqCdwu6NYpJyJCtN4qDlUrIrenBQJHNteIFG1ZM3C6OezoiBGpZpbH5Hg34h2nC06cYyj+5g8KmEs/W1wJL19klosWm6SQ1nq+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321823; c=relaxed/simple;
	bh=Ob+u0v7iJbF2fdhov1SjWGCt8FchSjZcmIy7w6TcGok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU47y6ZZnHMwtC3IuRXIp94+VX7cCqeb5nH0YFSDejoW+MdqzPYVeQmhNfdBgKDvRe2OIhJzCByFDzK8VJaocZIPDzfI9mkCWz4oCRUGIIvqL7dTT2CdwxyD0JvxIbdV2W7JGr2sn/gEUvWwVk8uM5PoZpwZiXjT8gXNK/uGuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLnqL4+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0379C433C7;
	Sun, 24 Mar 2024 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321823;
	bh=Ob+u0v7iJbF2fdhov1SjWGCt8FchSjZcmIy7w6TcGok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLnqL4+axim8eIK5Ov+m/hkkVI1/qWo9xmPh+9s3V3encxZMwvztpUDxxbZkgN9xj
	 B+FFV4H1z8XpwH7mk7zHMCduEj3N7Ll0VLcSQV05oElORaQpp2tAaRAhk7RrLAAKW6
	 szoK8H3O83mBzLATEP5gX93yF3KbbubElFK10bMySV4dyY6lZudT8FABDCdRjD4PS3
	 ZYlmNIolAgeAckcnNx8S0f2oMnFTunEC8pzd1tKex9DuKXeOwHCGGJm0W/YC2f1jhN
	 N3G1y36kNOTUg8jUq+SaVNvE4qEmz44fg7QZWfGaBt1c1BPFiVSSzQS24Zplot+WtC
	 FAVTpUwzhe7fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 551/638] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Date: Sun, 24 Mar 2024 18:59:48 -0400
Message-ID: <20240324230116.1348576-552-sashal@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 719fcafe07c12646691bd62d7f8d94d657fa0766 ]

We've been seeing the following panic in production

BUG: kernel NULL pointer dereference, address: 0000000000000065
PGD 2f485f067 P4D 2f485f067 PUD 2cc5d8067 PMD 0
RIP: 0010:ff_layout_cancel_io+0x3a/0x90 [nfs_layout_flexfiles]
Call Trace:
 <TASK>
 ? __die+0x78/0xc0
 ? page_fault_oops+0x286/0x380
 ? __rpc_execute+0x2c3/0x470 [sunrpc]
 ? rpc_new_task+0x42/0x1c0 [sunrpc]
 ? exc_page_fault+0x5d/0x110
 ? asm_exc_page_fault+0x22/0x30
 ? ff_layout_free_layoutreturn+0x110/0x110 [nfs_layout_flexfiles]
 ? ff_layout_cancel_io+0x3a/0x90 [nfs_layout_flexfiles]
 ? ff_layout_cancel_io+0x6f/0x90 [nfs_layout_flexfiles]
 pnfs_mark_matching_lsegs_return+0x1b0/0x360 [nfsv4]
 pnfs_error_mark_layout_for_return+0x9e/0x110 [nfsv4]
 ? ff_layout_send_layouterror+0x50/0x160 [nfs_layout_flexfiles]
 nfs4_ff_layout_prepare_ds+0x11f/0x290 [nfs_layout_flexfiles]
 ff_layout_pg_init_write+0xf0/0x1f0 [nfs_layout_flexfiles]
 __nfs_pageio_add_request+0x154/0x6c0 [nfs]
 nfs_pageio_add_request+0x26b/0x380 [nfs]
 nfs_do_writepage+0x111/0x1e0 [nfs]
 nfs_writepages_callback+0xf/0x30 [nfs]
 write_cache_pages+0x17f/0x380
 ? nfs_pageio_init_write+0x50/0x50 [nfs]
 ? nfs_writepages+0x6d/0x210 [nfs]
 ? nfs_writepages+0x6d/0x210 [nfs]
 nfs_writepages+0x125/0x210 [nfs]
 do_writepages+0x67/0x220
 ? generic_perform_write+0x14b/0x210
 filemap_fdatawrite_wbc+0x5b/0x80
 file_write_and_wait_range+0x6d/0xc0
 nfs_file_fsync+0x81/0x170 [nfs]
 ? nfs_file_mmap+0x60/0x60 [nfs]
 __x64_sys_fsync+0x53/0x90
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Inspecting the core with drgn I was able to pull this

  >>> prog.crashed_thread().stack_trace()[0]
  #0 at 0xffffffffa079657a (ff_layout_cancel_io+0x3a/0x84) in ff_layout_cancel_io at fs/nfs/flexfilelayout/flexfilelayout.c:2021:27
  >>> prog.crashed_thread().stack_trace()[0]['idx']
  (u32)1
  >>> prog.crashed_thread().stack_trace()[0]['flseg'].mirror_array[1].mirror_ds
  (struct nfs4_ff_layout_ds *)0xffffffffffffffed

This is clear from the stack trace, we call nfs4_ff_layout_prepare_ds()
which could error out initializing the mirror_ds, and then we go to
clean it all up and our check is only for if (!mirror->mirror_ds).  This
is inconsistent with the rest of the users of mirror_ds, which have

  if (IS_ERR_OR_NULL(mirror_ds))

to keep from tripping over this exact scenario.  Fix this up in
ff_layout_cancel_io() to make sure we don't panic when we get an error.
I also spot checked all the other instances of checking mirror_ds and we
appear to be doing the correct checks everywhere, only unconditionally
dereferencing mirror_ds when we know it would be valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ef817a0475ffa..3e724cb7ef01d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2016,7 +2016,7 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
 		mirror_ds = mirror->mirror_ds;
-		if (!mirror_ds)
+		if (IS_ERR_OR_NULL(mirror_ds))
 			continue;
 		ds = mirror->mirror_ds->ds;
 		if (!ds)
-- 
2.43.0


