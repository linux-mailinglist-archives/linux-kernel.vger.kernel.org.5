Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89976756559
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGQNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872248F;
        Mon, 17 Jul 2023 06:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4806105D;
        Mon, 17 Jul 2023 13:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE0AC433C7;
        Mon, 17 Jul 2023 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689601516;
        bh=RrIpp1g9I8pbqpn0Em/sN4kQbX4y33uGxMDrhbscyAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6myo2isPU0gau6SCW4+yAf955BW5Xcc2wLOzWTgDu6lBhQQsmaMlvnlGCmEmTXUi
         4YMpSnI8lG2lc6ImYCQ8Ec+fBUrwIO2VsIIcbxH3JBOd8c2Vm5N1Txc1X8Y/5gPeM9
         zXgmNSYQxXPIPAnxE0gF7vEstpTzroY8T7dAA4Jk=
Date:   Mon, 17 Jul 2023 15:45:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (oxp-sensors) Refactor init() and remove
 probe()
Message-ID: <2023071739-remedy-sloping-64f6@gregkh>
References: <20230717124013.38796-2-samsagax@gmail.com>
 <20230717124013.38796-5-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717124013.38796-5-samsagax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:40:06AM -0300, Joaquín Ignacio Aramendía wrote:
> Since the driver is not hotpluggable the probe() funtion is not used
> more than once.
> 
> Move all attribute registration logic to the init() function.

Again, as in patch 2/3, you forgot a signed-off-by line.

But this change isn't correct, just because a device is not
hotpluggable, does not mean it should not be using probe/release, in
fact just the opposite, it should be using that and NOT init.

But I understand why you changed the init call in patch 2/3, that is ok,
this isn't because:

> ---
>  drivers/hwmon/oxp-sensors.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index c70d9355eeba..39de49c8a392 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -431,32 +431,20 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
>  	.info = oxp_platform_sensors,
>  };
>  
> -/* Initialization logic */
> -static int oxp_platform_probe(struct platform_device *pdev)
> -{
> -	const struct dmi_system_id *dmi_entry;
> -	struct device *dev = &pdev->dev;
> -	struct device *hwdev;
> -
> -	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> -						     &oxp_ec_chip_info, NULL);
> -
> -	return PTR_ERR_OR_ZERO(hwdev);
> -}
> -
>  static struct platform_driver oxp_platform_driver = {
>  	.driver = {
>  		.name = "oxp-platform",
>  		.dev_groups = oxp_ec_groups,
>  	},
> -	.probe = oxp_platform_probe,
>  };
>  
>  static struct platform_device *oxp_platform_device;
>  
> +/* Initialization logic */
>  static int __init oxp_platform_init(void)
>  {
>  	const struct dmi_system_id *dmi_entry;
> +	struct device *hwdev;
>  
>  	/*
>  	 * Have to check for AMD processor here because DMI strings are the
> @@ -472,10 +460,21 @@ static int __init oxp_platform_init(void)
>  	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>  
>  	oxp_platform_device =
> -		platform_create_bundle(&oxp_platform_driver,
> -				       oxp_platform_probe, NULL, 0, NULL, 0);
> +		platform_create_bundle(&oxp_platform_driver, NULL, NULL, 0,
> +				       NULL, 0);
> +	if (IS_ERR(oxp_platform_device))
> +		return PTR_ERR(oxp_platform_device);
>  
> -	return PTR_ERR_OR_ZERO(oxp_platform_device);
> +	hwdev = devm_hwmon_device_register_with_info(&oxp_platform_device->dev,
> +						     "oxpec", NULL,
> +						     &oxp_ec_chip_info, NULL);

You are creating a fake platform device out of no where here, which is
tied to nothing, which isn't ok.  Keep it in the proper device tree and
have it be passed to you by the driver core in the probe() function.

I think you will see that this changed where in /sys/devices/ your
device is now, right?


> +	if (IS_ERR(hwdev)) {
> +		platform_device_unregister(oxp_platform_device);

Making fake platform devices is generally never a good idea, please
don't do that.

thanks,

greg k-h
