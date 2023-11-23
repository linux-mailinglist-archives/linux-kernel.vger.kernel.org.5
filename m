Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFACD7F6540
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjKWRWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD68D62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0EC433D9;
        Thu, 23 Nov 2023 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760159;
        bh=2D3aUhEExlMCoGyBeeeacQjJUG+XraZinasPd6JBJW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEnd+Al+R2lAela/niSU367F4vosKZr3w25UtMD2C+vBQ7mtTDqd6shdG3Th7MK1w
         sEV0HrmSPBJkl17Gsn1VN95x1gItdZsCpWWxFTF5KUTYtDZfENPNPemsasuvv+Wi9R
         6sV80XlhTRfQajBK+lGsKWT3F2ieHOEIOO76zu5Q=
Date:   Thu, 23 Nov 2023 13:55:57 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] usb: misc: onboard_usb_hub: Add support for clock
 input
Message-ID: <2023112329-augmented-ecology-0753@gregkh>
References: <20231123134728.709533-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123134728.709533-1-frieder@fris.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:47:20PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Most onboard USB hubs have a dedicated crystal oscillator but on some
> boards the clock signal for the hub is provided by the SoC.
> 
> In order to support this, we add the possibility of specifying a
> clock in the devicetree that gets enabled/disabled when the hub
> is powered up/down.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index a341b2fbb7b44..e710e3c82ba9b 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2022, Google LLC
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/gpio/consumer.h>
> @@ -60,12 +61,19 @@ struct onboard_hub {
>  	bool going_away;
>  	struct list_head udev_list;
>  	struct mutex lock;
> +	struct clk *clk;
>  };
>  
>  static int onboard_hub_power_on(struct onboard_hub *hub)
>  {
>  	int err;
>  
> +	err = clk_prepare_enable(hub->clk);
> +	if (err) {
> +		dev_err(hub->dev, "failed to enable clock: %d\n", err);
> +		return err;
> +	}

But what happens if clk is not set here?

And doesn't clk_prepare_enable() print out a message if it fails?

thanks,

greg k-h
