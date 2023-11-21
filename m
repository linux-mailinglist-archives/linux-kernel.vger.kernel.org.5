Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D57F3343
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjKUQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:08:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C611188;
        Tue, 21 Nov 2023 08:08:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 105321FB;
        Tue, 21 Nov 2023 08:09:40 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8BD3F6C4;
        Tue, 21 Nov 2023 08:08:52 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:08:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZVzWEYg8H3gq4WNm@FVFF77S0Q05N.cambridge.arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <CAP-5=fWeyorotfVz_y16ibakSwbNa0fapZoxSZ1nbkt1s=uGbw@mail.gmail.com>
 <ZVzTJhMsgjPw2OE4@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWb+Nbs24+XzqVp_5U+ehwiuojedHfDu8AxP3kFd7B4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWb+Nbs24+XzqVp_5U+ehwiuojedHfDu8AxP3kFd7B4KA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:03:11AM -0800, Ian Rogers wrote:
> On Tue, Nov 21, 2023 at 7:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Nov 21, 2023 at 07:41:17AM -0800, Ian Rogers wrote:
> > > Hi Marc,
> >
> > Hi Ian,
> >
> > > I'm unclear if you are running a newer perf tool on an older kernel or
> > > not. In any case I'll assume the kernel and perf tool versions match.
> > > In Linux 6.6 this patch was added to the ARM PMU:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/perf/arm_pmu.c?id=5c816728651ae425954542fed64d21d40cb75a9f
> > >
> > > My guess is that the apple_icestorm_pmu requires a similar patch.
> >
> > The apple_icestorm_pmu PMU driver uses the arm_pmu framework, so it's using
> > that code (since v6.6).
> >
> > > The perf tool is supposed to not use extended types when they aren't
> > > supported:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n532
> >
> > How does that is_event_supported() check actually work? I suspect that's giving
> > the wrong answer.
> 
> Maybe, the implementation is to check using perf_event_open:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n232
> 
> This is recycling logic from perf list where many legacy cache events
> are elided due to a lack of support.
> 
> > Regardless, I think the tool is doing something semantically wrong, see below.
> >
> > > So I share your confusion as to why something broke.
> > >
> > > PERF_TYPE_HARDWARE is a legacy type where there are hardcoded type and
> > > config values that correspond to an event. The PMU driver turns legacy
> > > events into the real types. On BIG.little systems if the legacy events
> > > are monitoring a task a different event is needed for each PMU (ie >1
> > > event). In your example you are monitoring 'ls', a task, and so
> > > different cycles events are necessary. In the high 32-bits (the
> > > extended type) the PMU is identified.
> >
> > I think the interesting thing here is that the tool is mapping events with an
> > explicit PMU into legacy PERF_TYPE_HARDWARE events, which is the opposite
> > direction than intended. Regardless of whether PERF_TYPE_HARDWARE events can be
> > targetted to a specific PMU, if the user has requested to use a specific PMU we
> > should be using that PMU and related event namespace.
> >
> > Marc's command line was:
> >
> >         sudo taskset -c 0 ./perf stat -vvv \
> >                 -e apple_icestorm_pmu/cycles/ \
> >                 -e apple_firestorm_pmu/cycles/ \
> >                 -e cycles \
> 
> -e cycles here is a direct request for the legacy cycles event. It
> will match in the parser here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.l?h=perf-tools-next#n301
> 
> which goes to:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.y?h=perf-tools-next#n397
> 
> and as this is a hardware event there is wildcard expansion on each core PMU.

Please read the rest of my message, which was talking about the other two
events.

Mark.

> 
> Thanks,
> Ian
> 
> >         ls
> >
> > ... and so the apple_*_pmu events should target their respective PMUs, and the
> > plain 'cycles' event could legitimately be opened as a single
> > PERF_TYPE_HARDWARE event, or split into two directed PERF_TYPE_HARDWARE events
> > targetting the two PMUs.
> >
> > However, thwe tool opens three (undirected?) PERF_TYPE_HARDWARE events:
> >
> > Opening: apple_icestorm_pmu/cycles/
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 3
> > Opening: apple_firestorm_pmu/cycles/
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
> > Opening: cycles
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> >
> > Mark.
