Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8A77E22A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbjHPNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbjHPNGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:06:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 871D91BFB;
        Wed, 16 Aug 2023 06:06:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6750CD75;
        Wed, 16 Aug 2023 06:07:20 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568C33F6C4;
        Wed, 16 Aug 2023 06:06:36 -0700 (PDT)
Message-ID: <e324df5d-a4c1-43f3-5e45-95dc591085ac@arm.com>
Date:   Wed, 16 Aug 2023 15:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/12] PM: EM: Add RCU mechanism which safely cleans
 the old data
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-10-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-10-lukasz.luba@arm.com>
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
> The EM is going to support runtime modifications of the power data.
> Introduce RCU safe mechanism to clean up the old allocated EM data.
> It also adds a mutex for the EM structure to serialize the modifiers.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index c2f8a0046f8a..4596bfe7398e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -23,6 +23,9 @@
>   */
>  static DEFINE_MUTEX(em_pd_mutex);
>  
> +static void em_cpufreq_update_efficiencies(struct device *dev,
> +					   struct em_perf_state *table);
> +
>  static bool _is_cpu_device(struct device *dev)
>  {
>  	return (dev->bus == &cpu_subsys);
> @@ -104,6 +107,45 @@ static void em_debug_create_pd(struct device *dev) {}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>  
> +static void em_destroy_rt_table_rcu(struct rcu_head *rp)
> +{
> +	struct em_perf_table *runtime_table;
> +
> +	runtime_table = container_of(rp, struct em_perf_table, rcu);
> +	kfree(runtime_table->state);
> +	kfree(runtime_table);
> +}
> +
> +static void em_destroy_tmp_setup_rcu(struct rcu_head *rp)
> +{
> +	struct em_perf_table *runtime_table;
> +
> +	runtime_table = container_of(rp, struct em_perf_table, rcu);
> +	kfree(runtime_table);
> +}

Still don't like that we have to have 2 rcu callbacks here. In case we
could assign default_table to runtime_table in em_create_pd() (and not
just default_table->state to runtime_table->state) IMHO we would only
need one rcu callback?

-->8--

-static void em_destroy_tmp_setup_rcu(struct rcu_head *rp)
-{
-       struct em_perf_table *runtime_table;
-
-       runtime_table = container_of(rp, struct em_perf_table, rcu);
-       kfree(runtime_table);
-}
-
 static void em_perf_runtime_table_set(struct device *dev,
                                      struct em_perf_table *runtime_table)
 {
@@ -136,13 +128,8 @@ static void em_perf_runtime_table_set(struct device *dev,
 
        em_cpufreq_update_efficiencies(dev, runtime_table->state);
 
-       /*
-        * Check if the 'state' array is not actually the one from setup.
-        * If it is then don't free it.
-        */
-       if (tmp->state == pd->default_table->state)
-               call_rcu(&tmp->rcu, em_destroy_tmp_setup_rcu);
-       else
+       /* Don't free default table (inital value of runtime table) */
+       if (tmp != pd->default_table)
                call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
 }
 
@@ -349,7 +336,6 @@ static int em_create_pd(struct device *dev, int nr_states,
                        unsigned long flags)
 {
        struct em_perf_table *default_table;
-       struct em_perf_table *runtime_table;
        struct em_perf_domain *pd;
        struct device *cpu_dev;
        int cpu, ret, num_cpus;
@@ -382,24 +368,15 @@ static int em_create_pd(struct device *dev, int nr_states,
 
        pd->default_table = default_table;
 
-       runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
-       if (!runtime_table) {
-               kfree(default_table);
-               kfree(pd);
-               return -ENOMEM;
-       }
-
        ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
        if (ret) {
                kfree(default_table);
-               kfree(runtime_table);
                kfree(pd);
                return ret;
        }
 
-       /* Re-use temporally (till 1st modification) the memory */
-       runtime_table->state = default_table->state;
-       rcu_assign_pointer(pd->runtime_table, runtime_table);
+       /* Initialize runtime table as default table */
+       rcu_assign_pointer(pd->runtime_table, default_table);
 
        if (_is_cpu_device(dev))
                for_each_cpu(cpu, cpus) {



