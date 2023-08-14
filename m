Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040D77C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjHNWrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjHNWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:47:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5717BA2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:47:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E411063;
        Mon, 14 Aug 2023 15:48:27 -0700 (PDT)
Received: from [10.57.90.230] (unknown [10.57.90.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008533F6C4;
        Mon, 14 Aug 2023 15:47:42 -0700 (PDT)
Message-ID: <2b69bd4e-5ef4-16c7-f908-7c70187e12b6@arm.com>
Date:   Mon, 14 Aug 2023 23:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] coresight: core: Fix multiple free TRBE platform data
 resource
To:     Junhao He <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com,
        jonathan.cameron@huawei.com, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230814093813.19152-3-hejunhao3@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230814093813.19152-3-hejunhao3@huawei.com>
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

+ James Clark

On 14/08/2023 10:38, Junhao He wrote:
> Current the TRBE driver supports matching TRBE platform device through
> id_table. The ACPI created a dummy TRBE platform device inside
> drivers/perf/arm_pmu_acpi.c. So the TRBE platform driver will probe only
> once and allocate just one TRBE platform data resource.
> 
> If the system supports the TRBE feature, Each CPU in the systems can
> have at least one TRBE present, and the coresight_unregister gets called
> multiple times, once for each of them.
> Therefore, when unregister TRBE coresight devices, the TRBE platform data
> resource will multiple free in function coresight_unregister.
> 
> root@localhost:# insmod coresight-trbe.ko
> root@localhost:# rmmod coresight-trbe.ko
> [  423.455932] ------------[ cut here ]------------
> [  423.461987] WARNING: CPU: 1 PID: 0 at drivers/base/devres.c:1064 devm_kfree+0x88/0x98
> [  423.483821] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O       6.5.0-rc4+ #1
> [  423.505842] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> ...
> [  423.601301] Call trace:
> [  423.604202]  devm_kfree+0x88/0x98
> [  423.608369]  coresight_release_platform_data+0xb8/0xe0 [coresight]
> [  423.616589]  coresight_unregister+0x120/0x170 [coresight]
> [  423.623533]  arm_trbe_remove_coresight_cpu+0x70/0xa0 [coresight_trbe]
> [  423.631082]  __flush_smp_call_function_queue+0x1e4/0x4e0
> [  423.637471]  generic_smp_call_function_single_interrupt+0x1c/0x30
> [  423.644796]  ipi_handler+0x90/0x278
> [  423.648992]  handle_percpu_devid_irq+0x90/0x250
> [  423.654636]  generic_handle_domain_irq+0x34/0x58
> [  423.659786]  gic_handle_irq+0x12c/0x270
> [  423.664039]  call_on_irq_stack+0x24/0x30
> [  423.668452]  do_interrupt_handler+0x88/0x98
> [  423.673027]  el1_interrupt+0x48/0xe8
> [  423.677413]  el1h_64_irq_handler+0x18/0x28
> [  423.681781]  el1h_64_irq+0x78/0x80
> [  423.685550]  default_idle_call+0x5c/0x180
> [  423.689855]  do_idle+0x25c/0x2c0
> [  423.694196]  cpu_startup_entry+0x2c/0x40
> [  423.698373]  secondary_start_kernel+0x144/0x188
> [  423.703920]  __secondary_switched+0xb8/0xc0
> [  423.708972] ---[ end trace 0000000000000000 ]---
> [  423.729209] ------------[ cut here ]------------
> ...
> [  423.735217] WARNING: CPU: 2 PID: 40 at drivers/base/devres.c:1064 devm_kfree+0x88/0x98
> ...
> [  424.012385] WARNING: CPU: 3 PID: 0 at drivers/base/devres.c:1064 devm_kfree+0x88/0x98
> ...
> 
> This patch does the following:
> 1.TRBE coresight devices do not need regular connections information, We
>    can free connections resource when the nr_conns is valid.
> 2.And we can ignore the free platform data resource, it will be
>    automatically free in platform_driver_unregister().

Do we need a Fixes tag here ?

> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 118fcf27854d..c6f7889d1b4d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1555,9 +1555,10 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   		conns[i]->dest_fwnode = NULL;
>   		devm_kfree(dev, conns[i]);
>   	}
> -	devm_kfree(dev, pdata->out_conns);
> -	devm_kfree(dev, pdata->in_conns);
> -	devm_kfree(dev, pdata);
> +	if (pdata->nr_outconns)
> +		devm_kfree(dev, pdata->out_conns);
> +	if (pdata->nr_inconns)
> +		devm_kfree(dev, pdata->in_conns);

These allocations are made on the parent device and that
may never get unregistered (e.g., AMBA device, platform device,
stay forever, even when the "coresight" modules are unloaded).
Thus the memory will be left unused, literally leaking.
This specific devm_kfree() was added to fix that. May be we should fix
this in the TRBE driver to use separate pdata for the TRBE device
instances.

Suzuki

>   	if (csdev)
>   		coresight_remove_conns_sysfs_group(csdev);
>   }

