Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890D80357F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjLDNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjLDNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:52:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493351A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:52:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38BAC433C7;
        Mon,  4 Dec 2023 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701697952;
        bh=SR4zmEbGPAtpyvbzmTlRN2hd0ISw5tqwBa8x9lpA8yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/2pylMW6MAuKBL+D5K5YNw4mVm4nKDY2Qq8/UmX/oMnA/fPkYicySTBWW/XPfIpe
         On5rcXpbFW8vjEJfjuXAaYtAsosHGlhnaWJiNdU0vL2h/LBJfn1DWwLjWcXR5U6Rg0
         32w1eHkObxddfMWZ65ePxrw+O37pIaFSvt2CGASwuqet79k4UOQeV6mYojiYZ0vjQm
         ErS48KW0rLOS5y3ml9flY9A8UFVsYAVNLzOzZaGN5ZCrxKjczvmdGd2FYSxTwEXtwh
         VFUhuR6nJMsfUkEHv6HARJMBtCiO0ROnOecsehIWIEu9zwLby/FwXy4jlrF6p0IRMu
         BbwCQCyg7g6DQ==
Date:   Mon, 4 Dec 2023 13:52:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <javier.carrasco.cruz@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range
 checks
Message-ID: <20231204135216.051b0d93@jic23-huawei>
In-Reply-To: <IA1PR11MB63958455F969F1506B3084769986A@IA1PR11MB6395.namprd11.prod.outlook.com>
References: <20231201-mcp3564_range_checks-v1-1-68f4436e22b0@gmail.com>
        <IA1PR11MB63958455F969F1506B3084769986A@IA1PR11MB6395.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 09:23:45 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Javier Carrasco,
> 
>    Thank you for looking over the driver and spotting and reporting the bug. Your fix is OK.
> 
> Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> Thanks,
> Marius
> 
> ________________________________
> From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Sent: Friday, December 1, 2023 11:48 AM
> To: Marius Cristea - M70257 <Marius.Cristea@microchip.com>; Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Subject: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range checks
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The current implementation uses the AND (&&) operator to check if the
> value to write for IIO_CHAN_INFO_CALIBBIAS and IIO_CHAN_INFO_CALIBSCALE
> is within the valid ranges.
> The evaluated values are the lower and upper limits of the ranges,
> so this operation always evaluates to false.
> 
> The OR (||) operator must be used instead.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This bug has been found when looking for use cases of IIO_AVAIL_RANGE
> and the fix could not be tested with real hardware. The issue and its
> soulution are rather simple, but still some testing and confirmation
> would be welcome.
> ---
>  drivers/iio/adc/mcp3564.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index e3f1de5fcc5a..d5fb1cae8aeb 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -918,7 +918,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
>                 mutex_unlock(&adc->lock);
>                 return ret;
>         case IIO_CHAN_INFO_CALIBBIAS:
> -               if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
> +               if (val < mcp3564_calib_bias[0] || val > mcp3564_calib_bias[2])
>                         return -EINVAL;
> 
>                 mutex_lock(&adc->lock);
> @@ -928,7 +928,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
>                 mutex_unlock(&adc->lock);
>                 return ret;
>         case IIO_CHAN_INFO_CALIBSCALE:
> -               if (val < mcp3564_calib_scale[0] && val > mcp3564_calib_scale[2])
> +               if (val < mcp3564_calib_scale[0] || val > mcp3564_calib_scale[2])
>                         return -EINVAL;
> 
>                 if (adc->calib_scale == val)
> 
> ---
> base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
> change-id: 20231201-mcp3564_range_checks-221708838130
> 
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

