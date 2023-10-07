Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5827BC9C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJGUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjJGUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:36:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDE95;
        Sat,  7 Oct 2023 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TF/aqVn3IrPnAMqnSHzChnQi0apaIvuOdxt0Uorvv1E=; b=D3iwRI4Gvzv9R9HV3nr9SWYP+s
        RdPiYvPHnG64BZK2SzCbvTwNWhcnYMlYkwGALT2aEiqtaKZnaCALWYgm0MWGHhD8oGn9kfTF9enem
        NetzCtD4xQREvOZ4jXL1aTsL1kWhwbRLCsutNPGYwtaujQKRGRamU/XdZL7b+i+3btAl4Nm5skEzP
        ccJl7S82yyWJeai2rto3f8d9OiLsOTr2b+52aFNSjCREUH4N5WFYLQTTKEuXsXa4w2ePNoq+3VNb6
        hPZ6INb5AhYpZv2WUlIReGB4xllPL/lkJNpE622MtUYd/2QyD+lZ4IjBdOp7cZYtwEd1wxCoLiq2/
        nmbReRHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpE1Y-005mL8-Eh; Sat, 07 Oct 2023 20:35:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/5] Remove the XFS mrlock
Date:   Sat,  7 Oct 2023 21:35:38 +0100
Message-Id: <20231007203543.1377452-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFS has an mrlock wrapper around the rwsem which adds only the
functionality of knowing whether the rwsem is currently held in read
or write mode.  Both regular rwsems and rt-rwsems know this, they just
don't expose it as an API.  By adding that, we can remove the XFS mrlock
as well as improving the debug assertions for the mmap_lock when lockdep
is disabled.

v2: Add rwsem_assert_held() and rwsem_assert_held_write() instead of
augmenting the existing rwsem_is_locked() with rwsem_is_write_locked().
There's also an __rwsem_assert_held() and __rwsem_assert_held_write()
for the benefit of XFS when it's in a context where lockdep doesn't
know what's going on.  It's still an improvement, so I hope those who
are looking for perfection can accept a mere improvement.

We can do more to replace uses of rwsem_is_locked(), and I have a few of
those in my tree, but let's focus on these three use cases for now and
we can trickle in other improvements through other maintainers after 6.7.

I'm sympathetic to "this will warn twice and dump much the same
information if you have lockdep enabled".  Perhaps somebody has a
suggestion for not doing that?

Matthew Wilcox (Oracle) (5):
  locking: Add rwsem_assert_held() and rwsem_assert_held_write()
  mm: Use rwsem assertion macros for mmap_lock
  xfs: Replace xfs_isilocked with xfs_assert_locked
  xfs: Remove mrlock wrapper
  fs: Add inode_assert_locked() and inode_assert_locked_excl()

 fs/attr.c                       |  2 +-
 fs/namei.c                      |  6 +--
 fs/xfs/libxfs/xfs_attr.c        |  2 +-
 fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
 fs/xfs/libxfs/xfs_bmap.c        | 19 ++++----
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
 fs/xfs/xfs_rtalloc.c            |  4 +-
 fs/xfs/xfs_super.c              |  4 +-
 fs/xfs/xfs_symlink.c            |  2 +-
 fs/xfs/xfs_trans_dquot.c        |  2 +-
 include/linux/fs.h              | 10 ++++
 include/linux/mmap_lock.h       | 10 ++--
 include/linux/rwbase_rt.h       |  9 +++-
 include/linux/rwsem.h           | 42 ++++++++++++++--
 31 files changed, 142 insertions(+), 203 deletions(-)
 delete mode 100644 fs/xfs/mrlock.h

-- 
2.40.1

