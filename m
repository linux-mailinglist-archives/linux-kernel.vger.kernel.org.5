Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA97BA325
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjJEPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjJEPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F38478A;
        Thu,  5 Oct 2023 07:09:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDDEC433B7;
        Thu,  5 Oct 2023 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514953;
        bh=k1FKWxeYnMbMWKz9v6DyRx1G4lOfFBO4olyVSlLtx5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q34l+jf/WhLuJLokRZRcE4VCOn4IptAUrPATBg6vJxDQdv4TSxJfLoUgqliV4QFka
         HPySTubr5L5yS+C6GTiEsRcnHl9yXvxeVN+z/ztCtPkRmHPJV6umSoGdeHVRBY0Tnd
         GRnlHbKCCO9+46xm5wEqozL6JEp16DKI6SeBast6baQxZ9xLf8dxscLwal/IAupnC+
         lxWoKhqQK266ndBpaR314QpXA9WtRM2aW7IRgyRfzF5CLsdSo7tfJiR1MPfTnCZQ/g
         xtSwxA6wX0+5HauESPx/SxDzFodhqFPu8hYzFGK9JnqjjRg/hPtUx4NkzSzPh04YHK
         gzQ1TZP4OfhiQ==
Date:   Thu, 5 Oct 2023 15:09:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()
Message-ID: <20231005150917.2d0c833e@jic23-huawei>
In-Reply-To: <20230925134427.214556-1-w.egorov@phytec.de>
References: <20230925134427.214556-1-w.egorov@phytec.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 15:44:27 +0200
Wadim Egorov <w.egorov@phytec.de> wrote:

> Fix wrong handling of a DMA request where the probing only failed
> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
> value is returned. This makes DMAs explicitly optional. Even if the
> DMA request is unsuccessfully, the ADC can still work properly.
> We do also handle the defer probe case by making use of dev_err_probe().
> 
> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

+CC Bhavya,

Could you take a look at this given you had comments on v1.

Thanks,

Jonathan

> ---
> v2:
>   - Update description
>   - Drop line break after Fixes tag
>   - Move decision about optional DMA into probe/caller
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8db7a01cb5fb..5f8795986995 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	err = tiadc_request_dma(pdev, adc_dev);
> -	if (err && err == -EPROBE_DEFER)
> +	if (err && err != -ENODEV) {
> +		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
>  		goto err_dma;
> +	}
>  
>  	return 0;
>  

