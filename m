Return-Path: <linux-kernel+bounces-23978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09EC82B4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DCB1F28EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6853E0A;
	Thu, 11 Jan 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2GvxO0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D353E08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A32C43390;
	Thu, 11 Jan 2024 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704997692;
	bh=O1JrLIUB6Kvam8m8FN9/RwfK/9ti74DZSsh90LyxUbw=;
	h=Date:From:To:Cc:Subject:From;
	b=K2GvxO0VnDftR2wRlz0ZC3pH6KEzQ/Je9I59cnKidcPgPPMpWD0XjipWrzs8jYVZ1
	 msBif1ifaCeFRViVvk3aGwRRGbe73aKX5d3GHMTZSwY5LO75e4ikZhuw3jyK5UDMPJ
	 DhJyrJjxbta4njaDL4nTX+S2WHHQrASos6Mn1f0h+zcsNXCCqFijd0yRQyRpK2F8PH
	 T7QWi8RTS2c5MbrJxl6gyThtCNX6IYcvT6xPrvYmzndxGZT9+9fe/+OjCkT5Gw+QC5
	 vsixTrKsHLr5PMDl7zMELOZcPFcoOiP5YsiL1oavbK3oGK0w0GWdKRvVa+8O/ISxqB
	 pmQBu++Z3CaeQ==
Date: Thu, 11 Jan 2024 10:28:10 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs update for 6.8-rc1
Message-ID: <ZaAzOgd3iWL0feTU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Happy new year!

Could you please consider this pull request?

Thank you.

The following changes since commit 6bc40e44f1ddef16a787f3501b97f1fff909177c:

  Merge tag 'ovl-fixes-6.7-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs (2023-11-17 09:18:48 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1

for you to fetch changes up to c3c2d45b9050180974e35ec8672c6e788adc236a:

  f2fs: show more discard status by sysfs (2023-12-26 13:07:26 -0800)

----------------------------------------------------------------
f2fs update for 6.8-rc1

In this series, we've some progress to support Zoned block device regarding to
the power-cut recovery flow and enabling checkpoint=disable feature which is
essential for Android OTA. Other than that, some patches touched sysfs entries
and tracepoints which are minor, while several bug fixes on error handlers and
compression flows are good to improve the overall stability.

Enhancement:
 - enable checkpoint=disable for zoned block device
 - sysfs entries such as discard status, discard_io_aware, dir_level
 - tracepoints such as f2fs_vm_page_mkwrite(), f2fs_rename(), f2fs_new_inode()
 - use shared inode lock during f2fs_fiemap() and f2fs_seek_block()

Bug fix:
 - address some power-cut recovery issues on zoned block device
 - handle errors and logics on do_garbage_collect(), f2fs_reserve_new_block(),
   f2fs_move_file_range(), f2fs_recover_xattr_data()
 - don't set FI_PREALLOCATED_ALL for partial write
 - fix to update iostat correctly in f2fs_filemap_fault()
 - fix to wait on block writeback for post_read case
 - fix to tag gcing flag on page during block migration
 - restrict max filesize for 16K f2fs
 - fix to avoid dirent corruption
 - explicitly null-terminate the xattr list

There are also several clean-up patches to remove dead codes and better
readability.

----------------------------------------------------------------
Chao Yu (18):
      f2fs: clean up w/ dotdot_name
      f2fs: use shared inode lock during f2fs_fiemap()
      f2fs: fix to check return value of f2fs_reserve_new_block()
      f2fs: fix to avoid dirent corruption
      f2fs: introduce tracepoint for f2fs_rename()
      f2fs: show i_mode in trace_f2fs_new_inode()
      f2fs: sysfs: support discard_io_aware
      f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
      f2fs: delete obsolete FI_DROP_CACHE
      f2fs: introduce get_dnode_addr() to clean up codes
      f2fs: update blkaddr in __set_data_blkaddr() for cleanup
      f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
      f2fs: add tracepoint for f2fs_vm_page_mkwrite()
      f2fs: fix to tag gcing flag on page during block migration
      f2fs: fix to wait on block writeback for post_read case
      f2fs: fix to check compress file in f2fs_move_file_range()
      f2fs: fix to update iostat correctly in f2fs_filemap_fault()
      f2fs: don't set FI_PREALLOCATED_ALL for partial write

Daniel Rosenberg (1):
      f2fs: Restrict max filesize for 16K f2fs

Eric Biggers (1):
      f2fs: explicitly null-terminate the xattr list

Jaegeuk Kim (6):
      f2fs: skip adding a discard command if exists
      f2fs: allow checkpoint=disable for zoned block device
      f2fs: allocate new section if it's not new
      f2fs: fix write pointers on zoned device after roll forward
      f2fs: check write pointers when checkpoint=disable
      f2fs: let's finish or reset zones all the time

Kevin Hao (1):
      f2fs: Use wait_event_freezable_timeout() for freezable kthread

Yang Hubin (1):
      f2fs: the name of a struct is wrong in a comment.

Yongpeng Yang (2):
      f2fs: Constrain the modification range of dir_level in the sysfs
      f2fs: Add error handling for negative returns from do_garbage_collect

Zhiguo Niu (2):
      f2fs: fix to check return value of f2fs_recover_xattr_data
      f2fs: show more discard status by sysfs

zhangxirui (1):
      f2fs: use inode_lock_shared instead of inode_lock in f2fs_seek_block()

 Documentation/ABI/testing/sysfs-fs-f2fs |  21 +++++
 fs/f2fs/compress.c                      |   6 +-
 fs/f2fs/data.c                          |  48 ++++-------
 fs/f2fs/f2fs.h                          |  46 +++++++----
 fs/f2fs/file.c                          |  66 +++++++--------
 fs/f2fs/gc.c                            |  16 ++--
 fs/f2fs/inode.c                         |  57 ++++---------
 fs/f2fs/namei.c                         |  23 +++---
 fs/f2fs/node.c                          |   6 +-
 fs/f2fs/recovery.c                      |  25 ++++--
 fs/f2fs/segment.c                       | 138 +++++++++++---------------------
 fs/f2fs/super.c                         |  16 ++--
 fs/f2fs/sysfs.c                         |  50 ++++++++++++
 fs/f2fs/xattr.c                         |  17 +++-
 include/linux/f2fs_fs.h                 |   2 +-
 include/trace/events/f2fs.h             | 127 +++++++++++++++++++++++++----
 16 files changed, 395 insertions(+), 269 deletions(-)

