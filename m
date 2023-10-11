Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A77C5769
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346770AbjJKOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjJKOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:51:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD804C0;
        Wed, 11 Oct 2023 07:51:07 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7abe4fa15ceso651627241.1;
        Wed, 11 Oct 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035867; x=1697640667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luFeyCZkkt4/O38U11aEApTd7HASt8V3OjghJ24r4tA=;
        b=BG2D5yW09TzwqNrcLUZHoNAGyXh7VN+Wwr9HzyFJ0X8wIuY3iaUyOf7/BbI9u7RH1w
         INviISEqQnQ/5Adcx2Qwd08x40I953E8W2+mD1fqHSiW/VqSLS2vVRj9nbm7sqypmA1f
         +KLsBUz3PHCe86EWSi8hMn/Dm1YJbOrzsE7mzkQuU2Mr9TwcYlKX7lXoITYIj41lVmzq
         ZV+gWLdmwSMHObJUZpV5ELu/id0VgkRbRI5AajFj3NfnEZp8ZHDOz7oHp17MuDDda2ou
         ogEx5An4iYgPpuQ1AsrfAyfenwbbDPFottwQx+3GsFJpKuXsNvtIRzvtyOWZjExKkS46
         LxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035867; x=1697640667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luFeyCZkkt4/O38U11aEApTd7HASt8V3OjghJ24r4tA=;
        b=Y0zJiJ0SOFBJ9f53UO+UKQ0AcnO+am90NemehZndzS6F+shz8iXH1LcbsRvWjxTsaj
         PbBbeP9QyH16Rc6C5vh55+IO8BtUsfM74YcjoVqbM8YYp+7EEHGJJfKOBcxVHf742I91
         k9Hw0mPseFX/n1o2k9uPu+Mthd3Zk4K12JUfGsIYtrGIW7shUUqYCYlH2l0EcEVWivZV
         y99RYaSDCN9V9SRJ09ewnMqDB8dMkksH3aYlCMR2zTXZb7m1a0gP93I9rKYM5P4kTGmr
         ZtBvD5eOr3R2D/uoAPS8KIzzsPIy64az2f0Le8XR6s7ToXmv0ObaVudyTBzkDNO+qoGv
         v0LQ==
X-Gm-Message-State: AOJu0YydDM77htC++d9BNr8U3t4SdKT4K9fdzb4EhBp3Bgszsxkx+RfQ
        qkgs1lhSL5qyIUVF69Esz3I=
X-Google-Smtp-Source: AGHT+IFJTkcxd+plbm+YR85kJFjieunHEaxmwhn1lkYJNeoTZaH2IP+S/KZSg5po+2pmwNk1Ojpv5g==
X-Received: by 2002:a1f:e401:0:b0:49a:a6c8:c815 with SMTP id b1-20020a1fe401000000b0049aa6c8c815mr11215596vkh.6.1697035866068;
        Wed, 11 Oct 2023 07:51:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020ac5cdc9000000b00495ba15ed09sm2552378vkn.8.2023.10.11.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:51:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 07:51:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, inux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: watchdog: marvell_gti: fix zero pretimeout
 handling
Message-ID: <2842d7d6-2bc8-4ee6-8817-789ab7f20eec@roeck-us.net>
References: <20231009044037.514570-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009044037.514570-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:10:36AM +0530, Bharat Bhushan wrote:
> When pretimeout is set to 0 then do not reprogram timer
> with zero timeout, this will reset device immediately.
> Also disable interrupt to stop pretimeout notification.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/marvell_gti_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> index d7eb8286e11e..25b7ce0f0738 100644
> --- a/drivers/watchdog/marvell_gti_wdt.c
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -190,6 +190,13 @@ static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
>  	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  	struct watchdog_device *wdog_dev = &priv->wdev;
>  
> +	if (!timeout) {
> +		/* Disable Interrupt */
> +		writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
> +		       priv->base + GTI_CWD_INT_ENA_CLR);
> +		return 0;
> +	}
> +
>  	/* pretimeout should 1/3 of max_timeout */
>  	if (timeout * 3 <= wdog_dev->max_timeout)
>  		return gti_wdt_settimeout(wdev, timeout * 3);
> -- 
> 2.34.1
> 
