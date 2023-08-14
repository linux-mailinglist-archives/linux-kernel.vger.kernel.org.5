Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF477B4AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjHNIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHNIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:51:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568DB91
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:51:51 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPSjy3111z2BdHv;
        Mon, 14 Aug 2023 16:48:54 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 16:51:49 +0800
CC:     <yangyicong@hisilicon.com>, Liang Li <liliang6@email.cn>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto
 loading
To:     Barry Song <21cnbao@gmail.com>
References: <20230807122233.28563-1-yangyicong@huawei.com>
 <ZNL9s92HjLy+MZTw@localhost>
 <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
 <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com>
 <ZNOCgX8yniu+IuUG@localhost>
 <f6edb51e-ae79-5eaa-f337-fb4971aec575@huawei.com>
 <CAGsJ_4wivZ186D9JgyL-46zRuBDboST+c-ODx0FEbXdy5Tt3NA@mail.gmail.com>
 <CAGsJ_4wxJvmsa3iVcgqeQEx5Ur3vq1aupE=FJKxOc-fCxy57SQ@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d23826de-f2a4-4e68-bbd9-014cc24966b8@huawei.com>
Date:   Mon, 14 Aug 2023 16:51:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4wxJvmsa3iVcgqeQEx5Ur3vq1aupE=FJKxOc-fCxy57SQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/12 13:31, Barry Song wrote:
> On Sat, Aug 12, 2023 at 1:24 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Fri, Aug 11, 2023 at 6:14 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>
>>> On 2023/8/9 20:11, Liang Li wrote:
>>>> Hi Yicong,
>>>>
>>>> Thanks for your reply,
>>>>
>>>> On 2023-08-09 14:31, Yicong Yang <yangyicong@huawei.com> wrote:
>>>>> Hi Barry, Liang,
>>>>>
>>>>> On 2023/8/9 13:47, Barry Song wrote:
>>>>>> On Wed, Aug 9, 2023 at 1:01 PM Liang Li <liliang6@email.cn> wrote:
>>>>>>>
>>>>>>> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>>>>>
>>>>>>>> On ACPI based system the device is probed by the name directly. If the
>>>>>>>> driver is configured as module it can only be loaded manually. Add the
>>>>>>>> platform id table as well as the module alias then the driver will be
>>>>>>>> loaded automatically by the udev or others once the device added.
>>>>>>>>
>>>>>>>
>>>>>>> Please consider revise the long log to clearly express the purpose of the
>>>>>>> changes in this patch:
>>>>>>>
>>>>>>> - What's the exact issue the patch is addressing
>>>>>>> - Why the changes in this patch can fix the issue or make something working
>>>>>>> - Consider impact of the changes introduced by this patch
>>>>>>>
>>>>>>> These info may help reviewers and maintainers .. and yourself on code merge.
>>>>>>
>>>>>> years ago, i found a good doc regarding this,
>>>>>> https://wiki.archlinux.org/title/Modalias
>>>>>>
>>>>>> guess it is because /lib/modules/$(uname -r)/modules.alias fails to contain smmu
>>>>>> driver without the MODULE_DEVICE_TABLE, isn't it, yicong？
>>>>>
>>>>> Yes I think it's the reason. I didn't find summary in kernel docs for the modalias
>>>>> as well as the uevent mechanism. Arch wiki has a well illustration for the modalias
>>>>> and suse[1] describes how this is used by the udev for module auto loading.
>>>>>
>>>>> For my case I'm using a ACPI based arm64 server and after booting the arm_smmuv3_pmu.ko
>>>>> is not auto loaded by the udevd since we aren't providing this information. In order
>>>>> to support this we need to provide this MODULE_DEVICE_TABLE() when the smmu pmu added
>>>>> as a platform device, then the userspace udev can know which module to load after the
>>>>> device is added.
>>>>>
>>>>
>>>> Then what's the purpose of the added '.id_table = ...' line in the previous
>>>> patch ?
>>>> <We lost the patch context in this thread.>
>>>>
>>>> Based on above clarification, the updated DEVICE_TABLE would update modalias
>>>> as expected, right ?
>>>
>>> ok, it's lack of illustration in the commit. If we're going to use MODULE_DEVICE_TABLE we need
>>> a platform id table. So I add it and I found it weired if we have a id table but not use it for
>>> probing, so I also initialize .id_table.
>>>
>>> I found there's also an another way to implement this by used MODULE_ALIAS(), and no need to add
>>> an id table. Maybe this way is less controversial.
>>
>> right, how is your driver matching with your device?
>>
>> acpi_driver_match_device()  or strcmp(pdev->name, drv->name) == 0 ?
> 

The latter. The smmu pmu platform device is created when parsing the IORT so probed by matching the
device and driver name directly.

> btw, those drivers supporting acpi probe usually have a acpi table
> 
> #if IS_ENABLED(CONFIG_ACPI)
> static const struct acpi_device_id hidma_acpi_ids[] = {
> {"QCOM8061"},
> {"QCOM8062", HIDMA_MSI_CAP},
> {"QCOM8063", (HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP)},
> {},
> };
> MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
> #endif
> 
>>
>> static int platform_match(struct device *dev, struct device_driver *drv)
>> {
>>         struct platform_device *pdev = to_platform_device(dev);
>>         struct platform_driver *pdrv = to_platform_driver(drv);
>>
>>         /* When driver_override is set, only bind to the matching driver */
>>         if (pdev->driver_override)
>>                 return !strcmp(pdev->driver_override, drv->name);
>>
>>         /* Attempt an OF style match first */
>>         if (of_driver_match_device(dev, drv))
>>                 return 1;
>>
>>         /* Then try ACPI style match */
>>         if (acpi_driver_match_device(dev, drv))
>>                 return 1;
>>
>>         /* Then try to match against the id table */
>>         if (pdrv->id_table)
>>                 return platform_match_id(pdrv->id_table, pdev) != NULL;
>>
>>         /* fall-back to driver name match */
>>         return (strcmp(pdev->name, drv->name) == 0);
>> }
>>
>> In both cases, it seems we don't need id_table. id_table can support
>> two or above device names, so that one driver can support
>> multiple device IDs usually with different specific device data.
>>

yes I think you're right. For my case use MODULE_ALIAS is enough. Will respin
a v2.

Thanks!

>>>
>>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>>> index 25a269d431e4..4c32b6dbfe76 100644
>>> --- a/drivers/perf/arm_smmuv3_pmu.c
>>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>>> @@ -984,6 +984,7 @@ static void __exit arm_smmu_pmu_exit(void)
>>>
>>>  module_exit(arm_smmu_pmu_exit);
>>>
>>> +MODULE_ALIAS("platform:arm-smmu-v3-pmcg");
>>>  MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Extension");
>>>  MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
>>>  MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>");
>>>
>>
>> Thanks
>> Barry
> .
> 
