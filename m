Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E77B106E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjI1BjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:39:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BBAC;
        Wed, 27 Sep 2023 18:38:59 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rwx0S45CdzrStx;
        Thu, 28 Sep 2023 09:36:40 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 09:38:56 +0800
Message-ID: <382fe161-95fb-3249-32cf-07058f81a4bc@huawei.com>
Date:   Thu, 28 Sep 2023 09:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 01/10] scsi: scsi_debug: create scsi_debug directory in
 the debugfs filesystem
Content-Language: en-US
To:     <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-2-haowenchao2@huawei.com>
 <8c7cfe09-d145-4387-91cf-da9d4e2398e1@interlog.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <8c7cfe09-d145-4387-91cf-da9d4e2398e1@interlog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/28 9:13, Douglas Gilbert wrote:
> On 2023-09-22 05:28, Wenchao Hao wrote:
>> Create directory scsi_debug in the root of the debugfs filesystem.
>> Prepare to add interface for manage error injection.
>>
>> Acked-by: Douglas Gilbert <dgilbert@interlog.com>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   drivers/scsi/scsi_debug.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>> index 9c0af50501f9..35c336271b13 100644
>> --- a/drivers/scsi/scsi_debug.c
>> +++ b/drivers/scsi/scsi_debug.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/random.h>
>>   #include <linux/xarray.h>
>>   #include <linux/prefetch.h>
>> +#include <linux/debugfs.h>
>>   #include <net/checksum.h>
>> @@ -862,6 +863,8 @@ static const int device_qfull_result =
>>   static const int condition_met_result = SAM_STAT_CONDITION_MET;
>> +static struct dentry *sdebug_debugfs_root;
>> +
>>   /* Only do the extra work involved in logical block provisioning if one or
>>    * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
>> @@ -7011,6 +7014,8 @@ static int __init scsi_debug_init(void)
>>           goto driver_unreg;
>>       }
>> +    sdebug_debugfs_root = debugfs_create_dir("scsi_debug", NULL);
> 
> debugfs_create_dir() can fail and return NULL. Looking at other drivers, most
> seem to assume it will work. Since the scsi_debug driver is often used to test
> abnormal situations, perhaps adding something like:
>      if (!sdebug_debugfs_root)
>          pr_info("%s: failed to create initial debugfs directory\n", __func__);
> 
> might save someone a bit of time if a NULL dereference on sdebug_debugfs_root
> follows later. That is what the mpt3sas driver does.
> 

Yes, I would fix it by checking return value of debugfs related call
after your review suggestions for other patches.

> Doug Gilbert
> 
>> +
>>       for (k = 0; k < hosts_to_add; k++) {
>>           if (want_store && k == 0) {
>>               ret = sdebug_add_host_helper(idx);
>> @@ -7057,6 +7062,7 @@ static void __exit scsi_debug_exit(void)
>>       sdebug_erase_all_stores(false);
>>       xa_destroy(per_store_ap);
>> +    debugfs_remove(sdebug_debugfs_root);
>>   }
>>   device_initcall(scsi_debug_init);
> 
> 

