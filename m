Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966A800BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjLAN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbjLAN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:28:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC62197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:28:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D0C433C7;
        Fri,  1 Dec 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701437327;
        bh=Qpt/aNUBs3S/L2cKojCHHUwbYv5eELV0YcgOZU1TGKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMXOQXidhON+jm5+n6xuu+kOTqu4R0ycQTD2qewfdiBSBDFqVQQPKY+nyYMgirEof
         3MKlC31acfD1/9i8FlBrXve9/GZ27NXryKzAPkZlcg5iII4wGMG2s8mQVDBvzM72dy
         uAyMzPZerMy255H2xgLj3iplnZBMiUKOnOmZUVj/tGaL6+OFHft0IuAEnBMVu0/yGD
         8Hp6Aq5J+hgDqUQ+ZmOSPaN5EGgV59xjkUPkklU2VUAp9Azk71TUX9UArFXew84o2q
         qwFXJz4UppDfioAZQJXLU2V7HCAi3BTZER7PNdhRrfa88waMqDhmdzAf9kaQbm3X5i
         UrhqiZVsOGflw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r93a6-0001z3-3B;
        Fri, 01 Dec 2023 14:29:23 +0100
Date:   Fri, 1 Dec 2023 14:29:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pxrc - simplify mutex handling with guard macro
Message-ID: <ZWnfsjIukIbAvQ-l@hovoldconsulting.com>
References: <20231201-pxrc-guard-v1-1-38937e657368@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-pxrc-guard-v1-1-38937e657368@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:08:45PM +0100, Marcus Folkesson wrote:
> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

A couple of drive-by comments below.

> ---
>  drivers/input/joystick/pxrc.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index ea2bf5951d67..3c3bf7179b46 100644
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

Looks like an unrelated change.
  
>  #define PXRC_VENDOR_ID		0x1781
>  #define PXRC_PRODUCT_ID		0x0898
> @@ -89,25 +91,20 @@ static int pxrc_open(struct input_dev *input)
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

Eh, this looks obviously broken. Did you not test this before
submitting? I assume lockdep would complain loudly too.

You're apparently the author of this driver and can test it, but I fear
the coming onslaught of untested guard conversions from the "cleanup"
crew. Not sure I find the result generally more readable either.

Johan
