Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AEC77B6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjHNKer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjHNKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:34:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22DFC10D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:34:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB6162F4;
        Mon, 14 Aug 2023 03:35:12 -0700 (PDT)
Received: from [10.57.90.230] (unknown [10.57.90.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6F053F6C4;
        Mon, 14 Aug 2023 03:34:28 -0700 (PDT)
Message-ID: <37e36bde-fc70-6d2d-8dec-28e572f618cc@arm.com>
Date:   Mon, 14 Aug 2023 11:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] coresight: trbe: Fix TRBE potential sleep in atomic
 context
To:     Junhao He <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com,
        jonathan.cameron@huawei.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230814093813.19152-2-hejunhao3@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230814093813.19152-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junhao

On 14/08/2023 10:38, Junhao He wrote:
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
>    arm_trbe_remove_coresight_cpu
>      coresight_unregister
>        device_unregister
>          device_del
>            kobject_del
>              __kobject_del
>                sysfs_remove_dir
>                  kernfs_remove
>                    down_write ---------> it may sleep
> 
> Add a helper arm_trbe_disable_cpu() to disable TRBE precpu irq and reset
> per TRBE.
> Simply call arm_trbe_remove_coresight_cpu() directly without useing the
> smp_call_function_single(), which is the same as registering the TRBE
> coresight device.
> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 35 +++++++++++---------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 7720619909d6..ce1e6f537b8d 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1225,6 +1225,17 @@ static void arm_trbe_enable_cpu(void *info)
>   	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>   }
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
>   static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
>   {
>   	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> @@ -1326,18 +1337,12 @@ static void arm_trbe_probe_cpu(void *info)
>   	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
>   }
>   
> -static void arm_trbe_remove_coresight_cpu(void *info)
> +static void arm_trbe_remove_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
>   {
> -	int cpu = smp_processor_id();
> -	struct trbe_drvdata *drvdata = info;
> -	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>   	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
>   
> -	disable_percpu_irq(drvdata->irq);
> -	trbe_reset_local(cpudata);
>   	if (trbe_csdev) {
>   		coresight_unregister(trbe_csdev);
> -		cpudata->drvdata = NULL;
>   		coresight_set_percpu_sink(cpu, NULL);

I am a bit concerned about "resetting" the sink from a different CPU.
Could we instead, schedule a delayed work to unregister the trbe_csdev?


Suzuki


>   	}
>   }
> @@ -1366,8 +1371,12 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
>   {
>   	int cpu;
>   
> -	for_each_cpu(cpu, &drvdata->supported_cpus)
> -		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
> +	for_each_cpu(cpu, &drvdata->supported_cpus) {
> +		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +			smp_call_function_single(cpu, arm_trbe_disable_cpu, drvdata, 1);
> +		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +			arm_trbe_remove_coresight_cpu(drvdata, cpu);
> +	}
>   	free_percpu(drvdata->cpudata);
>   	return 0;
>   }
> @@ -1406,12 +1415,8 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>   
> -	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> -		struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> -
> -		disable_percpu_irq(drvdata->irq);
> -		trbe_reset_local(cpudata);
> -	}
> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +		arm_trbe_disable_cpu(drvdata);
>   	return 0;
>   }
>   

