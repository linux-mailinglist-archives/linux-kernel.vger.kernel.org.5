Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18C7A3FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjIRDsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIRDs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:48:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAA5F10E;
        Sun, 17 Sep 2023 20:48:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C00A080BF;
        Mon, 18 Sep 2023 03:48:20 +0000 (UTC)
Date:   Mon, 18 Sep 2023 06:48:19 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Message-ID: <20230918034819.GO5285@atomide.com>
References: <20230412073954.20601-1-tony@atomide.com>
 <9daacd2f-0dbf-dddc-9403-b802447896a2@ideasonboard.com>
 <AB436C46-413A-4469-BA07-F3ED1CECF02F@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB436C46-413A-4469-BA07-F3ED1CECF02F@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [230916 12:50]:
> Hi Tomi and Tony,
> 
> > Am 13.09.2023 um 13:59 schrieb Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>:
> > 
> > On 12/04/2023 10:39, Tony Lindgren wrote:
> >> We may not have dsi->dsidev initialized during probe, and that can
> >> lead into various dsi related warnings as omap_dsi_host_detach() gets
> >> called with dsi->dsidev set to NULL.
> >> The warnings can be "Fixed dependency cycle(s)" followed by a
> >> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
> >> Let's fix the warnings by checking for a valid dsi->dsidev.
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> >> @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
> >>  {
> >>  	struct dsi_data *dsi = host_to_omap(host);
> >>  -	if (WARN_ON(dsi->dsidev != client))
> >> +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
> >>  		return -EINVAL;
> >>    	cancel_delayed_work_sync(&dsi->dsi_disable_work);
> > 
> > Shouldn't this rather be
> > 
> > if (!dsi->dsidev)
> > 	return 0;
> > 
> > before the if (WARN_ON(dsi->dsidev != client)) line?
> 
> Yes you are right. We have a different variant in our Pyra kernel:
> 
> What we currently have in our Pyra tree is: https://git.goldelico.com/?p=letux-kernel.git;a=commitdiff;h=5bf7bd64eec1eb924e794e8d6600919f0dae8c5a;hp=27a0cd6263194d1465e9c53293d35f8c8c988f9d
> 
>         struct dsi_data *dsi = host_to_omap(host);
>  
> -       if (WARN_ON(dsi->dsidev != client))
> +printk("%s\n", __func__);
> +
> +       if (!dsi->dsidev || WARN_ON(dsi->dsidev != client))
>                 return -EINVAL;
>  
>         cancel_delayed_work_sync(&dsi->dsi_disable_work);
> 
> > 
> > If dsi->dsidev is NULL, then attach hasn't been called, and we shouldn't do anything in the detach callback either.
> > 
> > With your change we'll end up doing all the work in the detach callback, without ever doing their counterpart in the attach side.
> 
> If useful, I can post above mentioned patch (without printk).

Sounds good to me.

Thanks,

Tony
