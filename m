Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCB7F336A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjKUQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKUQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:15:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7396A197;
        Tue, 21 Nov 2023 08:15:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DBD1FB;
        Tue, 21 Nov 2023 08:16:02 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C77933F6C4;
        Tue, 21 Nov 2023 08:15:14 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:15:11 +0000
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
Message-ID: <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> On Tue, Nov 21, 2023 at 8:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > > On Tue, Nov 21, 2023 at 7:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > > > > On Tue, 21 Nov 2023 13:40:31 +0000,
> > > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > [Adding key people on Cc]
> > > > > >
> > > > > > On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > > > Hector Martin <marcan@marcan.st> wrote:
> > > > > > >
> > > > > > > Perf broke on all Apple ARM64 systems (tested almost everything), and
> > > > > > > according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> > > > > >
> > > > > > I can confirm that at least on 6.7-rc2, perf is pretty busted on any
> > > > > > asymmetric ARM platform. It isn't clear what criteria is used to pick
> > > > > > the PMU, but nothing works anymore.
> > > > > >
> > > > > > The saving grace in my case is that Debian still ships a 6.1 perftool
> > > > > > package, but that's obviously not going to last.
> > > > > >
> > > > > > I'm happy to test potential fixes.
> > > > >
> > > > > At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
> > > > > -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
> > > > > CPU):
> > > >
> > > > IIUC the tool is doing the wrong thing here and overriding explicit
> > > > ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than events using
> > > > that ${pmu}'s type and event namespace.
> > > >
> > > > Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to be
> > > > targetted to a specific PMU, it's semantically wrong to rewrite events like
> > > > this since ${pmu}/${event}/ is not necessarily equivalent to a similarly-named
> > > > PERF_COUNT_HW_${EVENT}.
> > >
> > > If you name a PMU and an event then the event should only be opened on
> > > that PMU, 100% agree. There's a bunch of output, but when the legacy
> > > cycles event is opened it appears to be because it was explicitly
> > > requested.
> >
> > I think you've missed that the named PMU events are being erreously transformed
> > into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> >
> >   Opening: apple_firestorm_pmu/cycles/
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             0 (PERF_TYPE_HARDWARE)
> >     size                             136
> >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >     sample_type                      IDENTIFIER
> >     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >     disabled                         1
> >     inherit                          1
> >     enable_on_exec                   1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
> >
> > ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.
> >
> > Marc said that he bisected the issue down to commit:
> >
> >   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")
> >
> > ... so it looks like something is going wrong when the events are being parsed,
> > e.g. losing the HW PMU information?
> 
> Ok, I think I'm getting confused by other things. This looks like the issue.
> 
> I think it may be working as intended, but not how you intended :-) If
> a core PMU is listed and then a legacy event, the legacy event should
> be opened on the core PMU as a legacy event with the extended type
> set. This is to allow things like legacy cache events to be opened on
> a specified PMU. Legacy event names match with a higher priority than
> those in sysfs or json as they are hard coded. 

That has never been the case previously, so this is user-visible breakage, and
it prevents users from being able to do the right thing, so I think that's a
broken design.

> Presumably the expectation was that by advertising a cycles event, presumably
> in sysfs, then this is what would be matched.

I expect that if I ask for ${pmu}/${event}/, that PMU is used, and the event
*in that PMU's namespace* is used. Overriding that breaks long-established
practice and provides users with no recourse to get the behavioru they expect
(and previosuly had).

I do think that (regardless of whther this was the sematnic you intended)
silently overriding events with legacy events is a bug, and one we should fix.
As I mentioned in another reply, just because the events have the same name
does not mean that they are semantically the same, so we're liable to give
people the wrong numbers anyhow.

Can we fix this?

Mark.
