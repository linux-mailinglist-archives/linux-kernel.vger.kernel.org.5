Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90AA7D9A67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbjJ0NtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbjJ0NtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:49:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343E18A;
        Fri, 27 Oct 2023 06:49:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8CC433C8;
        Fri, 27 Oct 2023 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698414559;
        bh=DtoBfgUD9SXkRxzblhXcctUN6fwy02Tc6e40hMWArIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cwltWJ88666iLYUDxm4x1q3aEqU0LbdobISa/NGKQHcg9u1TUKe3UEq/ybSAUUnq4
         fnpFmCzj5K/djXjLyRkKRMHOSomJ1M0rv6NvXu7/gxXJ6RWVl1Qh7uHdpEivNLqSsb
         X66HPhj5Ifx5vGWnrk+LCKdUGbQh/TMEyBAgHUaUaHt2nKl9j0f7bU5xhNIt9daJuo
         EV++XjT9NZwyBFYLdGsW5bV90e2hP2HkH3vaIJrRBE/omXPpQuWrGa5/NkW3cJ5wf2
         ab/6ecq0YQZCvtvMJz6Ab5T4s0pfiFzt6UjThPe7DyzaCEWz6/exdlJ3VJx9A7/ngM
         pntSIy96UrR1g==
Date:   Fri, 27 Oct 2023 14:48:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Add support for BMP390
Message-ID: <20231027144843.623dc141@jic23-huawei>
In-Reply-To: <d6a9e9ca4670c7401545d0d086cd3059e29044c8.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
        <d6a9e9ca4670c7401545d0d086cd3059e29044c8.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 19:22:21 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Add BMP390 device ID to the supported IDs on bmp380 sensor family
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it.

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index deb336781b26..c6c761e84006 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -13,6 +13,7 @@
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp390-ds002.pdf
>   * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp581-ds004.pdf
>   *
>   * Notice:
> @@ -1225,7 +1226,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
>  static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
> -static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID };
> +static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
>  
>  const struct bmp280_chip_info bmp380_chip_info = {
>  	.id_reg = BMP380_REG_ID,
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index a230fcfc4a85..2971bf58f802 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -292,6 +292,7 @@
>  #define BMP580_CHIP_ID_ALT		0x51
>  #define BMP180_CHIP_ID			0x55
>  #define BMP280_CHIP_ID			0x58
> +#define BMP390_CHIP_ID			0x60
>  #define BME280_CHIP_ID			0x60
>  #define BMP280_SOFT_RESET_VAL		0xB6
>  

