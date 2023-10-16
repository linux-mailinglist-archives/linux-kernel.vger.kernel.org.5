Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5A7CA164
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJPIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:14:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14197B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:14:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E38957E;
        Mon, 16 Oct 2023 10:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697444072;
        bh=X0qPY/ZLr+T1pIWB06XY/oU04miPkYzv4QR6qe8hHmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEPhb+qfjRVqR7D1DjR/E4Qs9EwjfcHt8zBmMXEBgHmGiLl1wKX0oqAr3SYY4QtqV
         qPTLmd/7cqLDNPiSZG5NARIWT+TbU4s+6EyMzvh4mOJFRByYRQsDZG9L5ctpTQRtkM
         GBcs5herAk57EUmN/IcNYyspYVC5+maSi2mZhSsE=
Date:   Mon, 16 Oct 2023 11:14:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH] drm/bridge: adv7511: fix crash on irq during probe
Message-ID: <20231016081444.GD23177@pendragon.ideasonboard.com>
References: <20231014-adv7511-cec-irq-crash-fix-v1-1-3389486c8373@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231014-adv7511-cec-irq-crash-fix-v1-1-3389486c8373@bang-olufsen.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alvin,

On Sat, Oct 14, 2023 at 08:46:12PM +0200, Alvin Šipraga wrote:
> From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
> 
> Moved IRQ registration down to end of adv7511_probe().
> 
> If an IRQ already is pending during adv7511_probe
> (before adv7511_cec_init) then cec_received_msg_ts
> could crash using uninitialized data:
> 
>     Unable to handle kernel read from unreadable memory at virtual address 00000000000003d5
>     Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
>     Call trace:
>      cec_received_msg_ts+0x48/0x990 [cec]
>      adv7511_cec_irq_process+0x1cc/0x308 [adv7511]
>      adv7511_irq_process+0xd8/0x120 [adv7511]
>      adv7511_irq_handler+0x1c/0x30 [adv7511]
>      irq_thread_fn+0x30/0xa0
>      irq_thread+0x14c/0x238
>      kthread+0x190/0x1a8
> 
> Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")

Isn't the issue older than that ?

> Signed-off-by: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

With the Fixes: tag updated,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index d518de88b5c3..71022cb8abe4 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1291,17 +1291,6 @@ static int adv7511_probe(struct i2c_client *i2c)
>  
>  	INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
>  
> -	if (i2c->irq) {
> -		init_waitqueue_head(&adv7511->wq);
> -
> -		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> -						adv7511_irq_handler,
> -						IRQF_ONESHOT, dev_name(dev),
> -						adv7511);
> -		if (ret)
> -			goto err_unregister_cec;
> -	}
> -
>  	adv7511_power_off(adv7511);
>  
>  	i2c_set_clientdata(i2c, adv7511);
> @@ -1325,6 +1314,17 @@ static int adv7511_probe(struct i2c_client *i2c)
>  
>  	adv7511_audio_init(dev, adv7511);
>  
> +	if (i2c->irq) {
> +		init_waitqueue_head(&adv7511->wq);
> +
> +		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> +						adv7511_irq_handler,
> +						IRQF_ONESHOT, dev_name(dev),
> +						adv7511);
> +		if (ret)
> +			goto err_unregister_audio;
> +	}
> +
>  	if (adv7511->type == ADV7533 || adv7511->type == ADV7535) {
>  		ret = adv7533_attach_dsi(adv7511);
>  		if (ret)
> 

-- 
Regards,

Laurent Pinchart
