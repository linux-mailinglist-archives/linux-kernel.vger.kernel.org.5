Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F17F6308
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjKWPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbjKWPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:31:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F22685
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:30:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90959C433C8;
        Thu, 23 Nov 2023 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700753409;
        bh=avgYEc93ApUK2Dzi3scbMqpE6rCFepWGHT458CNWr+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8QI/NqBRq9tkrGu49K+/wXCmT4ev5yg810qwbTqPBeY3ZriGGhS0M3di2nN767Jy
         tYSjYJtAC+o5p1MueWDmddKNCbmj4UHctH1fO5vu8NlE2O/a162qK9C4ZENKfLbXwl
         n3StP2QJm6O9rN3clcozy2xo2WYdpcykJ/9SVVGzrelIHQQ/w1op8Ay8cYPFOG20Rf
         4CYw8CXqPUuJagg/ehxJ1xwcKB5vvEhR0GL7a3FU8PscNiOjp7qO9sjzd24ettppJS
         euzzNtRHrTaQgXUTvoXyhzrQC4XDxlPbcBgwqCx2Vzc8fSuLih7xfeCZ3UVu2d2Tw2
         mNUfQ950cbDSQ==
Date:   Thu, 23 Nov 2023 15:30:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: wm831x: Remove redundant forever while loop
Message-ID: <20231123153005.GD1354538@google.com>
References: <20231120102259.74210-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120102259.74210-1-mstrozek@opensource.cirrus.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, Maciej Strozek wrote:

> Current code excutes only once despite the while loop, so remove the
> loop. Also msleep(1) will likely result in a larger sleep, so increase
> its value for clarity while keeping the same behaviour.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
> V1 -> V2: removed unused variable 'timeout'
> 
>  drivers/mfd/wm831x-auxadc.c | 48 +++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
> index 65b98f3fbd92..77f8e51a5753 100644
> --- a/drivers/mfd/wm831x-auxadc.c
> +++ b/drivers/mfd/wm831x-auxadc.c
> @@ -152,7 +152,7 @@ static irqreturn_t wm831x_auxadc_irq(int irq, void *irq_data)
>  static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
>  				     enum wm831x_auxadc input)
>  {
> -	int ret, src, timeout;
> +	int ret, src;
> 
>  	mutex_lock(&wm831x->auxadc_lock);
> 
> @@ -179,32 +179,28 @@ static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
>  		goto disable;
>  	}
> 
> -	/* If we're not using interrupts then poll the
> -	 * interrupt status register */
> -	timeout = 5;
> -	while (timeout) {
> -		msleep(1);
> -
> -		ret = wm831x_reg_read(wm831x,
> -				      WM831X_INTERRUPT_STATUS_1);
> -		if (ret < 0) {
> -			dev_err(wm831x->dev,
> -				"ISR 1 read failed: %d\n", ret);
> -			goto disable;
> -		}
> +	/* If we're not using interrupts then read the
> +	 * interrupt status register
> +	 */

Can someone submit a commit to fix this comment.

> +	msleep(20);

New line here please.

> +	ret = wm831x_reg_read(wm831x,
> +				WM831X_INTERRUPT_STATUS_1);

Odd line-up.

> +	if (ret < 0) {
> +		dev_err(wm831x->dev,
> +			"ISR 1 read failed: %d\n", ret);
> +		goto disable;
> +	}
> 
> -		/* Did it complete? */
> -		if (ret & WM831X_AUXADC_DATA_EINT) {
> -			wm831x_reg_write(wm831x,
> -					 WM831X_INTERRUPT_STATUS_1,
> -					 WM831X_AUXADC_DATA_EINT);
> -			break;
> -		} else {
> -			dev_err(wm831x->dev,
> -				"AUXADC conversion timeout\n");
> -			ret = -EBUSY;
> -			goto disable;
> -		}
> +	/* Did it complete? */
> +	if (ret & WM831X_AUXADC_DATA_EINT) {
> +		wm831x_reg_write(wm831x,
> +					WM831X_INTERRUPT_STATUS_1,
> +					WM831X_AUXADC_DATA_EINT);

Very odd line-up.

> +	} else {
> +		dev_err(wm831x->dev,
> +			"AUXADC conversion timeout\n");
> +		ret = -EBUSY;
> +		goto disable;
>  	}
> 
>  	ret = wm831x_reg_read(wm831x, WM831X_AUXADC_DATA);
> --
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
