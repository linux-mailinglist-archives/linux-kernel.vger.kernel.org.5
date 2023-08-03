Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4B76F4B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjHCVnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjHCVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:43:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19730F6;
        Thu,  3 Aug 2023 14:43:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E23EBEEA;
        Thu,  3 Aug 2023 23:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691098962;
        bh=T/IhxOaGnPMkiGa3eRd30pEigzZfH8VZU5LboxNQwsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZLGqd5v3rZwHSRcVNFg0fLhk0VhcyoY7q+/2jWjxbzAaLoNS5OeiEqHdvDi8XFcA
         +pRkN0AfGrduUwHNT3UkweG24hYlAanZts9AzbbjD6xN2/ziD2nQyYYUFUkR8VN98K
         3d834Jh171uJaMSjruOZscSUVzIUthrHbLcMRjMk=
Date:   Fri, 4 Aug 2023 00:43:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: ds90ub960: Fix PLL config for 1200 MHz
 CSI rate
Message-ID: <20230803214352.GF27752@pendragon.ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v1-2-284a5455260f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803-ub9xx-uninit-vars-v1-2-284a5455260f@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Aug 03, 2023 at 11:41:39AM +0300, Tomi Valkeinen wrote:
> smatch reports:
> 
> drivers/media/i2c/ds90ub960.c:1788 ub960_init_tx_ports() error: uninitialized symbol 'pll_div'.
> 
> This is caused by 'pll_div' not being set for 1200 MHz CSI rate. Set the
> 'pll_div' correctly.

I'm surprised gcc didn't catch it.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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
