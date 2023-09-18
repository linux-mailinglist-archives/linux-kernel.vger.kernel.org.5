Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48BA7A560E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjIRXEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRXEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:04:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC38DB0;
        Mon, 18 Sep 2023 16:04:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 922DA1FB;
        Mon, 18 Sep 2023 16:04:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEAC3F5A1;
        Mon, 18 Sep 2023 16:04:08 -0700 (PDT)
Message-ID: <ebc8f4cd-1ac6-e7c8-8e20-53bca964ce56@arm.com>
Date:   Tue, 19 Sep 2023 01:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, vschneid@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
References: <20230918112937.493352-1-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230918112937.493352-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 13:29, Pierre Gondois wrote:
> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
> When moving to/from the schedutil governor, sched domains must be
> rebuilt to allow re-evaluating the enablement conditions of EAS.
> This is done through sched_cpufreq_governor_change().
> 
> Having a cpufreq governor assumes having a cpufreq driver running.
> Inserting/removing a cpufreq driver should trigger a re-evaluation
> of EAS enablement conditions, avoiding to see EAS enabled when
> removing a running cpufreq driver.
> 
> Add a sched_cpufreq_governor_change() call in cpufreq driver removal
> path.

Rebuilding SDs when inserting the driver is already covered by

  cpufreq_online()
    cpufreq_set_policy()
      sched_cpufreq_governor_change()
        if (old or new gov eq. schedutil)
          schedule_work(&rebuild_sd_work)

So what's missing is only a sched_cpufreq_governor_change() call when
removing the driver, right?

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..0a4979c34fd1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1673,6 +1673,8 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>  		cpufreq_driver->exit(policy);
>  		policy->freq_table = NULL;
>  	}
> +
> +	sched_cpufreq_governor_change(policy, policy->governor);
>  }
>  
>  static int cpufreq_offline(unsigned int cpu)

