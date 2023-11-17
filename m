Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCEB7EF943
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbjKQVLU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 16:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQVLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:11:18 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A95B6;
        Fri, 17 Nov 2023 13:11:14 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6c4884521f6so2296089b3a.0;
        Fri, 17 Nov 2023 13:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255474; x=1700860274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjUoFQmdVqozJfSUnsX9imt403boBh1aBRoDnrn1A2M=;
        b=w+grTICixzvvCRUcDf7zYxXRAV+XtHer0D8/FDoSaRqNL8WRekwE+qe6anBbhwbPC5
         7GnFmopL2XAJwJpcYxgoZIrSgg95YAzSpqAJYqoKMDWm0HmdOBuEjDf2xs7i3sPN4j/y
         hxDlM6Z041dfmUToLp8ZXLsOJ0p1XDT18VETdzozWSM/Tp42FXhJ4xENcmd6mtk3H8XJ
         McPINezB4e3pSRuKFq3rUtDwlZyG4CpGR7RV2cCbxS6XEI/B7o+78pgqcMqOomuvGtx+
         2fUMLDWf8D6Bj7Cho1wNPTjifQzChHWPmvV6VDTzdLI8v23PMktkuSty2I/wB366DG8h
         pDKA==
X-Gm-Message-State: AOJu0YyFPZY0Sg4o+tmtmCdNOMUHzoSigwI95ItPn3OIU0vOT1UOsOH5
        biegzdQvgRdmZrAL/mpMZRH2q/uw85THUiZcc0Y=
X-Google-Smtp-Source: AGHT+IF3XVtiOmkgk1Kge+dgUxNLC/3cYBOxTHLuT5ZoJ7saow0OJ/a9aSGpJCTbf8o9jp7YnYcAZZLBVs2kK5IO2I8=
X-Received: by 2002:a05:6a20:5485:b0:187:2521:4581 with SMTP id
 i5-20020a056a20548500b0018725214581mr370551pzk.60.1700255473768; Fri, 17 Nov
 2023 13:11:13 -0800 (PST)
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com> <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com> <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
 <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com>
In-Reply-To: <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 17 Nov 2023 13:11:02 -0800
Message-ID: <CAM9d7cg-tudzG4iPMHs5L-zYMe-WhyzZXN9eOtkoapS1n7t8AA@mail.gmail.com>
Subject: Re: Re: [Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To:     David Wang <00107082@163.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 8:09 PM David Wang <00107082@163.com> wrote:
>
>
> At 2023-11-16 00:26:06, "Namhyung Kim" <namhyung@kernel.org> wrote:
> >On Wed, Nov 15, 2023 at 8:12 AM David Wang <00107082@163.com> wrote:
> >>
> >>
> >> 在 2023-11-15 23:48:33，"Namhyung Kim" <namhyung@kernel.org> 写道：
> >> >On Wed, Nov 15, 2023 at 3:00 AM David Wang <00107082@163.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >> At 2023-11-15 18:32:41, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >> >> >
> >> >> >Namhyung, could you please take a look, you know how to operate this
> >> >> >cgroup stuff.
> >> >> >
> >> >>
> >> >> More information,  I run the profiling with 8cpu machine on a SSD with ext4 filesystem :
> >> >>
> >> >> # mkdir /sys/fs/cgroup/mytest
> >> >> # echo $$ > /sys/fs/cgroup/mytest/cgroup.procs
> >> >> ## Start profiling targeting cgroup /sys/fs/cgroup/mytest   on another terminal
> >> >> # fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randrw  --runtime=600 --numjobs=4 --time_based=1
> >> >>
> >> >> I got a feeling that f06cc667f7990 would decrease total samples by 10%~20% when profiling IO benchmark within cgroup.
>
>
> >
> >Then what is your profiling tool?  Where did you see
> >the 10%~20% drop in samples?
> >
>
> I wrote a simple/raw tool just for profiling callchains, which use perf_event_open with following attr:
>     attr.type = PERF_TYPE_SOFTWARE;
>      attr.config = PERF_COUNT_SW_CPU_CLOCK;
>      attr.sample_freq = 777; // adjust it
>      attr.freq = 1;
>      attr.wakeup_events = 16;
>      attr.sample_type = PERF_SAMPLE_TID|PERF_SAMPLE_CALLCHAIN;
>      attr.sample_max_stack = 32;
>
> The source code could be found here: https://github.com/zq-david-wang/linux-tools/tree/main/perf/profiler
> >>
> >> I am not experienced with the perf-tool at all,   too complicated a tool for me.... But I think I can try it.
> >
> >I feel sorry about that.  In most cases, just `perf record -a` and
> >then `perf report` would work well. :)
> >
> Thanks for the information,  I use following command to profile with perf:
> `./perf record -a -e cpu-clock -G mytest`
> I have run several round of test, and before each test, the system was rebooted, and perf output is
>
> On 6.7.0-rc1:
> $ sudo ./perf record -a -e cpu-clock -G mytest
>   ^C[ perf record: Woken up 527 times to write data ]
>   [ perf record: Captured and wrote 132.648 MB perf.data (2478745 samples) ]
>  ---reboot
>   $ sudo ./perf record -a -e cpu-clock -G mytest
>   ^C[ perf record: Woken up 473 times to write data ]
>   [ perf record: Captured and wrote 119.205 MB perf.data (2226994 samples) ]
>
>
> On 6.7.0-rc1 with f06cc667f79909e9175460b167c277b7c64d3df0 reverted
>
> $ sudo ./perf record -a -e cpu-clock -G mytest
>   ^C[ perf record: Woken up 567 times to write data ]
>   [ perf record: Captured and wrote 142.771 MB perf.data (2668224 samples) ]
>   ---reboot
>   $ sudo ./perf record -a -e cpu-clock -G mytest
>   ^C[ perf record: Woken up 557 times to write data ]
>   [ perf record: Captured and wrote 140.604 MB perf.data (2627167 samples) ]
>
>
> I also run with `-F 777`, which is some random number I used in my tool,   (just to compare with my tool )
>
> On 6.7.0-rc1
> $ sudo ./perf record -a -e cpu-clock -F 777 -G mytest
> ^C[ perf record: Woken up 93 times to write data ]
> [ perf record: Captured and wrote 24.575 MB perf.data (455222 samples) ] ( My tool have only ~359K samples, not stable)
>
>
> On 6.7.0-rc1 with f06cc667f79909e9175460b167c277b7c64d3df0 reverted
> $ sudo ./perf record -a -e cpu-clock -F 777 -G mytest
> ^C[ perf record: Woken up 98 times to write data ]
> [ perf record: Captured and wrote 25.703 MB perf.data (476390 samples) ]  (My tool have about ~446K, stable)
>
>
> From the data I collected, I think two problem could be observed for f06cc667f79909e9175460b167c277b7c64d3df0
> 1. sample missing.
> 2. sample unstable, total sample count drift a lot between tests.

Hmm.. so the fio process was running in the background during
the profiling, right?  But I'm not sure how you measured the same
amount of time.  Probably you need to run this (for 10 seconds):

  sudo perf record -a -G mytest -- sleep 10

And I guess you don't run the perf command in the target cgroup
which is good.

And is there any chance if it's improved because of the change?
Are the numbers in 6.7 better or worse?

Thanks,
Namhyung
