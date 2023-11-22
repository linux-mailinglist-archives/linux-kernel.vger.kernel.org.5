Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5517F4B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjKVPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344361AbjKVPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07080D8;
        Wed, 22 Nov 2023 07:49:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC521595;
        Wed, 22 Nov 2023 07:50:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD113F73F;
        Wed, 22 Nov 2023 07:49:23 -0800 (PST)
Date:   Wed, 22 Nov 2023 15:49:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Ian Rogers <irogers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N>
References: <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st>
 <ZV38z3+p2S2ETtzG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV38z3+p2S2ETtzG@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:06:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 22, 2023 at 12:23:27PM +0900, Hector Martin escreveu:
> > On 2023/11/22 1:38, Ian Rogers wrote:
> > > On Tue, Nov 21, 2023 at 8:15 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > >>> On Tue, Nov 21, 2023 at 8:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > >>>>> On Tue, Nov 21, 2023 at 7:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > >>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
> > >>>>>>> Marc Zyngier <maz@kernel.org> wrote:
> > >>>>>>>>
> > >>>>>>>> [Adding key people on Cc]
> > >>>>>>>>
> > >>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
> > >>>>>>>> Hector Martin <marcan@marcan.st> wrote:
> > >>>>>>>>>
> > >>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
> > >>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> > >>>>>>>>
> > >>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty busted on any
> > >>>>>>>> asymmetric ARM platform. It isn't clear what criteria is used to pick
> > >>>>>>>> the PMU, but nothing works anymore.
> > >>>>>>>>
> > >>>>>>>> The saving grace in my case is that Debian still ships a 6.1 perftool
> > >>>>>>>> package, but that's obviously not going to last.
> > >>>>>>>>
> > >>>>>>>> I'm happy to test potential fixes.
> > >>>>>>>
> > >>>>>>> At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
> > >>>>>>> -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
> > >>>>>>> CPU):
> > >>>>>>
> > >>>>>> IIUC the tool is doing the wrong thing here and overriding explicit
> > >>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than events using
> > >>>>>> that ${pmu}'s type and event namespace.
> > >>>>>>
> > >>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to be
> > >>>>>> targetted to a specific PMU, it's semantically wrong to rewrite events like
> > >>>>>> this since ${pmu}/${event}/ is not necessarily equivalent to a similarly-named
> > >>>>>> PERF_COUNT_HW_${EVENT}.
> > >>>>>
> > >>>>> If you name a PMU and an event then the event should only be opened on
> > >>>>> that PMU, 100% agree. There's a bunch of output, but when the legacy
> > >>>>> cycles event is opened it appears to be because it was explicitly
> > >>>>> requested.
> > >>>>
> > >>>> I think you've missed that the named PMU events are being erreously transformed
> > >>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> > >>>>
> > >>>>   Opening: apple_firestorm_pmu/cycles/
> > >>>>   ------------------------------------------------------------
> > >>>>   perf_event_attr:
> > >>>>     type                             0 (PERF_TYPE_HARDWARE)
> > >>>>     size                             136
> > >>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >>>>     sample_type                      IDENTIFIER
> > >>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >>>>     disabled                         1
> > >>>>     inherit                          1
> > >>>>     enable_on_exec                   1
> > >>>>     exclude_guest                    1
> > >>>>   ------------------------------------------------------------
> > >>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
> > >>>>
> > >>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.
> > >>>>
> > >>>> Marc said that he bisected the issue down to commit:
> > >>>>
> > >>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")
> > >>>>
> > >>>> ... so it looks like something is going wrong when the events are being parsed,
> > >>>> e.g. losing the HW PMU information?
> > >>>
> > >>> Ok, I think I'm getting confused by other things. This looks like the issue.
> > >>>
> > >>> I think it may be working as intended, but not how you intended :-) If
> > >>> a core PMU is listed and then a legacy event, the legacy event should
> 
> The point is that "cycles" when prefixed with "pmu/" shouldn't be
> considered "cycles" as HW/0, in that setting it is "cycles" for that
> PMU.

Exactly.

> (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
> have access in a Libre Computer rockchip 3399-pc hybrid board, if we use
> it, then we get what we want/had before, see below):

Both Cortex-A53 and Cortex-A72 have the common PMUv3 events, so they have
"cpu_cycles" and "bus_cycles".

The Apple PMUs that Hector and Marc anre using don't follow the PMUv3
architecture, and just have a "cycles" event.

[...]

> So what we need here seems to be to translate the generic term "cycles"
> to "cpu_cycles" when a PMU is explicitely passed in the event name and
> it doesn't have "cycles" and then just retry.

I'm not sure we need to map that.

My thinking is:

* If the user asks for "cycles" without a PMU name, that should use the
  PERF_TYPE_HARDWARE cycles event. The ARM PMUs handle that correctly when the
  event is directed to them.

* If the user asks for "${pmu}/cycles/", that should only use the "cycles"
  event in that PMU's namespace, not PERF_TYPE_HARDWARE.

* If we need a way so say "use the PERF_TYPE_HARDWARE cycles event on ${pmu}",
  then we should have a new syntax for that (e.g. as we have for raw events),
  e.g. it would be possible to have "pmu/hw:cycles/" or something like that.

That way there's no ambiguity.

Mark.
