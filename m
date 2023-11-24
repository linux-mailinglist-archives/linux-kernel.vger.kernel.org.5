Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826BB7F7499
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjKXNLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:11:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D90D72
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:11:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F5EC433C7;
        Fri, 24 Nov 2023 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700831482;
        bh=8mSUBJxI783kfIzyz9GSZzzaCFUJHxcazdbjVcAVjms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwRislTFWoUpbIAeSU6Nl6zfJlA2hHazkpMHRWwk9xlfqdBST05qHkygTrB/KdI7r
         51xlEdqbDAUWEftLQF/3StrTWDZhEKVJv82hnIxP5ECOZ6MbjW30FiQdz5rmcuhooV
         JcWCIGIAAYF1nQp38YEyfqSo4WYAy0WYuKkjCqpwqztZXQ56Iq3aGGmkspuGQyUw90
         uYnVOunwL5WwW6/9vu6Y5/ay0WbyuEFXLcftlXOBE3aX7IkFlkwD8DwEUexwQ5d2tE
         VPkoeWLgPvjjhBLVXO8SbqczGhAz6cddyHhKytlzsa7TxKJSEVQ7W9Dew31et1jyBq
         VN1baeDG7bQfw==
Date:   Fri, 24 Nov 2023 18:41:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
Message-ID: <ZWCg9hmfvexyn7xK@matsya>
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-23, 20:16, Kaiwei Liu wrote:
> From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

Typo is subject line

> 
> In the probe of dma, it will allocate device memory and do some
> initalization settings. All operations are only at the software
> level and don't need the DMA hardware power on. It doesn't need
> to resume the device and set the device active as well. here
> delete unnecessary operation.

Don't you need to read or write to the device? Without enable that wont
work right?

Lastly patches appear disjoint, pls thread them properly

> 
> Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
> ---
>  drivers/dma/sprd-dma.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 08fcf1ec368c..8ab5a9082fc5 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1203,21 +1203,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, sdev);
> -	ret = sprd_dma_enable(sdev);
> -	if (ret)
> -		return ret;
> -
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -
> -	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> -		goto err_rpm;
>  
>  	ret = dma_async_device_register(&sdev->dma_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
> -		goto err_register;
> +		return ret;
>  	}
>  
>  	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
> @@ -1226,16 +1216,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_of_register;
>  
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  
>  err_of_register:
>  	dma_async_device_unregister(&sdev->dma_dev);
> -err_register:
> -	pm_runtime_put_noidle(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -err_rpm:
> -	sprd_dma_disable(sdev);
>  	return ret;
>  }
>  
> -- 
> 2.17.1

-- 
~Vinod
