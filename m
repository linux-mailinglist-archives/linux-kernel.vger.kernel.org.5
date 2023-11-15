Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC67EC791
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjKOPpz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:45:54 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E4109;
        Wed, 15 Nov 2023 07:45:51 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1cc2575dfc7so52419265ad.1;
        Wed, 15 Nov 2023 07:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063150; x=1700667950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9if1LcIDYWn+6yGIa/i9Vugk0aDMVHzwYt5FrtAY5k4=;
        b=sK8CrnbF3IlmeFi3rFMe4c2oYKhJ5yZMPdKJHM5AM+q54JUi0X/97KzQ+v+SmEULzc
         BUAk4pemlY5Nr2COMjKcrudUV34Pw0pU08oGCnlamSSs0PQfQZQKAvrcxrMR3Ia8W35y
         9VAb+loG8Q6m9V6JzsEQuzV7ZOx5OZ+roEwxk0q5EzUPW6xxTXI/HoLvTgM7sMxdCwQQ
         ffDNPP71HvH/u1BvtnPP2e6WqCVmKsOMFQO+YYtj8/haStrjdJbprXadvVhOExkm+ecU
         mrsKqejn7aoFKceFLSMxsNpMi7YpMr9AKuaMYGZOymYCYYGZ/HB7ugT4KWoSS+TwcXcr
         pmFA==
X-Gm-Message-State: AOJu0YwUikkT4vjGv8rNPVFkN7cl2xnW2WRI1kdr7gHFo0byNK9uMUmD
        ay3CDcpAPW7pevlq5l21/tsSj2br1c+HiExUAwE=
X-Google-Smtp-Source: AGHT+IESrXrYtxRB8Hkt4MBw298ZSwydw9e5ZcE/zgEsSqJtNs2N2AmP5wZ/3nuyaQc50FR18mczkpYP9JPWtX+er1E=
X-Received: by 2002:a17:90b:4f45:b0:280:2935:af23 with SMTP id
 pj5-20020a17090b4f4500b002802935af23mr11945134pjb.5.1700063150440; Wed, 15
 Nov 2023 07:45:50 -0800 (PST)
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231115103241.GD3818@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Nov 2023 07:45:38 -0800
Message-ID: <CAM9d7cjY_NzPZKtQbSUzhLwrH+zAPB701PAiCHSmnvjcHnhLTQ@mail.gmail.com>
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Wang <00107082@163.com>, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 15, 2023 at 2:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Namhyung, could you please take a look, you know how to operate this
> cgroup stuff.

Sure.

>
> On Tue, Nov 14, 2023 at 11:20:32PM +0800, David Wang wrote:
> >
> >
> > At 2023-11-14 12:31:12, "David Wang" <00107082@163.com> wrote:
> > >Hi,
> > >
> > >I was making kernel profiling to identify kernel changes between revisions under the load of fio benchmark,
> >
> > >But I did not notice a significant change in the overhead of perf tracing based on the fio report,
> > >that is why I am not sure whether this is a regression or an improvement....
> > >Just report the change.

Do you mean f06cc667f79 ("perf: Optimize perf_cgroup_switch")?
Did you have cgroup events when you ran the benchmark?
Otherwise it should not make any differences.

> > >
> >
> > I run the same test on another disk which is almost idle all the time, and still, significant perf sample stats changes detected:
> >
> > 6.7.0-rc1
> >
> > aio_write(49.340% 131501/266521)
> >     ext4_file_write_iter(94.567% 124356/131501)
> >         iomap_dio_rw(78.494% 97612/124356)
> >             __iomap_dio_rw(99.550% 97173/97612)
> >                 iomap_dio_bio_iter(47.773% 46422/97173)   <<----
> >                 blk_finish_plug(29.931% 29085/97173)      <<----
> >                 iomap_iter(14.082% 13684/97173)
> >                 kmalloc_trace(1.814% 1763/97173)
> >                 kiocb_invalidate_pages(0.631% 613/97173)
> >                 invalidate_inode_pages2_range(0.448% 435/97173)
> >                 srso_return_thunk(0.320% 311/97173)
> >                 blk_start_plug(0.167% 162/97173)
> >
> >
> > 6.7.0-rc1 with f06cc667f79 reverted
> >
> > aio_write(49.071% 155873/317649)
> >     ext4_file_write_iter(95.211% 148409/155873)
> >         iomap_dio_rw(81.816% 121422/148409)
> >             __iomap_dio_rw(99.684% 121038/121422)
> >                 iomap_dio_bio_iter(40.280% 48754/121038)   <<---
> >                 blk_finish_plug(36.760% 44494/121038)      <<---
> >                 iomap_iter(14.657% 17740/121038)
> >                 kmalloc_trace(1.775% 2149/121038)
> >                 kiocb_invalidate_pages(0.599% 725/121038)
> >                 invalidate_inode_pages2_range(0.330% 399/121038)
> >                 srso_return_thunk(0.263% 318/121038)
> >                 blk_start_plug(0.169% 204/121038)

I cannot say whether it's good or not just by looking
at these numbers.  Maybe fs/block folks know..

> >
> >
> > I remove the 4 occurrences for checking nr_cgroups:
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 683dc086ef10..7583418e94d9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -690,8 +690,8 @@ static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
> >         struct perf_event_pmu_context *pmu_ctx;
> >
> >         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > -               if (cgroup && !pmu_ctx->nr_cgroups)
> > -                       continue;
> > +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> > +       //              continue;
> >                 perf_pmu_disable(pmu_ctx->pmu);
> >         }
> >  }
> > @@ -701,8 +701,8 @@ static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
> >         struct perf_event_pmu_context *pmu_ctx;
> >
> >         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > -               if (cgroup && !pmu_ctx->nr_cgroups)
> > -                       continue;
> > +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> > +       //              continue;
> >                 perf_pmu_enable(pmu_ctx->pmu);
> >         }
> >  }
> > @@ -3307,8 +3307,8 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
> >         is_active ^= ctx->is_active; /* changed bits */
> >
> >         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > -               if (cgroup && !pmu_ctx->nr_cgroups)
> > -                       continue;
> > +       //      if (cgroup && !pmu_ctx->nr_cgroups)
> > +       //              continue;
> >                 __pmu_ctx_sched_out(pmu_ctx, is_active);
> >         }
> >  }
> >
> >
> >  The resulting profiling stats is similar to reverting f06cc667f79.

Yeah, that's because you effectively reverted the change. :)

> > I think there are some cases where pmu_ctx->nr_cgroups is zero but there is still cgroup event within, and some samples are missed, causing the stats changes, just a guess.

I don't know what makes you think so.  Do you see
differences in the perf output?  Any cgroup events having
smaller number of samples or counts?

Or was the fio benchmark degraded seriously?

Thanks,
Namhyung
