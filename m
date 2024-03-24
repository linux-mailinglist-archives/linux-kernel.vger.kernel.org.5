Return-Path: <linux-kernel+bounces-113944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C1888782
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046411C25682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F12197B4;
	Sun, 24 Mar 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBjldkNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190241EFE31;
	Sun, 24 Mar 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321047; cv=none; b=kXLLnwpPqfGYKf3uTivv15lmFw9LYi935NU08qx5gCMWZlB1BdOMU5ZjRwdZ/lgdLNpgg8DCFVUOgG2pMrgHHEdjKFl1RxITZVLWleZ6gHLYVn2jQXx++5es53hOLmRcDzbfdqMjbka6ZqLMNU4gijMULbl0QG/EDGkC66W6ZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321047; c=relaxed/simple;
	bh=Ob+u0v7iJbF2fdhov1SjWGCt8FchSjZcmIy7w6TcGok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTCz1nBvwkHjh4YA1dq+w89ZEZ+DQf2sEIpWD/1s9Y+ufZAXG1h/YZsbKe8obG+rQ2EuExspce6mtgEV9ApoXspvxjPrV6kC1Jx38bcAWyY9M9wA9Rhvz3cutJhlXjydSeZQnDN0Sg/msIFwWInpOD4CeGbWbLhqxG5Lmt1t4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBjldkNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0ECC433F1;
	Sun, 24 Mar 2024 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321046;
	bh=Ob+u0v7iJbF2fdhov1SjWGCt8FchSjZcmIy7w6TcGok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBjldkNAMlUt7dGQz1DXDnEQHgu8sTPhriHfTLNS6OcMlSotw80Xrk6cvqYryQFCj
	 uqmoYiWBIg2aNyepyW9C2bUUdOh3v7/rJT8yTdo4eOHMreNmBXgARCBlOwzlqERTYA
	 QdzS6UJM+BF4/lpu7R1eIHz5PVo8EPXyPdKhwCmTM8A8bE12F95RPS2V5nrPNk9CVX
	 majdktyIZRPZirhJdPia3RkW+CD8r39qPCQHF9gi5pNLI7L+zW3CH5P0gRV+5+gNm+
	 B5P0rUgXnTwJtrqn+7dwEZR+gBc10qF8xQdunRuwkJxF8f2Zl2pd8e7QZydw0G58YQ
	 Y9bzU5dbqGxVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 609/713] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Date: Sun, 24 Mar 2024 18:45:35 -0400
Message-ID: <20240324224720.1345309-610-sashal@kernel.org>
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


