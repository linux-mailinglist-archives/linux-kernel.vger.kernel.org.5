Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D477E24F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbjHPNON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbjHPNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:13:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E30D91BFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:13:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95E9D75;
        Wed, 16 Aug 2023 06:14:22 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134B33F6C4;
        Wed, 16 Aug 2023 06:13:39 -0700 (PDT)
Message-ID: <a5a01257-f208-5dd8-bdb3-63c5578adf59@arm.com>
Date:   Wed, 16 Aug 2023 14:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] coresight: core: Fix multiple free TRBE platform data
 resource
Content-Language: en-US
To:     hejunhao <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com,
        jonathan.cameron@huawei.com, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230814093813.19152-3-hejunhao3@huawei.com>
 <2b69bd4e-5ef4-16c7-f908-7c70187e12b6@arm.com>
 <68f16bb1-53ed-b8b9-812e-6d3be40a5bde@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <68f16bb1-53ed-b8b9-812e-6d3be40a5bde@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 12:38, hejunhao wrote:
> Hi, Suzuki
> 
> 
> On 2023/8/15 6:47, Suzuki K Poulose wrote:
>> + James Clark
>>
>> On 14/08/2023 10:38, Junhao He wrote:
>>> Current the TRBE driver supports matching TRBE platform device through
>>> id_table. The ACPI created a dummy TRBE platform device inside
>>> drivers/perf/arm_pmu_acpi.c. So the TRBE platform driver will probe only
>>> once and allocate just one TRBE platform data resource.
>>>
>>> If the system supports the TRBE feature, Each CPU in the systems can
>>> have at least one TRBE present, and the coresight_unregister gets called
>>> multiple times, once for each of them.
>>> Therefore, when unregister TRBE coresight devices, the TRBE platform 
>>> data
>>> resource will multiple free in function coresight_unregister.
>>>
>>> root@localhost:# insmod coresight-trbe.ko
>>> root@localhost:# rmmod coresight-trbe.ko
>>> [  423.455932] ------------[ cut here ]------------
>>> [  423.461987] WARNING: CPU: 1 PID: 0 at drivers/base/devres.c:1064 
>>> devm_kfree+0x88/0x98
>>> [  423.483821] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G O       
>>> 6.5.0-rc4+ #1
>>> [  423.505842] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS 
>>> BTYPE=--)
>>> ...
>>> [  423.601301] Call trace:
>>> [  423.604202]  devm_kfree+0x88/0x98
>>> [  423.608369]  coresight_release_platform_data+0xb8/0xe0 [coresight]
>>> [  423.616589]  coresight_unregister+0x120/0x170 [coresight]
>>> [  423.623533]  arm_trbe_remove_coresight_cpu+0x70/0xa0 [coresight_trbe]
>>> [  423.631082]  __flush_smp_call_function_queue+0x1e4/0x4e0
>>> [  423.637471] generic_smp_call_function_single_interrupt+0x1c/0x30
>>> [  423.644796]  ipi_handler+0x90/0x278
>>> [  423.648992]  handle_percpu_devid_irq+0x90/0x250
>>> [  423.654636]  generic_handle_domain_irq+0x34/0x58
>>> [  423.659786]  gic_handle_irq+0x12c/0x270
>>> [  423.664039]  call_on_irq_stack+0x24/0x30
>>> [  423.668452]  do_interrupt_handler+0x88/0x98
>>> [  423.673027]  el1_interrupt+0x48/0xe8
>>> [  423.677413]  el1h_64_irq_handler+0x18/0x28
>>> [  423.681781]  el1h_64_irq+0x78/0x80
>>> [  423.685550]  default_idle_call+0x5c/0x180
>>> [  423.689855]  do_idle+0x25c/0x2c0
>>> [  423.694196]  cpu_startup_entry+0x2c/0x40
>>> [  423.698373]  secondary_start_kernel+0x144/0x188
>>> [  423.703920]  __secondary_switched+0xb8/0xc0
>>> [  423.708972] ---[ end trace 0000000000000000 ]---
>>> [  423.729209] ------------[ cut here ]------------
>>> ...
>>> [  423.735217] WARNING: CPU: 2 PID: 40 at drivers/base/devres.c:1064 
>>> devm_kfree+0x88/0x98
>>> ...
>>> [  424.012385] WARNING: CPU: 3 PID: 0 at drivers/base/devres.c:1064 
>>> devm_kfree+0x88/0x98
>>> ...
>>>
>>> This patch does the following:
>>> 1.TRBE coresight devices do not need regular connections information, We
>>>    can free connections resource when the nr_conns is valid.
>>> 2.And we can ignore the free platform data resource, it will be
>>>    automatically free in platform_driver_unregister().
>>
>> Do we need a Fixes tag here ?
> 
> Yes, I will do that.
> 
>>>
>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>> b/drivers/hwtracing/coresight/coresight-core.c
>>> index 118fcf27854d..c6f7889d1b4d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1555,9 +1555,10 @@ void coresight_release_platform_data(struct 
>>> coresight_device *csdev,
>>>           conns[i]->dest_fwnode = NULL;
>>>           devm_kfree(dev, conns[i]);
>>>       }
>>> -    devm_kfree(dev, pdata->out_conns);
>>> -    devm_kfree(dev, pdata->in_conns);
>>> -    devm_kfree(dev, pdata);
>>> +    if (pdata->nr_outconns)
>>> +        devm_kfree(dev, pdata->out_conns);
>>> +    if (pdata->nr_inconns)
>>> +        devm_kfree(dev, pdata->in_conns);
>>
>> These allocations are made on the parent device and that
>> may never get unregistered (e.g., AMBA device, platform device,
>> stay forever, even when the "coresight" modules are unloaded).
>> Thus the memory will be left unused, literally leaking.
>> This specific devm_kfree() was added to fix that. May be we should fix
>> this in the TRBE driver to use separate pdata for the TRBE device
>> instances.
>>
>> Suzuki
> 
> If we fix this with minimal changes, I think it is possible to add a check
> and not free pdata if it is TRBE?
> 
>      if (csdev->subtype.sink_subtype != 
> CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM)
>          devm_kfree(dev, pdata);
> 
> Then free pdata in the end of arm_trbe_remove_coresight().

It is much nicer to do something like :


--8>--


coresight: trbe: Allocate platform data per device

Coresight TRBE driver shares a single platform data (which is empty btw).
However, with the commit 4e8fe7e5c3a5
("coresight: Store pointers to connections rather than an array of them")
the coresight core would free up the pdata, resulting in multiple attempts
to free the same pdata for TRBE instances. Fix this by allocating a 
pdata per
coresight_device.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Reported-by: Junhao He <hejunhao3@huawei.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
  drivers/hwtracing/coresight/coresight-trbe.c | 15 ++++++++-------
  1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c 
b/drivers/hwtracing/coresight/coresight-trbe.c
index 025f70adee47..fbab2bb4db38 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1255,10 +1255,17 @@ static void 
arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
  	if (!desc.name)
  		goto cpu_clear;

+	/*
+	 * TRBE doesn't have any connections described via firmware. Instead
+	 * we register the trbe instance as per-cpu sink.
+	 */
+	desc.pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(desc.pdata))
+		goto cpu_clear;
+
  	desc.type = CORESIGHT_DEV_TYPE_SINK;
  	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
  	desc.ops = &arm_trbe_cs_ops;
-	desc.pdata = dev_get_platdata(dev);
  	desc.groups = arm_trbe_groups;
  	desc.dev = dev;
  	trbe_csdev = coresight_register(&desc);
@@ -1482,7 +1489,6 @@ static void arm_trbe_remove_irq(struct 
trbe_drvdata *drvdata)

  static int arm_trbe_device_probe(struct platform_device *pdev)
  {
-	struct coresight_platform_data *pdata;
  	struct trbe_drvdata *drvdata;
  	struct device *dev = &pdev->dev;
  	int ret;
@@ -1497,12 +1503,7 @@ static int arm_trbe_device_probe(struct 
platform_device *pdev)
  	if (!drvdata)
  		return -ENOMEM;

-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-
  	dev_set_drvdata(dev, drvdata);
-	dev->platform_data = pdata;
  	drvdata->pdev = pdev;
  	ret = arm_trbe_probe_irq(pdev, drvdata);
  	if (ret)
-- 
2.34.1



> 
>>
>>>       if (csdev)
>>>           coresight_remove_conns_sysfs_group(csdev);
>>>   }
>>
>>
>> .
>>
> 

