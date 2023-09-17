Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE37A353C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjIQKqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjIQKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:46:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35A122;
        Sun, 17 Sep 2023 03:46:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D28C433C8;
        Sun, 17 Sep 2023 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694947561;
        bh=tuneXaC50fCB7oGzaG6oE2MeWCqJV7+eq3Gj9nnslX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jDjT/cL3+CCoFlvprORtsAbBRN2ODlzr2Q3fu1KXSLOidUQ9dVk7iffauAKhax+nf
         +CCJ9RnIu8V2B/z6uBB0SqKpswGh/4rn5erdbuDsUyYZ+62deV570WXEfFSg9a+gsc
         nrRNbZPb+3rMXQBRVtVmn7a5m0SK00AHwQyk2F9R3Qyg7ZdHUiDmdKz3ZsR+/GfIeZ
         dGvYhbZY/owWv/wn3cYWFtJXasd9huEYYRsx6cI0AGrohIoxWXMK5sGt+4ZIcSxnyi
         UECG95/5NsEwygGPkmVSDctPTrCdSuGqUshKD3yYENxC3NrUTDEWKftgUx5nUyitQ1
         mWGLICm/AZayQ==
Date:   Sun, 17 Sep 2023 11:45:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <mugunthanvnm@ti.com>, <peter.ujfalusi@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <nm@ti.com>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Message-ID: <20230917114552.3f5cd081@jic23-huawei>
In-Reply-To: <20230914121300.845493-1-w.egorov@phytec.de>
References: <20230914121300.845493-1-w.egorov@phytec.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 14:13:00 +0200
Wadim Egorov <w.egorov@phytec.de> wrote:

> DMAs are optional. Even if the DMA request is unsuccessfully,
> the ADC can still work properly.

> Make tiadc_request_dma() not fail if we do not provide dmas &
> dma-names properties.
> 
> This actually fixes the wrong error handling of the tiadc_request_dma()
> result where the probing only failed if -EPROPE_DEFER was returned.
> 
> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
> 
No line break here.  Fixes tag is part of the main tag block.
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>  drivers/iio/adc/ti_am335x_adc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8db7a01cb5fb..e14aa9254ab1 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -543,8 +543,11 @@ static int tiadc_request_dma(struct platform_device *pdev,
>  	if (IS_ERR(dma->chan)) {
>  		int ret = PTR_ERR(dma->chan);
>  
> +		if (ret != -ENODEV)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "RX DMA channel request failed\n");
>  		dma->chan = NULL;
> -		return ret;
> +		return 0;
>  	}
>  
>  	/* RX buffer */
> @@ -670,7 +673,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	err = tiadc_request_dma(pdev, adc_dev);
> -	if (err && err == -EPROBE_DEFER)
> +	if (err)

So this looks like a more subtle change than you are describing.
In the original code, we backed off only if the return was a PROBE_DEFER, otherwise
we carried on.

Your change seems to make that happen for any non -ENODEV error, including PROBE_DEFER.
That's fine, but it's not what the description implies.

Whilst tiadc_request_dma will fail today if the dmas etc is not provided, that seems
like correct behavior to me.  A function requesting dma fails if it isn't available.
The handling of whether to carry on the job for the caller.

So I think it should just be
	if (err && err != -EINVAL)
		goto err_dma;

and no change in tiadc_request_dma()

However, the case you describe should have worked find with existing code
as it wasn't -EPROBE_DEFER, so I don't understand why you were looking at this
code block in the first place?

Jonathan


>  		goto err_dma;
>  
>  	return 0;

