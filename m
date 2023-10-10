Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839537C016A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjJJQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJJQR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:17:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E05CA;
        Tue, 10 Oct 2023 09:17:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A8FC433C7;
        Tue, 10 Oct 2023 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954647;
        bh=56o7CLyPH8HD1DpSyQ1z6xhaWF6KpUVyNqwHhHWJOaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqWOE/O98IhVs7xSEUl4RAkZhz0pzXDMVhEEExYhYg6zz7NCc5LW0184tnrquHHQV
         Zky3zc3CjghGJhx16jIhJG32EWrnEZRR5o0oP+pLvQw+u0Jwp9BMbx1jbUcvyv62ID
         E5cp/ECw03M7LZ21cS1712uxPqENZeX+pTiClhOgMqn07ik2Y9r5Q5eR/sTWfdakqy
         Sn7D2/Gc4OMzenlWPwCb/qbMdG+yEyVZd7bZ/cBfS0Vv9f0WgaBf3FyvKQE9bTyokb
         lJEX8OnHQyqZpvh1saaUIhg8bu/lHuod4r4Auv7clUV87sCOkXacUVPRoO7/fAs7qX
         dmQx0od/ii8Ng==
Date:   Tue, 10 Oct 2023 17:17:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/17] staging: iio: resolver: ad2s1210: simplify
 code with guard(mutex)
Message-ID: <20231010171738.5a23e66e@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-17-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-17-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can simplify the code and get rid of most of the gotos by using
> guard(mutex) from cleanup.h.
You could consider scoped_guard() for a few cases in here, but perhaps
it's better to be consistent and always use the guard() version.

There is a small timing question wrt to the gpio manipulation inline.

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes: New patch in v4.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 157 ++++++++++----------------------
>  1 file changed, 50 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index c4e1bc22e8b0..c4e0ffa92dc2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -47,6 +47,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -404,11 +405,13 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
>  	s64 timestamp;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	gpiod_set_value(st->sample_gpio, 1);
>  	timestamp = iio_get_time_ns(indio_dev);
>  	/* delay (6 * tck + 20) nano seconds */
>  	udelay(1);
> +	gpiod_set_value(st->sample_gpio, 0);
>  
>  	switch (chan->type) {
>  	case IIO_ANGL:
> @@ -418,14 +421,13 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
>  		ret = ad2s1210_set_mode(st, MOD_VEL);
>  		break;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
>  	if (ret < 0)
> -		goto error_ret;
> +		return ret;
>  	ret = spi_read(st->sdev, &st->sample, 3);
>  	if (ret < 0)
> -		goto error_ret;
> +		return ret;
>  
>  	switch (chan->type) {
>  	case IIO_ANGL:
> @@ -437,17 +439,11 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
>  
>  	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
>  
> -error_ret:
> -	gpiod_set_value(st->sample_gpio, 0);
> -	/* delay (2 * tck + 20) nano seconds */
> -	udelay(1);

Dropping this delay isn't obviously safe (though it probably is given stuff done before we exit).
I assume there are no rules on holding the gpio down for the register read.
 
If nothing else I think the patch description needs to made an argument for why it is fine.

> -	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
