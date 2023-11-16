Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6F7ED94D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjKPCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjKPCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4929319F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c43613892bso4889347b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700101454; x=1700706254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1AWHqkKP0z0LkMVHCfdRkRpGsaiflFrHJR7zY+cIaQ=;
        b=NAMSS6M+YaV7PuOlsiniFoMiTtYl4MAKGHLyTf1nTsz24clT49jRgLsjYpM6rV4sq4
         VnJgwYVrfIlMnPeUgcm530aatKU8MFs3Da739LZQEUe4bwZJPSSBGuY+bppkTmZrC9ds
         jDiAEd99Q3Z6PqE9yDJxr5SxfFk8NmNlVa9njUevFtRXnfR4mJfXVisyLiHxV84/ooNG
         FUZewXZ4PpY2JjgKhwujGfctfZNHFiLOCGmAwBz73ajVGE2V/ijuak6TXNLXvBdgM2U3
         47h1x5cUIzxE9JxSaz90F3lzHFDJNPiNhAitfPYcDUTlm+vxZxUf3iSANwSSiJhtl8h1
         SakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101454; x=1700706254;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1AWHqkKP0z0LkMVHCfdRkRpGsaiflFrHJR7zY+cIaQ=;
        b=q0dmfXMKtXa3gktXFT3Y39ojSvhY4oSuy/bQFU1YDbYtsfuqB9EQLjUbbSTy1RzfdI
         qCMUmbtJ+n35wqpdM57t+BFOItX5oKltCBI0aFVkDsAIL/3aW9cmNs0KMclBN5rtlBQ2
         mrZfxuHUmCPEjmV26laM1ZKo1eF9qt7rMTuP55vyDBw2NIPuD3XwQHT0xyY56Ow6B6rB
         qE6wI9fvqGVdYhTGRaT98xuoMsHVhbVy+YgPkBXaPF/C9bQ1dOx8FzZrWdLCKJhJvEPo
         cS5QUoQh43woThSiH5cgfXxhHqmU3P3/yshczd4yc1C8ZfAd3piOtSB2vjCSTZHevdoV
         Bypg==
X-Gm-Message-State: AOJu0Yzd37Knr3vUAmmWPTOgoJcHh+pwXIydV5GBSG8EFBpLJ0s0oV8t
        erY60R2SYDJW8XUd7HLNHXlcnas8TKYf80A8
X-Google-Smtp-Source: AGHT+IFcBS884mdgTaLDdRw+tqVenUibb2jpM4m0sdAM+Xjm5sQJMErfWYKcGClz5dYEj+8EimzXW6AsKlzA6lNX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:428c:0:b0:daf:34be:1e83 with SMTP
 id p134-20020a25428c000000b00daf34be1e83mr354171yba.2.1700101454395; Wed, 15
 Nov 2023 18:24:14 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:24:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116022411.2250072-1-yosryahmed@google.com>
Subject: [PATCH v3 0/5] mm: memcg: subtree stats flushing and thresholds
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
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

There was a reported regression in v2 [2] for will-it-scale::fallocate
benchmark. I believe this regression should not affect production
workloads. This specific benchmark is allocating and freeing memory
(using fallocate/ftruncate) at a rate that is much faster to make actual
use of the memory. Testing this series on 100+ machines running
production workloads did not show any practical regressions in page
fault latency or allocation latency, but it showed great improvements in
stats read time. I do not have numbers about the exact improvements for
this series, but combined with another optimization for cgroup v1 [3] we
see 5-10x improvements. A significant chunk of that is coming from the
cgroup v1 optimization, but this series also made an improvement as
reported by Domenico [4].

[1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/
[2]https://lore.kernel.org/lkml/202310202303.c68e7639-oliver.sang@intel.com/
[3]https://lore.kernel.org/lkml/20230803185046.1385770-1-yosryahmed@google.com/
[4]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL7nK77e2A@mail.gmail.com/

v2 -> v3:
- Rebased on top of v6.7-rc1.
- Updated commit messages based on discussions in previous versions.
- Reset percpu stats_updates in mem_cgroup_css_rstat_flush().
- Added a mem_cgroup_disabled() check to mem_cgroup_flush_stats().

v2: https://lore.kernel.org/lkml/20231010032117.1577496-1-yosryahmed@google.com/

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 include/linux/memcontrol.h |   8 +-
 mm/memcontrol.c            | 272 +++++++++++++++++++++----------------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |  42 ++++--
 4 files changed, 188 insertions(+), 136 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

