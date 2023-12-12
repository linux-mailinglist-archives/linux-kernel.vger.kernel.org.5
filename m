Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90980F58A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbjLLSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:31:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D29CA;
        Tue, 12 Dec 2023 10:31:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E638FEC;
        Tue, 12 Dec 2023 10:31:58 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4653F762;
        Tue, 12 Dec 2023 10:31:11 -0800 (PST)
Date:   Tue, 12 Dec 2023 18:31:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:00:16AM -0800, Ian Rogers wrote:
> On Tue, Dec 12, 2023 at 9:23 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Dec 12, 2023 at 7:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > >
> > >
> > >
> > > On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> > > >> From: Kan Liang <kan.liang@linux.intel.com>
> > > >>
> > > >> perf top errors out on a hybrid machine
> > > >>  $perf top
> > > >>
> > > >>  Error:
> > > >>  The cycles:P event is not supported.
> > > >>
> > > >> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> > > >> PMU. It causes perf_event_open to fail.
> > > >
> > > > ?
> > > >
> > > > All perf top expects is that the "cycles", the most basic one, be
> > > > collected, on all CPUs in the system.
> > > >
> > >
> > > Yes, but for hybrid there is no single "cycles" event which can cover
> > > all CPUs.
> >
> > Does that mean the kernel would reject the legacy "cycles" event
> > on hybrid CPUs?
> 
> I believe not. When the extended type isn't set on legacy cycles we
> often have the CPU and from that can determine the PMU. The issue is
> with the -1 any CPU perf_event_open option. As I was told, the PMU the
> event is opened on in this case is the first one registered in the
> kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
> it'll probably be cpu_core. On ARM ¯\_(ツ)_/¯.

On ARM it'll be essentially the same as on x86: if you open an event with
type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
happens to be found by perf_init_event() when iterating over the 'pmus' list.

If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
will opened on the appropriate CPU PMU, by virtue of being rejected by others
when perf_init_event() iterates over the 'pmus' list.

Mark.
