Return-Path: <linux-kernel+bounces-115981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62548898FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571DC29DAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1639799E;
	Mon, 25 Mar 2024 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqmj1Twx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724314E2FD;
	Sun, 24 Mar 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322300; cv=none; b=j3MFbYPHlUqotkmamKAwtpysDIhg1J8sAv45mt4uveo/V5U9B1GTb35BavMfMOnaqaM9CfV9r8wQA9YpzFXN6LY8ZRF44EEyZtLKx7t0Vxu+UQkIssvoWq2oDquI4tien/Q3nFNHCnweM1gS8IWOHeq/lUS9/9S9KDn2XUi52DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322300; c=relaxed/simple;
	bh=ywVlg6DZv4JOoFCoouN0S5IfzQM17zzw6ZSyM4sxDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeBbiHwwuKZnRBkkYcGRd7NIj+NYRXKxJGgp9Z43TgeYmT29IaAcADLPhLnsLex9DqF9u5L44wALtZ93A6+F5ShDVRWolykfQG/ymmRzBXRy/V/eLfeX4XtnHsMfKs9tYsLJUFyEkoZSCHQD+pw1O5g1oKcQka69iHYusgDn+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqmj1Twx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B93C433F1;
	Sun, 24 Mar 2024 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322300;
	bh=ywVlg6DZv4JOoFCoouN0S5IfzQM17zzw6ZSyM4sxDm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dqmj1TwxP42WvFV8Wgshbucr4/WRzgiRaALOmvTqOAfLf6L1mMpgA6m5NBxAMQtlx
	 WQRpCKbTp3VD85ISeybf/P/iNdO9zWl7hwryMHRZLYzoXFai7iVq0SlthU1P6xugNy
	 HoDCB4MFaJXCM+ZAYFiMgADPrMptk7M+Zu33T2L+6+Rt9S+xNW6TRR6NYanYUxWeXc
	 8gSpIgKqYW1xLvBAECcsO5PLIFEsnSVtef3pIpsLIy4kkjRIElvbmWGK+wHUQV6yEg
	 N5sFEmkrtQDlPIR3Pi8RAqBrNKR2H5tgbRkNL7UE+1gUwpLbLK7Eue1hlCXF5/9XsK
	 oQLkTmkur8Bbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 383/451] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Date: Sun, 24 Mar 2024 19:10:59 -0400
Message-ID: <20240324231207.1351418-384-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 81bbafab18a99..4376881be7918 100644
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


