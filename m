Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352397BF14E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441964AbjJJDVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441955AbjJJDVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:21:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F3A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:21:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso7274050276.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908080; x=1697512880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LVnT/y0R3LkPemDBgYVR7UpcgonMc+8VI5Wxeio9uFU=;
        b=DDTplumpkAsBSj1wMFy7c5Xu/eZeK5L0WE3BWXEU28l0WQd47bh3gcVt10frS5ivf8
         6SWIQGCMxwhkKXqxqoGm/qEHOc5Zk92HRTFUCMriOJ1AeA9S0JsAaOWDLfFDFLwX20sm
         fEFVjrM0vcfrGmc5byB+8lABCIGIZk5hkYS1YyccWEOmwplr8fAQUzzbcK7cTFzKzh6b
         4cd3rdsu8qVwWbqh68IvFEmQE52P663uguBjWBYM7kSWRb965vR/VtUZtbnKgu2FlAoP
         jCdpnsvdD1Z0CAKlOXwb5v4qEZFGNWBBcDR5eXv0hDxLmVnpilYbSEPbgwusEXGsn3LB
         2g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908080; x=1697512880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVnT/y0R3LkPemDBgYVR7UpcgonMc+8VI5Wxeio9uFU=;
        b=c3K/RfOWt+psHrsAYoUUM14TgHQSX6jsNMkHrdNe1nkm13UCs9woO3xLD2W+Leu6En
         zwR2i8Gwo15ejRq/IgJYakHbW3nhGMFVdK1XzDqiht6z7tKybvC9cWSHhyBiG31yA7Ql
         jgs/SOef8prEB3aNxqz0EAeoCYEV+589KtCGOKDqh1k0SfoIfEEMHuAVkzoB/Y0FhN1S
         7fakLYSIiT5M+qFe0X5qcl3dIRrmvy19LuulYEH2PwBGlTBjXCcrlZtgoGab0+xsXRKk
         85pp31M2zhBoLUsKPCY6unqMnSTt88mo5lB7zmo+UIEMuxoMeRI9YazINYAOJtlGXkZU
         hvsg==
X-Gm-Message-State: AOJu0YxPbdZevP03xxgzJUUjiBra4e5DjIrWOAdolVoky9YrVcSdIbZ2
        Ljh7T7vKI4FYQV14bSWVP5TxMCkbs/8AUGBs
X-Google-Smtp-Source: AGHT+IE3vlkDF4fIufp9m/nj7AiWytdfnQwhV+zyU/89AVG8IFJdzCPkPyGCN0ywrPgPCo7uBGiS8z9+kD3XQiDH
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:212:b0:d89:b072:d06f with SMTP
 id j18-20020a056902021200b00d89b072d06fmr265146ybs.7.1696908080471; Mon, 09
 Oct 2023 20:21:20 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:21:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010032117.1577496-1-yosryahmed@google.com>
Subject: [PATCH v2 0/5] mm: memcg: subtree stats flushing and thresholds
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to address shortages in today's approach for memcg
stats flushing, namely occasionally stale or expensive stat reads. The
series does so by changing the threshold that we use to decide whether
to trigger a flush to be per memcg instead of global (patch 3), and then
changing flushing to be per memcg (i.e. subtree flushes) instead of
global (patch 5).

Patch 3 & 5 are the core of the series, and they include more details
and testing results. The rest are either cleanups or prep work.

This series replaces the "memcg: more sophisticated stats flushing"
series [1], which also replaces another series, in a long list of
attempts to improve memcg stats flushing. It is not a new version of
the same patchset as it is a completely different approach. This is
based on collected feedback from discussions on lkml in all previous
attempts. Hopefully, this is the final attempt.

[1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/

v1 -> v2:
- Fixed compilation error reported by the kernel robot in patch 4, also
  added a missing rcu_read_unlock().
- More testing results in the commit message of patch 3.

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 include/linux/memcontrol.h |   8 +-
 mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |  42 ++++--
 4 files changed, 185 insertions(+), 136 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog

