Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C26377E232
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHPNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbjHPNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:08:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0439126BB;
        Wed, 16 Aug 2023 06:08:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011AED75;
        Wed, 16 Aug 2023 06:09:27 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208113F6C4;
        Wed, 16 Aug 2023 06:08:42 -0700 (PDT)
Message-ID: <2b54b79f-5313-497d-55ae-1ffa1f4c6bf5@arm.com>
Date:   Wed, 16 Aug 2023 15:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/12] Documentation: EM: Update with runtime
 modification design
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-13-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-13-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:
> Add a new section 'Design' which covers the information about Energy
> Model. It contains the design decisions, describes models and how they
> reflect the reality. Add description of the basic const. EM. Change the

Nit pick: Can we just use one tag for this EM? I would propose
'default'. So code and doc are aligned.

> other section IDs. Add documentation bit for the new feature which
> allows o modify the EM in runtime.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 150 +++++++++++++++++++++++++--
>  1 file changed, 140 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index ef341be2882b..01d4d806a123 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -72,16 +72,70 @@ required to have the same micro-architecture. CPUs in different performance
>  domains can have different micro-architectures.
>  
>  
> -2. Core APIs
> +2. Design
> +-----------------
> +
> +2.1 Basic EM
> +^^^^^^^^^^^^
> +
> +The basic EM is built around constant power information for each performance
> +state, which is accessible in: 'dev->em_pd->default_table->state'. This model
> +can be derived based on power measurements of the device e.g. CPU while
> +running some benchmark. The benchmark might be integer heavy or floating point
> +computation with a data set fitting into the CPU cache or registers. Bare in
> +mind that this model might not cover all possible workloads running on CPUs.
> +Thus, please run a few different benchmarks and verify with some real
> +workloads your power model values. The power variation due to the workload
> +instruction mix and data set is not modeled. The static power, which can
> +change during runtime due to variation of SOC temperature, is not modeled in
> +this basic EM.

s/in this basic EM/either

> +
> +2.2 Runtime modifiable EM
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +To better reflect power variation due to static power (leakage) the EM
> +supports runtime modifications of the power values. The mechanism relies on
> +RCU to free the modifiable EM perf_state table memory. Its user, the task
> +scheduler, also uses RCU to access this memory. The EM framework is
> +responsible for allocating the new memory for the modifiable EM perf_state
> +table. The old memory is freed automatically using RCU callback mechanism.
> +This design decision is made based on task scheduler using that data and
> +to prevent wrong usage of kernel modules if they would be responsible for the
> +memory management.
> +
> +There are two structures with the performance state tables in the EM:
> +a) dev->em_pd->default_table
> +b) dev->em_pd->runtime_table
> +They both point to the same memory location via:
> +'em_perf_table::state' pointer, until the first modification of the values
> +This should save memory on platforms which would never modify the EM. When
> +the first modification is made the 'default_table' (a) contains the old
> +EM which was created during the setup. The modified EM is available in the
> +'runtime_table' (b).
> +
> +Only EAS uses the 'runtime_table' and benefits from the updates to the
> +EM values. Other sub-systems (thermal, powercap) use the 'default_table' (a)
> +since they don't need such optimization.

The interested user immediately ask WHY here. Maybe skip this last part
of the sentence in case you don't want to provide the WHY here.

> +The drivers which want to modify the EM values are protected from concurrent

Does it have to be a driver?

> +access using a mutex. Therefore, the drivers must use sleeping context when
> +they want to modify the EM. The runtime modifiable EM might also be used for
> +better reflecting real workload scenarios, e.g. when they pop-up on the screen

I would describe this a little bit more generic. The current description
seems to be linked to Android foreground processes.

> +and will run for longer period, such as: games, video recoding or playing,
> +video calls, etc. It is up to the platform engineers to experiment and choose
> +the right approach for their device.

Maybe you can say here that with the runtime modifiable EM we switch
from a 'single and during the entire runtime static EM' (system
property) design to a 'single EM which can be changed during runtime
according e.g. to the workload' (system and workload property) design.

[...]

> +3.4 Runtime modifications
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Drivers willing to modify the EM at runtime should use the following API::
> +
>  
> +  int em_dev_update_perf_domain(struct device *dev,
> +			struct em_data_callback *cb, void *priv);
>  
> -2.4 Description details of this API
> +Drivers must provide a callback .update_power() returning power value for each
> +performance state. The callback function provided by the driver is free
> +to fetch data from any relevant location (DT, firmware, ...) or sensor.
> +The .update_power() callback is called by the EM for each performance state to
> +provide new power value. In the Section 4.2 there is an example driver
> +which shows simple implementation of this mechanism. The callback can be
> +declared with EM_UPDATE_CB() macro. The caller of that callback also passes
> +a private void pointer back to the driver which tries to update EM.
> +It is useful and helps to maintain the consistent context for all performance
> +state calls for a given EM.
> +The artificial EM also supports runtime modifications. For this type of EM
> +there is a need to provide one more callback: .get_cost(). The .get_cost()
> +returns the cost value for each performance state, which better reflects the
> +efficiency of the CPUs which use artificial EM. Those two callbacks:
> +.update_power() and get .get_cost() can be declared with one macro
> +EM_ADV_UPDATE_CB() and then passed to the em_dev_update_perf_domain().

Can't find EM_ADV_UPDATE_CB().

[...]

