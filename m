Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9041F7A8C34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjITTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81505C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d25b1dbdso98190b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236580; x=1695841380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHWMgku4LLrGTufn8n1g27TfkS1hUDllwGuoEQkkyB0=;
        b=AawrvxPGP5QsPPA/QzC7LsBojHztHgIeZ4OSFCd1hN5C4D5uwL7SmWTT2A0RvNngNZ
         yqW76Vrc1N1NSkNlxwZPC6/qq1TkRTAc8+nb7GPdAtSPIWM8kVZWeO7h4iLbPjSEloBI
         VyRs37iGWfi1hJITDjHFHn0qjM14dvaNnBt+3vrpJmilZkXHOt78jgm6JjKxZSj4rHnQ
         jGGtdhXYBGWKHgpW7Nvb9DWMr3hqAv1BPhNMCTP4myFHCNhk+qeRYgvsgimtOEOmG44F
         bgxrw5Ux4BDrjMFwAcgy33t26pzh3pebQ6VfGMx8YAb8c/yCC8PzZAkz/0fRwecxyMHi
         Wjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236580; x=1695841380;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHWMgku4LLrGTufn8n1g27TfkS1hUDllwGuoEQkkyB0=;
        b=wRJnbVDNVMF4wYFEfZN2PdDgko78FIPbS67+QoySz+jQtKZNMQRLnIIKXhhkwwNQLZ
         YX6m6aW/Hcu6B6N4Rh2c0N+fZEG0GJ5eazhCOT6l6p2yc8K9KMUQCYwnlOjFUGMp7ajd
         2+yp29i993XhjlEGgtIIDlkZIfgGi01jkkSAu/Vdgnjt42tEVhIpQZLMPu6LencELBFR
         KP03UG2DtRJ/00r6UX18ibAMgPSEIgeCI99r9k0/9qMgId4L5xZ+YEtkqTi7uGHDDwBS
         Kvj/khzsGk92qQxNPctqikv/J0WTRqwj0fj56EWbE/iEKmUpzupq3mgx9p8GzPjU58px
         rbxw==
X-Gm-Message-State: AOJu0YxV1oA2FGSUhkXrI1RCwOGBj/uDSdRQ0tSUG3f5DJgluzWe3e24
        VP/Tp7u5aLh3LrUqx+PuVGY=
X-Google-Smtp-Source: AGHT+IGVg2XSENvLktAqZHQqkry/EQebwFO4mWYs8eMdqulN7NUvY80VGar70a8xd+peAgrSNcqYIQ==
X-Received: by 2002:a05:6a20:7d88:b0:132:ff57:7fab with SMTP id v8-20020a056a207d8800b00132ff577fabmr4220198pzj.2.1695236579796;
        Wed, 20 Sep 2023 12:02:59 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.02.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:02:59 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 0/6] Refault distance update with MGLRU support
Date:   Thu, 21 Sep 2023 03:02:38 +0800
Message-ID: <20230920190244.16839-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

I noticed MGLRU not working very well on certain workflows, which is
observed on some workloads with heavy memory stress.

After some debugging, I found this was related to refault distance
detection, when the file page workingset size exceeds total memory,
and the access distance (the left-shift time of a page before it gets
activated or promoted, considering LRU starts from right) of file pages
are larger than total memory. All file pages are stuck on the oldest
generation and getting read-in then evicted permutably, few get activated
and stay in memory.

This series tries to fix this problem by rework the refault distance
based activation to better fit MGLRU, and also tries to use a unified
algorithm for both MGLRU and Inactive/Active LRU, the performance almost
doubled for the workloads that are not working well previously.

Patch 1/5 reworked the refault distance detection model for
Inactive/Active LRU, and updated the comments.

Patch 2/5 splitted the code logic into a helper, prepare for MGLRU.

Patch 3/5 and 4/5 are code simplification and updates for MGLRU.

Patch 5/5 applies the modified refault distance algorithm
for MGLRU.

Following benchmark showed 5x improvement:
To simulate the workflow, I setup a 3-replicated mongodb cluster using
docker, each in a standalone cgroup, set to use 5GB of wiretiger cache
and 10g of oplog, on a 32G VM. The benchmark is done using
https://github.com/apavlo/py-tpcc.git, modified to run STOCK_LEVEL
query only, for simulating slow query and get a stable result.

Before (with ZRAM enabled, the result won't change whether
any kind of swap is on or not):
$ tpcc.py --config=mongodb.config mongodb --duration=900 --warehouses=500 --clients=30
==================================================================
Execution Results after 919 seconds
------------------------------------------------------------------
                  Executed        Time (µs)       Rate
  STOCK_LEVEL     577             27584645283.7   0.02 txn/s
------------------------------------------------------------------
  TOTAL           577             27584645283.7   0.02 txn/s

Patched (with ZRAM enabled):
$ tpcc.py --config=mongodb.config mongodb --duration=900 --warehouses=500 --clients=30
==================================================================
Execution Results after 905 seconds
------------------------------------------------------------------
                  Executed        Time (µs)       Rate
  STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
------------------------------------------------------------------
  TOTAL           2542            27121571486.2   0.09 txn/s

The performance is 5x times better than before. Testing with lower
stress and some other benchmarks also shows slight improvement or
equivalent performance (eg. fio tests shows a observable performance gain).

Sending out as RFC, I'm still doing more test on it, since this changed
a frequently used algorithm and not really sure if there is any performance
regression on long term. It should improvement the performance for file
pages in general even if there are low memory pressure, since it saved
some cgroup iterations and atomic operations.

Update from V2:
- Rebase to latest mm-stable and redone some tests.
- Split the algorithm change into a stand alone patch as
  suggested by Johannes Weiner.

Update from V1:
- Removed the fls operations which previously used in patch 1 for
  protecting active pages by expontial ratio, simply compare with number of
  inactive pages seems good enough.
- Update some benchmarks results, test result that are basically
  identical as before are not updated.

Kairui Song (6):
  workingset: simplify and use a more intuitive model
  workingset: move refault distance checking into to a helper
  workignset: simplify the initilization code
  workingset: simplify lru_gen_test_recent
  mm, lru_gen: convert avg_total and avg_refaulted to atomic
  workingset, lru_gen: apply refault-distance based re-activation

 include/linux/mmzone.h |   4 +-
 include/linux/swap.h   |   2 -
 mm/swap.c              |   1 -
 mm/vmscan.c            |  30 +--
 mm/workingset.c        | 416 +++++++++++++++++++++--------------------
 5 files changed, 236 insertions(+), 217 deletions(-)

-- 
2.41.0

