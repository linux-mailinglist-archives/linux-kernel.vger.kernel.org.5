Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D8797AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbjIGRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbjIGRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD861990;
        Thu,  7 Sep 2023 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ykzxARVy4uCl6EJxalPtEu7KNDbQwm8SXBvTZkNjJPY=; b=Njpcz/IyQT0fdTQWkzaJwynKDt
        grfkwXy3awyPXJF2veO4UspVoBdf27UlM1dayYrxsB7RWqjm/4wW0bVokj3a0NfREiAqZuD+7JDod
        ScEIUkk8Y85CrX4Xtl1GdJH+R3GfOe6dpsa+8PPxQGtMdeOuEex8hcbGDH0+6h1cll2+MwNfpPq8y
        1Yn7d1t5yrWkwrY321FIn/1Voclkp/cF9kfNfa/OiVG2qmhQDxiJRn2ysBx8aT4CNYBGuA8bKO5b0
        +aI1t/4evcLGsE4QMu6NkKrbXezfOVVkVjA4u5A3aq96G/1NCyspCs2LiZRAs6Efbh39ks4he24eK
        TUww7iug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeJ5v-00CUFH-Ai; Thu, 07 Sep 2023 17:47:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 0/5] Remove the XFS mrlock
Date:   Thu,  7 Sep 2023 18:47:00 +0100
Message-Id: <20230907174705.2976191-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

I'd like acks from the locking people, then it probably should go upstream
through the XFS tree since that's where the patch series touches the
most code.

Matthew Wilcox (Oracle) (5):
  locking: Add rwsem_is_write_locked()
  mm: Use rwsem_is_write_locked in mmap_assert_write_locked
  xfs: Use rwsem_is_write_locked()
  xfs: Remove mrlock wrapper
  xfs: Stop using lockdep to assert that locks are held

 fs/xfs/mrlock.h           | 78 ---------------------------------------
 fs/xfs/xfs_inode.c        | 61 ++++++++++--------------------
 fs/xfs/xfs_inode.h        |  2 +-
 fs/xfs/xfs_iops.c         |  4 +-
 fs/xfs/xfs_linux.h        |  2 +-
 fs/xfs/xfs_super.c        |  4 +-
 include/linux/mmap_lock.h |  2 +-
 include/linux/rwbase_rt.h |  5 +++
 include/linux/rwsem.h     | 10 +++++
 9 files changed, 40 insertions(+), 128 deletions(-)
 delete mode 100644 fs/xfs/mrlock.h

-- 
2.40.1

