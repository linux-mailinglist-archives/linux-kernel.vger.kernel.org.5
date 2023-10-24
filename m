Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8504C7D4A31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjJXIdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjJXIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:33:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9519F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3054778b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136391; x=1698741191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4opiNsnZZqBguAp7l0z4RxGxoCkwHsLxMKsqrGAlKDc=;
        b=TosXE3THPP0MYI08BO3t74sz56iejbd4fKyJwgls9G/nmJjusHEaaJkF9inZQQiGsG
         MBBMetPaFiaN81b7QQtiqUUEkB5t6tCMluMwz81L+3nNrO4IgAOkxgG8b0oddTIpbdR9
         PciXrA9x8RXiIDqmYXzlCMxSHwgvXYDLgInCy6Ajqi8IFtTwHNG24JwUf2mDrFQNFPiB
         t4Cv0DtxJdBX9PO56uO9hbFwXtKBbGpvmc6AJ4cvj0226kHIfdDAk38Ciupt81JVUgNr
         4h23BaVc3Psirqb7M+/Ojais0zDlPWnO2K43BOI0/I7iqZ7MktNCuh+UiDOF7YgQt+Rf
         0Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136391; x=1698741191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4opiNsnZZqBguAp7l0z4RxGxoCkwHsLxMKsqrGAlKDc=;
        b=k4YRzYTMh1SlTy/KuOkNS3FKDWsmzPFw7kjyJ4DzNmGEMS2yQXOiZ748XyPkpvBUau
         KJNGZqrH0TWCgb7xDmZrSwWZwU6ug2wi86vq3n91g3ExjzgFPO22TMWy8Y5B5l54Shua
         7PFpJB15FDm3C6xRglqr2j2PB0KKHpzKbZ46t1GUDT6t5ytcOqcVKJvcqgyyprCmfrr5
         Tjro+GUhwciQPkMg/0BHY6vH/Jq2nCIliR4agLBuGT+3HXpcoo0QeDtzN2MtV7wmoqli
         /pCDrqAA3SWYM+q6ZbcRiTSRixV1R2IdGJjde+PBNzOfRITtwwX83vXklIjxWBmdVusF
         fl+w==
X-Gm-Message-State: AOJu0YxkC4BpZbVVwtutCOFhsZ0IXejEebTcbl76UxTtR3AHil+lG0vC
        pkoXjly7A/75mopDbjhsU7tOIw==
X-Google-Smtp-Source: AGHT+IFXSjkx04QR9nnz2TOFagUSULaL4sE18aVqctpq0U3SrAkmlMjZs5t6jtsN6WvK4/eUHQsGBg==
X-Received: by 2002:aa7:8395:0:b0:68f:cbd3:5b01 with SMTP id u21-20020aa78395000000b0068fcbd35b01mr19416967pfm.13.1698136390755;
        Tue, 24 Oct 2023 01:33:10 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:10 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 00/10] Introduce __mt_dup() to improve the performance of fork()
Date:   Tue, 24 Oct 2023 16:32:48 +0800
Message-Id: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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

Hi all,

This series introduces __mt_dup() to improve the performance of fork(). During
the duplication process of mmap, all VMAs are traversed and inserted one by one
into the new maple tree, causing the maple tree to be rebalanced multiple times.
Balancing the maple tree is a costly operation. To duplicate VMAs more
efficiently, mtree_dup() and __mt_dup() are introduced for the maple tree. They
can efficiently duplicate a maple tree.

Here are some algorithmic details about {mtree,__mt}_dup(). We perform a DFS
pre-order traversal of all nodes in the source maple tree. During this process,
we fully copy the nodes from the source tree to the new tree. This involves
memory allocation, and when encountering a new node, if it is a non-leaf node,
all its child nodes are allocated at once.

This idea was originally from Liam R. Howlett's Maple Tree Work email, and I
added some of my own ideas to implement it. Some previous discussions can be
found in [1]. For a more detailed analysis of the algorithm, please refer to the
logs for patch [3/10] and patch [10/10].

There is a "spawn" in byte-unixbench[2], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. The first row shows the number of VMAs.
The second and third rows show the number of fork() calls per ten seconds,
corresponding to next-20231006 and the this patchset, respectively. The
test results were obtained with CPU binding to avoid scheduler load
balancing that could cause unstable results. There are still some
fluctuations in the test results, but at least they are better than the
original performance.

21     121   221    421    821    1621   3221   6421   12821  25621  51221
112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%

Thanks to Liam and Matthew for the review.

Changes since v5:
 - Correct the copyright statement.
 - Add Suggested-by tag in patch [3/10] and [10/10], this work was originally
   proposed by Liam R. Howlett.
 - Some cleanup and comment corrections for patch [3/10].
 - Use vma_iter* series interfaces as much as possible in [10/10].

[1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
[2] https://github.com/kdlucas/byte-unixbench/tree/master

v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230830125654.21257-1-zhangpeng.00@bytedance.com/
v3: https://lore.kernel.org/lkml/20230925035617.84767-1-zhangpeng.00@bytedance.com/
v4: https://lore.kernel.org/lkml/20231009090320.64565-1-zhangpeng.00@bytedance.com/
v5: https://lore.kernel.org/lkml/20231016032226.59199-1-zhangpeng.00@bytedance.com/

Peng Zhang (10):
  maple_tree: Add mt_free_one() and mt_attr() helpers
  maple_tree: Introduce {mtree,mas}_lock_nested()
  maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
  radix tree test suite: Align kmem_cache_alloc_bulk() with kernel
    behavior.
  maple_tree: Add test for mtree_dup()
  maple_tree: Update the documentation of maple tree
  maple_tree: Skip other tests when BENCH is enabled
  maple_tree: Update check_forking() and bench_forking()
  maple_tree: Preserve the tree attributes when destroying maple tree
  fork: Use __mt_dup() to duplicate maple tree in dup_mmap()

 Documentation/core-api/maple_tree.rst |   4 +
 include/linux/maple_tree.h            |   7 +
 include/linux/mm.h                    |  11 +
 kernel/fork.c                         |  40 ++-
 lib/maple_tree.c                      | 290 +++++++++++++++++++-
 lib/test_maple_tree.c                 | 123 +++++----
 mm/internal.h                         |  11 -
 mm/memory.c                           |   7 +-
 mm/mmap.c                             |   9 +-
 tools/include/linux/rwsem.h           |   4 +
 tools/include/linux/spinlock.h        |   1 +
 tools/testing/radix-tree/linux.c      |  45 +++-
 tools/testing/radix-tree/maple.c      | 363 ++++++++++++++++++++++++++
 13 files changed, 813 insertions(+), 102 deletions(-)

-- 
2.20.1

