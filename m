Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2907648CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjG0Hg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjG0Hg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:36:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15311BE3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:26:04 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBMCQ2dsnzNmJN;
        Thu, 27 Jul 2023 15:02:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:05:48 +0800
Message-ID: <ac3f4aeb-45c8-c337-55c0-c04db9328090@huawei.com>
Date:   Thu, 27 Jul 2023 15:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] drm: omapdrm: dss: Remove redundant DSSERR()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <laurent.pinchart@ideasonboard.com>,
        <guozhengkui@vivo.com>, <dianders@chromium.org>,
        <yuancan@huawei.com>, <arnd@arndb.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230727113923.3093070-1-ruanjinjie@huawei.com>
 <20230727065708.q7wrmzb7egzc4tmy@pengutronix.de>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230727065708.q7wrmzb7egzc4tmy@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/27 14:57, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jul 27, 2023 at 11:39:23AM +0000, Ruan Jinjie wrote:
>> There is no need to call the DSSERR() function directly to print
>> a custom message when handling an error from platform_get_irq() function
>> as it is going to display an appropriate error message
>> in case of a failure.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/gpu/drm/omapdrm/dss/dispc.c | 1 -
>>  drivers/gpu/drm/omapdrm/dss/dsi.c   | 4 +---
>>  drivers/gpu/drm/omapdrm/dss/hdmi4.c | 1 -
>>  drivers/gpu/drm/omapdrm/dss/hdmi5.c | 1 -
>>  4 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> index c26aab4939fa..9209103f5dc5 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> @@ -4779,7 +4779,6 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
>>  
>>  	dispc->irq = platform_get_irq(dispc->pdev, 0);
>>  	if (dispc->irq < 0) {
>> -		DSSERR("platform_get_irq failed\n");
>>  		r = -ENODEV;
>>  		goto err_free;
>>  	}
> 
> Orthogonal to your patch I wonder about r = -ENODEV. Wouldn't r =
> dispc->irq be the sensible option? Ditto for the other hunks.

I agree with you, r = dispc->irq will be more sensible!
> 
> Best regards
> Uwe
> 
