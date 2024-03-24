Return-Path: <linux-kernel+bounces-113938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C1888877A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A162B22A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E91218530;
	Sun, 24 Mar 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz+MFpk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23211EF7F1;
	Sun, 24 Mar 2024 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321037; cv=none; b=FDnMlUC6i04t71JRztnMlrviaLjNuRcCrHP3CxljmMYym8CPCBMW2h2bLOSkD0ZfEQypr0nW6fTe3LDIOd+jyGN2UT0+LxfGsphyPohtpQ0A7FmiCRNN1lct5/FUVwZuIk0zxGN4ydT5RVh/p83VTStvw5yAvouKRGEY5qsXp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321037; c=relaxed/simple;
	bh=WV88TTyBK8qhGIefMkW1ZQfNxP20/MMMrWj+CpfwuKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmTfncwuWp44KyBywd9KZAHoM7UYUTVt3N2egChXuDkxphPen1iyUwQRQLoqi8drLmUpXCUYNRetsQteZdfIq4Vz9tKpvKw9WBWA5LlWqie9IJyHeUJmkA7D/Jt+6i7GJjfjnrla+Q749LQpZ0qmZWrN7pyZD/w39L3sM+bsom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz+MFpk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5456FC433F1;
	Sun, 24 Mar 2024 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321036;
	bh=WV88TTyBK8qhGIefMkW1ZQfNxP20/MMMrWj+CpfwuKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz+MFpk74imakJjz143ntidEVNr+O0D+Knrcr3zeHgB3X67S5u74zfOObC2vEqDcT
	 VjwFcoozS5POuGIjjuuR8ML/LSsKoyGPpp8idoN38wDdH0OwoFRkzdgO4ot+4sytl7
	 uj/r/212mXKjvrXcDJK3tridEPANx03iQixrY9dTIzWR7nxYB+O/EKczbTC+G6mW6r
	 +JGTxxmj/MGGi10I++2rebZOQwJhLsxIC7Z+uE8TduS/II8v6Ga/gGrXjsDytx1Ycl
	 Yg8Ruu7lhmv4EwiLbo7fukVjPmz/sK3iHHHoqBTGnjVSpQvBK5/CsKGkj/mK5Z8iN+
	 7P9XZ68a1OCJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Wysochanski <dwysocha@redhat.com>,
	Jeff Layton <jlayton@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 599/713] NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt
Date: Sun, 24 Mar 2024 18:45:25 -0400
Message-ID: <20240324224720.1345309-600-sashal@kernel.org>
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

From: Dave Wysochanski <dwysocha@redhat.com>

[ Upstream commit fd5860ab6341506004219b080aea40213b299d2e ]

The loop inside nfs_netfs_issue_read() currently does not disable
interrupts while iterating through pages in the xarray to submit
for NFS read.  This is not safe though since after taking xa_lock,
another page in the mapping could be processed for writeback inside
an interrupt, and deadlock can occur.  The fix is simple and clean
if we use xa_for_each_range(), which handles the iteration with RCU
while reducing code complexity.

The problem is easily reproduced with the following test:
 mount -o vers=3,fsc 127.0.0.1:/export /mnt/nfs
 dd if=/dev/zero of=/mnt/nfs/file1.bin bs=4096 count=1
 echo 3 > /proc/sys/vm/drop_caches
 dd if=/mnt/nfs/file1.bin of=/dev/null
 umount /mnt/nfs

On the console with a lockdep-enabled kernel a message similar to
the following will be seen:

 ================================
 WARNING: inconsistent lock state
 6.7.0-lockdbg+ #10 Not tainted
 --------------------------------
 inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
 test5/1708 [HC0[0]:SC0[0]:HE1:SE1] takes:
 ffff888127baa598 (&xa->xa_lock#4){+.?.}-{3:3}, at:
nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
 {IN-SOFTIRQ-W} state was registered at:
   lock_acquire+0x144/0x380
   _raw_spin_lock_irqsave+0x4e/0xa0
   __folio_end_writeback+0x17e/0x5c0
   folio_end_writeback+0x93/0x1b0
   iomap_finish_ioend+0xeb/0x6a0
   blk_update_request+0x204/0x7f0
   blk_mq_end_request+0x30/0x1c0
   blk_complete_reqs+0x7e/0xa0
   __do_softirq+0x113/0x544
   __irq_exit_rcu+0xfe/0x120
   irq_exit_rcu+0xe/0x20
   sysvec_call_function_single+0x6f/0x90
   asm_sysvec_call_function_single+0x1a/0x20
   pv_native_safe_halt+0xf/0x20
   default_idle+0x9/0x20
   default_idle_call+0x67/0xa0
   do_idle+0x2b5/0x300
   cpu_startup_entry+0x34/0x40
   start_secondary+0x19d/0x1c0
   secondary_startup_64_no_verify+0x18f/0x19b
 irq event stamp: 176891
 hardirqs last  enabled at (176891): [<ffffffffa67a0be4>]
_raw_spin_unlock_irqrestore+0x44/0x60
 hardirqs last disabled at (176890): [<ffffffffa67a0899>]
_raw_spin_lock_irqsave+0x79/0xa0
 softirqs last  enabled at (176646): [<ffffffffa515d91e>]
__irq_exit_rcu+0xfe/0x120
 softirqs last disabled at (176633): [<ffffffffa515d91e>]
__irq_exit_rcu+0xfe/0x120

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&xa->xa_lock#4);
   <Interrupt>
     lock(&xa->xa_lock#4);

  *** DEADLOCK ***

 2 locks held by test5/1708:
  #0: ffff888127baa498 (&sb->s_type->i_mutex_key#22){++++}-{4:4}, at:
      nfs_start_io_read+0x28/0x90 [nfs]
  #1: ffff888127baa650 (mapping.invalidate_lock#3){.+.+}-{4:4}, at:
      page_cache_ra_unbounded+0xa4/0x280

 stack backtrace:
 CPU: 6 PID: 1708 Comm: test5 Kdump: loaded Not tainted 6.7.0-lockdbg+
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
 Call Trace:
  dump_stack_lvl+0x5b/0x90
  mark_lock+0xb3f/0xd20
  __lock_acquire+0x77b/0x3360
  _raw_spin_lock+0x34/0x80
  nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
  netfs_begin_read+0x77f/0x980 [netfs]
  nfs_netfs_readahead+0x45/0x60 [nfs]
  nfs_readahead+0x323/0x5a0 [nfs]
  read_pages+0xf3/0x5c0
  page_cache_ra_unbounded+0x1c8/0x280
  filemap_get_pages+0x38c/0xae0
  filemap_read+0x206/0x5e0
  nfs_file_read+0xb7/0x140 [nfs]
  vfs_read+0x2a9/0x460
  ksys_read+0xb7/0x140

Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when fscache is enabled")
Suggested-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/fscache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index b05717fe0d4e4..60a3c28784e0b 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -307,11 +307,11 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	struct inode *inode = sreq->rreq->inode;
 	struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
 	struct page *page;
+	unsigned long idx;
 	int err;
 	pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
 	pgoff_t last = ((sreq->start + sreq->len -
 			 sreq->transferred - 1) >> PAGE_SHIFT);
-	XA_STATE(xas, &sreq->rreq->mapping->i_pages, start);
 
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
@@ -322,19 +322,14 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
-	xas_lock(&xas);
-	xas_for_each(&xas, page, last) {
+	xa_for_each_range(&sreq->rreq->mapping->i_pages, idx, page, start, last) {
 		/* nfs_read_add_folio() may schedule() due to pNFS layout and other RPCs  */
-		xas_pause(&xas);
-		xas_unlock(&xas);
 		err = nfs_read_add_folio(&pgio, ctx, page_folio(page));
 		if (err < 0) {
 			netfs->error = err;
 			goto out;
 		}
-		xas_lock(&xas);
 	}
-	xas_unlock(&xas);
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
-- 
2.43.0


