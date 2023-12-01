Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCC8001BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376843AbjLACpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjLACpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:45:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97DA8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:45:26 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ShHTb0CvWzvQw8;
        Fri,  1 Dec 2023 10:44:51 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm000004.china.huawei.com
 (7.193.23.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 10:45:23 +0800
Message-ID: <b2cb48ed-3ba2-ee61-4f33-0a60ebaf0029@huawei.com>
Date:   Fri, 1 Dec 2023 10:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/4] soc: hisilicon: kunpeng_hccs: Support the platform
 with PCC type3 and interrupt ack
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
 <20231130134550.33398-1-lihuisong@huawei.com>
 <20231130134550.33398-5-lihuisong@huawei.com>
 <20231130144911.00005faf@Huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20231130144911.00005faf@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/30 22:49, Jonathan Cameron 写道:
> On Thu, 30 Nov 2023 21:45:50 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> Support the platform with PCC type3 and interrupt ack. And a version
>> specific structure is introduced to handle the difference between the
>> device in the code.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Hi.
>
> A few trivial things inline but now looks good to me!
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 136 ++++++++++++++++++++++-----
>>   drivers/soc/hisilicon/kunpeng_hccs.h |  15 +++
>>   2 files changed, 126 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 15125f1e0f3e..d2302ff8c0e9 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> ...
>
>>   
>> -static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>> +static inline int hccs_wait_cmd_complete_by_poll(struct hccs_dev *hdev)
> Why inline?  Do we have numbers to support this hint to the compiler being
> useful?
No testing for this, but here might not be really useful.
So will remove this inline.
>>   {
>>   	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>>   	struct acpi_pcct_shared_memory __iomem *comm_base =
>> @@ -194,30 +211,75 @@ static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>>   	return ret;
>>   }
>>   
>> +static inline int hccs_wait_cmd_complete_by_irq(struct hccs_dev *hdev)
>> +{
>> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> +	int ret = 0;
> Drop ret...
Ack
>
>> +
>> +	if (!wait_for_completion_timeout(&cl_info->done,
>> +			usecs_to_jiffies(cl_info->deadline_us))) {
>> +		dev_err(hdev->dev, "PCC command executed timeout!\n");
>> +		ret = -ETIMEDOUT;
> 		return -TIMEDOUT;
> ...
>> +	}
>> +
>> +	return ret;
> return 0;
Ack
>> +}
>> +static const struct hccs_verspecific_data hisi04b1_verspec_data = {
>> +	.rx_callback = NULL,
> It's harmless but no need to set callback to NULL. Maybe it acts as documentation?
Just to explicitly assign value and show the difference between the devices.
> It's common practice to just let C spec guarantees initialize any not implemented callbacks
> to 0 without them needing to be done explicitly.
Correct, but It's harmless.
>
>> +	.wait_cmd_complete = hccs_wait_cmd_complete_by_poll,
>> +	.fill_pcc_shared_mem = hccs_fill_pcc_shared_mem_region,
>> +	.shared_mem_size = sizeof(struct acpi_pcct_shared_memory),
>> +	.has_txdone_irq = false,
>> +};
>> +
>> +static const struct hccs_verspecific_data hisi04b2_verspec_data = {
>> +	.rx_callback = hccs_pcc_rx_callback,
>> +	.wait_cmd_complete = hccs_wait_cmd_complete_by_irq,
>> +	.fill_pcc_shared_mem = hccs_fill_ext_pcc_shared_mem_region,
>> +	.shared_mem_size = sizeof(struct acpi_pcct_ext_pcc_shared_memory),
>> +	.has_txdone_irq = true,
>> +};
> .
