Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E88017CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjLAXfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjLAXfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:35:14 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B71B3;
        Fri,  1 Dec 2023 15:35:19 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58d521f12ebso1567151eaf.2;
        Fri, 01 Dec 2023 15:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701473719; x=1702078519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqmfDA6O54prcJnxC3J6dq1u6qKHwn493IjE704DgVU=;
        b=QRiX0Ti0fvhNHVBNPlFx99AmOhxJAr/455TBI+33JmpktjoEiQLmAndu6JycvREqSQ
         HN1co6/2z6iw64j2VJLY6QtCI0+qQtz4X0Querfv9SfAHoKrTTtJp4jYM7ZEwp5UiUnN
         8Vcxi/Od90WE+KwIcLI6v8Uhui3GqCckiU2sJcAa1FFqsRHkkeMvzh60bZKCbqOx8khw
         3kJu5rEvGjQIqicSPhg40JdMjbosMmVfOJnKe9D2yKcyu1kmB47LdkCnjWOmNFukSlz/
         RVBtDxBbcOKTsyggXpNflLIUCaHEFmGzCw5jcT6m1ftLdokJ5XgA2s1yb8/2raHTg4zk
         7a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473719; x=1702078519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqmfDA6O54prcJnxC3J6dq1u6qKHwn493IjE704DgVU=;
        b=Wpl0Fj5anQ3XAyUMtPKOMH8CUVamK6VQZSJaSZiTFF9R8/A5WPZSTeaQaIP5TdN3Y7
         9ueIZl7h9xfT3L785StMDxAdI/jypOmxCXRyCSGUhIzRw2Ac5jLLaKx7bHA2S+roBJDS
         yNic/F2t0w6PvAX5SCor5aX+f7IqrJtCrUSjRddoXoYFtsfT55hUi/mCdGNdCt+SA4Cn
         +kOn63nhOkZlJ3oJIxWhHO2HrZDyZbKt7TNZ2aozOKpK8TFQpjGiccSSFYO9O2SgvfoI
         rjro1DhNWX+AfFT7SyyRBfEzJP+di3ssLSYCKr+E61BKUGWkMpWjy+bEj4aILd79rpsF
         QKuA==
X-Gm-Message-State: AOJu0Yw6jliTm/X1gAlyGdhiN/yDygomPZqDv5IwdiW6vmKzBqpP7AS9
        8G3ilXeIM+wSqTpjm/DmyXtrlexKq5I=
X-Google-Smtp-Source: AGHT+IEsIckg5IRofzfy+td5HN1EX1DsN8omXF6YRg/N2UOCObTBv3E9qM5zuwFoOS2ny3TA/xcKmw==
X-Received: by 2002:a05:6358:8806:b0:16b:fbd6:9bab with SMTP id hv6-20020a056358880600b0016bfbd69babmr383162rwb.32.1701473718998;
        Fri, 01 Dec 2023 15:35:18 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1900:8815:33a8:c99c])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b00283991e2b8esm3983361pjc.57.2023.12.01.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:35:18 -0800 (PST)
Date:   Fri, 1 Dec 2023 15:35:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: pxrc - simplify mutex handling with guard macro
Message-ID: <ZWpttAT6az4yYb91@google.com>
References: <20231201-pxrc-guard-v2-1-714779672bc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-pxrc-guard-v2-1-714779672bc8@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 02:17:13PM +0100, Marcus Folkesson wrote:
> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> Changes in v2:
> - Add guard in pxrc_open()
> - Link to v1: https://lore.kernel.org/r/20231201-pxrc-guard-v1-1-38937e657368@gmail.com
> ---
>  drivers/input/joystick/pxrc.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index ea2bf5951d67..d4b699418361 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
> @@ -5,15 +5,17 @@
>   * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
> -#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
>  #include <linux/uaccess.h>
> +
>  #include <linux/usb.h>
>  #include <linux/usb/input.h>
> -#include <linux/mutex.h>
> -#include <linux/input.h>
>  
>  #define PXRC_VENDOR_ID		0x1781
>  #define PXRC_PRODUCT_ID		0x0898
> @@ -83,31 +85,26 @@ static int pxrc_open(struct input_dev *input)
>  	struct pxrc *pxrc = input_get_drvdata(input);
>  	int retval;

Now that we are not returning "success" and only carry error codes
in this variable we should call it "error".

>  
> -	mutex_lock(&pxrc->pm_mutex);
> +	guard(mutex)(&pxrc->pm_mutex);
>  	retval = usb_submit_urb(pxrc->urb, GFP_KERNEL);
>  	if (retval) {
>  		dev_err(&pxrc->intf->dev,
>  			"%s - usb_submit_urb failed, error: %d\n",
>  			__func__, retval);
> -		retval = -EIO;
> -		goto out;
> +		return -EIO;
>  	}
>  
>  	pxrc->is_open = true;
> -
> -out:
> -	mutex_unlock(&pxrc->pm_mutex);
> -	return retval;
> +	return 0;
>  }
>  
>  static void pxrc_close(struct input_dev *input)
>  {
>  	struct pxrc *pxrc = input_get_drvdata(input);
>  
> -	mutex_lock(&pxrc->pm_mutex);
> +	guard(mutex)(&pxrc->pm_mutex);
>  	usb_kill_urb(pxrc->urb);
>  	pxrc->is_open = false;
> -	mutex_unlock(&pxrc->pm_mutex);
>  }
>  
>  static void pxrc_free_urb(void *_pxrc)
> @@ -208,10 +205,9 @@ static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
>  {
>  	struct pxrc *pxrc = usb_get_intfdata(intf);
>  
> -	mutex_lock(&pxrc->pm_mutex);
> +	guard(mutex)(&pxrc->pm_mutex);
>  	if (pxrc->is_open)
>  		usb_kill_urb(pxrc->urb);
> -	mutex_unlock(&pxrc->pm_mutex);
>  
>  	return 0;
>  }
> @@ -221,11 +217,10 @@ static int pxrc_resume(struct usb_interface *intf)
>  	struct pxrc *pxrc = usb_get_intfdata(intf);
>  	int retval = 0;
>  
> -	mutex_lock(&pxrc->pm_mutex);
> +	guard(mutex)(&pxrc->pm_mutex);
>  	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
>  		retval = -EIO;

		return -EIO;
>  
> -	mutex_unlock(&pxrc->pm_mutex);
>  	return retval;

	return 0;

Thanks.

-- 
Dmitry
