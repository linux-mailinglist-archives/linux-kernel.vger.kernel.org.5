Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A77F9495
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjKZR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKZR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:26:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5554FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:26:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28E1C433C8;
        Sun, 26 Nov 2023 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701019573;
        bh=QstMPvKZWWXH1k6uFIpPTJoYRIG+NxTa6oNipKjBo/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s5lLJiT4T84tmmeh+iHocFr7oUyMjz64PpsL8MXDGj09RRXt8wEAUWqEYXg4fQllf
         ztQSlQUsqnlKwK8kE8erNEdg+KxcTFkxxoGLAEK1q9GhUaEfItUcqQJ1kPFUKyRJtz
         aOSArLpLRe5F0CsJ2FqQffoRzoxDfmkV9YDhtgo1oPUlQGrJLK3R/UUPJj9gt3TJTc
         7KH5q55Wl2ZL8Lxo2P5ejzrbtm85SU2/Z4aQHPXjstJJh28QO+AbJ/wrEcI9hR+jP0
         zkRFe5osBHyGcptknaa1w8NBk7Mq7eu+CESofaDqPIQSnRQNDTPF7TsZkqOLKMcW6u
         v1ikw9yqWnHcg==
Date:   Sun, 26 Nov 2023 17:26:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
Message-ID: <20231126172607.379c9d79@jic23-huawei>
In-Reply-To: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 11:50:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The GTS helpers do flooring of scale when calculating available scales.
> This results available-scales to be reported smaller than they should
> when the division in scale computation resulted remainder greater than
> half of the divider. (decimal part of result > 0.5)
> 
> Furthermore, when gains are computed based on scale, the gain resulting
> from the scale computation is also floored. As a consequence the
> floored scales reported by available scales may not match the gains that
> can be set.
> 
> The related discussion can be found from:
> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
> 
> Do rounding when computing scales and gains.
> 
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

A few questions inline about the maths.

> 
> ---
> Subjahit, is there any chance you test this patch with your driver? Can
> you drop the:
> 	if (val2 % 10)
> 		val2 += 1;
> from scale setting and do you see written and read scales matching?
> 
> I did run a few Kunit tests on this change - but I'm still a bit jumpy
> on it... Reviewing/testing is highly appreciated!
> 
> Just in case someone is interested in seeing the Kunit tests, they're
> somewhat unpolished & crude and can emit noisy debug prints - but can
> anyways be found from:
> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
> 
> ---
>  drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..7dc144ac10c8 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -18,6 +18,32 @@
>  #include <linux/iio/iio-gts-helper.h>
>  #include <linux/iio/types.h>
>  
> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
> +{
> +	unsigned int full32 = (unsigned int) full;
> +	unsigned int rem;
> +	int result;
> +
> +	if (full == (u64)full32) {
> +		unsigned int rem;
> +
> +		result = full32 / scale;
> +		rem = full32 - scale * result;
> +		if (rem >= scale / 2)
> +			result++;
> +
> +		return result;
> +	}
> +
> +	rem = do_div(full, scale);

As below, can we just add scale/2 to full in the do_div?

> +	if ((u64)rem >= scale / 2)
> +		result = full + 1;
> +	else
> +		result = full;
> +
> +	return result;
> +}
> +
>  /**
>   * iio_gts_get_gain - Convert scale to total gain
>   *
> @@ -28,30 +54,42 @@
>   *		scale is 64 100 000 000.
>   * @scale:	Linearized scale to compute the gain for.
>   *
> - * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> + * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
>   *		is invalid.
>   */
>  static int iio_gts_get_gain(const u64 max, const u64 scale)
>  {
> -	u64 full = max;
> +	u64 full = max, half_div;
> +	unsigned int scale32 = (unsigned int) scale;
>  	int tmp = 1;
>  
> -	if (scale > full || !scale)
> +	if (scale / 2 > full || !scale)

Seems odd. Why are we checking scale / 2 here?

>  		return -EINVAL;
>  
> +	/*
> +	 * The loop-based implementation below will potentially run _long_
> +	 * if we have a small scale and large 'max' - which may be needed when
> +	 * GTS is used for channels returning specific units. Luckily we can
> +	 * avoid the loop when scale is small and fits in 32 bits.
> +	 */
> +	if ((u64)scale32 == scale)
> +		return iio_gts_get_gain_32(full, scale32);
> +
>  	if (U64_MAX - full < scale) {
>  		/* Risk of overflow */
> -		if (full - scale < scale)
> +		if (full - scale / 2 < scale)
>  			return 1;
>  
>  		full -= scale;
>  		tmp++;
>  	}
>  
> -	while (full > scale * (u64)tmp)
> +	half_div = scale >> 2;

Why divide by 4?  Looks like classic issue with using shifts for division
causing confusion.

> +
> +	while (full + half_div >= scale * (u64)tmp)
>  		tmp++;
>  
> -	return tmp;
> +	return tmp - 1;
>  }
>  
>  /**
> @@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale_nano,
>   * Convert the total gain value to scale. NOTE: This does not separate gain
>   * generated by HW-gain or integration time. It is up to caller to decide what
>   * part of the total gain is due to integration time and what due to HW-gain.
> + * Computed gain is rounded to nearest integer.
>   *
>   * Return: 0 on success. Negative errno on failure.
>   */
> @@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>  				int *scale_int, int *scale_nano)
>  {
>  	u64 tmp;
> +	int rem;
>  
>  	tmp = gts->max_scale;
>  
> -	do_div(tmp, total_gain);
> +	rem = do_div(tmp, total_gain);

can we do usual trick of
do_div(tmp + total_gain/2, total_gain)
to get the same rounding effect?

> +	if (total_gain > 1 && rem >= total_gain / 2)
> +		tmp += 1ULL;
>  
>  	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
>  }
> @@ -192,7 +234,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
>  		     NULL);
>  
> -		/* Convert gains to scales */
> +		/* Convert gains to scales. */

Grumble - unrelated change.

>  		for (j = 0; j < gts->num_hwgain; j++) {
>  			ret = iio_gts_total_gain_to_scale(gts, gains[i][j],
>  							  &scales[i][2 * j],
> 
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa

