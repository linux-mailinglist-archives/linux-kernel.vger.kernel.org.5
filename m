Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F337E10B0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjKDTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKDTEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:04:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0331BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC7BC433C7;
        Sat,  4 Nov 2023 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699124650;
        bh=CJ5CvH2XKc3qIHFJg91oPL9wmqC3HtPop6Zvp2wfKU4=;
        h=Date:From:To:Cc:Subject:From;
        b=SjvuLTLkbH2wTuPAZ4n3+hJ6FNhKX5CDC5YQ/hSwwp0q+LLQMrqVkzmCX2C4RvSqY
         4zPUeJd+Hke9yTWBTu8avItJKnk00ciQxFiJtlOXTAVrr8zHsvo2PxFt2OQXtPE5DU
         lEvc/9JEV8tWrN/zly7kKhcZQyHsWw+VfRtGLRd1wfXdrzv83SoRouAyNYRX+8T159
         UjPpo9fZ3W6Q6Wfzlio5mZvODJtEc0qC00cHDQ/+ZyATtqNs1gGMa1pfmY3p3wlQjI
         KgtH+En8K4LpoqDTz8J+IAeEnY8KPghWbdxMQ7lF1otjJSKvhSANTMm5DNwsNyQsxy
         AbjpCksZYvh2g==
Date:   Sat, 4 Nov 2023 12:04:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs update for 6.7
Message-ID: <ZUaVqCoMnLi7bV6P@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull reuqest?

Thank you!

The following changes since commit 3669558bdf354cd352be955ef2764cde6a9bf5ec:

  Merge tag 'for-6.6-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-09-12 11:28:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.7-rc1

for you to fetch changes up to 1e7bef5f90ed69d903768d78369f251b77e5d2f5:

  f2fs: finish previous checkpoints before returning from remount (2023-10-22 06:42:02 -0700)

----------------------------------------------------------------
f2fs update for 6.7-rc1

In this cycle, we introduce a bigger page size support by changing the internal
f2fs's block size aligned to the page size. We also continue to improve zoned
block device support regarding the power off recovery. As usual, there are some
bug fixes regarding the error handling routines in compression and ioctl.

Enhancement:
 - Support Block Size == Page Size
 - let f2fs_precache_extents() traverses in file range
 - stop iterating f2fs_map_block if hole exists
 - preload extent_cache for POSIX_FADV_WILLNEED
 - compress: fix to avoid fragment w/ OPU during f2fs_ioc_compress_file()

Bug fix:
 - do not return EFSCORRUPTED, but try to run online repair
 - finish previous checkpoints before returning from remount
 - fix error handling of __get_node_page and __f2fs_build_free_nids
 - clean up zones when not successfully unmounted
 - fix to initialize map.m_pblk in f2fs_precache_extents()
 - fix to drop meta_inode's page cache in f2fs_put_super()
 - set the default compress_level on ioctl
 - fix to avoid use-after-free on dic
 - fix to avoid redundant compress extension
 - do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on
 - fix deadloop in f2fs_write_cache_pages()

----------------------------------------------------------------
Chao Yu (8):
      f2fs: compress: fix deadloop in f2fs_write_cache_pages()
      f2fs: compress: fix to avoid use-after-free on dic
      f2fs: compress: do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on
      f2fs: compress: fix to avoid redundant compress extension
      f2fs: fix to drop meta_inode's page cache in f2fs_put_super()
      f2fs: compress: fix to avoid fragment w/ OPU during f2fs_ioc_compress_file()
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()
      f2fs: let f2fs_precache_extents() traverses in file range

Daeho Jeong (2):
      f2fs: clean up zones when not successfully unmounted
      f2fs: finish previous checkpoints before returning from remount

Daniel Rosenberg (1):
      f2fs: Support Block Size == Page Size

Jaegeuk Kim (5):
      f2fs: split initial and dynamic conditions for extent_cache
      f2fs: set the default compress_level on ioctl
      f2fs: preload extent_cache for POSIX_FADV_WILLNEED
      f2fs: stop iterating f2fs_map_block if hole exists
      f2fs: do not return EFSCORRUPTED, but try to run online repair

KaiLong Wang (1):
      f2fs: Clean up errors in segment.h

Su Hui (1):
      f2fs: avoid format-overflow warning

Zhiguo Niu (2):
      f2fs: fix error path of __f2fs_build_free_nids
      f2fs: fix error handling of __get_node_page

 fs/f2fs/compress.c      | 63 +++++++++++++++++--------------
 fs/f2fs/data.c          | 35 ++++++++++++++----
 fs/f2fs/extent_cache.c  | 53 +++++++++++---------------
 fs/f2fs/file.c          | 17 ++++++++-
 fs/f2fs/inode.c         |  2 +-
 fs/f2fs/node.c          | 20 +++++++---
 fs/f2fs/segment.c       | 92 ++++++++++++++++++++++++++++------------------
 fs/f2fs/segment.h       |  4 +-
 fs/f2fs/super.c         | 98 ++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/xattr.c         | 20 ++++++----
 include/linux/f2fs_fs.h | 70 +++++++++++++++++++++--------------
 11 files changed, 296 insertions(+), 178 deletions(-)
