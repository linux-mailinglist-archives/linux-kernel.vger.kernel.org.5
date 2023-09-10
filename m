Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5F799E84
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjIJNnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjIJNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:43:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A632CC5;
        Sun, 10 Sep 2023 06:43:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E32C433C7;
        Sun, 10 Sep 2023 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694353393;
        bh=VKB2Zghwkxnpc+WRkMi4Xx+Wnp7r+pCTq0asTWKCZ5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O75gjvWAMcy3saA7DqOzBh5CkbH+QM4J7ruBeLcUDnAWUtnBriViU+Fr4PRxAOFzo
         XaqkAWjvallvPP+Mj7Vtmksy0Q/05qFTnudz0S/jHzZqH+69/hWjfrJTJAvkakf1jE
         8KFiU9u47Ozd8fWdxDr8xiRAO2+6Z03i6Xybk3MLgFObPsk6UFng4wvFF1D/CDurxU
         r6icqsksEDmBYtTimQVtLLna/zzbnVfWXFrv9Xi+SRdBJYcwrxgreSWyhoLvsgdNk2
         q3Jd1H8NFEkA2ZW+8FovgJuPlHK6ti1KkWSZWd59w+UfoVEpnra7r4TkctRcr2djMi
         sAKn6uPxNUQ6Q==
Date:   Sun, 10 Sep 2023 14:43:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH V2 RESEND] iio: pressure: ms5637: Use
 i2c_get_match_data()
Message-ID: <20230910144305.17d7df5d@jic23-huawei>
In-Reply-To: <20230903145926.66855-1-biju.das.jz@bp.renesas.com>
References: <20230903145926.66855-1-biju.das.jz@bp.renesas.com>
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

On Sun,  3 Sep 2023 15:59:26 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simplify probe() by replacing id lookup for retrieving match data and
> device_get_match_data() by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v1->v2:
>  * Added Rb tag from Andy
>  * Dropped id variable removal from commit description.
Applied. Thanks,

> ---
>  drivers/iio/pressure/ms5637.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 9b3abffb724b..ac30d76285d1 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -144,7 +144,6 @@ static const struct iio_info ms5637_info = {
>  
>  static int ms5637_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	const struct ms_tp_data *data;
>  	struct ms_tp_dev *dev_data;
>  	struct iio_dev *indio_dev;
> @@ -159,10 +158,7 @@ static int ms5637_probe(struct i2c_client *client)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (id)
> -		data = (const struct ms_tp_data *)id->driver_data;
> -	else
> -		data = device_get_match_data(&client->dev);
> +	data = i2c_get_match_data(client);
>  	if (!data)
>  		return -EINVAL;
>  

