Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2177AC6E6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIXG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjIXG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:58:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EC10C;
        Sat, 23 Sep 2023 23:57:56 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RtcGB5DPGz15NKw;
        Sun, 24 Sep 2023 14:55:30 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 24 Sep 2023 14:57:41 +0800
Message-ID: <bd5ad57f-7c61-e365-86f1-fdd3d2797021@huawei.com>
Date:   Sun, 24 Sep 2023 14:57:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] scsi: scsi_error: Fix device reset is not triggered
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        <linux-scsi@vger.kernel.org>
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
 <20230922093636.2645961-3-haowenchao2@huawei.com>
 <ce9cef41-29e2-4056-a60b-b0e4ee1cc17e@acm.org>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <ce9cef41-29e2-4056-a60b-b0e4ee1cc17e@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/22 23:18, Bart Van Assche wrote:
> On 9/22/23 02:36, Wenchao Hao wrote:
>> Fix the issue of skipping scsi_try_bus_device_reset() for devices
>> which is in progress of removing in following order:
>>
>> T1:                    T2:scsi_error_handle
>> __scsi_remove_device
>>    scsi_device_set_state(sdev, SDEV_DEL)
>>                     // would skip device with SDEV_DEL state
>>                        shost_for_each_device()
>>                       scsi_try_bus_device_reset
>>                     flush all commands
>>   ...
>>   scsi_device is released
>>
>> Some drivers like smartpqi only implement eh_device_reset_handler,
>> if device reset is skipped, the commands which had been sent to
>> firmware or devices hardware are not cleared. The error handle
>> would flush all these commands in scsi_unjam_host().
>>
>> When the commands are finished by hardware, use after free issue is
>> triggered.
>>
>> Add parameter "check_state" to macro shost_for_each_device() to
>> determine if check device status when traversal scsi_device
>> of Scsi_Host, and set this parameter to false when traversal
>> in scsi_error_handle to address this issue.
> 
> The above is incomprehensible to me. Please explain more clearly why this change is needed.

This is added for scsi error to not skip scsi_device's which is
in progress of removing, mostly, shost_for_each_device() is called
with check_state to 1, excepting some functions in scsi_error.c

> 
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index d0911bc28663..db8b9e42267c 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -704,6 +704,23 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
>>       return 0;
>>   }
>> +static int __scsi_device_get(struct scsi_device *sdev, bool check_state)
> 
> "check_state" is a bad argument name because it does not clearly explain the purpose of this argument. Would "include_deleted" perhaps be a better name?
> 

I took "include_deleted" in consideration too, but I am not
sure if more state check would be introduced, and we need following
check if name the it to "include_deleted"

if (!include_deleted &&	(sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
	goto fail;

Addition "!" is needed. So finally "check_state" is chosen.

If you think "include_deleted" is better, I would change in my next version.

>> +{
>> +    if (check_state &&
>> +        (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
>> +        goto fail;
>> +    if (!try_module_get(sdev->host->hostt->module))
>> +        goto fail;
>> +    if (!get_device(&sdev->sdev_gendev))
>> +        goto fail_put_module;
>> +    return 0;
>> +
>> +fail_put_module:
>> +    module_put(sdev->host->hostt->module);
>> +fail:
>> +    return -ENXIO;
>> +}
> 
> Looking at the above code, I think we need two functions: one that does not include the sdev->sdev_state check and a second function that includes the sdev->sdev_state check (scsi_device_get()) and calls the first. That will result in code that is easier to read than calls to a function with a boolean argument.

Yes, that's what I did.

> 
>> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
>> index c498a12f7715..e166d053c839 100644
>> --- a/include/scsi/scsi_device.h
>> +++ b/include/scsi/scsi_device.h
>> @@ -389,21 +389,25 @@ extern void __starget_for_each_device(struct scsi_target *, void *,
>>   /* only exposed to implement shost_for_each_device */
>>   extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
>> -                          struct scsi_device *);
>> +                          struct scsi_device *,
>> +                          bool);
>>   /**
>>    * shost_for_each_device - iterate over all devices of a host
>>    * @sdev: the &struct scsi_device to use as a cursor
>>    * @shost: the &struct scsi_host to iterate over
>> + * @check_state: if skip check scsi_device's state to skip some devices
>> + *               scsi_device with SDEV_DEL or SDEV_CANCEL would be skipped
>> + *               if this is true
>>    *
>>    * Iterator that returns each device attached to @shost.  This loop
>>    * takes a reference on each device and releases it at the end.  If
>>    * you break out of the loop, you must call scsi_device_put(sdev).
>>    */
>> -#define shost_for_each_device(sdev, shost) \
>> -    for ((sdev) = __scsi_iterate_devices((shost), NULL); \
>> +#define shost_for_each_device(sdev, shost, check_state) \
>> +    for ((sdev) = __scsi_iterate_devices((shost), NULL, check_state); \
>>            (sdev); \
>> -         (sdev) = __scsi_iterate_devices((shost), (sdev)))
>> +         (sdev) = __scsi_iterate_devices((shost), (sdev), check_state))
>>   /**
>>    * __shost_for_each_device - iterate over all devices of a host (UNLOCKED)
> 
> Since only the SCSI error handler passes 0 as 'check_state' argument to shost_for_each_device(), instead of adding a boolean argument to that macro, please do the following:
> * Introduce a new macro for the check_state = 1 case.
> * Keep the semantics for shost_for_each_device().
> 
> With this approach no SCSI LLDs will have to be modified.
> 

Originally, I added a new macro _shost_for_each_device(), which looks like following:

#define _shost_for_each_device(sdev, shost, check_state)

But I found another __shost_for_each_device(), too much shost_for_each_device(), so
I do not want to add another one any more...

Modify shost_for_each_device() directly looks not so good too, I want to add another
macro named "shost_for_each_device_all_state()" which do not skip scsi_device's with
DEL or CANCEL state, what do you think?

Thanks.

> Thanks,
> 
> Bart.
> 

