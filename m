Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D47BF167
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441971AbjJJDZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441902AbjJJDZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:25:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A8BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:25:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so65027641fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908331; x=1697513131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/75P8pc2DkgM2SQ5ORt4v9hM0okDctjs9IwPZwy6BY=;
        b=D8cFF0oesck5HHARRuBKnmhvHatGRECZVPrVD2spw9S8VkV3v3Eg/KipKR6N1VCmeo
         AkVPli7HvKpfBDdpfQgQHQ26kVVDnaK5nFDK7HCiEV4XE/IJj8TVaBLjShi7t2KxPFMK
         c9N4/UG57vLTWtrx8XaS/tTRFZoMFvUR09vPgrby7QV4O0uQGvUeEjpgOxHKJqjj32Lc
         6FgU81XFnUCOC5+LEAhx9BfgRkxu/ms6+LGmRfkA82ztrCROq4+H3aTxGYyzqijUzcWq
         DOboWknMGTVVxtw1Hz+GwEATXH2Mks05KI1cNOx5sorjlTBzfHioaACjSWDsrR7WAiUm
         vU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908331; x=1697513131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/75P8pc2DkgM2SQ5ORt4v9hM0okDctjs9IwPZwy6BY=;
        b=C4npOzaB+BoHbhjQOHRIEwQacecfc+PquR0xVC0+EQcsglYqwtCL/DjxMn+atif7xf
         FPcm6VqfZ36EFwOGOpfc7UcbzrMPQMkO1KFuqE9cL3gWYyCxfYN2sDXPpuSqjRIz5WW4
         U9a0loemZf77MPDpZdzSUe3DftwR6SakdcJGu5coMogjMwZnvVEG9gJ04vQ8H0XHzzG1
         7gFKDse42dEU13ZnAeyHvN8MMsIRFcsKCb8gRFyulOfENNIovd7xqJH4/THPfWz1QAJA
         DTOJVupcAAmeJHm2FcqypLZkFGSR/oI9benLaWAdhjPZqHlIqXlV+gPvOKgpVRZ8EkQ8
         A2Pw==
X-Gm-Message-State: AOJu0YxSwASjObm7OSlgyDBFB+Iwt5+aWGdJT0TTXol6fqeTG/yjtwK2
        YmtZFO7+sj2QQOV/tVSYIpC7ZYs49/qLG+sKGXBG0A==
X-Google-Smtp-Source: AGHT+IERt5tn63v96L18Ppe4WorT1kfFDN14wkKW/mg2O9+KyTaUBAxXwjrSFNxm6drWsnUM6be7sLSf1LRDS2f/JLg=
X-Received: by 2002:a2e:a212:0:b0:2c2:9810:3677 with SMTP id
 h18-20020a2ea212000000b002c298103677mr14419687ljm.6.1696908330676; Mon, 09
 Oct 2023 20:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com> <20231010032117.1577496-4-yosryahmed@google.com>
In-Reply-To: <20231010032117.1577496-4-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 9 Oct 2023 20:24:51 -0700
Message-ID: <CAJD7tkZv+R=jVji0oSMNtO0VhzgONiHvRPFumRZVwd4gs3BVHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 8:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
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
> ran in a cgroup that is 4 levels deep (/sys/fs/cgroup/a/b/c/d), which is
> deeper than a usual setup:
>
> (a) neper [1] with 1000 flows and 100 threads (single machine). The
> values in the table are the average of server and client throughputs in
> mbps after 30 iterations, each running for 30s:
>
>                                 tcp_rr          tcp_stream
> Base                            9504218.56      357366.84
> Patched                         9656205.68      356978.39
> Delta                           +1.6%           -0.1%
> Standard Deviation              0.95%           1.03%
>
> An increase in the performance of tcp_rr doesn't really make sense, but
> it's probably in the noise. The same tests were ran with 1 flow and 1
> thread but the throughput was too noisy to make any conclusions (the
> averages did not show regressions nonetheless).
>
> Looking at perf for one iteration of the above test, __mod_memcg_state()
> (which is where memcg_rstat_updated() is called) does not show up at all
> without this patch, but it shows up with this patch as 1.06% for tcp_rr
> and 0.36% for tcp_stream.
>
> (b) "stress-ng --vm 0 -t 1m --times --perf". I don't understand
> stress-ng very well, so I am not sure that's the best way to test this,
> but it spawns 384 workers and spits a lot of metrics which looks nice :)
> I picked a few ones that seem to be relevant to the stats update path. I
> also included cache misses as this patch introduce more atomics that may
> bounce between cpu caches:
>
> Metric                  Base            Patched         Delta
> Cache Misses            3.394 B/sec     3.433 B/sec     +1.14%
> Cache L1D Read          0.148 T/sec     0.154 T/sec     +4.05%
> Cache L1D Read Miss     20.430 B/sec    21.820 B/sec    +6.8%
> Page Faults Total       4.304 M/sec     4.535 M/sec     +5.4%
> Page Faults Minor       4.304 M/sec     4.535 M/sec     +5.4%
> Page Faults Major       18.794 /sec     0.000 /sec
> Kmalloc                 0.153 M/sec     0.152 M/sec     -0.65%
> Kfree                   0.152 M/sec     0.153 M/sec     +0.65%
> MM Page Alloc           4.640 M/sec     4.898 M/sec     +5.56%
> MM Page Free            4.639 M/sec     4.897 M/sec     +5.56%
> Lock Contention Begin   0.362 M/sec     0.479 M/sec     +32.32%
> Lock Contention End     0.362 M/sec     0.479 M/sec     +32.32%
> page-cache add          238.057 /sec    0.000 /sec
> page-cache del          6.265 /sec      6.267 /sec      -0.03%
>
> This is only using a single run in each case. I am not sure what to
> make out of most of these numbers, but they mostly seem in the noise
> (some better, some worse). The lock contention numbers are interesting.
> I am not sure if higher is better or worse here. No new locks or lock
> sections are introduced by this patch either way.
>
> Looking at perf, __mod_memcg_state() shows up as 0.00% with and without
> this patch. This is suspicious, but I verified while stress-ng is
> running that all the threads are in the right cgroup.
>
> (3) will-it-scale page_fault tests. These tests (specifically
> per_process_ops in page_fault3 test) detected a 25.9% regression before
> for a change in the stats update path [2]. These are the
> numbers from 30 runs (+ is good):
>
>              LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
> ------------------------------+-------------+-------------+-------------
>   page_fault1_per_process_ops |             |             |            |
>   (A) base                    | 265207.738  | 262941.000  | 12112.379  |
>   (B) patched                 | 249249.191  | 248781.000  | 8767.457   |
>                               | -6.02%      | -5.39%      |            |
>   page_fault1_per_thread_ops  |             |             |            |
>   (A) base                    | 241618.484  | 240209.000  | 10162.207  |
>   (B) patched                 | 229820.671  | 229108.000  | 7506.582   |
>                               | -4.88%      | -4.62%      |            |
>   page_fault1_scalability     |             |             |
>   (A) base                    | 0.03545     | 0.035705    | 0.0015837  |
>   (B) patched                 | 0.029952    | 0.029957    | 0.0013551  |
>                               | -9.29%      | -9.35%      |            |
>   page_fault2_per_process_ops |             |             |
>   (A) base                    | 203916.148  | 203496.000  | 2908.331   |
>   (B) patched                 | 186975.419  | 187023.000  | 1991.100   |
>                               | -6.85%      | -6.90%      |            |
>   page_fault2_per_thread_ops  |             |             |
>   (A) base                    | 170604.972  | 170532.000  | 1624.834   |
>   (B) patched                 | 163100.260  | 163263.000  | 1517.967   |
>                               | -4.40%      | -4.26%      |            |
>   page_fault2_scalability     |             |             |
>   (A) base                    | 0.054603    | 0.054693    | 0.00080196 |
>   (B) patched                 | 0.044882    | 0.044957    | 0.0011766  |
>                               | -0.05%      | +0.33%      |            |
>   page_fault3_per_process_ops |             |             |
>   (A) base                    | 1299821.099 | 1297918.000 | 9882.872   |
>   (B) patched                 | 1248700.839 | 1247168.000 | 8454.891   |
>                               | -3.93%      | -3.91%      |            |
>   page_fault3_per_thread_ops  |             |             |
>   (A) base                    | 387216.963  | 387115.000  | 1605.760   |
>   (B) patched                 | 368538.213  | 368826.000  | 1852.594   |
>                               | -4.82%      | -4.72%      |            |
>   page_fault3_scalability     |             |             |
>   (A) base                    | 0.59909     | 0.59367     | 0.01256    |
>   (B) patched                 | 0.59995     | 0.59769     | 0.010088   |
>                               | +0.14%      | +0.68%      |            |
>
> There is some microbenchmarks regressions (and some minute improvements),
> but nothing outside the normal variance of this benchmark between kernel
> versions. The fix for [2]  assumes that 3% is noise -- and there were no
> further practical complaints), so hopefully this means that such variatio=
ns
> in these microbenchmarks do not reflect on practical workloads.
>
> [1]https://github.com/google/neper
> [2]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Johannes, as I mentioned in a reply to v1, I think this might be what
you suggested in our previous discussion [1], but I am not sure this
is what you meant for the update path, so I did not add a
Suggested-by.

Please let me know if this is what you meant and I can amend the tag as suc=
h.

[1]https://lore.kernel.org/lkml/20230913153758.GB45543@cmpxchg.org/
