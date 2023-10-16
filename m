Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0C7CAA89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjJPNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJPNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:55:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC363EB;
        Mon, 16 Oct 2023 06:55:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D34C433C7;
        Mon, 16 Oct 2023 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697464523;
        bh=0yiuMspPwLpIVtahu6CyE1/zM4ZcZrYi/mvg9LDr9ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+9vFEXwiNmSlKNIO/JIfd+flMeyXnMoUltYCdk0YKitkj3KZ5F8CSephZk8PlZtz
         UKCbGtdCwguKOHwH0nw6mmG0uKmhjiDQNy5I+9TJc92JRTHDn6f9ud9KCAoZa0u0FZ
         po+IfCUBm7z+BLgEXPoSg/xhk1RBJLZ/KZJQpKSbsQaG44yHuE0N3j9IottZd/svjN
         acfmmnEI/c2vu2W6TWuxG33o0E3W0VnDwxw8EndH5jYzxIA8ZLG+Qp4Bil6KBO7a18
         Aryu9bzXCh0HD3Sn6y3ol7jYNMh4yuQdYg3o2SzmnGSSw2AIcT9YdJvCNIvLNonu+X
         4dv5Wb2S/h+cA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsO3x-0004Ff-2S;
        Mon, 16 Oct 2023 15:55:18 +0200
Date:   Mon, 16 Oct 2023 15:55:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] gnss: ubx: add support for the reset gpio
Message-ID: <ZS1AxSRL4F5WBvnC@hovoldconsulting.com>
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921133202.5828-4-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:32:01PM +0200, Wolfram Sang wrote:
> Tested with a Renesas KingFisher board. Because my GNSS device is hooked
> up via UART and I2C simultaneously, I could verify functionality by
> opening/closing the GNSS device using UART and see if the corresponding
> I2C device was visible on the bus.

Again, please try to make the commit message self-contained (e.g.
without implicitly referring to Subject).

Also say something about which u-blox module this is needed for since
the modules I've seen do not have a reset line.

>  static int ubx_set_active(struct gnss_serial *gserial)
> @@ -29,6 +31,8 @@ static int ubx_set_active(struct gnss_serial *gserial)
>  	if (ret)
>  		return ret;
>  
> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
> +
>  	return 0;
>  }
>  
> @@ -37,6 +41,8 @@ static int ubx_set_standby(struct gnss_serial *gserial)
>  	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
>  	int ret;
>  
> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +
>  	ret = regulator_disable(data->vcc);
>  	if (ret)
>  		return ret;
> @@ -90,6 +96,13 @@ static int ubx_probe(struct serdev_device *serdev)
>  	if (ret < 0 && ret != -ENODEV)
>  		goto err_free_gserial;
>  
> +	/* Start with reset asserted */
> +	data->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->reset_gpio)) {
> +		ret = PTR_ERR(data->reset_gpio);
> +		goto err_free_gserial;
> +	}

So this means that the reset line will be asserted indefinitely in case
the GNSS receiver is not used. Are you sure that's a good idea?

I don't know yet which module this is for, or how this signal is
supposed to be used, but the above makes this look more like an
active-high (regulator) enable signal. Perhaps that's what it is or
should be modelled as (i.e. as a fixed regulator).

> +
>  	ret = gnss_serial_register(gserial);
>  	if (ret)
>  		goto err_free_gserial;

Johan
