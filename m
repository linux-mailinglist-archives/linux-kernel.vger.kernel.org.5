Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8A767FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjG2OTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG2OTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D02030F3;
        Sat, 29 Jul 2023 07:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9347860C56;
        Sat, 29 Jul 2023 14:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50D9C433C7;
        Sat, 29 Jul 2023 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690640356;
        bh=nk9cBmIFvArLRnDTgJYRNRbNEOLwoWaBjWmtuCH+6B0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JLYCKdzalHR32ffuwzqkv35gldrJoAy0RSyC3A6gwddxT2gN0jKhhckYdsYvQksCW
         c4SeUKojN+MTG/swLcHN91CpBWYN7XwrZnRHar3/x4lg33IdVKmQP7jM4EZxe1LnTF
         VgVo16fE2rSCGREFwJbFxDiNGd9u5u18MQ2KCfMgAkKVzHXK4t3RMMzyuMywR5g6F8
         2b+QM+lnUrOrupAUZykyh/+dHMSGmm3dRC0WNtz7ygrILAklQ0vcKpfHXRRUWdE79X
         mmy8Vg8g5wpmw3RRZy3OK98L/pWKM+88WFRLCrTalAwpjzP8Dw1ROImA3GduwpO2va
         feB4i4flNLkHQ==
Date:   Sat, 29 Jul 2023 15:19:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers: iio: filter: admv8818: add bypass mode
Message-ID: <20230729151921.654656b6@jic23-huawei>
In-Reply-To: <20230726143331.66456-1-antoniu.miclaus@analog.com>
References: <20230726143331.66456-1-antoniu.miclaus@analog.com>
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

On Wed, 26 Jul 2023 17:33:30 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add filter bypass mode, which bypasses the low pass filter, high pass
> filter and disables/unregister the clock rate notifier.
> 
> The patch contains minimal changes in order to add the functionality.
> 
> It was requested by users of the driver to ease the interaction with
> different configuration modes of the device.

Hi Antoniu

I'd like to understand more about the use case for this.  My assumption
is that you'd do this if there is appropriate signal conditioning off
chip.  If that's the case I'd expect to see this as a device tree binding
thing rather than exposed to userspace.

Also, I can see that it may be useful to separately control the input and
output filter bypassing which this doesn't enable.

Hence need some use case information to decide if this is a reasonable
addition to the userspace ABI.

Other comments inline.

Thanks,

Jonathan


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/filter/admv8818.c | 51 ++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index fe8d46cb7f1d..f0d6bb606507 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -78,6 +78,7 @@ enum {
>  enum {
>  	ADMV8818_AUTO_MODE,
>  	ADMV8818_MANUAL_MODE,
> +	ADMV8818_BYPASS_MODE,
>  };
>  
>  struct admv8818_state {
> @@ -114,7 +115,8 @@ static const struct regmap_config admv8818_regmap_config = {
>  
>  static const char * const admv8818_modes[] = {
>  	[0] = "auto",
> -	[1] = "manual"
> +	[1] = "manual",
> +	[2] = "bypass"
>  };
>  
>  static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
> @@ -394,6 +396,36 @@ static int admv8818_reg_access(struct iio_dev *indio_dev,
>  		return regmap_write(st->regmap, reg, write_val);
>  }
>  
> +static int admv8818_filter_bypass(struct admv8818_state *st)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
> +				 ADMV8818_SW_IN_SET_WR0_MSK |
> +				 ADMV8818_SW_IN_WR0_MSK |
> +				 ADMV8818_SW_OUT_SET_WR0_MSK |
> +				 ADMV8818_SW_OUT_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_SW_IN_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_IN_WR0_MSK, 0) |
> +				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, 0));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
> +				 ADMV8818_HPF_WR0_MSK |
> +				 ADMV8818_LPF_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_HPF_WR0_MSK, 0) |
> +				 FIELD_PREP(ADMV8818_LPF_WR0_MSK, 0));
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static int admv8818_get_mode(struct iio_dev *indio_dev,
>  			     const struct iio_chan_spec *chan)
>  {
> @@ -411,7 +443,10 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  
>  	if (!st->clkin) {
>  		if (mode == ADMV8818_MANUAL_MODE)
> -			return 0;
> +			goto set_mode;
> +
> +		if (mode == ADMV8818_BYPASS_MODE)
> +			goto bypass_filter;

Flow wise, this is a little difficult to follow.
I'd be tempted to just duplicate the small amount of
handling below in the two paths that I can see end up going the code
that configures bypass.

>  
>  		return -EINVAL;
>  	}
> @@ -434,8 +469,9 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  
>  		break;
>  	case ADMV8818_MANUAL_MODE:
> +	case ADMV8818_BYPASS_MODE:
>  		if (st->filter_mode)

This was ugly in the first place as it relied on the values of the enum being 0
and 1 (without them being specified as such).  I'd tidy this up whilst here
as now we have 0 1 2 so it's harder to follow than before.  Just check against
the appropriate values eg != AUTO



> -			return 0;
> +			break;
>  
>  		clk_disable_unprepare(st->clkin);
>  
> @@ -448,6 +484,15 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> +bypass_filter:
> +	if (st->filter_mode != ADMV8818_BYPASS_MODE &&
> +	    mode == ADMV8818_BYPASS_MODE) {
> +		ret = admv8818_filter_bypass(st);

I'd like to see this up in the switch statement even if that means duplicating
a little more code.  Rethink this function so as to make it more
readable than it ends up after this change.

> +		if (ret)
> +			return ret;
> +	}
> +
> +set_mode:
>  	st->filter_mode = mode;
>  
>  	return ret;

