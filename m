Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5707D9AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbjJ0OPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjJ0OPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:15:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1657B8;
        Fri, 27 Oct 2023 07:15:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B57C433CA;
        Fri, 27 Oct 2023 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698416129;
        bh=FeoSFjBClAtXEms1dJG9FSmvqhaVOV5FqfpXbkM0l+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AQBhfqtnIqkANUon/plWcETuTbIxuFHYTXOC5YnH0l4iAG3UAWgwc+jGQJafTzoHD
         owYdNx1V9LVHi3u6T42PHTalE3Z7yN+6R2FnWRuZovcHePHByCkmqu5QRZo+NNxOdA
         oPTWYWapwlTXh4lqBpOqmUbt/CukWRfDq8815V63CGJmcFZ9oPU0XIhGSWF4Vu7CKr
         W6ozmZ3IRISu+lRG7NAB+H/hm1YQ3tQEt4RAHcY6ZLDwHnZFdpaFRYMQWcd+v8ynYi
         5EEh0ujBTx/bE6A3BsbX3hBPN0d79bew+/UweWV66whdtWVsNv9HRJb9dtSYlmdW6y
         NfiCEPiSeZKpg==
Date:   Fri, 27 Oct 2023 15:15:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tmag5273: fix temperature offset
Message-ID: <20231027151507.2eac395c@jic23-huawei>
In-Reply-To: <20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net>
References: <20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net>
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

On Mon, 23 Oct 2023 11:50:02 +0200
Javier Carrasco <javier.carrasco@wolfvision.net> wrote:

> The current offset has the scale already applied to it. The ABI
> documentation defines the offset parameter as "offset to be added
> to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
> obtain value in the <type> units as specified in <type>[Y]_raw
> documentation"
> 
> The right value is obtained at 0 degrees Celsius by the formula provided
> in the datasheet:
> 
> T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res

So base units for temperature are milli degrees celsius. 
T = 1000 * (25 + (adc - 17508) / 60.1)

T =  1000/60.1 * (25 * 60.1 + adc - 17508)
T = 10000/601 * (-16005.5 + adc)  
So I think the maths is a little off..
> 
> where:
> T = 0 degrees Celsius
> Tsens_t0 (reference temperature) = 25 degrees Celsius
> Tadc_t0 (16-bit format for Tsens_t0) = 17508
> Tadc_res = 60.1 LSB/degree Celsius
> 
> The resulting offset is 16605.5, which has been truncated to 16005 to
Interesting - the truncated value you have looks good to be but that's
not matching with the resulting offset or the value below...

> provide an integer value with a precision loss smaller than the 1-LSB
> measurement precision.
> 
> Fix the offset to apply its value prior to scaling.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/iio/magnetometer/tmag5273.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
> index c5e5c4ad681e..d22ca39007b6 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val = -266314;
> +			*val = -16605;
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> 
> ---
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961
> 
> Best regards,

