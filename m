Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D142179E765
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjIML77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjIML76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:59:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA219A8;
        Wed, 13 Sep 2023 04:59:54 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5E7316C4;
        Wed, 13 Sep 2023 13:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694606300;
        bh=ayRV34rsRfdF8woE+GQhfjAi3GQIYlaUEPoIV8k2xps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UzGe5cj2D9Tns1M8L6m3ueyaS3BOi0cZ6U8xa77eVjNqMDeB2lpW5SjpYkc7PUj1O
         xotPgAXmXDHIbb1fbJ+pSFqnpf6qFXGh5Ir0Rw0iGrMXuTd/M3+vO7WFTyNFb/yqsB
         pNOzj4czWbm/JROAS7pIQt3sO+ZCfzZ35sFTdhKs=
Message-ID: <9daacd2f-0dbf-dddc-9403-b802447896a2@ideasonboard.com>
Date:   Wed, 13 Sep 2023 14:59:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
References: <20230412073954.20601-1-tony@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230412073954.20601-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 10:39, Tony Lindgren wrote:
> We may not have dsi->dsidev initialized during probe, and that can
> lead into various dsi related warnings as omap_dsi_host_detach() gets
> called with dsi->dsidev set to NULL.
> 
> The warnings can be "Fixed dependency cycle(s)" followed by a
> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
> 
> Let's fix the warnings by checking for a valid dsi->dsidev.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
>   {
>   	struct dsi_data *dsi = host_to_omap(host);
>   
> -	if (WARN_ON(dsi->dsidev != client))
> +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
>   		return -EINVAL;
>   
>   	cancel_delayed_work_sync(&dsi->dsi_disable_work);

Shouldn't this rather be

if (!dsi->dsidev)
	return 0;

before the if (WARN_ON(dsi->dsidev != client)) line?

If dsi->dsidev is NULL, then attach hasn't been called, and we shouldn't 
do anything in the detach callback either.

With your change we'll end up doing all the work in the detach callback, 
without ever doing their counterpart in the attach side.

  Tomi

