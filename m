Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0877B417
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjHNI0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjHNI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:26:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6FC11710;
        Mon, 14 Aug 2023 01:26:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxyOgV5dlkwQwYAA--.14002S3;
        Mon, 14 Aug 2023 16:25:57 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM4U5dlkgaVZAA--.24168S3;
        Mon, 14 Aug 2023 16:25:57 +0800 (CST)
Subject: Re: [PATCH v2] usb: dwc2: add pci_device_id driver_data parse support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, loongson-kernel@lists.loongnix.cn,
        zhuyinbo@loongson.cn
References: <20230609025047.691-1-zhuyinbo@loongson.cn>
 <2023060915-uneasy-pedicure-35f4@gregkh>
 <1e2a07a4-f81f-3672-f29c-144d1a12ea21@loongson.cn>
 <2023060958-unvocal-flattery-256a@gregkh> <2023060912-shun-work-a667@gregkh>
 <d260aae0-2ce2-ed72-e680-8ec2d50335cc@loongson.cn>
 <2023061354-rectify-delta-5dd2@gregkh>
 <574ac243-18ee-9dd8-7aeb-8fe6ff1252a9@loongson.cn>
 <e7a84453-7677-6692-8662-ef719158bfbf@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <386c557d-c281-9905-d823-046048e1f5fd@loongson.cn>
Date:   Mon, 14 Aug 2023 16:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e7a84453-7677-6692-8662-ef719158bfbf@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvM4U5dlkgaVZAA--.24168S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Friendly ping ?


在 2023/7/21 下午4:13, Yinbo Zhu 写道:
> 
> Hi greg k-h,
> 
> I'm sorry to bother you,  I want to request your opinion on what I have 
> said.
> 
> Thanks,
> Yinbo
> 
> 
> 在 2023/6/14 上午11:55, zhuyinbo 写道:
>>
>>
>> 在 2023/6/13 下午6:19, Greg Kroah-Hartman 写道:
>>> On Mon, Jun 12, 2023 at 02:51:05PM +0800, zhuyinbo wrote:
>>>>
>>>>
>>>> 在 2023/6/9 下午5:31, Greg Kroah-Hartman 写道:
>>>>> On Fri, Jun 09, 2023 at 11:25:15AM +0200, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Jun 09, 2023 at 05:07:03PM +0800, zhuyinbo wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2023/6/9 下午2:13, Greg Kroah-Hartman 写道:
>>>>>>>> On Fri, Jun 09, 2023 at 10:50:47AM +0800, Yinbo Zhu wrote:
>>>>>>>>> The dwc2 driver has everything we need to run in PCI mode except
>>>>>>>>> for pci_device_id driver_data parse.  With that to set Loongson
>>>>>>>>> dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
>>>>>>>>> and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
>>>>>>>>> dwc2 controller will work.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>>>>> ---
>>>>>>>>> Change in v2:
>>>>>>>>>         1. Move the dwc2 pci ID from pci_ids.h to params.c.
>>>>>>>>>         2. Add some code logic to ensure that the current 
>>>>>>>>> device is
>>>>>>>>>            a PCI device.
>>>>>>>>>         3. Fix the compile issue when dwc2 pci driver as module.
>>>>>>>>>
>>>>>>>>>     drivers/usb/dwc2/core.h   |  1 +
>>>>>>>>>     drivers/usb/dwc2/params.c | 39 
>>>>>>>>> ++++++++++++++++++++++++++++++++++++++-
>>>>>>>>>     drivers/usb/dwc2/pci.c    | 14 +-------------
>>>>>>>>>     3 files changed, 40 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
>>>>>>>>> index 0bb4c0c845bf..c92a1da46a01 100644
>>>>>>>>> --- a/drivers/usb/dwc2/core.h
>>>>>>>>> +++ b/drivers/usb/dwc2/core.h
>>>>>>>>> @@ -1330,6 +1330,7 @@ irqreturn_t dwc2_handle_common_intr(int 
>>>>>>>>> irq, void *dev);
>>>>>>>>>     /* The device ID match table */
>>>>>>>>>     extern const struct of_device_id dwc2_of_match_table[];
>>>>>>>>>     extern const struct acpi_device_id dwc2_acpi_match[];
>>>>>>>>> +extern const struct pci_device_id dwc2_pci_ids[];
>>>>>>>>>     int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
>>>>>>>>>     int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
>>>>>>>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
>>>>>>>>> index 21d16533bd2f..6b68a8830781 100644
>>>>>>>>> --- a/drivers/usb/dwc2/params.c
>>>>>>>>> +++ b/drivers/usb/dwc2/params.c
>>>>>>>>> @@ -7,9 +7,14 @@
>>>>>>>>>     #include <linux/module.h>
>>>>>>>>>     #include <linux/of_device.h>
>>>>>>>>>     #include <linux/usb/of.h>
>>>>>>>>> +#include <linux/pci_ids.h>
>>>>>>>>> +#include <linux/pci.h>
>>>>>>>>>     #include "core.h"
>>>>>>>>> +#define PCI_PRODUCT_ID_HAPS_HSOTG    0xabc0
>>>>>>>>> +#define PCI_DEVICE_ID_LOONGSON_DWC2    0x7a04
>>>>>>>>> +
>>>>>>>>>     static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
>>>>>>>>>     {
>>>>>>>>>         struct dwc2_core_params *p = &hsotg->params;
>>>>>>>>> @@ -55,6 +60,14 @@ static void dwc2_set_jz4775_params(struct 
>>>>>>>>> dwc2_hsotg *hsotg)
>>>>>>>>> !device_property_read_bool(hsotg->dev, "disable-over-current");
>>>>>>>>>     }
>>>>>>>>> +static void dwc2_set_loongson_params(struct dwc2_hsotg *hsotg)
>>>>>>>>> +{
>>>>>>>>> +    struct dwc2_core_params *p = &hsotg->params;
>>>>>>>>> +
>>>>>>>>> +    p->phy_utmi_width = 8;
>>>>>>>>> +    p->power_down = DWC2_POWER_DOWN_PARAM_PARTIAL;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>     static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
>>>>>>>>>     {
>>>>>>>>>         struct dwc2_core_params *p = &hsotg->params;
>>>>>>>>> @@ -281,6 +294,23 @@ const struct acpi_device_id 
>>>>>>>>> dwc2_acpi_match[] = {
>>>>>>>>>     };
>>>>>>>>>     MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
>>>>>>>>> +const struct pci_device_id dwc2_pci_ids[] = {
>>>>>>>>> +    {
>>>>>>>>> +        PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 
>>>>>>>>> PCI_PRODUCT_ID_HAPS_HSOTG),
>>>>>>>>> +    },
>>>>>>>>> +    {
>>>>>>>>> +        PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
>>>>>>>>> +               PCI_DEVICE_ID_STMICRO_USB_OTG),
>>>>>>>>> +    },
>>>>>>>>> +    {
>>>>>>>>> +        PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 
>>>>>>>>> PCI_DEVICE_ID_LOONGSON_DWC2),
>>>>>>>>> +        .driver_data = (unsigned long)dwc2_set_loongson_params,
>>>>>>>>> +    },
>>>>>>>>> +    { /* end: all zeroes */ }
>>>>>>>>> +};
>>>>>>>>> +MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
>>>>>>>>> +EXPORT_SYMBOL_GPL(dwc2_pci_ids);
>>>>>>>>> +
>>>>>>>>>     static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
>>>>>>>>>     {
>>>>>>>>>         switch (hsotg->hw_params.op_mode) {
>>>>>>>>> @@ -927,13 +957,20 @@ int dwc2_init_params(struct dwc2_hsotg 
>>>>>>>>> *hsotg)
>>>>>>>>>         if (match && match->data) {
>>>>>>>>>             set_params = match->data;
>>>>>>>>>             set_params(hsotg);
>>>>>>>>> -    } else {
>>>>>>>>> +    } else if (!match) {
>>>>>>>>>             const struct acpi_device_id *amatch;
>>>>>>>>> +        const struct pci_device_id *pmatch = NULL;
>>>>>>>>>             amatch = acpi_match_device(dwc2_acpi_match, 
>>>>>>>>> hsotg->dev);
>>>>>>>>>             if (amatch && amatch->driver_data) {
>>>>>>>>>                 set_params = (set_params_cb)amatch->driver_data;
>>>>>>>>>                 set_params(hsotg);
>>>>>>>>> +        } else if (!amatch)
>>>>>>>>> +            pmatch = pci_match_id(dwc2_pci_ids, 
>>>>>>>>> to_pci_dev(hsotg->dev->parent));
>>>>>>>>
>>>>>>>> At this point in time, how can you guarantee that the parent device
>>>>>>>> really is a PCI one?  This function is being called from a platform
>>>>>>>> device callback, and platform devices should NEVER be a child of 
>>>>>>>> a PCI
>>>>>>>> device, as that's not how PCI or platform devices work.
>>>>>>>>
>>>>>>>> So how is this even possible?
>>>>>>>>
>>>>>>>> confused,
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi greg k-h,
>>>>>>>
>>>>>>> My current considerations are based on that the dwc2 drivers support
>>>>>>> three types of devices, they are Platform device / ACPI device / PCI
>>>>>>> device, and The dwc2/platform.c can all cover the three type dwc2
>>>>>>> device, no matter how it is registered.
>>>>>>>
>>>>>>> So, when a dwc2 device wasn't platform device and acpi device and It
>>>>>>> will be a PCI device, and the the dwc2/pci.c will register a dwc2
>>>>>>> platform device that dwc2 device is a device that in 
>>>>>>> dwc2/platform.c's
>>>>>>> dwc2_driver_probe.  the "&dwc2->dev->parent" is the 
>>>>>>> "hsotg->dev->parent"
>>>>>>> and it was also the &pci->dev.
>>>>>>
>>>>>> That's wrong, a PCI device should NEVER register a platform device 
>>>>>> under
>>>>>> it, as obviously it's not a platform device at all.
>>>>>>
>>>>>> So please work to fix that layering violation here, as that's not
>>>>>> correct and will cause problems as you are showing here.
>>>>>>
>>>>>>> So, We can use "to_pci_dev(hsotg->dev->parent)" to gain a dwc2 pci
>>>>>>> device.
>>>>>>
>>>>>> No, not if the parent is something else as you have no way of knowing
>>>>>> this at this point in time.
>>>>>>
>>>>>>>
>>>>>>> 1)  DWC2 PCI device driver (drivers/usb/dwc2/pci.c) :
>>>>>>>
>>>>>>> static int dwc2_pci_probe(struct pci_dev *pci,
>>>>>>>                             const struct pci_device_id *id)
>>>>>>> {
>>>>>>> ...
>>>>>>>           struct platform_device  *dwc2;
>>>>>>> ...
>>>>>>>           struct device           *dev = &pci->dev;
>>>>>>> ...
>>>>>>>     dwc2 = platform_device_alloc("dwc2", PLATFORM_DEVID_AUTO);
>>>>>>>                   //"dwc2" was used to match dwc2 platform driver
>>>>>>
>>>>>> This needs to be fixed, it's not ok at all.  Just use the real PCI
>>>>>> device here please.
>>>>>
>>>>> Also, to be fair, you didn't cause this problem, I missed it 
>>>>> previously.
>>>>> But fixing it is essential, and will be required in order to get your
>>>>> changes to work properly.  Sorry about that.
>>>>>
>>>>
>>>>
>>>> Hi greg k-h,
>>>>
>>>> Actually,  the dwc2/pci.c's  platform_device_add(dwc2) was create a
>>>> platform device called "dwc2"  ensure dwc2/platform's dwc2_driver_probe
>>>> function can be called. After all, the dwc2/platform's 
>>>> dwc2_driver_probe
>>>> is the one that truly initializes the dwc2 controller. In addition, the
>>>> same applies to dwc3 code.
>>>
>>> Yes, it does create a platform device, but ALSO a real platform device
>>> could be present in the system for the driver, one that is NOT a child
>>> of a PCI device, right?
>>
>>
>> I don't get it that why need dwc2 was a child of pci. and I just need
>> the dwc2->dev.parent's parent device was a child of dwc2 pci device.
>> If my patch conditions are met (match and amatch was NULL), this always
>> seems to hold true.
>>
>> dwc2_pci_probe ()
>> {
>> struct platform_device  *dwc2;
>> struct device *dev = &pci->dev;
>> dwc2->dev.parent = dev;
>> platform_device_add(dwc2);
>> }
>>
>>>
>>> It's not this way with your system, but it could be that way for many
>>> others, right?  And if so, the assumption that you can just poke around
>>> in the parent device and assume that you know what bus it is on is just
>>> wrong and will break things.
>>
>>
>> What you said about "system" that is unrelated to the kernel driver? I
>> think it should be system independent and it depends entirely on the
>> kernel driver, for the driver, everyone is the same. the behavior of the
>> driver is known, and currently I have not found any other risks it
>> poses.  Additionally, the key is that the issue that my patch is
>> addressing is a common issue. For example, if the following devices are
>> designed as PCI devices on hardware, they will always encounter the same
>> problem.
>>
>> const struct of_device_id dwc2_of_match_table[] = {
>>         { .compatible = "brcm,bcm2835-usb", .data = 
>> dwc2_set_bcm_params },
>>         { .compatible = "hisilicon,hi6220-usb", .data = 
>> dwc2_set_his_params },
>>         { .compatible = "ingenic,jz4775-otg", .data = 
>> dwc2_set_jz4775_params },
>>         { .compatible = "ingenic,jz4780-otg", .data = 
>> dwc2_set_jz4775_params },
>>         { .compatible = "ingenic,x1000-otg", .data = 
>> dwc2_set_jz4775_params },
>>         { .compatible = "ingenic,x1600-otg", .data = 
>> dwc2_set_x1600_params },
>>         { .compatible = "ingenic,x1700-otg", .data = 
>> dwc2_set_x1600_params },
>>         { .compatible = "ingenic,x1830-otg", .data = 
>> dwc2_set_x1600_params },
>>         { .compatible = "ingenic,x2000-otg", .data = 
>> dwc2_set_x2000_params },
>>         { .compatible = "rockchip,rk3066-usb", .data = 
>> dwc2_set_rk_params },
>>         { .compatible = "lantiq,arx100-usb", .data = 
>> dwc2_set_ltq_params },
>>         { .compatible = "lantiq,xrx200-usb", .data = 
>> dwc2_set_ltq_params },
>>
>>>
>>> You should NEVER be poking around in the information for the parent
>>> device, UNLESS you have just created the child device yourself and the
>>> ONLY code path is one that you have full control over.
>>>
>>> Does that make more sense?
>>
>>
>> Yes, but it seems inappropriate for dwc2. For this, please allow me to 
>> parse some of my comments in v1:
>>
>>
>> Actually, I use pci_match_id was due to I noticed that xhci-pci.c,
>> ehci-pci.c and ohci-pci.c was all use it . and I don't use it in
>> dwc2/pci.c was considering set dwc2 element need dpend on elements.c and
>> platform.c, and usb driver (ohci,echi,xhci) was a relatively
>> indepent device driver when to operate usb controler. but dwc2 was not.
>>
>> If I fource the element setting of dwc2 element in dwc2/pci.c. It will 
>> be following case. This will cause problems with element-initial
>> function or element-check function.
>>
>> 1. initial dwc2 element.
>> 2. check the setting of dwc2 element whether was suitable
>> 3. set dwc2 element.
>>
>> or
>>
>> 1. set dwc2 element.
>> 2. initial dwc2 element.
>> 3. check the setting of dwc2 element whether was suitable
>>
>> The corresponding code call process as follows:
>>
>> 1. dwc2_set_default_params(hsotg);
>> 2. dwc2_get_device_properties(hsotg);
>> 3. dwc2_check_params(hsotg);
>> 4. dwc2_set_loongson_params;
>>
>> or
>>
>> 1. dwc2_set_loongson_params;
>> 2. dwc2_set_default_params(hsotg);
>> 3. dwc2_get_device_properties(hsotg);
>> 4. dwc2_check_params(hsotg);
>>
>> But the platform dwc2 device or acpi dwc2 device was all following case
>> and It seems was correct order.
>>
>> 1. dwc2_set_default_params(hsotg);
>> 2. dwc2_get_device_properties(hsotg);
>> 3. dwc2_set_loongson_params;
>> 4. dwc2_check_params(hsotg);
>>
>>
>> Thanks,
>>
>> Yinbo

