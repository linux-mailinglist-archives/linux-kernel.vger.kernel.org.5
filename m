Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7B37CE799
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjJRTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJRTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84722114;
        Wed, 18 Oct 2023 12:20:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7300BC433C7;
        Wed, 18 Oct 2023 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697656805;
        bh=mLpZTsjbH1oZAruNAaAWMqbAcvfjHo5jimN4dXHpcuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cxcwwC32kJeRoubZdXCD5Ox6CFDVGJA7FazswfHZuXDlGIUoOcMcRIqhzLZSvWW8T
         NXXAiOYikRlG1wSe+B/6iZnMuoRYhvC7ZOkMlHWnR6kh33bc1/Vu4tzdgN50mHAhlI
         sXB/JnSxvCRyTtDAHYxALUAT0Ig/iOyop6+DIQiPASrNRIFqeqCpcyH6ELOgZgp7i8
         zjjJPTFtYBXYa4iYHhY/eF5ruZukvVOHt/SsAdSBAuvD2pnjIbLq9CdN9uSSz2TB3X
         TM8s5IC/grZKTjXs3/5Ok5dHZIhpxRZ21vJIqiIvqempIQO3DyncGdldGFdL1AOApY
         PpwHM6LaCb+bA==
Date:   Wed, 18 Oct 2023 20:20:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bmp280: fix eoc interrupt usage
Message-ID: <20231018202024.36aabbc1@jic23-huawei>
In-Reply-To: <20231018152816.56589-1-ak@it-klinger.de>
References: <20231018152816.56589-1-ak@it-klinger.de>
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

On Wed, 18 Oct 2023 17:28:16 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> distinguish the case in which the interrupt is set.
> 
> Fix the if statement so that only when the interrupt is set and the chip
> id is recognized the interrupt is requested.
> 
> This bug exists since the support of EOC interrupt was introduced.
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> 
> Also add a link to bmp085 datasheet for reference.
> 
Fixes tag is part of the tags block so needs to be down here.
> Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

However, it's also already fixed upstream I think.
That's not filtered back around to my togreg branch though as that has an outstanding
pull request.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6089f3f9d8f4..9b7beeb1c088 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -9,6 +9,7 @@
>   * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
>   *
>   * Datasheet:
> + * https://www.sparkfun.com/datasheets/Components/General/BST-BMP085-DS000-05.pdf
>   * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
> @@ -2179,7 +2180,7 @@ int bmp280_common_probe(struct device *dev,
>  	 * however as it happens, the BMP085 shares the chip ID of BMP180
>  	 * so we look for an IRQ if we have that.
>  	 */
> -	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
> +	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
>  		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
>  		if (ret)
>  			return ret;

