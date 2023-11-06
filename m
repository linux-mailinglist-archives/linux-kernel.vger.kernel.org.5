Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E2B7E26BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjKFOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjKFOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:25:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4A9C6;
        Mon,  6 Nov 2023 06:25:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C91C433C8;
        Mon,  6 Nov 2023 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699280722;
        bh=HY3kSLldl7rK8Qt1R1njkwITH3UB/c7/iTo+eGw2/5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfuahSDA/ik+wqTm44m7fP26rdFTxfGHXXZAKtyCwwZL+BxZTfimvszIss7cGXVMK
         kta0oN61FDmSKiy356qtTiM36ZO08ms5xIsA/Wdu3q5PiG+VeFI5HGGD0BrCdwv3ry
         Uiw0Q1gnPy4/4MXy6Y0Zr4iTtshf0OMxdXWVrTvc3zYo3pNLPnO8MTS5H+l0yZfAn0
         CVi2wIg/VJ8PGrZMoBZ4SVGP1lC1Rf1cli4TI36cIxzjPv6MaPFEgtZSyEd/aV3gR3
         JBvEwolJGEI4j3CM3NHHGz7cQt5ObIFJSE0aHoePGuSNLHbPOj3J0pXIuu2eEt/nhK
         0+dPGI19MJMfw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r00YJ-0000Ob-2S;
        Mon, 06 Nov 2023 15:26:08 +0100
Date:   Mon, 6 Nov 2023 15:26:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] gnss: ubx: add support for the reset gpio
Message-ID: <ZUj3fzArgPU4kYYT@hovoldconsulting.com>
References: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
 <20231103225601.6499-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103225601.6499-4-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 11:56:00PM +0100, Wolfram Sang wrote:
> The Renesas KingFisher board includes a U-Blox Neo-M8 chip. This chip
> has a reset pin which is also wired on the board. Add code to the driver
> to support this reset pin. Because my GNSS device is hooked up via UART
> and I2C simultaneously, I could verify functionality by opening/closing
> the GNSS device using UART and see if the corresponding I2C device was
> visible on the bus.

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
> +
>  	ret = gnss_serial_register(gserial);
>  	if (ret)
>  		goto err_free_gserial;

So as I just replied to you v3, the hardware integration manual for
NEO-M8 and the datasheets for some of the other modules explicitly says
that the RESET_N pin should not be used this way:

	1.5 I/O pins
	RESET_N: Reset input
	Driving RESET_N low activates a hardware reset of the system.
	Use this pin only to reset the module. Do not use RESET_N to
	turn the module on and off, since the reset state increases
	power consumption.

(and AFAIU you should generally not try to use reset this way unless it
is explicitly said to be supported).

Johan
