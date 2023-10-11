Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450667C541D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJKMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJKMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:37:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E013493;
        Wed, 11 Oct 2023 05:37:05 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S5Bxv69jdzLpZw;
        Wed, 11 Oct 2023 20:33:07 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 20:37:03 +0800
Message-ID: <5ea16795-08c6-ef6b-b8cb-f1de2f5a0021@huawei.com>
Date:   Wed, 11 Oct 2023 20:37:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Content-Language: en-US
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
 <20230922093842.2646157-2-haowenchao2@huawei.com>
 <ea28de69-8b9d-8ff8-b7fc-eb780123f055@kernel.org>
 <7a11374c-4e8e-b7f9-aca4-55686a6ec501@huawei.com>
In-Reply-To: <7a11374c-4e8e-b7f9-aca4-55686a6ec501@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/24 14:27, Wenchao Hao wrote:
> On 2023/9/22 20:50, Damien Le Moal wrote:
>> On 2023/09/22 2:38, Wenchao Hao wrote:
>>> This is just a cleanup for scsi_dev_queue_ready() to avoid
>>> redundant goto and if statement, it did not change the origin
>>> logic.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>> ---
>>>   drivers/scsi/scsi_lib.c | 35 ++++++++++++++++++-----------------
>>>   1 file changed, 18 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>>> index ca5eb058d5c7..f3e388127dbd 100644
>>> --- a/drivers/scsi/scsi_lib.c
>>> +++ b/drivers/scsi/scsi_lib.c
>>> @@ -1254,28 +1254,29 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
>>>       int token;
>>>       token = sbitmap_get(&sdev->budget_map);
>>> -    if (atomic_read(&sdev->device_blocked)) {
>>> -        if (token < 0)
>>> -            goto out;
>>> +    if (token < 0)
>>> +        return -1;
>>
>> This is changing how this function works...
>>
> 
> I don't think so...
> The origin function flow:
> 
> static inline int scsi_dev_queue_ready(struct request_queue *q,
>                    struct scsi_device *sdev)
> {
>      ...
>      token = sbitmap_get(&sdev->budget_map);
>      if (atomic_read(&sdev->device_blocked)) {
>          if (token < 0)
>              goto out;
>      }
>      return token;
> out:
>      return -1
> }
> 
> If the token is less than 0, it would always return -1. So we can found
> it's not necessary to check token after atomic_read().
> 
>>> -        if (scsi_device_busy(sdev) > 1)
>>> -            goto out_dec;
>>> +    /*
>>> +     * device_blocked is not set at mostly time, so check it first
>>> +     * and return token when it is not set.
>>> +     */
>>> +    if (!atomic_read(&sdev->device_blocked))
>>> +        return token;
>>
>> ...because you reversed the tests order.
> 
> As explained in comment, the device_blocked is not set at mostly time,
> so when it's not set, just return the token.
> 

Friendly ping...

