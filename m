Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C57D572F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjJXQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343961AbjJXQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:00:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0083;
        Tue, 24 Oct 2023 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xvNEiBG63OMFNIn4OCYNrNvdsGaoHiuqOfDxDCymSUw=; b=AzsoK5Ff7sTZHDFak0kPEDI5yk
        VC5DL953fZLBhoy4NmnC1rXy7r5I6rdvL2NC0M+aHyRp6uKWYYUbn9DOZdBDw6xFSwBZ9slONlyTd
        k1ghMe19z8kQOYAsNOCjoMkXD77GJR7TDJshwXXHh20Lu0W4HJOOwNhAlpHUp7sFoGdIabSVz4slF
        1hcl3DUGDzQAM7Md/UZiKdslYPr06ZMh7F1qiW5v5zAnNs9+NJm5HmtpjGb7lHtKWyJZU3bkHd8vw
        VSZPes5rZWCFElEEf5vptiugjyRK6VOCu/y66iRufTApPD+hmDsio39eDk38OaIwYCzYlLKZCIl02
        eYsb04Ew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvJoh-003Mtt-Ov; Tue, 24 Oct 2023 15:59:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C3C7300451; Tue, 24 Oct 2023 17:59:39 +0200 (CEST)
Date:   Tue, 24 Oct 2023 17:59:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Message-ID: <20231024155939.GF33965@noisy.programming.kicks-ass.net>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com>
 <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:32:27AM -0500, Mario Limonciello wrote:
> On 10/24/2023 03:02, Ingo Molnar wrote:
> > 
> > * Mario Limonciello <mario.limonciello@amd.com> wrote:
> > 
> > > Fixes a BUG reported during suspend to ram testing.
> > > 
> > > ```
> > > [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
> > > [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
> > > ```
> > > 
> > > Cc: stable@vger.kernel.org # 6.1+
> > > Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   arch/x86/events/amd/lbr.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> > > index eb31f850841a..5b98e8c7d8b7 100644
> > > --- a/arch/x86/events/amd/lbr.c
> > > +++ b/arch/x86/events/amd/lbr.c
> > > @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
> > >   void amd_pmu_lbr_reset(void)
> > >   {
> > > -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
> > >   	int i;
> > >   	if (!x86_pmu.lbr_nr)
> > > @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
> > >   	cpuc->last_task_ctx = NULL;
> > >   	cpuc->last_log_id = 0;
> > > +	put_cpu_ptr(&cpu_hw_events);
> > >   	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
> > >   }
> > 
> > Weird, amd_pmu_lbr_reset() is called from these places:
> > 
> >    - amd_pmu_lbr_sched_task(): during task sched-in during
> >      context-switching, this should already have preemption disabled.
> > 
> >    - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add
> >      (amd_pmu_add_event()), called by event_sched_in(), which too should have
> >      preemption disabled.
> > 
> > I clearly must have missed some additional place it gets called in.
> > 
> > Could you please cite the full log of the amd_pmu_lbr_reset() call that
> > caused the critical section warning?
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Below is the call trace in case you think it's better to disable preemption
> by the caller instead.  If you think it's better to keep it in
> amd_pmu_lbr_reset() I'll add this trace to the commit message.

You cut too much; what task is running this?

IIRC this is the hotplug thread running a teardown function on that CPU
itself. It being a strict per-cpu thread should not trip
smp_processor_id() wanrs.

> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x44/0x60
>  check_preemption_disabled+0xce/0xf0
>  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>  amd_pmu_lbr_reset+0x19/0xc0
>  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>  amd_pmu_cpu_reset.constprop.0+0x51/0x60
>  amd_pmu_cpu_dead+0x3e/0x90
>  x86_pmu_dead_cpu+0x13/0x20
>  cpuhp_invoke_callback+0x169/0x4b0
>  ? __pfx_virtnet_cpu_dead+0x10/0x10
>  __cpuhp_invoke_callback_range+0x76/0xe0
>  _cpu_down+0x112/0x270
>  freeze_secondary_cpus+0x8e/0x280
>  suspend_devices_and_enter+0x342/0x900
>  pm_suspend+0x2fd/0x690
>  state_store+0x71/0xd0
>  kernfs_fop_write_iter+0x128/0x1c0
>  vfs_write+0x2db/0x400
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x59/0x90
> 
