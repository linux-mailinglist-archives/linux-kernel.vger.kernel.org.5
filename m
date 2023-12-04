Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBB8038A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjLDPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjLDPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:23:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B30C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:23:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC14C433C7;
        Mon,  4 Dec 2023 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701703390;
        bh=v9HHvcP+5Qmgs8vOwwtctHKS8YafaG9blaZ4o+1KOkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jDBKfr+3DhZ3aeR9N1JjGZsaFWKv9q1J/2v3sVT4Pm6kkyE7apm0zJGFeENTzDoUl
         AGjP4IATo+ytQW9WW3M6zndzZr31v3rrsWjpmL2wzWWL9hSEGIgs8Zq1FSH0FKZY0X
         mAdZTg0vRjvLLzCRoHCBrBAYRRWtNRyLMKjA5SbKxR4ZapV5Pqu4XOyQydB0MRNYPt
         341gpuGi6c/is6XEo+RBDslYzXfGmX3FGsKPZSOV9aZ7uckOKB0LpHDiTVsR9V/6MW
         9R392iaMgdn7bd/Eyl1zvuhhRlQyyqMMpXV6YRJu9oIpSirTXhuPHKR6hTGwNPBkR0
         elNCR0o1y2cHQ==
Date:   Mon, 4 Dec 2023 15:23:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc:     <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204152301.6c212539@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
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

On Tue, 21 Nov 2023 11:20:19 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> are done which means we need to properly protect the whole operation so
> we are sure we will be in a sane state if two concurrent calls occur.
> 
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 04474dbfa631..91821dee03b7 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> -
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
> @@ -122,6 +122,8 @@ struct ad9467_state {
>  	unsigned int			output_mode;
>  
>  	struct gpio_desc		*pwrdown_gpio;
> +	/* protect against concurrent accesses to the device */
Not very specific.  Concurrent access usually fine at granularity of
individual read/write as the bus locks protect it.  What state
is actually being protected?  A shared buffer or some state that we
need to ensure remains consistent between driver and device?

> +	struct mutex			lock;
>  };
>  
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
>  	int ret;
>  
>  	if (!readval) {
> +		guard(mutex)(&st->lock);
>  		ret = ad9467_spi_write(spi, reg, writeval);
>  		if (ret)
>  			return ret;
> @@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  		if (scale_val[0] != val || scale_val[1] != val2)
>  			continue;
>  
> +		guard(mutex)(&st->lock);
>  		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
>  				       info->scale_table[i][1]);
>  		if (ret < 0)
> 

