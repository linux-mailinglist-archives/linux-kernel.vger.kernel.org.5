Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413697F8C80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjKYQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:44:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00794FF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:44:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B31C433C7;
        Sat, 25 Nov 2023 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700930653;
        bh=x3bZImpG/T/VeEsQdG09Wf8mRYw2KVFi2C7qJH6OKWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d+65TYoKqSuMmz8AsGRk/m6ZCRj2WTInxxXK4ztcZ+IhxSCXJQ9zatgP5WJ0EBvoO
         dbArQ18IyA7pzwIBnswZYZpnAURGC5wbdSFHzzRyS81sfzlQCxB17X7jsGDDShNyaY
         fEWSLwAi223pSz6E8eeBi/8Cx/PgxtE70Q2D7nw/IimUBC54183cL/c72ZQCuhHJnc
         gpPDwFEL9JfClCTQ0OaegJaN0xdCUq6Ydd5fxIPtVxAZtYB+IikUppEZcnyvxu9eKt
         myvnhUNtlHOcTzxxxhI/d4UPjJJm8IrotI13IbPywsjWZSvD7+4D2A7s1GlqF0HOjG
         0NgkY3Lfkwq2Q==
Date:   Sat, 25 Nov 2023 16:44:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: adc: ad7091r-base: Add debugfs reg access
Message-ID: <20231125164404.64072ffb@jic23-huawei>
In-Reply-To: <271203e245d324f94678d212e4daf13386bee463.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
        <271203e245d324f94678d212e4daf13386bee463.1700751907.git.marcelo.schmitt1@gmail.com>
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

On Thu, 23 Nov 2023 13:43:06 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add direct register access support for AD7091R-2/-4/-5/-8 ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

regmap provides it's own version of this, so I'm not sure I'd bother adding
the IIO one. See regmap-debugfs.c


> ---
>  drivers/iio/adc/ad7091r-base.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index dbc60ea1bafc..4d5051316428 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -177,8 +177,20 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
>  	return ret;
>  }
>  
> +static int ad7091r_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad7091r_state *st  = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->map, reg, readval);
> +
> +	return regmap_write(st->map, reg, writeval);
> +}
> +
>  static const struct iio_info ad7091r_info = {
>  	.read_raw = ad7091r_read_raw,
> +	.debugfs_reg_access = &ad7091r_reg_access,
>  };
>  
>  static irqreturn_t ad7091r_event_handler(int irq, void *private)

