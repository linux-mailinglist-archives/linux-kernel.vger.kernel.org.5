Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7580AC5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjLHSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjLHSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:44:37 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11B10F8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:44:41 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8BD70240106
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 19:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1702061078; bh=gdJEGxQD1dyTYKJxTTItwkIZdG3P5X6tnnWz/BIIbGw=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=amw0D/zBG/8sz8L4nO/+ln4b5LjUMs1PA4MawALRr6ZpulJNfzf/bPIOmnZSmy8Li
         RcykgmhG4a28WzK3OkBQQqb1kWsOVXeS8bBDZB7Jyo/ER+EGyiTWgJi6lzH6gI1LEM
         h/ZyoVDY+iKFTML//fBtr54MbX7b/SHT1BC7tq+IL7uJJ2z1bQ/6eJoPVoDKHxKpcA
         dSAfNGMNJxpu+KYx4588/x6ryy+5JSoaz4/YjIiRSFmL3WFd8uBPf3LQYCiG4OTprs
         fs0X7UmXa7GwS5sMsrzloIwPViRiOtAyXN34GjrXTWlG3N2NlA6rGq0J2XEK+AsK7X
         1HDafKZLDiQhw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Sn0Rn1jvRz6txc;
        Fri,  8 Dec 2023 19:44:37 +0100 (CET)
Date:   Fri,  8 Dec 2023 18:44:36 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix probe when built-in
Message-ID: <20231208194436.37e62928@posteo.net>
In-Reply-To: <20231207210723.222552-1-W_Armin@gmx.de>
References: <20231207210723.222552-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 22:07:23 +0100
Armin Wolf <W_Armin@gmx.de> wrote:

Just forgot. Did both, works just fine. Is it okay that way? This is my first
time.

Tested-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

> It seems that when the driver is built-in, the HID bus is
> initialized after the driver is loaded, which whould cause
> module_hid_driver() to fail.
> Fix this by registering the driver after the HID bus using
> late_initcall() in accordance with other hwmon HID drivers.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/corsair-psu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 904890598c11..2c7c92272fe3 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -899,7 +899,23 @@ static struct hid_driver corsairpsu_driver = {
>  	.reset_resume	= corsairpsu_resume,
>  #endif
>  };
> -module_hid_driver(corsairpsu_driver);
> +
> +static int __init corsair_init(void)
> +{
> +	return hid_register_driver(&corsairpsu_driver);
> +}
> +
> +static void __exit corsair_exit(void)
> +{
> +	hid_unregister_driver(&corsairpsu_driver);
> +}
> +
> +/*
> + * With module_init() the driver would load before the HID bus when
> + * built-in, so use late_initcall() instead.
> + */
> +late_initcall(corsair_init);
> +module_exit(corsair_exit);
> 
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
> --
> 2.39.2
> 

