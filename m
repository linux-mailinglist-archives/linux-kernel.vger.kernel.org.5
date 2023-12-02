Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D22801B2E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 08:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjLBHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 02:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 02:48:47 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453CE116
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 23:48:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c5dd157f5cso1047606a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701503332; x=1702108132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cvKzBKJavSflUIGtTrRq6X4172jeqPmi1cK5nCNC7Y=;
        b=lGhXVd5+RahfUqzurtlTdrVFm5U3IByq92y6SIjGEd1lZxPBIA0tcEAUSkESnXfxnI
         +C19ltlTdNoJCH7svAtp2/TdRVVB1b8KzLCGWr6b7s44p+a5s9cIhLL6uI+H9H8n65fq
         H77ZU5dD7kdkouAPIuFLAPoXGo30K9E6dRrXJ8gduvpRf4J6yOOaVdzVmccylX2yVl6R
         Qm9L8M/ds5NmI+TJBS5/2k9yfg8Rk0eF3dfN2SMXnzzWVIXmXRtXYz8mjm7+vWpe5JyJ
         Dl/6Ynj2NfI04T369q/FpRx3eTqNFAfJL8NZW9CPtKdzSB8fRm1LG7BVqXmTuuLZoIB4
         993g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701503332; x=1702108132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cvKzBKJavSflUIGtTrRq6X4172jeqPmi1cK5nCNC7Y=;
        b=mi9JDcNGiLHeQDZvXB/8wSP792H36Z+pWjl3JOwbo45n1ilFc2H7hQDfbr7ZxVs8Cw
         tIPmhAbnlfHpJArl7wCCtU/KlZ7DR2NvVXX3dIBoKGhYItEcTWT9IM/iaH1U6rOaVzwQ
         QpUy+OrM0jh4mpV7rZ/KnmRyockvjqydDugwABEuBfrmBN16gnJGmSZsCyusxqQj/9vQ
         U/m/CGn5zjRdhscNRn/l72t0ge7EN6mDkssAy8EkmbE49CK6+wL7EJfPGj1aBDglJ6IT
         sJkBPFsWFpSMMc07l1xDKGHDjVCciJ2IOO6N8xwrt8QscO0Qni18O0xauhWuVsFiwe3/
         TvHw==
X-Gm-Message-State: AOJu0YwRI72CwZG1qzAyfaDXM7uUT0KQohjTEsTTI0wilIKPTAq/QiZU
        JAcOkWCbLvJxLHMSd9/Y+HyPmZzRTHH11A==
X-Google-Smtp-Source: AGHT+IG1Jy6ieBWta9B6ASl+QwRtTxB5bmORWCEanuGe38otdWoA6VC0CHHpj+C//1Xxl1xNHpZWcl9Tip2YiA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:a18:0:b0:5c2:2b59:5e6c with SMTP id
 24-20020a630a18000000b005c22b595e6cmr4154075pgk.1.1701503332400; Fri, 01 Dec
 2023 23:48:52 -0800 (PST)
Date:   Sat, 2 Dec 2023 07:48:50 +0000
In-Reply-To: <20231129032154.3710765-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-4-yosryahmed@google.com>
Message-ID: <20231202074850.aisqdvyc5u2kth6r@google.com>
Subject: Re: [mm-unstable v4 3/5] mm: memcg: make stats flushing threshold per-memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:21:51AM +0000, Yosry Ahmed wrote:
> A global counter for the magnitude of memcg stats update is maintained
> on the memcg side to avoid invoking rstat flushes when the pending
> updates are not significant. This avoids unnecessary flushes, which are
> not very cheap even if there isn't a lot of stats to flush. It also
> avoids unnecessary lock contention on the underlying global rstat lock.
> 
> Make this threshold per-memcg. The scheme is followed where percpu (now
> also per-memcg) counters are incremented in the update path, and only
> propagated to per-memcg atomics when they exceed a certain threshold.
> 
> This provides two benefits:
> (a) On large machines with a lot of memcgs, the global threshold can be
> reached relatively fast, so guarding the underlying lock becomes less
> effective. Making the threshold per-memcg avoids this.
> 
> (b) Having a global threshold makes it hard to do subtree flushes, as we
> cannot reset the global counter except for a full flush. Per-memcg
> counters removes this as a blocker from doing subtree flushes, which
> helps avoid unnecessary work when the stats of a small subtree are
> needed.
> 
> Nothing is free, of course. This comes at a cost:
> (a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
> bytes. The extra memory usage is insigificant.
> 
> (b) More work on the update side, although in the common case it will
> only be percpu counter updates. The amount of work scales with the
> number of ancestors (i.e. tree depth). This is not a new concept, adding
> a cgroup to the rstat tree involves a parent loop, so is charging.
> Testing results below show no significant regressions.
> 
> (c) The error margin in the stats for the system as a whole increases
> from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
> NR_MEMCGS. This is probably fine because we have a similar per-memcg
> error in charges coming from percpu stocks, and we have a periodic
> flusher that makes sure we always flush all the stats every 2s anyway.
> 
> This patch was tested to make sure no significant regressions are
> introduced on the update path as follows. The following benchmarks were
> ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):
> 
> (1) Running 22 instances of netperf on a 44 cpu machine with
> hyperthreading disabled. All instances are run in a level 2 cgroup, as
> well as netserver:
>   # netserver -6
>   # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> Averaging 20 runs, the numbers are as follows:
> Base: 40198.0 mbps
> Patched: 38629.7 mbps (-3.9%)
> 
> The regression is minimal, especially for 22 instances in the same
> cgroup sharing all ancestors (so updating the same atomics).
> 
> (2) will-it-scale page_fault tests. These tests (specifically
> per_process_ops in page_fault3 test) detected a 25.9% regression before
> for a change in the stats update path [1]. These are the
> numbers from 10 runs (+ is good) on a machine with 256 cpus:
> 
>              LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
> ------------------------------+-------------+-------------+-------------
>   page_fault1_per_process_ops |             |             |            |
>   (A) base                    | 270249.164  | 265437.000  | 13451.836  |
>   (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
>                               | -3.29%      | -3.66%      |            |
>   page_fault1_per_thread_ops  |             |             |            |
>   (A) base                    | 242111.345  | 239737.000  | 10026.031  |
>   (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
>                               | -2.09%      | -1.85%      |            |
>   page_fault1_scalability     |             |             |
>   (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
>   (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
>                               | -1.16%      | -1.69%      |            |
>   page_fault2_per_process_ops |             |             |
>   (A) base                    | 203561.836  | 203301.000  | 2550.764   |
>   (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
>                               | -3.13%      | -2.73%      |            |
>   page_fault2_per_thread_ops  |             |             |
>   (A) base                    | 171046.473  | 170776.000  | 1509.679   |
>   (B) patched                 | 166626.327  | 166406.000  | 768.753    |
>                               | -2.58%      | -2.56%      |            |
>   page_fault2_scalability     |             |             |
>   (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
>   (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
>                               | -1.29%      | -1.41%      |            |
>   page_fault3_per_process_ops |             |             |
>   (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
>   (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
>                               | -1.56%      | -1.86%      |            |
>   page_fault3_per_thread_ops  |             |             |
>   (A) base                    | 391234.164  | 390860.000  | 1760.720   |
>   (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
>                               | -3.58%      | -3.71%      |            |
>   page_fault3_scalability     |             |             |
>   (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
>   (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
>                               | +2.26%      | +2.45%      |            |
> 
> All regressions seem to be minimal, and within the normal variance for
> the benchmark. The fix for [1] assumes that 3% is noise -- and there
> were no further practical complaints), so hopefully this means that such
> variations in these microbenchmarks do not reflect on practical
> workloads.
> 
> (3) I also ran stress-ng in a nested cgroup and did not observe any
> obvious regressions.
> 
> [1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
