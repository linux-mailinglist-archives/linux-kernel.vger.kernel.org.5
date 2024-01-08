Return-Path: <linux-kernel+bounces-19468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A769A826D67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49ADFB217FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875C22EF7;
	Mon,  8 Jan 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHrCe9Zc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084022068
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704715561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HtmrrRZs23B4hXwrrEuiwzHUR6n+wAsGzVFjIlhR+Rs=;
	b=dHrCe9ZclzU3upv9v0DoPzBel66ltEgPyw1AG6OkM3jEhEn1/FbWAGwrdw2IEtJ87rGeDp
	55xAQY8e/RfotnpZk4Ii/6f36ZYeLUxVWUONJSnx1PeJmhEzHbTgTVHBpI5zJWSs+VFnwd
	bnShsdCDaeNKRLufbN79okdRYaN3q0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-mSyYL8gpNv-4cBr26tSdRg-1; Mon, 08 Jan 2024 07:05:55 -0500
X-MC-Unique: mSyYL8gpNv-4cBr26tSdRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A285585A58B;
	Mon,  8 Jan 2024 12:05:55 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.227.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA3401C060AF;
	Mon,  8 Jan 2024 12:05:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes
Date: Mon,  8 Jan 2024 13:05:53 +0100
Message-ID: <20240108120553.4993-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hello Linus,

please consider pulling the following gfs2 changes.

In addition to the usual fixes and cleanups, this adds gfs2 support for
non-blocking lookups (MAY_NOT_BLOCK / LOOKUP_RCU).  That's a worthwhile
improvement by itself and gets us one step closer to making RESOLVE_CACHED
work (*).

https://lore.kernel.org/linux-fsdevel/20231109190844.2044940-1-agruenba@redhat.com/

Thanks,
Andreas

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.7-rc1-fixes

for you to fetch changes up to e345b87b0b0444d1c644b0ea15cfb50e88f10b55:

  gfs2: Fix freeze consistency check in log_write_header (2023-12-27 13:16:48 +0100)

----------------------------------------------------------------
gfs2 updates

- Add support for non-blocking lookup (MAY_NOT_BLOCK / LOOKUP_RCU)

- Various minor fixes and cleanups

----------------------------------------------------------------
Abhi Das (1):
      gfs2: Use GL_NOBLOCK flag for non-blocking lookups

Al Viro (2):
      gfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing
      gfs2: use is_subdir()

Andreas Gruenbacher (9):
      gfs2: Fix inode_go_instantiate description
      gfs2: Add GL_NOBLOCK flag
      gfs2: Minor gfs2_ail1_empty cleanup
      gfs2: Mark withdraws as unlikely
      gfs2: Rename gfs2_withdrawn to gfs2_withdrawing_or_withdrawn
      gfs2: Lift withdraw check out of gfs2_ail1_empty
      gfs2: Minor gfs2_{freeze,thaw}_super cleanup
      gfs2: Refcounting fix in gfs2_thaw_super
      gfs2: Fix freeze consistency check in log_write_header

Edward Adam Davis (1):
      gfs2: fix kernel BUG in gfs2_quota_cleanup

Kevin Hao (2):
      gfs2: Add missing set_freezable() for freezable kthread
      gfs2: Use wait_event_freezable_timeout() for freezable kthread

Matthew Wilcox (Oracle) (1):
      gfs2: Remove use of error flag in journal reads

Osama Muhammad (1):
      gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Randy Dunlap (1):
      gfs2: rgrp: fix kernel-doc warnings

 fs/gfs2/aops.c       |  2 +-
 fs/gfs2/dentry.c     | 23 ++++++++------
 fs/gfs2/export.c     |  2 --
 fs/gfs2/file.c       |  2 +-
 fs/gfs2/glock.c      | 47 +++++++++++++++++++++++++---
 fs/gfs2/glock.h      |  1 +
 fs/gfs2/glops.c      |  4 +--
 fs/gfs2/inode.c      |  8 ++---
 fs/gfs2/lock_dlm.c   |  8 ++---
 fs/gfs2/log.c        | 63 +++++++++++++++++++++----------------
 fs/gfs2/lops.c       | 21 +++++--------
 fs/gfs2/meta_io.c    |  9 ++++--
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/quota.c      | 16 +++++-----
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/rgrp.c       | 12 +++----
 fs/gfs2/super.c      | 88 +++++++++++++++++++++-------------------------------
 fs/gfs2/sys.c        |  2 +-
 fs/gfs2/trans.c      |  2 +-
 fs/gfs2/util.c       |  4 +--
 fs/gfs2/util.h       | 15 ++++-----
 21 files changed, 182 insertions(+), 151 deletions(-)


