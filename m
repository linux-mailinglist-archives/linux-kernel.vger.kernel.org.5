Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA4811046
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378829AbjLMLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjLMLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:36:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076310D;
        Wed, 13 Dec 2023 03:36:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD41C4A9;
        Wed, 13 Dec 2023 12:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702467353;
        bh=9SNuEfZLlJT5AlsFvY/gtkXYHwYDbd5a9YwB+YSaGK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuCFT1Qn6ZcuX8C+fg9wEvsrlUcfxqKRi1w/w7U9dekr+A7lF7FLZeoS9BruSD5n7
         D61gHByMqeLufQirxT+zx9UCeCJQBFxplnqUjpVYfqIGIGZduH4yaEAySfHKmBQfTj
         N/4k9OeHCrO8Sx5Bt6cCK1Dpr5IBr4uC2juouIUw=
Date:   Wed, 13 Dec 2023 13:36:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] media: i2c: mt9m114: use fsleep() in place of
 udelay()
Message-ID: <20231213113645.GA769@pendragon.ideasonboard.com>
References: <20231213112322.1655236-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213112322.1655236-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Wed, Dec 13, 2023 at 12:23:07PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With clang-16, building without COMMON_CLK triggers a range check on
> udelay() because of a constant division-by-zero calculation:
> 
> ld.lld: error: undefined symbol: __bad_udelay
> >>> referenced by mt9m114.c
> >>>               drivers/media/i2c/mt9m114.o:(mt9m114_power_on) in archive vmlinux.a
> 
> In this configuration, the driver already fails to probe, before
> this function gets called, so it's enough to suppress the assertion.
> 
> Do this by using fsleep(), which turns long delays into sleep() calls
> in place of the link failure.
> 
> This is probably a good idea regardless to avoid overly long dynamic
> udelay() calls on a slow clock.

The longest delay would be 16.66µs, which may not be worth a sleep, but
I think that's fine. Using fsleep() by default is a good idea.

> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Fixes: 24d756e914fc ("media: i2c: Add driver for onsemi MT9M114 camera sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/media/i2c/mt9m114.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
> index 0a22f328981d..68adaecaf481 100644
> --- a/drivers/media/i2c/mt9m114.c
> +++ b/drivers/media/i2c/mt9m114.c
> @@ -2116,7 +2116,7 @@ static int mt9m114_power_on(struct mt9m114 *sensor)
>  		duration = DIV_ROUND_UP(2 * 50 * 1000000, freq);
>  
>  		gpiod_set_value(sensor->reset, 1);
> -		udelay(duration);
> +		fsleep(duration);
>  		gpiod_set_value(sensor->reset, 0);
>  	} else {
>  		/*

-- 
Regards,

Laurent Pinchart
