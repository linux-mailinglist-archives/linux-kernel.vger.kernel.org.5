Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827AC7BC660
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjJGJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJGJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:15:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD58B9;
        Sat,  7 Oct 2023 02:15:09 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2ffn1bj4zNp4w;
        Sat,  7 Oct 2023 17:11:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 17:15:07 +0800
Message-ID: <78adf4cf-e43d-fa1b-1d65-43c25e0cba6b@huawei.com>
Date:   Sat, 7 Oct 2023 17:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND] fpga: region: Fix possible memory leak in
 fpga_region_register_full()
Content-Language: en-US
To:     Russ Weight <russell.h.weight@intel.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230928091636.1209914-1-ruanjinjie@huawei.com>
 <9842e1cc-3e61-3759-30f0-b4968622e0a7@intel.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <9842e1cc-3e61-3759-30f0-b4968622e0a7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 23:45, Russ Weight wrote:
> 
> 
> On 9/28/23 02:16, Jinjie Ruan wrote:
>> If device_register() fails in fpga_region_register_full(), the region
>> allocated by kzalloc() and the id allocated by ida_alloc() also need be
>> freed otherwise will cause memory leak.
>>
>> Fixes: 8886a579744f ("fpga: region: Use standard dev_release for class driver")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/fpga/fpga-region.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index b364a929425c..9dc6314976ef 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -228,12 +228,13 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>  
>>  	ret = device_register(&region->dev);
> 
> The comments for device_register() say:
> 
>  * NOTE: _Never_ directly free @dev after calling this function, even
>  * if it returned an error! Always use put_device() to give up the
>  * reference initialized in this function instead.
> 
> Note that dev is embedded in the region structure, so freeing region
> means freeing dev.
> 
> The expectation is that after device_register() has been called, even
> if it returns an error, put_device() is used to lower the reference
> count. When the reference count is zero, the fpga_region_dev_release()
> function is called. fpga_region_dev_release() frees calls ida_free()
> and frees the region.

Right!

> 
> Have you observed different behavior? Do you have evidence of a memory
> leak?

I have noticed a memory leak in using fpga_region_register_full() in
fpga-region-test.c. I'll send the patch sooner.

> 
> Thanks,
> - Russ
> 
>>  	if (ret) {
>> -		put_device(&region->dev);
>> -		return ERR_PTR(ret);
>> +		goto err_put_device;
>>  	}
>>  
>>  	return region;
>>  
>> +err_put_device:
>> +	put_device(&region->dev);
>>  err_remove:
>>  	ida_free(&fpga_region_ida, id);
>>  err_free:
> 
