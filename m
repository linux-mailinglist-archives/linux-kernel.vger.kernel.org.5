Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A857A1FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjIONgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjIONgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:36:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC201BEB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:36:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1BE1FB;
        Fri, 15 Sep 2023 06:36:43 -0700 (PDT)
Received: from [10.57.93.60] (unknown [10.57.93.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED193F5A1;
        Fri, 15 Sep 2023 06:36:02 -0700 (PDT)
Message-ID: <ff3a1e32-74c3-56bc-94dc-78d088faf8b7@arm.com>
Date:   Fri, 15 Sep 2023 15:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
To:     Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Valentin,

On 9/15/23 14:00, Valentin Schneider wrote:
> On 14/09/23 23:26, Shrikanth Hegde wrote:
>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>> platform when booting may not have EAS capability, but can do that after.
>>>> For example, changing/registering the cpufreq policy.
>>>>
>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>
>>>
>>
>> Hi Valentin, Thanks for taking a look at this patch.
>>
>>> But why would you write to it in the first place? Or do you mean to use
>>> this as an indicator for userspace that EAS is supported?
>>>
>>
>> Since this sysctl is present and its value being 1, it gives the
>> impression to the user that EAS is supported when it is not.
>> So its an attempt to correct that part.
>>
> 
> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
> supported? And on top of it, prevent all writes when EAS isn't supported
> (perf domains cannot be built, so there would be no point in forcing a
> rebuild that will do nothing).

I think the issue comes from the fact there is no variable representing
whether EAS is supported or not. sched_energy_enabled()/sched_energy_present
tells whether EAS is actively running on the system instead.

So on a system with EAS running, I think what would happen is:
# Disable EAS and set sched_energy_present=0
echo 0 > /proc/sys/kernel/sched_energy_aware

# sched_energy_present==0, so we get -EOPNOTSUPP
echo 1 > /proc/sys/kernel/sched_energy_aware


> 
> I can never remember how to properly use the sysctl API, so that's a very
> crude implementation, but something like so?
> 
> ---
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c089..dadfc5afc4121 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   	if (write && !capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (!sched_energy_enabled()) {
> +		if (write)
> +			return -EOPNOTSUPP;
> +		else {
> +			size_t len;
> +
> +			if (*ppos) {
> +				*lenp = 0;
> +				return 0;
> +			}
> +
> +			len = snprintf((char *)buffer, 3, "0\n");
> +
> +			*lenp = len;
> +			*ppos += len;
> +			return 0;
> +		}
> +	}
> +
>   	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>   	if (!ret && write) {
> -		state = static_branch_unlikely(&sched_energy_present);
> +		state = sched_energy_enabled();
>   		if (state != sysctl_sched_energy_aware)
>   			rebuild_sched_domains_energy();
>   	}
> 

Regards,
Pierre
