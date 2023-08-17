Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97EB77F26E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbjHQIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349083AbjHQIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:47:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD701BE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:31 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRJSr0XHnzNnKP;
        Thu, 17 Aug 2023 16:43:56 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 16:47:27 +0800
Subject: Re: [PATCH 2/2] coresight: trbe: Allocate platform data per device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, <hejunhao3@huawei.com>
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
 <20230816141008.535450-2-suzuki.poulose@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jonathan.cameron@huawei.com>, <leo.yan@linaro.org>,
        <mike.leach@linaro.org>, <james.clark@arm.com>,
        <yangyicong@huawei.com>, <prime.zeng@hisilicon.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <be6b01e0-1571-0391-995f-30436e2a655b@huawei.com>
Date:   Thu, 17 Aug 2023 16:47:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230816141008.535450-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/16 22:10, Suzuki K Poulose wrote:
> Coresight TRBE driver shares a single platform data (which is empty btw).
> However, with the commit 4e8fe7e5c3a5
> ("coresight: Store pointers to connections rather than an array of them")
> the coresight core would free up the pdata, resulting in multiple attempts
> to free the same pdata for TRBE instances. Fix this by allocating a pdata per
> coresight_device.
>
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Link: https://lore.kernel.org/r/20230814093813.19152-3-hejunhao3@huawei.com
> Reported-by: Junhao He <hejunhao3@huawei.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Test-by: Junhao He <hejunhao3@huawei.com>

> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 025f70adee47..d3d34a833f01 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1255,10 +1255,13 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   	if (!desc.name)
>   		goto cpu_clear;
>   
> +	desc.pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(desc.pdata))
> +		goto cpu_clear;
> +
>   	desc.type = CORESIGHT_DEV_TYPE_SINK;
>   	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
>   	desc.ops = &arm_trbe_cs_ops;
> -	desc.pdata = dev_get_platdata(dev);
>   	desc.groups = arm_trbe_groups;
>   	desc.dev = dev;
>   	trbe_csdev = coresight_register(&desc);
> @@ -1482,7 +1485,6 @@ static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
>   
>   static int arm_trbe_device_probe(struct platform_device *pdev)
>   {
> -	struct coresight_platform_data *pdata;
>   	struct trbe_drvdata *drvdata;
>   	struct device *dev = &pdev->dev;
>   	int ret;
> @@ -1497,12 +1499,7 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
>   	if (!drvdata)
>   		return -ENOMEM;
>   
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -
>   	dev_set_drvdata(dev, drvdata);
> -	dev->platform_data = pdata;
>   	drvdata->pdev = pdev;
>   	ret = arm_trbe_probe_irq(pdev, drvdata);
>   	if (ret)

