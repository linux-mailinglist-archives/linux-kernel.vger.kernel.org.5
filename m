Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CB7DBF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjJ3Rp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJ3Rp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:45:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAF7BC4;
        Mon, 30 Oct 2023 10:45:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264DAFEC;
        Mon, 30 Oct 2023 10:46:35 -0700 (PDT)
Received: from [10.57.7.2] (unknown [10.57.7.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B0E3F738;
        Mon, 30 Oct 2023 10:45:50 -0700 (PDT)
Message-ID: <83d6a790-3d18-4922-850b-b60e88761786@arm.com>
Date:   Mon, 30 Oct 2023 17:46:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     wyes.karny@amd.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, vschneid@redhat.com, bristot@redhat.com,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, beata.michalska@arm.com,
        linux-kernel@vger.kernel.org, qyousef@layalina.io,
        viresh.kumar@linaro.org, mingo@redhat.com, mgorman@suse.de
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231026170913.32605-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 10/26/23 18:09, Vincent Guittot wrote:
> The current method to take into account uclamp hints when estimating the
> target frequency can end into situation where the selected target
> frequency is finally higher than uclamp hints whereas there are no real
> needs. Such cases mainly happen because we are currently mixing the
> traditional scheduler utilization signal with the uclamp performance
> hints. By adding these 2 metrics, we loose an important information when
> it comes to select the target frequency and we have to make some
> assumptions which can't fit all cases.
> 
> Rework the interface between the scheduler and schedutil governor in order
> to propagate all information down to the cpufreq governor.
> 
> effective_cpu_util() interface changes and now returns the actual
> utilization of the CPU with 2 optional inputs:
> - The minimum performance for this CPU; typically the capacity to handle
>    the deadline task and the interrupt pressure. But also uclamp_min
>    request when available.
> - The maximum targeting performance for this CPU which reflects the
>    maximum level that we would like to not exceed. By default it will be
>    the CPU capacity but can be reduced because of some performance hints
>    set with uclamp. The value can be lower than actual utilization and/or
>    min performance level.

You have probably missed my question in the last v1 patch set.

The description above needs a bit of clarification, since looking at the
patches some dark corners are introduced IMO:

Currently, we have a less aggressive power saving policy than this
proposal.

The questions:
What if the PD has 4 CPUs, the max util found is 500 and is from a CPU
w/ uclamp_max, but there is another CPU with normal utilization 499?
What should be the final frequency for that PD?

In current design, where we care more about 'delivered performance
to the tasks' than power saving, the +20% would be applied for the
frequency. Therefore if that CPU with 499 util doesn't have uclamp_max,
it would get a decent amount of idle time for its tasks (to compensate
some workload variation).

Regards,
Lukasz
