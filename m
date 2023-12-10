Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3380BE64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjLJX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJX5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:57:19 -0500
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD553EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:57:23 -0800 (PST)
Date:   Sun, 10 Dec 2023 18:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702252642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h7rXAs69dsNWlMVqeR5qiVX7rKSJND/l1/P8dU0zdyc=;
        b=FnMM5Wl6jJmu+cvz/WLDNDRf73iC6TVQnHxZKY9fcF/nOcEK9vTCRWtlupzVaqLIE6N1Yf
        iReyVOTHfyAuXIwBO1JPp1XUPHTaapJDDnOrpXDIBm+5TZH7XHIJlv4k/u5DXdv1pswjwB
        aszr72OK9E+7VaIDhBVQcKKMI/XnwUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] More bcachefs fixes for 6.7
Message-ID: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, more bcachefs fixes for 6.7. Nothing terribly exciting, the
bug squashing continues...

Cheers,
Kent

----------------------------------------------------------------

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-10

for you to fetch changes up to a66ff26b0f31189e413a87065c25949c359e4bef:

  bcachefs: Close journal entry if necessary when flushing all pins (2023-12-10 16:53:46 -0500)

----------------------------------------------------------------
More bcachefs bugfixes for 6.7:

 - Fix a rare emergency shutdown path bug: dropping journal pins after
   the filesystem has mostly been torn down is not what we want.
 - Fix some concurrency issues with the btree write buffer and journal
   replay by not using the btree write buffer until journal replay is
   finished
 - A fixup from the prior patch to kill journal pre-reservations: at the
   start of the btree update path, where previously we took a
   pre-reservation, we do at least want to check the journal watermark.
 - Fix a race between dropping device metadata and btree node writes,
   which would re-add a pointer to a device that had just been dropped
 - Fix one of the SCRU lock warnings, in
   bch2_compression_stats_to_text().
 - Partial fix for a rare transaction paths overflow, when indirect
   extents had been split by background tasks, by not running certain
   triggers when they're not needed.
 - Fix for creating a snapshot with implicit source in a subdirectory of
   the containing subvolume
 - Don't unfreeze when we're emergency read-only
 - Fix for rebalance spinning trying to compress unwritten extentns
 - Another deleted_inodes fix, for directories
 - Fix a rare deadlock (usually just an unecessary wait) when flushing
   the journal with an open journal entry.

----------------------------------------------------------------
Brian Foster (1):
      bcachefs: don't attempt rw on unfreeze when shutdown

Daniel Hill (1):
      bcachefs: rebalance shouldn't attempt to compress unwritten extents

Kent Overstreet (10):
      bcachefs: Don't drop journal pins in exit path
      bcachefs; Don't use btree write buffer until journal replay is finished
      bcachefs: Fix a journal deadlock in replay
      bcachefs: Fix bch2_extent_drop_ptrs() call
      bcachefs: Convert compression_stats to for_each_btree_key2
      bcachefs: Don't run indirect extent trigger unless inserting/deleting
      bcachefs: Fix creating snapshot with implict source
      bcachefs: Fix deleted inode check for dirs
      bcachefs: Fix uninitialized var in bch2_journal_replay()
      bcachefs: Close journal entry if necessary when flushing all pins

 fs/bcachefs/btree_cache.c           |  8 +++-----
 fs/bcachefs/btree_io.c              |  4 ++--
 fs/bcachefs/btree_io.h              |  3 ---
 fs/bcachefs/btree_key_cache.c       |  2 --
 fs/bcachefs/btree_update.c          | 16 ++++++++++++++++
 fs/bcachefs/btree_update_interior.c | 11 +++++++++++
 fs/bcachefs/data_update.c           |  4 ++--
 fs/bcachefs/dirent.c                | 19 +++++++++++--------
 fs/bcachefs/dirent.h                |  1 +
 fs/bcachefs/extents.c               |  3 ++-
 fs/bcachefs/fs-ioctl.c              |  2 +-
 fs/bcachefs/fs.c                    |  3 +++
 fs/bcachefs/inode.c                 | 15 ++++++++++-----
 fs/bcachefs/journal.c               |  8 ++++----
 fs/bcachefs/journal.h               |  1 +
 fs/bcachefs/journal_io.c            |  1 +
 fs/bcachefs/journal_reclaim.c       |  3 +++
 fs/bcachefs/recovery.c              |  2 +-
 fs/bcachefs/reflink.c               |  8 ++++++++
 fs/bcachefs/sysfs.c                 |  8 ++++----
 20 files changed, 84 insertions(+), 38 deletions(-)
