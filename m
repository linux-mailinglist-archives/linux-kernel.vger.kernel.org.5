Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD47AC3F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjIWRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:35:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487EF124;
        Sat, 23 Sep 2023 10:35:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D8C433C9;
        Sat, 23 Sep 2023 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695490531;
        bh=LDzoxQiXR1UXK5eOrDD8NSF+bFzFTzgjToeIVd++w2U=;
        h=Date:From:To:Cc:Subject:From;
        b=AwWC8ST+NjkhQqQJNaHk7Y7x1NiZYTkDdBeI4PZtgCQUiFjVvRcXW3+Mj1U8WG+gf
         pymMM/Wj5Io6Zz+mz7QUOV1LaohIcQdu7vgmbD75rVNpKxYYtm3I5jD3H0Wsk8r66Y
         pTLVJzp5n6qbOQlh+UhmPlrPA+8FGqir8IiYvrOQ=
Date:   Sat, 23 Sep 2023 10:35:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.6-rc3
Message-Id: <20230923103530.4df4257fc2b80c97a52b55b6@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull this batch of hotfixes, thanks.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-09-23-10-31

for you to fetch changes up to fe4419801617514765974f3e796269bc512ad146:

  proc: nommu: fix empty /proc/<pid>/maps (2023-09-19 13:21:34 -0700)

----------------------------------------------------------------
13 hotfixes, 10 of which pertain to post-6.5 issues.  The other 3 are
cc:stable.

----------------------------------------------------------------
Alexey Dobriyan (1):
      selftests/proc: fixup proc-empty-vm test after KSM changes

Andrew Morton (1):
      revert "scripts/gdb/symbols: add specific ko module load command"

Ben Wolsieffer (2):
      proc: nommu: /proc/<pid>/maps: release mmap read lock
      proc: nommu: fix empty /proc/<pid>/maps

Geert Uytterhoeven (1):
      sh: mm: re-add lost __ref to ioremap_prot() to fix modpost warning

Jens Axboe (1):
      task_work: add kerneldoc annotation for 'data' argument

Johannes Weiner (2):
      mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list
      mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement

Randy Dunlap (3):
      scatterlist: add missing function params to kernel-doc
      argv_split: fix kernel-doc warnings
      pidfd: prevent a kernel-doc warning

Ryan Roberts (1):
      selftests: link libasan statically for tests with -fsanitize=address

Yin Fengwei (1):
      filemap: add filemap_map_order0_folio() to handle order0 folio

 arch/sh/mm/ioremap.c                         |  4 +-
 fs/proc/internal.h                           |  2 -
 fs/proc/task_nommu.c                         | 64 +++++++++++++++-----------
 include/linux/memcontrol.h                   |  4 +-
 include/linux/resume_user_mode.h             |  2 +-
 kernel/pid.c                                 |  2 +-
 kernel/task_work.c                           |  1 +
 lib/argv_split.c                             |  4 +-
 lib/scatterlist.c                            |  4 +-
 mm/filemap.c                                 | 69 +++++++++++++++++++---------
 mm/memcontrol.c                              |  6 +--
 mm/page_alloc.c                              | 12 ++---
 scripts/gdb/linux/symbols.py                 | 23 +---------
 tools/testing/selftests/fchmodat2/Makefile   |  2 +-
 tools/testing/selftests/openat2/Makefile     |  2 +-
 tools/testing/selftests/proc/proc-empty-vm.c |  1 +
 16 files changed, 111 insertions(+), 91 deletions(-)

