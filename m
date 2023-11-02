Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E07DF221
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjKBMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbjKBMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:16:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657AD40;
        Thu,  2 Nov 2023 05:16:47 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLjTH6PLjzrTvq;
        Thu,  2 Nov 2023 20:13:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 20:16:42 +0800
Message-ID: <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
Date:   Thu, 2 Nov 2023 20:16:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
To:     Paolo Abeni <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>
References: <20231028025917.314305-1-shaojijie@huawei.com>
 <20231028025917.314305-7-shaojijie@huawei.com>
 <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on 2023/11/2 18:45, Paolo Abeni wrote:
> On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
>>   
>> -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr)
>> +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr,
>> +				      bool need_dalay)
>>   {
>> +#define HCLGEVF_RESET_DELAY		5
>> +
>> +	if (need_dalay)
>> +		mdelay(HCLGEVF_RESET_DELAY);
> 5ms delay in an interrupt handler is quite a lot. What about scheduling
> a timer from the IH to clear the register when such delay is needed?
>
> Thanks!
>
> Paolo

Using timer in this case will complicate the code and make maintenance difficult.

We consider reducing the delay time by polling. For example,
the code cycles every 50 us to check whether the write register takes effect.
If yes, the function returns immediately. or the code cycles until 5 ms.

Is this method appropriate?

Thanks!
Jijie

