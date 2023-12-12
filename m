Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0980F5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376642AbjLLStV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 13:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjLLStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:19 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4DEA;
        Tue, 12 Dec 2023 10:49:25 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2866af9d73bso4274508a91.3;
        Tue, 12 Dec 2023 10:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406965; x=1703011765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieLFoul+mPd07DhlmLbEOA93lnztioXfkR7OG/Df+DA=;
        b=bAcc2eIzWeoo3OBxHov2eG3v9sOKkirmyvwy2vzWOyv25FliibRP0Q9VpbP6xQ0Sd2
         6LVXnKeIHP47XKcJuF6O17MpXG3+yUxPiuxpigXHrN7MYQvMiXsDeXToo2aBJRwbwg6o
         HzFff+Sy/JEKk+Bn7txemmIyyKRrEyabunGs9gbJUo7iyW0078y8HT6dmNAaZZs2oJYG
         HvEJ6kAKfDL1FtrN5VpB9cSz7FsYhPQstkn+/nzx2Qred318rw+I7Ub8SyxfZmxZgO9d
         IGmNlPX65GRa2JCOQ7LhwLqDiqTKFuwQUfAW0RVRIJlu+OSK/vJumwqHjSahi8+4S4tq
         mOLg==
X-Gm-Message-State: AOJu0YzYnKHWrs2pZZW2+OWGXstGxcFFdUD8R7/7gtpN6cKcuaP3hjZp
        t0J/0Ijbp0Z5RhCND0jONx9h/pz16Z2hQEKHvJs=
X-Google-Smtp-Source: AGHT+IHdP3JrLMVcqtMfuENRl0xtVa+FaokLT1DzuYhAg4/9SPuXyOZnu4rxOzqkQLlNZeaWchecIL4bXQ7nH+WRKrQ=
X-Received: by 2002:a17:90b:1210:b0:28a:6137:149b with SMTP id
 gl16-20020a17090b121000b0028a6137149bmr2980031pjb.94.1702406965050; Tue, 12
 Dec 2023 10:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org> <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com> <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 10:49:13 -0800
Message-ID: <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:31 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 12, 2023 at 10:00:16AM -0800, Ian Rogers wrote:
> > On Tue, Dec 12, 2023 at 9:23 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Dec 12, 2023 at 7:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > > > > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> > > > >> From: Kan Liang <kan.liang@linux.intel.com>
> > > > >>
> > > > >> perf top errors out on a hybrid machine
> > > > >>  $perf top
> > > > >>
> > > > >>  Error:
> > > > >>  The cycles:P event is not supported.
> > > > >>
> > > > >> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> > > > >> PMU. It causes perf_event_open to fail.
> > > > >
> > > > > ?
> > > > >
> > > > > All perf top expects is that the "cycles", the most basic one, be
> > > > > collected, on all CPUs in the system.
> > > > >
> > > >
> > > > Yes, but for hybrid there is no single "cycles" event which can cover
> > > > all CPUs.
> > >
> > > Does that mean the kernel would reject the legacy "cycles" event
> > > on hybrid CPUs?
> >
> > I believe not. When the extended type isn't set on legacy cycles we
> > often have the CPU and from that can determine the PMU. The issue is
> > with the -1 any CPU perf_event_open option. As I was told, the PMU the
> > event is opened on in this case is the first one registered in the
> > kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
> > it'll probably be cpu_core. On ARM ¯\_(ツ)_/¯.
>
> On ARM it'll be essentially the same as on x86: if you open an event with
> type==PERF_EVENT_TYPE_HARDWARE (without the extended HW type pointing to a
> specific PMU), and with cpu==-1, it'll go to an arbitrary CPU PMU, whichever
> happens to be found by perf_init_event() when iterating over the 'pmus' list.
>
> If you open an event with type==PERF_EVENT_TYPE_HARDWARE and cpu!=-1, the event
> will opened on the appropriate CPU PMU, by virtue of being rejected by others
> when perf_init_event() iterates over the 'pmus' list.

Ok, that means "cycles" with cpu == -1 would not work well.

I'm curious if it's possible to do some basic work at the event_init()
like to preserve (common) resource and to do some other work at
sched to config PMU on the current CPU.  So that users can simply
use "cycles" or "instructions" for their processes.

Thanks,
Namhyung
