Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA7AEA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjIZKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjIZKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:41:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61EE5;
        Tue, 26 Sep 2023 03:41:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so74347845ad.1;
        Tue, 26 Sep 2023 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695724868; x=1696329668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj6G1FPeamgYBfElta3qoZHccx9xx96N+48SOIoxSIc=;
        b=SV8qmE4vW+bce885ouqRPXO//YiD6yElgfRQTPiezt2evA/kPxw6rIO8MLW0NFcI0H
         +dxR1oBY4zM1ztFN8dfMHGBmfzWYo9KhtUE/RxYRavNY/Lgz7of9AVJJiDU0Gjy/jaG6
         EiZhzo4S6duLfdtkm0pzQfLIyOrJA0uk88rRi+ZtVWFTepLV94OFkx/MpIvTAmBaZk2U
         hP8bkc3GBk5UPp8q4ogs0KhtB8jVVNUc5J8xEU65K/lNu8UIAqVGxQGsMuOO8MN+P173
         RxOWL+ZKdo5NXA2RgWNh3SS40RBrTdbWjL7dTJfsRDMl0emYutxIw47omtKds3cYf953
         A39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724868; x=1696329668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj6G1FPeamgYBfElta3qoZHccx9xx96N+48SOIoxSIc=;
        b=VD22lgZnQ5XUiXH0g1t23IfPCx+yLufwkhv586kmWCeHO0PvTyNbgeuxv5trvVG77c
         Fyb26DHq/+orLqmMfWQDLP37dwtCKamdCSysPHgpYsafc7frz92wqXWFeRjjmNV7J9/f
         H9G8UluZkW35fURwEaznFfxMJ4mmBaBTYTG1YNPmhKIoYU1IGZTwvKdFNMpXi2LL7Nla
         eGKywvkMUPhfhKXLeDQRjDUzUuWQ4osZFxkGBv+pqSsAGNA8J6tS1FyA/aWTTd8Qq4BM
         UaFK5rzVr5JOUQmLLvWi/oOUWjSy39NZLOh39upLY7/UX3WMTJLTCf/FS99Z3pUQ2E+S
         Hizg==
X-Gm-Message-State: AOJu0Yz9V3vmV+sQ4jVNFbynw+o/zZyqUsIuZVPju9Xo2DN9Cmd4uTut
        B/yU6T7sGBYmrsTPH6bSv+o=
X-Google-Smtp-Source: AGHT+IHo4UOrl+ovnhwC0HWOMFO6dlIhUqXGrFAnrdS0ISdnko+qf2F5BkR9v+hT/9K2Xb+ueFctfw==
X-Received: by 2002:a17:902:c409:b0:1b8:954c:1f6 with SMTP id k9-20020a170902c40900b001b8954c01f6mr12402599plk.36.1695724867787;
        Tue, 26 Sep 2023 03:41:07 -0700 (PDT)
Received: from sol (14-201-140-18.tpgi.com.au. [14.201.140.18])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001c62c9d7289sm1539610plb.104.2023.09.26.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:41:07 -0700 (PDT)
Date:   Tue, 26 Sep 2023 18:41:00 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 4/5] gpio: xilinx: Replace bitmap_bitremap() calls
Message-ID: <ZRK1PA2vZBdfAozG@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052007.3917389-5-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:20:06AM +0300, Andy Shevchenko wrote:
> We have sparse and dence masks of the line mappings based on

dense

> the view point (Linux numbering or hardware numbering). Since
> the Linux side uses sequential bits for the mask, we can simply
> convert a Linux number to the hardware one and vise versa by

vice

> counting set bits in the respective mask. Hence replace
> bitmap_bitremap() calls by simpler equivalents.
> 
> With this done the dence mask is not needed and thus dropped.
> 

And dense again.

Cheers,
Kent.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index f103c30cc74f..14ca3097563a 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -46,7 +46,6 @@
>   * @gc: GPIO chip
>   * @regs: register block
>   * @hw_map: GPIO pin mapping on hardware side
> - * @sw_map: GPIO pin mapping on software side
>   * @state: GPIO write state shadow register
>   * @last_irq_read: GPIO read state register from last interrupt
>   * @dir: GPIO direction shadow register
> @@ -62,7 +61,6 @@ struct xgpio_instance {
>  	struct gpio_chip gc;
>  	void __iomem *regs;
>  	DECLARE_BITMAP(hw_map, 64);
> -	DECLARE_BITMAP(sw_map, 64);
>  	DECLARE_BITMAP(state, 64);
>  	DECLARE_BITMAP(last_irq_read, 64);
>  	DECLARE_BITMAP(dir, 64);
> @@ -76,12 +74,12 @@ struct xgpio_instance {
>  
>  static inline int xgpio_from_bit(struct xgpio_instance *chip, int bit)
>  {
> -	return bitmap_bitremap(bit, chip->hw_map, chip->sw_map, 64);
> +	return bitmap_weight(chip->hw_map, bit + 1);
>  }
>  
>  static inline int xgpio_to_bit(struct xgpio_instance *chip, int gpio)
>  {
> -	return bitmap_bitremap(gpio, chip->sw_map, chip->hw_map, 64);
> +	return find_nth_bit(chip->hw_map, 64, gpio);
>  }
>  
>  static inline u32 xgpio_get_value32(const unsigned long *map, int bit)
> @@ -619,9 +617,6 @@ static int xgpio_probe(struct platform_device *pdev)
>  	if (width[1] > 32)
>  		return -EINVAL;
>  
> -	/* Setup software pin mapping */
> -	bitmap_set(chip->sw_map, 0, width[0] + width[1]);
> -
>  	/* Setup hardware pin mapping */
>  	bitmap_set(chip->hw_map,  0, width[0]);
>  	bitmap_set(chip->hw_map, 32, width[1]);
> -- 
> 2.40.0.1.gaa8946217a0b
> 
