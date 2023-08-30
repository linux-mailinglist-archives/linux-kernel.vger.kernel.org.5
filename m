Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADBE78DA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjH3SgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343988AbjH3Rxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:53:41 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5A193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:53:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68a56401b5bso7602563b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418018; x=1694022818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qn85V7xkChNZBzxdpkci4eOIaMaLPSl7wYjvXs+DpjY=;
        b=vkOP3ZnFKkRZ3TacZtGaMg3vM75xZc7q+8eOc/oojVwBS7QwaUgW8JOlUfPgM9PPAB
         5dJAinETPRWHSJPR0Rb9J8uVH1lv8JYvhQmYNmJ1vmUdiUiCbMwWXs8sOTdlN64Hgxhg
         6GTyATw8L3Ocd5MEMmU6P2ti3i9622QF9I/AEOm6O6MnDN/23kfGFKcf1QP75o24hCv+
         Jj80MuQl2nq3f357Fhn+B+vrLkTu0ggtS6jFv7jnrXHXRJYdACawL+XZtexJiSa1LHTL
         /a2gJ9EZ5X3GHxrgAIiZtAuKOmZQmVy1qN/yx55pSwOlHsDzVs8+LDRyF91j9PT6FHV3
         nT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418018; x=1694022818;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qn85V7xkChNZBzxdpkci4eOIaMaLPSl7wYjvXs+DpjY=;
        b=I59fV1v3VO5mw24aYK6u9Dws9QThTiNDi//IasNVSkyx45sKrA1Lf79mLG+XB8C/Xx
         eQ7IBAzZpGm82Z8qrPzvWo+bErtCDzazq/fyOGnbJU5UCYd/BhCwScWtOH/BsAhi/9eN
         BLakZjf/234aqCeIwDVrx+vlKJRKy6k3sR8TZ9T4es9aeq+AByksKqL5WZEGyGhWhMtq
         0GLifxCOWIlYNQUFOYaStM8F/QE2wcDJHvdU9HRon4X5X995AIeFUWVhE/ENAPgKa0QT
         OLENUdA//q0i1WY0N5IvTAGoe4mEXMr7rLGuk+f1qi8kBQLSFMpygxzZ+InhZwoFLA/b
         0zag==
X-Gm-Message-State: AOJu0Yyu3g/6xg7+xH5WVzWpMrucVKmjqCAvjLI9+hQxnYtoW6ZaD25L
        fIKOFWYvLZtOGwdiiZBbIuCj+CztTDPtTivY
X-Google-Smtp-Source: AGHT+IGGDKKfoNP2xfxTBpw+9N5MksrPBIQXDSHS7eCPZsqXaSM9BVLpOjsAYkP4jO89eNOeY/j/0cNO6HzdBDkK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:17a5:b0:68a:6082:2c54 with
 SMTP id s37-20020a056a0017a500b0068a60822c54mr1000970pfg.6.1693418018100;
 Wed, 30 Aug 2023 10:53:38 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:53:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830175335.1536008-1-yosryahmed@google.com>
Subject: [PATCH v3 0/4] memcg: non-unified flushing for userspace stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most memcg flushing contexts using "unified" flushing, where only one
flusher is allowed at a time (others skip), and all flushers need to
flush the entire tree. This works well with high concurrency, which
mostly comes from in-kernel flushers (e.g. reclaim, refault, ..).

For userspace reads, unified flushing leads to non-deterministic stats
staleness and reading cost. This series clarifies and documents the
differences between unified and non-unified flushing (patches 1 & 2),
then opts userspace reads out of unified flushing (patch 3).

This patch series is a follow up on the discussion in [1]. That was a
patch that proposed that userspace reads wait for ongoing unified
flushers to complete before returning. There were concerns about the
latency that this introduces to userspace reads, especially with ongoing
reports of expensive stat reads even with unified flushing. Hence, this
series follows a different approach, by opting userspace reads out of
unified flushing completely. The cost of userspace reads are now
determinstic, and depend on the size of the subtree being read. This
should fix both the *sometimes* expensive reads (due to flushing the
entire tree) and occasional staless (due to skipping flushing).

I attempted to remove unified flushing completely, but noticed that
in-kernel flushers with high concurrency (e.g. hundreds of concurrent
reclaimers). This sort of concurrency is not expected from userspace
reads. More details about testing and some numbers in the last patch's
changelog.

v2 -> v3:
- Renamed stats_flush_ongoing to stats_unified_flush_ongoing in patch 1
  for more clarity.
- Added a mutex for flushes by userspace readers to guard the internal
  globla rstat lock from being hogged by userspace readers as suggested
  by Tejun Heo and Waiman Long.
- Fixed a bug in v2, where patch 4 also opted mem_cgroup_wb_stats() out
  of unified flushing by mistake. mem_cgroup_wb_stats() is not for
  userspace reading.

v2: https://lore.kernel.org/lkml/20230828233319.340712-1-yosryahmed@google.com/

Yosry Ahmed (4):
  mm: memcg: properly name and document unified stats flushing
  mm: memcg: add a helper for non-unified stats flushing
  mm: memcg: let non-unified root stats flushes help unified flushes
  mm: memcg: use non-unified stats flushing for userspace reads

 include/linux/memcontrol.h |   8 +--
 mm/memcontrol.c            | 106 +++++++++++++++++++++++++++----------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |   4 +-
 4 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

