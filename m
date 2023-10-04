Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AEB7B8559
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbjJDQcn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243290AbjJDQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:32:41 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86919B;
        Wed,  4 Oct 2023 09:32:37 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-690ba63891dso1860468b3a.2;
        Wed, 04 Oct 2023 09:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437157; x=1697041957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpOILGaPzFme8eJnGnR7nEZgZ9N3yDhRVdNPBjXB47c=;
        b=b+YejCkoEdwopGfDPgAGjaHWPvDM7ZsfMdewoH0wvRXcHLwmEYmxGZjCs4/B6uTG+n
         7q5xNNGxTaaM0fcpI3dpuVMlza53HXHvmj8T6L5SfDngig1vF26ezuREEEpnhTAmY588
         5DcJHripshVPKqMH9sPip8SvIS7vZW7/rTaAhk+ewlUBDyaNgL9n4bg9fpRPuU9NPS65
         2zXcts/gycDWv3+W0BDTvXmUR1C76WVFTRqDZ3a5+IVmOOMVGrW6DOUrlO2hEDuLy4Ih
         aGe/Sc3m4tmxISMVTpFQSBe8orm8mcAn9cw+KC9Z7VnyIv0TxCnduA5Hstc4rdYatBk/
         wJpA==
X-Gm-Message-State: AOJu0YzeHq1VCiiP9/oqS8dPVoOp+bM7pX38Suop24+pWgG3VeyUjIUL
        NfKkQivw20gqJCOoZ8oOrUDbgyEKARFUda/Lms0=
X-Google-Smtp-Source: AGHT+IHW186xVTeJmlnOiSCmnojvR2aQu3JeoB9Ud4SaLe0VHaFIYFXp2RClDsx5Ggek5JoNCr7YFlnR0Qxq+UZGStM=
X-Received: by 2002:a17:90b:1047:b0:277:6985:a3ff with SMTP id
 gq7-20020a17090b104700b002776985a3ffmr2429510pjb.3.1696437156981; Wed, 04 Oct
 2023 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231004040844.797044-1-namhyung@kernel.org> <20231004160224.GB6307@noisy.programming.kicks-ass.net>
In-Reply-To: <20231004160224.GB6307@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 4 Oct 2023 09:32:24 -0700
Message-ID: <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Oct 4, 2023 at 9:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 03, 2023 at 09:08:44PM -0700, Namhyung Kim wrote:
>
> > But after the change, it ended up iterating all pmus/events in the cpu
> > context if there's a cgroup event somewhere on the cpu context.
> > Unfortunately it includes uncore pmus which have much longer latency to
> > control.
>
> Can you describe the problem in more detail please?

Sure.

>
> We have cgrp as part of the tree key: {cpu, pmu, cgroup, idx},
> so it should be possible to find a specific cgroup for a cpu and or skip
> to the next cgroup on that cpu in O(log n) time.

This is about a single (core) pmu when it has a lot of events.
But this problem is different, it's about accessing more pmus
unnecessarily.

Say we have the following events for CPU 0.

  sw: context-switches
  core: cycles, cycles-for-cgroup-A
  uncore: whatever

The cpu context has a cgroup event so it needs to call
perf_cgroup_switch() at every context switch.  But actually
it only needs to resched the 'core' pmu since it only has a
cgroup event.  Other pmu events (like context-switches or
any uncore event) should not be bothered by that.

But perf_cgroup_switch() calls the general functions which
iterate all pmus in the (cpu) context.

  cpuctx.ctx.pmu_ctx_list:
    +-> sw -> core -> uncore  (pmu_ctx_entry)

Then it disables pmus, sched-out current events, switch
cgroup pointer, sched-in new events and enable pmus.
This gives a lot more overhead when it has uncore pmus
since accessing MSRs for uncore pmus has longer latency.
But uncore pmus cannot have cgroup events in the first
place.

So we need a separate list to keep pmus that have
active cgroup events.

  cpuctx.cgrp_ctx_list:
    +-> core  (cgrp_ctx_entry)

And we also need a logic to do the same work only
for this list.

Hope this helps.

>
> > To fix the issue, I restored a linked list equivalent to cgrp_cpuctx_list
> > in the perf_cpu_context and link perf_cpu_pmu_contexts that have cgroup
> > events only.  Also add new helpers to enable/disable and does ctx sched
> > in/out for cgroups.
>
> Adding a list and duplicating the whole scheduling infrastructure seems
> 'unfortunate' at best.

Yeah, I know.. but I couldn't come up with a better solution.

Thanks,
Namhyung
