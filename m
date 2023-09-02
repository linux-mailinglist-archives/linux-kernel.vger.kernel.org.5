Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA8790462
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351475AbjIBABO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjIBABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:01:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103EE42
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BAE5B826B9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AB3C433C9;
        Sat,  2 Sep 2023 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693612865;
        bh=2lY72EZOdDo4UdttgZLYLQ0k+vBebrNVKUbwVgsCBMI=;
        h=Date:From:To:Cc:Subject:From;
        b=f6Y6dWWwd1DNKxEVrcVDMliGUtOpL5Vy9eyDVnJFLi8J2R1RLCO6Z4+BBA6rRWw0J
         tHMArJccg5KuhoafAStKoXTKCrwlR1kOJPEqNMN1V289gUBo1mrCPec9I1nBTz6P30
         j60+pMiYSBu+omcD+WpA9cXaw1v7wFuQGA3K/ZDT4cJCoEwF7fFSbGWNGxh6VT/o4F
         wEEPUxR3UsD+SO2w7GfsXufBCHClEtYaO/zU0c4Ts1xh+135vzvbZfDKxf//Th41O4
         Ty3gbb0IyGT7meprrN1rPDJNhC7xNHOijlHdfS3c1WSXxmaiwC2lDn7rDPdbXIaaUd
         IWPmoNhkjQ1zw==
Date:   Fri, 1 Sep 2023 17:01:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.6
Message-ID: <ZPJ7P1J+jbyL6Mve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6-6-rc1

for you to fetch changes up to 3b7166121402a5062d18dcf4e3bce083fb9e4201:

  f2fs: use finish zone command when closing a zone (2023-08-25 10:30:37 -0700)

----------------------------------------------------------------
f2fs update for 6.6-rc1

In this cycle, we don't have a highlighted feature enhancement, but mostly
have fixed issues mainly in two parts: 1) zoned block device, 2) compression
support. For zoned block device, we've tried to improve the power-off recovery
flow as much as possible. For compression, we found some corner cases caused by
wrong compression policy and logics. Other than them, there were some reverts
and stat corrections.

Bug fix:
 - use finish zone command when closing a zone
 - check zone type before sending async reset zone command
 - fix to assign compress_level for lz4 correctly
 - fix error path of f2fs_submit_page_read()
 - don't {,de}compress non-full cluster
 - send small discard commands during checkpoint back
 - flush inode if atomic file is aborted
 - correct to account gc/cp stats

And, there are minor bug fixes, avoiding false lockdep warning, and clean-ups.

----------------------------------------------------------------
Chao Yu (14):
      f2fs: don't handle error case of f2fs_compress_alloc_page()
      f2fs: fix to avoid mmap vs set_compress_option case
      f2fs: allow f2fs_ioc_{,de}compress_file to be interrupted
      f2fs: compress: don't {,de}compress non-full cluster
      Revert "f2fs: fix to do sanity check on extent cache correctly"
      f2fs: fix to update i_ctime in __f2fs_setxattr()
      f2fs: remove unneeded check condition in __f2fs_setxattr()
      f2fs: fix to account gc stats correctly
      f2fs: fix to account cp stats correctly
      f2fs: doc: fix description of max_small_discards
      Revert "f2fs: do not issue small discard commands during checkpoint"
      f2fs: clean up error handling in sanity_check_{compress_,}inode()
      f2fs: fix error path of f2fs_submit_page_read()
      f2fs: compress: fix to assign compress_level for lz4 correctly

Christoph Hellwig (1):
      f2fs: don't reopen the main block device in f2fs_scan_devices

Chunhai Guo (1):
      f2fs: Only lfs mode is allowed with zoned block device feature

Daeho Jeong (1):
      f2fs: use finish zone command when closing a zone

Jaegeuk Kim (4):
      Revert "f2fs: clean up w/ sbi->log_sectors_per_block"
      f2fs: flush inode if atomic file is aborted
      f2fs: get out of a repeat loop when getting a locked data page
      f2fs: avoid false alarm of circular locking

Minjie Du (1):
      f2fs: increase usage of folio_next_index() helper

Randy Dunlap (1):
      f2fs: fix spelling in ABI documentation

Shin'ichiro Kawasaki (1):
      f2fs: check zone type before sending async reset zone command

Zhiguo Niu (1):
      f2fs: should update REQ_TIME for direct write

 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++---
 fs/f2fs/checkpoint.c                    |  2 +-
 fs/f2fs/compress.c                      | 14 +----
 fs/f2fs/data.c                          | 14 +++--
 fs/f2fs/debug.c                         | 33 +++++++++---
 fs/f2fs/f2fs.h                          | 96 +++++++++++++++++++++------------
 fs/f2fs/file.c                          | 60 +++++++++++++++------
 fs/f2fs/gc.c                            | 18 ++++---
 fs/f2fs/inline.c                        |  3 +-
 fs/f2fs/inode.c                         | 35 ++++--------
 fs/f2fs/recovery.c                      |  1 +
 fs/f2fs/segment.c                       | 89 +++++++++++++++++++-----------
 fs/f2fs/super.c                         | 41 +++++++-------
 fs/f2fs/sysfs.c                         | 18 +++++--
 fs/f2fs/xattr.c                         |  6 +--
 15 files changed, 268 insertions(+), 176 deletions(-)
