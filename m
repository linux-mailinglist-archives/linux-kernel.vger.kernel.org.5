Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0E7CFA65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjJSNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJSNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:08:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914E9F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:08:12 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SB7HS0pcBzrTF9;
        Thu, 19 Oct 2023 21:05:24 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 21:08:08 +0800
Subject: Re: [PATCH 3/3] coresight: ultrasoc-smb: fix uninitialized before use
 buf_hw_base
To:     Yicong Yang <yangyicong@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
 <20231012094706.21565-4-hejunhao3@huawei.com>
 <fe5af067-d2f4-7967-e75b-272b00e6275f@huawei.com>
CC:     <james.clark@arm.com>, <suzuki.poulose@arm.com>,
        <yangyicong@hisilicon.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <3e67ba5a-4022-0089-1ede-46f73ad70afa@huawei.com>
Date:   Thu, 19 Oct 2023 21:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <fe5af067-d2f4-7967-e75b-272b00e6275f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.218]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/19 10:34, Yicong Yang wrote:
> On 2023/10/12 17:47, Junhao He wrote:
>> In smb_reset_buffer, the sdb->buf_hw_base variable is uninitialized
>> before use, which initializes it in smb_init_data_buffer. And the SMB
>> regiester are set in smb_config_inport.
>> So move the call after smb_config_inport.
>>
>> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> index e78edc3480ce..21ba473786e5 100644
>> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -475,7 +475,6 @@ static int smb_init_data_buffer(struct platform_device *pdev,
>>   static void smb_init_hw(struct smb_drv_data *drvdata)
>>   {
>>   	smb_disable_hw(drvdata);
>> -	smb_reset_buffer(drvdata);
>>   
>>   	writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>>   	writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
>> @@ -597,6 +596,7 @@ static int smb_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	platform_set_drvdata(pdev, drvdata);
>> +	smb_reset_buffer(drvdata);
> Shouldn't we reset the buffer before registering the sink? Otherwise it'll
> be possible for user to access an unreset one.
>

Hi Yicong,

Thanks for the comments!

The code after the smb_register_sink() function also needs to moved.
I will fix all in next version.

Best regards,
Junhao.

