Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023217C9573
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjJNQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:48:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4DEAD;
        Sat, 14 Oct 2023 09:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D62C433C7;
        Sat, 14 Oct 2023 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697302122;
        bh=IJrlNnqjIUUh+gSh65AnT5Tv6b5rLf5FsYIFFFMO0Qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Av9m+yWLNk2ELds81JPlt3JNOqssW9vVhy+ss1zm5HxUxp3eyOOmDjVIrUq3YczhP
         cbnWJWK7DjckmdMhTWxZ0RGCZZCKORNSVwxKhFtNUh6JW7Q5rKv7YKUcXUe/yDwrQf
         gEWQGvI79xS720TEhZCjO/ELLhsloTWuaj4BmxTgcpK3Sem/e2AX8k0kjxsBkqRF8u
         KSCldX31xjLWtnys4xlng/1Z1hNUsPqApDMw2E1sWOMnJ2ZLBb91Lk0pOUpEUm0pH/
         2SmXlWDjQo4fXosXegJN+72jvUoi+s7Lv8x/dfRaNGxXo3s0rk3xIPr/jVF1qMWM8Y
         OLwQXnhVnxBpQ==
Date:   Sat, 14 Oct 2023 17:48:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Message-ID: <20231014174858.73bcabbc@jic23-huawei>
In-Reply-To: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
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

On Sat, 02 Sep 2023 21:46:20 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> As noted by Jonathan Cameron: it is perfectly legal for a channel
> to have an offset but no scale in addition to the raw interface.
> The conversion will imply that scale is 1:1.
> 
> Make rescale_configure_channel() accept just scale, or just offset
> to process a channel.
> 
> When a user asks for IIO_CHAN_INFO_OFFSET in rescale_read_raw()
> we now have to deal with the fact that OFFSET could be present
> but SCALE missing. Add code to simply scale 1:1 in this case.
> 
> Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
> Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
> Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Peter, can you take a look at this v2?

Thanks,

Jonathan
> ---
> Changes in v2:
> - Fix rescale_read_raw() handle channels with offset but no scale.
> - Link to v1: https://lore.kernel.org/r/20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org
> ---
>  drivers/iio/afe/iio-rescale.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 1f280c360701..56e5913ab82d 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  				return ret < 0 ? ret : -EOPNOTSUPP;
>  		}
>  
> -		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
> -		return rescale_process_offset(rescale, ret, scale, scale2,
> +		if (iio_channel_has_info(rescale->source->channel,
> +					 IIO_CHAN_INFO_SCALE)) {
> +			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
> +			return rescale_process_offset(rescale, ret, scale, scale2,
> +						      schan_off, val, val2);
> +		}
> +
> +		/*
> +		 * If we get here we have no scale so scale 1:1 but apply
> +		 * rescaler and offset, if any.
> +		 */
> +		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
>  					      schan_off, val, val2);
>  	default:
>  		return -EINVAL;
> @@ -280,8 +290,9 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->type = rescale->cfg->type;
>  
>  	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
> -	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_info(dev, "using raw+scale source channel\n");
> +	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
> +	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
> +		dev_info(dev, "using raw+scale/offset source channel\n");
>  	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>  		dev_info(dev, "using processed channel\n");
>  		rescale->chan_processed = true;
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230830-iio-rescale-only-offset-f28e05bd2deb
> 
> Best regards,

