Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7977B048
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjHNDwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjHNDwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:52:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD5E53
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:52:22 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPL4N4jCBz2Bd1V;
        Mon, 14 Aug 2023 11:49:24 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 11:52:19 +0800
Message-ID: <15dc4582-de74-ec5b-7d18-e1bf4a238257@huawei.com>
Date:   Mon, 14 Aug 2023 11:52:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: kunpeng_hccs: fix size_t format string
To:     Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
References: <20230812172116.3477379-1-arnd@kernel.org>
 <64D97BA6.3030609@hisilicon.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <64D97BA6.3030609@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd,

Acked-by: Huisong Li <lihuisong@huawei.com>

在 2023/8/14 8:56, Wei Xu 写道:
> Hi Arnd,
>
> On 2023/8/13 1:21, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Printing a size_t using the %lu format string causes a warning on
>> architectures that define the type as 'unsigned int':
>>
>> In file included from include/linux/device.h:15,
>>                   from include/linux/acpi.h:14,
>>                   from drivers/soc/hisilicon/kunpeng_hccs.c:25:
>> drivers/soc/hisilicon/kunpeng_hccs.c: In function 'hccs_get_bd_info':
>> drivers/soc/hisilicon/kunpeng_hccs.c:441:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>>
>> Use the correct %zu format instead.
>>
>> Fixes: 886bdf9c883bc ("soc: hisilicon: Support HCCS driver on Kunpeng SoC")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> I've already applied this one on top of the soc/drivers branch after I
>> merged the branch with the new driver and noticed the regression.
>>
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 6864d203c6782..0d6f6bacd3f62 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -438,7 +438,7 @@ static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
>>   	head = &rsp->rsp_head;
>>   	if (head->data_len > buf_len) {
>>   		dev_err(hdev->dev,
>> -			"buffer overflow (buf_len = %lu, data_len = %u)!\n",
>> +			"buffer overflow (buf_len = %zu, data_len = %u)!\n",
>>   			buf_len, head->data_len);
>>   		return -ENOMEM;
>>   	}
>>
> Thanks!
>
> Best Regards,
> Wei
> .
