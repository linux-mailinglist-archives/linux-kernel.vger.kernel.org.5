Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75D0793C63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbjIFMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjIFMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:12:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA71709;
        Wed,  6 Sep 2023 05:12:13 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rgh3d6BBVzNmmH;
        Wed,  6 Sep 2023 20:08:29 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 20:12:09 +0800
Message-ID: <ffdc92dd-2cab-358a-a25c-05f1418aa7ba@huawei.com>
Date:   Wed, 6 Sep 2023 20:12:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 09/19] scsi: core: increase/decrease target_busy
 without check can_queue
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <20230901094127.2010873-10-haowenchao2@huawei.com>
 <daba5c92-2395-4eee-b212-978fbe83b56f@oracle.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <daba5c92-2395-4eee-b212-978fbe83b56f@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/6 7:55, Mike Christie wrote:
> On 9/1/23 4:41 AM, Wenchao Hao wrote:
>> This is preparation for a genernal target based error handle strategy
>> to check if to wake up actual error handler.
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   drivers/scsi/scsi_lib.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index db0a42fe49c0..4a7fb48aa60f 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -293,8 +293,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
>>   
>>   	scsi_dec_host_busy(shost, cmd);
>>   
>> -	if (starget->can_queue > 0)
>> -		atomic_dec(&starget->target_busy);
>> +	atomic_dec(&starget->target_busy);
>>   
> 
> Ming had found that removing the atomics improves perf.
> Since most drivers didn't care about the target level counters
> it was moved to the can_queue check so only drivers using the
> feature suffer the perf hit.
> 
> Your patch should do the same.
> 
Would update in next version
