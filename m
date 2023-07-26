Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A92764152
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGZVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGZVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803112118
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so9345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690407739; x=1691012539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F181xJ+n7Njx8QINZmeQ5WSTONEtBtx60R4njTyAO6w=;
        b=Q9/Uar7kbm/fDXXNdNUkPT5MjHTU9yfaxCVi/uxAavCHvr3IT/3ZNnNLg+MKNI4YL6
         Jtc5XHBGRhprCUa7Wk6WQmejjG0NDu9cV5Jl8+aE7wB3c8OAnz7ap2exn/MqswefA4XL
         kv7hkNyM/nXCsMkoGDG5RM7C0cZoo6eeAiJh1yG5nLHSJlTIADJmTSPVlHieAXb+uKz1
         nLGVDL9fQWFk5IioJvDjH8qhSTVsD0MsA2l82mK5JKp9ClqnxkLhy2we8kb2loP9P7bG
         EvNtUrP2FWKznSA+DFmTees7h3R0e1W56zyPM7IcYaQAA87Pqtl/wrV2rhsq2WHbNRyj
         W+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690407739; x=1691012539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F181xJ+n7Njx8QINZmeQ5WSTONEtBtx60R4njTyAO6w=;
        b=AjTuZw1qoewhxDjZo8FPPybYdLaUM+rwC2Rk0SLYCFUrRk6nwHEPEfx/dC29vq6aEy
         OlohBYZMU+ki4LFjqHniQv0aq9sttV+4VjsYwrJ2pcFOcW4O80MEeB6AlJZKcuk7y5P2
         s4URuYxub5yHC8shkiUPNBwwgM+3r7UCOu8VkS2V9fo0ob+raHXxPApDwaV1HWXDM/AS
         YwUbTNFbk/G45GImNnqZxlz1G8fTKKDtBHCkBy8Hn0QbsLbwFL/3IYUwNZ+iDohtCKTE
         btLUUJCs6rlwUl4zG/5cac7RPBjH2NcRPCDMuf66iw3YKJHsb3qtXubB4kkfroxmHUQX
         m/fQ==
X-Gm-Message-State: ABy/qLbqfU/Gb8TQUGAxUqc4wE/Cv/i06LvEDGWbt5FxTOnaRfJGDVNA
        iOtT0RadQObuXRT2VQJJ6iuOog==
X-Google-Smtp-Source: APBJJlGt5NLcLPw0mVwNnTg9Wjjhuc8TP6mEQ6+lI3ZhoneODO/CaYmfdQ9XC1bJySvoHtz02LbFxA==
X-Received: by 2002:a05:600c:1ca1:b0:3f1:9a3d:4f7f with SMTP id k33-20020a05600c1ca100b003f19a3d4f7fmr5322wms.1.1690407738850;
        Wed, 26 Jul 2023 14:42:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:e8c:2042:5dec:b586])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm3047945wmc.0.2023.07.26.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:42:17 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix anon_vma memory ordering
Date:   Wed, 26 Jul 2023 23:41:01 +0200
Message-ID: <20230726214103.3261108-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Patch 1 here is a straightforward fix for a race in per-VMA locking code
that can lead to use-after-free; I hope we can get this one into
mainline and stable quickly.

Patch 2 is a fix for what I believe is a longstanding memory ordering
issue in how vma->anon_vma is used across the MM subsystem; I expect
that this one will have to go through a few iterations of review and
potentially rewrites, because memory ordering is tricky.
(If someone else wants to take over patch 2, I would be very happy.)

These patches don't really belong together all that much, I'm just
sending them as a series because they'd otherwise conflict.

I am CCing:

 - Suren because patch 1 touches his code
 - Matthew Wilcox because he is also currently working on per-VMA
   locking stuff
 - all the maintainers/reviewers for the Kernel Memory Consistency Model
   so they can help figure out the READ_ONCE() vs smp_load_acquire()
   thing
 - people involved in the previous discussion on the security list


Jann Horn (2):
  mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
  mm: Fix anon_vma memory ordering

 include/linux/rmap.h | 15 ++++++++++++++-
 mm/huge_memory.c     |  4 +++-
 mm/khugepaged.c      |  2 +-
 mm/ksm.c             | 16 +++++++++++-----
 mm/memory.c          | 32 ++++++++++++++++++++------------
 mm/mmap.c            | 13 ++++++++++---
 mm/rmap.c            |  6 ++++--
 mm/swapfile.c        |  3 ++-
 8 files changed, 65 insertions(+), 26 deletions(-)


base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
-- 
2.41.0.487.g6d72f3e995-goog

