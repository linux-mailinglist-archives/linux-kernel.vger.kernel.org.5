Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2F790BCE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjICMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjICMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E81126;
        Sun,  3 Sep 2023 05:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417C0B80BE6;
        Sun,  3 Sep 2023 12:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52534C433C8;
        Sun,  3 Sep 2023 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693742648;
        bh=tx/Sni1Qy6shqRQZ69OK3LLXaxeqemT3SjGi0r8PGR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JnmRtFLYEhpMvpt9sJ2sSxd8ygl1ndysTAP7id3eLV9+nEvnCpSh/twFjoOImUpI2
         60g2nI5dier9AYiNh05cF9y0ehQN+EXnF1z2kDPJUP3EBut1uIN3OZTy6hWsQdrAt9
         emtng1GxmGLBroMBb0VmiryLPUIE6AoiiNw4/hKQfSwbEhj4v6cS1iE6LjRZzPxhR7
         1OX2e+kdYeZ+1uY5ZSF+v2KQPZFcL8i04P2JZH4On+FCkjKokRNBQkIp8EvxHCFfha
         v3aIyIr2tFD5Jd4loEaipU38zi+4gmFwBoV0i5M8HzyOPip9/eoFURUyCOobejt04V
         u4lkGQW7Y0MvA==
Date:   Sun, 3 Sep 2023 13:04:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: Simplify probe()
Message-ID: <20230903130436.3587abcd@jic23-huawei>
In-Reply-To: <20230902163233.56449-1-biju.das.jz@bp.renesas.com>
References: <20230902163233.56449-1-biju.das.jz@bp.renesas.com>
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

On Sat,  2 Sep 2023 17:32:33 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simpilfy probe() by replacing device_get_match_data() and id lookup for
> retrieving match data by using i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Applied.

> ---
>  drivers/iio/adc/ti-ads1015.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 075c75a87544..9984515bfdea 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -976,16 +976,13 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
>  
>  static int ads1015_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	const struct ads1015_chip_data *chip;
>  	struct iio_dev *indio_dev;
>  	struct ads1015_data *data;
>  	int ret;
>  	int i;
>  
> -	chip = device_get_match_data(&client->dev);
> -	if (!chip)
> -		chip = (const struct ads1015_chip_data *)id->driver_data;
> +	chip = i2c_get_match_data(client);
>  	if (!chip)
>  		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
>  

