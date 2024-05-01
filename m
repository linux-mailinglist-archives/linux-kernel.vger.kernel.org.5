Return-Path: <linux-kernel+bounces-165798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A18B91C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275BB1F21E69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CE1635CD;
	Wed,  1 May 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cil/ygQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BA1C68D;
	Wed,  1 May 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604383; cv=none; b=rAatSgrcVItt8dXvSeM/DyswZEDVVh0bUuDbGOfqrNzed3hNggVo0nm7WjVj8SEkKsajGyPEeydFj1gf46sj3ZSELhMxwlAYzHqYzgyHkr140vw1cYmPVsq0q96cCwQoE6heczbk1Dim+8eSKRFs6VBJz0eOM/9vvkHiCcq5VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604383; c=relaxed/simple;
	bh=eBENjwP1TKJMaG2J5RN07Fr8FtAXTh1BcKSwysOhx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmxgF4LeW1TGff3d0VP+uhLIATpxGdn0smVSvdXd7ZK9xztykjdozL7wb7e3mcPAC+F9c847lXxuAVm2168h7IukKL4a+DrdPnZWUBkZ9Sgg6Tzq5IdjnRLHEUCNbvclI+BuryxcszDvnmOkweA6kKONapv0pDwS+eSJlpz3dD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cil/ygQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B98FC072AA;
	Wed,  1 May 2024 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604383;
	bh=eBENjwP1TKJMaG2J5RN07Fr8FtAXTh1BcKSwysOhx3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cil/ygQukMXVb10w/DhBX8psIk61vSnnjH7h1se8PiX/Vc4AJWv2XOHUq051HAQYP
	 7rzt6PV/xppoBZ8slwKqO9bC1jbzgIgAwvytJtHFYo882uHQbjvSuu1bYnjzAR2ioZ
	 vF/1TYQi2y4793ZZqqr1cuuMatH5M3a2ERC0IY1Zq+nJTANjeFR8l4tvOHMrwWJ7fg
	 wIMqA/rDA38sn/Rpq1gMgb07sn6oPpLIpG/4sW0Nz0lAp6Lsjb7xxYaQOAQGXExmy2
	 CISMoHXLJXPHjqQLXJr0s+6bc7B4LIpf+KwKOvBaiQSt4AyG1GcrlGmViKeleKHF/2
	 zcH8foKknm9LA==
Date: Wed, 1 May 2024 15:59:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Fengfei Xi <xi.fengfei@h3c.com>
Cc: sandeen@sandeen.net, darrick.wong@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	tian.xianting@h3c.com
Subject: Re: [PATCH] xfs: fix system crash caused by null bp->b_pages
Message-ID: <20240501225942.GN360919@frogsfrogsfrogs>
References: <63d75865-84c6-0f76-81a2-058f4cad1d84@sandeen.net>
 <20240428034436.42237-1-xi.fengfei@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428034436.42237-1-xi.fengfei@h3c.com>

On Sun, Apr 28, 2024 at 11:44:36AM +0800, Fengfei Xi wrote:
> >On 12/24/20 3:51 AM, Fengfei Xi wrote:
> >> We have encountered the following problems several times:
> >>     1、A raid slot or hardware problem causes block device loss.
> >>     2、Continue to issue IO requests to the problematic block device.
> >>     3、The system possibly crash after a few hours.
> 
> >What kernel is this on?
> 
> >> dmesg log as below:
> >> [15205901.268313] blk_partition_remap: fail for partition 1
> 
> >I think this message has been gone since kernel v4.16...
> 
> >If you're testing this on an old kernel, can you reproduce it on a
> >current kernel?
> 
> >> [15205901.319309] blk_partition_remap: fail for partition 1
> >> [15205901.319341] blk_partition_remap: fail for partition 1
> >> [15205901.319873] sysctl (3998546): drop_caches: 3
> 
> >What performed the drop_caches immediately before the BUG?  Does
> >the BUG happen without drop_caches?
> 
> >> [15205901.371379] BUG: unable to handle kernel NULL pointer dereference at
> 
> >was something lost here?  "dereference at" ... what?
> 
> >> [15205901.372602] IP: xfs_buf_offset+0x32/0x60 [xfs]
> >> [15205901.373605] PGD 0 P4D 0
> >> [15205901.374690] Oops: 0000 [#1] SMP
> >> [15205901.375629] Modules linked in:
> >> [15205901.382445] CPU: 6 PID: 18545 Comm: xfsaild/sdh1 Kdump: loaded Tainted: G
> >> [15205901.384728] Hardware name:
> >> [15205901.385830] task: ffff885216939e80 task.stack: ffffb28ba9b38000
> >> [15205901.386974] RIP: 0010:xfs_buf_offset+0x32/0x60 [xfs]
> >> [15205901.388044] RSP: 0018:ffffb28ba9b3bc68 EFLAGS: 00010246
> >> [15205901.389021] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000b
> >> [15205901.390016] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88627bebf000
> >> [15205901.391075] RBP: ffffb28ba9b3bc98 R08: ffff88627bebf000 R09: 00000001802a000d
> >> [15205901.392031] R10: ffff88521f3a0240 R11: ffff88627bebf000 R12: ffff88521041e000
> >> [15205901.392950] R13: 0000000000000020 R14: ffff88627bebf000 R15: 0000000000000000
> >> [15205901.393858] FS:  0000000000000000(0000) GS:ffff88521f380000(0000) knlGS:0000000000000000
> >> [15205901.394774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [15205901.395756] CR2: 0000000000000000 CR3: 000000099bc09001 CR4: 00000000007606e0
> >> [15205901.396904] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> [15205901.397869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> [15205901.398836] PKRU: 55555554
> >> [15205901.400111] Call Trace:
> >> [15205901.401058]  ? xfs_inode_buf_verify+0x8e/0xf0 [xfs]
> >> [15205901.402069]  ? xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
> >> [15205901.403060]  xfs_inode_buf_write_verify+0x10/0x20 [xfs]
> >> [15205901.404017]  _xfs_buf_ioapply+0x88/0x410 [xfs]
> >> [15205901.404990]  ? xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
> >> [15205901.405929]  xfs_buf_submit+0x63/0x200 [xfs]
> >> [15205901.406801]  xfs_buf_delwri_submit_buffers+0x16d/0x2b0 [xfs]
> >> [15205901.407675]  ? xfs_buf_delwri_submit_nowait+0x10/0x20 [xfs]
> >> [15205901.408540]  ? xfs_inode_item_push+0xb7/0x190 [xfs]
> >> [15205901.409395]  xfs_buf_delwri_submit_nowait+0x10/0x20 [xfs]
> >> [15205901.410249]  xfsaild+0x29a/0x780 [xfs]
> >> [15205901.411121]  kthread+0x109/0x140
> >> [15205901.411981]  ? xfs_trans_ail_cursor_first+0x90/0x90 [xfs]
> >> [15205901.412785]  ? kthread_park+0x60/0x60
> >> [15205901.413578]  ret_from_fork+0x2a/0x40
> >> 
> >> The "obvious" cause is that the bp->b_pages was NULL in function
> >> xfs_buf_offset. Analyzing vmcore, we found that b_pages=NULL but
> >> b_page_count=16, so b_pages is set to NULL for some reason.
> 
> >this can happen, for example _xfs_buf_get_pages sets the count, but may
> >fail the allocation, and leave the count set while the pointer is NULL.
> >> 
> >> crash> struct xfs_buf ffff88627bebf000 | less
> >>     ...
> >>   b_pages = 0x0,
> >>   b_page_array = {0x0, 0x0},
> >>   b_maps = 0xffff88627bebf118,
> >>   __b_map = {
> >>     bm_bn = 512,
> >>     bm_len = 128
> >>   },
> >>   b_map_count = 1,
> >>   b_io_length = 128,
> >>   b_pin_count = {
> >>     counter = 0
> >>   },
> >>   b_io_remaining = {
> >>     counter = 1
> >>   },
> >>   b_page_count = 16,
> >>   b_offset = 0,
> >>   b_error = 0,
> >>     ...
> >> 
> >> To avoid system crash, we can add the check of 'bp->b_pages' to
> >> xfs_inode_buf_verify(). If b_pages == NULL, we mark the buffer
> >> as -EFSCORRUPTED and the IO will not dispatched.
> >> 
> >> Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
> >> Reviewed-by: Xianting Tian <tian.xianting@h3c.com>
> >> ---
> >>  fs/xfs/libxfs/xfs_inode_buf.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >> 
> >> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> >> index c667c63f2..5a485c51f 100644
> >> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> >> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> >> @@ -45,6 +45,17 @@ xfs_inode_buf_verify(
> >>  	int		i;
> >>  	int		ni;
> >>  
> >> +	/*
> >> +	 * Don't crash and mark buffer EFSCORRUPTED when b_pages is NULL
> >> +	 */
> >> +	if (!bp->b_pages) {
> >> +		xfs_buf_ioerror(bp, -EFSCORRUPTED);
> >> +		xfs_alert(mp,
> >> +			"xfs_buf(%p) b_pages corruption detected at %pS\n",
> >> +			bp, __return_address);
> >> +		return;
> >> +	}
> 
> >This seems fairly ad hoc.
> 
> >I think we need a better idea of how we got here; why should inode buffers
> >be uniquely impacted (or defensively protected?)  Can you reproduce this
> >using virtual devices so the test can be scripted?
> 
> Hi, we have confirmed through the systemtap instrumentation of ioerror that 
> the issue is related to the cleanup logic for xfs_log_item->li_flags in the 
> xfs_buf_resubmit_failed_buffers function. 
> 
> As described in commit d43aaf1685aa471f0593685c9f54d53e3af3cf3f: 
> if we clear the log item failed state before queuing the buffer for IO 
> we can release all active references to the buffer and free it, 
> leading to use after free problems in xfs_buf_delwri_queue.
> 
> If we trigger dropcache between xfs_clear_li_failed and xfs_buf_delwri_queue,
> as no one holds the xfs_buf, the xfs_buf is released.

Er... doesn't bp->b_pages==NULL imply that bp is now a stale pointer?

--D

> Currently, after incorporating the modifications, the issue has not reoccurred.
> 
> --
> Thanks, 
> 
> Fengfei.Xi
> 

