Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF077F103
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbjHQHOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbjHQHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:14:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89CD12D62
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:14:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F316ED75;
        Thu, 17 Aug 2023 00:14:41 -0700 (PDT)
Received: from [10.163.56.113] (unknown [10.163.56.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969633F64C;
        Thu, 17 Aug 2023 00:13:57 -0700 (PDT)
Message-ID: <80ef7a87-6adf-27bc-43ae-05ae5680e418@arm.com>
Date:   Thu, 17 Aug 2023 12:43:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] coresight: trbe: Fix TRBE potential sleep in
 atomic context
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        mike.leach@linaro.org, linuxarm@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230816141008.535450-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Junhao,

On 8/16/23 19:40, Suzuki K Poulose wrote:
> From: Junhao He <hejunhao3@huawei.com>
> 
> smp_call_function_single() will allocate an IPI interrupt vector to
> the target processor and send a function call request to the interrupt
> vector. After the target processor receives the IPI interrupt, it will
> execute arm_trbe_remove_coresight_cpu() call request in the interrupt
> handler.
> 
> According to the device_unregister() stack information, if other process
> is useing the device, the down_write() may sleep, and trigger deadlocks
> or unexpected errors.
> 
>   arm_trbe_remove_coresight_cpu
>     coresight_unregister
>       device_unregister
>         device_del
>           kobject_del
>             __kobject_del
>               sysfs_remove_dir
>                 kernfs_remove
>                   down_write ---------> it may sleep

But how did you really detect this problem ? Does this show up as an warning when
you enable lockdep debug ? OR it really happened during a real workload execution
followed by TRBE module unload. Although the problem seems plausible (which needs
fixing), just wondering how did we trigger this.

> 
> Add a helper arm_trbe_disable_cpu() to disable TRBE precpu irq and reset
> per TRBE.
> Simply call arm_trbe_remove_coresight_cpu() directly without useing the
> smp_call_function_single(), which is the same as registering the TRBE
> coresight device.
> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Link: https://lore.kernel.org/r/20230814093813.19152-2-hejunhao3@huawei.com
> [ Remove duplicate cpumask checks during removal ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 33 +++++++++++---------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 7720619909d6..025f70adee47 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1225,6 +1225,17 @@ static void arm_trbe_enable_cpu(void *info)
>  	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>  }
>  
> +static void arm_trbe_disable_cpu(void *info)
> +{
> +	struct trbe_drvdata *drvdata = info;
> +	struct trbe_cpudata *cpudata = this_cpu_ptr(drvdata->cpudata);
> +
> +	disable_percpu_irq(drvdata->irq);
> +	trbe_reset_local(cpudata);
> +	cpudata->drvdata = NULL;
> +}
> +
> +
>  static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
>  {
>  	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> @@ -1326,18 +1337,12 @@ static void arm_trbe_probe_cpu(void *info)
>  	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
>  }
>  
> -static void arm_trbe_remove_coresight_cpu(void *info)
> +static void arm_trbe_remove_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
>  {
> -	int cpu = smp_processor_id();
> -	struct trbe_drvdata *drvdata = info;
> -	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>  	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
>  
> -	disable_percpu_irq(drvdata->irq);
> -	trbe_reset_local(cpudata);
>  	if (trbe_csdev) {
>  		coresight_unregister(trbe_csdev);
> -		cpudata->drvdata = NULL;
>  		coresight_set_percpu_sink(cpu, NULL);
>  	}
>  }
> @@ -1366,8 +1371,10 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
>  {
>  	int cpu;
>  
> -	for_each_cpu(cpu, &drvdata->supported_cpus)
> -		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
> +	for_each_cpu(cpu, &drvdata->supported_cpus) {
> +		smp_call_function_single(cpu, arm_trbe_disable_cpu, drvdata, 1);
> +		arm_trbe_remove_coresight_cpu(drvdata, cpu);
> +	}
>  	free_percpu(drvdata->cpudata);
>  	return 0;
>  }
> @@ -1406,12 +1413,8 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>  
> -	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> -		struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> -
> -		disable_percpu_irq(drvdata->irq);
> -		trbe_reset_local(cpudata);
> -	}
> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +		arm_trbe_disable_cpu(drvdata);

This code hunk seems unrelated to the context here other than just finding another use case
for arm_trbe_disable_cpu(). The problem is - arm_trbe_disable_cpu() resets cpudata->drvdata
which might not get re-initialized back in arm_trbe_cpu_startup(), as there will still be a
per cpu sink associated as confirmed with coresight_get_percpu_sink(). I guess it might be
better to drop this change and just keep everything limited to SMP IPI callback reworking in
arm_trbe_remove_coresight().

>  	return 0;
>  }
>  
