Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C1E80BA9C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjLJMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:13:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED5FF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:14:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27574C433C8;
        Sun, 10 Dec 2023 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702210444;
        bh=w+3+1upKrVtvIx2PiepHgbXPe0wVAPtc2OFDZJESmZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EqsbGlh1t9W5pRLywQpDXzEQhqN2jiIizhpb/SN5yS99AQqoOC+kUqEs7WPVtMver
         X/0KIj9n7++DV8Rmh0jByMbluIO5MisALPoFI1N8ESLulVwteVUfdBizvAuw7n/IUe
         G01RC2bOOnA883H2Uua+cAIF6ObjxfLLUbs4HDCLtDZnb9nYdsrAn/sVc/GeYG8CoX
         kGY2JvB0q+oEmNOWOwRJzwhXY+KXR55vSKeuZEBJY5JHg+x+UUywHiIgyD7hJH0B8B
         xJU+y7EvR4J/QUBQCxO9Db54eUH/2wxKJWuCsQvHzBvVqKI4flhZwaGxw/ZfGhT62c
         NXMIRAUdzM1Dw==
Date:   Sun, 10 Dec 2023 12:13:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] iio: adc: ad7091r: Set alert bit in config
 register
Message-ID: <20231210121356.16b8ef24@jic23-huawei>
In-Reply-To: <e392ad7b78c1d6244f605f4de2755b1adf3ab2ec.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
        <e392ad7b78c1d6244f605f4de2755b1adf3ab2ec.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Thu, 7 Dec 2023 15:38:53 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ad7091r-base driver sets up an interrupt handler for firing events
> when inputs are either above or below a certain threshold.
> However, for the interrupt signal to come from the device it must be
> configured to enable the ALERT/BUSY/GPO pin to be used as ALERT, which
> was not being done until now.
> Enable interrupt signals on the ALERT/BUSY/GPO pin by setting the proper
> bit in the configuration register.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Also a fix?  Feels like people expect this to work but I guess we could
in theory call it a 'feature' given it never did :)

Jonathan

> ---
>  drivers/iio/adc/ad7091r-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 0f192fbecbd4..6056a66d756c 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -28,6 +28,7 @@
>  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
>  
>  /* AD7091R_REG_CONF */
> +#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
>  #define AD7091R_REG_CONF_AUTO   BIT(8)
>  #define AD7091R_REG_CONF_CMD    BIT(10)
>  
> @@ -232,6 +233,11 @@ int ad7091r_probe(struct device *dev, const char *name,
>  	iio_dev->channels = chip_info->channels;
>  
>  	if (irq) {
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
> +		if (ret)
> +			return ret;
> +
>  		dev_set_drvdata(st->dev, iio_dev);
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  				ad7091r_event_handler,

