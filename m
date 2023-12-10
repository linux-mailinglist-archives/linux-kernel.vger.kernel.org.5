Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC93880B964
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjLJGmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:42:35 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F39B8;
        Sat,  9 Dec 2023 22:42:40 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fb06f38df0so2549307fac.1;
        Sat, 09 Dec 2023 22:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702190560; x=1702795360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPnfGn6B7os71uYqHnSLyoq1lTDN3Gl3B7F72ZE0VBI=;
        b=CZNp0P1pL+17Bh+BSrMlGvy2uaX+sOuRHlBQTO1a0kr16V0rIO5dR34JRlkBtLI4bC
         /LD0/8Vbz7VTrQu+/ENVD8JulvHnE0Hw1e6DDUInEJIC23gG4aLEzG04dOLMUFc0c7sw
         Nou6Fe5m+MQ/Cp32sWwGQrWP/nNUlrTVArR3Vsmnwdf6cFR4xKzbt02OF9dnbtuIiOPm
         HFH9J8VmLaJljyO7iUONvW5HxEBng4rfIagNLtar46c81zSDH5eng7cyOcNO7Thbbap0
         lrVQ5PzqruX4iGv4mFDnKac4Bc4wBeaQDUd53InyUz6fkwzsAEq9zSpGW/NsyTvlybV4
         MRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702190560; x=1702795360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPnfGn6B7os71uYqHnSLyoq1lTDN3Gl3B7F72ZE0VBI=;
        b=iYDBJoRcXh0TL4LaCBDPayHsd80cZl+LUwt9+NQXFInMwxF+wnAZg9nyY4toXM4Zgf
         E1hpzyNLgOaSgKzra1dmytH/b6C7P15hBCi+7vMEb2WL0WmaQ5mulBEheUx5ztIHVOtv
         p80yLqSOzx7X1W6iPOhVKbZalBbIzn6Tk6w9+shWQC9jUM6Wp3RuJF9QPVGo9jFvc2RE
         IXnqIuvSHj+9/IXGOSSL9sI7/G++bslaXax/RR3sF3AkVWrO/mBwyJejEunsBmF1jIA9
         sw2BNspW9P7P1HyGnY/CAVxA6j/XnvWdZdOJ22Zhn8+Mi+MyCn2uj3nRa2DGFAo3NR5k
         bGfg==
X-Gm-Message-State: AOJu0YzO8wKIkfsaBAMkR+1q1jFKN8CSXRENnA8ZJVGHyO142lmb8GuN
        tSTNJRawtyD8/ky1toGTCT8=
X-Google-Smtp-Source: AGHT+IEZosxF2/g1jVFkisBIAmohaUhmlBXDDTYx48PjqVdcn+OdFCtXM0pG3z8FIvl4EW+TPywiOg==
X-Received: by 2002:a05:6870:d18c:b0:1fb:2bec:9fb5 with SMTP id a12-20020a056870d18c00b001fb2bec9fb5mr3632282oac.0.1702190560026;
        Sat, 09 Dec 2023 22:42:40 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9082:8aa4:377c:de99])
        by smtp.gmail.com with ESMTPSA id t14-20020a63eb0e000000b005ac384b71cbsm4116777pgh.60.2023.12.09.22.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 22:42:39 -0800 (PST)
Date:   Sat, 9 Dec 2023 22:42:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, frank.li@vivo.com,
        u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
        robh@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: omap4-keypad: react on keypresses if
 device is runtime-suspended
Message-ID: <ZXVd3RcTdHi3MifB@google.com>
References: <20231209112058.453030-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209112058.453030-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sat, Dec 09, 2023 at 12:20:58PM +0100, Andreas Kemnade wrote:
> According to SWPU235AB, table 26-6, fclk is required to generate events
> at least on OMAP4460, so keep fclk enabled all the time the device
> is opened.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since RFC:
> - add R-by:
> 
>  drivers/input/keyboard/omap4-keypad.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index d3f8688fdd9c3..7d83aff95617f 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -83,6 +84,7 @@ struct omap4_keypad {
>  	bool no_autorepeat;
>  	u64 keys;
>  	unsigned short *keymap;
> +	struct clk *fck;
>  };
>  
>  static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> @@ -211,6 +213,8 @@ static int omap4_keypad_open(struct input_dev *input)
>  
>  	disable_irq(keypad_data->irq);
>  
> +	clk_prepare_enable(keypad_data->fck);

I believe this needs error handling.

Thanks.

-- 
Dmitry
