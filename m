Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC547B42AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjI3RZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjI3RZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:25:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE89DD;
        Sat, 30 Sep 2023 10:25:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7EC433C7;
        Sat, 30 Sep 2023 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696094701;
        bh=pHmVmDjDsZiy9N1fgB5bCX18M375YcsUpZJ8j7cjWL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NGSm6OCaP2nD1YXnbePaRlDIdijp5Lir7VmTk3yRUteWCzoOAfsWmHYg0HZuVv+GR
         UlCS/xg1UrLOnH0h1308CyOJqVgXTVNNoWhnW6sVeBeCekDj+GQcCxKIv2cDNgatLL
         3iRmETJPqJg3JtKgrKRVagYOZmdzQksecF6u+nDOR5mTy3iK5i5cLrQnv3MktUEv1i
         qRnb2UTs0W52YRisYUq1BIVFc1WBZ37kBV6Z82v8UQ+f6W2nNGIfmq0L+Djr2Gkdk4
         9q5ETGuT1TUREQ+hqtWP4yj7L6HLel8TR7BXANgxfGCqD320uZMG2xpb3+vuYkwOnj
         yU1c1M2fuvHsw==
Date:   Sat, 30 Sep 2023 18:25:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: ad7192: Improve f_order computation
Message-ID: <20230930182502.106d2c78@jic23-huawei>
In-Reply-To: <20230924215148.102491-3-alisadariana@gmail.com>
References: <20230924215148.102491-1-alisadariana@gmail.com>
        <20230924215148.102491-3-alisadariana@gmail.com>
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

On Mon, 25 Sep 2023 00:51:47 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Instead of using the f_order member of ad7192_state, a function that
> computes the f_order coefficient makes more sense. This coefficient is a
> function of the sinc filter and chop filter states.
> 
> Remove f_order member of ad7192_state structure. Instead use
> ad7192_compute_f_order function to compute the f_order coefficient
> according to the sinc filter and chop filter states passed as
> parameters.
> 
> Add ad7192_get_f_order function that returns the current f_order
> coefficient of the device.
> 
> Add ad7192_compute_f_adc function that computes the f_adc value
> according to the sinc filter and chop filter states passed as
> parameters.
> 
> Add ad7192_get_f_adc function that returns the current f_adc value of
> the device.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 62 +++++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d693f2ce8a20..0f9d33002d35 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -179,7 +179,6 @@ struct ad7192_state {
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
>  	u32				fclk;
> -	u32				f_order;
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
> @@ -419,7 +418,6 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  		st->conf |= AD7192_CONF_REFSEL;
>  
>  	st->conf &= ~AD7192_CONF_CHOP;
> -	st->f_order = AD7192_NO_SYNC_FILTER;
>  
>  	buf_en = of_property_read_bool(np, "adi,buffer-enable");
>  	if (buf_en)
> @@ -530,22 +528,60 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> +static int ad7192_compute_f_order(bool sinc3_en, bool chop_en)
> +{
> +	if (!chop_en)
> +		return 1;
> +
> +	if (sinc3_en)
> +		return AD7192_SYNC3_FILTER;
> +
> +	return AD7192_SYNC4_FILTER;
> +}
> +
> +static int ad7192_get_f_order(struct ad7192_state *st)
> +{
> +	bool sinc3_en, chop_en;
> +
> +	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
> +	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
> +
> +	return ad7192_compute_f_order(sinc3_en, chop_en);
> +}
> +
> +static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
> +				bool chop_en)
> +{
> +	unsigned int f_order = ad7192_compute_f_order(sinc3_en, chop_en);
> +
> +	return DIV_ROUND_CLOSEST(st->fclk,
> +				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +}
> +
> +static int ad7192_get_f_adc(struct ad7192_state *st)
> +{
> +	unsigned int f_order = ad7192_get_f_order(st);
> +
> +	return DIV_ROUND_CLOSEST(st->fclk,
> +				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +}
> +
>  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
>  						    int *freq)
>  {
>  	unsigned int fadc;
>  
>  	/* Formulas for filter at page 25 of the datasheet */
> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SYNC4_FILTER * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +	fadc = ad7192_compute_f_adc(st, false, true);
>  	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SYNC3_FILTER * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +	fadc = ad7192_compute_f_adc(st, true, true);
>  	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
> -	fadc = DIV_ROUND_CLOSEST(st->fclk, FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +	fadc = ad7192_compute_f_adc(st, false, false);
>  	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
> +
> +	fadc = ad7192_compute_f_adc(st, true, false);
>  	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  }
>  
> @@ -628,25 +664,21 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
>  
>  	switch (idx) {
>  	case 0:
> -		st->f_order = AD7192_SYNC4_FILTER;
>  		st->mode &= ~AD7192_MODE_SINC3;
>  
>  		st->conf |= AD7192_CONF_CHOP;
>  		break;
>  	case 1:
> -		st->f_order = AD7192_SYNC3_FILTER;
>  		st->mode |= AD7192_MODE_SINC3;
>  
>  		st->conf |= AD7192_CONF_CHOP;
>  		break;
>  	case 2:
> -		st->f_order = AD7192_NO_SYNC_FILTER;
>  		st->mode &= ~AD7192_MODE_SINC3;
>  
>  		st->conf &= ~AD7192_CONF_CHOP;
>  		break;
>  	case 3:
> -		st->f_order = AD7192_NO_SYNC_FILTER;
>  		st->mode |= AD7192_MODE_SINC3;
>  
>  		st->conf &= ~AD7192_CONF_CHOP;
> @@ -664,8 +696,7 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
>  {
>  	unsigned int fadc;
>  
> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 st->f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +	fadc = ad7192_get_f_adc(st);
>  
>  	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
>  		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
> @@ -713,8 +744,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			*val -= 273 * ad7192_get_temp_scale(unipolar);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = st->fclk /
> -			(st->f_order * 1024 * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
> +		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		*val = ad7192_get_3db_filter_freq(st);
> @@ -764,7 +794,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		div = st->fclk / (val * st->f_order * 1024);
> +		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
>  		if (div < 1 || div > 1023) {
>  			ret = -EINVAL;
>  			break;

