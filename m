Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC48110C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377388AbjLMMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjLMMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:08:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFFCD;
        Wed, 13 Dec 2023 04:09:03 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BC6666F;
        Wed, 13 Dec 2023 13:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702469296;
        bh=jqhRjEL97tn66XG6waeuYNlSKAzpHyL1g4+7ALb8P6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hwp6d+EjAYB0geF68t4m6zgcSbUiP+a93h4cqFqIC3Vzcbm2w9XuqWaArOoceoFlp
         ISYe3zCw05UnSJi4G81SOMUr8xC/qfJqhBMNag4gvwnMMiO5gQbVLGBxIIIGSs537k
         HKFJpw8ki6RmYvuiLZW89YKvP8LMgmmqd1+lIOVc=
Date:   Wed, 13 Dec 2023 14:09:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] media: i2c: mt9m114: use fsleep() in place of
 udelay()
Message-ID: <20231213120909.GC769@pendragon.ideasonboard.com>
References: <20231213112322.1655236-1-arnd@kernel.org>
 <5c5647d5-b389-4d71-9062-3a9921212079@ideasonboard.com>
 <20231213114812.GB769@pendragon.ideasonboard.com>
 <0722393c-8107-4a8f-b3ab-1bbb347a6f1b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0722393c-8107-4a8f-b3ab-1bbb347a6f1b@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:56:48PM +0200, Tomi Valkeinen wrote:
> On 13/12/2023 13:48, Laurent Pinchart wrote:
> > On Wed, Dec 13, 2023 at 01:40:54PM +0200, Tomi Valkeinen wrote:
> >> On 13/12/2023 13:23, Arnd Bergmann wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> With clang-16, building without COMMON_CLK triggers a range check on
> >>> udelay() because of a constant division-by-zero calculation:
> >>>
> >>> ld.lld: error: undefined symbol: __bad_udelay
> >>>>>> referenced by mt9m114.c
> >>>>>>                 drivers/media/i2c/mt9m114.o:(mt9m114_power_on) in archive vmlinux.a
> >>>
> >>> In this configuration, the driver already fails to probe, before
> >>> this function gets called, so it's enough to suppress the assertion.
> >>>
> >>> Do this by using fsleep(), which turns long delays into sleep() calls
> >>> in place of the link failure.
> >>>
> >>> This is probably a good idea regardless to avoid overly long dynamic
> >>> udelay() calls on a slow clock.
> >>>
> >>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> >>> Fixes: 24d756e914fc ("media: i2c: Add driver for onsemi MT9M114 camera sensor")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> ---
> >>>    drivers/media/i2c/mt9m114.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
> >>> index 0a22f328981d..68adaecaf481 100644
> >>> --- a/drivers/media/i2c/mt9m114.c
> >>> +++ b/drivers/media/i2c/mt9m114.c
> >>> @@ -2116,7 +2116,7 @@ static int mt9m114_power_on(struct mt9m114 *sensor)
> >>>    		duration = DIV_ROUND_UP(2 * 50 * 1000000, freq);
> >>>    
> >>>    		gpiod_set_value(sensor->reset, 1);
> >>> -		udelay(duration);
> >>> +		fsleep(duration);
> >>>    		gpiod_set_value(sensor->reset, 0);
> >>>    	} else {
> >>>    		/*
> >>
> >> I think this is fine, so:
> >>
> >> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >>
> >> But: If we don't have COMMON_CLK (or rather, I think, HAVE_CLK), the
> >> freq will be zero at compile time. So won't the compiler give a warning
> >> for the DIV_ROUND_UP() call?
> >>
> >> Interestingly, for me, this doesn't give a div-by-zero warning:
> >>
> >> 	int x;
> >> 	int y = 0;
> >> 	x = DIV_ROUND_UP(10, y);
> >>
> >> but this does:
> >>
> >> 	int x;
> >> 	const int y = 0;
> >> 	x = DIV_ROUND_UP(10, y);
> >>
> >> And looks like this gives the warning too:
> >>
> >> 	int x;
> >> 	const int y = 0;
> >> 	if (y)
> >> 		x = DIV_ROUND_UP(10, y);
> >>
> >> So, I think, the code in the driver could fail to compile at some later
> >> point, if the compiler warnings are improved (?), or if someone adds a
> >> 'const' in front of 'long freq = clk_get_rate(sensor->clk);' line.
> >>
> >> Maybe worry about that if it actually happens =).
> > 
> > Maybe :-) I would be tempted to make VIDEO_CAMERA_SENSOR depend on
> > COMMON_CLK.
> 
> I think HAVE_CLK would be more correct.

Indeed. Only arch/m68k (for Coldfire), arch/mips (for BCM63xx and
Lantiq) and arch/sh (for pre-DT platforms) still make use of
HAVE_LEGACY_CLK. It takes a long time to address the last users of a
legacy API, but it seems we could get there one day.

-- 
Regards,

Laurent Pinchart
