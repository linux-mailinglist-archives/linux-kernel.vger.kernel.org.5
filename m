Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492587E8123
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjKJSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjKJSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:23:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0E0A9EE0;
        Fri, 10 Nov 2023 00:30:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73B9B106F;
        Fri, 10 Nov 2023 00:31:43 -0800 (PST)
Received: from [192.168.1.25] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 221603F6C4;
        Fri, 10 Nov 2023 00:30:51 -0800 (PST)
Message-ID: <00ce01bf-1612-46cd-926d-ac283cfddff9@arm.com>
Date:   Fri, 10 Nov 2023 09:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] consolidate and cleanup CPU capacity
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a CPPC platform + EM/EAS (but without AMU):
Tested-by: Pierre Gondois <pierre.gondois@arm.com>

On 11/9/23 11:14, Vincent Guittot wrote:
> This is the 1st part of consolidating how the max compute capacity is
> used in the scheduler and how we calculate the frequency for a level of
> utilization.
> 
> Fix some unconsistancy when computing frequency for an utilization. There
> can be a mismatch between energy model and schedutil.
> 
> Next step will be to make a difference between the original
> max compute capacity of a CPU and what is currently available when
> there is a capping applying forever (i.e. seconds or more).
> 
> Changes since v5:
> - remove useless return in freq_inv_set_max_ratio()
> - Add tags
> 
> Changes since v4:
> - Capitalize the verb in subject
> - Remove usless parentheses in cppc_get_dmi_max_khz()
> - Use freq_ref pattern everywhere
> - Fix MHz / kHz units conversion for cppc_cpufreq
> - Move default definition of arch_scale_freq_ref() in
>    include/linux/sched/topology.h beside arch_scale_cpu_capacity
>    which faces similar default declaration behavior. This location covers
>    all cases with arch and CONFIG_* which was not the case with previous
>    attempts.
> 
> Changes since v3:
> - Split patch 5 cpufreq/cppc
> - Fix topology_init_cpu_capacity_cppc()
> - Fix init if AMU ratio
> - Added some tags
> 
> Changes since v2:
> - Remove the 1st patch which has been queued in tip
> - Rework how to initialize the reference frequency for cppc_cpufreq and
>    change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
> - Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
>    of the AMU ratio to be done when intializing cpu capacity and
>    capacity_ref_freq
> - Added some tags
> 
> Changes since v1:
> - Fix typos
> - Added changes in cpufreq to use arch_scale_freq_ref() when calling
>    arch_set_freq_scale (patch 3).
> - arch_scale_freq_ref() is always defined and returns 0 (as proposed
>    by Ionela) when not defined by the arch. This simplifies the code with
>    the addition of patch 3.
> - Simplify Energy Model which always uses arch_scale_freq_ref(). The
>    latter returns 0 when not defined by arch instead of last item of the
>    perf domain. This is not a problem because the function is only defined
>    for compilation purpose in this case and we don't care about the
>    returned value. (patch 5)
> - Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
> - Added reviewed tag for patch 1 which got a minor change but not for
>    others as I did some changes which could make previous reviewed tag
>    no more relevant.
> 
> Vincent Guittot (7):
>    topology: Add a new arch_scale_freq_reference
>    cpufreq: Use the fixed and coherent frequency for scaling capacity
>    cpufreq/schedutil: Use a fixed reference frequency
>    energy_model: Use a fixed reference frequency
>    cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
>    cpufreq/cppc: Set the frequency used for computing the capacity
>    arm64/amu: Use capacity_ref_freq to set AMU ratio
> 
>   arch/arm/include/asm/topology.h   |   1 +
>   arch/arm64/include/asm/topology.h |   1 +
>   arch/arm64/kernel/topology.c      |  26 +++---
>   arch/riscv/include/asm/topology.h |   1 +
>   drivers/acpi/cppc_acpi.c          | 104 ++++++++++++++++++++++
>   drivers/base/arch_topology.c      |  56 ++++++++----
>   drivers/cpufreq/cppc_cpufreq.c    | 139 ++++--------------------------
>   drivers/cpufreq/cpufreq.c         |   4 +-
>   include/acpi/cppc_acpi.h          |   2 +
>   include/linux/arch_topology.h     |   8 ++
>   include/linux/cpufreq.h           |   1 +
>   include/linux/energy_model.h      |   6 +-
>   include/linux/sched/topology.h    |   8 ++
>   kernel/sched/cpufreq_schedutil.c  |  26 +++++-
>   14 files changed, 224 insertions(+), 159 deletions(-)
> 
