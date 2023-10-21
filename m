Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0237D1DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjJUPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:51:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD8135;
        Sat, 21 Oct 2023 08:51:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA419C433C8;
        Sat, 21 Oct 2023 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903490;
        bh=cOw4gL9kSJ6K8qJAZUSbhrBUlQDYXrl01d9CLBEbyhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oKGhA7IN29Am89YvPDbKg1FLp2qyj6jrlFqTM/zFjW5QEBH6dwReLzhZROrE5+qhN
         V9fJNyfaLx/x0GrKFsRkN3BbeGkIKPlEMtUcMyb66RchfjYDSFu7zik6Xtr/5rLDv4
         c1ASAin4QZfZDvCNbPJB/yaw51VMsFdGc1XoGL/qkO5W+AXwwtOaGKv7Lb0QS9+8n3
         nJZNrJgIzvBCEZVBahJBPgGvaES/IAonrpvw5w57y0lIoHJUAMHr/HfRTM0eFwcQWH
         CLBAp6XtSHRU9PoJfYUSZhyO3+QRkxp/heco2RS4gY00NyLBxdt4BprDZ61vrVAJlL
         7st/XJIZH7low==
Date:   Sat, 21 Oct 2023 16:51:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: kx022a: Fix acceleration value scaling
Message-ID: <20231021165122.7350d185@jic23-huawei>
In-Reply-To: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
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

On Thu, 19 Oct 2023 16:23:56 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The IIO ABI mandates acceleration values from accelerometer to be
> emitted in m/s^2. The KX022A was emitting values in micro m/s^2.
> 
> Fix driver to report the correct scale values.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reported-by: Jagath Jog J <jagathjog1996@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> 
> ---
> The fix is somewhat crude and just crops the last 3 digits (rounds) of the
> scale while using IIO_VAL_INT_PLUS_NANO. I played with a thought of using
> IIO_VAL_FRACTIONAL, which could have modelled the computation
> G_range * g * scaling / (2^16 * scaling) - where scaling 10000 would
> have allowed using g value 980665.
> 
> This would have worked fine for reporting scale and available scales -
> but would be somewhat tricky when converting the user-supplied scale to
> register values in write_raw().
> 
> Well, the g varies from 9.832 (poles) to 9.780 (equator) according to
> some website - no proper source check done but this sounds about right -
> so maybe the loss of accuracy is acceptable.

MEMS accelerometers tend to be pretty inaccurate. So I'd not worry too much about
this loss of accuracy at all.
The 0 point according to the datasheet I just looked at is +- 25mg and
if I read the sensitivity numbers right part to part variation in scale
is well above 5%.  For 2G mode, it lists acceptable 1G values of
min=15401, typical=16384, max=17367

So if anyone actually wants to do precision measurement they need to calibrate
their particular device + deal with the variation due to temperature etc
which makes this even more fun.

Applied to my local fixes-togreg branch of iio.git, but I've just sent a pull request
so this may not go out until after the 6.7 merge window.

Jonathan

> 
> I did only very quick testing on KX022A and iio_generic_buffer. After
> the patch the values seemed to be correct order of magnitude. Further
> testing is appreciated :)
> 
> ---
>  drivers/iio/accel/kionix-kx022a.c | 37 ++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 4ea3c6718ed4..971fc60efef0 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -273,17 +273,17 @@ static const unsigned int kx022a_odrs[] = {
>   *	(range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
>   *	=> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
>   *	in low-power mode(?) )
> - *	=> +/-2G  => 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
> - *	=> +/-2G  - 598.550415
> - *	   +/-4G  - 1197.10083
> - *	   +/-8G  - 2394.20166
> - *	   +/-16G - 4788.40332
> + *	=> +/-2G  => 4 / 2^16 * 9,80665
> + *	=> +/-2G  - 0.000598550415
> + *	   +/-4G  - 0.00119710083
> + *	   +/-8G  - 0.00239420166
> + *	   +/-16G - 0.00478840332
>   */
>  static const int kx022a_scale_table[][2] = {
> -	{ 598, 550415 },
> -	{ 1197, 100830 },
> -	{ 2394, 201660 },
> -	{ 4788, 403320 },
> +	{ 0, 598550 },
> +	{ 0, 1197101 },
> +	{ 0, 2394202 },
> +	{ 0, 4788403 },
>  };
>  
>  static int kx022a_read_avail(struct iio_dev *indio_dev,
> @@ -302,7 +302,7 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
>  		*vals = (const int *)kx022a_scale_table;
>  		*length = ARRAY_SIZE(kx022a_scale_table) *
>  			  ARRAY_SIZE(kx022a_scale_table[0]);
> -		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*type = IIO_VAL_INT_PLUS_NANO;
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> @@ -366,6 +366,20 @@ static int kx022a_turn_on_unlock(struct kx022a_data *data)
>  	return ret;
>  }
>  
> +static int kx022a_write_raw_get_fmt(struct iio_dev *idev,
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int kx022a_write_raw(struct iio_dev *idev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long mask)
> @@ -510,7 +524,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
>  
>  		kx022a_reg2scale(regval, val, val2);
>  
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_VAL_INT_PLUS_NANO;
>  	}
>  
>  	return -EINVAL;
> @@ -712,6 +726,7 @@ static int kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples)
>  static const struct iio_info kx022a_info = {
>  	.read_raw = &kx022a_read_raw,
>  	.write_raw = &kx022a_write_raw,
> +	.write_raw_get_fmt = &kx022a_write_raw_get_fmt,
>  	.read_avail = &kx022a_read_avail,
>  
>  	.validate_trigger	= iio_validate_own_trigger,

