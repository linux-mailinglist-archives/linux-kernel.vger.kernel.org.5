Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6F7D585F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbjJXQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjJXQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:31:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123112B;
        Tue, 24 Oct 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yw1JizmzQa21OHIpxEbqWsvPR+Hf7j2CXdWs4xmNF0k=; b=jyw7JHuwxzc7X7X8xzfcxQNQ1b
        UjBFZlqt75ASSvoLbUxiITUd7kclX9FIdvcnTPmW7R34OmJNJaey6q//Ob1gJe2KDSsYBG6S1ld+D
        0LFxu9pr0ctPh0ET/BczCKmpYg0PZgX9Ct5SgB9pi2RvbgB5F3hb66yBj0ILSJIUXeaR2Krsbn6L6
        Fj5eJHWRLKGk1xqoMt0XqlwMdqDuz5M2G3N85hYwoRhAfdfAJYE2ekPn6bmWnilWiErAqNVPMu3YG
        i0AR6202kThNeaa5o9Hiauquerm5AGL2qqHa96gTJHR+rlfOrK35qlGYv/BKBNxTTYairTWpK68Hc
        lodsjShg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvKIg-00Fdqo-3A;
        Tue, 24 Oct 2023 16:30:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4998300451; Tue, 24 Oct 2023 18:30:38 +0200 (CEST)
Date:   Tue, 24 Oct 2023 18:30:38 +0200
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
Message-ID: <20231024163038.GC40044@noisy.programming.kicks-ass.net>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com>
 <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
 <20231024155939.GF33965@noisy.programming.kicks-ass.net>
 <47518940-2803-4a6b-88fd-8cfc872b4219@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47518940-2803-4a6b-88fd-8cfc872b4219@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:04:06AM -0500, Mario Limonciello wrote:

> > IIRC this is the hotplug thread running a teardown function on that CPU
> > itself. It being a strict per-cpu thread should not trip
> > smp_processor_id() wanrs.
> > 
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
> caller is amd_pmu_lbr_reset+0x19/0xc0
> CPU: 104 PID: 2960 Comm: rtcwake Not tainted 6.6.0-rc6-00002-g3e2c7f3ac51f

Very much not the cpuhp/%u thread :/, let me try and figure out how that
happens.

> #1025
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
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? count_memcg_events.constprop.0+0x1a/0x30
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? handle_mm_fault+0x1e9/0x340
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? preempt_count_add+0x4d/0xa0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? up_read+0x38/0x70
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? do_user_addr_fault+0x343/0x6b0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? exc_page_fault+0x74/0x170
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7f32f8d14a77
> Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa
> 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff
> 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffdc648de18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f32f8d14a77
> RDX: 0000000000000004 RSI: 000055b2fc2a5670 RDI: 0000000000000004
> RBP: 000055b2fc2a5670 R08: 0000000000000000 R09: 000055b2fc2a5670
> R10: 00007f32f8e1a2f0 R11: 0000000000000246 R12: 0000000000000004
> R13: 000055b2fc2a2480 R14: 00007f32f8e16600 R15: 00007f32f8e15a00
>  </TASK>
