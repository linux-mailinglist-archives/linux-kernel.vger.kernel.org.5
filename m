Return-Path: <linux-kernel+bounces-24084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277482B699
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A14288621
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71258208;
	Thu, 11 Jan 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkAmrtxC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEE5812E;
	Thu, 11 Jan 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=b0t3x6hCu0x/ojo3PHAaC3r4/bQ6bUFU+eeGlqR4ams=; b=JkAmrtxCDZsHE68Vt/5sWw6/E5
	xy/vZscRMIjfovLNp/OexA4gtXsc2GAVq7qPJrmJpWsgJRZAMD/5NiglDY7f7bndxm8txRepEsok9
	gKwCWONbgJ4FY6JoWqVES+rYgEYB4GZRnNK0msgYCESzSZB0YqNMvxecCOjjXD6TN6EJKGsTJMrce
	+0tAOPJAxTQ1GEdJbN1nHSNTHYr3kqSKJIu0gPiDv8SrsvGRSud5oTk38qYKlGZauqQ+MYRM5QB6l
	JJa42YJ70zYONifTp7j276PAV8tRWEbBx3CDcp14JvDnXC9nceuIIeFeuF7TkIUK8ZIWSAQm9IUIV
	XHwy30ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO2XO-00EzID-CS; Thu, 11 Jan 2024 21:24:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/3] Remove the XFS mrlock
Date: Thu, 11 Jan 2024 21:24:21 +0000
Message-Id: <20240111212424.3572189-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFS has an mrlock wrapper around the rwsem which adds only the
functionality of knowing whether the rwsem is currently held in read
or write mode.  Both regular rwsems and rt-rwsems know this, they just
don't expose it as an API.  By adding that, we can remove the XFS mrlock
as well as improving the debug assertions for the mmap_lock when lockdep
is disabled.

I have an ack on the first patch from Peter, so I would like to see this
merged through the XFS tree since most of what it touches is XFS.

v5:
 - Rebase on 5bad490858c3 (current Linus head) to pick up XFS changes

v4:
 - Switch the BUG_ONs to WARN_ONs (Wayman, Peter)

v3:
 - Rename __rwsem_assert_held() and __rwsem_assert_held_write() to
   rwsem_assert_held*_nolockdep()
 - Use IS_ENABLED(CONFIG_LOCKDEP) to only dump the information once
 - Use ASSERT instead of BUG_ON in xfs
 - Fix typo in subject line of patch 4
 - Drop patch 5 (inode_assert_locked)
 - Rebase on top of xfs-6.7-merge-2 which had a merge conflict

v2: Add rwsem_assert_held() and rwsem_assert_held_write() instead of
augmenting the existing rwsem_is_locked() with rwsem_is_write_locked().
There's also an __rwsem_assert_held() and __rwsem_assert_held_write()
for the benefit of XFS when it's in a context where lockdep doesn't
know what's going on.  It's still an improvement, so I hope those who
are looking for perfection can accept a mere improvement.

Matthew Wilcox (Oracle) (3):
  locking: Add rwsem_assert_held() and rwsem_assert_held_write()
  xfs: Replace xfs_isilocked with xfs_assert_ilocked
  xfs: Remove mrlock wrapper

 fs/xfs/libxfs/xfs_attr.c        |  2 +-
 fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
 fs/xfs/libxfs/xfs_bmap.c        | 21 ++++----
 fs/xfs/libxfs/xfs_defer.c       |  2 +-
 fs/xfs/libxfs/xfs_inode_fork.c  |  2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c    |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +--
 fs/xfs/mrlock.h                 | 78 ------------------------------
 fs/xfs/scrub/readdir.c          |  4 +-
 fs/xfs/xfs_attr_list.c          |  2 +-
 fs/xfs/xfs_bmap_util.c          | 10 ++--
 fs/xfs/xfs_dir2_readdir.c       |  2 +-
 fs/xfs/xfs_dquot.c              |  4 +-
 fs/xfs/xfs_file.c               |  4 +-
 fs/xfs/xfs_inode.c              | 86 ++++++++++++---------------------
 fs/xfs/xfs_inode.h              |  4 +-
 fs/xfs/xfs_inode_item.c         |  4 +-
 fs/xfs/xfs_iops.c               |  7 ++-
 fs/xfs/xfs_linux.h              |  2 +-
 fs/xfs/xfs_qm.c                 | 10 ++--
 fs/xfs/xfs_reflink.c            |  2 +-
 fs/xfs/xfs_rtalloc.c            |  2 +-
 fs/xfs/xfs_super.c              |  4 +-
 fs/xfs/xfs_symlink.c            |  2 +-
 fs/xfs/xfs_trans.c              |  2 +-
 fs/xfs/xfs_trans_dquot.c        |  2 +-
 include/linux/rwbase_rt.h       |  9 +++-
 include/linux/rwsem.h           | 46 ++++++++++++++++--
 28 files changed, 129 insertions(+), 194 deletions(-)
 delete mode 100644 fs/xfs/mrlock.h

-- 
2.43.0


