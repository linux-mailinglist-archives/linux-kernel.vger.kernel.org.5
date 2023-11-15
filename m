Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DE7EC0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjKOKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:33:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC309C2;
        Wed, 15 Nov 2023 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5/7hYLkKX+xRe8zJRyWd90wUQhzXQSC1j7GWHHVSPoU=; b=t613yKGSRaaY7M1igJC8Equf0P
        Y4yK8uiFLlw81Qa4yuqSLGZB5Iit4Z6yniXRmxGJTnTmb3BMoJtbPL2pz1XbZ0qLeXdMvU9rpknUt
        GtbwmPHW2o7Litv1kKS60TNfLSb/pyaxtq2rBdSZgu6lVNx3cYi6MwkZAMdoFf9Mb1JxciIlOetzW
        iKEGKkXIiCIZrWvUzFbgcB7GEZn9yv8oX47SG2nnlaxyRMnnOgzN/QtsZue5vwzwcR80mJH4l+Dgs
        X1BYa2Dp/uQ1uJ6KYzOQsoPBuOx+FUhLImrRoBI5uLaSb3j66ebRqdNgLHZkJhE4TW/b4GTah5NW5
        4PSl16Uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3DCL-00DeYW-TP; Wed, 15 Nov 2023 10:32:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91909300427; Wed, 15 Nov 2023 11:32:41 +0100 (CET)
Date:   Wed, 15 Nov 2023 11:32:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Wang <00107082@163.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
Message-ID: <20231115103241.GD3818@noisy.programming.kicks-ass.net>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Namhyung, could you please take a look, you know how to operate this
cgroup stuff.

On Tue, Nov 14, 2023 at 11:20:32PM +0800, David Wang wrote:
> 
> 
> At 2023-11-14 12:31:12, "David Wang" <00107082@163.com> wrote:
> >Hi,
> >
> >I was making kernel profiling to identify kernel changes between revisions under the load of fio benchmark, 
> 
> >But I did not notice a significant change in the overhead of perf tracing based on the fio report, 
> >that is why I am not sure whether this is a regression or an improvement....
> >Just report the change.
> >
> 
> I run the same test on another disk which is almost idle all the time, and still, significant perf sample stats changes detected:
> 
> 6.7.0-rc1
> 
> aio_write(49.340% 131501/266521)
>     ext4_file_write_iter(94.567% 124356/131501)
>         iomap_dio_rw(78.494% 97612/124356)
>             __iomap_dio_rw(99.550% 97173/97612)
>                 iomap_dio_bio_iter(47.773% 46422/97173)   <<----
>                 blk_finish_plug(29.931% 29085/97173)      <<----
>                 iomap_iter(14.082% 13684/97173)
>                 kmalloc_trace(1.814% 1763/97173)
>                 kiocb_invalidate_pages(0.631% 613/97173)
>                 invalidate_inode_pages2_range(0.448% 435/97173)
>                 srso_return_thunk(0.320% 311/97173)
>                 blk_start_plug(0.167% 162/97173)
> 
> 
> 6.7.0-rc1 with f06cc667f79 reverted
> 
> aio_write(49.071% 155873/317649)
>     ext4_file_write_iter(95.211% 148409/155873)
>         iomap_dio_rw(81.816% 121422/148409)
>             __iomap_dio_rw(99.684% 121038/121422)
>                 iomap_dio_bio_iter(40.280% 48754/121038)   <<---
>                 blk_finish_plug(36.760% 44494/121038)      <<---
>                 iomap_iter(14.657% 17740/121038)
>                 kmalloc_trace(1.775% 2149/121038)
>                 kiocb_invalidate_pages(0.599% 725/121038)
>                 invalidate_inode_pages2_range(0.330% 399/121038)
>                 srso_return_thunk(0.263% 318/121038)
>                 blk_start_plug(0.169% 204/121038)
> 
> 
> I remove the 4 occurrences for checking nr_cgroups:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 683dc086ef10..7583418e94d9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -690,8 +690,8 @@ static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
>         struct perf_event_pmu_context *pmu_ctx;
>  
>         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> +       //              continue;
>                 perf_pmu_disable(pmu_ctx->pmu);
>         }
>  }
> @@ -701,8 +701,8 @@ static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
>         struct perf_event_pmu_context *pmu_ctx;
>  
>         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> +       //              continue;
>                 perf_pmu_enable(pmu_ctx->pmu);
>         }
>  }
> @@ -3307,8 +3307,8 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
>         is_active ^= ctx->is_active; /* changed bits */
>  
>         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> +       //              continue;
>                 __pmu_ctx_sched_out(pmu_ctx, is_active);
>         }
>  }
> 
> 
>  The resulting profiling stats is similar to reverting f06cc667f79.
> I think there are some cases where pmu_ctx->nr_cgroups is zero but there is still cgroup event within, and some samples are missed, causing the stats changes, just a guess.
> 
> 
> David Wang
> 
