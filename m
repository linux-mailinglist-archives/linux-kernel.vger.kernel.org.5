Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507C7A5453
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjIRUrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:46:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E672310D;
        Mon, 18 Sep 2023 13:46:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D071FB;
        Mon, 18 Sep 2023 13:47:30 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBEA53F59C;
        Mon, 18 Sep 2023 13:46:49 -0700 (PDT)
Message-ID: <198067f1-218c-e2f3-cf05-9042269a00bf@arm.com>
Date:   Mon, 18 Sep 2023 22:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org>
 <8cfa9edb-67f9-80f9-0a5c-1920f95b338a@arm.com>
 <CAKfTPtDxJjj6wtpRnLjUi65j+5sQyYcHsQzbd+eSQCf4MVOiWA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDxJjj6wtpRnLjUi65j+5sQyYcHsQzbd+eSQCf4MVOiWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 15:35, Vincent Guittot wrote:
> On Thu, 14 Sept 2023 at 23:07, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 01/09/2023 15:03, Vincent Guittot wrote:

[...]

>>> +#ifdef arch_scale_freq_ref
>>> +static __always_inline
>>> +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
>>
>> Why is this function named with the arch prefix?
>>
>> So far we have 5 arch functions (arch_scale_freq_tick() <->
>> arch_scale_freq_ref()) and e.g. Arm/Arm64 defines them with there
>> topology_foo implementations.
>>
>> Isn't arch_scale_freq_ref_em() (as well as arch_scale_freq_ref_policy())
>> different in this sense and so a proper EM function which should
>> manifest in its name?
> 
> arch_scale_freq_ref_em() is there to handle cases where
> arch_scale_freq_ref() is not defined by arch. I keep arch_ prefix
> because this should be provided by architecture which wants to use EM.

That's correct, x86_64 with CONFIG_ENERGY_MODEL=y needs
arch_scale_freq_ref_em() returning highest perf_state of the perf_domain.
But this function as opposed to arch_scale_freq_ref() does not have to
be provided by the arch itself. It's provided by the EM instead.
That's why my doubt whether it should be named arch_scale_freq_ref_em().

> In the case of EM, it's only there for allyes|randconfig on arch that
> doesn't use arch_topology.c like x86_64

[...]

>>> @@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>>        */
>>>       cpu = cpumask_first(to_cpumask(pd->cpus));
>>>       scale_cpu = arch_scale_cpu_capacity(cpu);
>>> -     ps = &pd->table[pd->nr_perf_states - 1];
>>> +     ref_freq = arch_scale_freq_ref_em(cpu, pd);
>>
>> Why not using existing `unsigned long freq` here like in schedutil's
>> get_next_freq()?
> 
> Find it easier to read and understand and will not make any difference
> in the compiled code

True but I thought it's easier to be able to detect the functional
similarity between em_cpu_energy() (*) and get_next_freq().

freq = arch_scale_freq_ref_{policy,em}({policy,(cpu, pd)});
... (in case of *)
freq = map_util_freq(util, freq, max);

Just a nitpick ...

[...]
