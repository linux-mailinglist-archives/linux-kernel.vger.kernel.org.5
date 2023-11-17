Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B97EFB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346256AbjKQWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:33:34 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBED4F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:33:30 -0800 (PST)
Date:   Fri, 17 Nov 2023 17:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700260408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=op13F3XEN7FjDKlCWlYMcAKyKy+rR7LtkeYSw6GZX7w=;
        b=ZjwZV0tN5AwYZkUFXKLEJ09DiglxyMaAjiwxGcFuTLiPvZu1fiILmcfbtxQ8Hf+RzTqezS
        MoE8Pdnc2OcHN0a6/gVcuxR3Q5J1/Gj67jYjO3fMdtuzsslg3HAEaGsRMA0Hb4fDUiRZtF
        b3io4pgMS0f6C2ZVDSvlF2q3F9yOf+U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes
Message-ID: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, bugfix pull request for you :)

Cheers,
Kent

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-17

for you to fetch changes up to ba276ce5865b5a22ee96c4c5664bfefd9c1bb593:

  bcachefs: Fix missing locking for dentry->d_parent access (2023-11-16 16:57:19 -0500)

----------------------------------------------------------------
bcachefs bugfixes for 6.7

Lots of small fixes for minor nits and compiler warnings. Bigger items:

 - The six locks lost wakeup is finally fixed: six_read_trylock() was
   checking for the waiting bit before decrementing the number of
   readers - validated the fix with a torture test.

 - Fix for a memory reclaim issue: when needing to reallocate a key
   cache key, we now do our usual GFP_NOWAIT; unlock(); GFP_KERNEL
   dance.

 - Multiple deleted inodes btree fixes

 - Fix an issue in fsck, where i_nlink would be recalculated incorrectly
   for hardlinked files if a snapshot had ever been taken.

 - Kill journal pre-reservations: This is a bigger patch than I would
   normally send at this point, but it deletes code and it fixes some of
   our tests that would sporadically die with the journal getting stuck,
   and it's a performance improvement, too.

----------------------------------------------------------------
Daniel J Blueman (1):
      bcachefs: Fix potential sleeping during mount

Gustavo A. R. Silva (2):
      bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix multiple -Warray-bounds warnings
      bcachefs: Fix multiple -Warray-bounds warnings

Jiapeng Chong (1):
      bcachefs: make bch2_target_to_text_sb static

Kent Overstreet (18):
      bcachefs: Use correct fgf_t type as function argument
      bcachefs: Fix null ptr deref in bch2_backpointer_get_node()
      bcachefs: Guard against insufficient devices to create stripes
      bcachefs: Split out btree_key_cache_types.h
      bcachefs: Run btree key cache shrinker less aggressively
      bcachefs: btree_trans->write_locked
      bcachefs: Make sure to drop/retake btree locks before reclaim
      bcachefs: Check for nonce offset inconsistency in data_update path
      bcachefs: Kill journal pre-reservations
      bcachefs: Fix iterator leak in may_delete_deleted_inode()
      bcachefs: Fix error path in bch2_mount()
      bcachefs: Fix missing transaction commit
      bcachefs: Disable debug log statements
      bcachefs: Don't decrease BTREE_ITER_MAX when LOCKDEP=y
      bcachefs: Fix bch2_check_nlinks() for snapshots
      bcachefs: Fix no_data_io mode checksum check
      bcachefs: six locks: Fix lost wakeup
      bcachefs: Fix missing locking for dentry->d_parent access

 fs/bcachefs/backpointers.c          |  10 +--
 fs/bcachefs/bcachefs.h              |   2 +-
 fs/bcachefs/btree_iter.c            |   2 -
 fs/bcachefs/btree_key_cache.c       |  37 ++++----
 fs/bcachefs/btree_key_cache_types.h |  34 ++++++++
 fs/bcachefs/btree_trans_commit.c    | 169 ++++++++++++++++++++----------------
 fs/bcachefs/btree_types.h           |  35 +-------
 fs/bcachefs/btree_update_interior.c |  30 -------
 fs/bcachefs/btree_update_interior.h |   1 -
 fs/bcachefs/data_update.c           |  28 ++++++
 fs/bcachefs/disk_groups.c           |   4 +-
 fs/bcachefs/ec.c                    |  16 +++-
 fs/bcachefs/fs-io-pagecache.c       |   2 +-
 fs/bcachefs/fs-io-pagecache.h       |   2 +-
 fs/bcachefs/fs.c                    |   8 +-
 fs/bcachefs/fsck.c                  |   2 +-
 fs/bcachefs/inode.c                 |   8 +-
 fs/bcachefs/io_write.c              |   2 +-
 fs/bcachefs/journal.c               |  31 -------
 fs/bcachefs/journal.h               |  98 ---------------------
 fs/bcachefs/journal_io.c            |   7 ++
 fs/bcachefs/journal_reclaim.c       |  42 ++++-----
 fs/bcachefs/journal_types.h         |  26 ------
 fs/bcachefs/six.c                   |   7 +-
 fs/bcachefs/subvolume_types.h       |   2 +-
 fs/bcachefs/trace.h                 |  11 +--
 fs/bcachefs/xattr.c                 |   9 ++
 27 files changed, 248 insertions(+), 377 deletions(-)
 create mode 100644 fs/bcachefs/btree_key_cache_types.h
