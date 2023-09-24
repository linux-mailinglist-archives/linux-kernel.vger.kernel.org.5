Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BAD7ACB12
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIXRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:31:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8AFA;
        Sun, 24 Sep 2023 10:31:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EDAC433C7;
        Sun, 24 Sep 2023 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695576704;
        bh=SBcRy7SqvEDiW3tVYGnfs39BvMV4QV8Nn93/BBiEIN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XWm8Tw+issldt4e3+QjrdZXt6ac9d9MNE0oU363n7DtvPjibXiIj/07JSYsPsY82b
         RocWDo9ien25IUJ/XQwiXN39ET3ao1CuTT0J4XRm0EfviFLdBmvzr/QEkrGeJyXZKQ
         YbnPc4pywXAHHUvZVl1J+OP1uD8RxPOlwryIzo4zvPe8Ho+SQ46aYVnK7aeFvR1Tk5
         6nI5bBMrMjScxOGevjGsd6Gg6T2HiPP0wK1nhBGx9P6H/m1NFJkfT3ztWTCYtzPs9L
         xr57qphFW/0RUVR+H0+CGYC7BwxDU0LhNOVqwPHFdKTlVJTb0lGKcQNIxoqTEfLCMs
         ZTUHnlgcr6UIQ==
Date:   Sun, 24 Sep 2023 18:31:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 06/19] staging: iio: resolver: ad2s1210: always use
 16-bit value for raw read
Message-ID: <20230924183136.25112830@jic23-huawei>
In-Reply-To: <20230921144400.62380-7-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-7-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:47 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This removes the special handling for resolutions lower than 16 bits.
> This will allow us to use a fixed scale independent of the resolution.
> 
> Also, for the record, according to the datasheet, the logic for the
> special handling based on hysteresis that was removed was incorrect.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This looks fine to me, but a potential improvement would be to just
use a __be16 element in st in the first place have the type explicitly
marked all the way through.

Jonathan


> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 9c7f76114360..985b8fecd65a 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -465,10 +465,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  			     long m)
>  {
>  	struct ad2s1210_state *st = iio_priv(indio_dev);
> -	u16 negative;
>  	int ret = 0;
> -	u16 pos;
> -	s16 vel;
>  
>  	mutex_lock(&st->lock);
>  	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
> @@ -494,20 +491,11 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (chan->type) {
>  	case IIO_ANGL:
> -		pos = be16_to_cpup((__be16 *)st->rx);
> -		if (st->hysteresis)
> -			pos >>= 16 - st->resolution;
> -		*val = pos;
> +		*val = be16_to_cpup((__be16 *)st->rx);

Could be made more obvious still by adding as suitable __be16 to read into in the
first place.

>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_ANGL_VEL:
> -		vel = be16_to_cpup((__be16 *)st->rx);
> -		vel >>= 16 - st->resolution;
> -		if (vel & 0x8000) {
> -			negative = (0xffff >> st->resolution) << st->resolution;
> -			vel |= negative;
> -		}
> -		*val = vel;
> +		*val = (s16)be16_to_cpup((__be16 *)st->rx);
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:

