Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2DB75EA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGXD4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXD4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:56:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AEDD7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:56:18 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8RBD5vLNzVjj0;
        Mon, 24 Jul 2023 11:54:44 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 11:56:14 +0800
Subject: Re: [PATCH] driver core: Call dma_cleanup() on the test_remove path
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0-v1-8fd93768dbcf+19b-really_probe_dma_cleanup_jgg@nvidia.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ce997cca-32c2-fc04-b84c-b97e6ccea4ca@huawei.com>
Date:   Mon, 24 Jul 2023 11:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0-v1-8fd93768dbcf+19b-really_probe_dma_cleanup_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: LKML

On 2023/7/22 0:20, Jason Gunthorpe wrote:
> When test_remove is enabled really_probe() does not properly pair
> dma_configure() with dma_remove(), it will end up calling dma_configure()
> twice. This corrupts the owner_cnt and renders the group unusable with
> VFIO/etc.
> 
> Add the missing cleanup before going back to re_probe.
> 
> Fixes: 25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> Closes: https://lore.kernel.org/all/6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/base/dd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 878aa7646b37e4..a528cec24264ab 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -693,6 +693,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  		device_remove(dev);
>  		driver_sysfs_remove(dev);
> +		if (dev->bus && dev->bus->dma_cleanup)
> +			dev->bus->dma_cleanup(dev);
>  		device_unbind_cleanup(dev);
>  
>  		goto re_probe;
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> 

Tested-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui
