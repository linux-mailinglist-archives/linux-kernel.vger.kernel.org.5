Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C47D067F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbjJTCds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjJTCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:33:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA598
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:33:45 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SBT7V3cbkzNp1s;
        Fri, 20 Oct 2023 10:29:42 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 10:33:42 +0800
Subject: Re: [PATCH 2/3] coresight: ultrasoc-smb: simplify the code for check
 to_copy valid
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linuxarm@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
 <20231012094706.21565-3-hejunhao3@huawei.com>
 <20231019143530.00004c75@huawei.com>
CC:     <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <28ab70eb-8b75-6a56-1406-859a51ea4684@huawei.com>
Date:   Fri, 20 Oct 2023 10:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231019143530.00004c75@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/19 21:35, Jonathan Cameron wrote:
> On Thu, 12 Oct 2023 17:47:05 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>> We only need to check once when before using the to_copy variable
>> to simplify the code.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> I'm not convinced this one is an improvement. Sometimes it's easier to just
> see the individual conditions checked even if we could combine them.
> It's easy to understand we don't copy data if:
> a) We ask for 0 data.
> b) There is 0 data
>
> Less easy to establish that with the extra wrap around code in there
> (even though that has no impact on to_copy if it is 0)
>
> Jonathan
>

Thanks, I will drop this patch.

Best regards,
Junhao.

>> ---
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> index b08a619d1116..e78edc3480ce 100644
>> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -127,20 +127,15 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>>   					struct smb_drv_data, miscdev);
>>   	struct smb_data_buffer *sdb = &drvdata->sdb;
>>   	struct device *dev = &drvdata->csdev->dev;
>> -	ssize_t to_copy = 0;
>> -
>> -	if (!len)
>> -		return 0;
>> -
>> -	if (!sdb->data_size)
>> -		return 0;
>> -
>> -	to_copy = min(sdb->data_size, len);
>> +	ssize_t to_copy = min(sdb->data_size, len);
>>   
>>   	/* Copy parts of trace data when read pointer wrap around SMB buffer */
>>   	if (sdb->buf_rdptr + to_copy > sdb->buf_size)
>>   		to_copy = sdb->buf_size - sdb->buf_rdptr;
>>   
>> +	if (!to_copy)
>> +		return 0;
>> +
>>   	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
>>   		dev_dbg(dev, "Failed to copy data to user\n");
>>   		return -EFAULT;
> .
>

