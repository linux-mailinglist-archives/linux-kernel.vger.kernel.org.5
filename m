Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE207EF4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjKQOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjKQOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:52:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0CD6E;
        Fri, 17 Nov 2023 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2TYOXhkj7x810xSAvtF/cEDHanY3PKLSEl1T1XfqudQ=; b=HE2i7bgWmXkvnGMiC2WxmSINb4
        WgtCG1DWJzcf7S5/5voTzZGEGGpvpG1RqU4A+7g/P31+BfR9Ze2vhNig3dYRj12T4JxReB4plz5Qs
        +Rizm2+s0gMQVgduPywu/k8AeYVTuoFci2OuU9zNtIpgp04bP9HC5/lDLuErLTr11oX7gkpXXriB6
        GptH7Ybsb2BrkyyvzFQXtBXWarB5X9DmZp8evq72IorijZljcKvJxMUI/9bG2Vew+IqjvbLtZV5N7
        fQkgNmTXPHqHodR4hn4Z0i4mfykEx2ODv78iDGXkx1jN1Jlk0YbA6C9kxAcRufm0tPH1UTU5FpUXL
        m4hTsIWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r40C7-009ypt-Ib; Fri, 17 Nov 2023 14:51:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 0/4] Remove the XFS mrlock
Date:   Fri, 17 Nov 2023 14:51:38 +0000
Message-Id: <20231117145142.2378800-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

We can do more to replace uses of rwsem_is_locked(), and I have a few of
those in my tree, but let's focus on these two use cases for now and
we can trickle in other improvements through other maintainers after 6.8.


Matthew Wilcox (Oracle) (4):
  locking: Add rwsem_assert_held() and rwsem_assert_held_write()
  mm: Use rwsem assertion macros for mmap_lock
  xfs: Replace xfs_isilocked with xfs_assert_ilocked
  xfs: Remove mrlock wrapper

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
 include/linux/mmap_lock.h       | 10 ++--
 include/linux/rwbase_rt.h       |  9 +++-
 include/linux/rwsem.h           | 46 ++++++++++++++++--
 28 files changed, 132 insertions(+), 199 deletions(-)
 delete mode 100644 fs/xfs/mrlock.h

-- 
2.42.0

