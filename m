Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB467908B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjIBQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:36:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A2E8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:36:21 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cTbdqr0ADIQx7cTbeqHwkd; Sat, 02 Sep 2023 18:36:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693672580;
        bh=zi8b3GsNrC+jALwD2EUeiIS6wT/yD6bkTNGFEJTuaMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=a3sgYwvSOAasPXqcs6KhuBoCv9DqhJOaysrCDaA5dsBEjO039vHHmFlSTmlY9AqdM
         pF/9TvjS+e2ufE3m6vKzQnpY447A049KfZf9xJtTfZR58NeDV8EeYHvv6xpRuUhDu6
         SQZyNrirF/QqouYKH4Hni8bJJh2e3XNlXbzC00W1z3zX5lrnwPmSMRV3N8HN2NXgN+
         UAWBYy1LgasWz2wMY9c/6En0aJ0tYUSEwbcvAC5WqW81OkrYVVmOnA23PxhjzMDiwy
         5TDBUCAOcFvH1pNU+ccmrpWmaacP5c/ucr0v3PSCsdSaK3l219sQr44CUeokKJHebW
         tAaPKUuAwPi5A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 18:36:20 +0200
X-ME-IP: 86.243.2.178
Message-ID: <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
Date:   Sat, 2 Sep 2023 18:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Content-Language: fr
To:     =?UTF-8?Q?linux=40weissschuh=2enet_=3e=3e_Thomas_Wei=c3=9fschuh?= 
        <linux@weissschuh.net>
Cc:     dgilbert@interlog.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@roeck-us.net
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
> POWER-Z is a series of devices to monitor power characteristics of
> USB-C connections and display those on a on-device display.
> Some of the devices, notably KM002C and KM003C, contain an additional
> port which exposes the measurements via USB.
> 
> This is a driver for this monitor port.
> 
> It was developed and tested with the KM003C.
> 
> Signed-off-by: Thomas Weißschuh <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
> ---

...

> +static int powerz_probe(struct usb_interface *intf,
> +			const struct usb_device_id *id)
> +{
> +	struct powerz_priv *priv;
> +	struct device *hwmon_dev;
> +	struct device *parent;
> +
> +	parent = &intf->dev;
> +
> +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!priv->urb)
> +		return -ENOMEM;
> +	mutex_init(&priv->mutex);
> +	priv->status = -ETIMEDOUT;
> +	init_completion(&priv->completion);
> +
> +	hwmon_dev =
> +	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
> +						 &powerz_chip_info, NULL);
> +	usb_set_intfdata(intf, priv);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);

Hi,

If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.

CJ

> +}
> +

...
