Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC08110BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378805AbjLMMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjLMMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:05:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 260C6EA;
        Wed, 13 Dec 2023 04:06:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB33AC15;
        Wed, 13 Dec 2023 04:06:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3F43F762;
        Wed, 13 Dec 2023 04:06:01 -0800 (PST)
Date:   Wed, 13 Dec 2023 12:05:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXmeJmt-I65Quww3@FVFF77S0Q05N>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
 <56f4ba32-a0c6-4ae4-8bf9-c00aaed65fc5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56f4ba32-a0c6-4ae4-8bf9-c00aaed65fc5@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:22:49PM -0500, Liang, Kan wrote:
> 
> 
> On 2023-12-12 1:49 p.m., Namhyung Kim wrote:
> > On Tue, Dec 12, 2023 at 10:31 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >>
> >> On Tue, Dec 12, 2023 at 10:00:16AM -0800, Ian Rogers wrote:
> >>> On Tue, Dec 12, 2023 at 9:23 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>>
> >>>> On Tue, Dec 12, 2023 at 7:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> >>>>>> Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> >>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>>>>
> >>>>>>> perf top errors out on a hybrid machine
> >>>>>>>  $perf top
> >>>>>>>
> >>>>>>>  Error:
> >>>>>>>  The cycles:P event is not supported.
> >>>>>>>
> >>>>>>> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> >>>>>>> PMU. It causes perf_event_open to fail.
> >>>>>>
> >>>>>> ?
> >>>>>>
> >>>>>> All perf top expects is that the "cycles", the most basic one, be
> >>>>>> collected, on all CPUs in the system.
> >>>>>>
> >>>>>
> >>>>> Yes, but for hybrid there is no single "cycles" event which can cover
> >>>>> all CPUs.
> >>>>
> >>>> Does that mean the kernel would reject the legacy "cycles" event
> >>>> on hybrid CPUs?
> >>>
> >>> I believe not. When the extended type isn't set on legacy cycles we
> >>> often have the CPU and from that can determine the PMU. The issue is
> >>> with the -1 any CPU perf_event_open option. As I was told, the PMU the
> >>> event is opened on in this case is the first one registered in the
> >>> kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
> >>> it'll probably be cpu_core. On ARM ¯\_(ツ)_/¯.
> >>
> >> On ARM it'll be essentially the same as on x86: if you open an event with
> >> type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
> >> specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
> >> happens to be found by perf_init_event() when iterating over the 'pmus' list.
> >>
> >> If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
> >> will opened on the appropriate CPU PMU, by virtue of being rejected by others
> >> when perf_init_event() iterates over the 'pmus' list.
> > 
> > Ok, that means "cycles" with cpu == -1 would not work well.
> 
> Unless a PMU is specified.
> 
> > I'm curious if it's possible to do some basic work at the event_init()
> > like to preserve (common) resource and to do some other work at
> > sched to config PMU on the current CPU.  So that users can simply
> > use "cycles" or "instructions" for their processes.
> 
> The current code treats the hybrid as two standalone PMUs. To preserve
> the common resource in the other PMU, I think the only way is to create
> an event on the other PMU. It's what perf tool does now. I don't think
> we want to move the logic to the kernel.

Agreed.

> I think a possible way is to abstract a common PMU (cpu) which only
> includes common PMU features. It should be doable, because without the
> enabling code of hybrid, the default PMU is the common PMU. But I don't
> know how does it coexist with the other hybrid PMUs if we have both
> common PMU and hybrid PMUs available? It may just bring more complexity.

I think that brings a surprising amount of complexity, and I'm not entirely
sure if that's practical (since you'd effectively end up with a logical PMU
being dependent on multiple other logical PMUs).

I also think that it's practically necessary to expose the counts to the user
separately, even for common events. For example, the 'instructions' event may
count differently (speculative vs architectural execution), and 'cycles' can be
wildly different across microarchitectures due to realizable IPC, and blindly
adding those up across PMUs is liable to produce a misleading figure (and/or
one with massive variation).

While it is ugly, I think that it's necessary for userspace to discover the set
of CPU PMUs and open seperate events on them in order to produce useful data.

Specifically for perf top, if one is monitoring all CPUs, it'd be fine to open
a PERF_TYPE_HARDWARE event for each CPU; so long as cpu!=-1 it would go to the
relevant PMU and be counted as expected.

Thanks,
Mark.
