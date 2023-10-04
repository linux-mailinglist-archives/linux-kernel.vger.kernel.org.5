Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893B37B8321
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbjJDPBe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbjJDPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:01:30 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315FEBD;
        Wed,  4 Oct 2023 08:01:27 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c5bf7871dcso17836405ad.1;
        Wed, 04 Oct 2023 08:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431686; x=1697036486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHgS8JhrvcQ+1LezD403K7guVUfK79VX9K7UxVs2E2A=;
        b=nqiIcGngyYE08jFlHgpyOdP739GRtJrHCSORGtfw0dn+vGgymBJOlUog0hq4JQGMJM
         VmHpTl4qYdEs+hqTsRhq9gzgM8fKYeTckmHNM5pOCWEqdZDYVijJInSk8F/RCBqPsCJc
         rCqS39+DOEJGodg5WiNzp8iYaZv2Pq6xL7IRSIP07YJyKnn9Z6Zqc3q8ZNTHYPqZ33NR
         vlPZHtZbckqH2SuzvG3nPqTLswDdNmm5KeMBI2Hx8KH2sN2BXlpxaSAk0PZ/EdNBWfIi
         1OeLdtxq5EvAKuEf0diDAHgEB3IZmKylPrWF/MeNSKaiPlkMfQanz0HOGdUVuo99ogCj
         IBOg==
X-Gm-Message-State: AOJu0YwDoJXxaCbqYlfv9kWQPI1scpDW59uyoyAokuXuRF1hwFxhaH2b
        rfS7QfFpP+VYGjY385dpusmvIEOyk/sBavQwf6A=
X-Google-Smtp-Source: AGHT+IHOPg/z3l9dYugV87O1uS9By9EATQ1KcCm7Vp04FLZ9h0iDTnu4WokteoAffxa6KEHdT/1ASgBv0duKilrYm4g=
X-Received: by 2002:a17:90a:3183:b0:268:c5c7:f7f1 with SMTP id
 j3-20020a17090a318300b00268c5c7f7f1mr2309969pjb.29.1696431686119; Wed, 04 Oct
 2023 08:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231004040844.797044-1-namhyung@kernel.org> <ZR0TtjhGT+Em+/ti@gmail.com>
In-Reply-To: <ZR0TtjhGT+Em+/ti@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 4 Oct 2023 08:01:14 -0700
Message-ID: <CAM9d7cjvs_CYZH6rGdujSQ8d+MBa616t95dr9oAFs-Nzr_XUOQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Wed, Oct 4, 2023 at 12:26 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Namhyung Kim <namhyung@kernel.org> wrote:
>
> > AFAIK we don't have a tool to measure the context switch overhead
> > directly.  (I think I should add one to perf ftrace latency).  But I can
> > see it with a simple perf bench command like this.
> >
> >   $ perf bench sched pipe -l 100000
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 100000 pipe operations between two processes
> >
> >        Total time: 0.650 [sec]
> >
> >          6.505740 usecs/op
> >            153710 ops/sec
> >
> > It runs two tasks communicate each other using a pipe so it should
> > stress the context switch code.  This is the normal numbers on my
> > system.  But after I run these two perf stat commands in background,
> > the numbers vary a lot.
> >
> >   $ sudo perf stat -a -e cycles -G user.slice -- sleep 100000 &
> >   $ sudo perf stat -a -e uncore_imc/cas_count_read/ -- sleep 10000 &
> >
> > I will show the last two lines of perf bench sched pipe output for
> > three runs.
> >
> >         58.597060 usecs/op    # run 1
> >             17065 ops/sec
> >
> >         11.329240 usecs/op    # run 2
> >             88267 ops/sec
> >
> >         88.481920 usecs/op    # run 3
> >             11301 ops/sec
> >
> > I think the deviation comes from the fact that uncore events are managed
> > a certain number of cpus only.  If the target process runs on a cpu that
> > manages uncore pmu, it'd take longer.  Otherwise it won't affect the
> > performance much.
>
> The numbers of pipe-message context switching will vary a lot depending on
> CPU migration patterns as well.
>
> The best way to measure context-switch overhead is to pin that task
> to a single CPU with something like:
>
>    $ taskset 1 perf stat --null --repeat 10 perf bench sched pipe -l 10000 >/dev/null
>
>    Performance counter stats for 'perf bench sched pipe -l 10000' (10 runs):
>
>             0.049798 +- 0.000102 seconds time elapsed  ( +-  0.21% )
>
> as you can see the 0.21% stddev is pretty low.
>
> If we allow 2 CPUs, both runtime and stddev is much higher:
>
>    $ taskset 3 perf stat --null --repeat 10 perf bench sched pipe -l 10000 >/dev/null
>
>    Performance counter stats for 'perf bench sched pipe -l 10000' (10 runs):
>
>               1.4835 +- 0.0383 seconds time elapsed  ( +-  2.58% )

Thanks for taking your time.  I should have said I also tried this.
But the problem is that it doesn't need the pure context switch.
It needs to switch to a different cgroup to trigger the overhead.

For example, I counted the number of context switches.

  $ perf stat -e context-switches,cgroup-switches \
  > perf bench sched pipe -l 10000 > /dev/null

   Performance counter stats for 'perf bench sched pipe -l 10000':

            20,001      context-switches
            20,001      cgroup-switches

But if I use the taskset,

  $ perf stat -e context-switches,cgroup-switches \
  > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null

   Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':

            20,003      context-switches
                 2      cgroup-switches

So the regression didn't happen when I used taskset because
the two tasks run on the cpu without changing cgroups.

Maybe I can add an option to perf bench sched to place
senders and receivers in different cgroups.

Thanks,
Namhyung
