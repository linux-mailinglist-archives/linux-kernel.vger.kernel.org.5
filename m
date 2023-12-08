Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342958098DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjLHByA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjLHBxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:53:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58761991;
        Thu,  7 Dec 2023 17:53:29 -0800 (PST)
Received: from kwepemd100004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmYzx5nKwzWhvX;
        Fri,  8 Dec 2023 09:52:29 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemd100004.china.huawei.com (7.221.188.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 8 Dec 2023 09:53:26 +0800
Message-ID: <5a00cc4f-1524-8a19-88c8-fe04e0211713@huawei.com>
Date:   Fri, 8 Dec 2023 09:53:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230720114102.51053-1-haijie1@huawei.com>
In-Reply-To: <20230720114102.51053-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.175]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100004.china.huawei.com (7.221.188.31)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vkoul,

Kindly ping...

Thanks,
Jie Hai
On 2023/7/20 19:41, Jie Hai wrote:
> The change introduced by commit a7c01fa93aeb ("signal: break
> out of wait loops on kthread_stop()") causes dmatest aborts
> any ongoing tests and possible failure on the tests. This patch
> use wait_event_timeout instead of wait_event_freezable_timeout
> to avoid interrupting ongoing tests by signal brought by
> kthread_stop().
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>   drivers/dma/dmatest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index ffe621695e47..c06b8b16645a 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -827,7 +827,7 @@ static int dmatest_func(void *data)
>   		} else {
>   			dma_async_issue_pending(chan);
>   
> -			wait_event_freezable_timeout(thread->done_wait,
> +			ret = wait_event_timeout(thread->done_wait,
>   					done->done,
>   					msecs_to_jiffies(params->timeout));
>   
