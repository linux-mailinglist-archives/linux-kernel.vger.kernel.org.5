Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104507AA210
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjIUVMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIUVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:11:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E3DA0C3C;
        Thu, 21 Sep 2023 10:57:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B63E61595;
        Thu, 21 Sep 2023 03:12:48 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366B93F59C;
        Thu, 21 Sep 2023 03:12:11 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:12:09 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 0/4] consolidate and cleanup CPU capacity
Message-ID: <ZQwW+XoOFqvyuQ63@arm.com>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Sep 2023 at 15:03:08 (+0200), Vincent Guittot wrote:
> This is the 1st part of consolidating how the max compute capacity is
> used in the scheduler and how we calculate the frequency for a level of
> utilization.
> 
> Fix some unconsistancy when computing frequency for an utilization. There
> can be a mismatch between energy model and schedutil.

There are a few more pieces of functionality that would be worth
consolidating in this set as well, if you'd like to consider them:

- arch_set_freq_scale() still uses policy->cpuinfo.max_freq. It might be
  good to use the boot time stored max_freq here as well. Given that
  arch_scale_cpu_capacity() would be based on that stored value, if
  arch_scale_freq_capacity() ends up using a different value, it could
  have interesting effects on the utilization signals in case of
  boosting.

- As Pierre mentioned in a previous comment, there is already a
  cpufreq_get_hw_max_freq() weak function that returns
  policy->cpuinfo.max_freq and it's only used at boot time by 
  the setup code for AMU use for frequency invariance. I'm tempted to
  suggest to use this to initialize what is now "freq_factor" as my
  intention when I created that function was to provide platform
  providers with the possibility to implement their own and decide on
  the frequency they choose as their maximum. This could have been an
  arch_ function as well, but as you mentioned before, mobile and server
  platforms might want to choose different maximum values even if they
  are using the same architecture.

Thanks,
Ionela.

> 
> Next step will be to make a difference between the original
> max compute capacity of a CPU and what is currently available when
> there is a capping applying forever (i.e. seconds or more).
> 
> Vincent Guittot (4):
>   sched: consolidate and cleanup access to CPU's max compute capacity
>   topology: add a new arch_scale_freq_reference
>   cpufreq/schedutil: use a fixed reference frequency
>   energy_model: use a fixed reference frequency
> 
>  arch/arm/include/asm/topology.h   |  1 +
>  arch/arm64/include/asm/topology.h |  1 +
>  arch/riscv/include/asm/topology.h |  1 +
>  drivers/base/arch_topology.c      |  9 +++------
>  include/linux/arch_topology.h     |  7 +++++++
>  include/linux/energy_model.h      | 20 +++++++++++++++++---
>  kernel/sched/core.c               |  2 +-
>  kernel/sched/cpudeadline.c        |  2 +-
>  kernel/sched/cpufreq_schedutil.c  | 29 +++++++++++++++++++++++++++--
>  kernel/sched/deadline.c           |  4 ++--
>  kernel/sched/fair.c               | 18 ++++++++----------
>  kernel/sched/rt.c                 |  2 +-
>  kernel/sched/sched.h              |  6 ------
>  kernel/sched/topology.c           |  7 +++++--
>  14 files changed, 75 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
