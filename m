Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD79797696
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbjIGQN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbjIGQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:13:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C18267D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:48:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D29A1570;
        Thu,  7 Sep 2023 03:22:19 -0700 (PDT)
Received: from [10.57.92.139] (unknown [10.57.92.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A253F67D;
        Thu,  7 Sep 2023 03:21:38 -0700 (PDT)
Message-ID: <26d82927-af2b-b1b8-d57e-3d94c98f9482@arm.com>
Date:   Thu, 7 Sep 2023 12:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
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

Hello Chen,

On 9/1/23 11:49, Chen Yu wrote:
> Hi Shrikanth,
> 
> On 2023-09-01 at 12:22:49 +0530, Shrikanth Hegde wrote:
>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>> some of the architectures. IIUC its meant to either force rebuild the
>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
>>
>> perf domains are not built when there is SMT, or when there is no
>> Asymmetric CPU topologies or when there is no frequency invariance.
>> Since such cases EAS is not set and perf domains are not built. By
>> changing the values of sysctl_sched_energy_aware, its not possible to
>> force build the perf domains. Hence remove this sysctl on such platforms
>> that dont support it. Some of the settings can be changed later
>> such as smt_active by offlining the CPU's, In those cases if
>> build_perf_domains returns true, re-enable the sysctl.
>>
>> Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
>> is set when building the perf domains. Making use of that to find out if
>> the change is happening by sysctl or dynamic system change.
>>
>> Taking different cases:
>> Case1. system while booting has EAS capability, sysctl will be set 1. Hence
>> perf domains will be built if needed. On changing the sysctl to 0, since
>> sched_energy_update is true, perf domains would be freed and sysctl will
>> not be removed. later sysctl is changed to 1, enabling the perf domains
>> rebuild again. Since sysctl is already there, it will skip register.
>>
>> Case2. System while booting doesn't have EAS Capability. Later after system
>> change it becomes capable of EAS. sched_energy_update is false. Though
>> sysctl is 0, will go ahead and try to enable eas. This is the current
>> behaviour. if has_eas  is true, then sysctl will be registered. After
>> that any sysctl change is same as Case1.
>>
> 
> I think this change makes sense. Just one question for case 2,
> sched_energy_update is not strictly tied with sysctl change, right?
> sched_energy_update is true in rebuild_sched_domains_energy().
> rebuild_sched_domains_energy() will not only be invoked by sysctl
> path via sched_energy_aware_handler(), but also by other path, such
> as update_scale_freq_invariant(). If the system boots with EAS capability
> disabled, then it becomes EAS capable due to the frequency invariant
> readiness(cpufreq policy change?), then
> cpufreq_notifier(CPUFREQ_CREATE_POLICY) -> init_amu_fie_callback() ->
> amu_fie_setup() -> opology_set_scale_freq_source() ->
> update_scale_freq_invariant(true) -> rebuild_sched_domains_energy()
> Since sched_energy_update is true, the rebuild of perf domain will be skipped(but
> actually we want to create it) Please correct me if I miss something.
> 

I thought 'sched_energy_update' was here to force rebuilding the
perf_domains instead. If sched_energy_update=1, then it prevents from finding
a pre-existing perf_domain and skipping the perf_domain rebuild, unless I also
missed something:


#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
	/* Build perf. domains: */
	for (i = 0; i < ndoms_new; i++) {
		for (j = 0; j < n && !sched_energy_update; j++) {
			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd) {
				has_eas = true;
				goto match3;
			}
		}
		/* No match - add perf. domains for a new rd */
		has_eas |= build_perf_domains(doms_new[i]);
match3:
		;
	}
	sched_energy_set(has_eas);
#endif
