Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DE7B7300
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJCVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJCVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:05:21 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759CAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:05:18 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5859b1c92a0so972006a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367117; x=1696971917;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O0/YlS/arDQZ0m59TMVj+gfeRzJ2BBzIjZ1NFmOoYM=;
        b=nb/u07hT2nzyVT0Mzg6D3iMWafVOddYcwPhWWZbrOodoxetUhrh+c6rx+/RlkUuFsh
         SItA3PrnN6pSvD60bjQGeqvmnhfqltq/UzIiUxBH1hUh9mP+0Ct/pSG9bRwPrHHrNkGs
         skb7JgVpJ5/5K3N50E7v3o/M4K+c9IoTp6/dTpYdkfMzuvmCnpcrry/mDF2zGW4vTs0t
         gcE+kG/lEIgjxlTlP96TQNsQAk1paSqUBhusB5J4oVVDjncdFTdbujSZPrk4P2uAwrc8
         dwt+jOo6v6GzTVKd46k74x+gb4uIdOg7TAL/EIV+RhbFtvDQlzIVTtC2x02nSJ307kwK
         sRBg==
X-Gm-Message-State: AOJu0YwRnLyWlBEEbIdUKGA7VP0pnY140A7pEi5KL1HrbK9IhPmRIcKY
        h2Bzk1JkMu7uC2HMEp6/L40=
X-Google-Smtp-Source: AGHT+IHs9U1B2oRA/do3+LekxRx4sXIeoGKOqJVQ7F/v1Ii4bpI/WuEUyovozvZtH3NiSn4apdrtCQ==
X-Received: by 2002:a05:6a21:35c8:b0:105:6d0e:c046 with SMTP id ba8-20020a056a2135c800b001056d0ec046mr588676pzc.26.1696367116576;
        Tue, 03 Oct 2023 14:05:16 -0700 (PDT)
Received: from maniforge ([2620:10d:c090:400::4:4c3])
        by smtp.gmail.com with ESMTPSA id g4-20020a62e304000000b006933e71956dsm1789811pfh.9.2023.10.03.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:05:16 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:05:11 -0500
From:   David Vernet <void@manifault.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <20231003210511.GB30978@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
 <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:59:29PM +0800, Chen Yu wrote:
> Hi Prateek,

Hi Chenyu,

> On 2023-09-27 at 09:53:13 +0530, K Prateek Nayak wrote:
> > Hello David,
> > 
> > Some more test results (although this might be slightly irrelevant with
> > next version around the corner)
> > 
> > On 9/1/2023 12:41 AM, David Vernet wrote:
> > > On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> > > 
> > -> With EEVDF
> > 
> > o tl;dr
> > 
> > - Same as what was observed without EEVDF  but shared_runq shows
> >   serious regression with multiple more variants of tbench and
> >   netperf now.
> > 
> > o Kernels
> > 
> > eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
> > shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
> > shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
> > 			  (the rd->overload check still remains below the shared_runq access)
> >
> 
> I did not see any obvious regression on a Sapphire Rapids server and it seems that
> the result on your platform suggests that C/S workload could be impacted
> by shared_runq. Meanwhile some individual workloads like HHVM in David's environment
> (no shared resource between tasks if I understand correctly) could benefit from

Correct, hhvmworkers are largely independent, though they do sometimes
synchronize, and they also sometimes rely on I/O happening in other
tasks.

> shared_runq a lot. This makes me wonder if we can let shared_runq skip the C/S tasks.

I'm also open to this possibility, but I worry that we'd be going down
the same rabbit hole as what fair.c does already, which is use
heuristics to determine when something should or shouldn't be migrated,
etc. I really do feel that there's value in SHARED_RUNQ providing
consistent and predictable work conservation behavior.

On the other hand, it's clear that there are things we can do to improve
performance for some of these client/server workloads that hammer the
runqueue on larger CCXs / sockets. If we can avoid those regressions
while still having reasonably high confidence that work conservation
won't disproportionately suffer, I'm open to us making some tradeoffs
and/or adding a bit of complexity to avoid some of this unnecessary
contention.

I think it's probably about time for v4 to be sent out. What do you
folks think about including:

1. A few various fixes / tweaks from v3, e.g. avoiding using the wrong
   shard on the task_dead_fair() path if the feature is disabled before
   a dying task is dequeued from a shard, fixing the build issues
   pointed out by lkp, etc.
2. Fix the issue that Prateek pointed out in [0] where we're not
   properly skipping the LLC domain due to using the for_each_domain()
   macro (this is also addressed by (3)).
3. Apply Prateek's suggestions (in some form) in [1] and [2]. For [2],
   I'm inclined to just avoid enqueuing a task on a shard if the rq it's on
   has nr_running == 0. Or, we can just add his patch to the series
   directly if it turns out that just looking at rq->nr_running is
   insufficient.

[0]: https://lore.kernel.org/all/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
[1]: https://lore.kernel.org/all/20230831104508.7619-3-kprateek.nayak@amd.com/
[2]: https://lore.kernel.org/all/20230831104508.7619-4-kprateek.nayak@amd.com/

Prateek -- what do you think about this? I want to make sure you get
credit for your contributions to this series, so let me know how you'd
like to apply these changes. [1] essentially just improves much of the
logic from [3], so I'm not sure it would make sense to include it as a
separate patch. I'm happy to include a Co-authored-by tag, or to just
explicitly credit your contributions in the commit summary if you'd
prefer that.

[3]: https://lore.kernel.org/all/20230809221218.163894-7-void@manifault.com/

Thanks,
David
