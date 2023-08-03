Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666676F4DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjHCVxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHCVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:53:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359072D7E;
        Thu,  3 Aug 2023 14:53:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23B0AC67;
        Thu,  3 Aug 2023 23:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691099546;
        bh=ZqDmGTJU5wYQKOmk6F4NuUrXtBi0FAI5NAPCvoFr3Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+ngpATuJZoM5K1OKuk4FjG7sQCuFQHwVmlnjGM47vS91kb6ur0lf4oSjanmhiTGV
         yeHZItElUXcbjrP6vykbKdatqn5KSqpsZ8gW3DFWtb8WX4bIsEDsY2Pe1sunlkBXMV
         Jw2zARH0Q/fezSuUvD/m2K1KcHAk1ONomy0dKrQ8=
Date:   Fri, 4 Aug 2023 00:53:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: i2c: ds90ub960: Fix PLL config for 1200
 MHz CSI rate
Message-ID: <20230803215336.GI27752@pendragon.ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v2-0-512570ecb798@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v2-3-512570ecb798@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803-ub9xx-uninit-vars-v2-3-512570ecb798@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:15:47PM +0300, Tomi Valkeinen wrote:
> smatch reports:
> 
> drivers/media/i2c/ds90ub960.c:1788 ub960_init_tx_ports() error: uninitialized symbol 'pll_div'.
> 
> This is caused by 'pll_div' not being set for 1200 MHz CSI rate. Set the
> 'pll_div' correctly.
> 
> Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

My

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

from v1, send before I noticed v2 was on the list, still applies.

> ---
>  drivers/media/i2c/ds90ub960.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index 4833b39b9178..4ab45e326d80 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -1763,6 +1763,7 @@ static int ub960_init_tx_ports(struct ub960_data *priv)
>  		break;
>  	case MHZ(1200):
>  		speed_select = 1;
> +		pll_div = 0x18;
>  		break;
>  	case MHZ(800):
>  		speed_select = 2;
> 

-- 
Regards,

Laurent Pinchart
