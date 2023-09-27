Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314657B00B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjI0Jjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjI0Jjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:39:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7FDC0;
        Wed, 27 Sep 2023 02:39:41 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RwWgx2MKdzMlpH;
        Wed, 27 Sep 2023 17:35:57 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 17:39:39 +0800
Message-ID: <374f2f3c-e0f0-cd28-4b43-fa46a1fd5002@huawei.com>
Date:   Wed, 27 Sep 2023 17:39:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        <lixiaokeng@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
 <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
 <27eb28b9-46e9-489f-9826-5e8f9a9a662f@oracle.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <27eb28b9-46e9-489f-9826-5e8f9a9a662f@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/27 1:37, Mike Christie wrote:
> On 9/26/23 7:57 AM, Wenchao Hao wrote:
>> On 2023/9/26 1:54, Mike Christie wrote:
>>> On 9/25/23 10:07 AM, Wenchao Hao wrote:
>>>> On 2023/9/25 22:55, Christoph Hellwig wrote:
>>>>> Before we add another new error handling mechanism we need to fix the
>>>>> old one first.  Hannes' work on not passing the scsi_cmnd to the various
>>>>> reset handlers hasn't made a lot of progress in the last five years and
>>>>> we'll need to urgently fix that first before adding even more
>>>>> complexity.
>>>>>
>>>> I observed Hannes's patches posted about one year ago, it has not been
>>>> applied yet. I don't know if he is still working on it.
>>>>
>>>> My patches do not depend much on that work, I think the conflict can be
>>>> solved fast between two changes.
>>>
>>> I think we want to figure out Hannes's patches first.
>>>
>>> For a new EH design we will want to be able to do multiple TMFs in parallel
>>> on the same host/target right?
>>>
>>
>> It's not necessary to do multiple TMFs in parallel, it's ok to make sure
>> each TMFs do not affect each other.
>>
>> For example, we have two devices: 0:0:0:0 and 0:0:0:1
>>
>> Both of them request device reset, they do not happened in parallel, but
>> would in serial. If 0:0:0:0 is performing device reset in progress, 0:0:0:1
>> just wait 0:0:0:0 to finish.
> 
> I see. I guess we still get the benefit of not having to stop other devices
> when doing TMFs.
> 

Yes, it's better to support multiple TMFs in parallel than just run in serial.
I would wait for Hannes's changes to be applied and send my change again.

> I think we still want a common way to allocate/free and manage resources
> drivers will use during this time. Maybe have a init_device/target/cmd/eh_priv
> and exit_device/target/eh_priv (I'm not sure of the name, but something similar
> to the init_cmd_priv/exit_cmd_priv we have for normal commands.
> 
> scsi-ml then calls into the new eh with the priv data. Drivers don't have to
> do the preallocation and worry if it's per device/target/host.
> 
> I'm not 100% sure about the low level details. Check out how Hannes's is
> handling tag management for TMFs as well.
> 
> 
>>
>>> The problem is that we need to be able to make forward progress in the EH
>>> path and not fail just because we can't allocate memory for a TMF related
>>> struct. To accomplish this now, drivers will use mempools, preallocate TMF
>>> related structs/mem/tags with their scsi_cmnd related structs, preallocate
>>> per host/target/device related structs or ignore what I wrote above and just
>>> fail.
>>>
>>> Hannes's patches fix up the eh callouts so they don't pass in a scsi_cmnd
>>> when it's not needed. That seems nice because after that, then for your new
>>> EH we can begin to standardize on how to handle preallocation of drivers
>>> resources needed to perform TMFs for your new EH. It could be a per
>>> device/target/host callout to allow drivers to preallocate, then scsi-ml calls
>>> into the drivers with that data. It doesn't have to be exactly like that or
>>> anything close. It would be nice for drivers to not have to think about this
>>> type of thing and scsi-ml just to handle the resource management for us when
>>> there are multiple TMFs in progress.
>>>
>>
> 

