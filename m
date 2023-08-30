Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54778E0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbjH3Upi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbjH3UpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:45:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67044E62
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:43:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6E8D349E;
        Wed, 30 Aug 2023 22:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693428027;
        bh=9b1c7cdYA8/JOI7RsMAGYE8xBgsl/q6PNbhtx65ZuUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRlFCMxuWblERy/He11C6Kb48XFen1mHEZ5qCECg6R3U2WrzA82MerHBS9N/4hH2D
         Je3b41An+HMnoMQGO/8TET1sTi0LlCxzkKX+0K9Ii/67dYGRGKw19t7/eI0Ld2hB+V
         Qt/H/B8PtMDHjBxqohkN3byOWx1g+UECXtcd1JSo=
Date:   Wed, 30 Aug 2023 23:41:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Zhu Wang <wangzhu9@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 3/3] drm/bridge/analogix/anx78xx: Drop conditionals
 around of_node pointers
Message-ID: <20230830204159.GA1928@pendragon.ideasonboard.com>
References: <20230830170819.309269-1-biju.das.jz@bp.renesas.com>
 <20230830170819.309269-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830170819.309269-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the patch.

On Wed, Aug 30, 2023 at 06:08:19PM +0100, Biju Das wrote:
> Having conditional around the of_node pointers turns out to make driver
> code use ugly #ifdef and #if blocks. So drop the conditionals.

How about doing this for all bridge drivers in one go ?

> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * Split from patch#2
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 6169db73d2fe..ad8241758896 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -1231,9 +1231,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client)
>  
>  	mutex_init(&anx78xx->lock);
>  
> -#if IS_ENABLED(CONFIG_OF)
>  	anx78xx->bridge.of_node = client->dev.of_node;
> -#endif
>  
>  	anx78xx->client = client;
>  	i2c_set_clientdata(client, anx78xx);

-- 
Regards,

Laurent Pinchart
