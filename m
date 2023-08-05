Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED277119C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHESwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHESwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D901BE4;
        Sat,  5 Aug 2023 11:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C6C60E08;
        Sat,  5 Aug 2023 18:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F4C433C7;
        Sat,  5 Aug 2023 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691261552;
        bh=B+ZCfR/0VxxM4w9/07xvtwGZta+zoCYoP15NNG5J0U8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s+ZmI66XGBxJKdNQxfycjjEtI4iFoe4J4SqyFzbeBwds4MkL/lw6PhfNN/mZw6zhk
         KEpP9xwXBTb9SDuPv7sNPNSvabua1U1N2pY/Is7/tmqcOn5VeYoijZ3FW2kkDPV92Y
         1ktAZJBR9Xu7eRKcx5bwfte2+Tj2u1RGb2QH7qvwPdcDJBIcuvL/8Kp0ZahuouISIu
         5NLVRZ8WyEm3e3gHi3wDhCvSiOSTuhsj+PUz4t6PyfYVJzLOFQCZdoAHPCSaJGVTJT
         evPg+uStUwP5fT0C58FCZz5jtMyDI4fIMhfl7o6KRJbNrAPE8XBmKBsKKxUymFwyuX
         xAo8Yl8oLbsYA==
Date:   Sat, 5 Aug 2023 19:52:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drivers: iio: filter: admv8818: add bypass mode
Message-ID: <20230805195226.7cdb38bc@jic23-huawei>
In-Reply-To: <20230731084928.8302-1-antoniu.miclaus@analog.com>
References: <20230731084928.8302-1-antoniu.miclaus@analog.com>
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

On Mon, 31 Jul 2023 11:49:26 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add filter bypass mode, which bypasses the low pass filter, high pass
> filter and disables/unregister the clock rate notifier.
> 
> Currently a feature like bypassing the filter is not achievable
> straightforward and not very deductive. The user has to look through the
> code and call the set_lpf_3db_frequency and set_hpf_3db_frequency iio
> attributes from the user interface using the corner cases (freq >
> largest lpf supported by the part, respectively freq < smallest hpf
> supported by the part). Moreover, in such case of bypassing the filter,
> the input clock rate change might mess up things so we want to make sure
> that it is disabled. Also, the feature will help emphasizing the filter
> behavior, therefore adding it in the userspace will ease the
> charcaterization of the filter's effects when active/disabled.

Reasoning is well laid out. Thanks!  It's an unusual feature, but meh
it's also hidden in existing custom ABI so unlikely to cause any
problems.

> 
> It was requested by users of the driver to ease the interaction with
> different configuration modes of the device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it and see if we missed anything.

> ---
> changes in v2:
>  - improve code readability when setting the filter modes
>  - add more explanations regarding the necessity of this feature in the commit
>    body.
>  drivers/iio/filter/admv8818.c | 65 ++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index fe8d46cb7f1d..848baa6e3bbf 100644
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
> @@ -411,14 +443,22 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  
>  	if (!st->clkin) {
>  		if (mode == ADMV8818_MANUAL_MODE)
> -			return 0;
> +			goto set_mode;
> +
> +		if (mode == ADMV8818_BYPASS_MODE) {
> +			ret = admv8818_filter_bypass(st);
> +			if (ret)
> +				return ret;
> +
> +			goto set_mode;
> +		}
>  
>  		return -EINVAL;
>  	}
>  
>  	switch (mode) {
>  	case ADMV8818_AUTO_MODE:
> -		if (!st->filter_mode)
> +		if (st->filter_mode == ADMV8818_AUTO_MODE)
>  			return 0;
>  
>  		ret = clk_prepare_enable(st->clkin);
> @@ -434,20 +474,27 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  
>  		break;
>  	case ADMV8818_MANUAL_MODE:
> -		if (st->filter_mode)
> -			return 0;
> +	case ADMV8818_BYPASS_MODE:
> +		if (st->filter_mode == ADMV8818_AUTO_MODE) {
> +			clk_disable_unprepare(st->clkin);
>  
> -		clk_disable_unprepare(st->clkin);
> +			ret = clk_notifier_unregister(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		}
>  
> -		ret = clk_notifier_unregister(st->clkin, &st->nb);
> -		if (ret)
> -			return ret;
> +		if (mode == ADMV8818_BYPASS_MODE) {
> +			ret = admv8818_filter_bypass(st);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> +set_mode:
>  	st->filter_mode = mode;
>  
>  	return ret;

