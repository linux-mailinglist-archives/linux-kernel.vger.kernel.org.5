Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32187D5880
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjJXQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjJXQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:35:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E812B;
        Tue, 24 Oct 2023 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7aiZywvRsY6Q9Q6XdkE7hDVMPUu+CQ0jOQmrFXLh59M=; b=kQisp2ZwovIQVYckoNXGBwGKrG
        3e5egzEVLe1e9mWSI3TxFDX2czlSZvM4r5St10+3Ba15FiqYx6/kgC6Ao/O2QQ3RFynG1n30yjLGl
        0Q+aRCWgyu285A3GXng3Wv3VO5dd7T47Mlf3QyhvuBQRKylud7r7l6Se6giPpbRbMLsUVDM1zEs/h
        BMPcGl/VXrAj7TbDJliAzOz0HPLD+lvQPpxqI9bjQXzYrhNUp3YqCYgbdwbbIRZk4QKxJG3jFh+G1
        xf0KanQY+iQxsK6T6gyqjJJb4aB+0PltrXFk33g/5NTp+XJSKg6XyTlX9NsiLrAPpWR8b/Yl83hRs
        qiKuv7Gw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvKMl-00Fdwy-0L;
        Tue, 24 Oct 2023 16:34:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD326300392; Tue, 24 Oct 2023 18:34:50 +0200 (CEST)
Date:   Tue, 24 Oct 2023 18:34:50 +0200
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
Message-ID: <20231024163450.GB13938@noisy.programming.kicks-ass.net>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com>
 <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
 <20231024155939.GF33965@noisy.programming.kicks-ass.net>
 <47518940-2803-4a6b-88fd-8cfc872b4219@amd.com>
 <20231024163038.GC40044@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024163038.GC40044@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:30:38PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 24, 2023 at 11:04:06AM -0500, Mario Limonciello wrote:
> 
> > > IIRC this is the hotplug thread running a teardown function on that CPU
> > > itself. It being a strict per-cpu thread should not trip
> > > smp_processor_id() wanrs.
> > > 
> > 
> > BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
> > caller is amd_pmu_lbr_reset+0x19/0xc0
> > CPU: 104 PID: 2960 Comm: rtcwake Not tainted 6.6.0-rc6-00002-g3e2c7f3ac51f
> 
> Very much not the cpuhp/%u thread :/, let me try and figure out how that
> happens.

Uhh, my bad, these are the PREPARE/DEAD handlers, they run before online
and after dying. The CPU is completely dead. Running lbr_reset() here
makes no sense.

Did that want to be in amd_pmu_cpu_dying() ?

> 
> > #1025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x44/0x60
> >  check_preemption_disabled+0xce/0xf0
> >  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
> >  amd_pmu_lbr_reset+0x19/0xc0
> >  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
> >  amd_pmu_cpu_reset.constprop.0+0x51/0x60
> >  amd_pmu_cpu_dead+0x3e/0x90
> >  x86_pmu_dead_cpu+0x13/0x20
> >  cpuhp_invoke_callback+0x169/0x4b0
> >  ? __pfx_virtnet_cpu_dead+0x10/0x10
> >  __cpuhp_invoke_callback_range+0x76/0xe0
> >  _cpu_down+0x112/0x270
> >  freeze_secondary_cpus+0x8e/0x280
